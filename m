Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461EE64D520
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Dec 2022 02:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLOBzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 20:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLOBzi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 20:55:38 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919A9C1F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 17:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671069336; x=1702605336;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=AgA3kxoOjqJnFHfxWQHAgezhG73WtHNxuWOs7ySUBIA=;
  b=DzEgfmHxMBAXpSm2in4tDsqD+oTmsdjciiDQjjBrEsm8lBH2mDAbzV9F
   E12G2m0qK1B3oK+puJY77Ys+ikkDnlFniHmVlcP9d/HIgbdMGKpJ6gcK1
   0cAxoNOsFuIvMMvkAeB5YepRE2BMbOJKakU2kaCc8XgbEay6tq8fE/AQV
   vQoIk7piXbUX8hv+5G7nwotygLKeoll4D5pMJKnRXRIWWERHB1AvqvScb
   DW5fipfYfYCJbeTxCNjO6F0d7HqQeWboHkvTZJigRG93yrNuLAQ1NCacy
   SoY3iF3O5w4PiidRhDVWi3fTJ/JjsVJ73IZeM+xD+Zw1oKXPXKbDmypTP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="318608980"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="318608980"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 17:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="679944192"
X-IronPort-AV: E=Sophos;i="5.96,246,1665471600"; 
   d="scan'208";a="679944192"
Received: from lkp-server01.sh.intel.com (HELO b5d47979f3ad) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Dec 2022 17:55:34 -0800
Received: from kbuild by b5d47979f3ad with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1p5dTB-0005xG-2Z;
        Thu, 15 Dec 2022 01:55:33 +0000
Date:   Thu, 15 Dec 2022 09:54:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 4b634e0d30185615bf0fdcf1c14c50de7cca8783
Message-ID: <639a7e6d.MSAxRAwCeS0WSRVF%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 4b634e0d30185615bf0fdcf1c14c50de7cca8783  Merge tag 'mt76-for-kvalo-2022-12-09' of https://github.com/nbd168/wireless into pending

elapsed time: 737m

configs tested: 86
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arm                                 defconfig
x86_64                           rhel-8.3-bpf
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20221214
s390                 randconfig-r044-20221214
riscv                randconfig-r042-20221214
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arm64                            allyesconfig
i386                          randconfig-a014
ia64                             allmodconfig
i386                          randconfig-a001
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a003
i386                          randconfig-a005
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
i386                             allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-rust
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                            allnoconfig
powerpc                         wii_defconfig
arm                          pxa3xx_defconfig
sh                                  defconfig
powerpc                     rainier_defconfig
sh                           se7705_defconfig
powerpc                           allnoconfig
sh                           se7751_defconfig
arm64                            alldefconfig
sh                           sh2007_defconfig
powerpc                   currituck_defconfig
arc                         haps_hs_defconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                                defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
s390                                defconfig
i386                          randconfig-c001
s390                             allyesconfig
xtensa                         virt_defconfig
sparc                       sparc64_defconfig
mips                             allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
powerpc                      ppc40x_defconfig
sh                          rsk7269_defconfig
loongarch                           defconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
arm                  randconfig-r046-20221214
hexagon              randconfig-r041-20221214
hexagon              randconfig-r045-20221214
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a013
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-k001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
