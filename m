Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE7B728F1A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 06:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjFIEtV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 00:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFIEtU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 00:49:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A3830E8
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 21:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686286159; x=1717822159;
  h=date:from:to:cc:subject:message-id;
  bh=HX+NKkNzgrGhY7smi2/7EniSyTRAzG1lAItFa38eoSc=;
  b=dqRkW02QVIRPD1bSf+ERhaVq2gtUQF9HtKjHrUVMuytsttG0+v37Zzr+
   olSuf3C2Lki+WDthLAJ80/U60BJB/C5KTW0L+7mmMGhxnTayBpx38puFC
   745I+8/nB9oPQg0LN4+iBcGrVIWS6aX9uRVE091JViZkB/NoyDa2q1SUX
   upuD8hV31G4J1ni9iW8ZuH0OMPEPiyxxbrVGih8W1blrZ0ZA+6avJwiLY
   g4Rv4h946RZszIIO7JTQ8pQslIj+qdRs6b/GxlxdrMARZZoPMZ5ITC0XO
   BI+CzzBjk3RZ5Jd2kxdmYtsqv0sOOdsknnEqa6s4s/zwRY5TYolAJM2oX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="337147481"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="337147481"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 21:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="957002675"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="957002675"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 21:49:15 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7U3n-0008du-0K;
        Fri, 09 Jun 2023 04:49:15 +0000
Date:   Fri, 09 Jun 2023 12:48:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 fef0f427f71224442698ea4e052315a894d9de69
Message-ID: <202306091232.LNzraYGV-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: fef0f427f71224442698ea4e052315a894d9de69  wifi: rtlwifi: remove misused flag from HAL data

elapsed time: 724m

configs tested: 165
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r012-20230608   gcc  
alpha                randconfig-r021-20230608   gcc  
alpha                randconfig-r023-20230608   gcc  
alpha                randconfig-r031-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230608   gcc  
arc                  randconfig-r012-20230608   gcc  
arc                  randconfig-r015-20230608   gcc  
arc                  randconfig-r025-20230608   gcc  
arc                  randconfig-r043-20230608   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r032-20230608   clang
arm                  randconfig-r046-20230608   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230608   clang
arm64                randconfig-r024-20230608   clang
csky         buildonly-randconfig-r006-20230608   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230608   gcc  
csky                 randconfig-r011-20230608   gcc  
csky                 randconfig-r026-20230608   gcc  
csky                 randconfig-r031-20230608   gcc  
hexagon              randconfig-r003-20230608   clang
hexagon              randconfig-r005-20230608   clang
hexagon              randconfig-r013-20230608   clang
hexagon              randconfig-r016-20230608   clang
hexagon              randconfig-r022-20230608   clang
hexagon              randconfig-r041-20230608   clang
hexagon              randconfig-r045-20230608   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230608   gcc  
i386                 randconfig-i002-20230608   gcc  
i386                 randconfig-i003-20230608   gcc  
i386                 randconfig-i004-20230608   gcc  
i386                 randconfig-i005-20230608   gcc  
i386                 randconfig-i006-20230608   gcc  
i386                 randconfig-i011-20230608   clang
i386                 randconfig-i012-20230608   clang
i386                 randconfig-i013-20230608   clang
i386                 randconfig-i014-20230608   clang
i386                 randconfig-i015-20230608   clang
i386                 randconfig-i016-20230608   clang
i386                 randconfig-i051-20230608   gcc  
i386                 randconfig-i052-20230608   gcc  
i386                 randconfig-i053-20230608   gcc  
i386                 randconfig-i054-20230608   gcc  
i386                 randconfig-i055-20230608   gcc  
i386                 randconfig-i056-20230608   gcc  
i386                 randconfig-i061-20230608   gcc  
i386                 randconfig-i062-20230608   gcc  
i386                 randconfig-i063-20230608   gcc  
i386                 randconfig-i064-20230608   gcc  
i386                 randconfig-i065-20230608   gcc  
i386                 randconfig-i066-20230608   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230608   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230608   gcc  
loongarch            randconfig-r025-20230608   gcc  
loongarch            randconfig-r033-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r003-20230608   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r013-20230608   gcc  
microblaze           randconfig-r002-20230608   gcc  
microblaze           randconfig-r024-20230608   gcc  
microblaze           randconfig-r036-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230608   clang
mips                      malta_kvm_defconfig   clang
nios2        buildonly-randconfig-r001-20230608   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230608   gcc  
openrisc     buildonly-randconfig-r002-20230608   gcc  
openrisc             randconfig-r004-20230608   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230608   clang
powerpc      buildonly-randconfig-r004-20230608   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc              randconfig-r004-20230608   gcc  
powerpc              randconfig-r032-20230608   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230608   gcc  
riscv                randconfig-r006-20230608   gcc  
riscv                randconfig-r015-20230608   clang
riscv                randconfig-r042-20230608   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230608   clang
s390         buildonly-randconfig-r002-20230608   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230608   gcc  
s390                 randconfig-r014-20230608   clang
s390                 randconfig-r023-20230608   clang
s390                 randconfig-r035-20230608   gcc  
s390                 randconfig-r044-20230608   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh           buildonly-randconfig-r004-20230608   gcc  
sh                        dreamcast_defconfig   gcc  
sh                   randconfig-r003-20230608   gcc  
sh                   randconfig-r026-20230608   gcc  
sh                   randconfig-r034-20230608   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230608   gcc  
x86_64               randconfig-a002-20230608   gcc  
x86_64               randconfig-a003-20230608   gcc  
x86_64               randconfig-a004-20230608   gcc  
x86_64               randconfig-a005-20230608   gcc  
x86_64               randconfig-a006-20230608   gcc  
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a012-20230608   clang
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a015-20230608   clang
x86_64               randconfig-a016-20230608   clang
x86_64               randconfig-r002-20230608   gcc  
x86_64               randconfig-r006-20230608   gcc  
x86_64               randconfig-x051-20230608   clang
x86_64               randconfig-x052-20230608   clang
x86_64               randconfig-x053-20230608   clang
x86_64               randconfig-x054-20230608   clang
x86_64               randconfig-x055-20230608   clang
x86_64               randconfig-x056-20230608   clang
x86_64               randconfig-x061-20230608   clang
x86_64               randconfig-x062-20230608   clang
x86_64               randconfig-x063-20230608   clang
x86_64               randconfig-x064-20230608   clang
x86_64               randconfig-x065-20230608   clang
x86_64               randconfig-x066-20230608   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                              defconfig   gcc  
xtensa               randconfig-r021-20230608   gcc  
xtensa               randconfig-r033-20230608   gcc  
xtensa               randconfig-r035-20230608   gcc  
xtensa               randconfig-r036-20230608   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
