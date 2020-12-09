Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2CAA2D4A12
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 20:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgLIT1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 14:27:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:2215 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgLIT1f (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 14:27:35 -0500
IronPort-SDR: B2NVWOgoy1sBHiE39oezUCy7TKId9bW2li5U9suzYEuKXBktoL8Eq+NiaQrTZTEZmksKfYKm7g
 ZgAy4sAwXGsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="161894549"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="161894549"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 11:26:37 -0800
IronPort-SDR: 47QPtUpqs8vRSxVbnKp28E6w4FOWGESX8c3TzyDOMEwZoiZZc9H9FfjJhcbHdRiKDrkk1jfSXU
 aVr8gfQjLgXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="552749229"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2020 11:26:36 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kn56h-0000Py-PE; Wed, 09 Dec 2020 19:26:35 +0000
Date:   Thu, 10 Dec 2020 03:25:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 3f79e541593fecc2a90687eb7162e15a499caa33
Message-ID: <5fd124c0.V5YZuEy3DHdQoZqg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 3f79e541593fecc2a90687eb7162e15a499caa33  rtlwifi: rtl8192de: fix ofdm power compensation

elapsed time: 721m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                     davinci_all_defconfig
powerpc                      mgcoge_defconfig
powerpc                      ppc64e_defconfig
sh                            shmin_defconfig
mips                         tb0226_defconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
c6x                         dsk6455_defconfig
c6x                        evmc6472_defconfig
mips                       lemote2f_defconfig
powerpc                   motionpro_defconfig
mips                           ip28_defconfig
m68k                        m5407c3_defconfig
arc                           tb10x_defconfig
powerpc                      ppc44x_defconfig
mips                         tb0219_defconfig
mips                  maltasmvp_eva_defconfig
mips                     cu1000-neo_defconfig
powerpc                     rainier_defconfig
arm                           viper_defconfig
powerpc                     tqm5200_defconfig
powerpc                     sequoia_defconfig
c6x                              alldefconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
m68k                         apollo_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
sh                           se7751_defconfig
arm                            mmp2_defconfig
powerpc                       holly_defconfig
arm                           h5000_defconfig
sh                            migor_defconfig
mips                        bcm63xx_defconfig
powerpc                    socrates_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
arm                           tegra_defconfig
riscv                             allnoconfig
m68k                             alldefconfig
mips                         bigsur_defconfig
arm                        vexpress_defconfig
arm                          pxa168_defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc8540_ads_defconfig
sh                             shx3_defconfig
powerpc                      pmac32_defconfig
mips                          ath79_defconfig
arm                             mxs_defconfig
powerpc                      ppc40x_defconfig
powerpc                     mpc83xx_defconfig
m68k                        m5272c3_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
