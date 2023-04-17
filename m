Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8AF6E42CE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDQImU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDQImS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4F1A8
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720935; x=1713256935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1iCPaSiYBJjBG0hTOTEESPQJ7d1ZN8XlC3DON4WkBY8=;
  b=d2rvMkJl+VdwO+R+kLAxoezPfwBHZWoUthKuticVGTafq32DfAot648r
   9QftQBhGntsC8orAgDO2CHjtUDxBoc54F8Z6eZorl2QBHDeVlWTAvHsa7
   z4Hy9f2h2q2PxpsdjNcRJhQfym6SIzgLpdt1dwScqP0IpVomPK+dIZ/qC
   xT16cm+MYTFbyKgyUUsqiSVUYPDoa5mPnpHMUNuN3/M6ylF3pxgZoaZzS
   DlCwqZDZTvkCb7f1cT7+ypbMoYgoyqt5O1EjQnyRlMj0wQ3wAzbjMP6T5
   Tsde/ZRlo4OGn/tW0bDzUvHBNrT11X/tYtkPJRYJnbMRsX5El7Qt991oJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634427"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634427"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173884"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173884"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:42:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: fix iwl_mvm_max_amsdu_size() for MLO
Date:   Mon, 17 Apr 2023 11:41:30 +0300
Message-Id: <20230417113648.3588afc85d79.I11592893bbc191b9548518b8bd782de568a9f848@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For MLO, we cannot use vif->bss_conf.chandef.chan->band, since
that will lead to a NULL-ptr dereference as bss_conf isn't used.
However, in case of real MLO, we also need to take both LMACs
into account if they exist, since the station might be active
on both LMACs at the same time.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 37 +++++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 09787b8a1c4c..10d7178f1071 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -804,10 +804,11 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 				    struct ieee80211_sta *sta, unsigned int tid)
 {
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
-	enum nl80211_band band = mvmsta->vif->bss_conf.chandef.chan->band;
 	u8 ac = tid_to_mac80211_ac[tid];
+	enum nl80211_band band;
 	unsigned int txf;
-	int lmac = iwl_mvm_get_lmac_id(mvm->fw, band);
+	unsigned int val;
+	int lmac;
 
 	/* For HE redirect to trigger based fifos */
 	if (sta->deflink.he_cap.has_he && !WARN_ON(!iwl_mvm_has_new_tx_api(mvm)))
@@ -821,7 +822,37 @@ unsigned int iwl_mvm_max_amsdu_size(struct iwl_mvm *mvm,
 	 * We also want to have the start of the next packet inside the
 	 * fifo to be able to send bursts.
 	 */
-	return min_t(unsigned int, mvmsta->max_amsdu_len,
+	val = mvmsta->max_amsdu_len;
+
+	if (hweight16(sta->valid_links) <= 1) {
+		if (sta->valid_links) {
+			struct ieee80211_bss_conf *link_conf;
+			unsigned int link = ffs(sta->valid_links) - 1;
+
+			rcu_read_lock();
+			link_conf = rcu_dereference(mvmsta->vif->link_conf[link]);
+			if (WARN_ON(!link_conf))
+				band = NL80211_BAND_2GHZ;
+			else
+				band = link_conf->chandef.chan->band;
+			rcu_read_unlock();
+		} else {
+			band = mvmsta->vif->bss_conf.chandef.chan->band;
+		}
+
+		lmac = iwl_mvm_get_lmac_id(mvm->fw, band);
+	} else if (fw_has_capa(&mvm->fw->ucode_capa,
+			       IWL_UCODE_TLV_CAPA_CDB_SUPPORT)) {
+		/* for real MLO restrict to both LMACs if they exist */
+		lmac = IWL_LMAC_5G_INDEX;
+		val = min_t(unsigned int, val,
+			    mvm->fwrt.smem_cfg.lmac[lmac].txfifo_size[txf] - 256);
+		lmac = IWL_LMAC_24G_INDEX;
+	} else {
+		lmac = IWL_LMAC_24G_INDEX;
+	}
+
+	return min_t(unsigned int, val,
 		     mvm->fwrt.smem_cfg.lmac[lmac].txfifo_size[txf] - 256);
 }
 
-- 
2.38.1

