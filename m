Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D514389C8
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhJXPXQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58644 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231397AbhJXPXP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIo-000czj-9R; Sun, 24 Oct 2021 18:20:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:31 +0300
Message-Id: <iwlwifi.20211024181719.9e71630627f3.Iad975e15338844ca068683f62a51eb1fcb69e608@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: mvm: d3: use internal data representation
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Trying to convert from one firmware data representation to the
next version is getting tedious and error-prone, and doesn't
lend itself well to new APIs being added. Additionally, the
version 11 of the API as defined in the driver doesn't even
exist in the firmware.

Instead of converting to a newer firmware version of the data,
convert to an internal representation. This takes a bit more
space because the TKIP/AES counters etc. must be kept twice,
their representation is different and we don't know which of
the ones it is until later, but this is just a temporary use
of memory, and the code is clearer this way.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  43 ---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 357 +++++++++++-------
 2 files changed, 212 insertions(+), 188 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index e199d1813a61..1503119ea910 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -693,49 +693,6 @@ struct iwl_wowlan_status_v9 {
 	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
 } __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_9 */
 
-/**
- * struct iwl_wowlan_status - WoWLAN status
- * @gtk: GTK data
- * @igtk: IGTK data
- * @bigtk: BIGTK data
- * @replay_ctr: GTK rekey replay counter
- * @pattern_number: number of the matched pattern
- * @non_qos_seq_ctr: non-QoS sequence counter to use next
- * @qos_seq_ctr: QoS sequence counters to use next
- * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
- * @num_of_gtk_rekeys: number of GTK rekeys
- * @tid_tear_down: bitmap of TIDs torn down
- * @reserved: reserved
- * @received_beacons: number of received beacons
- * @wake_packet_length: wakeup packet length
- * @wake_packet_bufsize: wakeup packet buffer size
- * @tid_tear_down: bit mask of tids whose BA sessions were closed
- *		   in suspend state
- * @wake_packet: wakeup packet
- */
-struct iwl_wowlan_status {
-	struct iwl_wowlan_gtk_status gtk[1];
-	struct iwl_wowlan_igtk_status igtk[1];
-	struct iwl_wowlan_igtk_status bigtk[WOWLAN_IGTK_KEYS_NUM];
-	__le64 replay_ctr;
-	__le16 pattern_number;
-	__le16 non_qos_seq_ctr;
-	__le16 qos_seq_ctr[8];
-	__le32 wakeup_reasons;
-	__le32 num_of_gtk_rekeys;
-	u8 tid_tear_down;
-	u8 reserved[3];
-	__le32 received_beacons;
-	__le32 wake_packet_length;
-	__le32 wake_packet_bufsize;
-	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
-} __packed; /* WOWLAN_STATUSES_API_S_VER_11 */
-
-static inline u8 iwlmvm_wowlan_gtk_idx(struct iwl_wowlan_gtk_status *gtk)
-{
-	return gtk->key_flags & IWL_WOWLAN_GTK_IDX_MASK;
-}
-
 /* TODO: NetDetect API */
 
 #endif /* __iwl_fw_api_d3_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d3013a51a509..a19f646a324f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1379,12 +1379,49 @@ int iwl_mvm_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 
 /* converted data from the different status responses */
 struct iwl_wowlan_status_data {
-	u16 pattern_number;
-	u16 qos_seq_ctr[8];
+	u64 replay_ctr;
+	u32 num_of_gtk_rekeys;
+	u32 received_beacons;
 	u32 wakeup_reasons;
 	u32 wake_packet_length;
 	u32 wake_packet_bufsize;
-	const u8 *wake_packet;
+	u16 pattern_number;
+	u16 non_qos_seq_ctr;
+	u16 qos_seq_ctr[8];
+	u8 tid_tear_down;
+
+	struct {
+		/*
+		 * We store both the TKIP and AES representations
+		 * coming from the firmware because we decode the
+		 * data from there before we iterate the keys and
+		 * know which one we need.
+		 */
+		struct {
+			struct ieee80211_key_seq seq[IWL_MAX_TID_COUNT];
+		} tkip, aes;
+		/* including RX MIC key for TKIP */
+		u8 key[WOWLAN_KEY_MAX_SIZE];
+		u8 len;
+		u8 flags;
+	} gtk;
+
+	struct {
+		/* Same as above */
+		struct {
+			struct ieee80211_key_seq seq[IWL_MAX_TID_COUNT];
+			u64 tx_pn;
+		} tkip, aes;
+	} ptk;
+
+	struct {
+		u64 ipn;
+		u8 key[WOWLAN_KEY_MAX_SIZE];
+		u8 len;
+		u8 flags;
+	} igtk;
+
+	u8 wake_packet[];
 };
 
 static void iwl_mvm_report_wakeup_reasons(struct iwl_mvm *mvm,
@@ -1540,77 +1577,90 @@ static void iwl_mvm_tkip_sc_to_seq(struct tkip_sc *sc,
 	seq->tkip.iv16 = le16_to_cpu(sc->iv16);
 }
 
-static void iwl_mvm_set_aes_rx_seq(struct iwl_mvm *mvm, struct aes_sc *scs,
-				   struct ieee80211_sta *sta,
-				   struct ieee80211_key_conf *key)
+static void iwl_mvm_set_key_rx_seq_tids(struct ieee80211_key_conf *key,
+					struct ieee80211_key_seq *seq)
 {
 	int tid;
 
-	BUILD_BUG_ON(IWL_NUM_RSC != IEEE80211_NUM_TIDS);
+	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++)
+		ieee80211_set_key_rx_seq(key, tid, &seq[tid]);
+}
 
