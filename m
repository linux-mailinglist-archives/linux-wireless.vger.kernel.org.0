Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4358DF3C
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 20:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245228AbiHISmU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347819AbiHISlT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 14:41:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A4C6155
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 11:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660068919; x=1691604919;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=z2dhjMCwuK1fgnw4RHDIk7rCdY/5iiIXtDAw/Jbbbuw=;
  b=oFsCMsQ9STy34Dtqnjzz2h/DR4pbNJFi/ga1TMk6bs6LORM6t2DEYaDx
   /c9xis6anaBKyLWdP1GCGaqEID5baaZh+UGsLlyw/w6k3RZ2MW0FaA/or
   aGJz/gWaUQaI1xm/rkcGCZT5aZLAG3eB2SCzeqk5ITvxSww+WbhxgPMc2
   6UiSwIjsE6R8/nHNDBFG7Ck/bcoDLjn2//NPPzc3xLGR4rRDpNPmaN0dX
   OnDTL5iVepVc08TnXUbYZWPEvH3LEBdlQYP/h0TkFa6ykHGuM8ZU95fk4
   xVTyYO5l0D7H4tPILd4xYAmpPnydg75nOtvL7UbskCID6k/bAF1yF+ewB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="289658535"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="289658535"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 11:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="580902454"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2022 11:14:54 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLTkk-000N8T-0H;
        Tue, 09 Aug 2022 18:14:54 +0000
Date:   Wed, 10 Aug 2022 02:14:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 bafe9528b792f4a442aa1ea2b0297cd53a0351ab
Message-ID: <62f2a418.dxumQTiVN7GOcDjd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: bafe9528b792f4a442aa1ea2b0297cd53a0351ab  wifi: rtw89: 8852a: correct WDE IMR settings

elapsed time: 716m

configs tested: 81
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
i386                                defconfig
arc                  randconfig-r043-20220808
x86_64                              defconfig
i386                             allyesconfig
x86_64               randconfig-a003-20220808
arc                              allyesconfig
i386                 randconfig-a001-20220808
x86_64                           rhel-8.3-kvm
i386                 randconfig-a002-20220808
x86_64                               rhel-8.3
alpha                            allyesconfig
x86_64               randconfig-a004-20220808
i386                 randconfig-a003-20220808
powerpc                          allmodconfig
x86_64               randconfig-a001-20220808
i386                 randconfig-a004-20220808
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
m68k                             allyesconfig
x86_64               randconfig-a005-20220808
i386                 randconfig-a006-20220808
x86_64               randconfig-a002-20220808
x86_64                           rhel-8.3-syz
ia64                             allmodconfig
x86_64               randconfig-a006-20220808
x86_64                          rhel-8.3-func
m68k                             allmodconfig
i386                 randconfig-a005-20220808
x86_64                         rhel-8.3-kunit
mips                             allyesconfig
powerpc                           allnoconfig
sh                               allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
sh                          rsk7203_defconfig
riscv                    nommu_k210_defconfig
powerpc                       holly_defconfig
sparc64                             defconfig
arm                           u8500_defconfig
csky                             alldefconfig
mips                    maltaup_xpa_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                ecovec24-romimage_defconfig
mips                      loongson3_defconfig
loongarch                        alldefconfig
sh                           sh2007_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                 randconfig-c001-20220808

clang tested configs:
hexagon              randconfig-r045-20220808
hexagon              randconfig-r041-20220808
riscv                randconfig-r042-20220808
s390                 randconfig-r044-20220808
x86_64               randconfig-a013-20220808
x86_64               randconfig-a015-20220808
x86_64               randconfig-a016-20220808
x86_64               randconfig-a012-20220808
x86_64               randconfig-a011-20220808
x86_64               randconfig-a014-20220808
i386                 randconfig-a011-20220808
i386                 randconfig-a013-20220808
i386                 randconfig-a012-20220808
i386                 randconfig-a014-20220808
i386                 randconfig-a016-20220808
i386                 randconfig-a015-20220808
arm                       mainstone_defconfig
arm                   milbeaut_m10v_defconfig
x86_64               randconfig-k001-20220808

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
