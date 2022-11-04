Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25DA61A3E8
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Nov 2022 23:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiKDWJt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Nov 2022 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiKDWJq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Nov 2022 18:09:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB982E686
        for <linux-wireless@vger.kernel.org>; Fri,  4 Nov 2022 15:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667599783; x=1699135783;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xwcAxZowSfO1x3OVQHacvKvIUg1BUYdtm15o9rLdowQ=;
  b=nKT8lB8ihIpD5PdQ42Ep/5b+TUB7gfgFNjW4aUF4WpK3c5nKii2ODIKX
   W6K14Ffwpf/ESxE7sRNQueC8tBrwqGiwQBCIuqHuqHEUEv7Rg05k2Fnr3
   1RJo3aMqPMX3X9prTZRy6oJdPqGhwI3AzwUOOK20VsfC2ofL6m6YGwdR7
   Xlvck8nIi0/LR9F8yNcI4xwOO9MHns12UAdauIZiYl3IwMjkEd8+stUnt
   ETwQFTe/Zz456s/6rM7GwhgiFteVHtdWHSwtiyamP2Ee+j9HWGvcdbl6D
   m2jzKrE9vlaH7+ibO9bSVTH2326+Sobrn+btodV0zS3H7ambagw89A071
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="310085928"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="310085928"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="964499065"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="964499065"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 04 Nov 2022 15:09:42 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1or4sf-000HNJ-1W;
        Fri, 04 Nov 2022 22:09:41 +0000
Date:   Sat, 05 Nov 2022 06:08:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 91018bbcc664b6c9410ddccacd2239a4acadcfc9
Message-ID: <63658d76.VqMFHw2C+jhUjI0q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 91018bbcc664b6c9410ddccacd2239a4acadcfc9  Merge tag 'wireless-2022-11-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 1049m

configs tested: 56
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
mips                             allyesconfig
alpha                               defconfig
powerpc                          allmodconfig
arc                                 defconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
x86_64                        randconfig-a013
i386                          randconfig-a001
x86_64                        randconfig-a011
i386                          randconfig-a003
s390                 randconfig-r044-20221104
x86_64                        randconfig-a004
x86_64                              defconfig
x86_64                        randconfig-a015
i386                                defconfig
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                           rhel-8.3-syz
i386                          randconfig-a016
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
i386                             allyesconfig
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
arm                                 defconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
m68k                             allmodconfig
riscv                randconfig-r042-20221104
arc                  randconfig-r043-20221104

clang tested configs:
x86_64                        randconfig-a014
i386                          randconfig-a002
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
i386                          randconfig-a013
x86_64                        randconfig-a003
i386                          randconfig-a011
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
