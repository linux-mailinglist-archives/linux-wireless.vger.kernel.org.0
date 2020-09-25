Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B38277FF6
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 07:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgIYFf3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 01:35:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:37079 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgIYFf3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 01:35:29 -0400
IronPort-SDR: ClirygaU4NIscNQr2Z7FSjbXkyZQl3uC60SNSpB2KVnvLm3a304dLUp+o/8htlloPrMhNIiE4B
 JY+R/K1VpKrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="158825509"
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="158825509"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 22:35:29 -0700
IronPort-SDR: Wl/nxOtvQr0KaqwTlydi/NdYGrDuKHZ1Ts7mktEt5ZE1K78IW9zNfBIyCRQMKSbq6snGgmdcjd
 R1qUYWBphU5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,300,1596524400"; 
   d="scan'208";a="487317227"
Received: from lkp-server01.sh.intel.com (HELO bb5857c652c6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Sep 2020 22:35:28 -0700
Received: from kbuild by bb5857c652c6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kLgOF-00002j-FM; Fri, 25 Sep 2020 05:35:27 +0000
Date:   Fri, 25 Sep 2020 13:34:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 5b365af4c86d1229fcb5a8683fb3284498c37606
Message-ID: <5f6d8169.YqgVINzMsxxcOiJX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 5b365af4c86d1229fcb5a8683fb3284498c37606  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 762m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  maltasmvp_eva_defconfig
m68k                         apollo_defconfig
mips                      bmips_stb_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      tqm8xx_defconfig
arm                         bcm2835_defconfig
arm                           stm32_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arm                        clps711x_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
h8300                            alldefconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                   motionpro_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
m68k                        mvme16x_defconfig
powerpc                     sbc8548_defconfig
sh                             shx3_defconfig
arm                           efm32_defconfig
powerpc                     akebono_defconfig
sh                         apsh4a3a_defconfig
sh                           se7712_defconfig
sh                        sh7757lcr_defconfig
powerpc                    adder875_defconfig
arc                      axs103_smp_defconfig
m68k                          amiga_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8540_defconfig
sh                      rts7751r2d1_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
m68k                          hp300_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc837x_mds_defconfig
mips                        workpad_defconfig
powerpc                     ep8248e_defconfig
mips                       capcella_defconfig
riscv                          rv32_defconfig
powerpc                     ppa8548_defconfig
x86_64                              defconfig
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
i386                 randconfig-a002-20200924
i386                 randconfig-a006-20200924
i386                 randconfig-a003-20200924
i386                 randconfig-a004-20200924
i386                 randconfig-a005-20200924
i386                 randconfig-a001-20200924
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
i386                 randconfig-a002-20200925
i386                 randconfig-a006-20200925
i386                 randconfig-a003-20200925
i386                 randconfig-a004-20200925
i386                 randconfig-a005-20200925
i386                 randconfig-a001-20200925
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
