Return-Path: <linux-wireless+bounces-11827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4BB95C6B8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 09:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F7B4B22C8D
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCDA49650;
	Fri, 23 Aug 2024 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsOdPpEv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD73BBE9
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398824; cv=none; b=tAzUvbODloZ3vm0RQynTlP3S3aoBrGuSS2a2OHuFDmvlGTG0/NvlfqsNtILJdyy3MklSnE2gxglKGOrYbBoDP5ZtvLLgh9sdj/bHAdOh9FaeLTsOGQYr1gO/MvRDID8MvFMkKSx/jMkzwGF2Uo0A0OFhMfWroXBRUv5JSvAdGso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398824; c=relaxed/simple;
	bh=Z3aZpzVJyDD5PAg4BlT8H2UO0d11U57s0yP+0B58IEQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LJTcXY8xWJhps8awPNAaz46613U16DyVVYl6bc0Bx2prudQ9a1h052q/l74VooHQHw9MnFTowqoWBHM1Yj+7srBDMO59RsEUsJ4Xjz6JB4bdHxXUHq776e1HEb+ijY1mB+l908AltyDCDnRTSAtPEHbQ47getfNhgdaGSD6Urn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsOdPpEv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724398822; x=1755934822;
  h=date:from:to:cc:subject:message-id;
  bh=Z3aZpzVJyDD5PAg4BlT8H2UO0d11U57s0yP+0B58IEQ=;
  b=nsOdPpEvg+DonJ1Pgp0Ifx2WXIz2jJTVvllospLxF2A0+y8uZIyiVfXq
   zoGKOQhRITqwNLcogMUiypbNwaRRhCsXcOyeFGGKeCUSqD3QuC8xNY9/7
   Fs0tRUS35l9PHe2ITWPbY5FPqnkltkKIemmNzTTR4u8RkMKAZV9sExQgv
   3XLfhoxmYBsNJjSU72Fy6l5eZO6lntKIrEZ6uANZKtVZxTJ098P6NPnPu
   VxfSO0VA21bngN01SvfD1jzW+ecbG0UyOQg8Pn4eTPuv4NyKESNnHW6c5
   cSyk7730obwhA5TUfEKH/iIPsHFiCsCEzHkvmesA/vzJ/PEdIuJQTiRFD
   w==;
X-CSE-ConnectionGUID: OxsQ3oGqQr+oApoyNYEqKQ==
X-CSE-MsgGUID: 1z5bHbF+RfWOZCyMW5jiCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="22662920"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="22662920"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 00:40:21 -0700
X-CSE-ConnectionGUID: h/PaInpcRxqcumb88IJlnQ==
X-CSE-MsgGUID: rHUAvnwDQbuBV5iVp4OxvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61694854"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 23 Aug 2024 00:40:20 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shOuA-000DZM-0q;
	Fri, 23 Aug 2024 07:40:18 +0000
Date: Fri, 23 Aug 2024 15:39:53 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 67a72043aa2e6f60f7bbe7bfa598ba168f16d04f
Message-ID: <202408231550.w36Gak1l-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 67a72043aa2e6f60f7bbe7bfa598ba168f16d04f  wifi: mwifiex: remove unnecessary checks for valid priv

elapsed time: 1354m

