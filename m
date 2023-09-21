Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870B97A9D97
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjIUTmC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjIUTly (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:41:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0710A79632
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318631; x=1726854631;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lVjSVMzokfy4Z0H2/AgPQ1pwV1s1E6fngimxvFhqzWs=;
  b=DJbyDIRbpUjEvvkmmI6Ky9IwMKbL+NgLzDPAgdNxjSEZA1JHx9O0bJ69
   rzcPVyiW48SUkF0sEgqqWicCLAaAazhD41bOlKbPDRJkQr+IkcNTcE9OH
   k1erUKqN4KixMFvBE7CgxmxBvAyf13ZP7UBGTjRAXFYDUGpeg95Sn26vR
   XpZcqpIIl7MdMwIfTrPvEJIiCqapnhHmAPTfgtR9OwdllFk6B/IkeYe24
   jdBHYvEv+KAQn69HP5bXIP5uIUE1gb4W510Fsf40Rwt6wPQhDeRYtcD1k
   FFO6S30JYlD23/jziqK7XMIAUGftbLbEmWMrmWm81GUePX+3+wSYNkZ0z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384305355"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="384305355"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740545563"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="740545563"
Received: from rchuwer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.229.163])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 01:58:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/12] wifi: iwlwifi: mvm: add support for new wowlan_info_notif
Date:   Thu, 21 Sep 2023 11:58:04 +0300
Message-Id: <20230921110726.4ebcd244f436.Ib507573d50fa0ac666d09ab71f5241ccbcd7cd00@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230921085810.693048-1-gregory.greenman@intel.com>
References: <20230921085810.693048-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

