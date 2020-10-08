Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0697287F31
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 01:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbgJHXkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 19:40:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:12152 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730727AbgJHXkP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 19:40:15 -0400
IronPort-SDR: IkFNbrYra0Pw0AEWoyxbGWmMN0Hu8eQt8U8n+le6qvGtYMlcwvZ7rdW2VrE5IhZUpq1GPFW3HM
 zOiJ6EWQIqNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="161959299"
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="161959299"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 16:40:14 -0700
IronPort-SDR: oPJqgSobX35PSTwHmbm2AQCz6iDfLsjDHbCDSjwYuZrMoJbFjh+FSrbHiWHexE7/aqF2/6rISs
 XMgTFrWPrMNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="344893047"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 08 Oct 2020 16:40:13 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQfW8-00000q-HX; Thu, 08 Oct 2020 23:40:12 +0000
Date:   Fri, 09 Oct 2020 07:39:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 3dc289f8f139997f4e9d3cfccf8738f20d23e47b
Message-ID: <5f7fa33b.v0CghmLnoAfzOG3z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 3dc289f8f139997f4e9d3cfccf8738f20d23e47b  net: wireless: nl80211: fix out-of-bounds access in nl80211_del_key()

elapsed time: 721m

configs tested: 122
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
s390                       zfcpdump_defconfig
m68k                       m5208evb_defconfig
powerpc                    mvme5100_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
arm                            u300_defconfig
sh                         ap325rxa_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        m5307c3_defconfig
arm                             mxs_defconfig
h8300                               defconfig
xtensa                generic_kc705_defconfig
sh                   secureedge5410_defconfig
sh                        apsh4ad0a_defconfig
arm                       multi_v4t_defconfig
m68k                           sun3_defconfig
arm                  colibri_pxa300_defconfig
powerpc                       maple_defconfig
sh                          rsk7203_defconfig
sh                          urquell_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                         ps3_defconfig
sh                 kfr2r09-romimage_defconfig
arm                           h3600_defconfig
arm                          exynos_defconfig
powerpc                     mpc512x_defconfig
arm                       omap2plus_defconfig
m68k                         apollo_defconfig
powerpc                          g5_defconfig
mips                          ath25_defconfig
mips                         bigsur_defconfig
powerpc                  storcenter_defconfig
sh                        dreamcast_defconfig
powerpc                       ebony_defconfig
arm                           h5000_defconfig
powerpc                      ppc6xx_defconfig
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
