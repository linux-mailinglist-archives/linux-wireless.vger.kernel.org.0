Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF862C88F
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiKPS6Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 13:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiKPS6R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 13:58:17 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E2D3B0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 10:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668625097; x=1700161097;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=lA6+eSUW40Xxk0y0P4U3wBOkKBVLKXUK4izttgaWlP8=;
  b=mkUnRK7IegWYP6aWCTS55p0w3Ps2WdAY7m7vaN+t27glSaOQp6otPJCN
   FExGV/GG+hj4Lu8juMzd7Z2pjRmgK893TD3vQ6JAul5pX8WsvjMER/VsV
   7d/JnmW/O9rt+9/xOI52vg/XqL4BScU4u/P1zZH96Ey9OkYErOVKmHQ00
   ItrwAk1ZQC62oV1Pa4Vd9eIydvBs/CE72+nXsXTymJBkjiTO67rF8SXxb
   QfPZNgUUfUnC7F+2ZLzFDwKhEHB3N0RTk56JANE465Uuudtq8I4P1Gwd7
   ZdIRo0o0yz7mHIUIDcBrgRYyEccboT+8twWBxSWMo0iYgsnqJo9OYpZhy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="339450455"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="339450455"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 10:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="670607258"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="670607258"
Received: from lkp-server01.sh.intel.com (HELO ebd99836cbe0) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 16 Nov 2022 10:58:15 -0800
Received: from kbuild by ebd99836cbe0 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ovNby-0002dD-1r;
        Wed, 16 Nov 2022 18:58:14 +0000
Date:   Thu, 17 Nov 2022 02:57:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 5fef7d2a9faccc8103488c4766bafa5731d3e49c
Message-ID: <6375329a.gYew9ezudwnwNnqQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 5fef7d2a9faccc8103488c4766bafa5731d3e49c  Merge tag 'iwlwifi-next-for-kalle-2022-11-06-v2' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 804m

configs tested: 46
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
s390                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
s390                             allmodconfig
i386                                defconfig
arc                  randconfig-r043-20221115
x86_64                              defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20221115
s390                             allyesconfig
s390                 randconfig-r044-20221115
powerpc                           allnoconfig
mips                             allyesconfig
arm                                 defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a014
x86_64                           allyesconfig
i386                          randconfig-a012
m68k                             allmodconfig
i386                          randconfig-a016
arc                              allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
arm64                            allyesconfig
m68k                             allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a002

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r045-20221115
hexagon              randconfig-r041-20221115
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
