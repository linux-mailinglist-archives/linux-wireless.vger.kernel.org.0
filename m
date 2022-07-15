Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774CA575B9A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jul 2022 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiGOGcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jul 2022 02:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGOGcH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jul 2022 02:32:07 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532CA16594
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 23:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657866726; x=1689402726;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EuKip+TXZz2xR/QaVcwAq7GHxrLp6LiP8UsEz3Qmbrg=;
  b=P7KI0zhf1OdgxZD2JhBmeoNqi3+iK3TpCZ83x6u68w0e/jd8/tkifuqh
   FBOpdbqHKg22XqMBFSz3NEgL+WCfcrPhusRxS2AAqGZuZxbfnHUtMUX1c
   eUXnjkPGN0qiX1uIyA7+J+FckeIO1rION1zsZ/ltTtzI60fVfcbF7boWs
   aQTuguXvDUMff2Od/XYWXuCnSgjrj1PIwPStcOJRCjPOapU40coYHGMBk
   6UDLMYlri8vrDIPFqXgi2o9r/fF1qexiTkbmvGot+c5p3eSxMKCIj86GN
   mf4dE401WcDS9Au7RlPeB56Fk+DSxHd8SN9NcGrGi5awlZqY88swFBAUM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="285738416"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="285738416"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 23:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="571402951"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 23:32:04 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCErr-0001bZ-Dy;
        Fri, 15 Jul 2022 06:32:03 +0000
Date:   Fri, 15 Jul 2022 14:32:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:mld 102/108] net/mac80211/ibss.c:1229:40: error: too
 many arguments to function call, expected 3, have 4
Message-ID: <202207151420.mhh13hEP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
head:   ee037b2207cd4998c49505602d29216285d92764
commit: 75f48f25ce9f273e28d065adc60fb33496d45341 [102/108] wifi: mac80211: fix up link station creation/insertion
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220715/202207151420.mhh13hEP-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git/commit/?id=75f48f25ce9f273e28d065adc60fb33496d45341
        git remote add wireless-next https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
        git fetch --no-tags wireless-next mld
        git checkout 75f48f25ce9f273e28d065adc60fb33496d45341
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mac80211/ibss.c:1229:40: error: too many arguments to function call, expected 3, have 4
           sta = sta_info_alloc(sdata, addr, -1, GFP_ATOMIC);
                 ~~~~~~~~~~~~~~                  ^~~~~~~~~~
   include/linux/gfp.h:340:20: note: expanded from macro 'GFP_ATOMIC'
   #define GFP_ATOMIC      (__GFP_HIGH|__GFP_ATOMIC|__GFP_KSWAPD_RECLAIM)
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/mac80211/sta_info.h:842:18: note: 'sta_info_alloc' declared here
   struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
                    ^
   1 error generated.


vim +1229 net/mac80211/ibss.c

