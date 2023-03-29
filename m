Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF126CD291
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjC2HHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjC2HHk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:07:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844523C11
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073639; x=1711609639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OWts48a1O+Eif3t3a5EZyB2TTWRZ1U2ncPDJWGPqUeg=;
  b=GHVJFsn7awi4LtpF1lGsWLtD9PBqA4kBDbujrdrKb//sT9lu1UUWIJXf
   KmbQV+sybcsZmDjRaR+Z1Ej8KRZAoie0knaQylDl0i4l+FcUI+beyBWpX
   6XDDucOpZAE539xlQvVSKDOQF0PiRFZORFuX8PPFnnzLJoPuE2uGrsfCH
   9Ue4kF/wMsOPj9UVuU54D4k3vgaukQAuRmcOI/GnQgwRvLhyKWtKOheT6
   YcE6NZ/he/SRLz0MxR3LDze71hC4MEdIpbY+wBpKnwig9ykE1TmZwYego
   vzb6NaEBXYH3ueZqwlS3dQXCKPUMvWRWo44lU8cw+AAZ8s1hOMHSILWZM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450831"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450831"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111324"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111324"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:22 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/34] wifi: iwlwifi: mvm: rxmq: report link ID to mac80211
Date:   Wed, 29 Mar 2023 10:05:21 +0300
Message-Id: <20230329100039.c7dd3ec18077.I12ef9eb4a5b8b5c2b9d6bcaa1fda73b59eba39d8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add a fw_id_to_link_sta array in mvm to track the link
STA for each firmware station ID, and then use that to
report the link a frame was received on (since we know
the station ID from firmware).

Notably, this fixes beacon tracking for the correct link
since mac80211 now queues and processes those on the one
link identified by the link ID only.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  8 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  4 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |  8 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 28 ++++++++++++++-----
 5 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d302d98b7631..7fe733dcc748 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1570,8 +1570,10 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	}
 
 	/* init the fw <-> mac80211 STA mapping */
-	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++)
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[i], NULL);
+		RCU_INIT_POINTER(mvm->fw_id_to_link_sta[i], NULL);
+	}
 
 	memset(&mvm->fw_link_ids_map, 0, sizeof(mvm->fw_link_ids_map));
 
@@ -1757,8 +1759,10 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm)
 		goto error;
 
 	/* init the fw <-> mac80211 STA mapping */
-	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++)
+	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
 		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[i], NULL);
+		RCU_INIT_POINTER(mvm->fw_id_to_link_sta[i], NULL);
+	}
 
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, ADD_STA, 0) < 12) {
 		/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 4c8ab1db1f19..568f0eaeb0fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3319,9 +3319,11 @@ void iwl_mvm_sta_pre_rcu_remove(struct ieee80211_hw *hw,
 		link_sta = rcu_dereference_protected(mvm_sta->link[link_id],
 						     lockdep_is_held(&mvm->mutex));
 		sta_id = link_sta->sta_id;
-		if (sta == rcu_access_pointer(mvm->fw_id_to_mac_id[sta_id]))
+		if (sta == rcu_access_pointer(mvm->fw_id_to_mac_id[sta_id])) {
 			rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id],
 					   ERR_PTR(-ENOENT));
+			RCU_INIT_POINTER(mvm->fw_id_to_link_sta[sta_id], NULL);
+		}
 	}
 	mutex_unlock(&mvm->mutex);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 9be6d858411d..a713b8a10781 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -472,6 +472,7 @@ static void iwl_mvm_mld_sta_rm_all_sta_links(struct iwl_mvm *mvm,
 			continue;
 
 		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[link->sta_id], NULL);
+		RCU_INIT_POINTER(mvm->fw_id_to_link_sta[link->sta_id], NULL);
 		RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
 
 		if (link != &mvm_sta->deflink)
@@ -485,6 +486,7 @@ static void iwl_mvm_mld_free_sta_link(struct iwl_mvm *mvm,
 				      unsigned int link_id)
 {
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[mvm_sta_link->sta_id], NULL);
+	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[mvm_sta_link->sta_id], NULL);
 	RCU_INIT_POINTER(mvm_sta->link[link_id], NULL);
 
 	if (mvm_sta_link != &mvm_sta->deflink)
