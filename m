Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40445635C2A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiKWLxQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 06:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiKWLxP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 06:53:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A971ED
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669204394; x=1700740394;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=t5uQ9vZEO6q3vztWmmklzT9NsjW8+S2OoGZ9ukZbVuU=;
  b=MbOgUseaStTvPJrTFRb/M422AbhsNLU54BX9/cOpSh/RO2vGCVe5Y3ih
   926qUQcZsO+s6f05igdj+ZS9rpZW+BXS0sFjK17E8InchcgxhCevwnw9s
   TPJ4wT94EenFyBQJinvZRXt+hWkfmJtQiR6+zU99jlLyMiHJAxqzlZTuI
   NtiiP5Yri9vxOpbxvtGU7fiHhIWQxCyN4/BF/1Z7UL6GZ81c5CVRCmuz+
   QDjLGhgJiuT5quHbz4CgWSSI+kG39LXF11Tvyk5lNq526zDBjwnNz3Fwl
   fOy7ikDNMgqbs3tLiuPgu5zr+DEE3bDaP1yCbm7HjiAT4GNdq0UtY9oHM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="400341876"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="400341876"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 03:53:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="730760149"
X-IronPort-AV: E=Sophos;i="5.96,187,1665471600"; 
   d="scan'208";a="730760149"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Nov 2022 03:53:13 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oxoJU-0002hr-1R;
        Wed, 23 Nov 2022 11:53:12 +0000
Date:   Wed, 23 Nov 2022 19:53:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 3b79d4bad3a0e73d9becb409a5f6112bc61e2c93
Message-ID: <637e09a2.rE8HxFcvLaWSSLq9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 3b79d4bad3a0e73d9becb409a5f6112bc61e2c93  wifi: p54: Replace zero-length array of trailing structs with flex-array

elapsed time: 1517m

configs tested: 79
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
ia64                             allmodconfig
x86_64                              defconfig
i386                 randconfig-a016-20221121
i386                 randconfig-a011-20221121
i386                 randconfig-a013-20221121
i386                 randconfig-a012-20221121
i386                 randconfig-a014-20221121
i386                 randconfig-a015-20221121
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64               randconfig-a011-20221121
x86_64               randconfig-a012-20221121
x86_64               randconfig-a015-20221121
x86_64               randconfig-a013-20221121
x86_64               randconfig-a016-20221121
x86_64               randconfig-a014-20221121
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
i386                                defconfig
i386                             allyesconfig
arc                  randconfig-r043-20221120
arc                  randconfig-r043-20221121
riscv                randconfig-r042-20221121
s390                 randconfig-r044-20221121
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
x86_64               randconfig-a001-20221121
x86_64               randconfig-a003-20221121
x86_64               randconfig-a002-20221121
x86_64               randconfig-a004-20221121
x86_64               randconfig-a006-20221121
x86_64               randconfig-a005-20221121
i386                 randconfig-a001-20221121
i386                 randconfig-a003-20221121
i386                 randconfig-a002-20221121
i386                 randconfig-a004-20221121
i386                 randconfig-a005-20221121
i386                 randconfig-a006-20221121
hexagon              randconfig-r041-20221120
hexagon              randconfig-r041-20221121
hexagon              randconfig-r045-20221120
riscv                randconfig-r042-20221120
hexagon              randconfig-r045-20221121
s390                 randconfig-r044-20221120
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
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
