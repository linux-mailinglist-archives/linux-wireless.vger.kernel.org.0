Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F98C6E3859
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjDPMsT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjDPMsR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100A21726
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649294; x=1713185294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYAUStw8CS15+DkO2/LdghtDbje2kcrpEFBPjqWdAQs=;
  b=cDmEzdiAJb4NkqEQTnCX4Wk4KU6Tg7r+BdoNODMM3T0anQeM8lpS9Pdm
   H8rDm8NvyVHyjLNwdW9H91luETcNVUF6uP20mRoR86MtJIvKRTQUTF6+q
   eUV6Hn2gR2fgRn4oP1VX3m8akNFH9jEJljDSbjD5YcJvP+B9ZwCeuIEYN
   f2o7kcbO8XYgzGP4viLftpRq4fj/AHw03zrSgCMLrAgnSOBLEmNOwuCOk
   Jx3pdsvN72sjJPoqZux4+fwgnjgVamDdEkNPqWMnGMqtQo5edSHky4WQf
   dshXftmmeY8GyMud7iODWmajbGUa2Konz3497UPdPwNHjMPDS3GTV5Tpt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520569"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520569"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670440"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670440"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:12 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: track station mask for BAIDs
Date:   Sun, 16 Apr 2023 15:47:34 +0300
Message-Id: <20230416154301.c08523808c34.I719b7bba499648d1495ed3e3a90889d4732ef15d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we have MLO connections, a BAID applies to multiple
firmware stations. Track the station mask instead of the
station ID, getting rid of a few more deflink cases and
preparing for handling link switching for BAIDs.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 34 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 23 +++++++------
 3 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 7a8b4be8dcf2..29a87d1ba343 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -680,7 +680,7 @@ __aligned(roundup_pow_of_two(sizeof(struct _iwl_mvm_reorder_buf_entry)))
 
 /**
  * struct iwl_mvm_baid_data - BA session data
- * @sta_id: station id
+ * @sta_mask: current station mask for the BAID
  * @tid: tid of the session
  * @baid baid of the session
  * @timeout: the timeout set in the addba request
@@ -694,7 +694,7 @@ __aligned(roundup_pow_of_two(sizeof(struct _iwl_mvm_reorder_buf_entry)))
  */
 struct iwl_mvm_baid_data {
 	struct rcu_head rcu_head;
-	u8 sta_id;
+	u32 sta_mask;
 	u8 tid;
 	u8 baid;
 	u16 timeout;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 31e1d0ccdec5..9dbf14fa0ca7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -705,7 +705,7 @@ void iwl_mvm_reorder_timer_expired(struct timer_list *t)
 	if (expired) {
 		struct ieee80211_sta *sta;
 		struct iwl_mvm_sta *mvmsta;
-		u8 sta_id = baid_data->sta_id;
+		u8 sta_id = ffs(baid_data->sta_mask) - 1;
 
 		rcu_read_lock();
 		sta = rcu_dereference(buf->mvm->fw_id_to_mac_id[sta_id]);
@@ -740,6 +740,7 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 	struct ieee80211_sta *sta;
 	struct iwl_mvm_reorder_buffer *reorder_buf;
 	u8 baid = data->baid;
+	u32 sta_id;
 
 	if (WARN_ONCE(baid >= IWL_MAX_BAID, "invalid BAID: %x\n", baid))
 		return;
@@ -750,7 +751,9 @@ static void iwl_mvm_del_ba(struct iwl_mvm *mvm, int queue,
 	if (WARN_ON_ONCE(!ba_data))
 		goto out;
 
-	sta = rcu_dereference(mvm->fw_id_to_mac_id[ba_data->sta_id]);
+	/* pick any STA ID to find the pointer */
+	sta_id = ffs(ba_data->sta_mask) - 1;
+	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
 	if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta)))
 		goto out;
 
@@ -777,6 +780,7 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 	struct ieee80211_sta *sta;
 	struct iwl_mvm_reorder_buffer *reorder_buf;
 	struct iwl_mvm_baid_data *ba_data;
