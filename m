Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1206B2638CC
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIWDG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 18:03:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:30351 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgIIWDF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 18:03:05 -0400
IronPort-SDR: S+iSTT4GiYEXbtHDJ6hy/VhXiFYZ3yeA8Thv22LcHa3FN1d1oxCfHyH7QYQYx5pbiJJtNSUW9C
 aKwfhlLE892Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="158460271"
X-IronPort-AV: E=Sophos;i="5.76,410,1592895600"; 
   d="scan'208";a="158460271"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 15:03:04 -0700
IronPort-SDR: vUbBv55lHggx4sVOEZki69/hWHL4a4xRTcrXCFBW3RmFOGDpsRl1/bEJo7GMph25CDrMNT3THS
 k03vKoJR8gqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,410,1592895600"; 
   d="scan'208";a="304653694"
Received: from lkp-server01.sh.intel.com (HELO 12ff3cf3f2e9) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Sep 2020 15:03:02 -0700
Received: from kbuild by 12ff3cf3f2e9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kG8BC-0000br-8V; Wed, 09 Sep 2020 22:03:02 +0000
Date:   Thu, 10 Sep 2020 06:02:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 0dc0b5c29be240e4d0b6e1cb31be39116cd237b2
Message-ID: <5f5950f6.X+NWD7oIOtl7H4HR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 0dc0b5c29be240e4d0b6e1cb31be39116cd237b2  rtlwifi: switch from 'pci_' to 'dma_' API

elapsed time: 723m

configs tested: 162
configs skipped: 17

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             mxs_defconfig
arm                            zeus_defconfig
powerpc                 linkstation_defconfig
sparc64                             defconfig
h8300                       h8s-sim_defconfig
mips                      fuloong2e_defconfig
sh                         apsh4a3a_defconfig
arm                      footbridge_defconfig
sh                         ecovec24_defconfig
mips                malta_kvm_guest_defconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
powerpc                     powernv_defconfig
powerpc                      mgcoge_defconfig
arm                        neponset_defconfig
m68k                        stmark2_defconfig
sh                          sdk7786_defconfig
sh                         microdev_defconfig
arm                       cns3420vb_defconfig
alpha                               defconfig
powerpc64                        alldefconfig
sh                        sh7757lcr_defconfig
mips                      loongson3_defconfig
arm                          lpd270_defconfig
mips                         cobalt_defconfig
sh                     magicpanelr2_defconfig
arm                       mainstone_defconfig
mips                           mtx1_defconfig
sh                          r7785rp_defconfig
arc                           tb10x_defconfig
arm                        spear3xx_defconfig
arm                           sama5_defconfig
arm                       netwinder_defconfig
microblaze                      mmu_defconfig
sh                           se7721_defconfig
mips                  cavium_octeon_defconfig
mips                            gpr_defconfig
sh                          lboxre2_defconfig
m68k                            q40_defconfig
x86_64                           alldefconfig
powerpc                     mpc83xx_defconfig
arm                  colibri_pxa270_defconfig
mips                        nlm_xlp_defconfig
arm                         lpc18xx_defconfig
mips                           jazz_defconfig
m68k                       m5249evb_defconfig
parisc                generic-32bit_defconfig
arm                         assabet_defconfig
arm                            dove_defconfig
arc                          axs101_defconfig
mips                       bmips_be_defconfig
m68k                           sun3_defconfig
powerpc                     mpc512x_defconfig
s390                             allyesconfig
arm                        cerfcube_defconfig
sh                             shx3_defconfig
arm                         cm_x300_defconfig
sh                ecovec24-romimage_defconfig
csky                                defconfig
i386                                defconfig
arm                    vt8500_v6_v7_defconfig
arm                  colibri_pxa300_defconfig
xtensa                generic_kc705_defconfig
arm                         s3c2410_defconfig
um                            kunit_defconfig
sh                          polaris_defconfig
m68k                        mvme16x_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
arm                        shmobile_defconfig
arm64                            alldefconfig
mips                           rs90_defconfig
mips                          ath25_defconfig
nios2                         3c120_defconfig
arm                       aspeed_g5_defconfig
arm                        clps711x_defconfig
arc                        vdk_hs38_defconfig
openrisc                         alldefconfig
sh                         ap325rxa_defconfig
arm                        mvebu_v7_defconfig
arm                       spear13xx_defconfig
arm                          collie_defconfig
sh                           se7750_defconfig
arm                         hackkit_defconfig
arm                          gemini_defconfig
arm                          ixp4xx_defconfig
h8300                            allyesconfig
sh                 kfr2r09-romimage_defconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
sh                          landisk_defconfig
arc                     haps_hs_smp_defconfig
arm                           tegra_defconfig
sh                           se7206_defconfig
xtensa                    xip_kc705_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20200909
x86_64               randconfig-a006-20200909
x86_64               randconfig-a003-20200909
x86_64               randconfig-a001-20200909
x86_64               randconfig-a005-20200909
x86_64               randconfig-a002-20200909
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
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
x86_64               randconfig-a016-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909
x86_64               randconfig-a013-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
