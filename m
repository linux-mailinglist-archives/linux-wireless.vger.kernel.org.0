Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6C6D56E8
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 04:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjDDCw7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 22:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDCw6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 22:52:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD8A0
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 19:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680576777; x=1712112777;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=b/AgdTfsL+AUzpuEzwdtyLBKp+ADq1wjl2rQ9Q9NV+I=;
  b=LGDCnC6W0rUaa0vcNR7/i7F+QKW11O5uEBm0VnNbRFG/utgfPTVwMC7L
   DdBaDTB6h4m+/eIegWvTQ0GF3exFuOma2UWoQ50l323YQ9y5po2tW1lcJ
   qFGeFWoYtOADXUknZsCh9Qlk7GPtrLnKh/KlIYSEDtqZC/grqHYR0I4v5
   uAGxiJIH8g8a0ZIfMBQ8v8VYrAE84tVUB+lYdQLuws8wNsXmmDDXaSYTU
   au2q3euYAiDB2Krgqnxtg5Y5vByR0Teribx13Bm7Dsmf1bEMslWxDK4vG
   EKRssoN/ADmhZIzpyLXUrGSV/81ANkCYE1pez6RX/67TRz5QEqdJaIWAg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404835683"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="404835683"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 19:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="716493030"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="716493030"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Apr 2023 19:52:54 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjWn0-000P4B-0b;
        Tue, 04 Apr 2023 02:52:54 +0000
Date:   Tue, 04 Apr 2023 10:52:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 cbef9a83c51dfcb07f77cfa6ac26f53a1ea86f49
Message-ID: <642b90d8.yN4cqWn/B1/g1xMe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: cbef9a83c51dfcb07f77cfa6ac26f53a1ea86f49  wifi: rt2x00: Fix memory leak when handling surveys

elapsed time: 726m

configs tested: 121
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r034-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230403   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230403   clang
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r013-20230403   gcc  
arm64                randconfig-r032-20230403   clang
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r012-20230403   gcc  
hexagon      buildonly-randconfig-r004-20230403   clang
hexagon              randconfig-r001-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r015-20230403   gcc  
i386                 randconfig-r016-20230403   gcc  
i386                 randconfig-r021-20230403   gcc  
i386                 randconfig-r023-20230403   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230403   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230403   gcc  
m68k         buildonly-randconfig-r002-20230403   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230403   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r015-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230403   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r035-20230403   gcc  
parisc       buildonly-randconfig-r004-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r012-20230403   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r033-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r032-20230403   clang
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230403   gcc  
sh                   randconfig-r006-20230403   gcc  
sh                   randconfig-r036-20230403   gcc  
sparc        buildonly-randconfig-r001-20230403   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r004-20230403   gcc  
sparc64              randconfig-r005-20230403   gcc  
sparc64              randconfig-r024-20230403   gcc  
sparc64              randconfig-r026-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230403   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r001-20230403   clang
x86_64               randconfig-r016-20230403   gcc  
x86_64               randconfig-r031-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa               randconfig-r026-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
