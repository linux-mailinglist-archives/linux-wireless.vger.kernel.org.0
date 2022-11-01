Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C35615628
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 00:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKAXhf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 19:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKAXhd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 19:37:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5FA1C41A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667345852; x=1698881852;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EkD5ZjNbcdGTv0Dq0P9iDliV9EYQPB3so81Xsq5bf3A=;
  b=P+eob1N77RhJR5WvZWPL/NyC151Gk8H9oYENhKMrnmrNa0c/UXBUZwTv
   q/71QHJFfUHMnUV25nPYQ6v7GhYh8ES35ul4U0m3w6UgKpk4KZQRV6Al8
   XUPKMD78r4bfqoD8q/nA/nODqFdIAJbAbxoMimBmkSc936bmwLS5UyyNB
   V5CUfvPuMcSvn3w+GlLlX38E4NnXprfkRJComw6nEbCtd8sNDqSKiEbUb
   ZnWcB9fuGk+PSeejWxt80og+jZ8ZbOlp5I7wNzMTB0R94emP2JeF75qMG
   gwKmR+wKzH30pKGLl6WahSQD/mz1ey1EFFMH/1xxFTmicq2Nl5nfS+DaR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="373489373"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="373489373"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 16:37:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="963306569"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="963306569"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 01 Nov 2022 16:37:30 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oq0oz-000EAa-1Z;
        Tue, 01 Nov 2022 23:37:29 +0000
Date:   Wed, 02 Nov 2022 07:36:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 57d545b5a3d6ce3a8fb6b093f02bfcbb908973f3
Message-ID: <6361ad82.IfOdyNnSg3O5E69d%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 57d545b5a3d6ce3a8fb6b093f02bfcbb908973f3  wifi: wilc1000: sdio: fix module autoloading

elapsed time: 729m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
um                             i386_defconfig
um                           x86_64_defconfig
s390                                defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                              defconfig
s390                             allmodconfig
x86_64                        randconfig-a002
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                          randconfig-a016
i386                                defconfig
x86_64                        randconfig-a004
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a015
x86_64               randconfig-a016-20221031
x86_64               randconfig-a011-20221031
x86_64               randconfig-a013-20221031
x86_64               randconfig-a012-20221031
x86_64               randconfig-a014-20221031
x86_64               randconfig-a015-20221031
x86_64               randconfig-k001-20221031
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20221101
i386                          randconfig-a012
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
s390                             allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
powerpc                          allmodconfig
ia64                             allmodconfig
alpha                            allyesconfig
mips                             allyesconfig
sh                               allmodconfig
arm                                 defconfig
m68k                             allyesconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                         lubbock_defconfig
powerpc                      chrp32_defconfig
m68k                                defconfig
arm                            mps2_defconfig
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
mips                           jazz_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
sh                              ul2_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                       virt_defconfig
powerpc                 canyonlands_defconfig
i386                          randconfig-c001
i386                 randconfig-c001-20221031
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
um                                  defconfig
arm                         s3c6400_defconfig
m68k                       m5249evb_defconfig
arm                            qcom_defconfig
s390                 randconfig-r044-20221031
riscv                randconfig-r042-20221031
arc                  randconfig-r043-20221031
powerpc                      arches_defconfig
powerpc                    klondike_defconfig
mips                 randconfig-c004-20221031
openrisc                            defconfig
mips                    maltaup_xpa_defconfig
arc                      axs103_smp_defconfig
arm                       omap2plus_defconfig
arm                          iop32x_defconfig
riscv                    nommu_k210_defconfig
sh                        sh7757lcr_defconfig
openrisc                    or1ksim_defconfig
powerpc                     stx_gp3_defconfig
ia64                        generic_defconfig
sh                          rsk7203_defconfig
sh                      rts7751r2d1_defconfig
arm                             ezx_defconfig
arm                           sama5_defconfig
ia64                            zx1_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                         db1xxx_defconfig
mips                            ar7_defconfig
sh                     sh7710voipgw_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
s390                 randconfig-r044-20221101
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
x86_64                        randconfig-a014
i386                          randconfig-a015
hexagon              randconfig-r045-20221101
x86_64                        randconfig-a016
riscv                randconfig-r042-20221101
hexagon              randconfig-r041-20221101
i386                          randconfig-a011
x86_64                        randconfig-a005
powerpc                   bluestone_defconfig
arm                        magician_defconfig
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
mips                        qi_lb60_defconfig
arm                      pxa255-idp_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
