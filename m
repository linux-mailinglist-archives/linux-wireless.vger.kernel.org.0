Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450D461A65F
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Nov 2022 01:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiKEAR7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 20:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKEARt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 20:17:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C3740451
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667607468; x=1699143468;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=x+GMsHkil9io6MFCqU20YVFfv8TH2sROXwyHcvd73UE=;
  b=VTF713QJoz8YifIeEQa0OuqtIjvS+9tcNMDqPQZyR3C5n1P5dYYElzrQ
   TKv8ZGt90mzwfr+/xPo4wEcmjkGDItVxjC10XuDZmTQvlInrUaJaFevmF
   NQLmi9TBWBMxdCI7fVEExxuEoZOZylK4ksgmdeDb34NKdDN/DRpzMqGUX
   H/mqfn35g+kTDqRZ1V9qmYn0Q2Tu/GN9AWynmhbwSy0WdbDpiWfTvkpf6
   WWC/VMMUd6goNY0iyUGkcRnNyllgJgSUXdt4jyEUtp/G9U+nlH1S8qiIT
   lzdtKfyEcAKSRBhiqJDoKA0tXfZLtw/+o8m5VS0JrR6tZDhGKwSgIOPgT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="372211042"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="372211042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 17:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="964527485"
X-IronPort-AV: E=Sophos;i="5.96,139,1665471600"; 
   d="scan'208";a="964527485"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2022 17:17:46 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1or6sc-000HTB-04;
        Sat, 05 Nov 2022 00:17:46 +0000
Date:   Sat, 05 Nov 2022 08:17:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 bd954a7e4aa0739630884fc572d2d0e4dcd16e25
Message-ID: <6365aba5.lTti1uYFeJ5xOIgK%lkp@intel.com>
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
branch HEAD: bd954a7e4aa0739630884fc572d2d0e4dcd16e25  wifi: rtl8xxxu: Use dev_* instead of pr_info

elapsed time: 727m

configs tested: 78
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
ia64                             allmodconfig
m68k                             allyesconfig
arc                  randconfig-r043-20221104
x86_64                              defconfig
um                             i386_defconfig
arc                                 defconfig
um                           x86_64_defconfig
riscv                randconfig-r042-20221104
s390                             allmodconfig
s390                 randconfig-r044-20221104
i386                          randconfig-a014
x86_64                               rhel-8.3
i386                          randconfig-a012
i386                          randconfig-a016
alpha                               defconfig
x86_64                        randconfig-a013
x86_64                           allyesconfig
i386                                defconfig
x86_64                        randconfig-a004
s390                                defconfig
x86_64                        randconfig-a011
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a002
alpha                            allyesconfig
i386                          randconfig-a001
powerpc                           allnoconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
i386                          randconfig-a003
powerpc                          allmodconfig
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
s390                             allyesconfig
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
i386                          randconfig-a005
m68k                             allmodconfig
sh                               allmodconfig
arc                              allyesconfig
x86_64                        randconfig-a006
arm                                 defconfig
i386                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
m68k                       m5208evb_defconfig
sh                   sh7724_generic_defconfig
powerpc                   currituck_defconfig
powerpc                      ppc40x_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 linkstation_defconfig
arm                         cm_x300_defconfig
powerpc                     taishan_defconfig
powerpc                      ppc6xx_defconfig
mips                     loongson1b_defconfig
arm                           viper_defconfig
arm                       multi_v4t_defconfig
powerpc                      pasemi_defconfig
i386                          randconfig-c001

clang tested configs:
hexagon              randconfig-r041-20221104
hexagon              randconfig-r045-20221104
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a005
i386                          randconfig-a002
x86_64                        randconfig-a014
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
powerpc                   bluestone_defconfig
mips                        qi_lb60_defconfig
x86_64                        randconfig-k001
mips                        bcm63xx_defconfig
arm                        spear3xx_defconfig
mips                           ip28_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
