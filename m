Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80746E7028
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 02:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjDSAG1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 20:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjDSAGY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 20:06:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DAF93ED
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 17:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681862782; x=1713398782;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=axNdsdsDCP6WfO68a7BWkwibLfJhWFGfjBJDUaWEf8Q=;
  b=KyS8Vr4D3X/xiBCGatIeU+V57AMkjhzxbhZig0Xmx+1Uj0tDoEV0b4R2
   vs9D3pH7dbEUZSbaRr41nfZLmtZPWiHmglllhUrn9HzyiB14JNgSmyhUQ
   s7X/qluAF8LRJUGZXpSTfzG5yUeZWorxb3OsJTEATUiyfRUYB7us3oQdf
   CkIMl9/yHAMOh/Ip1PRCjbVe7fXWax1pJH/8nc+c4R5eydBmpVqsu1PXO
   H3gnOaAzwwQgPyCKwakwXeU9pLrZ8n2MlOFWFH9+bVd9unr1vb8MKik9Y
   /bKRDQohq5bB1a9KIgdy9wWA0PgoKbBEtIFxoC7NKXxSUN4oNncH9VqnL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="324932960"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="324932960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 17:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="835072675"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="835072675"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Apr 2023 17:06:18 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1povKz-000eFI-39;
        Wed, 19 Apr 2023 00:06:17 +0000
Date:   Wed, 19 Apr 2023 08:05:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 4c6c476cafa7f6800c94d7f520cbf710a4aed8bc
Message-ID: <643f3052.lMifl3V1mQIEnDAw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 4c6c476cafa7f6800c94d7f520cbf710a4aed8bc  Merge tag 'mt76-for-kvalo-2023-04-18' of https://github.com/nbd168/wireless into pending

elapsed time: 727m

configs tested: 107
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230418   gcc  
alpha                randconfig-r032-20230416   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230416   gcc  
arc          buildonly-randconfig-r006-20230416   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230416   gcc  
arc                  randconfig-r025-20230417   gcc  
arc                  randconfig-r035-20230416   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                  randconfig-r002-20230418   gcc  
arm                  randconfig-r021-20230416   clang
arm                  randconfig-r025-20230416   clang
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230418   clang
arm64                randconfig-r026-20230416   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r023-20230416   gcc  
hexagon              randconfig-r005-20230418   clang
hexagon              randconfig-r012-20230416   clang
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
i386                 randconfig-r023-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r034-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r021-20230417   gcc  
microblaze           randconfig-r024-20230416   gcc  
microblaze           randconfig-r033-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
mips                 randconfig-r003-20230418   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230418   gcc  
nios2                randconfig-r022-20230417   gcc  
parisc       buildonly-randconfig-r004-20230416   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230416   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r036-20230416   gcc  
sh                          sdk7780_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230416   gcc  
sparc64              randconfig-r013-20230416   gcc  
sparc64              randconfig-r016-20230416   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
