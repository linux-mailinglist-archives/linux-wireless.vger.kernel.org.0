Return-Path: <linux-wireless+bounces-28994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6BCC6061E
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554183BA719
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Nov 2025 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC42F6918;
	Sat, 15 Nov 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+BcneSe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD62F6168
	for <linux-wireless@vger.kernel.org>; Sat, 15 Nov 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763214312; cv=none; b=soHUDEwTd23LaurpKWrQLzFcHWfUzlM6ejhKRhdyxNwvTpDYql+rvJKHLqdinJjVMEJWM3TxBqeMQY7Zia4aDTBr9mf7Y42MgQ/MHjnR+ZNEC4WqmTfBs0n404RiJwRxt07pG4Y323qDbisDTiEjc2NCzoYOTHKSwQQ9b8FeF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763214312; c=relaxed/simple;
	bh=m38vNL6BbnLlPGF3FS75iQPf1tbHu3OJlWn7rtMc3do=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pWgeHk+A1/yWZ2Ke2XIOQM2Fw3G1Xqa9OKzv3M7KazkUHCARrJlZchsWkynX2nenv4e0Nbc5erSBLDktI0u+Z9k7vvN37fLVI8clnQMcWXlrk5rVnhgH+xyDzKtGQMyT7OL3cFxK1aglxjQgqHufpkTkguik+8IN87lqPg9Mg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+BcneSe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763214311; x=1794750311;
  h=date:from:to:cc:subject:message-id;
  bh=m38vNL6BbnLlPGF3FS75iQPf1tbHu3OJlWn7rtMc3do=;
  b=D+BcneSevICGYKEosnSaiFPcSF+LN2J6+ulqdj6aVOGUB39LAUyvX4Zq
   IKXlYreNq/fAyal0Rl7ven7q0GRYNFzhw+Bmms8v3QMfvKQd8carD8RqR
   l8Q+xc2LQD/ctRlf0bCLTnJvC064zBXLxZC58r9DwDkvj6aBOAgiJVMFH
   NVDXbERP67XGozIhjzZssds+SSTWl5BcPpTOnVasZyNMKc/IFzJwEaRvC
   2om3ewHXEuSmzuMgjPYLqMUWdRuAmyP+XUsKL5iSwZZkItbaYzLU2egE2
   C9xPIH5+9QDM8Fjr5lqPPmXxZF2UFp4KoIrDTaKWix2HnnqWYu5HXykMQ
   g==;
X-CSE-ConnectionGUID: 1Xtp+aaRQEKIJYYOKg60uw==
X-CSE-MsgGUID: Jkv7nu/hQJe58kYg4oPSvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="87933353"
X-IronPort-AV: E=Sophos;i="6.19,307,1754982000"; 
   d="scan'208";a="87933353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2025 05:45:09 -0800
X-CSE-ConnectionGUID: dKQHyUvhSY2YVl6knJ/p/g==
X-CSE-MsgGUID: I4pqUY+PRYebFeo/aqiEBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,307,1754982000"; 
   d="scan'208";a="195171935"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Nov 2025 05:45:07 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKGaO-0007zt-2r;
	Sat, 15 Nov 2025 13:45:04 +0000
Date: Sat, 15 Nov 2025 21:44:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 c99ebb6132595b4b288a413981197eb076547c5a
Message-ID: <202511152143.fjO9tLf7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: c99ebb6132595b4b288a413981197eb076547c5a  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 2405m

configs tested: 97
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20251115    gcc-13.4.0
arc                   randconfig-002-20251115    gcc-11.5.0
arm                               allnoconfig    clang-22
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20251115    clang-22
arm                   randconfig-002-20251115    gcc-8.5.0
arm                   randconfig-003-20251115    gcc-10.5.0
arm                   randconfig-004-20251115    clang-22
arm                       spear13xx_defconfig    gcc-15.1.0
arm                           tegra_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251115    gcc-8.5.0
arm64                 randconfig-002-20251115    clang-18
arm64                 randconfig-003-20251115    gcc-13.4.0
arm64                 randconfig-004-20251115    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251115    gcc-15.1.0
csky                  randconfig-002-20251115    gcc-9.5.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251115    clang-16
hexagon               randconfig-002-20251115    clang-22
i386                              allnoconfig    gcc-14
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch                 loongson3_defconfig    clang-22
loongarch             randconfig-001-20251115    clang-18
loongarch             randconfig-002-20251115    gcc-13.4.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           mtx1_defconfig    clang-22
mips                          rb532_defconfig    clang-18
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251115    gcc-8.5.0
nios2                 randconfig-002-20251115    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                       virt_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251115    gcc-8.5.0
parisc                randconfig-002-20251115    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                 canyonlands_defconfig    clang-22
powerpc                  mpc866_ads_defconfig    clang-22
powerpc               randconfig-001-20251115    clang-19
powerpc               randconfig-002-20251115    gcc-8.5.0
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251115    gcc-11.5.0
powerpc64             randconfig-002-20251115    gcc-14.3.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251115    clang-22
riscv                 randconfig-002-20251115    gcc-8.5.0
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251115    clang-17
s390                  randconfig-002-20251115    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          lboxre2_defconfig    gcc-15.1.0
sh                    randconfig-001-20251115    gcc-12.5.0
sh                    randconfig-002-20251115    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251115    gcc-13.4.0
sparc                 randconfig-002-20251115    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251115    gcc-9.5.0
sparc64               randconfig-002-20251115    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251115    gcc-14
um                    randconfig-002-20251115    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251115    gcc-14
x86_64      buildonly-randconfig-002-20251115    gcc-12
x86_64      buildonly-randconfig-003-20251115    gcc-14
x86_64      buildonly-randconfig-004-20251115    gcc-14
x86_64      buildonly-randconfig-005-20251115    gcc-12
x86_64      buildonly-randconfig-006-20251115    gcc-14
x86_64                              defconfig    gcc-14
xtensa                            allnoconfig    gcc-15.1.0
xtensa                          iss_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251115    gcc-8.5.0
xtensa                randconfig-002-20251115    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

