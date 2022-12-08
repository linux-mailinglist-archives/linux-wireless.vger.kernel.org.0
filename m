Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB86475DD
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 20:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLHTB6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 14:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHTB4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 14:01:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4DD84B5E
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670526115; x=1702062115;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uGbUoaBnj4f68UOeyHPufSg+UCLS3hvtA6Gvai5XuvM=;
  b=Pghhk0T4Myz54AucOqsKuhekY705bMgT0iEPFNv0zoHqTjyuhjPaUsSz
   82w3F9n0sRnH6qCC8zhg/8dsPiL6DiEUPWpNUxOgdximF8S6c6SBc3obc
   nwuOy7SYOW24NYWHh0VN4HWUhZyYAmDKMd6dtIwIegcI2+X605ZQCKc8x
   i9J4BM8OZOgvtOsFPcEdFJHK6maGdZvz/oITY07icUJFEgvAlNxuJmec5
   v+ePIkSHJh3qaiVy46CqB5NJ//C7F/rxf0IJgSu1bd326vJWkuyeI4Jy4
   dwCi/Vwi1fIBwBD6j5rvw2Xfj5Uyx9TeDDB6hs0KP93ZFlw4yU3Uc9yzC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="403524186"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="403524186"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 11:01:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="821453604"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="821453604"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2022 11:01:52 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3M9X-0001M3-2A;
        Thu, 08 Dec 2022 19:01:51 +0000
Date:   Fri, 09 Dec 2022 03:00:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 ce3c43789a232d5c7255e50658810be07e6f1a02
Message-ID: <6392346b.M8J3r3LPF8yafDEm%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: ce3c43789a232d5c7255e50658810be07e6f1a02  Merge tag 'iwlwifi-next-for-kalle-2022-12-07' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into pending

elapsed time: 721m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
i386                          randconfig-a014
i386                          randconfig-a012
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
arc                  randconfig-r043-20221207
x86_64                              defconfig
i386                                defconfig
m68k                             allyesconfig
x86_64                           rhel-8.3-syz
i386                          randconfig-a001
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
arc                              allyesconfig
i386                          randconfig-a003
i386                          randconfig-a016
alpha                            allyesconfig
riscv                randconfig-r042-20221207
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                               allmodconfig
s390                 randconfig-r044-20221207
i386                          randconfig-a005
s390                                defconfig
x86_64                               rhel-8.3
s390                             allyesconfig
x86_64                        randconfig-a013
x86_64                           allyesconfig
x86_64                        randconfig-a011
mips                             allyesconfig
i386                             allyesconfig
x86_64                        randconfig-a006
ia64                             allmodconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
x86_64                          rhel-8.3-rust
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
arm                              allyesconfig
arm64                            allyesconfig
x86_64                            allnoconfig

clang tested configs:
i386                          randconfig-a013
i386                          randconfig-a011
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a003

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
