Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415F06B5608
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Mar 2023 00:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjCJXwl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Mar 2023 18:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCJXwj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Mar 2023 18:52:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0688B12CB86
        for <linux-wireless@vger.kernel.org>; Fri, 10 Mar 2023 15:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678492357; x=1710028357;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=cPWCeZTDBiBZi9jwPSenmDlKPuggKtP6gDZr1NSxYG0=;
  b=gk7x90wtI4CSla/oM0AUKmIpKoyDZIslCZBO3iL03faj+Qp84jhL1sUi
   vWk8LZd5MFmcMzHlyjvOPmsBTsEJcNVIQPjGvkL0g8bVtCljWpLo4TIVY
   vvkoa5zWcnUt2Ua5zkUnznEf0Vr1Jla/6JQo56AjZAqp0UZMgsu3W35sm
   e0GARu8IQB//mCYHWYoLeqyHiiUsqReJX4BJGCpGsxlsqST/WQ/WEydgt
   xdOii0LWzouELbJ+zjObvKfpWF7tIDmFxbLwsP/PeIqpM4B8nelGB0X3i
   wJeF9uPO0x65lzhZ5jPF01wM+vHaDjcCc1Li8LN/wGNgJCxrwyT3FzyD2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="339217424"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="339217424"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 15:52:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746922386"
X-IronPort-AV: E=Sophos;i="5.98,251,1673942400"; 
   d="scan'208";a="746922386"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 15:52:34 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pamXK-0004BL-0Y;
        Fri, 10 Mar 2023 23:52:34 +0000
Date:   Sat, 11 Mar 2023 07:52:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 96c069508377547f913e7265a80fffe9355de592
Message-ID: <640bc2af.zhxzlWoGxZ3NetqH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 96c069508377547f913e7265a80fffe9355de592  wifi: cfg80211: fix MLO connection ownership

elapsed time: 731m

configs tested: 169
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230310   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230310   gcc  
arc                  randconfig-r011-20230310   gcc  
arc                  randconfig-r015-20230310   gcc  
arc                  randconfig-r026-20230310   gcc  
arc                  randconfig-r043-20230310   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r003-20230310   clang
arm          buildonly-randconfig-r004-20230310   clang
arm                                 defconfig   gcc  
arm                  randconfig-r024-20230310   clang
arm                  randconfig-r032-20230310   gcc  
arm                  randconfig-r046-20230310   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230310   clang
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230310   gcc  
arm64                randconfig-r033-20230310   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230310   gcc  
csky                 randconfig-r022-20230310   gcc  
csky                 randconfig-r023-20230310   gcc  
hexagon              randconfig-r003-20230310   clang
hexagon              randconfig-r004-20230310   clang
hexagon              randconfig-r012-20230310   clang
hexagon              randconfig-r016-20230310   clang
hexagon              randconfig-r023-20230310   clang
hexagon              randconfig-r024-20230310   clang
hexagon              randconfig-r031-20230310   clang
hexagon              randconfig-r034-20230310   clang
hexagon              randconfig-r041-20230310   clang
hexagon              randconfig-r045-20230310   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230310   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230310   gcc  
ia64                 randconfig-r021-20230310   gcc  
ia64                 randconfig-r022-20230310   gcc  
ia64                 randconfig-r031-20230310   gcc  
ia64                 randconfig-r034-20230310   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230310   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230310   gcc  
loongarch            randconfig-r006-20230310   gcc  
loongarch            randconfig-r015-20230310   gcc  
loongarch            randconfig-r016-20230310   gcc  
loongarch            randconfig-r025-20230310   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230310   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230310   gcc  
m68k                 randconfig-r012-20230310   gcc  
m68k                 randconfig-r016-20230310   gcc  
m68k                 randconfig-r035-20230310   gcc  
microblaze           randconfig-r006-20230310   gcc  
microblaze           randconfig-r013-20230310   gcc  
microblaze           randconfig-r015-20230310   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230310   gcc  
mips                 randconfig-r006-20230310   gcc  
mips                 randconfig-r021-20230310   clang
mips                 randconfig-r036-20230310   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230310   gcc  
nios2                randconfig-r005-20230310   gcc  
nios2                randconfig-r011-20230310   gcc  
nios2                randconfig-r021-20230310   gcc  
nios2                randconfig-r025-20230310   gcc  
nios2                randconfig-r031-20230310   gcc  
nios2                randconfig-r033-20230310   gcc  
openrisc     buildonly-randconfig-r001-20230310   gcc  
openrisc     buildonly-randconfig-r004-20230310   gcc  
openrisc     buildonly-randconfig-r006-20230310   gcc  
openrisc             randconfig-r003-20230310   gcc  
openrisc             randconfig-r004-20230310   gcc  
openrisc             randconfig-r005-20230310   gcc  
openrisc             randconfig-r022-20230310   gcc  
openrisc             randconfig-r036-20230310   gcc  
parisc       buildonly-randconfig-r001-20230310   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230310   gcc  
parisc               randconfig-r004-20230310   gcc  
parisc               randconfig-r011-20230310   gcc  
parisc               randconfig-r016-20230310   gcc  
parisc               randconfig-r023-20230310   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230310   gcc  
powerpc              randconfig-r002-20230310   clang
powerpc              randconfig-r005-20230310   clang
powerpc              randconfig-r006-20230310   clang
powerpc              randconfig-r012-20230310   gcc  
powerpc              randconfig-r015-20230310   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230310   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230310   gcc  
riscv                randconfig-r026-20230310   gcc  
riscv                randconfig-r042-20230310   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230310   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r014-20230310   gcc  
s390                 randconfig-r022-20230310   gcc  
s390                 randconfig-r044-20230310   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230310   gcc  
sh                   randconfig-r002-20230310   gcc  
sh                   randconfig-r011-20230310   gcc  
sh                   randconfig-r013-20230310   gcc  
sh                   randconfig-r024-20230310   gcc  
sh                   randconfig-r032-20230310   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r013-20230310   gcc  
sparc                randconfig-r034-20230310   gcc  
sparc64      buildonly-randconfig-r002-20230310   gcc  
sparc64      buildonly-randconfig-r004-20230310   gcc  
sparc64              randconfig-r001-20230310   gcc  
sparc64              randconfig-r012-20230310   gcc  
sparc64              randconfig-r032-20230310   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230310   gcc  
xtensa               randconfig-r026-20230310   gcc  
xtensa               randconfig-r033-20230310   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