configs tested: 177
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig   gcc-13.2.0
arc                   randconfig-001-20240823   gcc-13.2.0
arc                   randconfig-002-20240823   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                         axm55xx_defconfig   clang-20
arm                         bcm2835_defconfig   clang-20
arm                                 defconfig   clang-14
arm                          exynos_defconfig   clang-17
arm                           imxrt_defconfig   clang-20
arm                      integrator_defconfig   clang-20
arm                          pxa3xx_defconfig   clang-20
arm                   randconfig-001-20240823   gcc-14.1.0
arm                   randconfig-002-20240823   clang-20
arm                   randconfig-003-20240823   gcc-14.1.0
arm                   randconfig-004-20240823   clang-20
arm                        vexpress_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240823   clang-20
arm64                 randconfig-002-20240823   gcc-14.1.0
arm64                 randconfig-003-20240823   gcc-14.1.0
arm64                 randconfig-004-20240823   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240823   gcc-14.1.0
csky                  randconfig-002-20240823   gcc-14.1.0
hexagon                          alldefconfig   clang-15
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240823   clang-20
hexagon               randconfig-002-20240823   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240823   clang-18
i386         buildonly-randconfig-002-20240823   clang-18
i386         buildonly-randconfig-003-20240823   gcc-12
i386         buildonly-randconfig-004-20240823   clang-18
i386         buildonly-randconfig-005-20240823   clang-18
i386         buildonly-randconfig-006-20240823   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240823   gcc-12
i386                  randconfig-002-20240823   gcc-12
i386                  randconfig-003-20240823   clang-18
i386                  randconfig-004-20240823   gcc-12
i386                  randconfig-005-20240823   gcc-11
i386                  randconfig-006-20240823   gcc-12
i386                  randconfig-011-20240823   clang-18
i386                  randconfig-012-20240823   clang-18
i386                  randconfig-013-20240823   gcc-12
i386                  randconfig-014-20240823   clang-18
i386                  randconfig-015-20240823   clang-18
i386                  randconfig-016-20240823   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240823   gcc-14.1.0
loongarch             randconfig-002-20240823   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          hp300_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           ip32_defconfig   clang-20
mips                     loongson2k_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240823   gcc-14.1.0
nios2                 randconfig-002-20240823   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
openrisc                    or1ksim_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240823   gcc-14.1.0
parisc                randconfig-002-20240823   gcc-14.1.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                    amigaone_defconfig   gcc-14.1.0
powerpc                     mpc512x_defconfig   clang-20
powerpc               randconfig-001-20240823   clang-20
powerpc               randconfig-002-20240823   clang-14
powerpc               randconfig-003-20240823   gcc-14.1.0
powerpc                    socrates_defconfig   gcc-14.1.0
powerpc                     taishan_defconfig   clang-20
powerpc                     tqm8548_defconfig   clang-20
powerpc64             randconfig-001-20240823   gcc-14.1.0
powerpc64             randconfig-002-20240823   gcc-14.1.0
powerpc64             randconfig-003-20240823   clang-20
riscv                            allmodconfig   clang-20
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240823   clang-14
riscv                 randconfig-002-20240823   clang-20
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240823   gcc-14.1.0
s390                  randconfig-002-20240823   clang-15
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240823   gcc-14.1.0
sh                    randconfig-002-20240823   gcc-14.1.0
sh                            titan_defconfig   gcc-14.1.0
sh                          urquell_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240823   gcc-14.1.0
sparc64               randconfig-002-20240823   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240823   clang-20
um                    randconfig-002-20240823   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240823   gcc-12
x86_64       buildonly-randconfig-002-20240823   gcc-12
x86_64       buildonly-randconfig-003-20240823   gcc-12
x86_64       buildonly-randconfig-004-20240823   clang-18
x86_64       buildonly-randconfig-005-20240823   gcc-12
x86_64       buildonly-randconfig-006-20240823   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240823   clang-18
x86_64                randconfig-002-20240823   clang-18
x86_64                randconfig-003-20240823   clang-18
x86_64                randconfig-004-20240823   clang-18
x86_64                randconfig-005-20240823   clang-18
x86_64                randconfig-006-20240823   clang-18
x86_64                randconfig-011-20240823   gcc-12
x86_64                randconfig-012-20240823   clang-18
x86_64                randconfig-013-20240823   clang-18
x86_64                randconfig-014-20240823   gcc-11
x86_64                randconfig-015-20240823   clang-18
x86_64                randconfig-016-20240823   gcc-12
x86_64                randconfig-071-20240823   gcc-12
x86_64                randconfig-072-20240823   gcc-12
x86_64                randconfig-073-20240823   gcc-12
x86_64                randconfig-074-20240823   clang-18
x86_64                randconfig-075-20240823   gcc-12
x86_64                randconfig-076-20240823   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240823   gcc-14.1.0
xtensa                randconfig-002-20240823   gcc-14.1.0
xtensa                    xip_kc705_defconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

