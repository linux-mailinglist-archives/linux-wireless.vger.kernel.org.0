Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D227A019E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjINKYx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 06:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjINKYw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 06:24:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945161BEB
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694687088; x=1726223088;
  h=date:from:to:cc:subject:message-id;
  bh=6f1ifAuG++jDmefx2IcBf7u+bR+a26D0NtxTAanX+yI=;
  b=GIUyS9nsx5RZ8FEApEK1+OTnG2yahsKCBmtIg8TMvYqY/K0SRwp8r9aH
   TUVxvqCHydjTAs88mkV+715DOI6P0ectwtDOfvR4ld0P1bB6RHe8cU4eE
   Qzw1hVX6RFEhXsLz/GCZERJFqLEHlmuEFllIvaMb3GReNld/D0bv5ZELN
   B+1f1/DndFZRC+IJP+QiFznGX85fV4dNwmx6doCFuk+TCZOodinVqjSPU
   a4uEjQ3Pbes2swRQh2TP6Ssyy6KK+D390GwKF4GGVwEkYlU6F4BZyCKfN
   SGRql5r8V7Ep+q8eQ/hKVVwrqWIPAjjqgRDdAqMwNcloNjfLotzkY+4gz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="363950115"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="363950115"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 03:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744486683"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; 
   d="scan'208";a="744486683"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Sep 2023 03:24:44 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgjWc-0001UD-2O;
        Thu, 14 Sep 2023 10:24:42 +0000
Date:   Thu, 14 Sep 2023 18:24:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 6e48ebffc2db5419b3a51cfc509bde442252b356
Message-ID: <202309141822.Y58Ismh6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 6e48ebffc2db5419b3a51cfc509bde442252b356  wifi: mac80211: fix mesh id corruption on 32 bit systems

elapsed time: 1480m

