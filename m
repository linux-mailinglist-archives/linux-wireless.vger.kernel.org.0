Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43503ADBD5
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jun 2021 23:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhFSWAl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Jun 2021 18:00:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:41092 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFSWAk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Jun 2021 18:00:40 -0400
IronPort-SDR: Lp2v44rYcqd+Dbd2Ud7fe7TRf9QXefLx1K0a+x3wYKFAI9/+rQSUB5IR6eya8ucIKfx4q3ubbn
 GTT13yj1AnCg==
X-IronPort-AV: E=McAfee;i="6200,9189,10020"; a="206511059"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="206511059"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 14:58:29 -0700
IronPort-SDR: kjTQgXdHsumB28L/nRv0PinKv8+yA8t6raisvi6bTrlIM72YsCyBt2kTmX4uzblFqr9ElrckJH
 aug/OVSKd0MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="489466971"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jun 2021 14:58:28 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luiyx-0003nQ-HK; Sat, 19 Jun 2021 21:58:27 +0000
Date:   Sun, 20 Jun 2021 05:58:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 adf6a0f8c0a656df3d29403f314bf3e0dbb2dd77
Message-ID: <60ce6881.ycgEqDeMtxBZqD1d%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: adf6a0f8c0a656df3d29403f314bf3e0dbb2dd77  rtl8xxxu: avoid parsing short RX packet

elapsed time: 723m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
sh                          polaris_defconfig
x86_64                            allnoconfig
xtensa                       common_defconfig
arm                          pxa168_defconfig
powerpc                     tqm8555_defconfig
arm                     am200epdkit_defconfig
ia64                             allyesconfig
um                            kunit_defconfig
arm                         orion5x_defconfig
sh                        edosk7705_defconfig
sh                   sh7724_generic_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
arm                         palmz72_defconfig
sh                            hp6xx_defconfig
mips                     loongson2k_defconfig
mips                malta_qemu_32r6_defconfig
sh                   secureedge5410_defconfig
csky                                defconfig
powerpc                        cell_defconfig
powerpc                        fsp2_defconfig
arm                          badge4_defconfig
sh                           se7619_defconfig
powerpc                      pmac32_defconfig
arm                          pxa3xx_defconfig
powerpc                     tqm5200_defconfig
arm                           sunxi_defconfig
powerpc                           allnoconfig
sh                          urquell_defconfig
x86_64                           allyesconfig
arm                       imx_v6_v7_defconfig
mips                 decstation_r4k_defconfig
sh                           se7722_defconfig
arm                         s3c2410_defconfig
h8300                               defconfig
arm                          lpd270_defconfig
xtensa                           allyesconfig
arm                         shannon_defconfig
arc                                 defconfig
powerpc                     tqm8548_defconfig
arm                          imote2_defconfig
powerpc                   bluestone_defconfig
powerpc                        warp_defconfig
arm                         assabet_defconfig
mips                      loongson3_defconfig
powerpc                       maple_defconfig
powerpc                      ep88xc_defconfig
sparc                            alldefconfig
sh                           sh2007_defconfig
arm                        realview_defconfig
ia64                             alldefconfig
s390                                defconfig
mips                         db1xxx_defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
arm                       mainstone_defconfig
m68k                       m5475evb_defconfig
powerpc                         wii_defconfig
xtensa                              defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a002-20210618
i386                 randconfig-a006-20210618
i386                 randconfig-a004-20210618
i386                 randconfig-a001-20210618
i386                 randconfig-a005-20210618
i386                 randconfig-a003-20210618
x86_64               randconfig-a015-20210618
x86_64               randconfig-a011-20210618
x86_64               randconfig-a012-20210618
x86_64               randconfig-a014-20210618
x86_64               randconfig-a016-20210618
x86_64               randconfig-a013-20210618
i386                 randconfig-a015-20210618
i386                 randconfig-a016-20210618
i386                 randconfig-a013-20210618
i386                 randconfig-a014-20210618
i386                 randconfig-a012-20210618
i386                 randconfig-a011-20210618
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210620
x86_64               randconfig-b001-20210619
x86_64               randconfig-b001-20210618
x86_64               randconfig-a002-20210618
x86_64               randconfig-a001-20210618
x86_64               randconfig-a004-20210618
x86_64               randconfig-a003-20210618
x86_64               randconfig-a006-20210618
x86_64               randconfig-a005-20210618

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
