Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CEC475834
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 12:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242219AbhLOLyA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 06:54:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:62413 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231334AbhLOLyA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 06:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639569240; x=1671105240;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zOF975cIys87Fw3ViQmrt/F1uZJFAWVeQDnLIi0xbBs=;
  b=Ypob3FQmoLzM09JmXlKQ9c4waxdRZqQeFvkFNyx7awcqLEKnMnBRTZbK
   CwN5M+QZkb8NsoL4QEdhThNljIvp7xLS0cwslObaLBDcVggNv/DaYqHHf
   qUuz/S4ey5NnllWELf+y152oGo+dfPDyUJZAHI5KUKhh3Txoz0djZ/QV+
   m8CF2k6hvAKW3pflMxaKCEfztevEGqXU4/R1a1JZAxv7BKfW91EIaJeAd
   Tbltgt2KY/EhHM1kL3r06Sqa4yP7coZsKoYIzRxuvWBayyt8jk9RDHJYJ
   T+1Vi7x1/4DhkCUst59r86ud18yZtFYPLYFazhY2/kszHa+yWdzbhp/dZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="263359511"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="263359511"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 03:54:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="505766817"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Dec 2021 03:53:58 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxSr7-0001hJ-Uh; Wed, 15 Dec 2021 11:53:57 +0000
Date:   Wed, 15 Dec 2021 19:53:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 09ed8bfc5215ad5aac91c50008277b5586b9ef24
Message-ID: <61b9d72a.JytrY+2aTa8Ldqd/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 09ed8bfc5215ad5aac91c50008277b5586b9ef24  wilc1000: Rename workqueue from "WILC_wq" to "NETDEV-wq"

elapsed time: 723m

configs tested: 193
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211214
mips                 randconfig-c004-20211214
sh                 kfr2r09-romimage_defconfig
xtensa                    xip_kc705_defconfig
powerpc                    klondike_defconfig
arm                      tct_hammer_defconfig
m68k                          amiga_defconfig
arm                          pcm027_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc32xx_defconfig
powerpc                      tqm8xx_defconfig
arm                          gemini_defconfig
csky                             alldefconfig
arm                        cerfcube_defconfig
powerpc                        cell_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
arm                             mxs_defconfig
nds32                             allnoconfig
powerpc                      pasemi_defconfig
powerpc                    gamecube_defconfig
powerpc64                        alldefconfig
s390                                defconfig
mips                  cavium_octeon_defconfig
arm                     eseries_pxa_defconfig
arm                      footbridge_defconfig
arm                          pxa168_defconfig
riscv                            allmodconfig
powerpc                          allyesconfig
m68k                          sun3x_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
powerpc                   lite5200b_defconfig
powerpc                      acadia_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc85xx_cds_defconfig
um                             i386_defconfig
powerpc                        fsp2_defconfig
mips                         mpc30x_defconfig
arm                            dove_defconfig
arm                        oxnas_v6_defconfig
sh                          polaris_defconfig
mips                     loongson2k_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         hackkit_defconfig
mips                      malta_kvm_defconfig
mips                           ci20_defconfig
sh                          r7780mp_defconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      makalu_defconfig
arm                      jornada720_defconfig
sh                          urquell_defconfig
arm                           sama5_defconfig
mips                            ar7_defconfig
arm                       aspeed_g5_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                          lpd270_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
sparc                               defconfig
sh                         microdev_defconfig
powerpc                     stx_gp3_defconfig
i386                             alldefconfig
mips                      bmips_stb_defconfig
mips                           rs90_defconfig
mips                    maltaup_xpa_defconfig
sparc                       sparc32_defconfig
h8300                               defconfig
sh                      rts7751r2d1_defconfig
openrisc                            defconfig
powerpc                       ppc64_defconfig
powerpc                      pmac32_defconfig
m68k                             alldefconfig
arm                            qcom_defconfig
sh                           se7724_defconfig
sparc64                             defconfig
h8300                    h8300h-sim_defconfig
arm                         socfpga_defconfig
powerpc                      bamboo_defconfig
ia64                         bigsur_defconfig
arm                        multi_v5_defconfig
mips                        workpad_defconfig
mips                           jazz_defconfig
arm                            mmp2_defconfig
arm                         s3c2410_defconfig
arm                        shmobile_defconfig
arm                        magician_defconfig
sh                                  defconfig
powerpc                    mvme5100_defconfig
arm                          moxart_defconfig
sparc                            alldefconfig
powerpc                     pseries_defconfig
arm                      pxa255-idp_defconfig
m68k                       bvme6000_defconfig
powerpc                          g5_defconfig
arm                           sama7_defconfig
arm                  randconfig-c002-20211214
arm                  randconfig-c002-20211215
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a011-20211215
x86_64               randconfig-a014-20211215
x86_64               randconfig-a012-20211215
x86_64               randconfig-a013-20211215
x86_64               randconfig-a016-20211215
x86_64               randconfig-a015-20211215
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211214
x86_64               randconfig-c007-20211214
riscv                randconfig-c006-20211214
mips                 randconfig-c004-20211214
i386                 randconfig-c001-20211214
s390                 randconfig-c005-20211214
powerpc              randconfig-c003-20211214
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
i386                 randconfig-a013-20211214
i386                 randconfig-a011-20211214
i386                 randconfig-a016-20211214
i386                 randconfig-a014-20211214
i386                 randconfig-a015-20211214
i386                 randconfig-a012-20211214
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214
hexagon              randconfig-r045-20211215
hexagon              randconfig-r041-20211215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
