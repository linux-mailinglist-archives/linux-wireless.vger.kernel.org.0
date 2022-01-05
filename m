Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95117484D99
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jan 2022 06:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiAEF0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jan 2022 00:26:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:27406 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232056AbiAEF03 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jan 2022 00:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641360389; x=1672896389;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5/qHYWo94klkF0Oqj1UTkWZUH7uAxFgwTamp9dF5W10=;
  b=a7zZJ6If/tU619zPIScpVpQNCU/xTE3AakmZKV8SWUfLzIcZpq5Pdk5r
   F7oZ9DqRhAUpPI6ZFeNtIngCAc5f8Ze8YqtmuYCaZq9V8avRxClr96x71
   KYkB++7icql2F2OElq/lB0lc9YYocIKgw0bS5VePz1L0q8iixvLDDQcUp
   4LQH9qxG8bJNXUbZzobEGIz+I9D72FdrQX6BJzBmO6Niv2S5Lth1itI+l
   6LMjWP2WOY5C9aUsC634nIBset4X1BM3N+4Ympu38uIoLhYS+T2az/gzd
   pXmfnj+B4CY08jOQAkVbR5USN5T9gwgwyG/bbCTan0scpwAz4q4h+nbp1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222366039"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="222366039"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 21:26:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="470412413"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2022 21:26:26 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4yob-000GHK-S0; Wed, 05 Jan 2022 05:26:25 +0000
Date:   Wed, 05 Jan 2022 13:25:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211:master] BUILD SUCCESS
 6f89ecf10af1396ddc34c303ae1168a11f3f04a3
Message-ID: <61d52be6.g8AfJLH3jxnkXVJA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: 6f89ecf10af1396ddc34c303ae1168a11f3f04a3  Merge tag 'mac80211-for-net-2022-01-04' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211

elapsed time: 749m

configs tested: 108
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220105
sh                           se7750_defconfig
mips                     decstation_defconfig
powerpc                      arches_defconfig
sh                          rsk7201_defconfig
sh                          rsk7269_defconfig
sh                          r7785rp_defconfig
powerpc                     taishan_defconfig
powerpc                      bamboo_defconfig
arc                        nsim_700_defconfig
sh                        edosk7705_defconfig
sh                     magicpanelr2_defconfig
arm                         axm55xx_defconfig
xtensa                    smp_lx200_defconfig
sh                           sh2007_defconfig
arm                            zeus_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                  randconfig-c002-20220105
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20220105
x86_64               randconfig-a001-20220105
x86_64               randconfig-a004-20220105
x86_64               randconfig-a006-20220105
x86_64               randconfig-a003-20220105
x86_64               randconfig-a002-20220105
i386                 randconfig-a003-20220105
i386                 randconfig-a005-20220105
i386                 randconfig-a004-20220105
i386                 randconfig-a006-20220105
i386                 randconfig-a002-20220105
i386                 randconfig-a001-20220105
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                           ip28_defconfig
mips                      maltaaprp_defconfig
powerpc                     tqm5200_defconfig
arm                             mxs_defconfig
powerpc                      obs600_defconfig
powerpc                          g5_defconfig
arm                          collie_defconfig
mips                   sb1250_swarm_defconfig
x86_64               randconfig-a012-20220105
x86_64               randconfig-a015-20220105
x86_64               randconfig-a014-20220105
x86_64               randconfig-a013-20220105
x86_64               randconfig-a011-20220105
x86_64               randconfig-a016-20220105
i386                 randconfig-a012-20220105
i386                 randconfig-a016-20220105
i386                 randconfig-a015-20220105
i386                 randconfig-a014-20220105
i386                 randconfig-a011-20220105
i386                 randconfig-a013-20220105
hexagon              randconfig-r041-20220105
hexagon              randconfig-r045-20220105
riscv                randconfig-r042-20220105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
