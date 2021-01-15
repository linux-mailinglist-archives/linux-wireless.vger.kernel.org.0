Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0D2F7853
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 13:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbhAOMJ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 07:09:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:47292 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbhAOMJ0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 07:09:26 -0500
IronPort-SDR: go/5EkStSVerBCtKwhEOz0gfnKYKe91Wn+O553BsAJP6zS5PrFqV+XSLUKkkF83uxooIpYOxVS
 h5MpQUPstARw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178625263"
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="178625263"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 04:08:45 -0800
IronPort-SDR: tBgTMI02hdyZusVg7lIdga36SDnKNz0JVux6cctaw1fqV9wianm7fnsxNyw2lBlq6zM/WefeVO
 uCYQGx96aGVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,349,1602572400"; 
   d="scan'208";a="425292215"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Jan 2021 04:08:44 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0NuF-0000LI-JG; Fri, 15 Jan 2021 12:08:43 +0000
Date:   Fri, 15 Jan 2021 20:07:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 c13cf5c159660451c8fbdc37efb998b198e1d305
Message-ID: <6001859a.Kcc/ApFBzDYR8imt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: c13cf5c159660451c8fbdc37efb998b198e1d305  mac80211: check if atf has been disabled in __ieee80211_schedule_txq

elapsed time: 724m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
arc                                 defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
powerpc                  iss476-smp_defconfig
ia64                             allmodconfig
mips                      bmips_stb_defconfig
powerpc                      ppc6xx_defconfig
arm                             ezx_defconfig
sh                            migor_defconfig
powerpc                     mpc5200_defconfig
mips                        workpad_defconfig
mips                  decstation_64_defconfig
arm                          pxa168_defconfig
powerpc                      cm5200_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     sbc8548_defconfig
mips                           ci20_defconfig
sh                          rsk7203_defconfig
sh                               alldefconfig
parisc                generic-32bit_defconfig
sh                     sh7710voipgw_defconfig
mips                        nlm_xlp_defconfig
mips                   sb1250_swarm_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a004-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114
x86_64               randconfig-a015-20210115
x86_64               randconfig-a012-20210115
x86_64               randconfig-a013-20210115
x86_64               randconfig-a016-20210115
x86_64               randconfig-a014-20210115
x86_64               randconfig-a011-20210115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
