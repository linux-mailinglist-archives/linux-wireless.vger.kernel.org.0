Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608BD5A1ACC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 23:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiHYVFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 17:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiHYVFo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 17:05:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC47D6113C
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 14:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661461542; x=1692997542;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=miy//5TFAM8AttPRzIB9M9g6ifR0N1T9l5bEMwZloig=;
  b=WIeh8/dBHsIkbvdpZ277HfYEoHmMz6gSMdLKz78hnd/5WXa34MVnq0bz
   ag3iPJTKR40hPRS+SRvs1fKmU+EtdmlpFYXGwoNwEVMbR+k1j0tIIOVFP
   7uMZwqo1bQiR60m7dZYniNWxQs+/JW1k6tLHk8rjXK+xsCOLvz6m0sARY
   unIR8Kd/nhb+zNdsjvz0EZC7LRJhdbgfdigEt35HsWQXSlrmhCWRQg0Sg
   gU4vSQhlysfe1UjvKkHRX5FAHWSDY76KaDMOk7Rtx+r+21dIyDK36TVnl
   xRaRI6oH96Ps6I3y0UtJObDwMsDBTjJmJeMLkcvfdQQjp3QkhyjYDd2Lo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295631045"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="295631045"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 14:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587039845"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2022 14:05:40 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRK2m-0002ti-0x;
        Thu, 25 Aug 2022 21:05:40 +0000
Date:   Fri, 26 Aug 2022 05:05:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 55f0a4894484e8d6ddf662f5aebbf3b4cb028541
Message-ID: <6307e413.M2tffDoOB1Jf+uZh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 55f0a4894484e8d6ddf662f5aebbf3b4cb028541  wifi: mac80211: potential NULL dereference in ieee80211_tx_control_port()

elapsed time: 734m

configs tested: 70
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
loongarch                         allnoconfig
x86_64                              defconfig
arc                                 defconfig
i386                                defconfig
alpha                               defconfig
x86_64                               rhel-8.3
arm                                 defconfig
powerpc                           allnoconfig
i386                          randconfig-a001
s390                             allmodconfig
x86_64                           allyesconfig
i386                          randconfig-a016
loongarch                           defconfig
s390                                defconfig
x86_64                        randconfig-a006
i386                          randconfig-a005
powerpc                          allmodconfig
x86_64                        randconfig-a013
i386                          randconfig-a003
mips                             allyesconfig
s390                             allyesconfig
arc                  randconfig-r043-20220824
x86_64                           rhel-8.3-syz
arm                              allyesconfig
x86_64                          rhel-8.3-func
i386                             allyesconfig
x86_64                        randconfig-a002
i386                          randconfig-a014
arm64                            allyesconfig
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
riscv                randconfig-r042-20220824
i386                          randconfig-a012
arc                              allyesconfig
x86_64                    rhel-8.3-kselftests
arc                  randconfig-r043-20220823
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a004
x86_64                        randconfig-a015
m68k                             allyesconfig
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220825
sh                               allmodconfig
ia64                             allmodconfig

clang tested configs:
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a013
hexagon              randconfig-r045-20220825
x86_64                        randconfig-a005
x86_64                        randconfig-a016
i386                          randconfig-a004
hexagon              randconfig-r041-20220824
i386                          randconfig-a011
x86_64                        randconfig-a001
hexagon              randconfig-r045-20220824
hexagon              randconfig-r041-20220823
x86_64                        randconfig-a012
s390                 randconfig-r044-20220825
x86_64                        randconfig-a003
x86_64                        randconfig-a014
hexagon              randconfig-r045-20220823
riscv                randconfig-r042-20220825
hexagon              randconfig-r041-20220825
i386                          randconfig-a006
s390                 randconfig-r044-20220823
riscv                randconfig-r042-20220823

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
