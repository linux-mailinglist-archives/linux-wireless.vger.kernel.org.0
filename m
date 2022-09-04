Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C5E5AC255
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 06:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiIDEXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 00:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbiIDEXe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 00:23:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323B14D816
        for <linux-wireless@vger.kernel.org>; Sat,  3 Sep 2022 21:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662265413; x=1693801413;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6db7Zq0apOFl9p6I9+2ZQUN0iWzkUw1foRAYVoIYKNQ=;
  b=PzQlL2NyZSRY6P90wNp0xZImsJseTD/giyFcNQh66HvOa0lCh1k3rfLA
   lKN5UHKMiYUZl+vo+ps8sS64iuIYSSxv1m60nf2rvwmeqez6+a4OPHHVV
   z47QafdQ99YFm8WgvUjFqoMdCwk3zXOdXZFoGmkQE/Er3zOWQ9YR5XqGy
   Xh6gBYhbobGxPyMC9JWogzeW9G7E/xHsePSTz2violOLfiBrqobXQQZvg
   GI6o5AnxF4NrkAjHaIqvUBlsmaCN84YSWFtIO7uHMgDaN57bgaZFORZo6
   n0/w+/Ah6UHd3FY563j0WNxZDp4xxNHZtWWHZGamBeCPgQDh+SFAWS8Sm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="296213493"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="296213493"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 21:23:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="789053306"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Sep 2022 21:23:31 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUhAQ-0002YL-2E;
        Sun, 04 Sep 2022 04:23:30 +0000
Date:   Sun, 04 Sep 2022 12:23:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 7aac807386fc5d997e37d1f8db68d0f5ebc673c2
Message-ID: <63142832.MFTaNNfogsRfHPfX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: 7aac807386fc5d997e37d1f8db68d0f5ebc673c2  wifi: mac80211: keep A-MSDU data in sta and per-link

elapsed time: 726m

configs tested: 73
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20220904
i386                                defconfig
riscv                randconfig-r042-20220904
i386                          randconfig-a014
s390                 randconfig-r044-20220904
i386                          randconfig-a012
arm                                 defconfig
x86_64                              defconfig
i386                          randconfig-a016
arc                              allyesconfig
alpha                            allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
m68k                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                        randconfig-a013
x86_64                        randconfig-a011
ia64                             allmodconfig
csky                              allnoconfig
arc                               allnoconfig
arm                         assabet_defconfig
i386                          randconfig-a003
arm64                            allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
sh                               allmodconfig
x86_64                           rhel-8.3-syz
alpha                             allnoconfig
riscv                             allnoconfig
arm                              allyesconfig
mips                             allyesconfig
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
mips                       bmips_be_defconfig
powerpc                           allnoconfig
i386                          randconfig-a005
i386                          randconfig-a001
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                        m5272c3_defconfig
arm                         lpc18xx_defconfig
sh                               j2_defconfig
sh                           se7712_defconfig
sparc                               defconfig
microblaze                      mmu_defconfig
sh                           se7206_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                  nommu_kc705_defconfig
i386                          randconfig-c001

clang tested configs:
hexagon              randconfig-r045-20220904
i386                          randconfig-a013
hexagon              randconfig-r041-20220904
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a004
powerpc                          g5_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
powerpc                 mpc8272_ads_defconfig
arm                         s3c2410_defconfig
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
