Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D125464BD17
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Dec 2022 20:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiLMTTA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Dec 2022 14:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236572AbiLMTS2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Dec 2022 14:18:28 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB419FCF
        for <linux-wireless@vger.kernel.org>; Tue, 13 Dec 2022 11:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670959106; x=1702495106;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=GOAXpZTUrNasrSSnbbjVKOnWuWzO1KmhMhW45uiItZM=;
  b=Ke08cYBk7/EuPyX1gXwOiRlms5tzZoVilqt0GcWrmS4U+mo1MmI1EBx0
   eHQb/rHAeftOPkRRkjxrzi2Q+GxERxI73UWYdCWXUh0T0647Tol97b/84
   v5RUzqUxSulsX+ry9ujvK0mVBB3Z8j8b66/q3FnGdPRl6zFrhgS0XqJIE
   qJtTvOlc1N7V9fv/LTKmAsPb5UGrF0DHPhSs41Zg/pcsOPFyZKIGh3q13
   E9E4j/eWiMFGq8wkOmjgVHa5pkctH81WPuik50Sw1Orlj8Bs/COSrwArb
   3UNOGNBxKFaR+iTUtDih+0A29XVuYWFROmcH/McaDdu65e/uonDLfcHS/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="305856411"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="305856411"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 11:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="823006714"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="823006714"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2022 11:18:24 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5AnH-0004gd-1k;
        Tue, 13 Dec 2022 19:18:23 +0000
Date:   Wed, 14 Dec 2022 03:17:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 d1c722867f8022a27182b9a1d84e9bca75486c9a
Message-ID: <6398cfc7.jZOUPqyxbPmf401B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: d1c722867f8022a27182b9a1d84e9bca75486c9a  net: lan966x: Remove a useless test in lan966x_ptp_add_trap()

elapsed time: 878m

configs tested: 66
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-rust
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
arm                                 defconfig
x86_64                              defconfig
ia64                             allmodconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                                defconfig
i386                          randconfig-a001
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a003
i386                          randconfig-a014
x86_64                        randconfig-a015
i386                          randconfig-a016
i386                          randconfig-a005
arm64                            allyesconfig
arc                  randconfig-r043-20221213
x86_64                        randconfig-a004
arm                  randconfig-r046-20221213
x86_64                        randconfig-a002
arm                              allyesconfig
x86_64                        randconfig-a006
i386                          randconfig-a012
i386                             allyesconfig
powerpc                           allnoconfig
arc                                 defconfig
s390                             allmodconfig
um                           x86_64_defconfig
alpha                               defconfig
um                             i386_defconfig
s390                                defconfig
sh                               allmodconfig
s390                             allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
x86_64                           rhel-8.3-syz
arc                              allyesconfig
alpha                            allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm

clang tested configs:
hexagon              randconfig-r045-20221213
s390                 randconfig-r044-20221213
hexagon              randconfig-r041-20221213
i386                          randconfig-a002
i386                          randconfig-a013
i386                          randconfig-a006
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a014
riscv                randconfig-r042-20221213
i386                          randconfig-a004
x86_64               randconfig-a002-20221212
x86_64               randconfig-a001-20221212
x86_64                        randconfig-a001
x86_64               randconfig-a004-20221212
x86_64                        randconfig-a003
x86_64               randconfig-a003-20221212
x86_64                        randconfig-a005
x86_64               randconfig-a006-20221212
i386                          randconfig-a011
x86_64               randconfig-a005-20221212
i386                          randconfig-a015

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
