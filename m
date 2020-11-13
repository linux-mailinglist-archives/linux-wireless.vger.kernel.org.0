Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6872B25DF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Nov 2020 21:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKMUva (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Nov 2020 15:51:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:23418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgKMUv3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Nov 2020 15:51:29 -0500
IronPort-SDR: WcybX/pOnpYhkKkg07xsbc2OK3NaRBxeTk2gMEl0vMNo387g7IL7wEIb3YqITFA79iUv/1kz0j
 kwAK+8lMQuww==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="167953150"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="167953150"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:51:28 -0800
IronPort-SDR: syBjaVHz6Rk4hpSyf7shA1EaA+NfleZ4jmBXc9fzg4tVkQ3RtZ3lOlFIpd2EWDGSspy48D/eJ4
 2vMCrA8DOXLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="357648455"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Nov 2020 12:51:27 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdg2Y-0000Wy-Kd; Fri, 13 Nov 2020 20:51:26 +0000
Date:   Sat, 14 Nov 2020 04:51:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 7bc40aedf24d31d8bea80e1161e996ef4299fb10
Message-ID: <5faef1cb./ixq4jJrYxifjqqd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 7bc40aedf24d31d8bea80e1161e996ef4299fb10  mac80211: free sta in sta_info_insert_finish() on errors

elapsed time: 720m

configs tested: 184
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     sbc8548_defconfig
arm                         lubbock_defconfig
powerpc                      acadia_defconfig
mips                  cavium_octeon_defconfig
powerpc                     pq2fads_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     loongson1b_defconfig
powerpc                     rainier_defconfig
ia64                          tiger_defconfig
nios2                         10m50_defconfig
arm                             mxs_defconfig
arm                          prima2_defconfig
arm64                            alldefconfig
mips                          ath79_defconfig
powerpc                     sequoia_defconfig
powerpc                       eiger_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
m68k                                defconfig
parisc                generic-32bit_defconfig
arm                         orion5x_defconfig
mips                           ci20_defconfig
arm                              alldefconfig
mips                         bigsur_defconfig
arm                         s3c6400_defconfig
arm                         s5pv210_defconfig
arm                        cerfcube_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
nios2                            alldefconfig
sh                          rsk7203_defconfig
m68k                            q40_defconfig
sh                             shx3_defconfig
openrisc                    or1ksim_defconfig
arm                         hackkit_defconfig
powerpc                  storcenter_defconfig
sparc                       sparc32_defconfig
powerpc                     ppa8548_defconfig
sh                           se7750_defconfig
arc                           tb10x_defconfig
mips                        nlm_xlr_defconfig
c6x                              alldefconfig
arc                     nsimosci_hs_defconfig
arm                          gemini_defconfig
m68k                       m5249evb_defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
arm                           sunxi_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    sam440ep_defconfig
arm                           h3600_defconfig
arm                          tango4_defconfig
powerpc                     stx_gp3_defconfig
mips                         rt305x_defconfig
powerpc                   bluestone_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8560_defconfig
nds32                            alldefconfig
powerpc                      ep88xc_defconfig
sh                  sh7785lcr_32bit_defconfig
h8300                            allyesconfig
powerpc                       maple_defconfig
arm                       aspeed_g5_defconfig
arc                        nsim_700_defconfig
mips                       rbtx49xx_defconfig
microblaze                          defconfig
sh                   sh7724_generic_defconfig
alpha                            alldefconfig
arm                         vf610m4_defconfig
arm                      integrator_defconfig
sh                         ecovec24_defconfig
mips                         tb0287_defconfig
xtensa                generic_kc705_defconfig
arm                              zx_defconfig
mips                            gpr_defconfig
powerpc                     skiroot_defconfig
arm                          lpd270_defconfig
mips                           jazz_defconfig
xtensa                          iss_defconfig
m68k                       m5208evb_defconfig
mips                           xway_defconfig
mips                        jmr3927_defconfig
mips                          rb532_defconfig
arm                       aspeed_g4_defconfig
um                            kunit_defconfig
m68k                          hp300_defconfig
riscv                            allyesconfig
mips                        maltaup_defconfig
mips                        nlm_xlp_defconfig
arm                            u300_defconfig
openrisc                 simple_smp_defconfig
sh                          sdk7780_defconfig
s390                             alldefconfig
mips                       lemote2f_defconfig
c6x                        evmc6474_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                         bcm2835_defconfig
m68k                       m5475evb_defconfig
arm                      tct_hammer_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                            xcep_defconfig
mips                 decstation_r4k_defconfig
sh                          rsk7269_defconfig
arm                           spitz_defconfig
powerpc                         wii_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                          g5_defconfig
sparc                       sparc64_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a006-20201113
i386                 randconfig-a005-20201113
i386                 randconfig-a002-20201113
i386                 randconfig-a001-20201113
i386                 randconfig-a003-20201113
i386                 randconfig-a004-20201113
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
i386                 randconfig-a012-20201113
i386                 randconfig-a014-20201113
i386                 randconfig-a016-20201113
i386                 randconfig-a011-20201113
i386                 randconfig-a015-20201113
i386                 randconfig-a013-20201113
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
