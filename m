Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C60A6E5500
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 01:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjDQXMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjDQXMP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 19:12:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D3430DC
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 16:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681773133; x=1713309133;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0XhGoahLs3Bl/A3+LhabiKfFyiUPQ1YEbuHISW9tWZU=;
  b=lFR+Uuf1JKtzdnzUHRuQRtENSJ+RnYyvot6IaEylrWWg5OBV4po/3jm/
   b4fZ4exTEEJu7G7CXMooTZqfjOsAVtwy3DJm8MFgl9FzoVkWJJcEVERVQ
   AAx7G6EBu8W08w1xeSEX3R47gGwltARmv58lzN1vnTNrxyKImDXWAjzeX
   W2nkOPSDfiDJd0qNf64vSReroNrSI9Vu1cUzvLJ6pmnQZs9uyc5ywYruj
   EKInvq/w9VoC8kwdSo830A9Pl04Ptiw6mLSAESopre1arGltvSwq1/JEM
   nC6sV96N3VCvLNsizGjGzS3cQiVpGjTCM7+zkV7rKycbE4IfaLd0pgus9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="324647058"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="324647058"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 16:12:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723415837"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="723415837"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 17 Apr 2023 16:12:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poY10-000cit-0h;
        Mon, 17 Apr 2023 23:12:06 +0000
Date:   Tue, 18 Apr 2023 07:12:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 f22c0bffe8d9528ace89a853c6065b79dcb88c43
Message-ID: <643dd242.fE+BIy5yFrcY9owA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: f22c0bffe8d9528ace89a853c6065b79dcb88c43  wifi: rtw89: add support of concurrent mode

elapsed time: 732m

configs tested: 113
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230416   gcc  
alpha                randconfig-r032-20230416   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r033-20230416   gcc  
arc                  randconfig-r034-20230416   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230416   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230416   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230417   gcc  
csky                 randconfig-r025-20230416   gcc  
csky                 randconfig-r033-20230417   gcc  
csky                 randconfig-r035-20230417   gcc  
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230416   gcc  
ia64                 randconfig-r022-20230417   gcc  
ia64                 randconfig-r026-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230417   gcc  
loongarch            randconfig-r036-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r021-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230417   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230417   gcc  
openrisc             randconfig-r002-20230417   gcc  
openrisc             randconfig-r011-20230417   gcc  
openrisc             randconfig-r035-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230416   gcc  
parisc               randconfig-r006-20230417   gcc  
parisc               randconfig-r021-20230416   gcc  
parisc               randconfig-r023-20230416   gcc  
parisc               randconfig-r024-20230416   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        cell_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r016-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230417   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230416   gcc  
sparc64              randconfig-r003-20230416   gcc  
sparc64              randconfig-r026-20230417   gcc  
sparc64              randconfig-r036-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64               randconfig-k001-20230417   clang
x86_64               randconfig-r032-20230417   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230417   gcc  
xtensa               randconfig-r015-20230416   gcc  
xtensa               randconfig-r031-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
