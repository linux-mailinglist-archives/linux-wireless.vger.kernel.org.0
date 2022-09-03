Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4175ABDB0
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Sep 2022 09:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiICHjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Sep 2022 03:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiICHjF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Sep 2022 03:39:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DDA6F549
        for <linux-wireless@vger.kernel.org>; Sat,  3 Sep 2022 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662190745; x=1693726745;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=6+NamG2HHjRo5XF7i3AiYBQVm/jBz0ctEOJBsKKB8Bs=;
  b=FQwp3BM7hhWl0bsDGIJJgSxLAM7yx2Wf8kVF6qDOhFHhBHtuD0A2Uf9B
   WaXrDhKpZFNC9ooOUHaWHI9jXTFIp5p7inzZg6W8y0RIsBaqwwWNWr8bn
   DInN9Y7JYOxQIm2I6nbISVAyULNdqtCRplizS/56xZuviF45kygBkpF4q
   J2/Dxab5hYHsZQlosBeVtx0K1zmwCNAWeIFwyNSXID5NxPEXsdw65O2t6
   PPyS/M6bFoMxEI4cyHdAdFWslKPQp9z5yVYK6RHuzryfQNV47vjEJj6ok
   Z/ulTym5+YDseUJrhie6GsI0hSzG6mamtvQmEaTn8v/MnGDcTfkrHLyoc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="275883528"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="275883528"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 00:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="941544103"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2022 00:39:03 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUNk1-0001F5-2y;
        Sat, 03 Sep 2022 07:38:57 +0000
Date:   Sat, 03 Sep 2022 15:38:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 bf99f11df4de45fcba6f6c441b411a16bccaccf6
Message-ID: <63130462.5x/IiKdrxkxsLxUs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: bf99f11df4de45fcba6f6c441b411a16bccaccf6  wifi: move from strlcpy with unused retval to strscpy

elapsed time: 1078m

configs tested: 48
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20220901
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                              defconfig
x86_64                        randconfig-a002
i386                                defconfig
i386                          randconfig-a012
alpha                            allyesconfig
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
arc                              allyesconfig
i386                          randconfig-a014
x86_64                    rhel-8.3-kselftests
m68k                             allmodconfig
x86_64                         rhel-8.3-kunit
i386                             allyesconfig
m68k                             allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220901
hexagon              randconfig-r045-20220901
riscv                randconfig-r042-20220901
i386                          randconfig-a002
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
s390                 randconfig-r044-20220901
i386                          randconfig-a006
i386                          randconfig-a013
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a011
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
