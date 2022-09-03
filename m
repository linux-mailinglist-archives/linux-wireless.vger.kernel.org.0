Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78915ABE6D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Sep 2022 12:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiICKQS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Sep 2022 06:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiICKQR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Sep 2022 06:16:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EC354649
        for <linux-wireless@vger.kernel.org>; Sat,  3 Sep 2022 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662200176; x=1693736176;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ipQwja6Z5sYYrFOROx3MUnGqkCK8FmgUkl1BgeWnEc4=;
  b=Ja5kkqLrNbHFmK+rb3uCdRBRPOIS+4p30n7HN2cA3qjg7ZFFTHUwLfDD
   uHrotpYe8uLqWpDWmANGMdvviBmOkyVCjNXuxfEjVTnaLatJUWEGSMK2r
   RfX014L/BhN62AHUipS4JKeECbBUsqWXmZRexieT0UNdd3a/4Z7ktwOnD
   Limo+qTELx3JL+MOjP79Z7dMP4gQ7E8NY19Ow2hJ+OM4488tUWkhzszIF
   Fun/ql9oSGVr9CRlAKQkFYMifP673cmc3AJuMgxYrflA9XS2OJek42453
   GU/K8QvuPXyV9gUKNtufcNmyJvlV8wMH2SNkIhqVKOBmZ+gbVrzGpuyX8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="322311904"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="322311904"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 03:16:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="643236766"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2022 03:16:14 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUQCD-0001Rr-2S;
        Sat, 03 Sep 2022 10:16:13 +0000
Date:   Sat, 03 Sep 2022 18:15:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 338983ef25e6ce64b002e9b1b0f78f40124b136a
Message-ID: <63132957.7ilw4QjIX+XVooas%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: 338983ef25e6ce64b002e9b1b0f78f40124b136a  wifi: mac80211: fix double SW scan stop

elapsed time: 844m

configs tested: 32
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
um                           x86_64_defconfig
um                             i386_defconfig
m68k                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
mips                             allyesconfig
sh                               allmodconfig
x86_64                              defconfig
x86_64                               rhel-8.3
alpha                            allyesconfig
arc                              allyesconfig
m68k                             allmodconfig
i386                                defconfig
x86_64                           allyesconfig
arm                                 defconfig
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig
powerpc                    adder875_defconfig
powerpc                       ppc64_defconfig
mips                            ar7_defconfig
mips                    maltaup_xpa_defconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
