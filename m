Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C126A3B2B
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 07:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjB0GK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 01:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjB0GK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 01:10:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391412859
        for <linux-wireless@vger.kernel.org>; Sun, 26 Feb 2023 22:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677478226; x=1709014226;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9vk2WMVcQRmYFLjMdTmuVccawsPRCLsnQaOYvJhrucI=;
  b=jO6a2NMa8Q6JlnBG/HoJAPdBd/OBK985fjwtGXkqiKWY0Ph4T16I60GK
   I2TFim+7rL4EesREQPzerMYAlyd/RasmkGI911mcXnZ4NCzMkHEnBApPh
   1EZjWQl5NpxhmhfdRNCNzONdx/0V6o3VD1Flq6bGuLs9pmHrIINLSc3EF
   KRY1xXSgYsiSFwCqBNVWiGQE6lNMrkc2wl4D0qpqnaYdjvWBRyJUnsSX9
   vUdz9S7KssUmqdUHHGVLQg+SHhdn4hbWHkJ3/ei/kLLNCoWEdsr/Pol8c
   CvfPyxRU45WbkpXmzmPWN1+pjE8q6ZAws/mhVDdvq8fbDmPJBEpGg2G5o
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="335265951"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="335265951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 22:10:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="762532661"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="762532661"
Received: from lkp-server01.sh.intel.com (HELO 3895f5c55ead) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Feb 2023 22:10:23 -0800
Received: from kbuild by 3895f5c55ead with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pWWiN-00048R-0q;
        Mon, 27 Feb 2023 06:10:23 +0000
Date:   Mon, 27 Feb 2023 14:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 52fd90638a7269be2a6f6cf1e4dea6724f8e13b6
Message-ID: <63fc492e.OjDh6qkNA0jDECV0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 52fd90638a7269be2a6f6cf1e4dea6724f8e13b6  wifi: wext: warn about usage only once

elapsed time: 725m

