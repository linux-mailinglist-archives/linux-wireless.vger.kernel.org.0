Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5084A4682FA
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241529AbhLDGjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:41 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50314 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241661AbhLDGjk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:40 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOeb-0017AH-IS; Sat, 04 Dec 2021 08:36:14 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:51 +0200
Message-Id: <iwlwifi.20211204083238.73637acafe0b.I33e27712a12fff2816edc0a8abda1759259e20d7@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH 08/12] iwlwifi: mvm: d3: support v12 wowlan status
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Newer firmware versions are going to come with a new version
of the wowlan status API, which gives us replay counters for
both GTKs that might still be in use, as well as unifying the
layout of the counters to just be 64-bit quantities.

Extend our code to handle this case and be able to install
replay counters for both keys, if they're sent up from the
firmware.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  81 +++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 183 +++++++++++++++---
 2 files changed, 235 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 1503119ea910..4cd9ab23954e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -554,7 +554,7 @@ struct iwl_wowlan_gtk_status_v1 {
 } __packed; /* WOWLAN_GTK_MATERIAL_VER_1 */
 
 /**
- * struct iwl_wowlan_gtk_status - GTK status
+ * struct iwl_wowlan_gtk_status_v2 - GTK status
  * @key: GTK material
  * @key_len: GTK legth, if set to 0, the key is not available
  * @key_flags: information about the key:
@@ -565,7 +565,7 @@ struct iwl_wowlan_gtk_status_v1 {
  * @tkip_mic_key: TKIP RX MIC key
  * @rsc: TSC RSC counters
  */
