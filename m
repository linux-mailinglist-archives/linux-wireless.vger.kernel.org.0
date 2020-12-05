Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249D42CFABB
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgLEJFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 04:05:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:20234 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgLEJDh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 04:03:37 -0500
IronPort-SDR: s06dt9BVyxliovgoKVfaJobj7OEox3sGWF1VD2RkXP7Hvpvszwog8BpgQz8oR8LNh+G9tRyTLy
 2hyG5YOCKJzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="191751959"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="191751959"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 01:02:33 -0800
IronPort-SDR: K96MP/1sQdpXjvHigyQ9RVvgDHcSgCSknVopsmEgoM8+nJvqJtOlMg8wcGq2Nwjwe66wJTMlTA
 4lXxhrDKdegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="369146438"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Dec 2020 01:02:32 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klTSZ-0000E6-GR; Sat, 05 Dec 2020 09:02:31 +0000
Date:   Sat, 05 Dec 2020 17:02:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:pending] BUILD SUCCESS
 810ca591c1046f7054aa2187351a3aefe5c70c1b
Message-ID: <5fcb4c8e.hgYwLB2awWs3aNTR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  pending
branch HEAD: 810ca591c1046f7054aa2187351a3aefe5c70c1b  Merge tag 'mt76-for-kvalo-2020-12-04' of https://github.com/nbd168/wireless into pending

elapsed time: 749m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                        shmobile_defconfig
um                           x86_64_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
ia64                            zx1_defconfig
arm                         lpc18xx_defconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                      acadia_defconfig
arm                         assabet_defconfig
powerpc                     skiroot_defconfig
nios2                            alldefconfig
powerpc                     redwood_defconfig
powerpc                          g5_defconfig
powerpc                         wii_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      jornada720_defconfig
s390                          debug_defconfig
powerpc                      mgcoge_defconfig
nios2                         10m50_defconfig
powerpc                     ppa8548_defconfig
arm                         at91_dt_defconfig
powerpc                       ebony_defconfig
mips                         tb0226_defconfig
powerpc                 mpc8272_ads_defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
arm                        multi_v5_defconfig
arm                         nhk8815_defconfig
m68k                            q40_defconfig
mips                           jazz_defconfig
sparc64                             defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
x86_64               randconfig-a016-20201205
x86_64               randconfig-a012-20201205
x86_64               randconfig-a014-20201205
x86_64               randconfig-a013-20201205
x86_64               randconfig-a015-20201205
x86_64               randconfig-a011-20201205
i386                 randconfig-a014-20201204
i386                 randconfig-a013-20201204
i386                 randconfig-a011-20201204
i386                 randconfig-a015-20201204
i386                 randconfig-a012-20201204
i386                 randconfig-a016-20201204
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
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
