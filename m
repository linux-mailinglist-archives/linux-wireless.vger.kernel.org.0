Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFA23EBD52
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Aug 2021 22:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhHMUaz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Aug 2021 16:30:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:63723 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233905AbhHMUay (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Aug 2021 16:30:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="237671419"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="237671419"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2021 13:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; 
   d="scan'208";a="591290915"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2021 13:30:24 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mEdou-000O74-5M; Fri, 13 Aug 2021 20:30:24 +0000
Date:   Sat, 14 Aug 2021 04:29:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 a9a507013a6f98218d1797c8808bd9ba1e79782d
Message-ID: <6116d63a.qFHbzRu86BH/hRpT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: a9a507013a6f98218d1797c8808bd9ba1e79782d  Merge tag 'ieee802154-for-davem-2021-08-12' of git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan

elapsed time: 1482m

configs tested: 151
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210812
i386                 randconfig-c001-20210813
nios2                         3c120_defconfig
powerpc                     pseries_defconfig
mips                         mpc30x_defconfig
powerpc                     kmeter1_defconfig
m68k                             allyesconfig
sparc                       sparc64_defconfig
arm                          badge4_defconfig
h8300                    h8300h-sim_defconfig
m68k                             alldefconfig
sh                          rsk7264_defconfig
sh                            titan_defconfig
powerpc                     asp8347_defconfig
powerpc                        icon_defconfig
arc                          axs103_defconfig
riscv                    nommu_k210_defconfig
mips                  maltasmvp_eva_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        maltaup_defconfig
mips                           ip22_defconfig
sh                           se7721_defconfig
arm                       omap2plus_defconfig
powerpc                       ebony_defconfig
ia64                             allyesconfig
powerpc                      ppc44x_defconfig
arm                        clps711x_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc837x_mds_defconfig
ia64                             alldefconfig
sh                        edosk7705_defconfig
powerpc                         ps3_defconfig
mips                         rt305x_defconfig
arm                            qcom_defconfig
sh                   secureedge5410_defconfig
powerpc                       eiger_defconfig
arm                        multi_v7_defconfig
sh                          r7780mp_defconfig
powerpc                     rainier_defconfig
arm                       cns3420vb_defconfig
mips                          ath25_defconfig
arm                          simpad_defconfig
powerpc                    amigaone_defconfig
arm                         s5pv210_defconfig
arm                           viper_defconfig
arm                         orion5x_defconfig
sh                          lboxre2_defconfig
sh                          urquell_defconfig
microblaze                      mmu_defconfig
arm                         nhk8815_defconfig
arm                             rpc_defconfig
mips                          malta_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
sh                               alldefconfig
sh                         apsh4a3a_defconfig
powerpc                      cm5200_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
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
powerpc                           allnoconfig
i386                 randconfig-a004-20210812
i386                 randconfig-a003-20210812
i386                 randconfig-a002-20210812
i386                 randconfig-a001-20210812
i386                 randconfig-a006-20210812
i386                 randconfig-a005-20210812
i386                 randconfig-a004-20210813
i386                 randconfig-a003-20210813
i386                 randconfig-a001-20210813
i386                 randconfig-a002-20210813
i386                 randconfig-a006-20210813
i386                 randconfig-a005-20210813
x86_64               randconfig-a006-20210812
x86_64               randconfig-a004-20210812
x86_64               randconfig-a003-20210812
x86_64               randconfig-a005-20210812
x86_64               randconfig-a002-20210812
x86_64               randconfig-a001-20210812
i386                 randconfig-a011-20210812
i386                 randconfig-a015-20210812
i386                 randconfig-a013-20210812
i386                 randconfig-a014-20210812
i386                 randconfig-a016-20210812
i386                 randconfig-a012-20210812
i386                 randconfig-a011-20210813
i386                 randconfig-a015-20210813
i386                 randconfig-a014-20210813
i386                 randconfig-a013-20210813
i386                 randconfig-a016-20210813
i386                 randconfig-a012-20210813
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
x86_64               randconfig-c001-20210813
x86_64               randconfig-c001-20210812
x86_64               randconfig-a011-20210812
x86_64               randconfig-a013-20210812
x86_64               randconfig-a012-20210812
x86_64               randconfig-a016-20210812
x86_64               randconfig-a015-20210812
x86_64               randconfig-a014-20210812
x86_64               randconfig-a006-20210813
x86_64               randconfig-a004-20210813
x86_64               randconfig-a003-20210813
x86_64               randconfig-a002-20210813
x86_64               randconfig-a005-20210813
x86_64               randconfig-a001-20210813

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
