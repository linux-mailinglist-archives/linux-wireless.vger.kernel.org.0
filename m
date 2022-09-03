Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41A5ABE6F
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Sep 2022 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiICKRS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Sep 2022 06:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiICKRR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Sep 2022 06:17:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F94A550A2
        for <linux-wireless@vger.kernel.org>; Sat,  3 Sep 2022 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662200236; x=1693736236;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Fl5wHYACfqrk88SmL14P2V2T2m+OCSYDQdv9p57MO48=;
  b=dcDIC7ceF1FplUX52vlW58G4bCNHZS48MHAedz1dJ7SidnxdVo+p/Ggh
   QxIrG4GW2mHG65x+2CrpNBhdO3VCBuFyDltHU0Wo5POFABz6hy/C50kbl
   cqieEAx8o9Iqxgbjf3eZD7oZNR/kghjS4siacRX3pNPQEAFamPkDvLYD4
   TmRXu5rGXY4/9vgkm3ihuoLxRw4WHh0SukeZALUhBxrQRO03+OKoU1aOx
   mUcr8IQyi3WDbHnILMr6LWAgu4fl63DQfwW7+S/jsydGx08puQT+l8gwj
   ZgHuLb17JRV0ZxGVNhq3JwcgeBjrFCP4iD+2S9PuHNioHEuBlXbLY13Y4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="360104006"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="360104006"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 03:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="702397342"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Sep 2022 03:17:14 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUQDC-0001S7-00;
        Sat, 03 Sep 2022 10:17:14 +0000
Date:   Sat, 03 Sep 2022 18:16:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld-wip] BUILD SUCCESS
 6c91fe3dbcdf1d526f4db5a7eb16c8198b5dd893
Message-ID: <6313296f.JDJ9yeQT1T/7rukk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld-wip
branch HEAD: 6c91fe3dbcdf1d526f4db5a7eb16c8198b5dd893  wifi: mac80211: prevent VLANs on MLDs

elapsed time: 844m

configs tested: 32
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
um                             i386_defconfig
um                           x86_64_defconfig
m68k                             allyesconfig
mips                             allyesconfig
m68k                             allmodconfig
powerpc                           allnoconfig
arc                              allyesconfig
powerpc                          allmodconfig
alpha                            allyesconfig
x86_64                              defconfig
sh                               allmodconfig
x86_64                               rhel-8.3
i386                                defconfig
x86_64                           allyesconfig
arm                                 defconfig
i386                             allyesconfig
arm                              allyesconfig
arm64                            allyesconfig
powerpc                    adder875_defconfig
powerpc                       ppc64_defconfig
mips                            ar7_defconfig
mips                    maltaup_xpa_defconfig
ia64                             allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
