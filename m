Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E166D2E00
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 05:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjDADtH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 23:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjDADtF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 23:49:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AE1F76B
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 20:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680320944; x=1711856944;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=T0J+Rl41I0fYkmqcZ4gPOik1dEMUHY1KDY6Kg1s+TKs=;
  b=UESkF7VkTh93bZcPCyLKjORxNDhBXbNHpnTuctfhxWuP7AjMj9Vl1GCk
   MSfgKTOFej5wktEGi/uBGCcJf6PGBoqXKNEa9V3TntZcUtrAkYacKZkal
   I/fmTdZOfE+R6uUlhiLmiYxaGuZkdAKenlOevrMpQuJ6nyP+F3wvhNb6+
   Ry1hhQHIQYUxxlantL+WD9/4nbQUWAnpV1tguxjqhUTUXgPQ1kbW21F2u
   VAGlf5x7YUO0knN2AALVrxup4sM1A55IA5vMDeGyOtaJGrdb0dncwBZey
   HRoecsBs8JN5dMVByHvzoSlpZaKjD4NwKJXQcxxlOj2+j/2sP90zwQa+Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="321268501"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="321268501"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 20:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="662612090"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="662612090"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2023 20:45:10 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1piSAv-000MQW-2g;
        Sat, 01 Apr 2023 03:45:09 +0000
Date:   Sat, 01 Apr 2023 11:44:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 eb85df0a5643612285f61f38122564498d0c49f7
Message-ID: <6427a891.SZEIVJ+pomAtmWtA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: eb85df0a5643612285f61f38122564498d0c49f7  wifi: mt76: mt7921: fix fw used for offload check for mt7922

elapsed time: 733m

