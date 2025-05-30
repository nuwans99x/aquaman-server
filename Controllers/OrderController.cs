using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace AquamanServer.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class OrderController : ControllerBase
    {
        private static List<Order> Orders = new List<Order>();

        [HttpGet]
        public IActionResult GetOrders()
        {
            return Ok(Orders);
        }

        [HttpPost]
        public IActionResult PlaceOrder([FromBody] Order order)
        {
            order.Id = Orders.Count + 1;
            order.Status = "Pending";
            Orders.Add(order);
            return CreatedAtAction(nameof(GetOrders), new { id = order.Id }, order);
        }

        [HttpPut("{id}/status")]
        public IActionResult UpdateOrderStatus(int id, [FromBody] string status)
        {
            var order = Orders.Find(o => o.Id == id);
            if (order == null)
            {
                return NotFound();
            }

            order.Status = status;
            return NoContent();
        }
    }

    public class Order
    {
        public int Id { get; set; }
        public string CustomerName { get; set; }
        public string Address { get; set; }
        public List<OrderItem> Items { get; set; }
        public string Status { get; set; }
    }

    public class OrderItem
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; }
    }
}