configs tested: 218
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230913   gcc  
alpha                randconfig-r021-20230913   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230913   gcc  
arc                  randconfig-r005-20230913   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230913   gcc  
arm                   randconfig-001-20230914   gcc  
arm                  randconfig-r004-20230913   clang
arm                  randconfig-r032-20230913   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r032-20230913   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230913   gcc  
csky                 randconfig-r021-20230913   gcc  
csky                 randconfig-r022-20230913   gcc  
hexagon               randconfig-001-20230913   clang
hexagon               randconfig-002-20230913   clang
hexagon              randconfig-r025-20230913   clang
hexagon              randconfig-r035-20230913   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230914   gcc  
i386         buildonly-randconfig-002-20230914   gcc  
i386         buildonly-randconfig-003-20230913   gcc  
i386         buildonly-randconfig-003-20230914   gcc  
i386         buildonly-randconfig-004-20230914   gcc  
i386         buildonly-randconfig-005-20230914   gcc  
i386         buildonly-randconfig-006-20230914   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230913   gcc  
i386                  randconfig-001-20230914   gcc  
i386                  randconfig-002-20230913   gcc  
i386                  randconfig-002-20230914   gcc  
i386                  randconfig-003-20230914   gcc  
i386                  randconfig-004-20230913   gcc  
i386                  randconfig-004-20230914   gcc  
i386                  randconfig-005-20230913   gcc  
i386                  randconfig-005-20230914   gcc  
i386                  randconfig-006-20230914   gcc  
i386                  randconfig-011-20230913   gcc  
i386                  randconfig-011-20230914   gcc  
i386                  randconfig-012-20230913   gcc  
i386                  randconfig-012-20230914   gcc  
i386                  randconfig-013-20230913   gcc  
i386                  randconfig-013-20230914   gcc  
i386                  randconfig-014-20230913   gcc  
i386                  randconfig-014-20230914   gcc  
i386                  randconfig-015-20230913   gcc  
i386                  randconfig-015-20230914   gcc  
i386                  randconfig-016-20230914   gcc  
i386                 randconfig-r023-20230913   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230913   gcc  
loongarch            randconfig-r001-20230913   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r022-20230913   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r013-20230913   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r025-20230913   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230913   gcc  
nios2                randconfig-r023-20230913   gcc  
nios2                randconfig-r033-20230913   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r001-20230913   gcc  
openrisc             randconfig-r004-20230913   gcc  
openrisc             randconfig-r016-20230913   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230913   gcc  
parisc               randconfig-r024-20230913   gcc  
parisc               randconfig-r035-20230913   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r003-20230913   gcc  
powerpc              randconfig-r006-20230913   gcc  
powerpc              randconfig-r015-20230913   clang
powerpc64            randconfig-r005-20230913   gcc  
powerpc64            randconfig-r031-20230913   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230913   gcc  
riscv                randconfig-r036-20230913   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230913   clang
s390                 randconfig-r013-20230913   clang
s390                 randconfig-r014-20230913   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r011-20230913   gcc  
sh                   randconfig-r034-20230913   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230914   gcc  
sparc                randconfig-r031-20230913   gcc  
sparc                randconfig-r036-20230913   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r012-20230913   gcc  
sparc64              randconfig-r014-20230913   gcc  
sparc64              randconfig-r024-20230913   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230913   clang
um                   randconfig-r003-20230913   clang
um                   randconfig-r026-20230913   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230913   gcc  
x86_64       buildonly-randconfig-001-20230914   gcc  
x86_64       buildonly-randconfig-002-20230913   gcc  
x86_64       buildonly-randconfig-002-20230914   gcc  
x86_64       buildonly-randconfig-003-20230913   gcc  
x86_64       buildonly-randconfig-003-20230914   gcc  
x86_64       buildonly-randconfig-004-20230913   gcc  
x86_64       buildonly-randconfig-004-20230914   gcc  
x86_64       buildonly-randconfig-005-20230913   gcc  
x86_64       buildonly-randconfig-005-20230914   gcc  
x86_64       buildonly-randconfig-006-20230913   gcc  
x86_64       buildonly-randconfig-006-20230914   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230913   gcc  
x86_64                randconfig-001-20230914   gcc  
x86_64                randconfig-002-20230913   gcc  
x86_64                randconfig-002-20230914   gcc  
x86_64                randconfig-003-20230913   gcc  
x86_64                randconfig-003-20230914   gcc  
x86_64                randconfig-004-20230914   gcc  
x86_64                randconfig-005-20230914   gcc  
x86_64                randconfig-006-20230914   gcc  
x86_64                randconfig-011-20230913   gcc  
x86_64                randconfig-011-20230914   gcc  
x86_64                randconfig-012-20230913   gcc  
x86_64                randconfig-012-20230914   gcc  
x86_64                randconfig-013-20230913   gcc  
x86_64                randconfig-013-20230914   gcc  
x86_64                randconfig-014-20230913   gcc  
x86_64                randconfig-014-20230914   gcc  
x86_64                randconfig-015-20230913   gcc  
x86_64                randconfig-015-20230914   gcc  
x86_64                randconfig-016-20230913   gcc  
x86_64                randconfig-016-20230914   gcc  
x86_64                randconfig-071-20230913   gcc  
x86_64                randconfig-071-20230914   gcc  
x86_64                randconfig-072-20230913   gcc  
x86_64                randconfig-072-20230914   gcc  
x86_64                randconfig-073-20230913   gcc  
x86_64                randconfig-073-20230914   gcc  
x86_64                randconfig-074-20230913   gcc  
x86_64                randconfig-074-20230914   gcc  
x86_64                randconfig-075-20230913   gcc  
x86_64                randconfig-075-20230914   gcc  
x86_64                randconfig-076-20230913   gcc  
x86_64                randconfig-076-20230914   gcc  
x86_64               randconfig-r016-20230913   clang
x86_64               randconfig-r026-20230913   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r002-20230913   gcc  
xtensa               randconfig-r033-20230913   gcc  
xtensa               randconfig-r034-20230913   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
