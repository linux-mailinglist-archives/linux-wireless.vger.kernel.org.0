Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D136736313
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jun 2023 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjFTFRH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jun 2023 01:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjFTFRE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jun 2023 01:17:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF610DB
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 22:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687238219; x=1718774219;
  h=date:from:to:cc:subject:message-id;
  bh=NmS6F5hCbfe8hcjZFOc+I8+cJ/p5hhPvKlWr6CHg8IY=;
  b=JayRz36lFQZA+cfTx6cNcJV1eElSfb81nQR0q+KbrE1H1G1U8zQu6529
   hUZdumXr7sxLdhrKrIdFXG30hgMcDmiY+rKjSXhIUN5aczUOCo5Gj0yjN
   NSEGlSij7pzloPJvm+Kzi4M5HVIEtjI6R2//707dgCeDAzdYsM2AxE6zV
   mgQ1Inr4y40heqBzQ+cx4istmpx6yzQ8lOBUtdsVyyInN2OIw9TxAdk0k
   YfZT6iHnMgJqkanWnWUyUaibFRfY7+pkL/KVI1ZuyDZGV6BlxJgEI9IYD
   Pn2pX49Na5Z0qJJHVOPmpLnlbPmoCEi/JbpkscmlwqY3C+7j0njUuK8X3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339382351"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="339382351"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 22:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="783929507"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="783929507"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jun 2023 22:16:55 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qBTja-0005W8-0T;
        Tue, 20 Jun 2023 05:16:54 +0000
Date:   Tue, 20 Jun 2023 13:16:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 5a0702aac020b2e81f778e3477095d8ed39ce523
Message-ID: <202306201300.7S0ZZzfW-lkp@intel.com>
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
branch HEAD: 5a0702aac020b2e81f778e3477095d8ed39ce523  wifi: mac80211: add eht_capa debugfs field

elapsed time: 728m

configs tested: 125
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230619   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230619   gcc  
arc                  randconfig-r021-20230619   gcc  
arc                  randconfig-r043-20230619   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230619   clang
arm                  randconfig-r033-20230619   clang
arm                  randconfig-r035-20230619   clang
arm                  randconfig-r046-20230619   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230619   gcc  
csky                 randconfig-r032-20230619   gcc  
csky                 randconfig-r036-20230619   gcc  
hexagon              randconfig-r012-20230619   clang
hexagon              randconfig-r041-20230619   clang
hexagon              randconfig-r045-20230619   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230619   gcc  
i386         buildonly-randconfig-r005-20230619   gcc  
i386         buildonly-randconfig-r006-20230619   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230619   gcc  
i386                 randconfig-i002-20230619   gcc  
i386                 randconfig-i003-20230619   gcc  
i386                 randconfig-i004-20230619   gcc  
i386                 randconfig-i005-20230619   gcc  
i386                 randconfig-i006-20230619   gcc  
i386                 randconfig-i011-20230619   clang
i386                 randconfig-i012-20230619   clang
i386                 randconfig-i013-20230619   clang
i386                 randconfig-i014-20230619   clang
i386                 randconfig-i015-20230619   clang
i386                 randconfig-i016-20230619   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230619   gcc  
loongarch            randconfig-r004-20230619   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r005-20230619   gcc  
microblaze           randconfig-r024-20230619   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                  cavium_octeon_defconfig   clang
mips                        maltaup_defconfig   clang
mips                 randconfig-r013-20230619   gcc  
mips                 randconfig-r014-20230619   gcc  
mips                 randconfig-r015-20230619   gcc  
mips                 randconfig-r033-20230619   clang
mips                           rs90_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230619   gcc  
nios2                randconfig-r006-20230619   gcc  
openrisc             randconfig-r005-20230619   gcc  
openrisc             randconfig-r032-20230619   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230619   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc              randconfig-r003-20230619   gcc  
powerpc              randconfig-r015-20230619   clang
powerpc              randconfig-r023-20230619   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r036-20230619   gcc  
riscv                randconfig-r042-20230619   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r034-20230619   gcc  
s390                 randconfig-r044-20230619   clang
sh                               allmodconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r035-20230619   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230619   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230619   clang
um                   randconfig-r004-20230619   clang
um                   randconfig-r014-20230619   gcc  
um                   randconfig-r026-20230619   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230619   gcc  
x86_64       buildonly-randconfig-r002-20230619   gcc  
x86_64       buildonly-randconfig-r003-20230619   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230619   gcc  
x86_64               randconfig-a002-20230619   gcc  
x86_64               randconfig-a003-20230619   gcc  
x86_64               randconfig-a004-20230619   gcc  
x86_64               randconfig-a005-20230619   gcc  
x86_64               randconfig-a006-20230619   gcc  
x86_64               randconfig-a011-20230619   clang
x86_64               randconfig-a012-20230619   clang
x86_64               randconfig-a013-20230619   clang
x86_64               randconfig-a014-20230619   clang
x86_64               randconfig-a015-20230619   clang
x86_64               randconfig-a016-20230619   clang
x86_64               randconfig-r013-20230619   clang
x86_64               randconfig-r034-20230619   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230619   gcc  
xtensa               randconfig-r025-20230619   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
