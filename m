Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2E5FBCB9
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJKVQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 17:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJKVQv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 17:16:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546F25BC3E
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665523010; x=1697059010;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=I9CRj8I9HqObmURoLLC0GvQRlf15ddQs9vKjCmMiaeo=;
  b=bYHK+Xeuxh5i4lPl61iDiWJASYm9X9IQ9AkYSWMOziYf4e2Fhu9jHMzs
   odU8xZ8HLHvR/f6Y6YoxBmIWWmdPS20PNNPr56Pl82o5LaQOBS+VaBv81
   OAlS3wE5Oc6qXveJIcaicReGQWz1w42ArRG9PlbOEsjk4oetYOUM+eteV
   G5O9U1p2udn7uZdb2g0uSltqwOd6/hIc7auYCgj7tIE/7nPGbxVuICNYo
   QEd1ODXTuRVu3mKfJt9/4qXZXxhRyX92np7xrH38heQFepKw/8bYzsA5E
   53xgTL8B1Xmqcar7xSfttG1YhFeEc9AHoAvQsNimYhF/Oy7anuvql7fmf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="304615025"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="304615025"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 14:16:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="577588836"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="577588836"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2022 14:16:48 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oiMcJ-0003AZ-2R;
        Tue, 11 Oct 2022 21:16:47 +0000
Date:   Wed, 12 Oct 2022 05:16:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 abf93f369419249ca482a8911039fe1c75a94227
Message-ID: <6345dd13.42ai0KzG62grZOQE%lkp@intel.com>
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
branch HEAD: abf93f369419249ca482a8911039fe1c75a94227  wifi: ath11k: mac: fix reading 16 bytes from a region of size 0 warning

elapsed time: 725m

configs tested: 122
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                              defconfig
s390                                defconfig
s390                             allmodconfig
x86_64                               rhel-8.3
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                           allyesconfig
mips                             allyesconfig
s390                             allyesconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
s390                 randconfig-r044-20221010
sh                               allmodconfig
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
arc                  randconfig-r043-20221010
m68k                             allyesconfig
m68k                             allmodconfig
i386                                defconfig
alpha                            allyesconfig
i386                 randconfig-a016-20221010
riscv                randconfig-r042-20221010
x86_64               randconfig-a011-20221010
i386                 randconfig-a012-20221010
arc                              allyesconfig
arm64                            allyesconfig
i386                 randconfig-a011-20221010
x86_64               randconfig-a016-20221010
i386                 randconfig-a013-20221010
x86_64               randconfig-a014-20221010
arm                              allyesconfig
i386                 randconfig-a015-20221010
x86_64               randconfig-a015-20221010
x86_64                        randconfig-a015
x86_64               randconfig-a012-20221010
i386                 randconfig-a014-20221010
x86_64               randconfig-a013-20221010
x86_64                        randconfig-a013
i386                             allyesconfig
x86_64                        randconfig-a011
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                           se7206_defconfig
sh                        edosk7760_defconfig
i386                 randconfig-c001-20221010
arm                         s3c6400_defconfig
arm                         lubbock_defconfig
m68k                        m5272c3_defconfig
ia64                          tiger_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     asp8347_defconfig
m68k                        stmark2_defconfig
m68k                             alldefconfig
arm                            pleb_defconfig
arc                      axs103_smp_defconfig
powerpc                     taishan_defconfig
arm                         lpc18xx_defconfig
parisc                generic-64bit_defconfig
arc                         haps_hs_defconfig
powerpc                      ep88xc_defconfig
um                               alldefconfig
sh                           se7780_defconfig
xtensa                           alldefconfig
arm                            zeus_defconfig
arm                           sama5_defconfig
openrisc                       virt_defconfig
arm                            lart_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      fuloong2e_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
x86_64               randconfig-k001-20221010
arm                        mini2440_defconfig
powerpc                     rainier_defconfig
ia64                        generic_defconfig
nios2                         3c120_defconfig
sh                        sh7763rdp_defconfig
m68k                           sun3_defconfig
arm                        realview_defconfig
mips                 decstation_r4k_defconfig
mips                            gpr_defconfig
sh                           se7722_defconfig
nios2                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                 randconfig-a003-20221010
i386                 randconfig-a002-20221010
i386                 randconfig-a001-20221010
i386                 randconfig-a004-20221010
i386                 randconfig-a006-20221010
hexagon              randconfig-r045-20221010
i386                 randconfig-a005-20221010
x86_64               randconfig-a006-20221010
x86_64               randconfig-a005-20221010
hexagon              randconfig-r041-20221010
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64               randconfig-a003-20221010
x86_64               randconfig-a002-20221010
x86_64               randconfig-a001-20221010
x86_64               randconfig-a004-20221010
x86_64                        randconfig-k001
powerpc                      walnut_defconfig
powerpc                 mpc836x_rdk_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
riscv                    nommu_virt_defconfig
arm                         orion5x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
