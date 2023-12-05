#include <iostream>
#include <vector>

#include "CppTempl/CppTempl.hpp"
#include "spdlog/sinks/stdout_color_sinks.h"
#include "spdlog/spdlog.h"

void setupLogging(std::vector<spdlog::sink_ptr> &sinks)
{
  try
  {
    auto console_sink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
    console_sink->set_level(spdlog::level::debug);
    sinks.push_back(console_sink);

    auto logger = std::make_shared<spdlog::logger>("CppTempl", std::begin(sinks), std::end(sinks));
    logger->set_level(spdlog::level::debug);
    spdlog::register_logger(logger);
  }
  catch (const spdlog::spdlog_ex &ex)
  {
    std::cout << "Log initialization failed: " << ex.what() << std::endl;
  }
}

int main()
{
  try
  {
    std::vector<spdlog::sink_ptr> sinks;
    setupLogging(sinks);

    CppTempl::CppTempl templ(spdlog::get("CppTempl"));
    std::cout << templ.echo("My message") << std::endl;
  }
  catch (const std::exception &exc)
  {
    std::cerr << exc.what() << std::endl;
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}
