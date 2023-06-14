Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6514B73087B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjFNTiy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 15:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjFNTi2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 15:38:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CD4296D
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686771476; x=1718307476;
  h=date:from:to:cc:subject:message-id;
  bh=C+0Xf//jOssr4obFmy2gbomfvBLwQtSGbDvOgWm+o4A=;
  b=cW3mpl4ENcm/UeeO10U/0LaWB6oBfOonA7rogqKgOz2JHCr3ultcLXDQ
   13bNjtcN/+Z+mUjTk5gSOQN+CGSXRaX2JYs2vvTsEcVnHxRKnmdxhWESw
   F0Kd0ymaCawAZiDf5BhThLKQPYBZUBGgFxn1d1Yk82ZUc8P08+WBdTcya
   wZ0684nqZs8iArXf3EP2MSFNK4Zn1RnpdqydHeLcWNNMYlWSDgAIVZiAA
   7W4U9xY9dd5bj7iImF5swP1d+rbkCPjdRD9OZTI9RVko36RoaTDSmZ0v8
   dnPojQf/qSMK9MBR9YTRxJrfnhilyq2MT46kqjBg1uRl2E1gJ+5vQTur3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="358717572"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="358717572"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 12:37:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="712183702"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="712183702"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Jun 2023 12:37:37 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9WJF-00010s-0R;
        Wed, 14 Jun 2023 19:37:37 +0000
Date:   Thu, 15 Jun 2023 03:35:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 f1a0898b5d6a77d332d036da03bad6fa9770de5b
Message-ID: <202306150303.x8Oeov4o-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: f1a0898b5d6a77d332d036da03bad6fa9770de5b  wifi: iwlwifi: mvm: spin_lock_bh() to fix lockdep regression

elapsed time: 721m

configs tested: 142
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230614   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230612   gcc  
alpha                randconfig-r005-20230612   gcc  
alpha                randconfig-r014-20230614   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r023-20230612   gcc  
arc                  randconfig-r026-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arc                  randconfig-r043-20230613   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230612   gcc  
arm                  randconfig-r021-20230612   clang
arm                  randconfig-r024-20230612   clang
arm                  randconfig-r046-20230612   clang
arm                  randconfig-r046-20230613   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230614   clang
arm64                               defconfig   gcc  
arm64                randconfig-r015-20230614   gcc  
csky         buildonly-randconfig-r001-20230614   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r034-20230612   gcc  
csky                 randconfig-r036-20230612   gcc  
hexagon              randconfig-r032-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r041-20230613   clang
hexagon              randconfig-r045-20230612   clang
hexagon              randconfig-r045-20230613   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i011-20230614   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i012-20230614   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i013-20230614   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i014-20230614   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i015-20230614   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-i016-20230614   gcc  
i386                 randconfig-r021-20230612   gcc  
i386                 randconfig-r024-20230612   gcc  
i386                 randconfig-r031-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230612   gcc  
loongarch            randconfig-r006-20230612   gcc  
loongarch            randconfig-r014-20230614   gcc  
loongarch            randconfig-r022-20230612   gcc  
loongarch            randconfig-r031-20230612   gcc  
loongarch            randconfig-r035-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230612   gcc  
m68k                 randconfig-r012-20230614   gcc  
m68k                 randconfig-r025-20230612   gcc  
m68k                 randconfig-r032-20230612   gcc  
microblaze           randconfig-r004-20230612   gcc  
microblaze           randconfig-r013-20230614   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230614   gcc  
mips         buildonly-randconfig-r006-20230614   gcc  
mips                 randconfig-r003-20230612   gcc  
nios2        buildonly-randconfig-r002-20230614   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230612   gcc  
openrisc             randconfig-r016-20230614   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r005-20230614   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230614   gcc  
parisc               randconfig-r033-20230612   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r011-20230614   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230612   clang
riscv                randconfig-r006-20230612   clang
riscv                randconfig-r015-20230614   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                randconfig-r042-20230613   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230614   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230612   clang
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
s390                 randconfig-r044-20230613   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230612   gcc  
sh                   randconfig-r036-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230612   gcc  
sparc64      buildonly-randconfig-r003-20230614   gcc  
sparc64              randconfig-r035-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r026-20230612   gcc  
x86_64               randconfig-r033-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230614   gcc  
xtensa               randconfig-r016-20230614   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
