#pragma once

#include <string>

#include "spdlog/spdlog.h"

namespace CppTempl
{

class CppTemplImpl;

class CppTempl
{
 public:
  explicit CppTempl(const std::shared_ptr<spdlog::logger> &logger);

  ~CppTempl();

  std::string echo(std::string msg) const;

 private:
  std::unique_ptr<CppTemplImpl> impl_;
};

}  // namespace CppTempl
