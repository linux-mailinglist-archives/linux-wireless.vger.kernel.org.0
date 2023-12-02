Return-Path: <linux-wireless+bounces-329-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE11801D26
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 14:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4823C1F21174
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979AD182BA;
	Sat,  2 Dec 2023 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lM9Bd5eQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247FC107
	for <linux-wireless@vger.kernel.org>; Sat,  2 Dec 2023 05:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701524821; x=1733060821;
  h=date:from:to:cc:subject:message-id;
  bh=GsBTgQLadluwmO+Kz9Gg4NDWOTnGqoRMWnBL+0gccsw=;
  b=lM9Bd5eQq2i+hDT/NmctjM5LZujLWbv2XAnyAfMWQGqWIHkYPVfOog7D
   G4ccejosxpr3ww/YuiTgxewnN0Bs+EFy2scB0rzp6H2aJmVgoJBMi5aFP
   z6HbyLKxHx8tfImHSPa8IgELvJZSKYe7UgP/ajrYJkye2KaDnnfcWNcAB
   fvAZkZEUv5CGQw672oO4Relq4cV/xyFjTRnygm3raAFEIgFpOPkxA/NLG
   EfzoCmIL8rOh25dAQm8fJv6uO5fvic7iQ8n4Q43FrUdUYizBZQPrSON3F
   UGVWG5qiNrDTsQ8KehMi7FfC0XbBgiNfdeEptejepp106EkQjnuFxnqOk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="457920871"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="457920871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 05:47:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="719820779"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="719820779"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Dec 2023 05:46:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r9QKe-0005FG-1F;
	Sat, 02 Dec 2023 13:46:56 +0000
Date: Sat, 02 Dec 2023 21:46:16 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 756b31203d482d2dd1aa6c208978b0410dc7530f
Message-ID: <202312022113.pfwAh0GM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 756b31203d482d2dd1aa6c208978b0410dc7530f  wifi: rtw89: fix misbehavior of TX beacon in concurrent mode

elapsed time: 1459m

