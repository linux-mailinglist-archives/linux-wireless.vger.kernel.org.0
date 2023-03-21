Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88366C27A5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 02:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjCUB5j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCUB5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 21:57:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE7211C4
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679363856; x=1710899856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HCV+Jpzz/Fd9dCFOhk5Hovmo50YPsn4eR/cUdi+ZVtE=;
  b=NZUQez3tD+qc72+ivrMn/QbVBSNLipb6gVOsUJb43RHWg4Y2dp6rZA9r
   RAu5ZsQ6eC3rf5vqLk3Cij8hdxZdonxNShzdWT6p9X2fNn1yHc2fDzzge
   bsiqSGXlQ86sZlWnlOhULaXKM6gCx0wS+8/SOI1O7mlruCQXaiJIr7i8R
   PPmBdgzt3xL8dMw1xmsOk6hCbqsr+4sGVv9Sl85iEIbm3Pd1NJiUXmAdD
   7fOZhHilPoJUVAzwIFr0TcvLsuZRfC+5GUqZ9zOLsgjmehv/2N91585Jf
   ReXVvrOBBaHqCFnBrT7xnyyJzVc53+/sJv3SVpiXjDgc/KKlP23V8B9Ch
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="401398799"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="401398799"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 18:57:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="927209009"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="927209009"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2023 18:57:11 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1peRFK-000BUC-0e;
        Tue, 21 Mar 2023 01:57:06 +0000
Date:   Tue, 21 Mar 2023 09:56:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: Re: [PATCH v2 4/4] wifi: ath11k: add AP power save support
Message-ID: <202303210910.Ag8f94jv-lkp@intel.com>
References: <20230320164334.3325886-5-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320164334.3325886-5-quic_mkenna@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Maharaja,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wireless-next/main]
[also build test WARNING on kvalo-ath/ath-next next-20230320]
[cannot apply to wireless/main linus/master v6.3-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maharaja-Kennadyrajan/wifi-nl80211-rename-NL80211_CMD_SET_BEACON-to-NL80211_CMD_UDPATE_AP/20230321-005501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20230320164334.3325886-5-quic_mkenna%40quicinc.com
patch subject: [PATCH v2 4/4] wifi: ath11k: add AP power save support
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20230321/202303210910.Ag8f94jv-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/289c49facf48da5a221a3c8072f97c4641eca9f0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Maharaja-Kennadyrajan/wifi-nl80211-rename-NL80211_CMD_SET_BEACON-to-NL80211_CMD_UDPATE_AP/20230321-005501
        git checkout 289c49facf48da5a221a3c8072f97c4641eca9f0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 olddefconfig
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303210910.Ag8f94jv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/mac.c:3218:6: warning: no previous prototype for 'ath11k_mac_ap_ps_recalc' [-Wmissing-prototypes]
    3218 | void ath11k_mac_ap_ps_recalc(struct ath11k *ar)
         |      ^~~~~~~~~~~~~~~~~~~~~~~


vim +/ath11k_mac_ap_ps_recalc +3218 drivers/net/wireless/ath/ath11k/mac.c

  3217	
> 3218	void ath11k_mac_ap_ps_recalc(struct ath11k *ar)
  3219	{
  3220		struct ath11k_vif *arvif;
  3221		enum ath11k_ap_ps_state state = ATH11K_AP_PS_STATE_OFF;
  3222		int ret;
  3223		bool allow_ap_ps = true;
  3224	
  3225		lockdep_assert_held(&ar->conf_mutex);
  3226	
  3227		list_for_each_entry(arvif, &ar->arvifs, list) {
  3228			if (arvif->vdev_type == WMI_VDEV_TYPE_STA ||
  3229			    !arvif->vif_ap_ps_enabled) {
  3230				allow_ap_ps = false;
  3231				break;
  3232			}
  3233		}
  3234	
  3235		if (!allow_ap_ps)
  3236			ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "ap ps is not allowed\n");
  3237	
  3238		if (allow_ap_ps && !ar->num_stations && ar->ap_ps_enabled)
  3239			state = ATH11K_AP_PS_STATE_ON;
  3240	
  3241		if (ar->ap_ps_state == state)
  3242			return;
  3243	
  3244		ret = ath11k_wmi_pdev_ap_ps_cmd_send(ar, ar->pdev->pdev_id, state);
  3245		if (ret) {
  3246			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
  3247				   "failed to send ap ps command pdev_id %u state %u\n",
  3248				   ar->pdev->pdev_id, state);
  3249			return;
  3250		}
  3251	
  3252		ar->ap_ps_state = state;
  3253	}
  3254	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
