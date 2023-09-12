Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C234179CE72
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 12:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjILKgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjILKe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 06:34:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F303C10EA
        for <linux-wireless@vger.kernel.org>; Tue, 12 Sep 2023 03:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694514865; x=1726050865;
  h=date:from:to:cc:subject:message-id;
  bh=8tRCBdBpvLrkH/sfp6R0UNQg9fogKYoJc8I9ujSVSak=;
  b=lqrfnTRKZzpc7GP7kSyS7hWw9xcwqnUVb8PP8fG5nKLBF5recdtW7j0Y
   T0wVmLD9v/Cle23F6D6PGl9ySwgm+bXX4VrRHhNQr9iF2RfCfRM3UUp2E
   n8Qvm0zzRcWqDCnuX5BdeYillOChKApDjTQpVIm100cdq9t4fbpVRo1Dc
   IBCvEKEyZ/4p3weeQd/TZsJ/0QUL7I5RtSMF9IEg4WDUeN8K6lsdNr27F
   PYgepPl50cedrlHbZocm0mMN1PtfQLfnRVSQvQ4/C05gvlU5GcsRu8SnX
   0kpcVxD//tGNMPYzpm/DZ3oCSM4UUncEK6ggJ3gtf2HaZHNZNf9DTkrsa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363367500"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="363367500"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858748208"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="858748208"
Received: from lkp-server02.sh.intel.com (HELO 1e56c5165d33) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2023 03:34:24 -0700
Received: from kbuild by 1e56c5165d33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qg0is-0000Gi-1f;
        Tue, 12 Sep 2023 10:34:22 +0000
Date:   Tue, 12 Sep 2023 18:33:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:merge-2023-09-11] BUILD SUCCESS
 7da89fb58c59511e062a930e7b47e0d5bea565f4
Message-ID: <202309121843.Rit7qPiv-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git merge-2023-09-11
branch HEAD: 7da89fb58c59511e062a930e7b47e0d5bea565f4  Merge remote-tracking branch 'wireless-next/main' into wireless

elapsed time: 885m

configs tested: 161
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230912   gcc  
arc                  randconfig-r011-20230912   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230912   clang
arm                  randconfig-r014-20230912   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230912   clang
arm64                randconfig-r013-20230912   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230912   gcc  
csky                 randconfig-r034-20230912   gcc  
hexagon               randconfig-001-20230912   clang
hexagon               randconfig-002-20230912   clang
hexagon              randconfig-r021-20230912   clang
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
i386                  randconfig-001-20230912   clang
i386                  randconfig-002-20230912   clang
i386                  randconfig-003-20230912   clang
i386                  randconfig-004-20230912   clang
i386                  randconfig-005-20230912   clang
i386                  randconfig-006-20230912   clang
i386                  randconfig-011-20230912   gcc  
i386                  randconfig-012-20230912   gcc  
i386                  randconfig-013-20230912   gcc  
i386                  randconfig-014-20230912   gcc  
i386                  randconfig-015-20230912   gcc  
i386                  randconfig-016-20230912   gcc  
i386                 randconfig-r003-20230912   clang
i386                 randconfig-r015-20230912   gcc  
i386                 randconfig-r024-20230912   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230912   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230912   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r016-20230912   gcc  
microblaze           randconfig-r036-20230912   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r035-20230912   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230912   gcc  
nios2                randconfig-r031-20230912   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r026-20230912   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230912   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230912   clang
riscv                randconfig-r022-20230912   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230912   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r004-20230912   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r023-20230912   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
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
x86_64                randconfig-071-20230912   clang
x86_64                randconfig-072-20230912   clang
x86_64                randconfig-073-20230912   clang
x86_64                randconfig-074-20230912   clang
x86_64                randconfig-075-20230912   clang
x86_64                randconfig-076-20230912   clang
x86_64               randconfig-r025-20230912   gcc  
x86_64               randconfig-r032-20230912   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r033-20230912   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
