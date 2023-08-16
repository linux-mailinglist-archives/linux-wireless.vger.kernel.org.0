Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1688777DDC9
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 11:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbjHPJuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 05:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbjHPJuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 05:50:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166BADF
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 02:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692179418; x=1723715418;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oWi75NojLSLKlx4YxL2ARuRq66wAnt6OUzej2OG3Tqo=;
  b=kZWX+R1ta+j0jpZqsRuDMeEdVpEFIpe1H1uTEaqgstRb4etFKycL+8ek
   0vVHEch3MeIBsBTwBYuuSEHPgfdbVgByGXoUL9Hd08ccZChWxz+rjOb2k
   0YxSiSz5f1UAncrJ2zk72wgwGzTIFCtuWQGZdI0Upqk3GTCIx92uIg9wR
   YF8NViLedRX1PuuOTvfBF5UhPoDgIZIC401qEWOMEGyXQktBrKeIKZyVQ
   1rywkXAMu2uqGdQaEk+lEId4zGBFXHZ6gr88RapCX8MHOKMw08IlQ2+cc
   OmJOIK35XJURf8P+BGo/AnJJVlq8jYhwb7i9i8SmXL/K6LrMGd8v1V/DI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458842070"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="458842070"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 02:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769128511"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769128511"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2023 02:50:15 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWDAD-0000Cf-0G;
        Wed, 16 Aug 2023 09:50:07 +0000
Date:   Wed, 16 Aug 2023 17:49:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Aloka Dixit <quic_alokad@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] wifi: mac80211: fix puncturing bitmap handling in CSA
Message-ID: <202308161727.hK0qYLAL-lkp@intel.com>
References: <20230816101108.9a2a011e3670.I062e026efafb59b026ab72fc7f7fce54f43dd29b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816101108.9a2a011e3670.I062e026efafb59b026ab72fc7f7fce54f43dd29b@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main linus/master v6.5-rc6 next-20230816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/wifi-mac80211-fix-puncturing-bitmap-handling-in-CSA/20230816-161302
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230816101108.9a2a011e3670.I062e026efafb59b026ab72fc7f7fce54f43dd29b%40changeid
patch subject: [PATCH v2] wifi: mac80211: fix puncturing bitmap handling in CSA
config: riscv-randconfig-r012-20230816 (https://download.01.org/0day-ci/archive/20230816/202308161727.hK0qYLAL-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308161727.hK0qYLAL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308161727.hK0qYLAL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/mac80211/cfg.c:3680:6: error: use of undeclared identifier 'link_data'
    3680 |         if (link_data->conf->eht_puncturing != link_data->conf->csa_punct_bitmap) {
         |             ^
   net/mac80211/cfg.c:3680:41: error: use of undeclared identifier 'link_data'
    3680 |         if (link_data->conf->eht_puncturing != link_data->conf->csa_punct_bitmap) {
         |                                                ^
   net/mac80211/cfg.c:3681:3: error: use of undeclared identifier 'link_data'
    3681 |                 link_data->conf->eht_puncturing =
         |                 ^
   net/mac80211/cfg.c:3682:6: error: use of undeclared identifier 'link_data'
    3682 |                                         link_data->conf->csa_punct_bitmap;
         |                                         ^
   4 errors generated.


vim +/link_data +3680 net/mac80211/cfg.c

  3640	
  3641	static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
  3642	{
  3643		struct ieee80211_local *local = sdata->local;
  3644		u64 changed = 0;
  3645		int err;
  3646	
  3647		sdata_assert_lock(sdata);
  3648		lockdep_assert_held(&local->mtx);
  3649		lockdep_assert_held(&local->chanctx_mtx);
  3650	
  3651		/*
  3652		 * using reservation isn't immediate as it may be deferred until later
  3653		 * with multi-vif. once reservation is complete it will re-schedule the
  3654		 * work with no reserved_chanctx so verify chandef to check if it
  3655		 * completed successfully
  3656		 */
  3657	
  3658		if (sdata->deflink.reserved_chanctx) {
  3659			/*
  3660			 * with multi-vif csa driver may call ieee80211_csa_finish()
  3661			 * many times while waiting for other interfaces to use their
  3662			 * reservations
  3663			 */
  3664			if (sdata->deflink.reserved_ready)
  3665				return 0;
  3666	
  3667			return ieee80211_link_use_reserved_context(&sdata->deflink);
  3668		}
  3669	
  3670		if (!cfg80211_chandef_identical(&sdata->vif.bss_conf.chandef,
  3671						&sdata->deflink.csa_chandef))
  3672			return -EINVAL;
  3673	
  3674		sdata->vif.bss_conf.csa_active = false;
  3675	
  3676		err = ieee80211_set_after_csa_beacon(sdata, &changed);
  3677		if (err)
  3678			return err;
  3679	
> 3680		if (link_data->conf->eht_puncturing != link_data->conf->csa_punct_bitmap) {
  3681			link_data->conf->eht_puncturing =
  3682						link_data->conf->csa_punct_bitmap;
  3683			changed |= BSS_CHANGED_EHT_PUNCTURING;
  3684		}
  3685	
  3686		ieee80211_link_info_change_notify(sdata, &sdata->deflink, changed);
  3687	
  3688		if (sdata->deflink.csa_block_tx) {
  3689			ieee80211_wake_vif_queues(local, sdata,
  3690						  IEEE80211_QUEUE_STOP_REASON_CSA);
  3691			sdata->deflink.csa_block_tx = false;
  3692		}
  3693	
  3694		err = drv_post_channel_switch(sdata);
  3695		if (err)
  3696			return err;
  3697	
  3698		cfg80211_ch_switch_notify(sdata->dev, &sdata->deflink.csa_chandef, 0,
  3699					  sdata->vif.bss_conf.eht_puncturing);
  3700	
  3701		return 0;
  3702	}
  3703	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
