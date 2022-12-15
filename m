Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906B364D521
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Dec 2022 02:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLOBzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 20:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLOBzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 20:55:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7441D285
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 17:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671069338; x=1702605338;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=zlyKmeirElWttnc+7OMKDlmqQuCcoAGrJfr78UkkpWg=;
  b=BDe8oG8IZz33Mo/5WMw6jWK+eYSXz59H/h404qOlOxuor/Kx2q8vFoYn
   AULkNDFCGieKfUiXRcI8qpB3Cd54H/dJvEV7b4SFYErlKXqFfiBaEmn01
   L+d9ALShv0JWxDRvCYV0MKWQjMhmqOoPSCOMduQu9lhgVIOqvhdVQfaKW
   RjVW72o1XuiNXfBhW6SZOvvtUy0+kNoDkwEKt5RHVuHIOPOZt8rT6aX7Y
   kKDM1NxtJyfJ3cqfwusexLzQA5Mix8486ZuHVYGdHOaGE5SRd0wrq0MzB
   /CJwOKIgGNhN9VvF0+A9En4gACMmRRicxy+X23tMsEgIknsG7yDYr2fPF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="318608983"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="318608983"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="679944193"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="679944193"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2022 17:55:34 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5dTB-0005xI-2d;
        Thu, 15 Dec 2022 01:55:33 +0000
Date:   Thu, 15 Dec 2022 09:54:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 01258b62c62710297dab4e2b72f46e01be392cc6
Message-ID: <639a7e6f.DvIfkCAdFV8ZIQTL%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 01258b62c62710297dab4e2b72f46e01be392cc6  wifi: ti: remove obsolete lines in the Makefile

elapsed time: 738m

configs tested: 86
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                           allnoconfig
um                           x86_64_defconfig
um                             i386_defconfig
sh                               allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
s390                 randconfig-r044-20221214
i386                          randconfig-a005
mips                             allyesconfig
x86_64                        randconfig-a004
powerpc                          allmodconfig
x86_64                        randconfig-a002
ia64                             allmodconfig
x86_64                        randconfig-a006
m68k                             allyesconfig
arc                  randconfig-r043-20221214
x86_64                           rhel-8.3-bpf
m68k                             allmodconfig
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a016
x86_64                           rhel-8.3-syz
x86_64                        randconfig-a015
i386                          randconfig-a014
arc                              allyesconfig
riscv                randconfig-r042-20221214
x86_64                         rhel-8.3-kunit
i386                          randconfig-a012
alpha                            allyesconfig
x86_64                           rhel-8.3-kvm
i386                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-rust
x86_64                            allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
i386                                defconfig
powerpc                         wii_defconfig
arm                          pxa3xx_defconfig
sh                                  defconfig
powerpc                     rainier_defconfig
sh                           se7705_defconfig
s390                                defconfig
sh                           se7751_defconfig
arm64                            alldefconfig
sh                           sh2007_defconfig
powerpc                   currituck_defconfig
arc                         haps_hs_defconfig
arm64                               defconfig
s390                             allyesconfig
m68k                                defconfig
i386                          randconfig-c001
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
ia64                                defconfig
xtensa                         virt_defconfig
sparc                       sparc64_defconfig
mips                             allmodconfig

clang tested configs:
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
arm                  randconfig-r046-20221214
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a016
hexagon              randconfig-r041-20221214
x86_64                        randconfig-a012
hexagon              randconfig-r045-20221214
x86_64                        randconfig-a014
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