-struct iwl_wowlan_gtk_status {
+struct iwl_wowlan_gtk_status_v2 {
 	u8 key[WOWLAN_KEY_MAX_SIZE];
 	u8 key_len;
 	u8 key_flags;
@@ -574,6 +574,41 @@ struct iwl_wowlan_gtk_status {
 	struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 rsc;
 } __packed; /* WOWLAN_GTK_MATERIAL_VER_2 */
 
+/**
+ * struct iwl_wowlan_all_rsc_tsc_v5 - key counters
+ * @ucast_rsc: unicast RSC values
+ * @mcast_rsc: multicast RSC values (per key map value)
+ * @sta_id: station ID
+ * @mcast_key_id_map: map of key id to @mcast_rsc entry
+ */
+struct iwl_wowlan_all_rsc_tsc_v5 {
+	__le64 ucast_rsc[IWL_MAX_TID_COUNT];
+	__le64 mcast_rsc[2][IWL_MAX_TID_COUNT];
+	__le32 sta_id;
+	u8 mcast_key_id_map[4];
+} __packed; /* ALL_TSC_RSC_API_S_VER_5 */
+
+/**
+ * struct iwl_wowlan_gtk_status_v3 - GTK status
+ * @key: GTK material
+ * @key_len: GTK length, if set to 0, the key is not available
+ * @key_flags: information about the key:
+ *	bits[0:1]:  key index assigned by the AP
+ *	bits[2:6]:  GTK index of the key in the internal DB
+ *	bit[7]:     Set iff this is the currently used GTK
+ * @reserved: padding
+ * @tkip_mic_key: TKIP RX MIC key
+ * @sc: RSC/TSC counters
+ */
+struct iwl_wowlan_gtk_status_v3 {
+	u8 key[WOWLAN_KEY_MAX_SIZE];
+	u8 key_len;
+	u8 key_flags;
+	u8 reserved[2];
+	u8 tkip_mic_key[IWL_MIC_KEY_SIZE];
+	struct iwl_wowlan_all_rsc_tsc_v5 sc;
+} __packed; /* WOWLAN_GTK_MATERIAL_VER_3 */
+
 #define IWL_WOWLAN_GTK_IDX_MASK		(BIT(0) | BIT(1))
 
 /**
@@ -640,7 +675,7 @@ struct iwl_wowlan_status_v6 {
  * @wake_packet: wakeup packet
  */
 struct iwl_wowlan_status_v7 {
-	struct iwl_wowlan_gtk_status gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_gtk_status_v2 gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
 	__le16 pattern_number;
@@ -676,7 +711,7 @@ struct iwl_wowlan_status_v7 {
  * @wake_packet: wakeup packet
  */
 struct iwl_wowlan_status_v9 {
-	struct iwl_wowlan_gtk_status gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_gtk_status_v2 gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
 	__le16 pattern_number;
@@ -693,6 +728,44 @@ struct iwl_wowlan_status_v9 {
 	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
 } __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_9 */
 
+/**
+ * struct iwl_wowlan_status_v12 - WoWLAN status
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched pattern
+ * @non_qos_seq_ctr: non-QoS sequence counter to use next.
+ *                   Reserved if the struct has version >= 10.
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @transmitted_ndps: number of transmitted neighbor discovery packets
+ * @received_beacons: number of received beacons
+ * @wake_packet_length: wakeup packet length
+ * @wake_packet_bufsize: wakeup packet buffer size
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *		   in suspend state
+ * @reserved: unused
+ * @wake_packet: wakeup packet
+ */
+struct iwl_wowlan_status_v12 {
+	struct iwl_wowlan_gtk_status_v3 gtk[WOWLAN_GTK_KEYS_NUM];
+	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 non_qos_seq_ctr;
+	__le16 qos_seq_ctr[8];
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	__le32 transmitted_ndps;
+	__le32 received_beacons;
+	__le32 wake_packet_length;
+	__le32 wake_packet_bufsize;
+	u8 tid_tear_down;
+	u8 reserved[3];
+	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
+} __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_12 */
+
 /* TODO: NetDetect API */
 
 #endif /* __iwl_fw_api_d3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index f9b485fcfcdb..b400867e94f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1390,6 +1390,13 @@ struct iwl_wowlan_status_data {
 	u16 qos_seq_ctr[8];
 	u8 tid_tear_down;
 
+	struct {
+		/* including RX MIC key for TKIP */
+		u8 key[WOWLAN_KEY_MAX_SIZE];
+		u8 len;
+		u8 flags;
+	} gtk;
+
 	struct {
 		/*
 		 * We store both the TKIP and AES representations
@@ -1400,11 +1407,15 @@ struct iwl_wowlan_status_data {
 		struct {
 			struct ieee80211_key_seq seq[IWL_MAX_TID_COUNT];
 		} tkip, aes;
-		/* including RX MIC key for TKIP */
-		u8 key[WOWLAN_KEY_MAX_SIZE];
-		u8 len;
-		u8 flags;
-	} gtk;
+
+		/*
+		 * We use -1 for when we have valid data but don't know
+		 * the key ID from firmware, and thus it needs to be
+		 * installed with the last key (depending on rekeying).
+		 */
+		s8 key_id;
+		bool valid;
+	} gtk_seq[2];
 
 	struct {
 		/* Same as above */
@@ -1556,12 +1567,10 @@ static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
 	kfree_skb(pkt);
 }
 
-static void iwl_mvm_aes_sc_to_seq(struct aes_sc *sc,
-				  struct ieee80211_key_seq *seq)
+static void iwl_mvm_le64_to_aes_seq(__le64 le_pn, struct ieee80211_key_seq *seq)
 {
-	u64 pn;
+	u64 pn = le64_to_cpu(le_pn);
 
-	pn = le64_to_cpu(sc->pn);
 	seq->ccmp.pn[0] = pn >> 40;
 	seq->ccmp.pn[1] = pn >> 32;
 	seq->ccmp.pn[2] = pn >> 24;
@@ -1570,6 +1579,20 @@ static void iwl_mvm_aes_sc_to_seq(struct aes_sc *sc,
 	seq->ccmp.pn[5] = pn;
 }
 
+static void iwl_mvm_aes_sc_to_seq(struct aes_sc *sc,
+				  struct ieee80211_key_seq *seq)
+{
+	iwl_mvm_le64_to_aes_seq(sc->pn, seq);
+}
+
+static void iwl_mvm_le64_to_tkip_seq(__le64 le_pn, struct ieee80211_key_seq *seq)
+{
+	u64 pn = le64_to_cpu(le_pn);
+
+	seq->tkip.iv16 = (u16)pn;
+	seq->tkip.iv32 = (u32)(pn >> 16);
+}
+
 static void iwl_mvm_tkip_sc_to_seq(struct tkip_sc *sc,
 				   struct ieee80211_key_seq *seq)
 {
@@ -1630,10 +1653,12 @@ static void iwl_mvm_convert_key_counters(struct iwl_wowlan_status_data *status,
 	/* GTK RX counters */
 	for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
 		iwl_mvm_tkip_sc_to_seq(&sc->tkip.multicast_rsc[i],
-				       &status->gtk.tkip.seq[i]);
+				       &status->gtk_seq[0].tkip.seq[i]);
 		iwl_mvm_aes_sc_to_seq(&sc->aes.multicast_rsc[i],
-				      &status->gtk.aes.seq[i]);
+				      &status->gtk_seq[0].aes.seq[i]);
 	}
+	status->gtk_seq[0].valid = true;
+	status->gtk_seq[0].key_id = -1;
 
 	/* PTK TX counter */
 	status->ptk.tkip.tx_pn = (u64)le16_to_cpu(sc->tkip.tsc.iv16) |
@@ -1649,28 +1674,103 @@ static void iwl_mvm_convert_key_counters(struct iwl_wowlan_status_data *status,
 	}
 }
 
-static void iwl_mvm_set_key_rx_seq(struct iwl_mvm *mvm,
-				   struct ieee80211_key_conf *key,
-				   struct iwl_wowlan_status_data *status,
-				   bool installed)
+static void
+iwl_mvm_convert_key_counters_v5_gtk_seq(struct iwl_wowlan_status_data *status,
+					struct iwl_wowlan_all_rsc_tsc_v5 *sc,
+					unsigned int idx, unsigned int key_id)
 {
-	if (status->num_of_gtk_rekeys && !installed)
-		return;
+	int tid;
+
+	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
+		iwl_mvm_le64_to_tkip_seq(sc->mcast_rsc[idx][tid],
+					 &status->gtk_seq[idx].tkip.seq[tid]);
+		iwl_mvm_le64_to_aes_seq(sc->mcast_rsc[idx][tid],
+					&status->gtk_seq[idx].aes.seq[tid]);
+	}
+
+	status->gtk_seq[idx].valid = true;
+	status->gtk_seq[idx].key_id = key_id;
+}
+
+static void
+iwl_mvm_convert_key_counters_v5(struct iwl_wowlan_status_data *status,
+				struct iwl_wowlan_all_rsc_tsc_v5 *sc)
+{
+	int i, tid;
 
+	BUILD_BUG_ON(IWL_MAX_TID_COUNT > IWL_MAX_TID_COUNT);
+	BUILD_BUG_ON(IWL_MAX_TID_COUNT > IWL_NUM_RSC);
+	BUILD_BUG_ON(ARRAY_SIZE(sc->mcast_rsc) != ARRAY_SIZE(status->gtk_seq));
+
+	/* GTK RX counters */
+	for (i = 0; i < ARRAY_SIZE(sc->mcast_key_id_map); i++) {
+		u8 entry = sc->mcast_key_id_map[i];
+
+		if (entry < ARRAY_SIZE(sc->mcast_rsc))
+			iwl_mvm_convert_key_counters_v5_gtk_seq(status, sc,
+								entry, i);
+	}
+
+	/* PTK TX counters not needed, assigned in device */
+
+	/* PTK RX counters */
+	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
+		iwl_mvm_le64_to_tkip_seq(sc->ucast_rsc[tid],
+					 &status->ptk.tkip.seq[tid]);
+		iwl_mvm_le64_to_aes_seq(sc->ucast_rsc[tid],
+					&status->ptk.aes.seq[tid]);
+	}
+}
+
+static void iwl_mvm_set_key_rx_seq_idx(struct ieee80211_key_conf *key,
+				       struct iwl_wowlan_status_data *status,
+				       int idx)
+{
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		iwl_mvm_set_key_rx_seq_tids(key, status->gtk.aes.seq);
+		iwl_mvm_set_key_rx_seq_tids(key, status->gtk_seq[idx].aes.seq);
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
-		iwl_mvm_set_key_rx_seq_tids(key, status->gtk.tkip.seq);
+		iwl_mvm_set_key_rx_seq_tids(key, status->gtk_seq[idx].tkip.seq);
 		break;
 	default:
 		WARN_ON(1);
 	}
 }
 
