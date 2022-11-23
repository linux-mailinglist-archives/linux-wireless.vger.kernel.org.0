Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3595635819
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 10:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbiKWJum (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 04:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbiKWJt4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 04:49:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC42111604A
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 01:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669196829; x=1700732829;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=I4Uef0SVvsdwl3Yv9/XqoPqad6+Ci2CuVycq8pow9Mo=;
  b=FXl0zjWm53zZ+IDRQgNNIenniY/xiYtTY7EeD9ybqWHGencsvc1KZ7DT
   8EyEntM3GLgNbtj7l/6/sKK8DaE+bdg3BzvTKPW9c0f8o/UUiW+pVsy1V
   LTr+2kWJdnuifVe1XTh4Y6aM3rvq1eplAcEFKyaDp5ffyLIiZ9NRbjkn8
   DrCGZgaO/JX4gnH/HjtJvWOSIeCg4jXijWmlJC5NHCEsef21PuP7x22ch
   JU914dxJmcPr4ENqH/jpyUzosvj7P6SVOP8iy15NLyOaaG86tTJCDzXB5
   QSon2h3kRIujJnuo0H2k9ztWSNAenPRTIX6QoVwIxcdaqOnZHbRe14Ryj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="311656977"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="311656977"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 01:47:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="705296894"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="705296894"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Nov 2022 01:47:08 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxmLT-0002al-2L;
        Wed, 23 Nov 2022 09:47:07 +0000
Date:   Wed, 23 Nov 2022 17:46:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 2d0b08c157434eebf0b6393c570089666dacf2aa
Message-ID: <637debfa.qvFe6AlZLSqtR9gH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 2d0b08c157434eebf0b6393c570089666dacf2aa  MAINTAINERS: mark rsi wifi driver as orphan

elapsed time: 1389m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
s390                             allmodconfig
s390                                defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
mips                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                             allyesconfig
ia64                             allmodconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
x86_64                           rhel-8.3-syz
i386                 randconfig-a014-20221121
i386                 randconfig-a016-20221121
i386                 randconfig-a015-20221121
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                             allyesconfig
i386                                defconfig
x86_64                            allnoconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a014-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a015-20221121
arm                      footbridge_defconfig
powerpc                       eiger_defconfig
sparc                       sparc32_defconfig
powerpc                    sam440ep_defconfig
sparc                            alldefconfig
sh                           se7705_defconfig
m68k                        stmark2_defconfig
arc                              allyesconfig
s390                 randconfig-r044-20221121
riscv                randconfig-r042-20221121
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
i386                          randconfig-c001
arm                        trizeps4_defconfig
m68k                       m5275evb_defconfig
arc                          axs103_defconfig
arm                                 defconfig
arm                              allyesconfig
sh                              ul2_defconfig
sh                           se7780_defconfig
sh                          sdk7780_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
sh                             espt_defconfig
m68k                       m5208evb_defconfig
arm                          gemini_defconfig
arm                            pleb_defconfig
parisc                generic-64bit_defconfig
sh                     sh7710voipgw_defconfig
m68k                             allyesconfig
alpha                            allyesconfig
m68k                             allmodconfig
powerpc                      pcm030_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                         haps_hs_defconfig
arc                      axs103_smp_defconfig
loongarch                         allnoconfig
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
m68k                                defconfig
powerpc                      makalu_defconfig
ia64                      gensparse_defconfig
xtensa                          iss_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sh                   rts7751r2dplus_defconfig
m68k                        m5307c3_defconfig
openrisc                    or1ksim_defconfig
loongarch                           defconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
arm                           sunxi_defconfig
sh                         ap325rxa_defconfig
sparc                               defconfig
csky                                defconfig
x86_64                                  kexec
arc                    vdk_hs38_smp_defconfig
arm                              allmodconfig
loongarch                        allmodconfig
arm64                            allyesconfig
nios2                            allyesconfig
parisc                           allyesconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
powerpc                    mvme5100_defconfig
arm                         bcm2835_defconfig
arm                         lpc32xx_defconfig
i386                 randconfig-a001-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
x86_64                        randconfig-k001
x86_64               randconfig-a002-20221121
x86_64               randconfig-a001-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
x86_64               randconfig-a003-20221121
powerpc                   bluestone_defconfig
arm                          moxart_defconfig
hexagon                             defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
powerpc                    gamecube_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                     cu1000-neo_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
s390                 randconfig-r044-20221122
hexagon              randconfig-r041-20221122
riscv                randconfig-r042-20221122
hexagon              randconfig-r045-20221122

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
