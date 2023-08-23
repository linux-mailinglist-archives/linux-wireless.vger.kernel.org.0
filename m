Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08A67861FD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Aug 2023 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbjHWVNM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Aug 2023 17:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbjHWVNL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Aug 2023 17:13:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6017410D8
        for <linux-wireless@vger.kernel.org>; Wed, 23 Aug 2023 14:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692825189; x=1724361189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fx6XHiDbKR09aJ2pIBVrkeck4ZiQZxqTBfit32JbjbU=;
  b=M9JOharWPUf6AUpigg2Qhk+SvbAHQg4xiGJkC9Ei0F6UH4eRdvIweN8d
   ID6feodx+0mEMqxLPSfAA7dGLOIwcNmv6iBaP47rHgE7lCgKOVCGK27rR
   ipnpIebSbwaTBVRciN3h7+FBVQYJ5zdQ/2ZeuqShO5vORzNeW3OzRiX5s
   9zlW0ETVkLeonaEn/aPntypwthguA/PomO+0OhlDX9CK7SIaHhB3/6Y3D
   HHk5ruh0J0b6uq92LawyLuzerVhJXGxsMKaGiEOv5xTDzh/gDbCOaRyk1
   jDTndlQOeGKPkBfSHqVLqmkszTM59j0eDQFd5GGFAWROVF5upJhzhpL9U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378026738"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="378026738"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 14:13:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="736804045"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="736804045"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2023 14:13:06 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYvA2-0001Vo-0T;
        Wed, 23 Aug 2023 21:13:06 +0000
Date:   Thu, 24 Aug 2023 05:12:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Wen Gong <quic_wgong@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] Revert "mac80211: add parse regulatory info in 6 GHz
 operation information"
Message-ID: <202308240547.O8ZxrrXI-lkp@intel.com>
References: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e@changeid>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc7 next-20230823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/Revert-mac80211-add-parse-regulatory-info-in-6-GHz-operation-information/20230821-170019
base:   linus/master
patch link:    https://lore.kernel.org/r/20230821105903.7482379cde47.Ib72645d02fadc24b520db118abd82e861c87316e%40changeid
patch subject: [PATCH] Revert "mac80211: add parse regulatory info in 6 GHz operation information"
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230824/202308240547.O8ZxrrXI-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230824/202308240547.O8ZxrrXI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308240547.O8ZxrrXI-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/realtek/rtw89/regd.c: In function 'rtw89_reg_6ghz_power_recalc':
>> drivers/net/wireless/realtek/rtw89/regd.c:514:39: error: 'struct ieee80211_bss_conf' has no member named 'power_type'; did you mean 'txpower_type'?
     514 |                 switch (vif->bss_conf.power_type) {
         |                                       ^~~~~~~~~~
         |                                       txpower_type


vim +514 drivers/net/wireless/realtek/rtw89/regd.c

f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  505  
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  506  void rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  507  				 struct rtw89_vif *rtwvif, bool active)
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  508  {
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  509  	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  510  
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  511  	lockdep_assert_held(&rtwdev->mutex);
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  512  
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02  513  	if (active) {
f6baa1d3d5703f Zong-Zhe Yang 2023-06-02 @514  		switch (vif->bss_conf.power_type) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