-	if (sta && iwl_mvm_has_new_rx_api(mvm)) {
-		struct iwl_mvm_sta *mvmsta;
-		struct iwl_mvm_key_pn *ptk_pn;
+static void iwl_mvm_set_aes_ptk_rx_seq(struct iwl_mvm *mvm,
+				       struct iwl_wowlan_status_data *status,
+				       struct ieee80211_sta *sta,
+				       struct ieee80211_key_conf *key)
+{
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_key_pn *ptk_pn;
+	int tid;
 
-		mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	iwl_mvm_set_key_rx_seq_tids(key, status->ptk.aes.seq);
 
-		rcu_read_lock();
-		ptk_pn = rcu_dereference(mvmsta->ptk_pn[key->keyidx]);
-		if (WARN_ON(!ptk_pn)) {
-			rcu_read_unlock();
-			return;
-		}
+	if (!iwl_mvm_has_new_rx_api(mvm))
+		return;
 
-		for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
-			struct ieee80211_key_seq seq = {};
-			int i;
 
-			iwl_mvm_aes_sc_to_seq(&scs[tid], &seq);
-			ieee80211_set_key_rx_seq(key, tid, &seq);
-			for (i = 1; i < mvm->trans->num_rx_queues; i++)
-				memcpy(ptk_pn->q[i].pn[tid],
-				       seq.ccmp.pn, IEEE80211_CCMP_PN_LEN);
-		}
+	rcu_read_lock();
+	ptk_pn = rcu_dereference(mvmsta->ptk_pn[key->keyidx]);
+	if (WARN_ON(!ptk_pn)) {
 		rcu_read_unlock();
-	} else {
-		for (tid = 0; tid < IWL_NUM_RSC; tid++) {
-			struct ieee80211_key_seq seq = {};
+		return;
+	}
 
-			iwl_mvm_aes_sc_to_seq(&scs[tid], &seq);
-			ieee80211_set_key_rx_seq(key, tid, &seq);
-		}
+	for (tid = 0; tid < IWL_MAX_TID_COUNT; tid++) {
+		int i;
+
+		for (i = 1; i < mvm->trans->num_rx_queues; i++)
+			memcpy(ptk_pn->q[i].pn[tid],
+			       status->ptk.aes.seq[tid].ccmp.pn,
+			       IEEE80211_CCMP_PN_LEN);
 	}
+	rcu_read_unlock();
 }
 
