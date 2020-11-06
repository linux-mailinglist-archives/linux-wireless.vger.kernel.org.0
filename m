Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2D2A8C0A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 02:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbgKFBYQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 20:24:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:44218 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbgKFBYQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 20:24:16 -0500
IronPort-SDR: PqE6lGA8L9HokR5rRk/6ofmJZMTSqgrHpzohVda/yNl6Ds6QZQjIGBROLZCArI0DNQBizg4JFT
 HLLJfKiXfPaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="169597125"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="169597125"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 17:24:15 -0800
IronPort-SDR: 8q+/Aq2CEjDkwj33LPLI2BSgfLETD7TNjP4KruZ7eIdje+Ki425FSGydDS/D+DpKaYeS3fVv2K
 C+uXTvG9Zlng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="354520094"
Received: from lkp-server01.sh.intel.com (HELO a340e641b702) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2020 17:24:13 -0800
Received: from kbuild by a340e641b702 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kaqU9-0000Fh-A7; Fri, 06 Nov 2020 01:24:13 +0000
Date:   Fri, 06 Nov 2020 09:23:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 2aaf09a0e7842b3ac7be6e0b8fb1888b3daeb3b3
Message-ID: <5fa4a59b.nfVWlXNF5DJ0VXn1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 2aaf09a0e7842b3ac7be6e0b8fb1888b3daeb3b3  r8169: work around short packet hw bug on RTL8125

elapsed time: 1412m

configs tested: 192
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
sh                          rsk7269_defconfig
sh                        sh7763rdp_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
arm                           viper_defconfig
sh                         microdev_defconfig
c6x                              alldefconfig
sh                            migor_defconfig
arm                          pxa168_defconfig
arm                      integrator_defconfig
sh                        sh7785lcr_defconfig
sh                           se7705_defconfig
openrisc                         alldefconfig
powerpc                    amigaone_defconfig
arm                         mv78xx0_defconfig
powerpc                      makalu_defconfig
s390                       zfcpdump_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc832x_rdb_defconfig
parisc                generic-32bit_defconfig
sh                   secureedge5410_defconfig
arm                      pxa255-idp_defconfig
arm                          tango4_defconfig
nios2                         3c120_defconfig
sh                          r7780mp_defconfig
sparc                               defconfig
powerpc                     ep8248e_defconfig
powerpc                   lite5200b_defconfig
powerpc                 mpc834x_itx_defconfig
c6x                                 defconfig
mips                       bmips_be_defconfig
sparc                       sparc32_defconfig
sh                           se7724_defconfig
mips                        nlm_xlr_defconfig
arm                  colibri_pxa270_defconfig
mips                       lemote2f_defconfig
s390                             allyesconfig
ia64                                defconfig
mips                       capcella_defconfig
mips                       rbtx49xx_defconfig
arc                              alldefconfig
um                            kunit_defconfig
powerpc                    ge_imp3a_defconfig
openrisc                            defconfig
mips                     loongson1c_defconfig
arm                        multi_v5_defconfig
arc                            hsdk_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                malta_kvm_guest_defconfig
sh                          rsk7264_defconfig
arm                          lpd270_defconfig
powerpc                           allnoconfig
i386                             allyesconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
parisc                generic-64bit_defconfig
powerpc                     tqm8555_defconfig
arm                         hackkit_defconfig
arc                     haps_hs_smp_defconfig
riscv                            alldefconfig
arm                         s3c2410_defconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                       holly_defconfig
arm                        mvebu_v7_defconfig
mips                        bcm47xx_defconfig
mips                            gpr_defconfig
powerpc                         ps3_defconfig
m68k                            mac_defconfig
arm                             pxa_defconfig
xtensa                         virt_defconfig
c6x                        evmc6678_defconfig
sh                        apsh4ad0a_defconfig
mips                           ip22_defconfig
arm                     davinci_all_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
arm                            hisi_defconfig
arm                          badge4_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  audio_kc705_defconfig
arm                        multi_v7_defconfig
mips                      maltaaprp_defconfig
arm                          moxart_defconfig
m68k                             allmodconfig
arc                           tb10x_defconfig
arm                         orion5x_defconfig
nds32                            alldefconfig
mips                         rt305x_defconfig
mips                           ip27_defconfig
powerpc                     sequoia_defconfig
sh                         ecovec24_defconfig
c6x                        evmc6457_defconfig
arm                      footbridge_defconfig
powerpc                     kmeter1_defconfig
mips                      malta_kvm_defconfig
powerpc                      ppc44x_defconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20201105
x86_64               randconfig-a003-20201105
x86_64               randconfig-a005-20201105
x86_64               randconfig-a002-20201105
x86_64               randconfig-a006-20201105
x86_64               randconfig-a001-20201105
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
i386                 randconfig-a015-20201105
i386                 randconfig-a013-20201105
i386                 randconfig-a014-20201105
i386                 randconfig-a016-20201105
i386                 randconfig-a011-20201105
i386                 randconfig-a012-20201105
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