This new version of wolan_info_notif supports the handling
of bigtk during d3, this patch holds parsing of the new
notif version, adding new keys and updating ipn of
existing keys during the resume flow.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  46 ++++-
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 165 +++++++++++++++---
 3 files changed, 184 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 72d461c47323..ea99d41040d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -397,6 +397,8 @@ struct iwl_wowlan_config_cmd {
 #define WOWLAN_GTK_KEYS_NUM     2
 #define WOWLAN_IGTK_KEYS_NUM	2
 #define WOWLAN_IGTK_MIN_INDEX	4
+#define WOWLAN_BIGTK_KEYS_NUM	2
+#define WOWLAN_BIGTK_MIN_INDEX	6
 
 /*
  * WOWLAN_TSC_RSC_PARAMS
@@ -621,9 +623,10 @@ struct iwl_wowlan_gtk_status_v3 {
  * @ipn: the IGTK packet number (replay counter)
  * @key_len: IGTK length, if set to 0, the key is not available
  * @key_flags: information about the key:
- *	bits[0]:    key index assigned by the AP (0: index 4, 1: index 5)
- *	bits[1:5]:  IGTK index of the key in the internal DB
- *	bit[6]:     Set iff this is the currently used IGTK
+ *	bits[0]: key index assigned by the AP (0: index 4, 1: index 5)
+ *	(0: index 6, 1: index 7 with bigtk)
+ *	bits[1:5]: IGTK index of the key in the internal DB
+ *	bit[6]: Set iff this is the currently used IGTK
  */
 struct iwl_wowlan_igtk_status {
 	u8 key[WOWLAN_KEY_MAX_SIZE];
@@ -807,10 +810,44 @@ struct iwl_wowlan_info_notif_v1 {
 	u8 reserved2[2];
 } __packed; /* WOWLAN_INFO_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_wowlan_info_notif_v2 - WoWLAN information notification
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched patterns
+ * @reserved1: reserved
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @transmitted_ndps: number of transmitted neighbor discovery packets
+ * @received_beacons: number of received beacons
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *	in suspend state
+ * @station_id: station id
+ * @reserved2: reserved
+ */
+struct iwl_wowlan_info_notif_v2 {
+	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 reserved1;
+	__le16 qos_seq_ctr[8];
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	__le32 transmitted_ndps;
+	__le32 received_beacons;
+	u8 tid_tear_down;
+	u8 station_id;
+	u8 reserved2[2];
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_2 */
+
 /**
  * struct iwl_wowlan_info_notif - WoWLAN information notification
  * @gtk: GTK data
  * @igtk: IGTK data
+ * @bigtk: BIGTK data
  * @replay_ctr: GTK rekey replay counter
  * @pattern_number: number of the matched patterns
  * @reserved1: reserved
@@ -827,6 +864,7 @@ struct iwl_wowlan_info_notif_v1 {
 struct iwl_wowlan_info_notif {
 	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status bigtk[WOWLAN_BIGTK_KEYS_NUM];
 	__le64 replay_ctr;
 	__le16 pattern_number;
 	__le16 reserved1;
@@ -838,7 +876,7 @@ struct iwl_wowlan_info_notif {
 	u8 tid_tear_down;
 	u8 station_id;
 	u8 reserved2[2];
-} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_2 */
+} __packed; /* WOWLAN_INFO_NTFY_API_S_VER_3 */
 
 /**
  * struct iwl_wowlan_wake_pkt_notif - WoWLAN wake packet notification
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
index 898bf351f6e4..2d2b9c8c36ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/offload.h
@@ -3,7 +3,7 @@
  * Copyright (C) 2012-2014 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2021-2022 Intel Corporation
+ * Copyright (C) 2021-2023 Intel Corporation
  */
 #ifndef __iwl_fw_api_offload_h__
 #define __iwl_fw_api_offload_h__
@@ -18,7 +18,9 @@ enum iwl_prot_offload_subcmd_ids {
 	WOWLAN_WAKE_PKT_NOTIFICATION = 0xFC,
 
 	/**
-	 * @WOWLAN_INFO_NOTIFICATION: Notification in &struct iwl_wowlan_info_notif
+	 * @WOWLAN_INFO_NOTIFICATION: Notification in
+	 * &struct iwl_wowlan_info_notif_v1, &struct iwl_wowlan_info_notif_v2,
+	 * or iwl_wowlan_info_notif
 	 */
 	WOWLAN_INFO_NOTIFICATION = 0xFD,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index f6488b4bbe68..ffb1fdd7ee32 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1438,6 +1438,7 @@ struct iwl_wowlan_status_data {
 	} ptk;
 
 	struct iwl_multicast_key_data igtk;
+	struct iwl_multicast_key_data bigtk[WOWLAN_BIGTK_KEYS_NUM];
 
 	u8 *wake_packet;
 };
@@ -1781,8 +1782,8 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 struct iwl_mvm_d3_gtk_iter_data {
 	struct iwl_mvm *mvm;
 	struct iwl_wowlan_status_data *status;
-	u32 gtk_cipher, igtk_cipher;
-	bool unhandled_cipher, igtk_support;
+	u32 gtk_cipher, igtk_cipher, bigtk_cipher;
+	bool unhandled_cipher, igtk_support, bigtk_support;
 	int num_keys;
 };
 
@@ -1817,6 +1818,9 @@ static void iwl_mvm_d3_find_last_keys(struct ieee80211_hw *hw,
 		if (data->igtk_support &&
 		    (key->keyidx == 4 || key->keyidx == 5)) {
 			data->igtk_cipher = key->cipher;
+		} else if (data->bigtk_support &&
+			   (key->keyidx == 6 || key->keyidx == 7)) {
+			data->bigtk_cipher = key->cipher;
 		} else {
 			data->unhandled_cipher = true;
 			return;
@@ -1848,6 +1852,24 @@ iwl_mvm_d3_set_igtk_bigtk_ipn(const struct iwl_multicast_key_data *key,
 	}
 }
 
+static void
+iwl_mvm_d3_update_igtk_bigtk(struct iwl_wowlan_status_data *status,
+			     struct ieee80211_key_conf *key,
+			     struct iwl_multicast_key_data *key_data)
+{
+	if (status->num_of_gtk_rekeys && key_data->len) {
+		/* remove rekeyed key */
+		ieee80211_remove_key(key);
+	} else {
+		struct ieee80211_key_seq seq;
+
+		iwl_mvm_d3_set_igtk_bigtk_ipn(key_data,
+					      &seq,
+					      key->cipher);
+		ieee80211_set_key_rx_seq(key, 0, &seq);
+	}
+}
+
 static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -1900,17 +1922,14 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 		if (key->keyidx == 4 || key->keyidx == 5) {
-			/* remove rekeyed key */
-			if (status->num_of_gtk_rekeys) {
-				ieee80211_remove_key(key);
-			} else {
-				struct ieee80211_key_seq seq;
+			iwl_mvm_d3_update_igtk_bigtk(status, key,
+						     &status->igtk);
+		}
+		if (key->keyidx == 6 || key->keyidx == 7) {
+			u8 idx = key->keyidx == status->bigtk[1].id;
 
-				iwl_mvm_d3_set_igtk_bigtk_ipn(&status->igtk,
-							      &seq,
-							      key->cipher);
-				ieee80211_set_key_rx_seq(key, 0, &seq);
-			}
+			iwl_mvm_d3_update_igtk_bigtk(status, key,
+						     &status->bigtk[idx]);
 		}
 	}
 }
@@ -2042,6 +2061,8 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		.mvm = mvm,
 		.status = status,
 	};