-static void iwl_mvm_set_tkip_rx_seq(struct tkip_sc *scs,
-				    struct ieee80211_key_conf *key)
+static void iwl_mvm_convert_key_counters(struct iwl_wowlan_status_data *status,
+					 union iwl_all_tsc_rsc *sc)
 {
-	int tid;
+	int i;
 
-	BUILD_BUG_ON(IWL_NUM_RSC != IEEE80211_NUM_TIDS);
+	BUILD_BUG_ON(IWL_MAX_TID_COUNT > IWL_MAX_TID_COUNT);
+	BUILD_BUG_ON(IWL_MAX_TID_COUNT > IWL_NUM_RSC);
 
-	for (tid = 0; tid < IWL_NUM_RSC; tid++) {
-		struct ieee80211_key_seq seq = {};
+	/* GTK RX counters */
+	for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
+		iwl_mvm_tkip_sc_to_seq(&sc->tkip.multicast_rsc[i],
+				       &status->gtk.tkip.seq[i]);
+		iwl_mvm_aes_sc_to_seq(&sc->aes.multicast_rsc[i],
+				      &status->gtk.aes.seq[i]);
+	}
 
-		iwl_mvm_tkip_sc_to_seq(&scs[tid], &seq);
-		ieee80211_set_key_rx_seq(key, tid, &seq);
+	/* PTK TX counter */
+	status->ptk.tkip.tx_pn = (u64)le16_to_cpu(sc->tkip.tsc.iv16) |
+				 ((u64)le32_to_cpu(sc->tkip.tsc.iv32) << 16);
+	status->ptk.aes.tx_pn = le64_to_cpu(sc->aes.tsc.pn);
+
+	/* PTK RX counters */
+	for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
+		iwl_mvm_tkip_sc_to_seq(&sc->tkip.unicast_rsc[i],
+				       &status->ptk.tkip.seq[i]);
+		iwl_mvm_aes_sc_to_seq(&sc->aes.unicast_rsc[i],
+				      &status->ptk.aes.seq[i]);
 	}
 }
 
 static void iwl_mvm_set_key_rx_seq(struct iwl_mvm *mvm,
 				   struct ieee80211_key_conf *key,
-				   struct iwl_wowlan_status *status)
+				   struct iwl_wowlan_status_data *status)
 {
-	union iwl_all_tsc_rsc *rsc = &status->gtk[0].rsc.all_tsc_rsc;
-
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		iwl_mvm_set_aes_rx_seq(mvm, rsc->aes.multicast_rsc, NULL, key);
+		iwl_mvm_set_key_rx_seq_tids(key, status->gtk.aes.seq);
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
-		iwl_mvm_set_tkip_rx_seq(rsc->tkip.multicast_rsc, key);
+		iwl_mvm_set_key_rx_seq_tids(key, status->gtk.tkip.seq);
 		break;
 	default:
 		WARN_ON(1);
@@ -1619,7 +1669,7 @@ static void iwl_mvm_set_key_rx_seq(struct iwl_mvm *mvm,
 
 struct iwl_mvm_d3_gtk_iter_data {
 	struct iwl_mvm *mvm;
-	struct iwl_wowlan_status *status;
+	struct iwl_wowlan_status_data *status;
 	void *last_gtk;
 	u32 cipher;
 	bool find_phase, unhandled_cipher;
@@ -1633,6 +1683,7 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 				   void *_data)
 {
 	struct iwl_mvm_d3_gtk_iter_data *data = _data;
+	struct iwl_wowlan_status_data *status = data->status;
 
 	if (data->unhandled_cipher)
 		return;
@@ -1661,10 +1712,6 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 	 * note that this assumes no TDLS sessions are active
 	 */
 	if (sta) {
-		struct ieee80211_key_seq seq = {};
-		union iwl_all_tsc_rsc *sc =
-			&data->status->gtk[0].rsc.all_tsc_rsc;
-
 		if (data->find_phase)
 			return;
 
@@ -1672,16 +1719,12 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 		case WLAN_CIPHER_SUITE_CCMP:
 		case WLAN_CIPHER_SUITE_GCMP:
 		case WLAN_CIPHER_SUITE_GCMP_256:
-			iwl_mvm_set_aes_rx_seq(data->mvm, sc->aes.unicast_rsc,
-					       sta, key);
-			atomic64_set(&key->tx_pn, le64_to_cpu(sc->aes.tsc.pn));
+			atomic64_set(&key->tx_pn, status->ptk.aes.tx_pn);
+			iwl_mvm_set_aes_ptk_rx_seq(data->mvm, status, sta, key);
 			break;
 		case WLAN_CIPHER_SUITE_TKIP:
-			iwl_mvm_tkip_sc_to_seq(&sc->tkip.tsc, &seq);
-			iwl_mvm_set_tkip_rx_seq(sc->tkip.unicast_rsc, key);
-			atomic64_set(&key->tx_pn,
-				     (u64)seq.tkip.iv16 |
-				     ((u64)seq.tkip.iv32 << 16));
+			atomic64_set(&key->tx_pn, status->ptk.tkip.tx_pn);
+			iwl_mvm_set_key_rx_seq_tids(key, status->ptk.tkip.seq);
 			break;
 		}
 
@@ -1703,7 +1746,7 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 
 static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
-					  struct iwl_wowlan_status *status)
+					  struct iwl_wowlan_status_data *status)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_d3_gtk_iter_data gtkdata = {
@@ -1717,7 +1760,7 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	if (!status || !vif->bss_conf.bssid)
 		return false;
 
-	if (le32_to_cpu(status->wakeup_reasons) & disconnection_reasons)
+	if (status->wakeup_reasons & disconnection_reasons)
 		return false;
 
 	/* find last GTK that we used initially, if any */
@@ -1741,7 +1784,7 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 			    iwl_mvm_d3_update_keys, &gtkdata);
 
 	IWL_DEBUG_WOWLAN(mvm, "num of GTK rekeying %d\n",
-			 le32_to_cpu(status->num_of_gtk_rekeys));
+			 status->num_of_gtk_rekeys);
 	if (status->num_of_gtk_rekeys) {
 		struct ieee80211_key_conf *key;
 		struct {
@@ -1750,36 +1793,32 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		} conf = {
 			.conf.cipher = gtkdata.cipher,
 			.conf.keyidx =
-				iwlmvm_wowlan_gtk_idx(&status->gtk[0]),
+				status->gtk.flags & IWL_WOWLAN_GTK_IDX_MASK,
 		};
 		__be64 replay_ctr;
 
 		IWL_DEBUG_WOWLAN(mvm,
 				 "Received from FW GTK cipher %d, key index %d\n",
 				 conf.conf.cipher, conf.conf.keyidx);
+
+		BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
+		BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
+		BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
+		BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
+		BUILD_BUG_ON(sizeof(conf.key) < sizeof(status->gtk.key));
+
+		memcpy(conf.conf.key, status->gtk.key, sizeof(status->gtk.key));
+
 		switch (gtkdata.cipher) {
 		case WLAN_CIPHER_SUITE_CCMP:
 		case WLAN_CIPHER_SUITE_GCMP:
-			BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
-			BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
 			conf.conf.keylen = WLAN_KEY_LEN_CCMP;
-			memcpy(conf.conf.key, status->gtk[0].key,
-			       WLAN_KEY_LEN_CCMP);
 			break;
 		case WLAN_CIPHER_SUITE_GCMP_256:
-			BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
 			conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
-			memcpy(conf.conf.key, status->gtk[0].key,
-			       WLAN_KEY_LEN_GCMP_256);
 			break;
 		case WLAN_CIPHER_SUITE_TKIP:
-			BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
 			conf.conf.keylen = WLAN_KEY_LEN_TKIP;
-			memcpy(conf.conf.key, status->gtk[0].key, 16);
-			/* leave TX MIC key zeroed, we don't use it anyway */
-			memcpy(conf.conf.key +
-			       NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
-			       status->gtk[0].tkip_mic_key, 8);
 			break;
 		}
 
@@ -1788,8 +1827,7 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 			return false;
 		iwl_mvm_set_key_rx_seq(mvm, key, status);
 
-		replay_ctr =
-			cpu_to_be64(le64_to_cpu(status->replay_ctr));
+		replay_ctr = cpu_to_be64(status->replay_ctr);
 
 		ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
 					   (void *)&replay_ctr, GFP_KERNEL);
