Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7674D274901
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Sep 2020 21:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIVTXU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Sep 2020 15:23:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:41034 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVTXU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Sep 2020 15:23:20 -0400
IronPort-SDR: 6TpHvGskWC16m7qDsV6OAyKMyBBtW8Eeu5rXhfe2i/blYyymVYQbkfuiLpEf1scl+HGqiwlJ36
 nCx7IpmfZmEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="222286198"
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="222286198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 12:23:17 -0700
IronPort-SDR: j13qr0EvUMqz4h8n3+6YMoYBBw9wwLhKSLh81cVpthqZR6EtdEDO72r2vowfBzOlQmc4tlfiaz
 hNLiX8d9enaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,291,1596524400"; 
   d="scan'208";a="305067186"
Received: from lkp-server01.sh.intel.com (HELO 928d8e596b58) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2020 12:23:15 -0700
Received: from kbuild by 928d8e596b58 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kKnsh-0000cW-3g; Tue, 22 Sep 2020 19:23:15 +0000
Date:   Wed, 23 Sep 2020 03:23:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 dd7a3a331f5dec4f61fa2ba48512125a89401c25
Message-ID: <5f6a4f1c.2xVKPuo/bf4JEWVM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: dd7a3a331f5dec4f61fa2ba48512125a89401c25  rtlwifi: rtl8723be: use true,false for bool variable large_cfo_hit

elapsed time: 722m

configs tested: 179
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     eseries_pxa_defconfig
arm                            xcep_defconfig
mips                 decstation_r4k_defconfig
arc                     nsimosci_hs_defconfig
xtensa                         virt_defconfig
powerpc                     asp8347_defconfig
arc                        nsim_700_defconfig
arm                        vexpress_defconfig
arm                       spear13xx_defconfig
arm                  colibri_pxa300_defconfig
arm                          pxa3xx_defconfig
um                           x86_64_defconfig
m68k                         amcore_defconfig
arm                       versatile_defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
arm                      tct_hammer_defconfig
arc                            hsdk_defconfig
xtensa                          iss_defconfig
parisc                           alldefconfig
powerpc                      mgcoge_defconfig
arm                         palmz72_defconfig
arm                          pxa168_defconfig
powerpc                     kilauea_defconfig
arm                           sunxi_defconfig
sh                      rts7751r2d1_defconfig
sh                          sdk7786_defconfig
mips                          rb532_defconfig
arm                         lpc32xx_defconfig
mips                            e55_defconfig
um                            kunit_defconfig
powerpc                  mpc866_ads_defconfig
arm                        clps711x_defconfig
x86_64                              defconfig
ia64                            zx1_defconfig
powerpc                      tqm8xx_defconfig
sh                        edosk7760_defconfig
powerpc                      arches_defconfig
mips                      bmips_stb_defconfig
mips                       capcella_defconfig
powerpc                      makalu_defconfig
nios2                            alldefconfig
arm                            lart_defconfig
arm                         vf610m4_defconfig
sh                            shmin_defconfig
mips                        nlm_xlr_defconfig
arm                            mps2_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                      footbridge_defconfig
m68k                        mvme147_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
sh                            hp6xx_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7203_defconfig
arm                         s5pv210_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
powerpc                     tqm8540_defconfig
arm                          pxa910_defconfig
m68k                             alldefconfig
arm                            pleb_defconfig
c6x                        evmc6474_defconfig
m68k                          atari_defconfig
powerpc                     ksi8560_defconfig
arm                          lpd270_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
powerpc                      acadia_defconfig
mips                       bmips_be_defconfig
powerpc                     tqm8548_defconfig
sh                            titan_defconfig
m68k                          multi_defconfig
arc                          axs103_defconfig
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
x86_64               randconfig-a005-20200920
x86_64               randconfig-a003-20200920
x86_64               randconfig-a004-20200920
x86_64               randconfig-a002-20200920
x86_64               randconfig-a006-20200920
x86_64               randconfig-a001-20200920
i386                 randconfig-a002-20200920
i386                 randconfig-a006-20200920
i386                 randconfig-a003-20200920
i386                 randconfig-a004-20200920
i386                 randconfig-a005-20200920
i386                 randconfig-a001-20200920
i386                 randconfig-a002-20200921
i386                 randconfig-a006-20200921
i386                 randconfig-a003-20200921
i386                 randconfig-a004-20200921
i386                 randconfig-a005-20200921
i386                 randconfig-a001-20200921
i386                 randconfig-a002-20200922
i386                 randconfig-a006-20200922
i386                 randconfig-a003-20200922
i386                 randconfig-a004-20200922
i386                 randconfig-a005-20200922
i386                 randconfig-a001-20200922
x86_64               randconfig-a011-20200921
x86_64               randconfig-a013-20200921
x86_64               randconfig-a014-20200921
x86_64               randconfig-a015-20200921
x86_64               randconfig-a012-20200921
x86_64               randconfig-a016-20200921
i386                 randconfig-a012-20200921
i386                 randconfig-a014-20200921
i386                 randconfig-a016-20200921
i386                 randconfig-a013-20200921
i386                 randconfig-a011-20200921
i386                 randconfig-a015-20200921
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200921
x86_64               randconfig-a003-20200921
x86_64               randconfig-a004-20200921
x86_64               randconfig-a002-20200921
x86_64               randconfig-a006-20200921
x86_64               randconfig-a001-20200921
x86_64               randconfig-a011-20200922
x86_64               randconfig-a013-20200922
x86_64               randconfig-a014-20200922
x86_64               randconfig-a015-20200922
x86_64               randconfig-a012-20200922
x86_64               randconfig-a016-20200922
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
