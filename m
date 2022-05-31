Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060D45389C0
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 03:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbiEaB7x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 21:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiEaB7w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 21:59:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32224BD8
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653962391; x=1685498391;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=nhfFxUrl7t813aM7tpWV7PVZUBxCTGJt+Y8QIWErefw=;
  b=Za9lASaa/79HvKDCmtw5WSM603qsdRH/AUL6z/pOGT1FHxNtJi6MmCK8
   Wyn5S/S8WWVLU4Ch0w2VNBSAFiZ2fTRJZD6cQBy3f7lVK2yZm3qJrns+5
   tKocqa4AK2XSmMqoTZZDGhKuod4gd1okSiCm4pmGohJ5UxGhvAmw2SQdu
   GigneS6aDmq6AoDHnIXXSp51J/c1GFlEoTJYykJPVsPfXCkiRttMv3hlz
   HNaR9SCUsGVeWKaOAXQjoO3ZJ6KVhUEO1U9D5FQ8XnHPBlNN365+fLNOn
   Zrtr4h8gsoudMT8ac7+vIaObDgUlY2tAYhwTh9YRJ0wxJtynY9rLem3hk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="300461566"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="300461566"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 18:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="632814029"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 May 2022 18:59:50 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvrAj-0002Cb-EH;
        Tue, 31 May 2022 01:59:49 +0000
Date:   Tue, 31 May 2022 09:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 7711fe713a4987695ac6c68c9f175cb2d1d06e83
Message-ID: <62957683.9aw4e6hraneKM0SA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 7711fe713a4987695ac6c68c9f175cb2d1d06e83  wifi: rtw88: add a work to correct atomic scheduling warning of ::set_tim

elapsed time: 996m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20220530
powerpc                     tqm8555_defconfig
sh                             espt_defconfig
powerpc                      chrp32_defconfig
s390                          debug_defconfig
ia64                      gensparse_defconfig
xtensa                       common_defconfig
parisc                generic-32bit_defconfig
arm                       omap2plus_defconfig
sh                        sh7785lcr_defconfig
sh                             shx3_defconfig
sh                            migor_defconfig
mips                 decstation_r4k_defconfig
m68k                        mvme147_defconfig
sh                           se7722_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     taishan_defconfig
sh                        sh7763rdp_defconfig
arc                           tb10x_defconfig
m68k                       m5249evb_defconfig
ia64                             alldefconfig
m68k                       bvme6000_defconfig
m68k                          amiga_defconfig
mips                           jazz_defconfig
sh                           se7780_defconfig
sh                           se7619_defconfig
arm                  randconfig-c002-20220530
x86_64               randconfig-c001-20220530
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                             allyesconfig
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20220530
i386                 randconfig-a006-20220530
i386                 randconfig-a003-20220530
i386                 randconfig-a004-20220530
i386                 randconfig-a005-20220530
i386                 randconfig-a001-20220530
x86_64               randconfig-a003-20220530
x86_64               randconfig-a004-20220530
x86_64               randconfig-a001-20220530
x86_64               randconfig-a002-20220530
x86_64               randconfig-a006-20220530
x86_64               randconfig-a005-20220530
arc                  randconfig-r043-20220530
riscv                               defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
powerpc                   bluestone_defconfig
mips                     loongson1c_defconfig
arm                          ixp4xx_defconfig
arm                       mainstone_defconfig
arm                         lpc32xx_defconfig
arm                      tct_hammer_defconfig
arm                         s3c2410_defconfig
arm                             mxs_defconfig
arm                          pxa168_defconfig
mips                     loongson2k_defconfig
x86_64               randconfig-a011-20220530
x86_64               randconfig-a013-20220530
x86_64               randconfig-a012-20220530
x86_64               randconfig-a014-20220530
x86_64               randconfig-a015-20220530
x86_64               randconfig-a016-20220530
i386                 randconfig-a016-20220530
i386                 randconfig-a012-20220530
i386                 randconfig-a011-20220530
i386                 randconfig-a014-20220530
i386                 randconfig-a013-20220530
i386                 randconfig-a015-20220530
s390                 randconfig-r044-20220530
hexagon              randconfig-r041-20220530
hexagon              randconfig-r045-20220530
riscv                randconfig-r042-20220530

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