@@ -1800,7 +1838,7 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 				    WOWLAN_GET_STATUSES, 0) < 10) {
 		mvmvif->seqno_valid = true;
 		/* +0x10 because the set API expects next-to-use, not last-used */
-		mvmvif->seqno = le16_to_cpu(status->non_qos_seq_ctr) + 0x10;
+		mvmvif->seqno = status->non_qos_seq_ctr + 0x10;
 	}
 
 	return true;
@@ -1808,13 +1846,13 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 /* Occasionally, templates would be nice. This is one of those times ... */
 #define iwl_mvm_parse_wowlan_status_common(_ver)			\
-static struct iwl_wowlan_status *					\
+static struct iwl_wowlan_status_data *					\
 iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
-					    void *_data, int len)	\
+					    struct iwl_wowlan_status_ ##_ver *data,\
+					    int len)			\
 {									\
-	struct iwl_wowlan_status *status;				\
-	struct iwl_wowlan_status_ ##_ver *data = _data;			\
-	int data_size;							\
+	struct iwl_wowlan_status_data *status;				\
+	int data_size, i;						\
 									\
 	if (len < sizeof(*data)) {					\
 		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");	\
@@ -1832,18 +1870,22 @@ iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
 		return ERR_PTR(-ENOMEM);				\
 									\
 	/* copy all the common fields */				\
-	status->replay_ctr = data->replay_ctr;				\
-	status->pattern_number = data->pattern_number;			\
-	status->non_qos_seq_ctr = data->non_qos_seq_ctr;		\
-	memcpy(status->qos_seq_ctr, data->qos_seq_ctr,			\
-	       sizeof(status->qos_seq_ctr));				\
-	status->wakeup_reasons = data->wakeup_reasons;			\
-	status->num_of_gtk_rekeys = data->num_of_gtk_rekeys;		\
-	status->received_beacons = data->received_beacons;		\
-	status->wake_packet_length = data->wake_packet_length;		\
-	status->wake_packet_bufsize = data->wake_packet_bufsize;	\
+	status->replay_ctr = le64_to_cpu(data->replay_ctr);		\
+	status->pattern_number = le16_to_cpu(data->pattern_number);	\
+	status->non_qos_seq_ctr = le16_to_cpu(data->non_qos_seq_ctr);	\
+	for (i = 0; i < 8; i++)						\
+		status->qos_seq_ctr[i] =				\
+			le16_to_cpu(data->qos_seq_ctr[i]);		\
+	status->wakeup_reasons = le32_to_cpu(data->wakeup_reasons);	\
+	status->num_of_gtk_rekeys =					\
+		le32_to_cpu(data->num_of_gtk_rekeys);			\
+	status->received_beacons = le32_to_cpu(data->received_beacons);	\
+	status->wake_packet_length =					\
+		le32_to_cpu(data->wake_packet_length);			\
+	status->wake_packet_bufsize =					\
+		le32_to_cpu(data->wake_packet_bufsize);			\
 	memcpy(status->wake_packet, data->wake_packet,			\
-	       le32_to_cpu(status->wake_packet_bufsize));		\
+	       status->wake_packet_bufsize);				\
 									\
 	return status;							\
 }
