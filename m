Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B72704DF4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 14:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjEPMl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 08:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjEPMlZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 08:41:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D33A1725
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 05:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684240884; x=1715776884;
  h=date:from:to:cc:subject:message-id;
  bh=DEVLOUEi6iUfzOhWuHVfUYUHwyACT3hG/V5o7k4kqhk=;
  b=Tdpx+O6ltSdWGQAR/RPKi8W97a9ZejWzx4afFSmgRwXEFvoLf/0UBtWX
   o0+lNN6VbE1f7DOIKTSnNqX/mIz56BV3HDtO+SJcUbHK78cGeF0bQOt74
   AkEbuYWLwExQB7dOH+Rm8GcDhmiVw83fkqJbKgadlWqfiZEkJkxFCT50b
   HdrGbnfnr1zvWMhPLsaLjqvgh1Q5JmadcUWzHqWKa/XJ51QeQoYBvvhTq
   7X6tZEBJt0o6WDXetf7SXkQcCntEOfLR30Ft3KWkpjfNn1SKC8rx72/q7
   XHuqWXSlv4PuHbLbPG+VnKxjkmGhpU6R7oThopEeV88Mm3F3SkFvmuaZ1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="348966251"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="348966251"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 05:41:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="813413805"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="813413805"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 16 May 2023 05:41:14 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pytzO-0007Re-15;
        Tue, 16 May 2023 12:41:14 +0000
