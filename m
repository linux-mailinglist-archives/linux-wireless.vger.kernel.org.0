Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2068364F66
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 02:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhDTAUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 20:20:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:39276 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhDTAUI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 20:20:08 -0400
IronPort-SDR: oQJbyC3VI8HhqVMqyGa2G6NQDPVctirrTwTop8DH6YFaWKmMQnQ1XI62A8lPlEnYuJI3Uzrvno
 rEBkSVYZzVfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="256730430"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="256730430"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 17:19:36 -0700
IronPort-SDR: bhb18dkjvywh9U31JhkSA/8s9eTHZUTMg84itWTsk1+Pv5/PdudAGgh+p8OmQvfXDfboZpzSDO
 JwHvpIayCdwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="426705018"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Apr 2021 17:19:34 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYe74-0001zR-7C; Tue, 20 Apr 2021 00:19:34 +0000
Date:   Tue, 20 Apr 2021 08:19:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 010bfbe768f7ecc876ffba92db30432de4997e2a
Message-ID: <607e1dff.sdxLYQjh+hF28z7P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 010bfbe768f7ecc876ffba92db30432de4997e2a  cfg80211: scan: drop entry from hidden_list on overflow

elapsed time: 725m

configs tested: 160
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                      chrp32_defconfig
arm                        mvebu_v5_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     mpc5200_defconfig
m68k                          atari_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     kmeter1_defconfig
openrisc                 simple_smp_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           xway_defconfig
sh                             espt_defconfig
sparc64                          alldefconfig
arm                        realview_defconfig
powerpc                     pseries_defconfig
arm                      pxa255-idp_defconfig
arm                       versatile_defconfig
arm                       multi_v4t_defconfig
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
nds32                             allnoconfig
mips                      pic32mzda_defconfig
xtensa                           allyesconfig
sh                          urquell_defconfig
arc                     haps_hs_smp_defconfig
sh                      rts7751r2d1_defconfig
xtensa                         virt_defconfig
arm                            mmp2_defconfig
arm                           omap1_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                     davinci_all_defconfig
h8300                     edosk2674_defconfig
mips                          ath79_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc834x_itx_defconfig
xtensa                    smp_lx200_defconfig
arm                        mini2440_defconfig
arm                        neponset_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                           se7750_defconfig
sh                         apsh4a3a_defconfig
sparc                       sparc32_defconfig
um                               alldefconfig
m68k                        m5272c3_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc832x_rdb_defconfig
sparc                       sparc64_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            hp6xx_defconfig
alpha                            alldefconfig
arm                            lart_defconfig
powerpc                          g5_defconfig
powerpc                      bamboo_defconfig
mips                        nlm_xlr_defconfig
nds32                               defconfig
arm                           h3600_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
powerpc                     kilauea_defconfig
sparc                               defconfig
powerpc                      ppc64e_defconfig
powerpc                         wii_defconfig
mips                            e55_defconfig
arm                         hackkit_defconfig
powerpc                      ep88xc_defconfig
powerpc                     ep8248e_defconfig
xtensa                       common_defconfig
h8300                               defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
m68k                        m5407c3_defconfig
powerpc                       ppc64_defconfig
ia64                             allmodconfig
powerpc                 xes_mpc85xx_defconfig
ia64                                defconfig
powerpc                      katmai_defconfig
sh                          rsk7201_defconfig
mips                         mpc30x_defconfig
riscv                    nommu_virt_defconfig
mips                      maltaaprp_defconfig
arm                        spear3xx_defconfig
powerpc                      pcm030_defconfig
powerpc                    klondike_defconfig
powerpc                      arches_defconfig
m68k                         amcore_defconfig
arc                              alldefconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210419
x86_64               randconfig-a001-20210419
x86_64               randconfig-a005-20210419
x86_64               randconfig-a002-20210419
x86_64               randconfig-a006-20210419
x86_64               randconfig-a004-20210419
i386                 randconfig-a003-20210419
i386                 randconfig-a001-20210419
i386                 randconfig-a006-20210419
i386                 randconfig-a005-20210419
i386                 randconfig-a004-20210419
i386                 randconfig-a002-20210419
i386                 randconfig-a015-20210419
i386                 randconfig-a013-20210419
i386                 randconfig-a014-20210419
i386                 randconfig-a016-20210419
i386                 randconfig-a012-20210419
i386                 randconfig-a011-20210419
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210419
x86_64               randconfig-a015-20210419
x86_64               randconfig-a013-20210419
x86_64               randconfig-a011-20210419
x86_64               randconfig-a012-20210419
x86_64               randconfig-a016-20210419

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
