Return-Path: <linux-wireless+bounces-5887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 338F5899497
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 06:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2121C22374
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 04:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8028D28E2;
	Fri,  5 Apr 2024 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT7ZKI80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F321350
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292751; cv=none; b=ccayhwu/9ftT8nmzNvn97h1r54A1EptmYbSueOB4qkOnk/fS8Z50rX7BQjtNu6O9Ipz5cH4IUHP3xEvNI+TNL62H/oQxWE+serqdRAnG96fa7a0anRX0eE8/e0ists9uJKmJ6ywP9gIhYK9gItpVi0RrQtBR1CEvN6D+U54XP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292751; c=relaxed/simple;
	bh=Y5jATI1gM2iQi2o0TMnrsLozWqup9/0RhY7w6X87IpE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XMP3k59LDRtzm9v84G+rnU9A8ze7dlNjVk9P8zMvXxk64kpB+W3GZFGVlBb7l4APoJIgmDq9Cpxr2lfLjWfbkvtwX3UbobprkMUDw3DwH8W2o+I7aL/9402XBcSHooI282G6Y60h6RQ1XgxFiYfw3LVbcKEnV1tkBMiSYci1LO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UT7ZKI80; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712292749; x=1743828749;
  h=date:from:to:cc:subject:message-id;
  bh=Y5jATI1gM2iQi2o0TMnrsLozWqup9/0RhY7w6X87IpE=;
  b=UT7ZKI80JCV7C0EYoLm291JKRPaV07lvUXX6azR5uatQyUoQQQHBhvR1
   wMFu91Oi8lJkU17x0LjQB3hR9uRydINYcRdmP7P5r8bgRnDp432VTui/D
   /eFeZOJJSnVgMMBYNdPWY5L31nuTmj3r0pU6NHjM/0efyhA6UKUaqBUm+
   mNLNWTq2CFb50b5Y7+Z2dNipzDUzdrQh2y9FfDtL7eTtMy5rRYQdHhDDZ
   EcmJ7PGYYgtsdmm9SbDCsQyxvPJhtYoQ01/38Juxk0ZCThH5BltwSnLgb
   DS17ZWlg9nYMEQEQpwvwrKgyWEDQiVynsLFdJkHA8RMLmYeMwYVQt2lS4
   A==;
X-CSE-ConnectionGUID: rzvHJ5B8SEyaThw9qZKp6A==
X-CSE-MsgGUID: p6qNeUzcTfucZ7tSbiv3kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7493088"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="7493088"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 21:52:29 -0700
X-CSE-ConnectionGUID: ShmN6JdlQLythcBvsZP/zQ==
X-CSE-MsgGUID: LnfRK4HwQDijpyZaNLPPXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="23714423"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Apr 2024 21:52:27 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsbYu-0001ts-21;
	Fri, 05 Apr 2024 04:52:24 +0000
Date: Fri, 05 Apr 2024 12:51:54 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 a465371d296097a6ec2bc77b7a0d19bd896e8adf
Message-ID: <202404051251.zrfQh3co-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: a465371d296097a6ec2bc77b7a0d19bd896e8adf  Merge tag 'rtw-next-2024-04-04' of https://github.com/pkshih/rtw into pending

elapsed time: 1176m