Date:   Tue, 16 May 2023 20:40:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 20429444e653ee8242dfbf815c0c37866beb371b
Message-ID: <20230516124040.HcYr1%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230516180935/lkp-src/repo/*/wireless
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 20429444e653ee8242dfbf815c0c37866beb371b  wifi: rtl8xxxu: fix authentication timeout due to incorrect RCR value

elapsed time: 863m

configs tested: 217
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230515   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230516   gcc  
arc                  randconfig-r022-20230516   gcc  
arc                  randconfig-r025-20230515   gcc  
arc                  randconfig-r043-20230515   gcc  
arc                  randconfig-r043-20230516   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230515   clang
arm                                 defconfig   gcc  
arm                  randconfig-r024-20230515   clang
arm                  randconfig-r046-20230516   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230515   clang
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230516   gcc  
arm64                randconfig-r003-20230515   clang
arm64                randconfig-r005-20230516   gcc  
arm64                randconfig-r012-20230515   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230515   gcc  
csky                 randconfig-r006-20230515   gcc  
csky                 randconfig-r011-20230515   gcc  
csky                 randconfig-r012-20230516   gcc  
csky                 randconfig-r031-20230515   gcc  
hexagon              randconfig-r005-20230516   clang
hexagon              randconfig-r023-20230515   clang
hexagon              randconfig-r026-20230515   clang
hexagon              randconfig-r033-20230515   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230515   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230515   clang
i386                 randconfig-a002-20230515   clang
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230515   clang
i386                 randconfig-a004-20230515   clang
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230515   clang
i386                 randconfig-a006-20230515   clang
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230515   gcc  
i386                 randconfig-a012-20230515   gcc  
i386                 randconfig-a013-20230515   gcc  
i386                 randconfig-a014-20230515   gcc  
i386                 randconfig-a015-20230515   gcc  
i386                 randconfig-a016-20230515   gcc  
i386                 randconfig-i051-20230515   clang
i386                 randconfig-i052-20230515   clang
i386                          randconfig-i052   clang
i386                 randconfig-i053-20230515   clang
i386                 randconfig-i054-20230515   clang
i386                          randconfig-i054   clang
i386                 randconfig-i055-20230515   clang
i386                 randconfig-i056-20230515   clang
i386                          randconfig-i056   clang
i386                 randconfig-i061-20230515   clang
i386                 randconfig-i062-20230515   clang
i386                          randconfig-i062   clang
i386                 randconfig-i063-20230515   clang
i386                 randconfig-i064-20230515   clang
i386                          randconfig-i064   clang
i386                 randconfig-i065-20230515   clang
i386                 randconfig-i066-20230515   clang
i386                          randconfig-i066   clang
i386                 randconfig-i071-20230515   gcc  
i386                          randconfig-i071   clang
i386                 randconfig-i072-20230515   gcc  
i386                 randconfig-i073-20230515   gcc  
i386                          randconfig-i073   clang
i386                 randconfig-i074-20230515   gcc  
i386                 randconfig-i075-20230515   gcc  
i386                          randconfig-i075   clang
i386                 randconfig-i076-20230515   gcc  
i386                 randconfig-i081-20230515   gcc  
i386                 randconfig-i082-20230515   gcc  
i386                 randconfig-i083-20230515   gcc  
i386                 randconfig-i084-20230515   gcc  
i386                 randconfig-i085-20230515   gcc  
i386                 randconfig-i086-20230515   gcc  
i386                 randconfig-i091-20230515   clang
i386                 randconfig-i092-20230515   clang
i386                 randconfig-i093-20230515   clang
i386                 randconfig-i094-20230515   clang
i386                 randconfig-i095-20230515   clang
i386                 randconfig-i096-20230515   clang
i386                 randconfig-r014-20230515   gcc  
i386                 randconfig-r016-20230515   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230515   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r016-20230515   gcc  
ia64                 randconfig-r024-20230516   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230515   gcc  
loongarch    buildonly-randconfig-r003-20230515   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230515   gcc  
loongarch            randconfig-r006-20230516   gcc  
loongarch            randconfig-r023-20230516   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230516   gcc  
microblaze           randconfig-r004-20230516   gcc  
microblaze           randconfig-r012-20230515   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230515   gcc  
mips                 randconfig-r004-20230515   gcc  
mips                 randconfig-r004-20230516   clang
mips                 randconfig-r035-20230515   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230515   gcc  
nios2                randconfig-r005-20230516   gcc  
openrisc     buildonly-randconfig-r003-20230515   gcc  
openrisc             randconfig-r006-20230516   gcc  
openrisc             randconfig-r036-20230515   gcc  
parisc       buildonly-randconfig-r006-20230515   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230516   gcc  
parisc               randconfig-r015-20230515   gcc  
parisc               randconfig-r026-20230516   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230516   gcc  
riscv                randconfig-r013-20230515   gcc  
riscv                randconfig-r042-20230515   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230516   clang
s390                                defconfig   gcc  
s390                 randconfig-r001-20230516   gcc  
s390                 randconfig-r035-20230515   clang
s390                 randconfig-r044-20230515   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230515   gcc  
sh                   randconfig-r001-20230515   gcc  
sh                   randconfig-r002-20230516   gcc  
sh                   randconfig-r011-20230515   gcc  
sh                   randconfig-r011-20230516   gcc  
sh                   randconfig-r013-20230516   gcc  
sh                   randconfig-r033-20230515   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230515   gcc  
sparc                randconfig-r032-20230515   gcc  
sparc                randconfig-r034-20230515   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230515   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230515   clang
x86_64               randconfig-a003-20230515   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230515   clang
x86_64               randconfig-a005-20230515   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230515   clang
x86_64               randconfig-a011-20230515   gcc  
x86_64                        randconfig-a011   gcc  
x86_64               randconfig-a012-20230515   gcc  
x86_64               randconfig-a013-20230515   gcc  
x86_64                        randconfig-a013   gcc  
x86_64               randconfig-a014-20230515   gcc  
x86_64               randconfig-a015-20230515   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-a016-20230515   gcc  
x86_64               randconfig-x051-20230515   gcc  
x86_64               randconfig-x052-20230515   gcc  
x86_64               randconfig-x053-20230515   gcc  
x86_64               randconfig-x054-20230515   gcc  
x86_64               randconfig-x055-20230515   gcc  
x86_64               randconfig-x056-20230515   gcc  
x86_64               randconfig-x061-20230515   gcc  
x86_64               randconfig-x062-20230515   gcc  
x86_64               randconfig-x063-20230515   gcc  
x86_64               randconfig-x064-20230515   gcc  
x86_64               randconfig-x065-20230515   gcc  
x86_64               randconfig-x066-20230515   gcc  
x86_64               randconfig-x071-20230515   clang
x86_64               randconfig-x072-20230515   clang
x86_64               randconfig-x073-20230515   clang
x86_64               randconfig-x074-20230515   clang
x86_64               randconfig-x075-20230515   clang
x86_64               randconfig-x076-20230515   clang
x86_64               randconfig-x081-20230515   clang
x86_64               randconfig-x082-20230515   clang
x86_64               randconfig-x083-20230515   clang
x86_64               randconfig-x084-20230515   clang
x86_64               randconfig-x085-20230515   clang
x86_64               randconfig-x086-20230515   clang
x86_64               randconfig-x091-20230515   gcc  
x86_64               randconfig-x092-20230515   gcc  
x86_64                        randconfig-x092   gcc  
x86_64               randconfig-x093-20230515   gcc  
x86_64               randconfig-x094-20230515   gcc  
x86_64                        randconfig-x094   gcc  
x86_64               randconfig-x095-20230515   gcc  
x86_64               randconfig-x096-20230515   gcc  
x86_64                        randconfig-x096   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230515   gcc  
xtensa               randconfig-r003-20230516   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
