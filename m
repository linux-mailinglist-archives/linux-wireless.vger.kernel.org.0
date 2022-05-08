Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A251EFD4
	for <lists+linux-wireless@lfdr.de>; Sun,  8 May 2022 21:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiEHTRX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 May 2022 15:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242828AbiEHSDU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 May 2022 14:03:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925FC5FBC
        for <linux-wireless@vger.kernel.org>; Sun,  8 May 2022 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652032768; x=1683568768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=68Pn7zke99uMVNz1DzjSNpGV1gXJ8bJC1hn2i4CtgcM=;
  b=Wfblr4l10WCUxP1wAvjbbs5tZk2hWw5q5qcK4n/D6x5yPjIoZ6JH3HT7
   hDgpqZTNg+7ESYeegBNTZsHS/cH3GN/y/Hu47q6lP+d3atRGZsOyhdwzx
   W3i5vFJqKjeOOErKOcrwjP0Et0Fj7OAcevgfHuvMRewmPUbcg7Tpgk/rB
   mUGe6xpaiDO0wRTk4NBZ58irg3QVw4QyeVdbhgG87VEAHXVFMUciHs4OU
   lcf61GlwbuvDR3ZE3+gBRmtYv9k2IKAUD0UU4E5jmRy1rcF2Awcd5/F2C
   FuVGNPIHtiTCtYlnrRQKuA1OXoHlDWxQ4N7kTToE5JCQfKa4RvpleqPSw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="248767713"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="248767713"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 10:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="550665748"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2022 10:59:25 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnlBl-000Ffa-0y;
        Sun, 08 May 2022 17:59:25 +0000
Date:   Mon, 9 May 2022 01:58:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonas Jelonek <jelonek.jonas@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kbuild-all@lists.01.org, kvalo@kernel.org, nbd@nbd.name,
        johannes@sipsolutions.net, thomas.huehn@hs-nordhausen.de,
        Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: Re: [PATCH v3 1/2] mac80211: extend current rate control tx status
 API
