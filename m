Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EF95E6AF5
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiIVSbT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 14:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiIVSat (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 14:30:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28E814F8
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 11:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663871283; x=1695407283;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=95s75/JMc7X/DwsTcP/SFNTGrTmoGq4IIR8TfPrIBZs=;
  b=ARvhoxIjESJ/y9XZ6F8++yg+TvJgUxDTTF6jcJ6qNTH4jPA8RdCblauu
   DxKgSlwLEpPSI2fyCOCNEXmNsEIRU+GGilTq9NNrym/yD8bKuCM3w+qTQ
   J/NT7jmwd11tAuqCJK7SK0uP8LauC7PY7eRko4SA2TD9C4ZnPjGhcIKZ6
   fBkV29TzeVFYwDHGaJxyxq+4dreDnaiUlT9h84eLRg2968xs06p7XJH9i
   VHuIP0KgdiE6ESWtCZtcCajYoEe/M1pJXb3CUk18ZJJn5gkQbv5Jke7uZ
   HdVc5Jfq1sxnyjhzivQVoe98yYQcNrcWuGiVc/YdLsmw7WMTCPSTaU4oA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301806133"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301806133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 11:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="619903362"
Received: from lkp-server01.sh.intel.com (HELO c0a60f19fe7e) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Sep 2022 11:23:35 -0700
Received: from kbuild by c0a60f19fe7e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1obQrH-0004rh-0V;
        Thu, 22 Sep 2022 18:23:35 +0000
Date:   Fri, 23 Sep 2022 02:23:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 aa7a5f946f5baa9209e44aeb1063316a27ad29c8
Message-ID: <632ca81b.RjOeOgAnllVJKSTK%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: aa7a5f946f5baa9209e44aeb1063316a27ad29c8  Merge tag 'iwlwifi-next-for-kalle-2022-09-18' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 721m

configs tested: 58
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                              defconfig
arc                  randconfig-r043-20220921
riscv                randconfig-r042-20220921
x86_64                               rhel-8.3
s390                                defconfig
s390                 randconfig-r044-20220921
x86_64                        randconfig-a004
powerpc                          allmodconfig
i386                                defconfig
x86_64                        randconfig-a002
s390                             allyesconfig
x86_64                        randconfig-a013
sh                               allmodconfig
x86_64                        randconfig-a006
x86_64                           allyesconfig
arm                                 defconfig
i386                          randconfig-a014
mips                             allyesconfig
i386                          randconfig-a001
x86_64                        randconfig-a011
powerpc                           allnoconfig
i386                          randconfig-a012
i386                          randconfig-a003
i386                          randconfig-a016
x86_64                        randconfig-a015
i386                          randconfig-a005
arm                              allyesconfig
arm64                            allyesconfig
m68k                             allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220921
hexagon              randconfig-r045-20220921
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a013
i386                          randconfig-a011
x86_64                        randconfig-a005
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a002
i386                          randconfig-a015
i386                          randconfig-a004
i386                          randconfig-a006

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
