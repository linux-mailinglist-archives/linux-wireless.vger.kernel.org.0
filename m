Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8224654C3C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Dec 2022 06:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLWFfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Dec 2022 00:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWFfF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Dec 2022 00:35:05 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130421E3F8
        for <linux-wireless@vger.kernel.org>; Thu, 22 Dec 2022 21:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671773705; x=1703309705;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+EPuj2yJgZKhoK4uh3S96CsTaLqJ5VawVKWaPJLFyz0=;
  b=kegSHo4sb7vcM7UgzAnU0RKYCakSMWB0iaLxMHbWD84PXbgs/WKrPkA5
   hszb9m2wjfX0N2Ev1gq6Hq2aifbwroGZjS0UDtIALo26+UB2ALm0//A8l
   hfLGVaXlWH3K4QE39HYOTWfpA5YLq+dyfFyJRXljFgWB84yzCBCXiP2Cc
   Kn5lcAJx88iWAajewJjs3pzHyyMR6AtGN0lbZkAXjZdlb4joSjC6rEgS4
   dfRRvRbFSVqzvjOFIhzt2jRKZ8vok3yxqWM01kX5gWYm1F88EeFJyyj4O
   C5z80dXuA0oRfla/h8oNs+tfez5/59+M0rVvMqL1NCfspwTrl/ITufGeN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="320333851"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="320333851"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 21:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="629734151"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="629734151"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Dec 2022 21:35:02 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p8ahx-000CRt-2g;
        Fri, 23 Dec 2022 05:35:01 +0000
Date:   Fri, 23 Dec 2022 13:34:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 44bacbdf9066c590423259dbd6d520baac99c1a8
Message-ID: <63a53e03.yg72BcBtGiO07Tdu%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 44bacbdf9066c590423259dbd6d520baac99c1a8  wifi: wl3501_cs: don't call kfree_skb() under spin_lock_irqsave()

elapsed time: 728m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
s390                                defconfig
um                             i386_defconfig
um                           x86_64_defconfig
s390                             allyesconfig
powerpc                           allnoconfig
x86_64                              defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
sh                               allmodconfig
x86_64               randconfig-a003-20221219
x86_64               randconfig-a001-20221219
x86_64               randconfig-a004-20221219
x86_64               randconfig-a002-20221219
x86_64               randconfig-a006-20221219
x86_64               randconfig-a005-20221219
x86_64                               rhel-8.3
mips                             allyesconfig
powerpc                          allmodconfig
i386                                defconfig
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a001-20221219
i386                 randconfig-a003-20221219
i386                 randconfig-a002-20221219
i386                 randconfig-a006-20221219
i386                 randconfig-a005-20221219
i386                 randconfig-a004-20221219
arm                                 defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
x86_64                        randconfig-a015
riscv                randconfig-r042-20221218
arm64                            allyesconfig
arm                              allyesconfig
arc                  randconfig-r043-20221219
i386                             allyesconfig
arm                  randconfig-r046-20221219
arc                  randconfig-r043-20221218
s390                 randconfig-r044-20221218
x86_64                            allnoconfig
i386                          randconfig-c001
s390                 randconfig-r044-20221222
arc                  randconfig-r043-20221222
riscv                randconfig-r042-20221222
arm                        trizeps4_defconfig
sh                            shmin_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
m68k                        mvme147_defconfig
powerpc                    amigaone_defconfig
m68k                         amcore_defconfig
m68k                        m5272c3_defconfig
sh                           se7724_defconfig
sh                          rsk7203_defconfig
arm                            xcep_defconfig
mips                           xway_defconfig

clang tested configs:
x86_64                          rhel-8.3-rust
i386                 randconfig-a014-20221219
i386                 randconfig-a012-20221219
i386                 randconfig-a013-20221219
i386                 randconfig-a015-20221219
i386                 randconfig-a011-20221219
i386                 randconfig-a016-20221219
x86_64                        randconfig-a012
x86_64                        randconfig-a014
arm                  randconfig-r046-20221218
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221218
hexagon              randconfig-r045-20221219
hexagon              randconfig-r041-20221219
hexagon              randconfig-r045-20221218
riscv                randconfig-r042-20221219
s390                 randconfig-r044-20221219
x86_64               randconfig-a015-20221219
x86_64               randconfig-a013-20221219
x86_64               randconfig-a012-20221219
x86_64               randconfig-a016-20221219
x86_64               randconfig-a014-20221219
x86_64               randconfig-a011-20221219
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