Message-ID: <202205090141.egLK4ZdI-lkp@intel.com>
References: <20220508151056.2431775-2-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508151056.2431775-2-jelonek.jonas@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jonas,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on wireless/main]
[also build test ERROR on v5.18-rc5]
[cannot apply to wireless-next/main next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonas-Jelonek/mac80211-extend-current-rate-control-tx-status-API/20220508-231356
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220509/202205090141.egLK4ZdI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/4241dcd99dd1ea39739668850806abcd249f8535
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jonas-Jelonek/mac80211-extend-current-rate-control-tx-status-API/20220508-231356
        git checkout 4241dcd99dd1ea39739668850806abcd249f8535
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/wireless/ath/ath11k/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/wireless/ath/ath11k/dp_tx.c: In function 'ath11k_dp_tx_complete_msdu':
>> drivers/net/wireless/ath/ath11k/dp_tx.c:606:16: error: 'struct ieee80211_tx_status' has no member named 'rate'; did you mean 'rates'?
     606 |         status.rate = &rate;
         |                ^~~~
         |                rates


vim +606 drivers/net/wireless/ath/ath11k/dp_tx.c

1b8bb94c0612cf Wen Gong               2021-12-20  517  
d5c65159f28953 Kalle Valo             2019-11-23  518  static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
d5c65159f28953 Kalle Valo             2019-11-23  519  				       struct sk_buff *msdu,
d5c65159f28953 Kalle Valo             2019-11-23  520  				       struct hal_tx_status *ts)
d5c65159f28953 Kalle Valo             2019-11-23  521  {
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  522  	struct ieee80211_tx_status status = { 0 };
d5c65159f28953 Kalle Valo             2019-11-23  523  	struct ath11k_base *ab = ar->ab;
d5c65159f28953 Kalle Valo             2019-11-23  524  	struct ieee80211_tx_info *info;
d5c65159f28953 Kalle Valo             2019-11-23  525  	struct ath11k_skb_cb *skb_cb;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  526  	struct ath11k_peer *peer;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  527  	struct ath11k_sta *arsta;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  528  	struct rate_info rate;
d5c65159f28953 Kalle Valo             2019-11-23  529  
d5c65159f28953 Kalle Valo             2019-11-23  530  	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
d5c65159f28953 Kalle Valo             2019-11-23  531  		/* Must not happen */
d5c65159f28953 Kalle Valo             2019-11-23  532  		return;
d5c65159f28953 Kalle Valo             2019-11-23  533  	}
d5c65159f28953 Kalle Valo             2019-11-23  534  
d5c65159f28953 Kalle Valo             2019-11-23  535  	skb_cb = ATH11K_SKB_CB(msdu);
d5c65159f28953 Kalle Valo             2019-11-23  536  
d5c65159f28953 Kalle Valo             2019-11-23  537  	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
d5c65159f28953 Kalle Valo             2019-11-23  538  
bcef57ea400cc2 P Praneesh             2021-11-12  539  	if (unlikely(!rcu_access_pointer(ab->pdevs_active[ar->pdev_idx]))) {
d5c65159f28953 Kalle Valo             2019-11-23  540  		dev_kfree_skb_any(msdu);
bcef57ea400cc2 P Praneesh             2021-11-12  541  		return;
d5c65159f28953 Kalle Valo             2019-11-23  542  	}
d5c65159f28953 Kalle Valo             2019-11-23  543  
bcef57ea400cc2 P Praneesh             2021-11-12  544  	if (unlikely(!skb_cb->vif)) {
d5c65159f28953 Kalle Valo             2019-11-23  545  		dev_kfree_skb_any(msdu);
bcef57ea400cc2 P Praneesh             2021-11-12  546  		return;
d5c65159f28953 Kalle Valo             2019-11-23  547  	}
d5c65159f28953 Kalle Valo             2019-11-23  548  
d5c65159f28953 Kalle Valo             2019-11-23  549  	info = IEEE80211_SKB_CB(msdu);
d5c65159f28953 Kalle Valo             2019-11-23  550  	memset(&info->status, 0, sizeof(info->status));
d5c65159f28953 Kalle Valo             2019-11-23  551  
d5c65159f28953 Kalle Valo             2019-11-23  552  	/* skip tx rate update from ieee80211_status*/
d5c65159f28953 Kalle Valo             2019-11-23  553  	info->status.rates[0].idx = -1;
d5c65159f28953 Kalle Valo             2019-11-23  554  
d5c65159f28953 Kalle Valo             2019-11-23  555  	if (ts->status == HAL_WBM_TQM_REL_REASON_FRAME_ACKED &&
d5c65159f28953 Kalle Valo             2019-11-23  556  	    !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
d5c65159f28953 Kalle Valo             2019-11-23  557  		info->flags |= IEEE80211_TX_STAT_ACK;
d5c65159f28953 Kalle Valo             2019-11-23  558  		info->status.ack_signal = ATH11K_DEFAULT_NOISE_FLOOR +
d5c65159f28953 Kalle Valo             2019-11-23  559  					  ts->ack_rssi;
ea5907db2a9ccf Avraham Stern          2022-02-02  560  		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
d5c65159f28953 Kalle Valo             2019-11-23  561  	}
d5c65159f28953 Kalle Valo             2019-11-23  562  
d5c65159f28953 Kalle Valo             2019-11-23  563  	if (ts->status == HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX &&
d5c65159f28953 Kalle Valo             2019-11-23  564  	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
d5c65159f28953 Kalle Valo             2019-11-23  565  		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
d5c65159f28953 Kalle Valo             2019-11-23  566  
1b8bb94c0612cf Wen Gong               2021-12-20  567  	if (unlikely(ath11k_debugfs_is_extd_tx_stats_enabled(ar)) ||
1b8bb94c0612cf Wen Gong               2021-12-20  568  	    ab->hw_params.single_pdev_only) {
d5c65159f28953 Kalle Valo             2019-11-23  569  		if (ts->flags & HAL_TX_STATUS_FLAGS_FIRST_MSDU) {
d5c65159f28953 Kalle Valo             2019-11-23  570  			if (ar->last_ppdu_id == 0) {
d5c65159f28953 Kalle Valo             2019-11-23  571  				ar->last_ppdu_id = ts->ppdu_id;
d5c65159f28953 Kalle Valo             2019-11-23  572  			} else if (ar->last_ppdu_id == ts->ppdu_id ||
d5c65159f28953 Kalle Valo             2019-11-23  573  				   ar->cached_ppdu_id == ar->last_ppdu_id) {
d5c65159f28953 Kalle Valo             2019-11-23  574  				ar->cached_ppdu_id = ar->last_ppdu_id;
d5c65159f28953 Kalle Valo             2019-11-23  575  				ar->cached_stats.is_ampdu = true;
1b8bb94c0612cf Wen Gong               2021-12-20  576  				ath11k_dp_tx_update_txcompl(ar, ts);
d5c65159f28953 Kalle Valo             2019-11-23  577  				memset(&ar->cached_stats, 0,
d5c65159f28953 Kalle Valo             2019-11-23  578  				       sizeof(struct ath11k_per_peer_tx_stats));
d5c65159f28953 Kalle Valo             2019-11-23  579  			} else {
d5c65159f28953 Kalle Valo             2019-11-23  580  				ar->cached_stats.is_ampdu = false;
1b8bb94c0612cf Wen Gong               2021-12-20  581  				ath11k_dp_tx_update_txcompl(ar, ts);
d5c65159f28953 Kalle Valo             2019-11-23  582  				memset(&ar->cached_stats, 0,
d5c65159f28953 Kalle Valo             2019-11-23  583  				       sizeof(struct ath11k_per_peer_tx_stats));
d5c65159f28953 Kalle Valo             2019-11-23  584  			}
d5c65159f28953 Kalle Valo             2019-11-23  585  			ar->last_ppdu_id = ts->ppdu_id;
d5c65159f28953 Kalle Valo             2019-11-23  586  		}
d5c65159f28953 Kalle Valo             2019-11-23  587  
d5c65159f28953 Kalle Valo             2019-11-23  588  		ath11k_dp_tx_cache_peer_stats(ar, msdu, ts);
d5c65159f28953 Kalle Valo             2019-11-23  589  	}
d5c65159f28953 Kalle Valo             2019-11-23  590  
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  591  	spin_lock_bh(&ab->base_lock);
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  592  	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  593  	if (!peer || !peer->sta) {
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  594  		ath11k_dbg(ab, ATH11K_DBG_DATA,
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  595  			   "dp_tx: failed to find the peer with peer_id %d\n",
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  596  			    ts->peer_id);
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  597  		spin_unlock_bh(&ab->base_lock);
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  598  		dev_kfree_skb_any(msdu);
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  599  		return;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  600  	}
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  601  	arsta = (struct ath11k_sta *)peer->sta->drv_priv;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  602  	status.sta = peer->sta;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  603  	status.skb = msdu;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  604  	status.info = info;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  605  	rate = arsta->last_txrate;
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16 @606  	status.rate = &rate;
d5c65159f28953 Kalle Valo             2019-11-23  607  
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  608  	spin_unlock_bh(&ab->base_lock);
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  609  
94739d45c388c5 Pradeep Kumar Chitrapu 2022-02-16  610  	ieee80211_tx_status_ext(ar->hw, &status);
d5c65159f28953 Kalle Valo             2019-11-23  611  }
d5c65159f28953 Kalle Valo             2019-11-23  612  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
