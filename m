Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714DE3EF990
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 06:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbhHREi7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 00:38:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:5026 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhHREi6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 00:38:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203400458"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="203400458"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 21:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="676896697"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2021 21:38:23 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGDLK-000Sag-JA; Wed, 18 Aug 2021 04:38:22 +0000
Date:   Wed, 18 Aug 2021 12:37:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 0a298d133893c72c96e2156ed7cb0f0c4a306a3e
Message-ID: <611c8e9d.uQsDj2R9qc6cfC4K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 0a298d133893c72c96e2156ed7cb0f0c4a306a3e  net: qlcnic: add missed unlock in qlcnic_83xx_flash_read32

elapsed time: 787m

configs tested: 152
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
xtensa                generic_kc705_defconfig
sh                        edosk7760_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
mips                      maltaaprp_defconfig
powerpc                     akebono_defconfig
powerpc                      mgcoge_defconfig
powerpc                 linkstation_defconfig
mips                         db1xxx_defconfig
arm                          simpad_defconfig
powerpc                     pq2fads_defconfig
powerpc                      walnut_defconfig
powerpc                       holly_defconfig
arm                             ezx_defconfig
powerpc                     mpc512x_defconfig
xtensa                  nommu_kc705_defconfig
arm                         at91_dt_defconfig
mips                     loongson1c_defconfig
mips                          rb532_defconfig
mips                       bmips_be_defconfig
arm                            dove_defconfig
sh                     magicpanelr2_defconfig
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             alldefconfig
arm                         lubbock_defconfig
sh                         ecovec24_defconfig
arc                        nsim_700_defconfig
mips                            e55_defconfig
arm                          lpd270_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                  iss476-smp_defconfig
arc                        vdk_hs38_defconfig
mips                           jazz_defconfig
mips                     cu1000-neo_defconfig
ia64                            zx1_defconfig
sh                        edosk7705_defconfig
powerpc                   microwatt_defconfig
arm                  colibri_pxa270_defconfig
um                               alldefconfig
sh                           se7721_defconfig
sh                          rsk7201_defconfig
arm                  colibri_pxa300_defconfig
openrisc                         alldefconfig
arm                          badge4_defconfig
powerpc                      pmac32_defconfig
arm                        spear3xx_defconfig
sh                          r7780mp_defconfig
x86_64                           alldefconfig
mips                        jmr3927_defconfig
powerpc                      acadia_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7724_defconfig
powerpc                        cell_defconfig
openrisc                 simple_smp_defconfig
mips                        vocore2_defconfig
powerpc                        icon_defconfig
powerpc                      katmai_defconfig
x86_64                            allnoconfig
powerpc                   currituck_defconfig
powerpc                 canyonlands_defconfig
powerpc                           allnoconfig
powerpc                       maple_defconfig
powerpc                     tqm8541_defconfig
arm                           sama5_defconfig
arm                           u8500_defconfig
sparc                       sparc32_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
i386                 randconfig-a011-20210817
i386                 randconfig-a015-20210817
i386                 randconfig-a014-20210817
i386                 randconfig-a013-20210817
i386                 randconfig-a016-20210817
i386                 randconfig-a012-20210817
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a004-20210817
i386                 randconfig-a006-20210817
i386                 randconfig-a005-20210817
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
