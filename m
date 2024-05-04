Return-Path: <linux-wireless+bounces-7158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1578BBA1C
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 10:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62EB0B2117B
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 08:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1658BF3;
	Sat,  4 May 2024 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/fmY3A8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25E639
	for <linux-wireless@vger.kernel.org>; Sat,  4 May 2024 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714811665; cv=none; b=gCgaC7sE5lTcsstUnZYqM17ENSa5+aRw7HcSs6e9rvRx/aoMo5mZuwuRnfLpzHV0sdK0/+RaiXCdQee/leOOcYPW9Nl9w7Sha8kUfpV8e0PMaQwwaO9Gn6olCh7rwnip/GZ9U4QwtihMug5/+1/NbtUMSqar7LMK1klQRzwr4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714811665; c=relaxed/simple;
	bh=Tt4EIvZuN2gozg/fVcL92nADEAa3vU7y2FYs/p/EJ70=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BXcxokqwbFZdGAKAgGfjn/xkgj4hcyJaR4pqSRmZpfyCQoK2EDqGgrrjPGXTUnHM5FfB/3UdhYy9YPkvlC0ig0lOfJdttHbVM5UTULUNs3DdmlBfrgdQ0BJJWqaeJuU2aV0w5mtd/P+kW13GfOuWzLYzPgZLRfx67wDwaByvvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/fmY3A8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714811664; x=1746347664;
  h=date:from:to:cc:subject:message-id;
  bh=Tt4EIvZuN2gozg/fVcL92nADEAa3vU7y2FYs/p/EJ70=;
  b=G/fmY3A8jQ4wMgFUO2BJXQZOvdJTzoLINe1fqQ0F2MD65MKj7IbYe0Lr
   HP0+tsmei/PBy+8C8lMOqJqxuaV0Gl930dB7LwT5ztCjcnfIAPfZsud4O
   Tn3xKIeuT4xYWJMxJyJUYFMXSKiWF5JvPQQuGms3dbUVEvnfYYYdP+z29
   Z56LaWbzvHeW1OZ4qlyap9cH2N8Yyp5Xp/4nmGn2xSHt+o/RF1+/aiC0P
   xYbczO667Bn79BrRsc7Jv44EVe9jSuqEG3eE6U3vnfA9/QMSCz5a67rdP
   P5x3alYNXTyGO96VMDJdg66ikNw7T5fSs/8J0DhPN3rH6lqEDuXNv0XPV
   w==;
X-CSE-ConnectionGUID: A+qpKbolQ4mWgMQ6Utbsmw==
X-CSE-MsgGUID: 4e/dR7uAQKOmYqKmko3HxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="21771687"
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="21771687"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 01:34:23 -0700
X-CSE-ConnectionGUID: uHdbdrDDSPi1H5qvl9HK4w==
X-CSE-MsgGUID: UQqMVPKjSuuFTzlQAExHhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,253,1708416000"; 
   d="scan'208";a="27767917"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 May 2024 01:34:22 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s3AqZ-000CZs-1F;
	Sat, 04 May 2024 08:34:19 +0000
Date: Sat, 04 May 2024 16:33:33 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 838c7b8f1f278404d9d684c34a8cb26dc41aaaa1
Message-ID: <202405041631.2U37GMEX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 838c7b8f1f278404d9d684c34a8cb26dc41aaaa1  wifi: nl80211: Avoid address calculations via out of bounds array indexing

elapsed time: 1421m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240504   gcc  
arc                   randconfig-002-20240504   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            alldefconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240504   gcc  
arm64                 randconfig-002-20240504   gcc  
arm64                 randconfig-003-20240504   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240504   gcc  
csky                  randconfig-002-20240504   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240504   clang
i386         buildonly-randconfig-002-20240504   gcc  
i386         buildonly-randconfig-003-20240504   gcc  
i386         buildonly-randconfig-004-20240504   clang
i386         buildonly-randconfig-005-20240504   clang
i386         buildonly-randconfig-006-20240504   clang
i386                                defconfig   clang
i386                  randconfig-001-20240504   gcc  
i386                  randconfig-002-20240504   clang
i386                  randconfig-003-20240504   gcc  
i386                  randconfig-004-20240504   clang
i386                  randconfig-005-20240504   clang
i386                  randconfig-006-20240504   gcc  
i386                  randconfig-011-20240504   gcc  
i386                  randconfig-012-20240504   clang
i386                  randconfig-013-20240504   clang
i386                  randconfig-014-20240504   gcc  
i386                  randconfig-015-20240504   gcc  
i386                  randconfig-016-20240504   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240504   gcc  
loongarch             randconfig-002-20240504   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       lemote2f_defconfig   gcc  
mips                          rm200_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240504   gcc  
nios2                 randconfig-002-20240504   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240504   gcc  
parisc                randconfig-002-20240504   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240504   gcc  
powerpc               randconfig-002-20240504   gcc  
powerpc               randconfig-003-20240504   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240504   gcc  
riscv                 randconfig-002-20240504   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-002-20240504   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240504   gcc  
sh                    randconfig-002-20240504   gcc  
sh                           se7780_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240504   gcc  
sparc64               randconfig-002-20240504   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240504   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240504   clang
x86_64       buildonly-randconfig-005-20240504   clang
x86_64       buildonly-randconfig-006-20240504   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240504   clang
x86_64                randconfig-002-20240504   clang
x86_64                randconfig-003-20240504   clang
x86_64                randconfig-004-20240504   clang
x86_64                randconfig-006-20240504   clang
x86_64                randconfig-012-20240504   clang
x86_64                randconfig-014-20240504   clang
x86_64                randconfig-016-20240504   clang
x86_64                randconfig-072-20240504   clang
x86_64                randconfig-075-20240504   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240504   gcc  
xtensa                randconfig-002-20240504   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

