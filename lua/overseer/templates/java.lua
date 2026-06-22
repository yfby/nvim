-- Overseer templates for Java build tools (Maven & Gradle)
-- Auto-detects which build tool the project uses.

return {
  -- Maven tasks
  {
    name = "mvn compile",
    builder = function()
      return {
        cmd = { "mvn", "compile" },
        name = "Maven Compile",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.filereadable(vim.fn.getcwd() .. "/pom.xml") == 1
      end,
    },
  },
  {
    name = "mvn test",
    builder = function()
      return {
        cmd = { "mvn", "test" },
        name = "Maven Test",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.filereadable(vim.fn.getcwd() .. "/pom.xml") == 1
      end,
    },
  },
  {
    name = "mvn package",
    builder = function()
      return {
        cmd = { "mvn", "package", "-DskipTests" },
        name = "Maven Package",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.filereadable(vim.fn.getcwd() .. "/pom.xml") == 1
      end,
    },
  },
  {
    name = "mvn clean install",
    builder = function()
      return {
        cmd = { "mvn", "clean", "install" },
        name = "Maven Clean Install",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.filereadable(vim.fn.getcwd() .. "/pom.xml") == 1
      end,
    },
  },
  {
    name = "mvn spring-boot:run",
    builder = function()
      return {
        cmd = { "mvn", "spring-boot:run" },
        name = "Spring Boot Run",
        cwd = vim.fn.getcwd(),
        components = { "default" },
      }
    end,
    condition = {
      callback = function()
        local pom = vim.fn.getcwd() .. "/pom.xml"
        if vim.fn.filereadable(pom) == 1 then
          local content = vim.fn.readfile(pom)
          return table.concat(content):find("spring%-boot%-maven%-plugin") ~= nil
        end
        return false
      end,
    },
  },

  -- Gradle tasks
  {
    name = "gradle build",
    builder = function()
      return {
        cmd = { "./gradlew", "build" },
        name = "Gradle Build",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.filereadable(vim.fn.getcwd() .. "/gradlew") == 1
      end,
    },
  },
  {
    name = "gradle test",
    builder = function()
      return {
        cmd = { "./gradlew", "test" },
        name = "Gradle Test",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.filereadable(vim.fn.getcwd() .. "/gradlew") == 1
      end,
    },
  },
  {
    name = "gradle run",
    builder = function()
      return {
        cmd = { "./gradlew", "run" },
        name = "Gradle Run",
        cwd = vim.fn.getcwd(),
        components = { "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.filereadable(vim.fn.getcwd() .. "/gradlew") == 1
      end,
    },
  },
  {
    name = "gradle clean build",
    builder = function()
      return {
        cmd = { "./gradlew", "clean", "build" },
        name = "Gradle Clean Build",
        cwd = vim.fn.getcwd(),
        components = { { "on_output_quickfix", open = true }, "default" },
      }
    end,
    condition = {
      callback = function()
        return vim.fn.filereadable(vim.fn.getcwd() .. "/gradlew") == 1
      end,
    },
  },
}
