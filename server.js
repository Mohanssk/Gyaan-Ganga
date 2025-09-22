import express from "express";
import pg from "pg";
import path from "path";
import bcrypt from "bcrypt";
import { fileURLToPath } from 'url';

// ES Module workaround for __dirname
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const port = 3000;
const saltRounds = 10;

// Database Client Setup
const db = new pg.Client({
  user: "postgres",
  host: "localhost",
  database: "GyanGanga",
  password: "12345",
  port: 5432,
});

db.connect((err) => {
  if (err) {
    console.error("🔴 FATAL: Database connection error. Server has not started.", err.stack);
    return;
  }
  
  console.log("🟢 Successfully connected to the database.");

  app.use(express.urlencoded({ extended: true }));
  app.use(express.static(path.join(__dirname, "public")));

  // --- Helper Functions for Database Logic ---

  async function handleSignup(fullName, username, email, password, role) {
    try {
      const hashedPassword = await bcrypt.hash(password, saltRounds);
      const result = await db.query(
        "INSERT INTO users (full_name, username, email, password_hash, role) VALUES ($1, $2, $3, $4, $5) RETURNING *",
        [fullName, username, email, hashedPassword, role]
      );
      console.log("✅ New user created:", result.rows[0]);
      return { success: true };
    } catch (err) {
      console.error("❌ Error during signup:", err.message);
      return { success: false, error: err };
    }
  }

  async function handleLogin(username, password) {
    try {
      // 1. Find the user in the database by their username
      const result = await db.query("SELECT * FROM users WHERE username = $1", [username]);

      if (result.rows.length === 0) {
        console.log("Login failed: User not found.");
        return { success: false }; // User does not exist
      }

      const user = result.rows[0];
      const storedHashedPassword = user.password_hash;

      // 2. Compare the password from the form with the stored hash
      const passwordMatch = await bcrypt.compare(password, storedHashedPassword);

      if (passwordMatch) {
        console.log("✅ Login successful for user:", user.username);
        return { success: true, user: user }; // Passwords match
      } else {
        console.log("Login failed: Incorrect password.");
        return { success: false }; // Passwords do not match
      }
    } catch (err) {
      console.error("❌ Error during login:", err);
      return { success: false, error: err };
    }
  }

  // --- Routes ---
  app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'login.html'));
  });

  app.get('/signup', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'register.html'));
  });

  app.post('/signup', async (req, res) => {
    const { fullName, username, email, password, role } = req.body;
    const result = await handleSignup(fullName, username, email, password, role);
    if (result.success) {
      res.send('<h1>Signup Successful!</h1><p>You can now log in.</p><a href="/login">Go to Login</a>');
    } else {
      res.status(500).send("<h1>Error</h1><p>An error occurred. The username or email may be taken.</p><a href='/signup'>Try again</a>");
    }
  });

  app.post('/login', async (req, res) => {
    const { username, password } = req.body; // We only need username and password to authenticate
    const result = await handleLogin(username, password);

    if (result.success) {
      // In a real application, you would create a user session here.
      // For now, we'll just redirect to the homepage.
      res.redirect('/');
    } else {
      res.send("<h1>Login Failed</h1><p>Invalid username or password.</p><a href='/login'>Try again</a>");
    }
  });

  // --- Start Server ---
  app.listen(port, () => {
    console.log(`🟢 Server running on http://localhost:${port}`);
  });
});