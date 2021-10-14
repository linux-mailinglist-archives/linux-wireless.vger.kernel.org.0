Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4580E42D15B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Oct 2021 06:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhJNEI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Oct 2021 00:08:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:52210 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhJNEI5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Oct 2021 00:08:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227491344"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="227491344"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 21:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="491770920"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2021 21:06:51 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mas15-0005YH-67; Thu, 14 Oct 2021 04:06:51 +0000
Date:   Thu, 14 Oct 2021 12:06:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 ff1cc2fa3055ee4c83839f38b74b4ee370a2291c
Message-ID: <6167acd7.O57non1MJ+DbC8+L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: ff1cc2fa3055ee4c83839f38b74b4ee370a2291c  wireless: Remove redundant 'flush_workqueue()' calls

elapsed time: 1244m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211013
powerpc                          allyesconfig
mips                           jazz_defconfig
arm                          iop32x_defconfig
um                                  defconfig
sh                           se7721_defconfig
arm                            mmp2_defconfig
powerpc                  storcenter_defconfig
arm                         lpc32xx_defconfig
um                               alldefconfig
arm                        multi_v7_defconfig
arm                       omap2plus_defconfig
mips                        bcm47xx_defconfig
arm                        multi_v5_defconfig
sh                             shx3_defconfig
arm                      jornada720_defconfig
h8300                            allyesconfig
sh                             sh03_defconfig
powerpc                     asp8347_defconfig
riscv                    nommu_virt_defconfig
powerpc                      ppc6xx_defconfig
xtensa                  audio_kc705_defconfig
arm                     eseries_pxa_defconfig
arc                      axs103_smp_defconfig
arm                        mvebu_v7_defconfig
sh                     magicpanelr2_defconfig
arm                         nhk8815_defconfig
m68k                       m5208evb_defconfig
arm                        vexpress_defconfig
xtensa                       common_defconfig
sh                            migor_defconfig
powerpc64                        alldefconfig
mips                           xway_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
powerpc                 mpc837x_mds_defconfig
parisc                generic-32bit_defconfig
powerpc                       eiger_defconfig
mips                            e55_defconfig
ia64                             alldefconfig
sh                        edosk7760_defconfig
arm                             mxs_defconfig
mips                      maltasmvp_defconfig
mips                   sb1250_swarm_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm5200_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                        icon_defconfig
mips                           gcw0_defconfig
powerpc                     kilauea_defconfig
arm                         axm55xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pasemi_defconfig
mips                malta_qemu_32r6_defconfig
arm                         vf610m4_defconfig
arc                          axs103_defconfig
s390                          debug_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                  randconfig-c002-20211013
x86_64               randconfig-c001-20211013
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20211013
x86_64               randconfig-a012-20211013
x86_64               randconfig-a016-20211013
x86_64               randconfig-a014-20211013
x86_64               randconfig-a013-20211013
x86_64               randconfig-a011-20211013
i386                 randconfig-a016-20211013
i386                 randconfig-a014-20211013
i386                 randconfig-a011-20211013
i386                 randconfig-a015-20211013
i386                 randconfig-a012-20211013
i386                 randconfig-a013-20211013
arc                  randconfig-r043-20211012
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20211013
x86_64               randconfig-a006-20211013
x86_64               randconfig-a001-20211013
x86_64               randconfig-a005-20211013
x86_64               randconfig-a002-20211013
x86_64               randconfig-a003-20211013
i386                 randconfig-a001-20211013
i386                 randconfig-a003-20211013
i386                 randconfig-a004-20211013
i386                 randconfig-a005-20211013
i386                 randconfig-a002-20211013
i386                 randconfig-a006-20211013
hexagon              randconfig-r041-20211013
hexagon              randconfig-r045-20211013
hexagon              randconfig-r041-20211012
s390                 randconfig-r044-20211012
riscv                randconfig-r042-20211012
hexagon              randconfig-r045-20211012

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
