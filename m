Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9EE47B6F9
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 02:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhLUByk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 20:54:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:46239 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhLUByk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 20:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640051680; x=1671587680;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=J7tMio4r4q2Y+/7i5R720BxiGEy/KdNkWZ2RaK2Ztdc=;
  b=P7YWFDQ55wk4/HPqZ3hTQGa4bM/YK8lirm9MJRYBFa5AU9XS/cpATTnr
   NenB9TXnNJgp5TBJyBFGJ50+di+hpIi7NIZnrY24kTKMTDlsyBcFDduzI
   1Pme8pEd+FWQcoGYn6VZdEXroW6IzPTY2nNZZsmoe5Go5vTYpuYAZ831v
   Iqur/sp53ioFS33SkTI8Xi2d+Qi40QdGAb9UrCXi2NFFnfQKZQD7GSxjn
   pKLGY0B+TRUN5UWhCg1vBoDqugRhTP5cvRxuHZXFC/hOyCF492vAE4GD+
   MdV+LpWhjL+xsAvEFz/HE0R1psETw/ciQR7wQhYnYK6RiWrSx1ZtOrm+I
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="264491355"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="264491355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 17:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="684487940"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Dec 2021 17:54:38 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzUMP-0008XM-Ss; Tue, 21 Dec 2021 01:54:37 +0000
Date:   Tue, 21 Dec 2021 09:53:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211-next:master] BUILD SUCCESS
 701fdfe348f7e5c9fe71caa3558d63dbb4bc4b81
Message-ID: <61c133b6.DgXB7/0YQTu0ooCh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 701fdfe348f7e5c9fe71caa3558d63dbb4bc4b81  cfg80211: Enable regulatory enforcement checks for drivers supporting mesh iface

elapsed time: 720m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
arm                         s3c6400_defconfig
powerpc                      arches_defconfig
arm                          badge4_defconfig
arm                         s3c2410_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
sh                          urquell_defconfig
sh                             shx3_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         lubbock_defconfig
powerpc                   currituck_defconfig
arm                          exynos_defconfig
sh                     magicpanelr2_defconfig
sh                           se7750_defconfig
arm                       imx_v4_v5_defconfig
nios2                            alldefconfig
arm                  randconfig-c002-20211220
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
x86_64               randconfig-a013-20211221
x86_64               randconfig-a014-20211221
x86_64               randconfig-a011-20211221
x86_64               randconfig-a012-20211221
x86_64               randconfig-a016-20211221
x86_64               randconfig-a015-20211221
arc                  randconfig-r043-20211220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a012-20211220
i386                 randconfig-a011-20211220
i386                 randconfig-a014-20211220
i386                 randconfig-a016-20211220
i386                 randconfig-a015-20211220
i386                 randconfig-a013-20211220
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