configs tested: 252
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              alldefconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231201   gcc  
arc                   randconfig-001-20231202   gcc  
arc                   randconfig-002-20231201   gcc  
arc                   randconfig-002-20231202   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                         lpc18xx_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                        multi_v5_defconfig   clang
arm                   randconfig-001-20231201   gcc  
arm                   randconfig-002-20231201   gcc  
arm                   randconfig-003-20231201   gcc  
arm                   randconfig-004-20231201   gcc  
arm                        realview_defconfig   gcc  
arm                        spear6xx_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231201   gcc  
arm64                 randconfig-002-20231201   gcc  
arm64                 randconfig-003-20231201   gcc  
arm64                 randconfig-004-20231201   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231201   gcc  
csky                  randconfig-001-20231202   gcc  
csky                  randconfig-002-20231201   gcc  
csky                  randconfig-002-20231202   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231201   clang
hexagon               randconfig-002-20231201   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231201   gcc  
i386         buildonly-randconfig-002-20231201   gcc  
i386         buildonly-randconfig-003-20231201   gcc  
i386         buildonly-randconfig-004-20231201   gcc  
i386         buildonly-randconfig-005-20231201   gcc  
i386         buildonly-randconfig-006-20231201   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231201   gcc  
i386                  randconfig-002-20231201   gcc  
i386                  randconfig-003-20231201   gcc  
i386                  randconfig-004-20231201   gcc  
i386                  randconfig-005-20231201   gcc  
i386                  randconfig-006-20231201   gcc  
i386                  randconfig-011-20231201   clang
i386                  randconfig-011-20231202   gcc  
i386                  randconfig-012-20231201   clang
i386                  randconfig-012-20231202   gcc  
i386                  randconfig-013-20231201   clang
i386                  randconfig-013-20231202   gcc  
i386                  randconfig-014-20231201   clang
i386                  randconfig-014-20231202   gcc  
i386                  randconfig-015-20231201   clang
i386                  randconfig-015-20231202   gcc  
i386                  randconfig-016-20231201   clang
i386                  randconfig-016-20231202   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231201   gcc  
loongarch             randconfig-001-20231202   gcc  
loongarch             randconfig-002-20231201   gcc  
loongarch             randconfig-002-20231202   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
m68k                           virt_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         db1xxx_defconfig   gcc  
mips                          rb532_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231201   gcc  
nios2                 randconfig-001-20231202   gcc  
nios2                 randconfig-002-20231201   gcc  
nios2                 randconfig-002-20231202   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231201   gcc  
parisc                randconfig-001-20231202   gcc  
parisc                randconfig-002-20231201   gcc  
parisc                randconfig-002-20231202   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc               randconfig-001-20231201   gcc  
powerpc               randconfig-002-20231201   gcc  
powerpc               randconfig-003-20231201   gcc  
powerpc                     tqm8541_defconfig   gcc  
powerpc64             randconfig-001-20231201   gcc  
powerpc64             randconfig-002-20231201   gcc  
powerpc64             randconfig-003-20231201   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231201   gcc  
riscv                 randconfig-002-20231201   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231201   clang
s390                  randconfig-001-20231202   gcc  
s390                  randconfig-002-20231201   clang
s390                  randconfig-002-20231202   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                    randconfig-001-20231201   gcc  
sh                    randconfig-001-20231202   gcc  
sh                    randconfig-002-20231201   gcc  
sh                    randconfig-002-20231202   gcc  
sh                          sdk7780_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231201   gcc  
sparc64               randconfig-001-20231202   gcc  
sparc64               randconfig-002-20231201   gcc  
sparc64               randconfig-002-20231202   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231201   gcc  
um                    randconfig-002-20231201   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231201   gcc  
x86_64       buildonly-randconfig-001-20231202   clang
x86_64       buildonly-randconfig-002-20231201   gcc  
x86_64       buildonly-randconfig-002-20231202   clang
x86_64       buildonly-randconfig-003-20231201   gcc  
x86_64       buildonly-randconfig-003-20231202   clang
x86_64       buildonly-randconfig-004-20231201   gcc  
x86_64       buildonly-randconfig-004-20231202   clang
x86_64       buildonly-randconfig-005-20231201   gcc  
x86_64       buildonly-randconfig-005-20231202   clang
x86_64       buildonly-randconfig-006-20231201   gcc  
x86_64       buildonly-randconfig-006-20231202   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231201   clang
x86_64                randconfig-002-20231201   clang
x86_64                randconfig-003-20231201   clang
x86_64                randconfig-004-20231201   clang
x86_64                randconfig-005-20231201   clang
x86_64                randconfig-006-20231201   clang
x86_64                randconfig-011-20231201   gcc  
x86_64                randconfig-011-20231202   clang
x86_64                randconfig-012-20231201   gcc  
x86_64                randconfig-012-20231202   clang
x86_64                randconfig-013-20231201   gcc  
x86_64                randconfig-013-20231202   clang
x86_64                randconfig-014-20231201   gcc  
x86_64                randconfig-014-20231202   clang
x86_64                randconfig-015-20231201   gcc  
x86_64                randconfig-015-20231202   clang
x86_64                randconfig-016-20231201   gcc  
x86_64                randconfig-016-20231202   clang
x86_64                randconfig-071-20231201   gcc  
x86_64                randconfig-071-20231202   clang
x86_64                randconfig-072-20231201   gcc  
x86_64                randconfig-072-20231202   clang
x86_64                randconfig-073-20231201   gcc  
x86_64                randconfig-073-20231202   clang
x86_64                randconfig-074-20231201   gcc  
x86_64                randconfig-074-20231202   clang
x86_64                randconfig-075-20231201   gcc  
x86_64                randconfig-075-20231202   clang
x86_64                randconfig-076-20231201   gcc  
x86_64                randconfig-076-20231202   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20231201   gcc  
xtensa                randconfig-001-20231202   gcc  
xtensa                randconfig-002-20231201   gcc  
xtensa                randconfig-002-20231202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

