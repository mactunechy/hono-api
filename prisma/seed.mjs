import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  for (let i = 1; i <= 5; i++) {
    await prisma.post.create({
      data: {
        title: `Post ${i}`,
        content: `This is post number ${i}`,
        published: true,
      },
    });
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