+	u32 sta_id;
 
 	IWL_DEBUG_HT(mvm, "Frame release notification for BAID %u, NSSN %d\n",
 		     baid, nssn);
@@ -794,7 +798,9 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 		goto out;
 	}
 
-	sta = rcu_dereference(mvm->fw_id_to_mac_id[ba_data->sta_id]);
+	/* pick any STA ID to find the pointer */
+	sta_id = ffs(ba_data->sta_mask) - 1;
+	sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
 	if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta)))
 		goto out;
 
@@ -935,7 +941,6 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb_mac_header(skb);
-	struct iwl_mvm_sta *mvm_sta;
 	struct iwl_mvm_baid_data *baid_data;
 	struct iwl_mvm_reorder_buffer *buffer;
 	struct sk_buff *tail;
@@ -947,6 +952,7 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 	u8 sub_frame_idx = desc->amsdu_info &
 			   IWL_RX_MPDU_AMSDU_SUBFRAME_IDX_MASK;
 	struct iwl_mvm_reorder_buf_entry *entries;
+	u32 sta_mask;
 	int index;
 	u16 nssn, sn;
 	u8 baid;
@@ -969,8 +975,6 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		      "Got valid BAID without a valid station assigned\n"))
 		return false;
 
-	mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-
 	/* not a data packet or a bar */
 	if (!ieee80211_is_back_req(hdr->frame_control) &&
 	    (!ieee80211_is_data_qos(hdr->frame_control) ||
@@ -988,11 +992,14 @@ static bool iwl_mvm_reorder(struct iwl_mvm *mvm,
 		return false;
 	}
 
+	rcu_read_lock();
+	sta_mask = iwl_mvm_sta_fw_id_mask(mvm, sta, -1);
+	rcu_read_unlock();
+
 	if (WARN(tid != baid_data->tid ||
-		 mvm_sta->deflink.sta_id != baid_data->sta_id,
-		 "baid 0x%x is mapped to sta:%d tid:%d, but was received for sta:%d tid:%d\n",
-		 baid, baid_data->sta_id, baid_data->tid, mvm_sta->deflink.sta_id,
-		 tid))
+		 !(sta_mask & baid_data->sta_mask),
+		 "baid 0x%x is mapped to sta_mask:0x%x tid:%d, but was received for sta_mask:0x%x tid:%d\n",
+		 baid, baid_data->sta_mask, baid_data->tid, sta_mask, tid))
 		return false;
 
 	nssn = reorder & IWL_RX_MPDU_REORDER_NSSN_MASK;
@@ -2776,9 +2783,10 @@ void iwl_mvm_rx_bar_frame_release(struct iwl_mvm *mvm, struct napi_struct *napi,
 		goto out;
 	}
 
