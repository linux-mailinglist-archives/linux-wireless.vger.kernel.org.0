Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D81033C81B
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 22:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhCOVD7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 17:03:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:26475 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232282AbhCOVDu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 17:03:50 -0400
IronPort-SDR: GnNrJq3pbBySQaeJWTu98QTkxHnZ8KIeABkxdLr94tJDnTYyz0yjsOD2g5+qhWEFuBpq3USTqJ
 TWM/p/FglmPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176286453"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="176286453"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 14:03:49 -0700
IronPort-SDR: GEC0BrIBJ59+sSIw2NIqHOietQCuVztMILdZsPa3iAjCyuxtU8FPxQ8QlmbQj63/f2IaHETlmW
 TfKq/hzvaa7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="378637806"
Received: from lkp-server02.sh.intel.com (HELO 1dc5e1a854f4) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 15 Mar 2021 14:03:48 -0700
Received: from kbuild by 1dc5e1a854f4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lLuNQ-0000eM-3F; Mon, 15 Mar 2021 21:03:48 +0000
Date:   Tue, 16 Mar 2021 05:02:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 13ce240a932fe9c809ec6e79ffc5a4d4ecf534ee
Message-ID: <604fcb7d.5C30/R8nyuwyEPoL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 13ce240a932fe9c809ec6e79ffc5a4d4ecf534ee  rtw88: 8822c: support FW crash dump when FW crash

elapsed time: 725m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
sh                                  defconfig
sh                               alldefconfig
powerpc                     taishan_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      loongson3_defconfig
mips                         rt305x_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
nds32                             allnoconfig
sh                   secureedge5410_defconfig
nds32                            alldefconfig
arc                      axs103_smp_defconfig
mips                      malta_kvm_defconfig
arm                           u8500_defconfig
powerpc                      ppc6xx_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                          hp300_defconfig
mips                     cu1830-neo_defconfig
mips                        jmr3927_defconfig
arm                           h5000_defconfig
arm                          exynos_defconfig
arm                       mainstone_defconfig
arm                           omap1_defconfig
arm                           spitz_defconfig
arm                       omap2plus_defconfig
powerpc                    socrates_defconfig
powerpc                       ebony_defconfig
sparc                       sparc64_defconfig
arm                         vf610m4_defconfig
m68k                        m5272c3_defconfig
sh                          urquell_defconfig
xtensa                           alldefconfig
sh                        sh7757lcr_defconfig
s390                                defconfig
sh                           se7206_defconfig
mips                         mpc30x_defconfig
mips                  decstation_64_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
xtensa                  cadence_csp_defconfig
mips                            ar7_defconfig
arc                        nsim_700_defconfig
sh                             shx3_defconfig
powerpc                     kmeter1_defconfig
mips                        nlm_xlp_defconfig
arm                         nhk8815_defconfig
xtensa                generic_kc705_defconfig
parisc                           alldefconfig
sh                            titan_defconfig
arm                         assabet_defconfig
mips                           ip32_defconfig
arm                        multi_v7_defconfig
powerpc                     rainier_defconfig
parisc                generic-32bit_defconfig
arm                        mini2440_defconfig
i386                                defconfig
h8300                       h8s-sim_defconfig
sh                          r7785rp_defconfig
mips                        maltaup_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7721_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      cm5200_defconfig
powerpc                    sam440ep_defconfig
sh                        sh7763rdp_defconfig
um                             i386_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
powerpc                      ppc40x_defconfig
sh                          lboxre2_defconfig
powerpc                      pcm030_defconfig
mips                            gpr_defconfig
mips                        bcm63xx_defconfig
powerpc                   motionpro_defconfig
arm                           h3600_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          g5_defconfig
arm                         orion5x_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210315
i386                 randconfig-a005-20210315
i386                 randconfig-a003-20210315
i386                 randconfig-a002-20210315
i386                 randconfig-a004-20210315
i386                 randconfig-a006-20210315
i386                 randconfig-a013-20210315
i386                 randconfig-a016-20210315
i386                 randconfig-a011-20210315
i386                 randconfig-a012-20210315
i386                 randconfig-a014-20210315
i386                 randconfig-a015-20210315
x86_64               randconfig-a006-20210315
x86_64               randconfig-a001-20210315
x86_64               randconfig-a005-20210315
x86_64               randconfig-a004-20210315
x86_64               randconfig-a002-20210315
x86_64               randconfig-a003-20210315
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210315
x86_64               randconfig-a016-20210315
x86_64               randconfig-a013-20210315
x86_64               randconfig-a015-20210315
x86_64               randconfig-a014-20210315
x86_64               randconfig-a012-20210315

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
