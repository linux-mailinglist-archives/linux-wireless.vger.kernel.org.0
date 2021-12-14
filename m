Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D6D473D7B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 08:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhLNHQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 02:16:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:49487 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231387AbhLNHQw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 02:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639466212; x=1671002212;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=up8vweh2eZKj6WOG5sA4GJo4npNc4Z24FrtkQ1EG9qM=;
  b=nmLJBgskLGGpBHqnxjKdn7qMfU3lztg51xplckRuhhymYkDTZ9oySC3b
   18LAO0wwtdRe+a4DpLsdQJvSLr0qMVA5+q2MzcZLu9T13adYk0+7rvvgW
   qm/YUyHref5pEn5sLIWHebrlqr8Kd60ZxUFtG8TYDSmI55K5DLwM21aaf
   vhUydT8QQBwZ8kX8t83WmhAOEjBLI45PR3g/0g72i9rsHLFe0lUlQFrRv
   Mrw3COT+KIi6K3bafkeau4wLCRxxe5kva2TuqXhAtsHqgtCiusVa8HY7d
   HgQSzNd7Ay4y/w3oZW3baZR/Kz6BSu56+u8CrVtnyzqQSHcRZ/H2UYQwU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="237653356"
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="237653356"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 23:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,204,1635231600"; 
   d="scan'208";a="505255584"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 23:16:51 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mx23O-000024-KU; Tue, 14 Dec 2021 07:16:50 +0000
Date:   Tue, 14 Dec 2021 15:16:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:pending] BUILD SUCCESS
 db207592b74891fc45a89a62c0ec500e2abb8202
Message-ID: <61b844b0.9kvkE1/FD3aZq8d6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git pending
branch HEAD: db207592b74891fc45a89a62c0ec500e2abb8202  Merge tag 'mt76-for-kvalo-2021-12-03' of https://github.com/nbd168/wireless into pending

elapsed time: 720m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211213
arc                        vdk_hs38_defconfig
powerpc                     pq2fads_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
openrisc                 simple_smp_defconfig
powerpc                   motionpro_defconfig
arm                       imx_v6_v7_defconfig
arm                         s5pv210_defconfig
powerpc                     taishan_defconfig
powerpc                      acadia_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
arc                     haps_hs_smp_defconfig
mips                     decstation_defconfig
mips                          rm200_defconfig
xtensa                  audio_kc705_defconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
parisc                           allyesconfig
arm                        trizeps4_defconfig
i386                             alldefconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      ppc6xx_defconfig
powerpc                    sam440ep_defconfig
m68k                       m5208evb_defconfig
m68k                         apollo_defconfig
powerpc                       holly_defconfig
sh                              ul2_defconfig
m68k                       bvme6000_defconfig
powerpc                 canyonlands_defconfig
sh                        sh7785lcr_defconfig
arm                           sunxi_defconfig
mips                           ip22_defconfig
nds32                            alldefconfig
sh                           se7712_defconfig
m68k                        mvme147_defconfig
powerpc                     kilauea_defconfig
mips                      pic32mzda_defconfig
powerpc                     mpc512x_defconfig
m68k                          multi_defconfig
arm                  randconfig-c002-20211213
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a011-20211213
x86_64               randconfig-a012-20211213
x86_64               randconfig-a014-20211213
x86_64               randconfig-a013-20211213
x86_64               randconfig-a016-20211213
x86_64               randconfig-a015-20211213
i386                 randconfig-a013-20211213
i386                 randconfig-a011-20211213
i386                 randconfig-a016-20211213
i386                 randconfig-a014-20211213
i386                 randconfig-a015-20211213
i386                 randconfig-a012-20211213
arc                  randconfig-r043-20211213
riscv                randconfig-r042-20211213
s390                 randconfig-r044-20211213
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211213
arm                  randconfig-c002-20211213
riscv                randconfig-c006-20211213
mips                 randconfig-c004-20211213
i386                 randconfig-c001-20211213
s390                 randconfig-c005-20211213
powerpc              randconfig-c003-20211213
x86_64               randconfig-a006-20211213
x86_64               randconfig-a005-20211213
x86_64               randconfig-a001-20211213
x86_64               randconfig-a002-20211213
x86_64               randconfig-a003-20211213
x86_64               randconfig-a004-20211213
i386                 randconfig-a001-20211213
i386                 randconfig-a002-20211213
i386                 randconfig-a003-20211213
i386                 randconfig-a004-20211213
i386                 randconfig-a005-20211213
i386                 randconfig-a006-20211213
hexagon              randconfig-r045-20211213
hexagon              randconfig-r041-20211213
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
