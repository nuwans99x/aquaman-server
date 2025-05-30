using aquaman_server.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace aquaman_server.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        // This is a placeholder. Replace with actual DB context and logic.
        private static List<User> Users = new List<User>();

        [HttpPost("register")]
        public IActionResult Register([FromBody] RegisterRequest request)
        {
            if (Users.Any(u => u.Username == request.Username || u.Email == request.Email))
                return BadRequest("Username or Email already exists");
            var user = new User
            {
                Username = request.Username,
                PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password),
                Email = request.Email,
                Role = "user"
            };
            Users.Add(user);
            return Ok();
        }

        [HttpPost("login")]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            var user = Users.FirstOrDefault(u => u.Username == request.Username);
            if (user == null || !BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash))
                return Unauthorized();
            if (!user.IsActive)
                return Forbid();
            // Return a mock token for now
            return Ok(new { token = "mock-jwt-token", role = user.Role });
        }

        [HttpGet]
        public IActionResult GetAll()
        {
            return Ok(Users);
        }

        [HttpPost("invalidate/{id}")]
        public IActionResult InvalidateUser(int id)
        {
            var user = Users.FirstOrDefault(u => u.Id == id);
            if (user == null) return NotFound();
            user.IsActive = false;
            return Ok();
        }
    }
}
