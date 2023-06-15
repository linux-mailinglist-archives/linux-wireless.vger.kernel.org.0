Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72663730C71
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 02:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjFOA6U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 20:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOA6T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 20:58:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57F326A6
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 17:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686790698; x=1718326698;
  h=date:from:to:cc:subject:message-id;
  bh=QVUURO2Wq1priacyyL04Tux/MM15WFUyyDVOHrc5Lo8=;
  b=GRvhUT95/BcjbOtL1BzWCNxb64JDWl/0xjQJPDzBofNh7FLwYwN8mTty
   7idw2+5a2HwY1uYPAaE/EULX6GObvupnV07KTMn7D8xqUI85wnPy8m7Y9
   6VWofuWsxT3jokPaJFQVCPJG5KwcBZCrRHxe9Ju5kq5XJL47lFR4c1KWM
   TMtguOt+BBmRcjkEY0vXzbsZkDNJV3+aTukCD2gDTKVkALQeTNkfJ/gAc
   JVti6Hqap8Dr9R/SMePikUfr+fvKxyAOdC+wO0oNxqGjPOmJ1UT9+RPv+
   q5RCVvvsW8/HC4r8HOGu5CziZ2+0YF6DKS46RI+FIp5GYzOocR6bkefxi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="422380159"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="422380159"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 17:58:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="1042427901"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="1042427901"
Received: from lkp-server02.sh.intel.com (HELO d59cacf64e9e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2023 17:58:16 -0700
Received: from kbuild by d59cacf64e9e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9bJX-0001Dh-0a;
        Thu, 15 Jun 2023 00:58:15 +0000
Date:   Thu, 15 Jun 2023 08:58:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 93ae81454b1107843ad36dcdc457dd10ee0f2cbe
Message-ID: <202306150802.bsQH9j1g-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 93ae81454b1107843ad36dcdc457dd10ee0f2cbe  wifi: iwlwifi: dbg-tlv: clear FW debug memory on init

elapsed time: 722m

configs tested: 128
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230614   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arc                  randconfig-r043-20230614   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230612   gcc  
arm                  randconfig-r024-20230612   clang
arm                  randconfig-r046-20230612   clang
arm                  randconfig-r046-20230614   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230614   clang
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230614   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r034-20230614   gcc  
hexagon              randconfig-r016-20230614   clang
hexagon              randconfig-r032-20230612   clang
hexagon              randconfig-r036-20230614   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r041-20230614   clang
hexagon              randconfig-r045-20230612   clang
hexagon              randconfig-r045-20230614   clang
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
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r021-20230612   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230612   gcc  
loongarch            randconfig-r031-20230612   gcc  
loongarch            randconfig-r035-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230612   gcc  
m68k                 randconfig-r005-20230612   gcc  
m68k                 randconfig-r006-20230612   gcc  
m68k                 randconfig-r023-20230612   gcc  
microblaze           randconfig-r003-20230612   gcc  
microblaze           randconfig-r031-20230614   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230614   gcc  
mips                 randconfig-r001-20230612   gcc  
mips                 randconfig-r011-20230614   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230612   gcc  
nios2                randconfig-r002-20230612   gcc  
nios2                randconfig-r013-20230614   gcc  
nios2                randconfig-r022-20230612   gcc  
nios2                randconfig-r034-20230612   gcc  
openrisc     buildonly-randconfig-r006-20230614   gcc  
openrisc             randconfig-r004-20230612   gcc  
openrisc             randconfig-r024-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc       buildonly-randconfig-r003-20230614   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r004-20230614   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230612   clang
riscv                randconfig-r015-20230614   gcc  
riscv                randconfig-r042-20230612   gcc  
riscv                randconfig-r042-20230614   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r026-20230612   gcc  
s390                 randconfig-r032-20230614   clang
s390                 randconfig-r044-20230612   gcc  
s390                 randconfig-r044-20230614   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230614   gcc  
sh                   randconfig-r035-20230614   gcc  
sh                   randconfig-r036-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230612   gcc  
sparc                randconfig-r033-20230614   gcc  
sparc64              randconfig-r021-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230614   clang
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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