@@ -496,6 +498,8 @@ static int iwl_mvm_mld_alloc_sta_link(struct iwl_mvm *mvm,
 				      struct ieee80211_sta *sta,
 				      unsigned int link_id)
 {
+	struct ieee80211_link_sta *link_sta =
+		rcu_dereference_protected(sta->link[link_id], 1);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_link_sta *link;
 	u32 sta_id = iwl_mvm_find_free_sta_id(mvm,
@@ -515,6 +519,8 @@ static int iwl_mvm_mld_alloc_sta_link(struct iwl_mvm *mvm,
 	link->sta_id = sta_id;
 	rcu_assign_pointer(mvm_sta->link[link_id], link);
 	rcu_assign_pointer(mvm->fw_id_to_mac_id[link->sta_id], sta);
+	rcu_assign_pointer(mvm->fw_id_to_link_sta[link->sta_id],
+			   link_sta);
 
 	return 0;
 }
@@ -604,6 +610,7 @@ static int iwl_mvm_alloc_sta_after_restart(struct iwl_mvm *mvm,
 			return ret;
 
 		rcu_assign_pointer(mvm->fw_id_to_mac_id[sta_id], sta);
+		rcu_assign_pointer(mvm->fw_id_to_link_sta[sta_id], link_sta);
 		iwl_mvm_realloc_queues_after_restart(mvm, sta);
 
 		/* since we need only one station, no need to continue */
@@ -800,6 +807,7 @@ int iwl_mvm_mld_rm_sta_id(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	lockdep_assert_held(&mvm->mutex);
 
 	RCU_INIT_POINTER(mvm->fw_id_to_mac_id[sta_id], NULL);
+	RCU_INIT_POINTER(mvm->fw_id_to_link_sta[sta_id], NULL);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 6421edd53404..a7a7018edd2b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -905,6 +905,7 @@ struct iwl_mvm {
 	/* data related to data path */
 	struct iwl_rx_phy_info last_phy_info;
 	struct ieee80211_sta __rcu *fw_id_to_mac_id[IWL_MVM_STATION_COUNT_MAX];
+	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_MVM_STATION_COUNT_MAX];
 	unsigned long fw_link_ids_map;
 	u8 rx_ba_sessions;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index b160ae137c4a..5d803e537b00 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -253,12 +253,22 @@ static void iwl_mvm_add_rtap_sniffer_config(struct iwl_mvm *mvm,
 static void iwl_mvm_pass_packet_to_mac80211(struct iwl_mvm *mvm,
 					    struct napi_struct *napi,
 					    struct sk_buff *skb, int queue,
-					    struct ieee80211_sta *sta)
+					    struct ieee80211_sta *sta,
+					    struct ieee80211_link_sta *link_sta)
 {
-	if (iwl_mvm_check_pn(mvm, skb, queue, sta))
+	if (unlikely(iwl_mvm_check_pn(mvm, skb, queue, sta))) {
 		kfree_skb(skb);
-	else
-		ieee80211_rx_napi(mvm->hw, sta, skb, napi);
+		return;
+	}
+
+	if (sta && sta->valid_links && link_sta) {
+		struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
+
+		rx_status->link_valid = 1;
+		rx_status->link_id = link_sta->link_id;
+	}
+
+	ieee80211_rx_napi(mvm->hw, sta, skb, napi);
 }
 
 static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
@@ -631,7 +641,7 @@ static void iwl_mvm_release_frames(struct iwl_mvm *mvm,
 		while ((skb = __skb_dequeue(skb_list))) {
 			iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb,
 							reorder_buf->queue,
-							sta);
+							sta, NULL /* FIXME */);
 			reorder_buf->num_stored--;
 		}
 	}
@@ -2298,6 +2308,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	u32 len;
 	u32 pkt_len = iwl_rx_packet_payload_len(pkt);
 	struct ieee80211_sta *sta = NULL;
+	struct ieee80211_link_sta *link_sta = NULL;
 	struct sk_buff *skb;
 	u8 crypt_len = 0;
 	size_t desc_size;
@@ -2454,6 +2465,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			sta = rcu_dereference(mvm->fw_id_to_mac_id[id]);
 			if (IS_ERR(sta))
 				sta = NULL;
+			link_sta = rcu_dereference(mvm->fw_id_to_link_sta[id]);
 		}
 	} else if (!is_multicast_ether_addr(hdr->addr2)) {
 		/*
@@ -2588,8 +2600,10 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	if (!iwl_mvm_reorder(mvm, napi, queue, sta, skb, desc) &&
-	    (likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2))))
-		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue, sta);
+	    likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr2)))
+		iwl_mvm_pass_packet_to_mac80211(mvm, napi, skb, queue, sta,
+						link_sta);
+
 out:
 	rcu_read_unlock();
 }
-- 
2.38.1