@@ -1852,10 +1894,49 @@ iwl_mvm_parse_wowlan_status_common(v6)
 iwl_mvm_parse_wowlan_status_common(v7)
 iwl_mvm_parse_wowlan_status_common(v9)
 
-static struct iwl_wowlan_status *
+static void iwl_mvm_convert_gtk(struct iwl_wowlan_status_data *status,
+				struct iwl_wowlan_gtk_status *data)
+{
+	BUILD_BUG_ON(sizeof(status->gtk.key) < sizeof(data->key));
+	BUILD_BUG_ON(NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY +
+		     sizeof(data->tkip_mic_key) >
+		     sizeof(status->gtk.key));
+
+	status->gtk.len = data->key_len;
+	status->gtk.flags = data->key_flags;
+
+	memcpy(status->gtk.key, data->key, sizeof(data->key));
+
+	/* if it's as long as the TKIP encryption key, copy MIC key */
+	if (status->gtk.len == NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY)
+		memcpy(status->gtk.key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+		       data->tkip_mic_key, sizeof(data->tkip_mic_key));
+}
+
+static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
+				 struct iwl_wowlan_igtk_status *data)
+{
+	const u8 *ipn = data->ipn;
+
+	BUILD_BUG_ON(sizeof(status->igtk.key) < sizeof(data->key));
+
+	status->igtk.len = data->key_len;
+	status->igtk.flags = data->key_flags;
+
+	memcpy(status->igtk.key, data->key, sizeof(data->key));
+
+	status->igtk.ipn = ((u64)ipn[5] <<  0) |
+			   ((u64)ipn[4] <<  8) |
+			   ((u64)ipn[3] << 16) |
+			   ((u64)ipn[2] << 24) |
+			   ((u64)ipn[1] << 32) |
+			   ((u64)ipn[0] << 40);
+}
+
+static struct iwl_wowlan_status_data *
 iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 {
-	struct iwl_wowlan_status *status;
+	struct iwl_wowlan_status_data *status;
 	struct iwl_wowlan_get_status_cmd get_status_cmd = {
 		.sta_id = cpu_to_le32(sta_id),
 	};
@@ -1895,59 +1976,57 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 			IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL)) {
 		struct iwl_wowlan_status_v6 *v6 = (void *)cmd.resp_pkt->data;
 
-		status = iwl_mvm_parse_wowlan_status_common_v6(mvm,
-							       cmd.resp_pkt->data,
-							       len);
+		status = iwl_mvm_parse_wowlan_status_common_v6(mvm, v6, len);
 		if (IS_ERR(status))
 			goto out_free_resp;
 
 		BUILD_BUG_ON(sizeof(v6->gtk.decrypt_key) >
-			     sizeof(status->gtk[0].key));
-		BUILD_BUG_ON(sizeof(v6->gtk.tkip_mic_key) >
-			     sizeof(status->gtk[0].tkip_mic_key));
+			     sizeof(status->gtk.key));
+		BUILD_BUG_ON(NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY +
+			     sizeof(v6->gtk.tkip_mic_key) >
+			     sizeof(status->gtk.key));
 
 		/* copy GTK info to the right place */