469002983fc90c Johannes Berg    2009-02-15  1190  
8bf11d8d081106 Johannes Berg    2011-12-15  1191  void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
8bf11d8d081106 Johannes Berg    2011-12-15  1192  			      const u8 *bssid, const u8 *addr,
8bf11d8d081106 Johannes Berg    2011-12-15  1193  			      u32 supp_rates)
469002983fc90c Johannes Berg    2009-02-15  1194  {
2e10d330f8d5f0 Felix Fietkau    2009-12-20  1195  	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
469002983fc90c Johannes Berg    2009-02-15  1196  	struct ieee80211_local *local = sdata->local;
469002983fc90c Johannes Berg    2009-02-15  1197  	struct sta_info *sta;
55de908ab292c0 Johannes Berg    2012-07-26  1198  	struct ieee80211_chanctx_conf *chanctx_conf;
b422c6cd7e93bb Ashok Nagarajan  2013-05-10  1199  	struct ieee80211_supported_band *sband;
74608aca4d82e2 Simon Wunderlich 2013-07-08  1200  	enum nl80211_bss_scan_width scan_width;
55de908ab292c0 Johannes Berg    2012-07-26  1201  	int band;
469002983fc90c Johannes Berg    2009-02-15  1202  
af8cdcd828ad75 Johannes Berg    2009-04-19  1203  	/*
af8cdcd828ad75 Johannes Berg    2009-04-19  1204  	 * XXX: Consider removing the least recently used entry and
af8cdcd828ad75 Johannes Berg    2009-04-19  1205  	 * 	allow new one to be added.
af8cdcd828ad75 Johannes Berg    2009-04-19  1206  	 */
469002983fc90c Johannes Berg    2009-02-15  1207  	if (local->num_sta >= IEEE80211_IBSS_MAX_STA_ENTRIES) {
bdcbd8e0e3ffda Johannes Berg    2012-06-22  1208  		net_info_ratelimited("%s: No room for a new IBSS STA entry %pM\n",
47846c9b0c1080 Johannes Berg    2009-11-25  1209  				    sdata->name, addr);
8bf11d8d081106 Johannes Berg    2011-12-15  1210  		return;
469002983fc90c Johannes Berg    2009-02-15  1211  	}
469002983fc90c Johannes Berg    2009-02-15  1212  
2e10d330f8d5f0 Felix Fietkau    2009-12-20  1213  	if (ifibss->state == IEEE80211_IBSS_MLME_SEARCH)
8bf11d8d081106 Johannes Berg    2011-12-15  1214  		return;
2e10d330f8d5f0 Felix Fietkau    2009-12-20  1215  
b203ca39126bad Joe Perches      2012-05-08  1216  	if (!ether_addr_equal(bssid, sdata->u.ibss.bssid))
8bf11d8d081106 Johannes Berg    2011-12-15  1217  		return;
469002983fc90c Johannes Berg    2009-02-15  1218  
55de908ab292c0 Johannes Berg    2012-07-26  1219  	rcu_read_lock();
d0a9123ef548de Johannes Berg    2022-05-10  1220  	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
55de908ab292c0 Johannes Berg    2012-07-26  1221  	if (WARN_ON_ONCE(!chanctx_conf)) {
55de908ab292c0 Johannes Berg    2012-07-26  1222  		rcu_read_unlock();
55de908ab292c0 Johannes Berg    2012-07-26  1223  		return;
55de908ab292c0 Johannes Berg    2012-07-26  1224  	}
4bf88530be971b Johannes Berg    2012-11-09  1225  	band = chanctx_conf->def.chan->band;
74608aca4d82e2 Simon Wunderlich 2013-07-08  1226  	scan_width = cfg80211_chandef_to_scan_width(&chanctx_conf->def);
55de908ab292c0 Johannes Berg    2012-07-26  1227  	rcu_read_unlock();
55de908ab292c0 Johannes Berg    2012-07-26  1228  
cb71f1d136a635 Johannes Berg    2022-05-31 @1229  	sta = sta_info_alloc(sdata, addr, -1, GFP_ATOMIC);
469002983fc90c Johannes Berg    2009-02-15  1230  	if (!sta)
8bf11d8d081106 Johannes Berg    2011-12-15  1231  		return;
469002983fc90c Johannes Berg    2009-02-15  1232  
469002983fc90c Johannes Berg    2009-02-15  1233  	/* make sure mandatory rates are always added */
b422c6cd7e93bb Ashok Nagarajan  2013-05-10  1234  	sband = local->hw.wiphy->bands[band];
046d2e7c50e308 Sriram R         2022-04-04  1235  	sta->sta.deflink.supp_rates[band] = supp_rates |
74608aca4d82e2 Simon Wunderlich 2013-07-08  1236  			ieee80211_mandatory_rates(sband, scan_width);
469002983fc90c Johannes Berg    2009-02-15  1237  
8bf11d8d081106 Johannes Berg    2011-12-15  1238  	spin_lock(&ifibss->incomplete_lock);
8bf11d8d081106 Johannes Berg    2011-12-15  1239  	list_add(&sta->list, &ifibss->incomplete_stations);
8bf11d8d081106 Johannes Berg    2011-12-15  1240  	spin_unlock(&ifibss->incomplete_lock);
8bf11d8d081106 Johannes Berg    2011-12-15  1241  	ieee80211_queue_work(&local->hw, &sdata->work);
469002983fc90c Johannes Berg    2009-02-15  1242  }
469002983fc90c Johannes Berg    2009-02-15  1243  

:::::: The code at line 1229 was first introduced by commit
:::::: cb71f1d136a635decf43c3b502ee34fb05640fcd wifi: mac80211: add sta link addition/removal

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
