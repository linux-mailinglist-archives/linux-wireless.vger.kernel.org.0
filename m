Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B18E647DCD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Dec 2022 07:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiLIGdM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Dec 2022 01:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIGdK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Dec 2022 01:33:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C3F6BC87
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 22:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670567589; x=1702103589;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JTyAW90Ku8nNHNKMAQ5NBEqOSQO0g1/SOVsFTn1jCgA=;
  b=QcRGBx5/pq52V6YQ3HHwBOr2tyRayzZbP77Kx2wJjJjp1We2+azlOfh2
   +ZYslUk/3hlB64NUZ7+mrwLUDu9ufcfEBcMeMHyUhTerTlE68dyI/ByU0
   9Bhgr/l95W2rDuxZtSmRDc17BiXLMZzLeTnn8ocVGdmFQQxCK3IMzPE8b
   Qg+ihooUcpWgcpce3Or4GlZBN+bbOplLoO8qHS+iSi/fmMtSrJdQd2eFs
   z3bSzA/eAO3jURF0BbKiNUG/kBZcqhc6WEW1imtChflFJ67Q8OOzY8tRK
   lvpfcOKs72ej8VMqJaFJZM5BjqQKhpXOUlU9de6ObtruK4eX+N7fK3NFF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="297070117"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="297070117"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2022 22:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10555"; a="678052988"
X-IronPort-AV: E=Sophos;i="5.96,230,1665471600"; 
   d="scan'208";a="678052988"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Dec 2022 22:33:07 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p3WwU-0001h1-1J;
        Fri, 09 Dec 2022 06:33:06 +0000
Date:   Fri, 09 Dec 2022 14:32:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 832c3f66f53f1eb20f424b916a311ad82074ef0d
Message-ID: <6392d67e./MnesDcx26O9bNy5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 832c3f66f53f1eb20f424b916a311ad82074ef0d  Merge tag 'iwlwifi-next-for-kalle-2022-12-07' of http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 835m

configs tested: 60
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                           allyesconfig
i386                             allyesconfig
arc                  randconfig-r043-20221207
s390                 randconfig-r044-20221207
riscv                randconfig-r042-20221207
arm                                 defconfig
x86_64                          rhel-8.3-rust
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
i386                          randconfig-a014
i386                          randconfig-a005
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                                 defconfig
um                           x86_64_defconfig
um                             i386_defconfig
alpha                               defconfig
powerpc                           allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
sh                               allmodconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
ia64                             allmodconfig
powerpc                          allmodconfig
mips                             allyesconfig
s390                             allyesconfig

clang tested configs:
arm                  randconfig-r046-20221207
hexagon              randconfig-r041-20221207
hexagon              randconfig-r045-20221207
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a006
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