-		memcpy(status->gtk[0].key, v6->gtk.decrypt_key,
+		memcpy(status->gtk.key, v6->gtk.decrypt_key,
 		       sizeof(v6->gtk.decrypt_key));
-		memcpy(status->gtk[0].tkip_mic_key, v6->gtk.tkip_mic_key,
+		memcpy(status->gtk.key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+		       v6->gtk.tkip_mic_key,
 		       sizeof(v6->gtk.tkip_mic_key));
-		memcpy(&status->gtk[0].rsc, &v6->gtk.rsc,
-		       sizeof(status->gtk[0].rsc));
+
+		iwl_mvm_convert_key_counters(status, &v6->gtk.rsc.all_tsc_rsc);
 
 		/* hardcode the key length to 16 since v6 only supports 16 */
-		status->gtk[0].key_len = 16;
+		status->gtk.len = 16;
 
 		/*
 		 * The key index only uses 2 bits (values 0 to 3) and
 		 * we always set bit 7 which means this is the
 		 * currently used key.
 		 */
-		status->gtk[0].key_flags = v6->gtk.key_index | BIT(7);
+		status->gtk.flags = v6->gtk.key_index | BIT(7);
 	} else if (notif_ver == 7) {
 		struct iwl_wowlan_status_v7 *v7 = (void *)cmd.resp_pkt->data;
 
-		status = iwl_mvm_parse_wowlan_status_common_v7(mvm,
-							       cmd.resp_pkt->data,
-							       len);
+		status = iwl_mvm_parse_wowlan_status_common_v7(mvm, v7, len);
 		if (IS_ERR(status))
 			goto out_free_resp;
 
-		status->gtk[0] = v7->gtk[0];
-		status->igtk[0] = v7->igtk[0];
+		iwl_mvm_convert_key_counters(status, &v7->gtk[0].rsc.all_tsc_rsc);
+		iwl_mvm_convert_gtk(status, &v7->gtk[0]);
+		iwl_mvm_convert_igtk(status, &v7->igtk[0]);
 	} else if (notif_ver == 9 || notif_ver == 10 || notif_ver == 11) {
 		struct iwl_wowlan_status_v9 *v9 = (void *)cmd.resp_pkt->data;
 
 		/* these three command versions have same layout and size, the
 		 * difference is only in a few not used (reserved) fields.
 		 */
-		status = iwl_mvm_parse_wowlan_status_common_v9(mvm,
-							       cmd.resp_pkt->data,
-							       len);
+		status = iwl_mvm_parse_wowlan_status_common_v9(mvm, v9, len);
 		if (IS_ERR(status))
 			goto out_free_resp;
 
-		status->gtk[0] = v9->gtk[0];
-		status->igtk[0] = v9->igtk[0];
+		iwl_mvm_convert_key_counters(status, &v9->gtk[0].rsc.all_tsc_rsc);
+		iwl_mvm_convert_gtk(status, &v9->gtk[0]);
+		iwl_mvm_convert_igtk(status, &v9->igtk[0]);
 
 		status->tid_tear_down = v9->tid_tear_down;
 	} else {
@@ -1962,7 +2041,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 	return status;
 }
 
-static struct iwl_wowlan_status *
+static struct iwl_wowlan_status_data *
 iwl_mvm_get_wakeup_status(struct iwl_mvm *mvm, u8 sta_id)
 {
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
@@ -1987,29 +2066,17 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_wowlan_status_data status;
-	struct iwl_wowlan_status *fw_status;
+	struct iwl_wowlan_status_data *status;
 	int i;
 	bool keep;
 	struct iwl_mvm_sta *mvm_ap_sta;
 
-	fw_status = iwl_mvm_get_wakeup_status(mvm, mvmvif->ap_sta_id);
-	if (IS_ERR_OR_NULL(fw_status))
+	status = iwl_mvm_get_wakeup_status(mvm, mvmvif->ap_sta_id);
+	if (IS_ERR(status))
 		goto out_unlock;
 
 	IWL_DEBUG_WOWLAN(mvm, "wakeup reason 0x%x\n",
-			 le32_to_cpu(fw_status->wakeup_reasons));
-
-	status.pattern_number = le16_to_cpu(fw_status->pattern_number);
-	for (i = 0; i < 8; i++)
-		status.qos_seq_ctr[i] =
-			le16_to_cpu(fw_status->qos_seq_ctr[i]);
-	status.wakeup_reasons = le32_to_cpu(fw_status->wakeup_reasons);
-	status.wake_packet_length =
-		le32_to_cpu(fw_status->wake_packet_length);
-	status.wake_packet_bufsize =
-		le32_to_cpu(fw_status->wake_packet_bufsize);
-	status.wake_packet = fw_status->wake_packet;
+			 status->wakeup_reasons);
 
 	/* still at hard-coded place 0 for D3 image */
 	mvm_ap_sta = iwl_mvm_sta_from_staid_protected(mvm, 0);
@@ -2017,7 +2084,7 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 		goto out_free;
 
 	for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
-		u16 seq = status.qos_seq_ctr[i];
+		u16 seq = status->qos_seq_ctr[i];
 		/* firmware stores last-used value, we store next value */
 		seq += 0x10;
 		mvm_ap_sta->tid_data[i].seq_number = seq;
@@ -2033,15 +2100,15 @@ static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 	/* now we have all the data we need, unlock to avoid mac80211 issues */
 	mutex_unlock(&mvm->mutex);
 
-	iwl_mvm_report_wakeup_reasons(mvm, vif, &status);
+	iwl_mvm_report_wakeup_reasons(mvm, vif, status);
 
-	keep = iwl_mvm_setup_connection_keep(mvm, vif, fw_status);
+	keep = iwl_mvm_setup_connection_keep(mvm, vif, status);
 
-	kfree(fw_status);
+	kfree(status);
 	return keep;
 
 out_free:
-	kfree(fw_status);
+	kfree(status);
 out_unlock:
 	mutex_unlock(&mvm->mutex);
 	return false;
@@ -2165,16 +2232,16 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 		.pattern_idx = -1,
 	};
 	struct cfg80211_wowlan_wakeup *wakeup_report = &wakeup;
+	struct iwl_wowlan_status_data *status;
 	struct iwl_mvm_nd_query_results query;
-	struct iwl_wowlan_status *fw_status;
 	unsigned long matched_profiles;
 	u32 reasons = 0;
 	int i, n_matches, ret;
 
-	fw_status = iwl_mvm_get_wakeup_status(mvm, IWL_MVM_INVALID_STA);
-	if (!IS_ERR_OR_NULL(fw_status)) {
-		reasons = le32_to_cpu(fw_status->wakeup_reasons);
-		kfree(fw_status);
+	status = iwl_mvm_get_wakeup_status(mvm, IWL_MVM_INVALID_STA);
+	if (!IS_ERR(status)) {
+		reasons = status->wakeup_reasons;
+		kfree(status);
 	}
 
 	if (reasons & IWL_WOWLAN_WAKEUP_BY_RFKILL_DEASSERTED)
-- 
2.33.0

