Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1D26414A8
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 08:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiLCHOt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Dec 2022 02:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiLCHOp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Dec 2022 02:14:45 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919347BC03
        for <linux-wireless@vger.kernel.org>; Fri,  2 Dec 2022 23:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670051684; x=1701587684;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zHveHnZ2VTTKDB9/VWFZUd53CjEziuY5sepekDTl+fY=;
  b=gDggy1PMkD7UaAkSbv5bl8IlrTFzifIcO/ccgGUOcLCzRtsIeAuezuZS
   G7RrKR2MaHJM09ZkCYrAQ+ZQt/1JKTKTYv14df8JGdGzCtBTlAfm0EvH1
   GLmA+6/0tld9tCeVE/bufWGdPZEl6KzDa4j/tpubqsgwSgRZmMbuV3fgh
   I5myDd6aS2VQ8BY4UDOAjHqn0ourdX8wz7TrTUOUpL4ADwRtEPhONv9nH
   pQwozlm1y6G1i+ThS21wU4vsUCwGf/Mtz7+Cu+m9nxV//BFUPqtGO0+Yw
   97aZhD6Y12hBgzk1LTG0ZFAzn24fqh10pBv1hvUIrhNG+inTrpTWAemj4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="380394182"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="380394182"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 23:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="819670442"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="819670442"
Received: from lkp-server01.sh.intel.com (HELO 64a2d449c951) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Dec 2022 23:14:42 -0800
Received: from kbuild by 64a2d449c951 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p1MjR-000EMo-3B;
        Sat, 03 Dec 2022 07:14:41 +0000
Date:   Sat, 03 Dec 2022 15:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 d03407183d97554dfffea70f385b5bdd520f846c
Message-ID: <638af72c.5Yn5XhW/PF0Kp0oo%lkp@intel.com>
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
branch HEAD: d03407183d97554dfffea70f385b5bdd520f846c  wifi: ath10k: fix QCOM_SMEM dependency

elapsed time: 727m

configs tested: 61
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
m68k                             allyesconfig
um                             i386_defconfig
m68k                             allmodconfig
um                           x86_64_defconfig
arc                              allyesconfig
alpha                            allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                 randconfig-r044-20221201
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig
x86_64                           rhel-8.3-kvm
s390                                defconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a015
ia64                             allmodconfig
arc                  randconfig-r043-20221201
riscv                randconfig-r042-20221201
s390                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                                defconfig
i386                          randconfig-a005
i386                          randconfig-a016
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                            allnoconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                          randconfig-c001

clang tested configs:
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
hexagon              randconfig-r045-20221201
hexagon              randconfig-r041-20221201
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