+	int i;
+
 	u32 disconnection_reasons =
 		IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_MISSED_BEACON |
 		IWL_WOWLAN_WAKEUP_BY_DISCONNECTION_ON_DEAUTH;
@@ -2058,6 +2079,11 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 				    0))
 		gtkdata.igtk_support = true;
 
+	if (iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
+				    WOWLAN_INFO_NOTIFICATION,
+				    0) >= 3)
+		gtkdata.bigtk_support = true;
+
 	/* find last GTK that we used initially, if any */
 	ieee80211_iter_keys(mvm->hw, vif,
 			    iwl_mvm_d3_find_last_keys, &gtkdata);
@@ -2088,6 +2114,13 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 						     &status->igtk))
 			return false;
 
+		for (i = 0; i < ARRAY_SIZE(status->bigtk); i++) {
+			if (!iwl_mvm_d3_igtk_bigtk_rekey_add(status, vif,
+							     gtkdata.bigtk_cipher,
+							     &status->bigtk[i]))
+				return false;
+		}
+
 		ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
 					   (void *)&replay_ctr, GFP_KERNEL);
 	}
@@ -2172,6 +2205,37 @@ static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 	memcpy(status->igtk.ipn, data->ipn, sizeof(data->ipn));
 }
 
+static void iwl_mvm_convert_bigtk(struct iwl_wowlan_status_data *status,
+				  const struct iwl_wowlan_igtk_status *data)
+{
+	int data_idx, status_idx = 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(status->bigtk) < WOWLAN_BIGTK_KEYS_NUM);
+
+	for (data_idx = 0; data_idx < WOWLAN_BIGTK_KEYS_NUM; data_idx++) {
+		if (!data[data_idx].key_len)
+			continue;
+
+		status->bigtk[status_idx].len = data[data_idx].key_len;
+		status->bigtk[status_idx].flags = data[data_idx].key_flags;
+		status->bigtk[status_idx].id =
+			u32_get_bits(data[data_idx].key_flags,
+				     IWL_WOWLAN_IGTK_BIGTK_IDX_MASK)
+			+ WOWLAN_BIGTK_MIN_INDEX;
+
+		BUILD_BUG_ON(sizeof(status->bigtk[status_idx].key) <
+			     sizeof(data[data_idx].key));
+		BUILD_BUG_ON(sizeof(status->bigtk[status_idx].ipn) <
+			     sizeof(data[data_idx].ipn));
+
+		memcpy(status->bigtk[status_idx].key, data[data_idx].key,
+		       sizeof(data[data_idx].key));
+		memcpy(status->bigtk[status_idx].ipn, data[data_idx].ipn,
+		       sizeof(data[data_idx].ipn));
+		status_idx++;
+	}
+}
+
 static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 					    struct iwl_wowlan_info_notif *data,
 					    struct iwl_wowlan_status_data *status,
@@ -2194,7 +2258,42 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 	iwl_mvm_convert_key_counters_v5(status, &data->gtk[0].sc);
 	iwl_mvm_convert_gtk_v3(status, data->gtk);
 	iwl_mvm_convert_igtk(status, &data->igtk[0]);
