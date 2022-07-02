Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC783563DA8
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 04:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiGBCAc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 22:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiGBCAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 22:00:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3BE37A3F
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656727228; x=1688263228;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DYj8xDTpDJJEPwlZp4LelQW5QsKCx+GwTodD6V2RhKw=;
  b=lI6C76W8yTW47EyGcXzd3uRSqELbbQZo/DxmFQv9hkHaXifJrvboXgl5
   C/EMO/67QgojerhJfK/IpfzKTHQOXE4Mycf/t85Dg7xqnlA/X4bGx8Lme
   ERYnYGgyRZg1rBVL9qoj8gJvQU81K6HRvbUrd6TUlDdGVUUbdkIeWDau0
   VzXHsm7qXNvXR8vigMAZ32HCSYdScfiR2yoyMrX35mu/Ms4nGCxPkuAx7
   ovVww5T4K4hGcFazPXgy8Cgi+fbLZS7mBp0JDo7CPw+KKT1qzuVyaNiPF
   s29q2t5ACKKst+8YqSUAtgpaMesMxg3ip8PKXpXSJv1GH0nX9YMPPU4uE
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="263174953"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="263174953"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 19:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="694711502"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2022 19:00:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7SQs-000EeA-Ni;
        Sat, 02 Jul 2022 02:00:26 +0000
Date:   Sat, 02 Jul 2022 09:59:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 8bc65d38ee466897a264c9e336fe21058818b1b1
Message-ID: <62bfa680.X9YHqsGP3RlfjX2N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8bc65d38ee466897a264c9e336fe21058818b1b1  wifi: nl80211: retrieve EHT related elements in AP mode

elapsed time: 887m

configs tested: 50
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
ia64                             allmodconfig
sh                               allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
i386                                defconfig
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a012
i386                          randconfig-a014
arc                  randconfig-r043-20220629
s390                 randconfig-r044-20220629
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a013
i386                          randconfig-a011
hexagon              randconfig-r045-20220629
hexagon              randconfig-r041-20220629

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
