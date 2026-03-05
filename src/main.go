package main

import (
	"log"

	"github.com/gofiber/fiber/v2"
)

func handle(c *fiber.Ctx) error {
	return c.SendStatus(200)
}

func main() {
	app := fiber.New()
	log.Println("Starting server on :8000...")
	app.Get("/", handle)
	log.Fatal(app.Listen(":8000"))
}