+static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
+				   struct iwl_wowlan_status_data *status,
+				   bool installed)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(status->gtk_seq); i++) {
+		if (!status->gtk_seq[i].valid)
+			continue;
+
+		/* Handle the case where we know the key ID */
+		if (status->gtk_seq[i].key_id == key->keyidx) {
+			s8 new_key_id = -1;
+
+			if (status->num_of_gtk_rekeys)
+				new_key_id = status->gtk.flags &
+						IWL_WOWLAN_GTK_IDX_MASK;
+
+			/* Don't install a new key's value to an old key */
+			if (new_key_id != key->keyidx)
+				iwl_mvm_set_key_rx_seq_idx(key, status, i);
+			continue;
+		}
+
+		/* handle the case where we didn't, last key only */
+		if (status->gtk_seq[i].key_id == -1 &&
+		    (!status->num_of_gtk_rekeys || installed))
+			iwl_mvm_set_key_rx_seq_idx(key, status, i);
+	}
+}
+
 struct iwl_mvm_d3_gtk_iter_data {
 	struct iwl_mvm *mvm;
 	struct iwl_wowlan_status_data *status;
@@ -1746,7 +1846,7 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 		ieee80211_remove_key(key);
 
 	if (data->last_gtk == key)
-		iwl_mvm_set_key_rx_seq(data->mvm, key, data->status, false);
+		iwl_mvm_set_key_rx_seq(key, data->status, false);
 }
 
 static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
