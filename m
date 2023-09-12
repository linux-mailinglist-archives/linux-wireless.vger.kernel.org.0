Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3842579C954
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 10:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjILIJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 04:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjILIJD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 04:09:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6C0E78
        for <linux-wireless@vger.kernel.org>; Tue, 12 Sep 2023 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694506139; x=1726042139;
  h=date:from:to:cc:subject:message-id;
  bh=w/YV+9HRnH1O5/UWqL54nG1NpX9DbCRZs2G8+R2Ybrk=;
  b=lndYpn36zm9nIXW7KzGVoM6x1SDSQAGTpWxqnTxhHabpFX6xd2orGSoi
   O/Ulbbr4qFz6P1hIRDpEAmJOgEmDs/FnzQPDswUAH06/XbXtKXgiT7k+l
   8wpaViz9Og32PgUfah1K6TD4cHCVQjlxoUsWx2vUcrh8hfSelN+F9a5Um
   F7FFgGmAJjqBgxEZehhb2rvuL1NyKkvvVTO3YjyPvFofv4ivW2lGAFzwr
   Tqu0B4vv7vWEKTo/LRJ4dKQ+UGXdQI6IM+WqRRqTrPwxthdiPFdi03Q1h
   CC/MlKPry6kqbxwzHhbrYb5OVNDR6ER5ZwdnAh+jWwllPR1h6W5FHmPEp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464676709"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="464676709"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="1074473262"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="1074473262"
Received: from lkp-server02.sh.intel.com (HELO 1e56c5165d33) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Sep 2023 01:08:57 -0700
Received: from kbuild by 1e56c5165d33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qfyS7-00007h-2F;
        Tue, 12 Sep 2023 08:08:55 +0000
Date:   Tue, 12 Sep 2023 16:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 37c20b2effe987b806c8de6d12978e4ffeff026f
Message-ID: <202309121602.EVRFg6zD-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 37c20b2effe987b806c8de6d12978e4ffeff026f  wifi: cfg80211: fix cqm_config access race

elapsed time: 740m

configs tested: 186
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230912   gcc  
alpha                randconfig-r033-20230912   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230912   gcc  
arc                  randconfig-r002-20230912   gcc  
arc                  randconfig-r006-20230912   gcc  
arc                  randconfig-r016-20230912   gcc  
arc                  randconfig-r034-20230912   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230912   clang
arm                  randconfig-r001-20230912   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230912   gcc  
arm64                randconfig-r031-20230912   clang
arm64                randconfig-r036-20230912   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230912   gcc  
csky                 randconfig-r005-20230912   gcc  
csky                 randconfig-r006-20230912   gcc  
csky                 randconfig-r013-20230912   gcc  
csky                 randconfig-r022-20230912   gcc  
hexagon               randconfig-001-20230912   clang
hexagon               randconfig-002-20230912   clang
hexagon              randconfig-r002-20230912   clang
hexagon              randconfig-r012-20230912   clang
hexagon              randconfig-r024-20230912   clang
hexagon              randconfig-r034-20230912   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230912   clang
i386         buildonly-randconfig-002-20230912   clang
i386         buildonly-randconfig-003-20230912   clang
i386         buildonly-randconfig-004-20230912   clang
i386         buildonly-randconfig-005-20230912   clang
i386         buildonly-randconfig-006-20230912   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-006-20230912   clang
i386                  randconfig-011-20230912   gcc  
i386                  randconfig-012-20230912   gcc  
i386                  randconfig-013-20230912   gcc  
i386                  randconfig-014-20230912   gcc  
i386                  randconfig-015-20230912   gcc  
i386                  randconfig-016-20230912   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230912   gcc  
loongarch            randconfig-r001-20230912   gcc  
loongarch            randconfig-r002-20230912   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230912   gcc  
m68k                 randconfig-r004-20230912   gcc  
m68k                 randconfig-r014-20230912   gcc  
m68k                 randconfig-r023-20230912   gcc  
m68k                 randconfig-r025-20230912   gcc  
m68k                 randconfig-r026-20230912   gcc  
m68k                 randconfig-r035-20230912   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r022-20230912   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r024-20230912   clang
mips                 randconfig-r032-20230912   gcc  
mips                 randconfig-r033-20230912   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230912   gcc  
nios2                randconfig-r023-20230912   gcc  
nios2                randconfig-r035-20230912   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r015-20230912   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230912   gcc  
parisc               randconfig-r021-20230912   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r005-20230912   clang
powerpc64            randconfig-r005-20230912   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230912   clang
riscv                randconfig-r004-20230912   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230912   gcc  
s390                 randconfig-r002-20230912   clang
s390                 randconfig-r012-20230912   gcc  
s390                 randconfig-r013-20230912   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r001-20230912   gcc  
sh                   randconfig-r002-20230912   gcc  
sh                   randconfig-r004-20230912   gcc  
sh                   randconfig-r015-20230912   gcc  
sh                   randconfig-r021-20230912   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r032-20230912   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r003-20230912   gcc  
sparc64              randconfig-r036-20230912   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230912   gcc  
um                   randconfig-r016-20230912   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230912   clang
x86_64       buildonly-randconfig-002-20230912   clang
x86_64       buildonly-randconfig-003-20230912   clang
x86_64       buildonly-randconfig-004-20230912   clang
x86_64       buildonly-randconfig-005-20230912   clang
x86_64       buildonly-randconfig-006-20230912   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230912   gcc  
x86_64                randconfig-002-20230912   gcc  
x86_64                randconfig-003-20230912   gcc  
x86_64                randconfig-004-20230912   gcc  
x86_64                randconfig-005-20230912   gcc  
x86_64                randconfig-006-20230912   gcc  
x86_64                randconfig-011-20230912   clang
x86_64                randconfig-012-20230912   clang
x86_64                randconfig-013-20230912   clang
x86_64                randconfig-014-20230912   clang
x86_64                randconfig-015-20230912   clang
x86_64                randconfig-016-20230912   clang
x86_64                randconfig-074-20230912   clang
x86_64                randconfig-076-20230912   clang
x86_64               randconfig-r025-20230912   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r003-20230912   gcc  
xtensa               randconfig-r011-20230912   gcc  
xtensa               randconfig-r014-20230912   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
