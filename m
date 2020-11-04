Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4140F2A702D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 23:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgKDWGX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 17:06:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:56817 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgKDWGX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 17:06:23 -0500
IronPort-SDR: NijfsYVMV+h/6N5L0tyzKA2Xlzz/LsVigFsL5ENkOD92QS9r/aXc81B4CVpbsbNFdkz0DDAXtY
 PD3aVP0xsnXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="254002630"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="254002630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 14:06:22 -0800
IronPort-SDR: IE41H8jPW7A4zokAp/vpWwtamob39i7euNZGiFaW9T2lYNLx2UIeKdRUDoFGjK7xk/SnBsDdKm
 abdU15Ul0OFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="354011001"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Nov 2020 14:06:20 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kaQv5-00016c-PU; Wed, 04 Nov 2020 22:06:19 +0000
Date:   Thu, 05 Nov 2020 06:05:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 fea07a487c6dd422dc8837237c9d2bc7c33119af
Message-ID: <5fa325b3.6XH7/EExJVqYZUYu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: fea07a487c6dd422dc8837237c9d2bc7c33119af  net: openvswitch: silence suspicious RCU usage warning

elapsed time: 1202m

configs tested: 202
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7206_defconfig
m68k                       bvme6000_defconfig
m68k                           sun3_defconfig
h8300                               defconfig
arm                        shmobile_defconfig
sh                           se7751_defconfig
arm                        vexpress_defconfig
mips                          ath25_defconfig
arm                            u300_defconfig
arm                           efm32_defconfig
arm                     davinci_all_defconfig
riscv                    nommu_k210_defconfig
sh                               alldefconfig
arm                          prima2_defconfig
powerpc                        fsp2_defconfig
arc                        vdk_hs38_defconfig
arm                          moxart_defconfig
arm                   milbeaut_m10v_defconfig
arm                        oxnas_v6_defconfig
sh                           se7705_defconfig
mips                           ip28_defconfig
m68k                       m5208evb_defconfig
sh                           se7712_defconfig
arm                        multi_v7_defconfig
sh                          rsk7269_defconfig
sh                   secureedge5410_defconfig
mips                        maltaup_defconfig
arm                      pxa255-idp_defconfig
arm                          tango4_defconfig
powerpc                   motionpro_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                                defconfig
m68k                       m5249evb_defconfig
arm                          pxa910_defconfig
openrisc                            defconfig
mips                         tb0226_defconfig
xtensa                              defconfig
mips                      malta_kvm_defconfig
sh                ecovec24-romimage_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v5_defconfig
powerpc                    sam440ep_defconfig
mips                         db1xxx_defconfig
arm                            pleb_defconfig
arm                        mvebu_v7_defconfig
sh                        sh7785lcr_defconfig
arm                        spear3xx_defconfig
sh                           se7722_defconfig
riscv                            allyesconfig
powerpc                      katmai_defconfig
sh                            hp6xx_defconfig
microblaze                      mmu_defconfig
mips                        vocore2_defconfig
powerpc                      cm5200_defconfig
arc                            hsdk_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc6xx_defconfig
arm                      integrator_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      tqm8xx_defconfig
mips                     cu1000-neo_defconfig
mips                           xway_defconfig
arm                          exynos_defconfig
mips                          ath79_defconfig
sh                          landisk_defconfig
m68k                          amiga_defconfig
arm                            mmp2_defconfig
powerpc                 canyonlands_defconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8555_defconfig
mips                malta_qemu_32r6_defconfig
arm                          ep93xx_defconfig
i386                             alldefconfig
powerpc                       holly_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
m68k                          hp300_defconfig
openrisc                         alldefconfig
mips                          malta_defconfig
powerpc                  storcenter_defconfig
arc                          axs103_defconfig
powerpc                      chrp32_defconfig
mips                  decstation_64_defconfig
ia64                      gensparse_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
powerpc                          allyesconfig
sh                          r7785rp_defconfig
powerpc                      ppc64e_defconfig
arm                          iop32x_defconfig
m68k                            mac_defconfig
powerpc                     taishan_defconfig
riscv                    nommu_virt_defconfig
sh                     sh7710voipgw_defconfig
arm                         orion5x_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
ia64                            zx1_defconfig
arm                              alldefconfig
mips                            ar7_defconfig
powerpc                        cell_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                  iss476-smp_defconfig
xtensa                generic_kc705_defconfig
arm                         lubbock_defconfig
arm                            mps2_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                             allmodconfig
arc                           tb10x_defconfig
arm                            zeus_defconfig
powerpc                     rainier_defconfig
arm                       cns3420vb_defconfig
ia64                             alldefconfig
mips                      maltaaprp_defconfig
ia64                        generic_defconfig
arm                         mv78xx0_defconfig
sh                            shmin_defconfig
m68k                          multi_defconfig
arm                     am200epdkit_defconfig
xtensa                          iss_defconfig
arm                           viper_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201104
i386                 randconfig-a006-20201104
i386                 randconfig-a005-20201104
i386                 randconfig-a001-20201104
i386                 randconfig-a002-20201104
i386                 randconfig-a003-20201104
i386                 randconfig-a004-20201105
i386                 randconfig-a006-20201105
i386                 randconfig-a005-20201105
i386                 randconfig-a001-20201105
i386                 randconfig-a002-20201105
i386                 randconfig-a003-20201105
x86_64               randconfig-a012-20201104
x86_64               randconfig-a015-20201104
x86_64               randconfig-a013-20201104
x86_64               randconfig-a011-20201104
x86_64               randconfig-a014-20201104
x86_64               randconfig-a016-20201104
i386                 randconfig-a015-20201104
i386                 randconfig-a013-20201104
i386                 randconfig-a014-20201104
i386                 randconfig-a016-20201104
i386                 randconfig-a011-20201104
i386                 randconfig-a012-20201104
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
x86_64               randconfig-a004-20201104
x86_64               randconfig-a003-20201104
x86_64               randconfig-a005-20201104
x86_64               randconfig-a002-20201104
x86_64               randconfig-a006-20201104
x86_64               randconfig-a001-20201104

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
