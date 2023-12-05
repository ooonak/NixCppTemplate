#include "CppTemplImpl.hpp"

CppTempl::CppTemplImpl::CppTemplImpl(const std::shared_ptr<spdlog::logger> &logger) : logger_{logger}
{
  logger_->info(__func__);
}

CppTempl::CppTemplImpl::~CppTemplImpl() { logger_->info(__func__); }

std::string CppTempl::CppTemplImpl::echo(std::string msg) const { return msg; }
