const express = require("express");
const os = require("os");

const app = express();
app.use(express.json());
app.use(express.static("public"));

const PORT = 3000;

// Health check
app.get("/health", (req, res) => {
  res.status(200).json({ status: "OK" });
});

// Log generation endpoint
app.post("/generate-log", (req, res) => {
  const log = {
    level: "info",
    message: "User triggered log generation",
    timestamp: new Date().toISOString(),
    hostname: os.hostname(),
    pod: process.env.HOSTNAME || "unknown",
    service: "demo-nodejs-app"
  };

  console.log(JSON.stringify(log));

  res.json({ status: "Log generated successfully" });
});

// Server start
app.listen(PORT, () => {
  console.log(JSON.stringify({
    level: "info",
    message: "Demo Node.js application started",
    port: PORT,
    timestamp: new Date().toISOString()
  }));
});
