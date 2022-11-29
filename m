Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2938063B97C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 06:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiK2F3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 00:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiK2F3V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 00:29:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A1712095
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 21:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669699760; x=1701235760;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ISkF6WZavZogV5Xhxzuj0vOQVMXQSbzbJVId9GGc5do=;
  b=XrCF3DSzAm8H23KUrS1Bv3PTmc9DHK0jpvYlNgEIr7HdEteenEWEWtPd
   vnS3JAsOkN7YBCRY060O5QxrMsNftsygI8xN+M17j54raYw4344l1dRId
   6iiIPuQGlns733uXCEUXQrgiGPf9mpO4YOgSzgssPxFcwlfmKtYlNUaH3
   PfmOJIT9bnoWdvHY85jFjQWjBIfQozoEBOHpZn7+OuOL2bP+J7O5pbD0F
   whr2YZBYCIQhT5gU+o5mlTwf9sRG7aryKQ+CWEybqELTKVcYlDlqznhOP
   d+4p0SBwR5+icxoDJwii1n0yAwmY5qFkvio5o7Da3o2zNOPZPqT68A0Wn
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="312652535"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="312652535"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 21:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="888710228"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="888710228"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 28 Nov 2022 21:29:19 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oztBG-0008fX-1C;
        Tue, 29 Nov 2022 05:29:18 +0000
Date:   Tue, 29 Nov 2022 13:28:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 8cd2a12cc967ca60872ecd3f7b7a485cc30ff8ff
Message-ID: <63859878.gizC6eUxGq5Umlsq%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 8cd2a12cc967ca60872ecd3f7b7a485cc30ff8ff  Merge tag 'mt76-for-kvalo-2022-11-28' of https://github.com/nbd168/wireless into pending

elapsed time: 942m

configs tested: 57
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                  randconfig-r043-20221128
alpha                            allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
i386                 randconfig-a002-20221128
i386                 randconfig-a003-20221128
i386                 randconfig-a001-20221128
x86_64                              defconfig
i386                 randconfig-a004-20221128
i386                 randconfig-a005-20221128
x86_64                           allyesconfig
i386                 randconfig-a006-20221128
i386                                defconfig
i386                             allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
s390                             allyesconfig
x86_64               randconfig-a001-20221128
x86_64               randconfig-a003-20221128
x86_64               randconfig-a004-20221128
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64               randconfig-a002-20221128
x86_64                           rhel-8.3-kvm
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20221128
x86_64               randconfig-a005-20221128
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig

clang tested configs:
hexagon              randconfig-r045-20221128
riscv                randconfig-r042-20221128
s390                 randconfig-r044-20221128
hexagon              randconfig-r041-20221128
i386                 randconfig-a012-20221128
i386                 randconfig-a011-20221128
i386                 randconfig-a013-20221128
i386                 randconfig-a014-20221128
i386                 randconfig-a016-20221128
i386                 randconfig-a015-20221128
x86_64               randconfig-a012-20221128
x86_64               randconfig-a014-20221128
x86_64               randconfig-a011-20221128
x86_64               randconfig-a013-20221128
x86_64               randconfig-a016-20221128
x86_64               randconfig-a015-20221128

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
