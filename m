Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533586E7201
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 05:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjDSD7U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 23:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDSD7S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 23:59:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45241736
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681876727; x=1713412727;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=forc7Li1SxFCKsNPiSdtI1jHg+ZWt5OI58OylR0I5qc=;
  b=RkfSe2zJezya9YBGif7VVsJ09sENBeDw6lZSvFCqS2fmD63BDZGfgaDV
   GnxxGzrhsapa4ekW4w+BQ5Hsl2Uk6TISIAIFjXswB85IfRFwJAimuATDd
   aPF49j7u1bP20p9rEUygd+KiAQPKw11/bwFOONCHBPvl1/hL1DnEdQwWt
   CXRG3wp5cPXKY+UzsPo3dnLIb5Ri71NEYrYgGBdVGxgKD9UI/BXNC3+SM
   ctO30mwmm+jlbhPssgx6H9NhZUIgZER6B55n48HdPXnkBFIImxSxbHDA7
   XjrGpzdWKxfzh1jaXtRuY5OTu45DCoejRS3MUQArlgjXI2Lbj+V2xzQyJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325680482"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325680482"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 20:58:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="815479724"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="815479724"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2023 20:58:29 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1poyxg-000eT6-1Y;
        Wed, 19 Apr 2023 03:58:28 +0000
Date:   Wed, 19 Apr 2023 11:57:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 9ae708f00161e1d789268fa9cc05bf6bec2af474
Message-ID: <643f66c3.fLOlDaug/sBQPRA7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
branch HEAD: 9ae708f00161e1d789268fa9cc05bf6bec2af474  wifi: mac80211: remove ieee80211_tx_status_8023

elapsed time: 725m

configs tested: 107
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230417   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r026-20230417   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc          buildonly-randconfig-r004-20230416   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230416   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r023-20230416   gcc  
arm64                randconfig-r025-20230416   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230418   gcc  
csky                 randconfig-r023-20230418   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230418   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230416   gcc  
m68k         buildonly-randconfig-r006-20230418   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230417   gcc  
m68k                 randconfig-r021-20230418   gcc  
microblaze   buildonly-randconfig-r004-20230418   gcc  
microblaze           randconfig-r012-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r003-20230416   gcc  
nios2        buildonly-randconfig-r006-20230418   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230417   gcc  
nios2                randconfig-r026-20230418   gcc  
openrisc             randconfig-r011-20230416   gcc  
openrisc             randconfig-r016-20230416   gcc  
parisc       buildonly-randconfig-r004-20230417   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230418   gcc  
powerpc      buildonly-randconfig-r002-20230418   gcc  
powerpc      buildonly-randconfig-r003-20230418   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                 mpc837x_mds_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230418   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230416   gcc  
s390                 randconfig-r024-20230416   gcc  
sh                               allmodconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                   randconfig-r026-20230416   gcc  
sh                           se7721_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230416   gcc  
sparc                randconfig-r013-20230417   gcc  
sparc                randconfig-r024-20230418   gcc  
sparc64      buildonly-randconfig-r003-20230417   gcc  
sparc64              randconfig-r022-20230416   gcc  
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
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230418   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
