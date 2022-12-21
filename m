Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30695652B7D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 03:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiLUCcT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Dec 2022 21:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiLUCcO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Dec 2022 21:32:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529D7201AC
        for <linux-wireless@vger.kernel.org>; Tue, 20 Dec 2022 18:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671589933; x=1703125933;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=U6iCSlCrKwmL6rcOOhG48Ac7SfXJQZ+MTEDdoGCc8/c=;
  b=VUbbz+T9fiPqpfembDhOorfkFmjYkz8yMhxr1itIO9e02nAR/DOO5LZC
   3OanXlVdGA+2h3E/Ml69e4roK7dEkAACl8YLsDa8akXJS8o+1rai44pxG
   TLOoHrN5XmZI92RCA2mE1o7MSC7kTAQbVGjFHg4qPdIU3SAJ/kZaHL/kp
   YKRLniMVpXH0Kv66910nKXNI0EPhgWpeN8yVSOLg8BnseC5QktRSmq9Ww
   RJgM/3SdeZ8OBqJipJyggZVxpDtiyNN1uUSEZkTvnbXZtixfcz8gYq/iX
   hBLdAjTFNNIaBLCbb5h0vheitrNs7gg+1RsfbE1ovdm0w+vMSWWnnypFW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="303192229"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="303192229"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 18:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="653339576"
X-IronPort-AV: E=Sophos;i="5.96,261,1665471600"; 
   d="scan'208";a="653339576"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Dec 2022 18:32:10 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p7ott-0009mF-1S;
        Wed, 21 Dec 2022 02:32:09 +0000
Date:   Wed, 21 Dec 2022 10:30:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 b7dc753fe33a707379e2254317794a4dad6c0fe2
Message-ID: <63a26faf.Jc/GcctI9uGwsQuU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: b7dc753fe33a707379e2254317794a4dad6c0fe2  wifi: ath9k: use proper statements in conditionals

elapsed time: 791m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
m68k                             allyesconfig
s390                                defconfig
x86_64                              defconfig
s390                             allmodconfig
sh                               allmodconfig
i386                                defconfig
powerpc                          allmodconfig
s390                             allyesconfig
mips                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                           allyesconfig
i386                 randconfig-a006-20221219
x86_64               randconfig-a006-20221219
x86_64                           rhel-8.3-bpf
arc                  randconfig-r043-20221220
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
i386                 randconfig-a001-20221219
i386                 randconfig-a003-20221219
s390                 randconfig-r044-20221220
i386                             allyesconfig
riscv                randconfig-r042-20221220
x86_64                           rhel-8.3-kvm
arm64                            allyesconfig
i386                 randconfig-a002-20221219
arm                              allyesconfig
i386                 randconfig-a005-20221219
i386                 randconfig-a004-20221219
riscv                randconfig-r042-20221218
x86_64                            allnoconfig
arc                  randconfig-r043-20221219
arm                  randconfig-r046-20221219
x86_64                        randconfig-a013
x86_64               randconfig-a002-20221219
arc                  randconfig-r043-20221218

clang tested configs:
x86_64                          rhel-8.3-rust
arm                  randconfig-r046-20221220
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
hexagon              randconfig-r045-20221220
hexagon              randconfig-r041-20221220
i386                 randconfig-a011-20221219
i386                 randconfig-a016-20221219
i386                 randconfig-a014-20221219
i386                 randconfig-a015-20221219
arm                  randconfig-r046-20221218
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
s390                 randconfig-r044-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
x86_64               randconfig-a015-20221219
x86_64                        randconfig-a014
x86_64               randconfig-a011-20221219

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