configs tested: 244
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
arc                         haps_hs_defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240404   gcc  
arc                   randconfig-001-20240405   gcc  
arc                   randconfig-002-20240404   gcc  
arc                   randconfig-002-20240405   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                        neponset_defconfig   gcc  
arm                   randconfig-001-20240404   gcc  
arm                   randconfig-001-20240405   gcc  
arm                   randconfig-002-20240404   gcc  
arm                   randconfig-003-20240404   clang
arm                   randconfig-003-20240405   gcc  
arm                   randconfig-004-20240404   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240404   gcc  
arm64                 randconfig-001-20240405   gcc  
arm64                 randconfig-002-20240404   gcc  
arm64                 randconfig-002-20240405   gcc  
arm64                 randconfig-003-20240404   clang
arm64                 randconfig-003-20240405   gcc  
arm64                 randconfig-004-20240404   gcc  
arm64                 randconfig-004-20240405   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240404   gcc  
csky                  randconfig-001-20240405   gcc  
csky                  randconfig-002-20240404   gcc  
csky                  randconfig-002-20240405   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240404   clang
hexagon               randconfig-002-20240404   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240404   gcc  
i386         buildonly-randconfig-002-20240404   clang
i386         buildonly-randconfig-003-20240404   clang
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-004-20240404   gcc  
i386         buildonly-randconfig-005-20240404   clang
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240404   gcc  
i386         buildonly-randconfig-006-20240405   clang
i386                                defconfig   clang
i386                  randconfig-001-20240404   gcc  
i386                  randconfig-001-20240405   clang
i386                  randconfig-002-20240404   clang
i386                  randconfig-003-20240404   clang
i386                  randconfig-003-20240405   clang
i386                  randconfig-004-20240404   gcc  
i386                  randconfig-004-20240405   clang
i386                  randconfig-005-20240404   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-006-20240404   clang
i386                  randconfig-011-20240404   gcc  
i386                  randconfig-011-20240405   clang
i386                  randconfig-012-20240404   clang
i386                  randconfig-013-20240404   gcc  
i386                  randconfig-014-20240404   clang
i386                  randconfig-015-20240404   gcc  
i386                  randconfig-016-20240404   gcc  
i386                  randconfig-016-20240405   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240404   gcc  
loongarch             randconfig-001-20240405   gcc  
loongarch             randconfig-002-20240404   gcc  
loongarch             randconfig-002-20240405   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240404   gcc  
nios2                 randconfig-001-20240405   gcc  
nios2                 randconfig-002-20240404   gcc  
nios2                 randconfig-002-20240405   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240404   gcc  
parisc                randconfig-001-20240405   gcc  
parisc                randconfig-002-20240404   gcc  
parisc                randconfig-002-20240405   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240404   gcc  
powerpc               randconfig-002-20240404   gcc  
powerpc               randconfig-003-20240404   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240404   gcc  
powerpc64             randconfig-001-20240405   gcc  
powerpc64             randconfig-002-20240404   clang
powerpc64             randconfig-002-20240405   gcc  
powerpc64             randconfig-003-20240404   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240404   clang
riscv                 randconfig-002-20240404   clang
riscv                 randconfig-002-20240405   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240404   gcc  
s390                  randconfig-002-20240404   gcc  
s390                  randconfig-002-20240405   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240404   gcc  
sh                    randconfig-001-20240405   gcc  
sh                    randconfig-002-20240404   gcc  
sh                    randconfig-002-20240405   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240404   gcc  
sparc64               randconfig-001-20240405   gcc  
sparc64               randconfig-002-20240404   gcc  
sparc64               randconfig-002-20240405   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240404   clang
um                    randconfig-001-20240405   gcc  
um                    randconfig-002-20240404   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240404   gcc  
x86_64       buildonly-randconfig-002-20240404   gcc  
x86_64       buildonly-randconfig-003-20240404   gcc  
x86_64       buildonly-randconfig-003-20240405   gcc  
x86_64       buildonly-randconfig-004-20240404   clang
x86_64       buildonly-randconfig-004-20240405   gcc  
x86_64       buildonly-randconfig-005-20240404   clang
x86_64       buildonly-randconfig-006-20240404   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240404   clang
x86_64                randconfig-002-20240404   gcc  
x86_64                randconfig-003-20240404   clang
x86_64                randconfig-004-20240404   gcc  
x86_64                randconfig-004-20240405   gcc  
x86_64                randconfig-005-20240404   gcc  
x86_64                randconfig-006-20240404   gcc  
x86_64                randconfig-006-20240405   gcc  
x86_64                randconfig-011-20240404   clang
x86_64                randconfig-012-20240404   clang
x86_64                randconfig-012-20240405   gcc  
x86_64                randconfig-013-20240404   clang
x86_64                randconfig-013-20240405   gcc  
x86_64                randconfig-014-20240404   clang
x86_64                randconfig-015-20240404   gcc  
x86_64                randconfig-015-20240405   gcc  
x86_64                randconfig-016-20240404   gcc  
x86_64                randconfig-016-20240405   gcc  
x86_64                randconfig-071-20240404   gcc  
x86_64                randconfig-071-20240405   gcc  
x86_64                randconfig-072-20240404   clang
x86_64                randconfig-072-20240405   gcc  
x86_64                randconfig-073-20240404   clang
x86_64                randconfig-073-20240405   gcc  
x86_64                randconfig-074-20240404   gcc  
x86_64                randconfig-074-20240405   gcc  
x86_64                randconfig-075-20240404   clang
x86_64                randconfig-075-20240405   gcc  
x86_64                randconfig-076-20240404   gcc  
x86_64                randconfig-076-20240405   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240404   gcc  
xtensa                randconfig-001-20240405   gcc  
xtensa                randconfig-002-20240404   gcc  
xtensa                randconfig-002-20240405   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

