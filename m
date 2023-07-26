Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3866D763F7E
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjGZT0K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 15:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGZT0K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 15:26:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A6D2115
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 12:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690399568; x=1721935568;
  h=date:from:to:cc:subject:message-id;
  bh=90AWs6WDeHs0oG+qKtMfhLWkveoblmQvLVltXq+lLl0=;
  b=G4BmXQFIeBXDQNM+a/Z1Ncg224q94EtC5DsYHbeyfRZ8U2irvLDbkmar
   V5k8xxhg8maxaZgUwi5RI3Sa61gaBRpl4E1sjrRfmKSDXbiEDssnjrRY6
   tncf518InFjLekxNt4DuhQstSG7fB5OlsL+qOBXT7RuOK9THp31+mNJFU
   HxUQBfDh7X/loNx9TxGuC2/df0k80LLkjDXLzZ3WVH+XuNCcvvTMsADxp
   PL1ibToW61JbuKScWnBvYLGTunyahqo11T4W6Lv0kjIDMJXBtStgKq6/Q
   ECHL6r5DleM4PuxgQhpsXUNbdiiSdSvtJAB2KCo7ttYXGKyEp3wH0IQBG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="371722353"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="371722353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 12:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900554024"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="900554024"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2023 12:26:06 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOk97-0001Ef-1v;
        Wed, 26 Jul 2023 19:26:05 +0000
Date:   Thu, 27 Jul 2023 03:25:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 456b5e85d8a56e5563573b10e0840c7ae59373da
Message-ID: <202307270324.7rKZg21b-lkp@intel.com>
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
branch HEAD: 456b5e85d8a56e5563573b10e0840c7ae59373da  MAINTAINERS: add Jeff as ath10k, ath11k and ath12k maintainer

elapsed time: 723m

configs tested: 182
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230726   gcc  
alpha                randconfig-r013-20230726   gcc  
alpha                randconfig-r024-20230726   gcc  
alpha                randconfig-r032-20230726   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                  randconfig-r002-20230726   gcc  
arc                  randconfig-r003-20230726   gcc  
arc                  randconfig-r035-20230726   gcc  
arc                  randconfig-r043-20230726   gcc  
arm                              alldefconfig   clang
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230726   gcc  
arm                  randconfig-r023-20230726   gcc  
arm                  randconfig-r032-20230726   clang
arm                  randconfig-r046-20230726   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230726   gcc  
arm64                randconfig-r013-20230726   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230726   gcc  
csky                 randconfig-r031-20230726   gcc  
csky                 randconfig-r032-20230726   gcc  
hexagon              randconfig-r006-20230726   clang
hexagon              randconfig-r013-20230726   clang
hexagon              randconfig-r014-20230726   clang
hexagon              randconfig-r021-20230726   clang
hexagon              randconfig-r022-20230726   clang
hexagon              randconfig-r036-20230726   clang
hexagon              randconfig-r041-20230726   clang
hexagon              randconfig-r045-20230726   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230726   gcc  
i386         buildonly-randconfig-r005-20230726   gcc  
i386         buildonly-randconfig-r006-20230726   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230726   gcc  
i386                 randconfig-i002-20230726   gcc  
i386                 randconfig-i003-20230726   gcc  
i386                 randconfig-i004-20230726   gcc  
i386                 randconfig-i005-20230726   gcc  
i386                 randconfig-i006-20230726   gcc  
i386                 randconfig-i011-20230726   clang
i386                 randconfig-i012-20230726   clang
i386                 randconfig-i013-20230726   clang
i386                 randconfig-i014-20230726   clang
i386                 randconfig-i015-20230726   clang
i386                 randconfig-i016-20230726   clang
i386                 randconfig-r011-20230726   clang
i386                 randconfig-r016-20230726   clang
i386                 randconfig-r026-20230726   clang
i386                 randconfig-r034-20230726   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230726   gcc  
loongarch            randconfig-r006-20230726   gcc  
loongarch            randconfig-r016-20230726   gcc  
loongarch            randconfig-r033-20230726   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230726   gcc  
microblaze           randconfig-r001-20230726   gcc  
microblaze           randconfig-r006-20230726   gcc  
microblaze           randconfig-r011-20230726   gcc  
microblaze           randconfig-r014-20230726   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230726   clang
mips                 randconfig-r035-20230726   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230726   gcc  
nios2                randconfig-r004-20230726   gcc  
nios2                randconfig-r006-20230726   gcc  
nios2                randconfig-r011-20230726   gcc  
nios2                randconfig-r014-20230726   gcc  
nios2                randconfig-r015-20230726   gcc  
nios2                randconfig-r022-20230726   gcc  
nios2                randconfig-r025-20230726   gcc  
nios2                randconfig-r033-20230726   gcc  
openrisc             randconfig-r003-20230726   gcc  
openrisc             randconfig-r005-20230726   gcc  
openrisc             randconfig-r022-20230726   gcc  
openrisc             randconfig-r025-20230726   gcc  
openrisc             randconfig-r026-20230726   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc               randconfig-r002-20230726   gcc  
parisc               randconfig-r006-20230726   gcc  
parisc               randconfig-r011-20230726   gcc  
parisc               randconfig-r012-20230726   gcc  
parisc               randconfig-r014-20230726   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc              randconfig-r006-20230726   gcc  
powerpc              randconfig-r032-20230726   gcc  
powerpc              randconfig-r035-20230726   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230726   gcc  
riscv                randconfig-r004-20230726   gcc  
riscv                randconfig-r005-20230726   gcc  
riscv                randconfig-r016-20230726   clang
riscv                randconfig-r022-20230726   clang
riscv                randconfig-r036-20230726   gcc  
riscv                randconfig-r042-20230726   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230726   gcc  
s390                 randconfig-r002-20230726   gcc  
s390                 randconfig-r014-20230726   clang
s390                 randconfig-r024-20230726   clang
s390                 randconfig-r025-20230726   clang
s390                 randconfig-r034-20230726   gcc  
s390                 randconfig-r044-20230726   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230726   gcc  
sh                   randconfig-r005-20230726   gcc  
sh                   randconfig-r015-20230726   gcc  
sh                   randconfig-r016-20230726   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230726   gcc  
sparc                randconfig-r026-20230726   gcc  
sparc                randconfig-r033-20230726   gcc  
sparc64              randconfig-r013-20230726   gcc  
sparc64              randconfig-r022-20230726   gcc  
sparc64              randconfig-r025-20230726   gcc  
sparc64              randconfig-r031-20230726   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r036-20230726   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230726   gcc  
x86_64       buildonly-randconfig-r002-20230726   gcc  
x86_64       buildonly-randconfig-r003-20230726   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r005-20230726   gcc  
x86_64               randconfig-r026-20230726   clang
x86_64               randconfig-x001-20230726   clang
x86_64               randconfig-x002-20230726   clang
x86_64               randconfig-x003-20230726   clang
x86_64               randconfig-x004-20230726   clang
x86_64               randconfig-x005-20230726   clang
x86_64               randconfig-x006-20230726   clang
x86_64               randconfig-x011-20230726   gcc  
x86_64               randconfig-x012-20230726   gcc  
x86_64               randconfig-x013-20230726   gcc  
x86_64               randconfig-x014-20230726   gcc  
x86_64               randconfig-x015-20230726   gcc  
x86_64               randconfig-x016-20230726   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r002-20230726   gcc  
xtensa               randconfig-r003-20230726   gcc  
xtensa               randconfig-r015-20230726   gcc  
xtensa               randconfig-r023-20230726   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
