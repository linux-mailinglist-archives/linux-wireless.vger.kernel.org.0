Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AEB287F48
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgJHXwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 19:52:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:30201 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbgJHXwc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 19:52:32 -0400
IronPort-SDR: jB8H6q6/Nm1tilf4LRMe70IHHFHHWXn07J86Ob2c0uFQB5c5v83GKplHcPIL07hkXaQhNyuKou
 w7tX7OJF63KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="227069497"
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="227069497"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 16:52:30 -0700
IronPort-SDR: FqIToitaT79WJVxN7aaMxQucGtClgBlRcsLff7mwjjibpb0kFQubSGndBHCJltJGxx6yxDx+p/
 lZ6LSs6nuxbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="298264684"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2020 16:52:29 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQfi0-00001N-G5; Thu, 08 Oct 2020 23:52:28 +0000
Date:   Fri, 09 Oct 2020 07:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 ba6ff70a3bb76c1ff440d3a0044b82e97abb648f
Message-ID: <5f7fa61d.tDWZBHVL+aOHbLrU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git  master
branch HEAD: ba6ff70a3bb76c1ff440d3a0044b82e97abb648f  mac80211: copy configured beacon tx rate to driver

elapsed time: 722m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
mips                      bmips_stb_defconfig
arm                      footbridge_defconfig
sh                         ap325rxa_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        m5307c3_defconfig
arm                             mxs_defconfig
h8300                               defconfig
powerpc                         ps3_defconfig
sh                 kfr2r09-romimage_defconfig
arm                           h3600_defconfig
arm                          exynos_defconfig
powerpc                     mpc512x_defconfig
parisc                           allyesconfig
powerpc                       maple_defconfig
i386                             alldefconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     powernv_defconfig
powerpc                      mgcoge_defconfig
arm                             pxa_defconfig
mips                           mtx1_defconfig
mips                          malta_defconfig
powerpc                      pmac32_defconfig
c6x                              allyesconfig
arm                         assabet_defconfig
sparc                       sparc32_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
powerpc                      ppc44x_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5249evb_defconfig
xtensa                    smp_lx200_defconfig
arm                        keystone_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       aspeed_g5_defconfig
mips                     cu1000-neo_defconfig
sh                           se7619_defconfig
arm                         nhk8815_defconfig
arm                         bcm2835_defconfig
sh                             espt_defconfig
mips                      loongson3_defconfig
mips                           ip28_defconfig
arm                        shmobile_defconfig
powerpc                      arches_defconfig
powerpc                    gamecube_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ppa8548_defconfig
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
x86_64               randconfig-a004-20201008
x86_64               randconfig-a003-20201008
x86_64               randconfig-a005-20201008
x86_64               randconfig-a001-20201008
x86_64               randconfig-a002-20201008
x86_64               randconfig-a006-20201008
i386                 randconfig-a006-20201008
i386                 randconfig-a005-20201008
i386                 randconfig-a001-20201008
i386                 randconfig-a004-20201008
i386                 randconfig-a002-20201008
i386                 randconfig-a003-20201008
i386                 randconfig-a015-20201008
i386                 randconfig-a013-20201008
i386                 randconfig-a014-20201008
i386                 randconfig-a016-20201008
i386                 randconfig-a011-20201008
i386                 randconfig-a012-20201008
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
x86_64               randconfig-a012-20201008
x86_64               randconfig-a015-20201008
x86_64               randconfig-a013-20201008
x86_64               randconfig-a014-20201008
x86_64               randconfig-a011-20201008
x86_64               randconfig-a016-20201008

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
