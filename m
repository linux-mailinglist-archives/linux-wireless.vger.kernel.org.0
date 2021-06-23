Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38593B124F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jun 2021 05:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFWDl6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 23:41:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:47292 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhFWDl5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 23:41:57 -0400
IronPort-SDR: hkGYeqzSW7SPwF7b2UZXLp1U9ADHJJ12pgQBL4rKXJZ1Rp58qUH/HG9Y2NM32aUf1d3TCdc69y
 CAsKrxKVkE9A==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="271031368"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="271031368"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 20:39:40 -0700
IronPort-SDR: QWYZXsykJI48fGuOKqUaTUyH7vdvXWC7vZcsxlGdQ47NlVnsxNeWVLv9GLaA0i0DJc5gLO8h+9
 jtZ5GI2/kg4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="556830045"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2021 20:39:39 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvtjm-0005h4-FT; Wed, 23 Jun 2021 03:39:38 +0000
Date:   Wed, 23 Jun 2021 11:39:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 829eea7c94e0bac804e65975639a2f2e5f147033
Message-ID: <60d2acf4.P7kCZEO3KNrCFIrF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 829eea7c94e0bac804e65975639a2f2e5f147033  mt7601u: add USB device ID for some versions of XiaoDu WiFi Dongle.

elapsed time: 727m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           h3600_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      arches_defconfig
arm                             rpc_defconfig
arm                            lart_defconfig
powerpc                        fsp2_defconfig
sparc64                             defconfig
mips                         mpc30x_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   motionpro_defconfig
arc                        vdk_hs38_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm5200_defconfig
powerpc                    gamecube_defconfig
powerpc                    sam440ep_defconfig
sh                           se7705_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          malta_defconfig
xtensa                           alldefconfig
powerpc                      makalu_defconfig
h8300                     edosk2674_defconfig
sh                           se7724_defconfig
arc                           tb10x_defconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1830-neo_defconfig
powerpc                      acadia_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
arm                       netwinder_defconfig
um                            kunit_defconfig
sh                          polaris_defconfig
m68k                         apollo_defconfig
powerpc                      katmai_defconfig
h8300                            alldefconfig
um                           x86_64_defconfig
sh                          r7785rp_defconfig
mips                      bmips_stb_defconfig
sh                        edosk7705_defconfig
mips                   sb1250_swarm_defconfig
arm                            zeus_defconfig
mips                           mtx1_defconfig
arc                    vdk_hs38_smp_defconfig
mips                           ip28_defconfig
arm                     eseries_pxa_defconfig
powerpc                     ep8248e_defconfig
sh                   rts7751r2dplus_defconfig
sh                          kfr2r09_defconfig
mips                       rbtx49xx_defconfig
sh                           se7343_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                          atari_defconfig
powerpc                     tqm8555_defconfig
mips                         rt305x_defconfig
mips                           xway_defconfig
arm                        realview_defconfig
arm                      jornada720_defconfig
m68k                        mvme16x_defconfig
s390                             allmodconfig
riscv                               defconfig
sh                                  defconfig
arm                        mvebu_v5_defconfig
sh                   sh7770_generic_defconfig
powerpc                     kmeter1_defconfig
microblaze                          defconfig
arm                         orion5x_defconfig
arm                        shmobile_defconfig
sh                            titan_defconfig
mips                            gpr_defconfig
h8300                               defconfig
powerpc                     sequoia_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
