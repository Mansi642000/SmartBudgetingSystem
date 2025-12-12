## Security updates and recommended actions

1. Removed hard-coded database credentials from `util/DBConnection.java`.
   - The connection now reads `DB_URL`, `DB_USER`, and `DB_PASS` from environment variables.
   - Fallback defaults exist for local development, but we recommend always setting these env vars in production.

2. `.env.example` was added to show recommended env variables and values. Do NOT commit an actual `.env` file.

3. Updated `start_tomcat.bat` and `.vscode/tasks.json` to avoid hard-coded `CATALINA_HOME` paths:
   - Tasks and scripts now depend on `CATALINA_HOME` being set in the environment instead of a hard-coded path.

4. Added `.gitignore` to prevent committing `target/`, `.vscode/`, `mvn-build-output.txt`, and `.env` files.

5. Recommendations:
   - Rotate your MySQL password immediately if it was ever committed or shown publicly.
   - Do not commit any `.env` files or any credentials.
   - Consider using a secret manager or vault for production secrets instead of environment variables.
   - Review your GitHub/Git repo for accidental commit of secrets and remove them if found.

6. What changed by the assistant (local workspace only):
   - Edited `DBConnection.java` to read env vars for database connection.
   - Added `.env.example` and `.gitignore`.
   - Updated `.vscode/tasks.json` and `start_tomcat.bat` to avoid local hard-coded paths.
   - Created `SECURITY.md` with these instructions.

If you want, I can: 
- Replace any other occurrences of hard-coded values in files (search & replace), and
- Add a script to quickly rotate credentials and re-deploy, and 
- Show how to configure environment variables on Windows (or Docker) for secure deployment.
