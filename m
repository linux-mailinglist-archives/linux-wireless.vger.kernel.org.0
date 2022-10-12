Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1445F5FC9B8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJLRIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 13:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJLRIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 13:08:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1475B9591
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665594531; x=1697130531;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=v2JBSufx6NdTFhvV/u5cI7ngz4YPGLn42vVHesux9bc=;
  b=Bq8l2QxQ2Iqi31b33MRy6ig63kaac+hPgqblKihmqdsj0yKuu8o6Xpck
   42O/Qv2VI4B24pEzN6wbNYsuC9AKZRxcD7k20Rvojp9q8Z5hyGpqBX9+9
   zXd4GsWbZcoj7EVBMWB8EEuo5Ayk3gSkr1SFxUlYG21+CvoSGpe+HovYM
   BO4BLl2Grkw55Qw/0DP1OHmsUtb94R+eO+MQMj8Mvyfqq7n7VmfpzNbbi
   BUr0oHw+pTCi9qoFuKfb8EIch/73qDBiQ6ip8sCvmlfD/0f9mi/k9/yIn
   z9Esfhrv4Vj9u9KlVhNjMK7YP+FjkSWcZiqRAAZK8hxh0Ee44+ynWDFDJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="304840861"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="304840861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 10:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="657848630"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="657848630"
Received: from lkp-server01.sh.intel.com (HELO 2af0a69ca4e0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2022 10:08:39 -0700
Received: from kbuild by 2af0a69ca4e0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oifDh-00042Z-2G;
        Wed, 12 Oct 2022 17:08:37 +0000
Date:   Thu, 13 Oct 2022 01:08:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 b8fe87b816851d08a31c7c9589855c8535672299
Message-ID: <6346f485.AcGQVqTxrLTodQeM%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: b8fe87b816851d08a31c7c9589855c8535672299  wifi: rtw89: 8852b: add basic attributes of chip_info

elapsed time: 725m

configs tested: 101
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
i386                          randconfig-a001
i386                                defconfig
i386                          randconfig-a003
m68k                             allyesconfig
i386                             allyesconfig
i386                          randconfig-a005
arc                               allnoconfig
m68k                        m5272c3_defconfig
alpha                             allnoconfig
riscv                             allnoconfig
csky                              allnoconfig
i386                          randconfig-a012
x86_64                        randconfig-a004
i386                          randconfig-a016
x86_64                        randconfig-a002
m68k                       m5475evb_defconfig
mips                      loongson3_defconfig
i386                          randconfig-a014
x86_64                        randconfig-a006
openrisc                       virt_defconfig
sh                   sh7724_generic_defconfig
arm                                 defconfig
x86_64                        randconfig-a015
um                           x86_64_defconfig
um                             i386_defconfig
arm                              allyesconfig
arm64                            allyesconfig
sh                          sdk7780_defconfig
xtensa                           alldefconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
arc                              alldefconfig
sh                            shmin_defconfig
sh                         apsh4a3a_defconfig
openrisc                            defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arm                        keystone_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_mds_defconfig
mips                       bmips_be_defconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                  randconfig-r043-20221012
s390                 randconfig-r044-20221012
riscv                randconfig-r042-20221012
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arm                        clps711x_defconfig
powerpc                      arches_defconfig
mips                     loongson1b_defconfig
mips                          rb532_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
xtensa                           allyesconfig
sh                           se7750_defconfig
powerpc                     rainier_defconfig
ia64                             allmodconfig
powerpc                    amigaone_defconfig
mips                           ci20_defconfig
m68k                                defconfig
riscv                    nommu_k210_defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
mips                          ath79_defconfig
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
mips                     cu1830-neo_defconfig
powerpc                      katmai_defconfig
mips                      maltaaprp_defconfig
riscv                             allnoconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
powerpc                 mpc8560_ads_defconfig
x86_64                        randconfig-k001
hexagon              randconfig-r045-20221012
hexagon              randconfig-r041-20221012
powerpc                      obs600_defconfig
mips                           mtx1_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
