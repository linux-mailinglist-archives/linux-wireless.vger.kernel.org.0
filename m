Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D927D842
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 22:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgI2Ude (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 16:33:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:33950 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2Ude (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 16:33:34 -0400
IronPort-SDR: KEg40mqVJ8qp7o/ugwCQtDT87k9zBvIkfsbxGM8JIMxwnk3Rpeitdob7r8M2dyZWynC5GJW+30
 kycxCnVHjhBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="162344760"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="162344760"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 13:33:31 -0700
IronPort-SDR: fuMFn/40D7LW2+AnXcdyjAtxmb4AKOvh1QrP8aMonnLWu/YcB+x3eRsl/DSSUQ8eeR1dp5hSm3
 rP7Y43YYUfiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="312343463"
Received: from lkp-server02.sh.intel.com (HELO 10ae44db8633) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Sep 2020 13:33:30 -0700
Received: from kbuild by 10ae44db8633 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNMJV-0000IA-In; Tue, 29 Sep 2020 20:33:29 +0000
Date:   Wed, 30 Sep 2020 04:33:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 1d2a85382282e7c77cbde5650335c3ffc6073fa1
Message-ID: <5f739a13.ZpXTbgS3xRYc5TjT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 1d2a85382282e7c77cbde5650335c3ffc6073fa1  wl3501_cs: Remove unnecessary NULL check

elapsed time: 723m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
arc                      axs103_smp_defconfig
arc                         haps_hs_defconfig
arm                         orion5x_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                           alldefconfig
mips                          ath79_defconfig
sh                        sh7757lcr_defconfig
arm                    vt8500_v6_v7_defconfig
m68k                        m5407c3_defconfig
mips                         db1xxx_defconfig
powerpc                      cm5200_defconfig
arm                        keystone_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        mvebu_v7_defconfig
arm                        spear3xx_defconfig
s390                       zfcpdump_defconfig
ia64                        generic_defconfig
mips                      pistachio_defconfig
ia64                            zx1_defconfig
arm                           efm32_defconfig
arm                         cm_x300_defconfig
powerpc64                           defconfig
sh                         apsh4a3a_defconfig
um                             i386_defconfig
arm                             ezx_defconfig
powerpc                      pasemi_defconfig
powerpc                     sequoia_defconfig
mips                           ip32_defconfig
powerpc                  mpc866_ads_defconfig
nios2                         3c120_defconfig
powerpc                 mpc832x_mds_defconfig
mips                             allmodconfig
powerpc                  mpc885_ads_defconfig
arm                             pxa_defconfig
sh                           se7722_defconfig
riscv                    nommu_virt_defconfig
mips                      loongson3_defconfig
arm                       spear13xx_defconfig
powerpc                     tqm8541_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc8560_ads_defconfig
s390                                defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                           sama5_defconfig
arc                             nps_defconfig
arm                          exynos_defconfig
um                            kunit_defconfig
arm                          gemini_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                        fsp2_defconfig
arm                           sunxi_defconfig
sh                           se7206_defconfig
powerpc                      katmai_defconfig
powerpc                     tqm8560_defconfig
microblaze                    nommu_defconfig
arc                        vdk_hs38_defconfig
powerpc                     akebono_defconfig
c6x                        evmc6457_defconfig
ia64                      gensparse_defconfig
powerpc                     ppa8548_defconfig
powerpc                    socrates_defconfig
arm                              zx_defconfig
c6x                         dsk6455_defconfig
powerpc                      ppc6xx_defconfig
arm                      pxa255-idp_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc836x_mds_defconfig
sh                   sh7770_generic_defconfig
arm                          ep93xx_defconfig
arm                           h5000_defconfig
sh                           se7780_defconfig
parisc                           alldefconfig
arm                             mxs_defconfig
mips                            gpr_defconfig
c6x                        evmc6474_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                       aspeed_g5_defconfig
sparc                            alldefconfig
sh                         ecovec24_defconfig
riscv                          rv32_defconfig
mips                        bcm63xx_defconfig
arm                         hackkit_defconfig
sh                   sh7724_generic_defconfig
powerpc64                        alldefconfig
arm                            mps2_defconfig
mips                       capcella_defconfig
powerpc                     mpc83xx_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
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
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200929
i386                 randconfig-a002-20200929
i386                 randconfig-a003-20200929
i386                 randconfig-a004-20200929
i386                 randconfig-a005-20200929
i386                 randconfig-a001-20200929
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
i386                 randconfig-a012-20200929
i386                 randconfig-a016-20200929
i386                 randconfig-a014-20200929
i386                 randconfig-a013-20200929
i386                 randconfig-a015-20200929
i386                 randconfig-a011-20200929
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
