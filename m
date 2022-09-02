Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6305AA497
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 02:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiIBArM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Sep 2022 20:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiIBArL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Sep 2022 20:47:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CFAA3478
        for <linux-wireless@vger.kernel.org>; Thu,  1 Sep 2022 17:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662079630; x=1693615630;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=rng5btMRYg2RfNGoPBuNd4JsJS0SdByYwPyG3TcgmIM=;
  b=LVISmNx27S/9noxuFJaOlvDKLu4lYh0Hp41DsH+V9vlyG3k+6ooGRRTa
   hQx+TL/S26+M90WdSJ6dFT/Ric+Dsq23yJCh5aM71MBqG3C/csXgW/3a5
   VrZRkQEKs/0GRtbjiRhcCvDppy0MyHjF+S/6jOtTG0l75awsPEkqUuoY0
   tn2fOJ+lT9d6sxPMSUCUV8EqY0BMhmnkoGTQwu1Mwhyws0BZ2N3ncGZFg
   1COvbSaHBL90v8dt3b7R6C9nVJFpUWO/2mH0e0D02zP+9z1EXrUGK16j6
   VcHKU7FBtoR5L10GzgvkpFgWKF2TEsMTobxSy4i7JCvVW16ihmQMc3qsi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="294603425"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="294603425"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 17:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589814697"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 17:47:08 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTupv-0000wn-2R;
        Fri, 02 Sep 2022 00:47:07 +0000
Date:   Fri, 02 Sep 2022 08:46:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld-wip] BUILD REGRESSION
 10cf17b0508f56ee45e15ad2a612b64999264d4f
Message-ID: <63115279.sdSELItEr3Uec5eg%lkp@intel.com>
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
branch HEAD: 10cf17b0508f56ee45e15ad2a612b64999264d4f  wifi: nl80211: add MLD address to assoc BSS entries

Error/Warning reports:

https://lore.kernel.org/lkml/202209011914.qsuHMsE0-lkp@intel.com
https://lore.kernel.org/lkml/202209011952.4tMld57n-lkp@intel.com
https://lore.kernel.org/lkml/202209012046.5sg4d0qh-lkp@intel.com
https://lore.kernel.org/lkml/202209020842.MRD1g4vr-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/net/wireless/realtek/rtw88/fw.c:1085:27: error: too few arguments to function 'ieee80211_nullfunc_get'
drivers/net/wireless/st/cw1200/sta.c:198:23: error: too few arguments to function 'ieee80211_nullfunc_get'
net/mac80211/link.c:398:51: error: 'BSS_CHANGED_EHT_PUNCTURING' undeclared (first use in this function)

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-r015-20220901
|   |-- drivers-net-wireless-realtek-rtw88-fw.c:error:too-few-arguments-to-function-ieee80211_nullfunc_get
|   `-- drivers-net-wireless-st-cw1200-sta.c:error:too-few-arguments-to-function-ieee80211_nullfunc_get
|-- i386-randconfig-a005
|   `-- net-mac80211-link.c:error:BSS_CHANGED_EHT_PUNCTURING-undeclared-(first-use-in-this-function)
|-- sh-allmodconfig
|   `-- drivers-net-wireless-st-cw1200-sta.c:error:too-few-arguments-to-function-ieee80211_nullfunc_get
`-- sparc-allyesconfig
    |-- drivers-net-wireless-realtek-rtw88-fw.c:error:too-few-arguments-to-function-ieee80211_nullfunc_get
    |-- drivers-net-wireless-st-cw1200-sta.c:error:too-few-arguments-to-function-ieee80211_nullfunc_get
    `-- net-mac80211-link.c:error:BSS_CHANGED_EHT_PUNCTURING-undeclared-(first-use-in-this-function)
clang_recent_errors
`-- x86_64-randconfig-a003
    |-- drivers-net-wireless-st-cw1200-sta.c:error:too-few-arguments-to-function-call-expected-have
    `-- net-mac80211-link.c:error:use-of-undeclared-identifier-BSS_CHANGED_EHT_PUNCTURING

elapsed time: 1057m

configs tested: 53
configs skipped: 2

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
i386                                defconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                               rhel-8.3
i386                             allyesconfig
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a001
i386                          randconfig-a003
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                        randconfig-a013
i386                          randconfig-a005
x86_64                        randconfig-a011
m68k                             allyesconfig
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
x86_64                           rhel-8.3-kvm
arc                  randconfig-r043-20220901
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
x86_64                              defconfig
m68k                             allmodconfig
x86_64                           allyesconfig
alpha                            allyesconfig
arc                              allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
i386                          randconfig-a002
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
i386                          randconfig-a006
x86_64                        randconfig-a016
riscv                randconfig-r042-20220901
hexagon              randconfig-r045-20220901
hexagon              randconfig-r041-20220901
s390                 randconfig-r044-20220901

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
