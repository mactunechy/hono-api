import { serve } from "@hono/node-server";
import { Hono } from "hono";
import prismadb from "./lib/prismadb";

const app = new Hono();

app.get("/posts", async (c) => {
  const posts = await prismadb.post.findMany();
  return c.json({ data: posts });
});

const port = 3000;
console.log(`Server is running on port ${port}`);

serve({
  fetch: app.fetch,
  port,
});