-	if (WARN(tid != baid_data->tid || sta_id != baid_data->sta_id,
-		 "baid 0x%x is mapped to sta:%d tid:%d, but BAR release received for sta:%d tid:%d\n",
-		 baid, baid_data->sta_id, baid_data->tid, sta_id,
+	if (WARN(tid != baid_data->tid || sta_id > IWL_MVM_STATION_COUNT_MAX ||
+		 !(baid_data->sta_mask & BIT(sta_id)),
+		 "baid 0x%x is mapped to sta_mask:0x%x tid:%d, but BAR release received for sta:%d tid:%d\n",
+		 baid, baid_data->sta_mask, baid_data->tid, sta_id,
 		 tid))
 		goto out;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 3e5bed885bd9..d323d119c334 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -251,6 +251,7 @@ static void iwl_mvm_rx_agg_session_expired(struct timer_list *t)
 	struct ieee80211_sta *sta;
 	struct iwl_mvm_sta *mvm_sta;
 	unsigned long timeout;
+	unsigned int sta_id;
 
 	rcu_read_lock();
 
@@ -269,7 +270,8 @@ static void iwl_mvm_rx_agg_session_expired(struct timer_list *t)
 	}
 
 	/* Timer expired */
-	sta = rcu_dereference(ba_data->mvm->fw_id_to_mac_id[ba_data->sta_id]);
+	sta_id = ffs(ba_data->sta_mask) - 1; /* don't care which one */
+	sta = rcu_dereference(ba_data->mvm->fw_id_to_mac_id[sta_id]);
 
 	/*
 	 * sta should be valid unless the following happens:
@@ -2756,10 +2758,11 @@ static void iwl_mvm_init_reorder_buffer(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_fw_baid_op_sta(struct iwl_mvm *mvm,
-				  struct iwl_mvm_sta *mvm_sta,
+				  struct ieee80211_sta *sta,
 				  bool start, int tid, u16 ssn,
 				  u16 buf_size)
 {
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_add_sta_cmd cmd = {
 		.mac_id_n_color = cpu_to_le32(mvm_sta->mac_id_n_color),
 		.sta_id = mvm_sta->deflink.sta_id,
@@ -2804,7 +2807,7 @@ static int iwl_mvm_fw_baid_op_sta(struct iwl_mvm *mvm,
 }
 
 static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
-				  struct iwl_mvm_sta *mvm_sta,
+				  struct ieee80211_sta *sta,
 				  bool start, int tid, u16 ssn,
 				  u16 buf_size, int baid)
 {
@@ -2819,7 +2822,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 
 	if (start) {
 		cmd.alloc.sta_id_mask =
-			cpu_to_le32(BIT(mvm_sta->deflink.sta_id));
+			cpu_to_le32(iwl_mvm_sta_fw_id_mask(mvm, sta, -1));
 		cmd.alloc.tid = tid;
 		cmd.alloc.ssn = cpu_to_le16(ssn);
 		cmd.alloc.win_size = cpu_to_le16(buf_size);
@@ -2829,7 +2832,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 		BUILD_BUG_ON(sizeof(cmd.remove_v1) > sizeof(cmd.remove));
 	} else {
 		cmd.remove.sta_id_mask =
-			cpu_to_le32(BIT(mvm_sta->deflink.sta_id));
+			cpu_to_le32(iwl_mvm_sta_fw_id_mask(mvm, sta, -1));
 		cmd.remove.tid = cpu_to_le32(tid);
 	}
 
@@ -2852,16 +2855,16 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 	return baid;
 }
 
-static int iwl_mvm_fw_baid_op(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvm_sta,
+static int iwl_mvm_fw_baid_op(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			      bool start, int tid, u16 ssn, u16 buf_size,
 			      int baid)
 {
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_BAID_ML_SUPPORT))
-		return iwl_mvm_fw_baid_op_cmd(mvm, mvm_sta, start,
+		return iwl_mvm_fw_baid_op_cmd(mvm, sta, start,
 					      tid, ssn, buf_size, baid);
 
-	return iwl_mvm_fw_baid_op_sta(mvm, mvm_sta, start,
+	return iwl_mvm_fw_baid_op_sta(mvm, sta, start,
 				      tid, ssn, buf_size);
 }
 
@@ -2931,7 +2934,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 
 	/* Don't send command to remove (start=0) BAID during restart */
 	if (start || !test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		baid = iwl_mvm_fw_baid_op(mvm, mvm_sta, start, tid, ssn, buf_size,
+		baid = iwl_mvm_fw_baid_op(mvm, sta, start, tid, ssn, buf_size,
 					  baid);
 
 	if (baid < 0) {
@@ -2953,7 +2956,7 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			    iwl_mvm_rx_agg_session_expired, 0);
 		baid_data->mvm = mvm;
 		baid_data->tid = tid;
-		baid_data->sta_id = mvm_sta->deflink.sta_id;
+		baid_data->sta_mask = iwl_mvm_sta_fw_id_mask(mvm, sta, -1);
 
 		mvm_sta->tid_to_baid[tid] = baid;
 		if (timeout)
-- 
2.38.1

