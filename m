Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029D0526A64
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 21:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353561AbiEMT3V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 15:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383888AbiEMT3N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 15:29:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF20F2A9
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652470151; x=1684006151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jxyF+pUkOhXeP3sURtGIsbWu1ZHHNg6clR3K8RRCTgA=;
  b=YRr/HDrus9K3bTFog+/5eFva6DqxmKxJ7Bh01S15OsGlC7dH4wb3rIP0
   6l05RDj3ajixaCv+6XG6TsmfAOlT2g7OJcw4mjHCaVXuaWJ4bzg1H0zbM
   lnTfw0mT8867ce5LrF3DSy9VluzJ0vZGM51qGNvrDGTv2r606AILC2hfH
   Y1MAQgGIU8opLSc/i8kG2v1fkbfu7tqsplJz27XwirlMutfkpbVw/B8hH
   NvaxAnHKxS++hI+SD7eXDlvn9spsxiZURoMTG4x0VI2crs7/3I8wdQCVp
   Kcy+mzdDzlIUo5ZBrufJy825TLv5fHhRwgWhx4EayfKbA/aI13BNV+izj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="252437737"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="252437737"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 12:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="637409143"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2022 12:29:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npayC-000M3M-SD;
        Fri, 13 May 2022 19:29:00 +0000
Date:   Sat, 14 May 2022 03:28:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 3/3] mac80211: mlme: use local SSID copy
Message-ID: <202205140341.A1zkqlx2-lkp@intel.com>
References: <20220513154805.89b855fd46f3.Ibdacb74eb4f9b21bc473072605df05bfd8bb2d75@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513154805.89b855fd46f3.Ibdacb74eb4f9b21bc473072605df05bfd8bb2d75@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

I love your patch! Yet something to improve:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on wireless/main v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Johannes-Berg/mac80211-mlme-move-in-RSSI-reporting-code/20220513-215204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
config: hexagon-randconfig-r041-20220512 (https://download.01.org/0day-ci/archive/20220514/202205140341.A1zkqlx2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/64db83d0f7472324be9dce953061d4219b420e1c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Johannes-Berg/mac80211-mlme-move-in-RSSI-reporting-code/20220513-215204
        git checkout 64db83d0f7472324be9dce953061d4219b420e1c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mac80211/mlme.c:2645:23: error: no member named 'cfg' in 'struct ieee80211_vif'
                                                 sdata->vif.cfg.ssid,
                                                 ~~~~~~~~~~ ^
   net/mac80211/mlme.c:2646:23: error: no member named 'cfg' in 'struct ieee80211_vif'
                                                 sdata->vif.cfg.ssid_len,
                                                 ~~~~~~~~~~ ^
   2 errors generated.


vim +2645 net/mac80211/mlme.c

  2607	
  2608	static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)
  2609	{
  2610		struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
  2611		u8 *dst = ifmgd->bssid;
  2612		u8 unicast_limit = max(1, max_probe_tries - 3);
  2613		struct sta_info *sta;
  2614	
  2615		/*
  2616		 * Try sending broadcast probe requests for the last three
  2617		 * probe requests after the first ones failed since some
  2618		 * buggy APs only support broadcast probe requests.
  2619		 */
  2620		if (ifmgd->probe_send_count >= unicast_limit)
  2621			dst = NULL;
  2622	
  2623		/*
  2624		 * When the hardware reports an accurate Tx ACK status, it's
  2625		 * better to send a nullfunc frame instead of a probe request,
  2626		 * as it will kick us off the AP quickly if we aren't associated
  2627		 * anymore. The timeout will be reset if the frame is ACKed by
  2628		 * the AP.
  2629		 */
  2630		ifmgd->probe_send_count++;
  2631	
  2632		if (dst) {
  2633			mutex_lock(&sdata->local->sta_mtx);
  2634			sta = sta_info_get(sdata, dst);
  2635			if (!WARN_ON(!sta))
  2636				ieee80211_check_fast_rx(sta);
  2637			mutex_unlock(&sdata->local->sta_mtx);
  2638		}
  2639	
  2640		if (ieee80211_hw_check(&sdata->local->hw, REPORTS_TX_ACK_STATUS)) {
  2641			ifmgd->nullfunc_failed = false;
  2642			ieee80211_send_nullfunc(sdata->local, sdata, false);
  2643		} else {
  2644			ieee80211_mlme_send_probe_req(sdata, sdata->vif.addr, dst,
> 2645						      sdata->vif.cfg.ssid,
  2646						      sdata->vif.cfg.ssid_len,
  2647						      ifmgd->associated->channel);
  2648		}
  2649	
  2650		ifmgd->probe_timeout = jiffies + msecs_to_jiffies(probe_wait_ms);
  2651		run_again(sdata, ifmgd->probe_timeout);
  2652	}
  2653	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
