Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34702608375
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Oct 2022 04:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJVCCl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 22:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJVCCj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 22:02:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589592A9370
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 19:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666404158; x=1697940158;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jlMaUYuP8H25qgd2t7dOPWDhNfeVd0nH7yZ/vOC/Hmg=;
  b=bNBeujvrhmYf3HLONJPP1NcAA3jhXolqO7u7fJ0IqdH7RDyTEhyNOLq3
   j2CCT1J61DOPs9Rr+RvzlVDIDGJ5ZriRKgImVo0q7SpjwGPXsDc4Zr0An
   ytkK69hyK3OvW/VtGv6dDprzUSsH7HA7H7hLOBs2yjTnsVaLtIv2eqFZb
   tQL5cxcopbfqBFKnad54I/gDB0Vihv6rzTxFuIL32U7w8ebTpcRFLkaUM
   +flJxU5K21BVlhcVjKHhzpaBVgbmr715xqHroHHCLyEEGZxOzwZ3hWPHh
   MEhNoERT8HD0P7kmVlQKpw0i9Mi57BpsrbTImBwfGRCfC8agYwwL5/9tu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="393458923"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="393458923"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 19:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="699570771"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="699570771"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2022 19:02:36 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1om3qO-0003D1-0j;
        Sat, 22 Oct 2022 02:02:36 +0000
Date:   Sat, 22 Oct 2022 10:02:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 80e5acb6dd72b25a6e6527443b9e9c1c3a7bcef6
Message-ID: <63534f33.2jvrzNyoRJMIKhg4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 80e5acb6dd72b25a6e6527443b9e9c1c3a7bcef6  wifi: rtl8xxxu: Fix reads of uninitialized variables hw_ctrl_s1, sw_ctrl_s1

elapsed time: 720m

configs tested: 62
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arm                                 defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
i386                                defconfig
arc                  randconfig-r043-20221019
arc                  randconfig-r043-20221020
s390                             allyesconfig
s390                 randconfig-r044-20221020
riscv                randconfig-r042-20221020
arm64                            allyesconfig
x86_64                        randconfig-a013
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                        randconfig-a011
arm                              allyesconfig
powerpc                           allnoconfig
m68k                             allyesconfig
i386                          randconfig-a005
m68k                             allmodconfig
x86_64                        randconfig-a002
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
arc                              allyesconfig
i386                          randconfig-a016
x86_64                        randconfig-a015
powerpc                          allmodconfig
i386                          randconfig-a001
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
sh                               allmodconfig
alpha                            allyesconfig
x86_64                        randconfig-a004
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a006
mips                             allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a003

clang tested configs:
riscv                randconfig-r042-20221019
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
hexagon              randconfig-r045-20221019
hexagon              randconfig-r041-20221019
s390                 randconfig-r044-20221019
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a015
i386                          randconfig-a013
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003
x86_64                        randconfig-a016
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
