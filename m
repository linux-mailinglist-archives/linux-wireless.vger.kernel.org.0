Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADA961763D
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Nov 2022 06:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiKCFjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Nov 2022 01:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKCFjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Nov 2022 01:39:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006213F2D
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 22:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667453960; x=1698989960;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=wyJX14wO88SU/ywW1RbSaOGzKXJk/urorhDVeSuIb+4=;
  b=Q9edW/nck4sd5U3cQhxzqYuiWOXgG8SQDcg2wiD2ZUMAM1JEyBi0h7CT
   jy0GVjP3t1rSukqwkCmKVjoaq2nSNh//SLK7KjhC4BIag+7hDpzBmfp7I
   Hk+H79cnj6ujBGWy+xt019JDFdJ2fxWxkoicTgcZoR5+f+6OfElTgOwo3
   GxZesfKqtPlMtyHsXr6Jeu/jtDCJrTvo147l06DlReeSAA0RcWMH9c03I
   sHSGUin79HDLwS/E0ZLHichHjARUbWLn0CpJy1VQRGvdo1g9jzkqwe68A
   Q6t/gATbCCYpNpiquZyyaiHPXJkr78sVfjqc9pmc7LM6LiiovfbmsYPS4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="297047395"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="297047395"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 22:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="703540224"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="703540224"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2022 22:39:19 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oqSwg-000FXl-1t;
        Thu, 03 Nov 2022 05:39:18 +0000
Date:   Thu, 03 Nov 2022 13:39:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <quic_kvalo@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 f45cb6b29cd36514e13f7519770873d8c0457008
Message-ID: <636353f5.86JEagpWmapnaH2+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: f45cb6b29cd36514e13f7519770873d8c0457008  wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()

elapsed time: 724m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
alpha                               defconfig
s390                             allmodconfig
ia64                             allmodconfig
s390                                defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
sh                               allmodconfig
i386                          randconfig-a001
s390                             allyesconfig
i386                          randconfig-a003
x86_64                           rhel-8.3-kvm
x86_64                              defconfig
x86_64                           rhel-8.3-syz
m68k                             allmodconfig
arc                              allyesconfig
x86_64                           allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                             allyesconfig
i386                                defconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
m68k                       m5208evb_defconfig
powerpc                         wii_defconfig
m68k                       m5275evb_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
m68k                         apollo_defconfig
mips                     decstation_defconfig
sparc                       sparc32_defconfig
m68k                          multi_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                        multi_v7_defconfig
arm                         s3c6400_defconfig
sh                        apsh4ad0a_defconfig
arm                           tegra_defconfig
sh                          rsk7203_defconfig
i386                          randconfig-c001
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
um                                  defconfig
parisc64                            defconfig
powerpc                   motionpro_defconfig
parisc                generic-32bit_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                               alldefconfig
sh                                  defconfig
arc                            hsdk_defconfig
sh                 kfr2r09-romimage_defconfig
parisc                           allyesconfig
arm                            pleb_defconfig
arm                  randconfig-c002-20221102
x86_64                        randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
arm                       cns3420vb_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221102
hexagon              randconfig-r045-20221102
riscv                randconfig-r042-20221103
hexagon              randconfig-r041-20221103
hexagon              randconfig-r045-20221103
s390                 randconfig-r044-20221103
mips                     loongson1c_defconfig
mips                           mtx1_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                    nommu_virt_defconfig
mips                       rbtx49xx_defconfig
arm                         socfpga_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                          g5_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
