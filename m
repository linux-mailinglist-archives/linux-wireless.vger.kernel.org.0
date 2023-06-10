Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73572AE82
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jun 2023 21:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjFJTyU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 10 Jun 2023 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFJTyT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 10 Jun 2023 15:54:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5F730ED
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jun 2023 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686426858; x=1717962858;
  h=date:from:to:cc:subject:message-id;
  bh=S8hMT1mjEuJp4yIgt9T4gNGPg4heBI9aZKaBzjgd9dM=;
  b=P6v1BwE1YMGAtIEGsXsTIf2US+l/tJYrI2LPMLewc6RGU/IUDwKcDevw
   nKgWCii5JAH9lD+RFJJXbUjh2TpkluXTwkpLGXl9DnA+MRFV5a9iWcw1f
   RLCxTHW8kVbyMfV2fEhEMwziuNHldKf6CCEeGMogfDeQF14bW0AC/SAjd
   Mg/z4yx52NMgmB1eUMpIZ+a4XwNBjtAj01/2FiFORUeKhDC4TMDsQYJd5
   4iHeCQpsC2rC4/ogti/IUD+ReOlDSNfwPh9o78NqUE3oVrJUKVuS62QvY
   5DGYfUzZCTRYMgutfQl4WCd3FvtsEE1nGx+IbL/Xdg5eyZ+7WD4IjcEfW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="355293571"
X-IronPort-AV: E=Sophos;i="6.00,233,1681196400"; 
   d="scan'208";a="355293571"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2023 12:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10737"; a="661118884"
X-IronPort-AV: E=Sophos;i="6.00,233,1681196400"; 
   d="scan'208";a="661118884"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 10 Jun 2023 12:54:16 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q84f9-000AOS-2p;
        Sat, 10 Jun 2023 19:54:15 +0000
Date:   Sun, 11 Jun 2023 03:53:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 cabb8b48e542e1401f6881c4f7d3bb82f723ee40
Message-ID: <202306110329.OTffYVh1-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: cabb8b48e542e1401f6881c4f7d3bb82f723ee40  Merge branch 'mptcp-unify-pm-interfaces'

elapsed time: 721m

configs tested: 166
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230610   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230608   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r011-20230608   gcc  
arc                  randconfig-r043-20230610   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230610   clang
arm          buildonly-randconfig-r002-20230608   gcc  
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                  randconfig-r025-20230610   clang
arm                  randconfig-r046-20230610   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230610   clang
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230610   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230608   gcc  
hexagon                          alldefconfig   clang
hexagon      buildonly-randconfig-r006-20230608   clang
hexagon              randconfig-r005-20230610   clang
hexagon              randconfig-r011-20230610   clang
hexagon              randconfig-r014-20230610   clang
hexagon              randconfig-r015-20230610   clang
hexagon              randconfig-r016-20230608   clang
hexagon              randconfig-r021-20230610   clang
hexagon              randconfig-r026-20230610   clang
hexagon              randconfig-r041-20230610   clang
hexagon              randconfig-r045-20230610   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230610   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230608   gcc  
i386                 randconfig-i001-20230610   clang
i386                 randconfig-i002-20230608   gcc  
i386                 randconfig-i002-20230610   clang
i386                 randconfig-i003-20230608   gcc  
i386                 randconfig-i003-20230610   clang
i386                 randconfig-i004-20230608   gcc  
i386                 randconfig-i004-20230610   clang
i386                 randconfig-i005-20230608   gcc  
i386                 randconfig-i005-20230610   clang
i386                 randconfig-i006-20230608   gcc  
i386                 randconfig-i006-20230610   clang
i386                 randconfig-i011-20230608   clang
i386                 randconfig-i012-20230608   clang
i386                 randconfig-i013-20230608   clang
i386                 randconfig-i014-20230608   clang
i386                 randconfig-i015-20230608   clang
i386                 randconfig-i016-20230608   clang
i386                 randconfig-r021-20230610   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230608   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230608   gcc  
loongarch            randconfig-r005-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k         buildonly-randconfig-r005-20230610   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230610   gcc  
microblaze   buildonly-randconfig-r003-20230610   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                         db1xxx_defconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                          malta_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230610   gcc  
openrisc             randconfig-r001-20230610   gcc  
openrisc             randconfig-r013-20230610   gcc  
openrisc             randconfig-r033-20230610   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230610   gcc  
parisc               randconfig-r032-20230610   gcc  
parisc               randconfig-r034-20230610   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                     ksi8560_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc              randconfig-r035-20230610   clang
powerpc                     skiroot_defconfig   clang
powerpc                     tqm8540_defconfig   clang
powerpc                         wii_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230608   clang
riscv                randconfig-r013-20230608   clang
riscv                randconfig-r035-20230610   clang
riscv                randconfig-r042-20230610   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230610   clang
s390                 randconfig-r016-20230610   gcc  
s390                 randconfig-r025-20230610   gcc  
s390                 randconfig-r031-20230610   clang
s390                 randconfig-r044-20230610   gcc  
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh           buildonly-randconfig-r004-20230608   gcc  
sh                        edosk7705_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r004-20230608   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230608   gcc  
sparc                randconfig-r014-20230608   gcc  
sparc                randconfig-r036-20230610   gcc  
sparc64              randconfig-r002-20230610   gcc  
sparc64              randconfig-r034-20230610   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230608   gcc  
x86_64               randconfig-a001-20230610   clang
x86_64               randconfig-a002-20230608   gcc  
x86_64               randconfig-a002-20230610   clang
x86_64               randconfig-a003-20230608   gcc  
x86_64               randconfig-a003-20230610   clang
x86_64               randconfig-a004-20230608   gcc  
x86_64               randconfig-a004-20230610   clang
x86_64               randconfig-a005-20230608   gcc  
x86_64               randconfig-a005-20230610   clang
x86_64               randconfig-a006-20230608   gcc  
x86_64               randconfig-a006-20230610   clang
x86_64               randconfig-a011-20230610   gcc  
x86_64               randconfig-a012-20230610   gcc  
x86_64               randconfig-a013-20230610   gcc  
x86_64               randconfig-a014-20230610   gcc  
x86_64               randconfig-a015-20230610   gcc  
x86_64               randconfig-a016-20230610   gcc  
x86_64               randconfig-r004-20230610   clang
x86_64               randconfig-r023-20230610   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230608   gcc  
xtensa       buildonly-randconfig-r002-20230610   gcc  
xtensa               randconfig-r026-20230610   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
