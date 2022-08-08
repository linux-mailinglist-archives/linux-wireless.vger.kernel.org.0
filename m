Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9758CF63
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 22:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiHHUts (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbiHHUtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 16:49:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E113663E2
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659991785; x=1691527785;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Xjr3I9LNDdaolmGHTJQyReRCAXGWNeKiW2LU/huonY8=;
  b=JN+K9BvcxRPeT3wpuZAQ3oO0x9HNdZRXMCk1Cq1GPCb2w4Y1zpFt5ShN
   kzT8x2uWXLASWRjwW3BD7YhIQ8jcHI0yaATOZe/CNZ1kWKFB9h517x/4O
   Aon36KypBBa5SAQklEbsOMhwUijYkTgH24v412xhJbKEknbb4kEwzhChT
   EFhfv9yOcbgl7Q2VsBCuqWXQq5C++eib29Q/2SKmTHcciseUNlAHo4wsI
   S37Y2PUV7Bp+fMuDmsJAAymZYkzDj51FUOYu7bHWKMziTMsZT0Q+ZeHVq
   GmNXocTAuGhArA48bpjZT8XWrqDdCgPbEtdWPZXFCS3qjeofZydhIZ2sj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="316612830"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="316612830"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 13:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="932215163"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2022 13:49:33 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oL9gq-000MWL-2o;
        Mon, 08 Aug 2022 20:49:32 +0000
Date:   Tue, 09 Aug 2022 04:49:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 f01272ee3856e62e8a0f8211e8edf1876a6f5e38
Message-ID: <62f176d8.26BJAaaW7/mOEWng%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: f01272ee3856e62e8a0f8211e8edf1876a6f5e38  wifi: wilc1000: fix spurious inline in wilc_handle_disconnect()

elapsed time: 717m

configs tested: 69
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
powerpc                           allnoconfig
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
m68k                             allmodconfig
x86_64                    rhel-8.3-kselftests
arc                              allyesconfig
i386                 randconfig-a005-20220808
i386                 randconfig-a006-20220808
x86_64                               rhel-8.3
sh                               allmodconfig
arc                  randconfig-r043-20220807
x86_64                           rhel-8.3-kvm
arm                                 defconfig
s390                 randconfig-r044-20220807
mips                             allyesconfig
i386                          randconfig-a014
arm                              allyesconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a003-20220808
alpha                            allyesconfig
riscv                randconfig-r042-20220807
powerpc                          allmodconfig
x86_64                           allyesconfig
m68k                             allyesconfig
x86_64               randconfig-a001-20220808
i386                 randconfig-a002-20220808
arc                  randconfig-r043-20220808
arm64                            allyesconfig
x86_64               randconfig-a002-20220808
i386                          randconfig-a012
i386                          randconfig-a016
i386                 randconfig-a003-20220808
i386                 randconfig-a004-20220808
x86_64               randconfig-a006-20220808
i386                 randconfig-a001-20220808
x86_64               randconfig-a004-20220808
x86_64               randconfig-a005-20220808
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006

clang tested configs:
hexagon              randconfig-r045-20220808
riscv                randconfig-r042-20220808
hexagon              randconfig-r041-20220808
i386                          randconfig-a013
x86_64               randconfig-a012-20220808
hexagon              randconfig-r045-20220807
hexagon              randconfig-r041-20220807
x86_64               randconfig-a011-20220808
x86_64               randconfig-a016-20220808
x86_64               randconfig-a015-20220808
i386                          randconfig-a011
x86_64               randconfig-a014-20220808
i386                          randconfig-a015
x86_64               randconfig-a013-20220808
s390                 randconfig-r044-20220808
i386                 randconfig-a011-20220808
i386                 randconfig-a013-20220808
i386                 randconfig-a012-20220808
i386                 randconfig-a014-20220808
i386                 randconfig-a016-20220808
i386                 randconfig-a015-20220808
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
