Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0776FA97
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 09:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjHDHBO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 03:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjHDHBL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 03:01:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392591734
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691132470; x=1722668470;
  h=date:from:to:cc:subject:message-id;
  bh=SEp+3K+GkVY8Y2e4fruIXCrFqchWfLPKY70eK2YQ1EY=;
  b=gKW6sthllMb/ZU9gFAjDE8PhWQqBsvxNmC64FkAnwAST4RBK3UBHyGTJ
   MqiTwDXmVbRL26VZX1ZfxI47JcUPauIC9eRRJGegtd6gBMiqkmfFtAh08
   q1Skha2DgWycXr12a2BjUCIlIB3KEhqGz8TpsR1xy63k3fPcNjdyNOqot
   7djLrOM64ZJyvwi1qubrjQCW0YZgZMGjd/l398aEDvf3w4ClMhmEWHCbJ
   evujR47+VgdKQheEak4Gi5Hp0cfd98V98JVzqGuNS5qHscKb2NZkenmLk
   pmv8MgIhY+oEaEHudBKiDzpTosr7ppxKPWNtMFjNbw9IhgutDxPnJgZbE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="433936603"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="433936603"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 00:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="799907650"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="799907650"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2023 00:01:08 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRoo7-0002hH-0Y;
        Fri, 04 Aug 2023 07:01:07 +0000
Date:   Fri, 04 Aug 2023 15:01:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 904b102f1ebb67b91f1e90783a480fc473c986dd
Message-ID: <202308041501.vmpvGlp0-lkp@intel.com>
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
branch HEAD: 904b102f1ebb67b91f1e90783a480fc473c986dd  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

elapsed time: 725m

configs tested: 133
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r024-20230731   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230801   gcc  
arc                  randconfig-r025-20230731   gcc  
arc                  randconfig-r026-20230731   gcc  
arc                  randconfig-r033-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r004-20230801   clang
arm                  randconfig-r013-20230731   gcc  
arm                  randconfig-r032-20230801   clang
arm                  randconfig-r046-20230731   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r034-20230801   gcc  
hexagon              randconfig-r022-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
i386                 randconfig-r005-20230801   gcc  
i386                 randconfig-r033-20230801   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230731   gcc  
m68k                 randconfig-r024-20230731   gcc  
microblaze           randconfig-r005-20230801   gcc  
microblaze           randconfig-r022-20230731   gcc  
microblaze           randconfig-r023-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230801   gcc  
nios2                randconfig-r035-20230731   gcc  
nios2                randconfig-r036-20230731   gcc  
openrisc             randconfig-r025-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230731   gcc  
parisc               randconfig-r031-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r036-20230801   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230801   gcc  
riscv                randconfig-r013-20230731   clang
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230801   gcc  
s390                 randconfig-r012-20230731   clang
s390                 randconfig-r034-20230731   gcc  
s390                 randconfig-r035-20230801   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230801   gcc  
sh                   randconfig-r006-20230801   gcc  
sh                   randconfig-r014-20230731   gcc  
sh                   randconfig-r031-20230801   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230801   gcc  
sparc                randconfig-r011-20230731   gcc  
sparc                randconfig-r012-20230731   gcc  
sparc                randconfig-r015-20230731   gcc  
sparc64              randconfig-r015-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r006-20230801   gcc  
x86_64               randconfig-r016-20230731   clang
x86_64               randconfig-r021-20230731   clang
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x001-20230801   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x002-20230801   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x003-20230801   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x004-20230801   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x005-20230801   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x006-20230801   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
