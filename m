Return-Path: <linux-wireless+bounces-28437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B82C23DA1
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 09:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C21A65C9B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974AD2E9EA1;
	Fri, 31 Oct 2025 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIC5tgHU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A12E6105
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899939; cv=none; b=MCvtWNIoeinNWztWOhi1LoO0e+v1q0xLHl6R293yJ8IKer2aI0IWtxAJhqo+Ru2EZOwOlBa94MFMdZe73LSaIfqk30ZWHZx3QwxtpVrB4UvVIIyXMmo1vdenY32xO0pO4c+7agju5Gp0lysiEITzdt040wJ0skMsSfl8V77T4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899939; c=relaxed/simple;
	bh=RYlHXGCow5GbXvVp8yzT7CehQtqv5kgYcnY4OwXJbpg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bkBlh6L3mMV4Qc7DSIhy1xqRtOB+9I8Q7SMWbFQMIOH4WE2sGEIjUOnb1Y2gv1X9Hb6F+HdcJowPE0xiZHV0vyeW9e7nobBbtP1WuDmxxoELct/28S1/UDabIjLqCh8Ng6WO/1zQTVZAkdOyp+2Bg5M/Tew97C5fTLMs17pjZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIC5tgHU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761899938; x=1793435938;
  h=date:from:to:cc:subject:message-id;
  bh=RYlHXGCow5GbXvVp8yzT7CehQtqv5kgYcnY4OwXJbpg=;
  b=SIC5tgHUcF1FtpRl1tFBZRtOKivknbnyN+GGz2kpV1mIVbiuSpxRKkr/
   CDbRlQTv6Hfw0dWn1Dnl7d9n4wUKrV6RM3Xvy62nr3K2NtsE3zyUDgYD6
   KrRQdROePjH9arKPoYkKuD5jkYXQ2pAgw2ZfTM2boswh/JVq9pAnhkNbi
   kOOwQpKY1zHEakOSu0WuBjIxSv03AIYfJSYIotiGbGSxjqg3uYdZEVt8w
   Wv54DsQpNpjYOrRxkDj4yB2pvW1sBotYKz52pTr2TXP8j9wZe4Iw/gQke
   9+AQqsxPEyACZpxQyyKUxO8Sm2EjzyADO6aGg8LYXKbK03TTekzCo6sc6
   Q==;
X-CSE-ConnectionGUID: ASPIAQUsTAi8FR8kFJVvuA==
X-CSE-MsgGUID: TaLyrR2nQweDm6oYXqAE0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="64086667"
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="64086667"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 01:38:57 -0700
X-CSE-ConnectionGUID: o/b34yzJRX6iM5joRSWEGw==
X-CSE-MsgGUID: gUJOLpvhTD6I9AcS5e/i2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,268,1754982000"; 
   d="scan'208";a="186058238"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 31 Oct 2025 01:38:56 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vEkeB-000MuU-1Y;
	Fri, 31 Oct 2025 08:38:21 +0000
Date: Fri, 31 Oct 2025 16:36:23 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 70e8335485966d7d4ed85976dceab52803b151a2
Message-ID: <202510311617.uvg2wPwB-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 70e8335485966d7d4ed85976dceab52803b151a2  wifi: zd1211rw: fix potential memory leak in __zd_usb_enable_rx()

elapsed time: 1455m

configs tested: 130
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                          axs101_defconfig    gcc-15.1.0
arc                   randconfig-001-20251030    gcc-11.5.0
arc                   randconfig-002-20251030    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                       aspeed_g4_defconfig    clang-22
arm                       imx_v4_v5_defconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20251030    gcc-10.5.0
arm                   randconfig-002-20251030    clang-19
arm                   randconfig-003-20251030    clang-22
arm                   randconfig-004-20251030    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251031    gcc-8.5.0
arm64                 randconfig-002-20251031    clang-22
arm64                 randconfig-003-20251031    gcc-10.5.0
arm64                 randconfig-004-20251031    gcc-14.3.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251031    gcc-9.5.0
csky                  randconfig-002-20251031    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251030    clang-22
hexagon               randconfig-002-20251030    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251031    gcc-14
i386        buildonly-randconfig-002-20251031    gcc-14
i386        buildonly-randconfig-003-20251031    clang-20
i386        buildonly-randconfig-004-20251031    gcc-14
i386        buildonly-randconfig-005-20251031    clang-20
i386        buildonly-randconfig-006-20251031    gcc-14
i386                  randconfig-001-20251031    gcc-14
i386                  randconfig-002-20251031    gcc-14
i386                  randconfig-003-20251031    gcc-14
i386                  randconfig-004-20251031    gcc-14
i386                  randconfig-005-20251031    gcc-14
i386                  randconfig-006-20251031    gcc-12
i386                  randconfig-007-20251031    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251030    clang-22
loongarch             randconfig-002-20251030    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5208evb_defconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm47xx_defconfig    clang-18
mips                          eyeq5_defconfig    gcc-15.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    gcc-11.5.0
nios2                 randconfig-001-20251030    gcc-8.5.0
nios2                 randconfig-002-20251030    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.1.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                  or1klitex_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                randconfig-001-20251030    gcc-8.5.0
parisc                randconfig-002-20251030    gcc-8.5.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20251030    clang-22
powerpc               randconfig-002-20251030    clang-22
powerpc64             randconfig-001-20251030    gcc-8.5.0
powerpc64             randconfig-002-20251030    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251030    gcc-13.4.0
riscv                 randconfig-002-20251030    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20251030    clang-17
s390                  randconfig-002-20251030    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251030    gcc-15.1.0
sh                    randconfig-002-20251030    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    gcc-15.1.0
sparc                 randconfig-001-20251031    gcc-8.5.0
sparc                 randconfig-002-20251031    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251031    gcc-8.5.0
sparc64               randconfig-002-20251031    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251031    gcc-14
um                    randconfig-002-20251031    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251031    clang-20
x86_64      buildonly-randconfig-002-20251031    gcc-14
x86_64      buildonly-randconfig-003-20251031    clang-20
x86_64      buildonly-randconfig-004-20251031    gcc-14
x86_64      buildonly-randconfig-005-20251031    gcc-14
x86_64      buildonly-randconfig-006-20251031    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251031    gcc-14
x86_64                randconfig-012-20251031    clang-20
x86_64                randconfig-013-20251031    gcc-14
x86_64                randconfig-014-20251031    gcc-14
x86_64                randconfig-015-20251031    gcc-14
x86_64                randconfig-016-20251031    clang-20
x86_64                randconfig-071-20251031    gcc-14
x86_64                randconfig-072-20251031    clang-20
x86_64                randconfig-073-20251031    gcc-14
x86_64                randconfig-074-20251031    clang-20
x86_64                randconfig-075-20251031    gcc-14
x86_64                randconfig-076-20251031    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251031    gcc-13.4.0
xtensa                randconfig-002-20251031    gcc-8.5.0
xtensa                         virt_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