configs tested: 254
configs skipped: 21

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230329   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230329   gcc  
alpha                randconfig-r005-20230329   gcc  
alpha                randconfig-r005-20230330   gcc  
alpha                randconfig-r012-20230329   gcc  
alpha                randconfig-r016-20230329   gcc  
alpha                randconfig-r024-20230329   gcc  
alpha                randconfig-r025-20230329   gcc  
alpha                randconfig-r031-20230329   gcc  
alpha                randconfig-r034-20230329   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230329   gcc  
arc          buildonly-randconfig-r003-20230329   gcc  
arc          buildonly-randconfig-r006-20230329   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r004-20230329   gcc  
arc                  randconfig-r005-20230329   gcc  
arc                  randconfig-r013-20230329   gcc  
arc                  randconfig-r016-20230329   gcc  
arc                  randconfig-r025-20230329   gcc  
arc                  randconfig-r033-20230329   gcc  
arc                  randconfig-r035-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                  randconfig-r013-20230329   gcc  
arm                  randconfig-r025-20230329   gcc  
arm                  randconfig-r046-20230329   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230329   gcc  
arm64                randconfig-r003-20230329   gcc  
arm64                randconfig-r006-20230329   gcc  
arm64                randconfig-r023-20230331   gcc  
arm64                randconfig-r036-20230329   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230329   gcc  
csky                 randconfig-r004-20230329   gcc  
csky                 randconfig-r011-20230329   gcc  
csky                 randconfig-r022-20230329   gcc  
csky                 randconfig-r025-20230331   gcc  
csky                 randconfig-r026-20230329   gcc  
csky                 randconfig-r033-20230329   gcc  
csky                 randconfig-r035-20230329   gcc  
hexagon              randconfig-r015-20230329   clang
hexagon              randconfig-r023-20230329   clang
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r041-20230330   clang
hexagon              randconfig-r045-20230329   clang
hexagon              randconfig-r045-20230330   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230329   gcc  
ia64                 randconfig-r005-20230329   gcc  
ia64                 randconfig-r006-20230329   gcc  
ia64                 randconfig-r012-20230329   gcc  
ia64                 randconfig-r015-20230329   gcc  
ia64                 randconfig-r023-20230329   gcc  
ia64                 randconfig-r024-20230329   gcc  
ia64                 randconfig-r025-20230329   gcc  
ia64                 randconfig-r031-20230329   gcc  
ia64                 randconfig-r036-20230329   gcc  
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230329   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230329   gcc  
loongarch            randconfig-r002-20230329   gcc  
loongarch            randconfig-r002-20230330   gcc  
loongarch            randconfig-r004-20230329   gcc  
loongarch            randconfig-r005-20230330   gcc  
loongarch            randconfig-r006-20230329   gcc  
loongarch            randconfig-r021-20230329   gcc  
loongarch            randconfig-r022-20230329   gcc  
loongarch            randconfig-r023-20230329   gcc  
loongarch            randconfig-r025-20230329   gcc  
loongarch            randconfig-r026-20230329   gcc  
loongarch            randconfig-r035-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r001-20230330   gcc  
m68k                 randconfig-r004-20230329   gcc  
m68k                 randconfig-r013-20230329   gcc  
m68k                 randconfig-r015-20230329   gcc  
m68k                 randconfig-r023-20230331   gcc  
m68k                 randconfig-r031-20230329   gcc  
m68k                 randconfig-r035-20230329   gcc  
microblaze           randconfig-r013-20230329   gcc  
microblaze           randconfig-r022-20230331   gcc  
microblaze           randconfig-r023-20230329   gcc  
microblaze           randconfig-r024-20230329   gcc  
microblaze           randconfig-r024-20230331   gcc  
microblaze           randconfig-r032-20230329   gcc  
microblaze           randconfig-r036-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230329   clang
mips                 randconfig-r004-20230330   clang
mips                 randconfig-r005-20230329   clang
mips                 randconfig-r011-20230329   gcc  
mips                 randconfig-r021-20230329   gcc  
mips                 randconfig-r026-20230329   gcc  
mips                          rb532_defconfig   gcc  
nios2        buildonly-randconfig-r004-20230329   gcc  
nios2        buildonly-randconfig-r005-20230329   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230330   gcc  
nios2                randconfig-r006-20230329   gcc  
nios2                randconfig-r024-20230329   gcc  
nios2                randconfig-r026-20230329   gcc  
nios2                randconfig-r033-20230329   gcc  
nios2                randconfig-r033-20230330   gcc  
nios2                randconfig-r035-20230329   gcc  
nios2                randconfig-r036-20230330   gcc  
openrisc     buildonly-randconfig-r002-20230329   gcc  
openrisc     buildonly-randconfig-r003-20230329   gcc  
openrisc     buildonly-randconfig-r006-20230329   gcc  
openrisc             randconfig-r004-20230329   gcc  
openrisc             randconfig-r006-20230329   gcc  
openrisc             randconfig-r006-20230330   gcc  
openrisc             randconfig-r011-20230329   gcc  
openrisc             randconfig-r021-20230329   gcc  
openrisc             randconfig-r034-20230329   gcc  
openrisc             randconfig-r036-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230330   gcc  
parisc               randconfig-r004-20230329   gcc  
parisc               randconfig-r006-20230329   gcc  
parisc               randconfig-r014-20230329   gcc  
parisc               randconfig-r015-20230329   gcc  
parisc               randconfig-r022-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                 mpc8560_ads_defconfig   clang
powerpc              randconfig-r003-20230329   gcc  
powerpc              randconfig-r011-20230329   clang
powerpc              randconfig-r032-20230329   gcc  
powerpc              randconfig-r034-20230329   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230329   clang
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230330   gcc  
riscv                randconfig-r002-20230330   gcc  
riscv                randconfig-r005-20230329   gcc  
riscv                randconfig-r006-20230329   gcc  
riscv                randconfig-r013-20230329   clang
riscv                randconfig-r016-20230329   clang
riscv                randconfig-r021-20230331   gcc  
riscv                randconfig-r032-20230329   gcc  
riscv                randconfig-r035-20230329   gcc  
riscv                randconfig-r042-20230329   clang
riscv                randconfig-r042-20230330   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230329   clang
s390         buildonly-randconfig-r003-20230329   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230329   gcc  
s390                 randconfig-r003-20230329   gcc  
s390                 randconfig-r005-20230329   gcc  
s390                 randconfig-r014-20230329   clang
s390                 randconfig-r016-20230329   clang
s390                 randconfig-r031-20230329   gcc  
s390                 randconfig-r032-20230329   gcc  
s390                 randconfig-r033-20230329   gcc  
s390                 randconfig-r035-20230329   gcc  
s390                 randconfig-r044-20230329   clang
s390                 randconfig-r044-20230330   clang
sh                               allmodconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r005-20230329   gcc  
sh                   randconfig-r006-20230329   gcc  
sh                   randconfig-r014-20230329   gcc  
sh                   randconfig-r023-20230329   gcc  
sh                   randconfig-r032-20230329   gcc  
sh                          rsk7203_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230329   gcc  
sparc                randconfig-r005-20230329   gcc  
sparc                randconfig-r006-20230329   gcc  
sparc                randconfig-r006-20230330   gcc  
sparc                randconfig-r022-20230329   gcc  
sparc                randconfig-r024-20230331   gcc  
sparc64      buildonly-randconfig-r004-20230329   gcc  
sparc64              randconfig-r002-20230329   gcc  
sparc64              randconfig-r003-20230329   gcc  
sparc64              randconfig-r012-20230329   gcc  
sparc64              randconfig-r024-20230329   gcc  
sparc64              randconfig-r025-20230329   gcc  
sparc64              randconfig-r026-20230331   gcc  
sparc64              randconfig-r031-20230329   gcc  
sparc64              randconfig-r034-20230329   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230329   gcc  
xtensa               randconfig-r021-20230329   gcc  
xtensa               randconfig-r021-20230331   gcc  
xtensa               randconfig-r026-20230329   gcc  
xtensa               randconfig-r031-20230329   gcc  
xtensa               randconfig-r033-20230329   gcc  
xtensa               randconfig-r036-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
