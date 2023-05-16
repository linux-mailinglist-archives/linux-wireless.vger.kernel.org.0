Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB228704CFA
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 13:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjEPLu3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjEPLt6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 07:49:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE2469D
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237781; x=1715773781;
  h=date:from:to:cc:subject:message-id;
  bh=Yu3um0789SWRPRmHe+ayN3NeIBprdypPtQvKY3Z9mys=;
  b=YoEnu85HAxFC1qb8XdLEdCLkBLyAM3CnnLnV54eUZsadhbQkpQWCeYb8
   zm3jtiPyuZLg7PHiMw4cY0jXMwvlwua58sDLYpzD95pwQ14POoY/Bp6+T
   q52/9kbxv2kQtG/okM/qbrjpwXTXgDdd8hxv4pmMrovtVX8SrigUghpyf
   teaW2VDEDFLncGM7c3U479fkwge6VlK+XhhIySW8oBtjvKg58sJNOvu6q
   9U7Qu+MlKAwn7XiuKXZ2v3S0jz4NQlUhE6Bj84sAw/UBSsk5JgqNiVkSo
   1trWIZZOfFA+Oqk+JsfuXcaIx2+8wjGW/RWtbCshkPEwJWSTXDyM97EKQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="335999023"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="335999023"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:49:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="1031257473"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="1031257473"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 16 May 2023 04:49:13 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pytB2-0007PO-2L;
        Tue, 16 May 2023 11:49:12 +0000
Date:   Tue, 16 May 2023 19:48:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 103d6e9d61e012d9f7d0aae33529924f9a3d78d9
Message-ID: <20230516114833.xpIR3%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230516180935/lkp-src/repo/*/wireless-next
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 103d6e9d61e012d9f7d0aae33529924f9a3d78d9  wifi: rtl8xxxu: Rename some registers

elapsed time: 811m

configs tested: 121
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230516   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230515   gcc  
arm                  randconfig-r004-20230515   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230515   clang
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230516   gcc  
arm64                randconfig-r022-20230515   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230515   gcc  
csky                 randconfig-r012-20230516   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230515   clang
i386                 randconfig-a002-20230515   clang
i386                 randconfig-a003-20230515   clang
i386                 randconfig-a004-20230515   clang
i386                 randconfig-a005-20230515   clang
i386                 randconfig-a006-20230515   clang
i386                 randconfig-a011-20230515   gcc  
i386                 randconfig-a012-20230515   gcc  
i386                 randconfig-a013-20230515   gcc  
i386                 randconfig-a014-20230515   gcc  
i386                 randconfig-a015-20230515   gcc  
i386                 randconfig-a016-20230515   gcc  
i386                          randconfig-i062   clang
i386                          randconfig-i064   clang
i386                          randconfig-i066   clang
i386                 randconfig-i071-20230515   gcc  
i386                 randconfig-i072-20230515   gcc  
i386                 randconfig-i073-20230515   gcc  
i386                 randconfig-i074-20230515   gcc  
i386                 randconfig-i075-20230515   gcc  
i386                 randconfig-i076-20230515   gcc  
i386                 randconfig-i081-20230515   gcc  
i386                 randconfig-i082-20230515   gcc  
i386                 randconfig-i083-20230515   gcc  
i386                 randconfig-i084-20230515   gcc  
i386                 randconfig-i085-20230515   gcc  
i386                 randconfig-i086-20230515   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230515   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230515   gcc  
microblaze           randconfig-r004-20230516   gcc  
microblaze           randconfig-r006-20230515   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r006-20230515   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230515   gcc  
openrisc             randconfig-r006-20230516   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230515   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230515   clang
riscv                randconfig-r004-20230515   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230516   clang
s390                                defconfig   gcc  
s390                 randconfig-r001-20230516   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230515   gcc  
sh                   randconfig-r011-20230516   gcc  
sh                   randconfig-r013-20230516   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230515   gcc  
sparc                randconfig-r025-20230515   gcc  
sparc64              randconfig-r024-20230515   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a015   gcc  
x86_64               randconfig-x051-20230515   gcc  
x86_64               randconfig-x052-20230515   gcc  
x86_64               randconfig-x053-20230515   gcc  
x86_64               randconfig-x054-20230515   gcc  
x86_64               randconfig-x055-20230515   gcc  
x86_64               randconfig-x056-20230515   gcc  
x86_64               randconfig-x081-20230515   clang
x86_64               randconfig-x082-20230515   clang
x86_64               randconfig-x083-20230515   clang
x86_64               randconfig-x084-20230515   clang
x86_64               randconfig-x085-20230515   clang
x86_64               randconfig-x086-20230515   clang
x86_64               randconfig-x091-20230515   gcc  
x86_64               randconfig-x092-20230515   gcc  
x86_64               randconfig-x093-20230515   gcc  
x86_64               randconfig-x094-20230515   gcc  
x86_64               randconfig-x095-20230515   gcc  
x86_64               randconfig-x096-20230515   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230515   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