configs tested: 273
configs skipped: 25

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230226   gcc  
alpha        buildonly-randconfig-r001-20230227   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230227   gcc  
alpha                randconfig-r015-20230226   gcc  
alpha                randconfig-r021-20230227   gcc  
alpha                randconfig-r035-20230226   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230226   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230226   gcc  
arc                  randconfig-r011-20230226   gcc  
arc                  randconfig-r011-20230227   gcc  
arc                  randconfig-r021-20230226   gcc  
arc                  randconfig-r021-20230227   gcc  
arc                  randconfig-r022-20230226   gcc  
arc                  randconfig-r032-20230226   gcc  
arc                  randconfig-r033-20230226   gcc  
arc                  randconfig-r034-20230226   gcc  
arc                  randconfig-r035-20230227   gcc  
arc                  randconfig-r036-20230227   gcc  
arc                  randconfig-r043-20230226   gcc  
arc                  randconfig-r043-20230227   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230226   gcc  
arm          buildonly-randconfig-r005-20230226   gcc  
arm          buildonly-randconfig-r005-20230227   clang
arm          buildonly-randconfig-r006-20230226   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230227   gcc  
arm                  randconfig-r025-20230226   gcc  
arm                  randconfig-r033-20230227   gcc  
arm                  randconfig-r034-20230227   gcc  
arm                  randconfig-r036-20230226   clang
arm                  randconfig-r046-20230226   gcc  
arm                  randconfig-r046-20230227   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230227   clang
arm64        buildonly-randconfig-r005-20230226   gcc  
arm64        buildonly-randconfig-r005-20230227   clang
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230226   gcc  
arm64                randconfig-r005-20230226   gcc  
arm64                randconfig-r005-20230227   clang
arm64                randconfig-r012-20230226   clang
arm64                randconfig-r015-20230226   clang
arm64                randconfig-r024-20230227   gcc  
arm64                randconfig-r034-20230227   clang
arm64                randconfig-r036-20230227   clang
csky         buildonly-randconfig-r001-20230226   gcc  
csky         buildonly-randconfig-r004-20230226   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230226   gcc  
csky                 randconfig-r003-20230227   gcc  
csky                 randconfig-r004-20230227   gcc  
csky                 randconfig-r013-20230227   gcc  
csky                 randconfig-r014-20230227   gcc  
csky                 randconfig-r021-20230226   gcc  
csky                 randconfig-r021-20230227   gcc  
csky                 randconfig-r023-20230227   gcc  
csky                 randconfig-r036-20230226   gcc  
hexagon      buildonly-randconfig-r003-20230227   clang
hexagon      buildonly-randconfig-r006-20230227   clang
hexagon              randconfig-r002-20230226   clang
hexagon              randconfig-r014-20230226   clang
hexagon              randconfig-r015-20230227   clang
hexagon              randconfig-r016-20230226   clang
hexagon              randconfig-r022-20230226   clang
hexagon              randconfig-r024-20230227   clang
hexagon              randconfig-r026-20230226   clang
hexagon              randconfig-r031-20230226   clang
hexagon              randconfig-r032-20230227   clang
hexagon              randconfig-r035-20230227   clang
hexagon              randconfig-r041-20230226   clang
hexagon              randconfig-r041-20230227   clang
hexagon              randconfig-r045-20230226   clang
hexagon              randconfig-r045-20230227   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230227   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230227   clang
i386                          randconfig-a001   gcc  
i386                 randconfig-a002-20230227   clang
i386                          randconfig-a002   clang
i386                 randconfig-a003-20230227   clang
i386                          randconfig-a003   gcc  
i386                 randconfig-a004-20230227   clang
i386                          randconfig-a004   clang
i386                 randconfig-a005-20230227   clang
i386                          randconfig-a005   gcc  
i386                 randconfig-a006-20230227   clang
i386                          randconfig-a006   clang
i386                 randconfig-a011-20230227   gcc  
i386                 randconfig-a012-20230227   gcc  
i386                 randconfig-a013-20230227   gcc  
i386                 randconfig-a014-20230227   gcc  
i386                 randconfig-a015-20230227   gcc  
i386                 randconfig-a016-20230227   gcc  
i386                 randconfig-r032-20230227   clang
i386                 randconfig-r034-20230227   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230227   gcc  
ia64         buildonly-randconfig-r002-20230227   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230226   gcc  
ia64                 randconfig-r006-20230226   gcc  
ia64                 randconfig-r013-20230227   gcc  
ia64                 randconfig-r022-20230227   gcc  
ia64                 randconfig-r023-20230226   gcc  
ia64                 randconfig-r024-20230226   gcc  
ia64                 randconfig-r031-20230227   gcc  
ia64                 randconfig-r033-20230226   gcc  
ia64                 randconfig-r036-20230226   gcc  
ia64                 randconfig-r036-20230227   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230226   gcc  
loongarch    buildonly-randconfig-r004-20230226   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230226   gcc  
loongarch            randconfig-r001-20230227   gcc  
loongarch            randconfig-r002-20230226   gcc  
loongarch            randconfig-r002-20230227   gcc  
loongarch            randconfig-r003-20230226   gcc  
loongarch            randconfig-r005-20230227   gcc  
loongarch            randconfig-r025-20230227   gcc  
loongarch            randconfig-r031-20230226   gcc  
loongarch            randconfig-r034-20230226   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230226   gcc  
m68k                 randconfig-r002-20230227   gcc  
m68k                 randconfig-r004-20230226   gcc  
m68k                 randconfig-r011-20230226   gcc  
m68k                 randconfig-r013-20230227   gcc  
m68k                 randconfig-r025-20230227   gcc  
m68k                 randconfig-r034-20230226   gcc  
microblaze   buildonly-randconfig-r003-20230226   gcc  
microblaze   buildonly-randconfig-r006-20230226   gcc  
microblaze   buildonly-randconfig-r006-20230227   gcc  
microblaze           randconfig-r006-20230227   gcc  
microblaze           randconfig-r014-20230227   gcc  
microblaze           randconfig-r016-20230226   gcc  
microblaze           randconfig-r034-20230226   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r004-20230227   gcc  
mips                 randconfig-r011-20230226   gcc  
mips                 randconfig-r015-20230226   gcc  
mips                 randconfig-r016-20230227   clang
mips                 randconfig-r024-20230226   gcc  
mips                 randconfig-r033-20230226   clang
mips                 randconfig-r034-20230227   gcc  
mips                 randconfig-r035-20230226   clang
nios2        buildonly-randconfig-r003-20230227   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230227   gcc  
nios2                randconfig-r012-20230226   gcc  
nios2                randconfig-r021-20230226   gcc  
nios2                randconfig-r023-20230226   gcc  
nios2                randconfig-r032-20230226   gcc  
openrisc     buildonly-randconfig-r002-20230227   gcc  
openrisc             randconfig-r002-20230227   gcc  
openrisc             randconfig-r012-20230227   gcc  
openrisc             randconfig-r016-20230226   gcc  
openrisc             randconfig-r021-20230226   gcc  
openrisc             randconfig-r025-20230226   gcc  
openrisc             randconfig-r026-20230226   gcc  
openrisc             randconfig-r031-20230226   gcc  
openrisc             randconfig-r031-20230227   gcc  
openrisc             randconfig-r036-20230226   gcc  
parisc       buildonly-randconfig-r004-20230226   gcc  
parisc       buildonly-randconfig-r004-20230227   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230226   gcc  
parisc               randconfig-r006-20230227   gcc  
parisc               randconfig-r013-20230226   gcc  
parisc               randconfig-r025-20230226   gcc  
parisc               randconfig-r026-20230227   gcc  
parisc               randconfig-r032-20230226   gcc  
parisc               randconfig-r033-20230227   gcc  
parisc               randconfig-r035-20230227   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230227   gcc  
powerpc              randconfig-r012-20230227   gcc  
powerpc              randconfig-r022-20230226   clang
powerpc              randconfig-r025-20230227   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230227   clang
riscv                randconfig-r003-20230227   clang
riscv                randconfig-r004-20230227   clang
riscv                randconfig-r005-20230227   clang
riscv                randconfig-r006-20230226   gcc  
riscv                randconfig-r006-20230227   clang
riscv                randconfig-r013-20230226   clang
riscv                randconfig-r014-20230227   gcc  
riscv                randconfig-r023-20230226   clang
riscv                randconfig-r026-20230226   clang
riscv                randconfig-r042-20230226   clang
riscv                randconfig-r042-20230227   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230227   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230226   gcc  
s390                 randconfig-r006-20230227   clang
s390                 randconfig-r023-20230227   gcc  
s390                 randconfig-r033-20230227   clang
s390                 randconfig-r044-20230226   clang
s390                 randconfig-r044-20230227   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230227   gcc  
sh                   randconfig-r005-20230226   gcc  
sh                   randconfig-r025-20230226   gcc  
sh                   randconfig-r026-20230227   gcc  
sh                   randconfig-r035-20230226   gcc  
sparc        buildonly-randconfig-r001-20230227   gcc  
sparc        buildonly-randconfig-r002-20230226   gcc  
sparc        buildonly-randconfig-r006-20230227   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230227   gcc  
sparc                randconfig-r004-20230226   gcc  
sparc                randconfig-r015-20230227   gcc  
sparc                randconfig-r016-20230227   gcc  
sparc                randconfig-r022-20230227   gcc  
sparc                randconfig-r024-20230227   gcc  
sparc                randconfig-r026-20230226   gcc  
sparc64      buildonly-randconfig-r004-20230226   gcc  
sparc64              randconfig-r003-20230226   gcc  
sparc64              randconfig-r005-20230226   gcc  
sparc64              randconfig-r012-20230226   gcc  
sparc64              randconfig-r012-20230227   gcc  
sparc64              randconfig-r014-20230226   gcc  
sparc64              randconfig-r015-20230226   gcc  
sparc64              randconfig-r036-20230227   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r003-20230227   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230227   clang
x86_64               randconfig-a002-20230227   clang
x86_64               randconfig-a003-20230227   clang
x86_64               randconfig-a004-20230227   clang
x86_64               randconfig-a005-20230227   clang
x86_64               randconfig-a006-20230227   clang
x86_64               randconfig-a011-20230227   gcc  
x86_64               randconfig-a012-20230227   gcc  
x86_64               randconfig-a013-20230227   gcc  
x86_64               randconfig-a014-20230227   gcc  
x86_64               randconfig-a015-20230227   gcc  
x86_64               randconfig-a016-20230227   gcc  
x86_64               randconfig-r011-20230227   gcc  
x86_64               randconfig-r022-20230227   gcc  
x86_64               randconfig-r023-20230227   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230227   gcc  
xtensa       buildonly-randconfig-r006-20230226   gcc  
xtensa               randconfig-r002-20230226   gcc  
xtensa               randconfig-r004-20230227   gcc  
xtensa               randconfig-r032-20230226   gcc  
xtensa               randconfig-r033-20230226   gcc  
xtensa               randconfig-r033-20230227   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
