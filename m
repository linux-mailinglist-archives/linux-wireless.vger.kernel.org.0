Return-Path: <linux-wireless+bounces-907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C999A816DB0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 13:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9DF1F225E1
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Dec 2023 12:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43FD4F202;
	Mon, 18 Dec 2023 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsWT4eAc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB724EB54
	for <linux-wireless@vger.kernel.org>; Mon, 18 Dec 2023 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702901462; x=1734437462;
  h=date:from:to:cc:subject:message-id;
  bh=qfhqAXzsHpuVLIp7wDZ2xiRmvv0Mm/JstOt3Y4a6LF0=;
  b=nsWT4eAcYsEzlAmhEI25CP1i8bVPYp/HR839OpsWfxWJYzvSKBzdzx03
   xAu7Nsc89O4aKc3i4d7Jn6nnivcq1KfJifY8608Vt5adTKhTGwbvCAsHu
   xgdrWMkwpympY/PHucgOcujbJ5zU6fu7VLtMSP1c0u+NXp3gOeo6SZYnP
   +zFkzHaBVeHgFUHp3I5UCHIg7koligljptXdj5bUrl95gFY8PqWUJHWZz
   vDFekdWpZVgrbErBBS9PzbIHBaAY+ydHQBUF0S4joaQYLvBRbBkCQic4m
   qDRy7qVoDS84gK0D+LtE6aGUE7xI1uNHWNsrEwhL8568oL3tnbJso5VP/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="481680901"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="481680901"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 04:11:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="725299625"
X-IronPort-AV: E=Sophos;i="6.04,285,1695711600"; 
   d="scan'208";a="725299625"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Dec 2023 04:11:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFCSX-00042z-2a;
	Mon, 18 Dec 2023 12:10:57 +0000
Date: Mon, 18 Dec 2023 20:10:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 c5a3f56fcdb0a48a20772e4c9b8adc6c7256a461
Message-ID: <202312182042.cjmkxDMF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: c5a3f56fcdb0a48a20772e4c9b8adc6c7256a461  Merge tag 'ath-next-20231215' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

elapsed time: 1480m

configs tested: 221
configs skipped: 3

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
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231218   gcc  
arc                   randconfig-002-20231218   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                           h3600_defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                          pxa3xx_defconfig   gcc  
arm                   randconfig-001-20231218   gcc  
arm                   randconfig-002-20231218   gcc  
arm                   randconfig-003-20231218   gcc  
arm                   randconfig-004-20231218   gcc  
arm                        shmobile_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231218   gcc  
arm64                 randconfig-002-20231218   gcc  
arm64                 randconfig-003-20231218   gcc  
arm64                 randconfig-004-20231218   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231218   gcc  
csky                  randconfig-002-20231218   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231218   clang
hexagon               randconfig-002-20231218   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231217   clang
i386         buildonly-randconfig-002-20231217   clang
i386         buildonly-randconfig-003-20231217   clang
i386         buildonly-randconfig-004-20231217   clang
i386         buildonly-randconfig-005-20231217   clang
i386         buildonly-randconfig-006-20231217   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231217   clang
i386                  randconfig-002-20231217   clang
i386                  randconfig-003-20231217   clang
i386                  randconfig-004-20231217   clang
i386                  randconfig-005-20231217   clang
i386                  randconfig-006-20231217   clang
i386                  randconfig-011-20231217   gcc  
i386                  randconfig-012-20231217   gcc  
i386                  randconfig-013-20231217   gcc  
i386                  randconfig-014-20231217   gcc  
i386                  randconfig-015-20231217   gcc  
i386                  randconfig-016-20231217   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231218   gcc  
loongarch             randconfig-002-20231218   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                        bcm47xx_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                           mtx1_defconfig   clang
mips                        omega2p_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231218   gcc  
nios2                 randconfig-002-20231218   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20231218   gcc  
parisc                randconfig-002-20231218   gcc  
parisc64                            defconfig   gcc  
powerpc                      acadia_defconfig   clang
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                   bluestone_defconfig   clang
powerpc                        cell_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                     ksi8560_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231218   gcc  
powerpc               randconfig-002-20231218   gcc  
powerpc               randconfig-003-20231218   gcc  
powerpc                 xes_mpc85xx_defconfig   gcc  
powerpc64             randconfig-001-20231218   gcc  
powerpc64             randconfig-002-20231218   gcc  
powerpc64             randconfig-003-20231218   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231218   gcc  
riscv                 randconfig-002-20231218   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231218   clang
s390                  randconfig-002-20231218   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20231218   gcc  
sh                    randconfig-002-20231218   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231218   gcc  
sparc                 randconfig-002-20231218   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231218   gcc  
sparc64               randconfig-002-20231218   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231218   gcc  
um                    randconfig-002-20231218   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231218   gcc  
x86_64       buildonly-randconfig-002-20231218   gcc  
x86_64       buildonly-randconfig-003-20231218   gcc  
x86_64       buildonly-randconfig-004-20231218   gcc  
x86_64       buildonly-randconfig-005-20231218   gcc  
x86_64       buildonly-randconfig-006-20231218   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231218   clang
x86_64                randconfig-002-20231218   clang
x86_64                randconfig-003-20231218   clang
x86_64                randconfig-004-20231218   clang
x86_64                randconfig-005-20231218   clang
x86_64                randconfig-006-20231218   clang
x86_64                randconfig-011-20231218   gcc  
x86_64                randconfig-012-20231218   gcc  
x86_64                randconfig-013-20231218   gcc  
x86_64                randconfig-014-20231218   gcc  
x86_64                randconfig-015-20231218   gcc  
x86_64                randconfig-016-20231218   gcc  
x86_64                randconfig-071-20231218   gcc  
x86_64                randconfig-072-20231218   gcc  
x86_64                randconfig-073-20231218   gcc  
x86_64                randconfig-074-20231218   gcc  
x86_64                randconfig-075-20231218   gcc  
x86_64                randconfig-076-20231218   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231218   gcc  
xtensa                randconfig-002-20231218   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