@@ -1830,7 +1930,7 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		key = ieee80211_gtk_rekey_add(vif, &conf.conf);
 		if (IS_ERR(key))
 			return false;
-		iwl_mvm_set_key_rx_seq(mvm, key, status, true);
+		iwl_mvm_set_key_rx_seq(key, status, true);
 
 		replay_ctr = cpu_to_be64(status->replay_ctr);
 
@@ -1898,9 +1998,10 @@ iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
 iwl_mvm_parse_wowlan_status_common(v6)
 iwl_mvm_parse_wowlan_status_common(v7)
 iwl_mvm_parse_wowlan_status_common(v9)
+iwl_mvm_parse_wowlan_status_common(v12)
 
-static void iwl_mvm_convert_gtk(struct iwl_wowlan_status_data *status,
-				struct iwl_wowlan_gtk_status *data)
+static void iwl_mvm_convert_gtk_v2(struct iwl_wowlan_status_data *status,
+				   struct iwl_wowlan_gtk_status_v2 *data)
 {
 	BUILD_BUG_ON(sizeof(status->gtk.key) < sizeof(data->key));
 	BUILD_BUG_ON(NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY +
@@ -1918,6 +2019,26 @@ static void iwl_mvm_convert_gtk(struct iwl_wowlan_status_data *status,
 		       data->tkip_mic_key, sizeof(data->tkip_mic_key));
 }
 
+static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
+				   struct iwl_wowlan_gtk_status_v3 *data)
+{
+	/* The parts we need are identical in v2 and v3 */
+#define CHECK(_f) do {							\
+	BUILD_BUG_ON(offsetof(struct iwl_wowlan_gtk_status_v2, _f) !=	\
+		     offsetof(struct iwl_wowlan_gtk_status_v3, _f));	\
+	BUILD_BUG_ON(offsetofend(struct iwl_wowlan_gtk_status_v2, _f) !=\
+		     offsetofend(struct iwl_wowlan_gtk_status_v3, _f));	\
+} while (0)
+
+	CHECK(key);
+	CHECK(key_len);
+	CHECK(key_flags);
+	CHECK(tkip_mic_key);
+#undef CHECK
+
+	iwl_mvm_convert_gtk_v2(status, (void *)data);
+}
+
 static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 				 struct iwl_wowlan_igtk_status *data)
 {
@@ -2017,7 +2138,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 			goto out_free_resp;
 
 		iwl_mvm_convert_key_counters(status, &v7->gtk[0].rsc.all_tsc_rsc);
-		iwl_mvm_convert_gtk(status, &v7->gtk[0]);
+		iwl_mvm_convert_gtk_v2(status, &v7->gtk[0]);
 		iwl_mvm_convert_igtk(status, &v7->igtk[0]);
 	} else if (notif_ver == 9 || notif_ver == 10 || notif_ver == 11) {
 		struct iwl_wowlan_status_v9 *v9 = (void *)cmd.resp_pkt->data;
@@ -2030,10 +2151,22 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 			goto out_free_resp;
 
 		iwl_mvm_convert_key_counters(status, &v9->gtk[0].rsc.all_tsc_rsc);
-		iwl_mvm_convert_gtk(status, &v9->gtk[0]);
+		iwl_mvm_convert_gtk_v2(status, &v9->gtk[0]);
 		iwl_mvm_convert_igtk(status, &v9->igtk[0]);
 
 		status->tid_tear_down = v9->tid_tear_down;
+	} else if (notif_ver == 12) {
+		struct iwl_wowlan_status_v12 *v12 = (void *)cmd.resp_pkt->data;
+
+		status = iwl_mvm_parse_wowlan_status_common_v12(mvm, v12, len);
+		if (IS_ERR(status))
+			goto out_free_resp;
+
+		iwl_mvm_convert_key_counters_v5(status, &v12->gtk[0].sc);
+		iwl_mvm_convert_gtk_v3(status, &v12->gtk[0]);
+		iwl_mvm_convert_igtk(status, &v12->igtk[0]);
+
+		status->tid_tear_down = v12->tid_tear_down;
 	} else {
 		IWL_ERR(mvm,
 			"Firmware advertises unknown WoWLAN status response %d!\n",
-- 
2.33.1