+	iwl_mvm_convert_bigtk(status, data->bigtk);
+	status->replay_ctr = le64_to_cpu(data->replay_ctr);
+	status->pattern_number = le16_to_cpu(data->pattern_number);
+	for (i = 0; i < IWL_MAX_TID_COUNT; i++)
+		status->qos_seq_ctr[i] =
+			le16_to_cpu(data->qos_seq_ctr[i]);
+	status->wakeup_reasons = le32_to_cpu(data->wakeup_reasons);
+	status->num_of_gtk_rekeys =
+		le32_to_cpu(data->num_of_gtk_rekeys);
+	status->received_beacons = le32_to_cpu(data->received_beacons);
+	status->tid_tear_down = data->tid_tear_down;
+}
+
+static void
+iwl_mvm_parse_wowlan_info_notif_v2(struct iwl_mvm *mvm,
+				   struct iwl_wowlan_info_notif_v2 *data,
+				   struct iwl_wowlan_status_data *status,
+				   u32 len)
+{
+	u32 i;
+
+	if (!data) {
+		IWL_ERR(mvm, "iwl_wowlan_info_notif data is NULL\n");
+		status = NULL;
+		return;
+	}
+
+	if (len < sizeof(*data)) {
+		IWL_ERR(mvm, "Invalid WoWLAN info notification!\n");
+		status = NULL;
+		return;
+	}
 
+	iwl_mvm_convert_key_counters_v5(status, &data->gtk[0].sc);
+	iwl_mvm_convert_gtk_v3(status, data->gtk);
+	iwl_mvm_convert_igtk(status, &data->igtk[0]);
 	status->replay_ctr = le64_to_cpu(data->replay_ctr);
 	status->pattern_number = le16_to_cpu(data->pattern_number);
 	for (i = 0; i < IWL_MAX_TID_COUNT; i++)
@@ -2866,7 +2965,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_mvm *mvm =
 		container_of(notif_wait, struct iwl_mvm, notif_wait);
 	struct iwl_d3_data *d3_data = data;
-	u32 len;
+	u32 len = iwl_rx_packet_payload_len(pkt);
 	int ret;
 	int wowlan_info_ver = iwl_fw_lookup_notif_ver(mvm->fw,
 						      PROT_OFFLOAD_GROUP,
@@ -2876,7 +2975,6 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 
 	switch (WIDE_ID(pkt->hdr.group_id, pkt->hdr.cmd)) {
 	case WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION): {
-		struct iwl_wowlan_info_notif *notif;
 
 		if (d3_data->notif_received & IWL_D3_NOTIF_WOWLAN_INFO) {
 			/* We might get two notifications due to dual bss */
@@ -2886,26 +2984,39 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 		}
 
 		if (wowlan_info_ver < 2) {
-			struct iwl_wowlan_info_notif_v1 *notif_v1 = (void *)pkt->data;
+			struct iwl_wowlan_info_notif_v1 *notif_v1 =
+				(void *)pkt->data;
+			struct iwl_wowlan_info_notif_v2 *notif_v2;
 
-			notif = kmemdup(notif_v1, sizeof(*notif), GFP_ATOMIC);
-			if (!notif)
+			notif_v2 = kmemdup(notif_v1, sizeof(*notif_v2), GFP_ATOMIC);
+
+			if (!notif_v2)
 				return false;
 
-			notif->tid_tear_down = notif_v1->tid_tear_down;
-			notif->station_id = notif_v1->station_id;
-			memset_after(notif, 0, station_id);
+			notif_v2->tid_tear_down = notif_v1->tid_tear_down;
+			notif_v2->station_id = notif_v1->station_id;
+			memset_after(notif_v2, 0, station_id);
+			iwl_mvm_parse_wowlan_info_notif_v2(mvm, notif_v2,
+							   d3_data->status,
+							   len);
+			kfree(notif_v2);
+
+		} else if (wowlan_info_ver == 2) {
+			struct iwl_wowlan_info_notif_v2 *notif_v2 =
+				(void *)pkt->data;
+
+			iwl_mvm_parse_wowlan_info_notif_v2(mvm, notif_v2,
+							   d3_data->status,
+							   len);
 		} else {
-			notif = (void *)pkt->data;
+			struct iwl_wowlan_info_notif *notif =
+				(void *)pkt->data;
+
+			iwl_mvm_parse_wowlan_info_notif(mvm, notif,
+							d3_data->status, len);
 		}
 
 		d3_data->notif_received |= IWL_D3_NOTIF_WOWLAN_INFO;
-		len = iwl_rx_packet_payload_len(pkt);
-		iwl_mvm_parse_wowlan_info_notif(mvm, notif, d3_data->status,
-						len);
-
-		if (wowlan_info_ver < 2)
-			kfree(notif);
 
 		if (d3_data->status &&
 		    d3_data->status->wakeup_reasons & IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT)
-- 
2.38.1

