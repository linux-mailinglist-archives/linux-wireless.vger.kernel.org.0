Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853DE611EB4
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Oct 2022 02:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJ2AZj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 20:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2AZi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 20:25:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250E06D86B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 17:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667003137; x=1698539137;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BtVn+cHMQ0XkuedQueFqs/pKErIVKa4WvE8oquUolsE=;
  b=MAPaiqrxJpR+EHCd+FGjuYWS5MhtFqWCyrHxRaFpEFKURK6LrhYqSebu
   GF6sE8F/YlUKrRxKfJcUCx/bXVBfOMaRJwwSEAzHognMcmSdgyWZDayp1
   OeaRgi2sP626eAfoNmew8FyVd/P9WmGthufJOIfzpdJyx44nwHRZ7HI7m
   7GCf/VnwGfrcdNuYazAc5ZQA/U9VhzRfBOzAqV9f7dw74GAl4aDSrGVvF
   Uzz+PMAMe2sg6APjqdWns3H2zhdh9WLmMUwrFXYiudpZPScHi/XI73YUL
   CQMD9fdjegeBM6NpoSvQNE+xBRl8iqx8905dIKH9PEMY5TmRgG7sYJK9L
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="394934990"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="394934990"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 17:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="584103411"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="584103411"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Oct 2022 17:25:34 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ooZfJ-000AMZ-2b;
        Sat, 29 Oct 2022 00:25:33 +0000
Date:   Sat, 29 Oct 2022 08:25:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 0879f594289e36546974c17f10bf587d9303e724
Message-ID: <635c72e3.57occxR3Kri0TQKU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 0879f594289e36546974c17f10bf587d9303e724  Merge branch 'main' into test

elapsed time: 736m

configs tested: 52
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
i386                                defconfig
x86_64                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                           allnoconfig
x86_64                               rhel-8.3
i386                             allyesconfig
arc                                 defconfig
alpha                               defconfig
x86_64                           allyesconfig
s390                             allmodconfig
s390                                defconfig
ia64                             allmodconfig
arc                              allyesconfig
sh                               allmodconfig
alpha                            allyesconfig
i386                          randconfig-a001
powerpc                          allmodconfig
i386                          randconfig-a003
mips                             allyesconfig
i386                          randconfig-a005
s390                             allyesconfig
arc                  randconfig-r043-20221028
x86_64                        randconfig-a002
x86_64                        randconfig-a006
m68k                             allyesconfig
i386                          randconfig-a012
m68k                             allmodconfig
riscv                randconfig-r042-20221028
i386                          randconfig-a016
s390                 randconfig-r044-20221028
x86_64                        randconfig-a004
i386                          randconfig-a014
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
hexagon              randconfig-r041-20221028
x86_64                        randconfig-a001
i386                          randconfig-a011
hexagon              randconfig-r045-20221028
x86_64                        randconfig-a003
i386                          randconfig-a015
x86_64                        randconfig-a005

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
