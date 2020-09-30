Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D327EEDD
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgI3QUI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:20:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53416 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731214AbgI3QUI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:20:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNepo-002MPc-HQ; Wed, 30 Sep 2020 19:20:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:50 +0300
Message-Id: <iwlwifi.20200930191738.b7098f097a5c.I4ae1c5b2186b0e04702233a7a7068d69cfd3361a@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930161959.983283-1-luca@coelho.fi>
References: <20200930161959.983283-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/12] iwlwifi: mvm: d3: parse wowlan status version 11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The firmware is being updated to report version 11 of this
response in order to include BIGTK material. Parse it, but
for now keep the existing behaviour of disconnecting on any
rekeying with even IGTK presence, need to fix that before
BIGTK can be supported.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  42 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 133 +++++++++++-------
 2 files changed, 119 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index cc7f89905222..5db301a6a312 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -661,7 +661,7 @@ struct iwl_wowlan_status_v7 {
 } __packed; /* WOWLAN_STATUSES_API_S_VER_7 */
 
 /**
- * struct iwl_wowlan_status - WoWLAN status
+ * struct iwl_wowlan_status_v9 - WoWLAN status (version 9)
  * @gtk: GTK data
  * @igtk: IGTK data
  * @replay_ctr: GTK rekey replay counter
@@ -679,7 +679,7 @@ struct iwl_wowlan_status_v7 {
  * @reserved: unused
  * @wake_packet: wakeup packet
  */
-struct iwl_wowlan_status {
+struct iwl_wowlan_status_v9 {
 	struct iwl_wowlan_gtk_status gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
@@ -697,6 +697,44 @@ struct iwl_wowlan_status {
 	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
 } __packed; /* WOWLAN_STATUSES_API_S_VER_9 */
 
+/**
+ * struct iwl_wowlan_status - WoWLAN status
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @bigtk: BIGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched pattern
+ * @non_qos_seq_ctr: non-QoS sequence counter to use next
+ * @qos_seq_ctr: QoS sequence counters to use next
+ * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
+ * @num_of_gtk_rekeys: number of GTK rekeys
+ * @tid_tear_down: bitmap of TIDs torn down
+ * @reserved: reserved
+ * @received_beacons: number of received beacons
+ * @wake_packet_length: wakeup packet length
+ * @wake_packet_bufsize: wakeup packet buffer size
+ * @tid_tear_down: bit mask of tids whose BA sessions were closed
+ *		   in suspend state
+ * @wake_packet: wakeup packet
+ */
+struct iwl_wowlan_status {
+	struct iwl_wowlan_gtk_status gtk[1];
+	struct iwl_wowlan_igtk_status igtk[1];
+	struct iwl_wowlan_igtk_status bigtk[WOWLAN_IGTK_KEYS_NUM];
+	__le64 replay_ctr;
+	__le16 pattern_number;
+	__le16 non_qos_seq_ctr;
+	__le16 qos_seq_ctr[8];
+	__le32 wakeup_reasons;
+	__le32 num_of_gtk_rekeys;
+	u8 tid_tear_down;
+	u8 reserved[3];
+	__le32 received_beacons;
+	__le32 wake_packet_length;
+	__le32 wake_packet_bufsize;
+	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
+} __packed; /* WOWLAN_STATUSES_API_S_VER_11 */
+
 static inline u8 iwlmvm_wowlan_gtk_idx(struct iwl_wowlan_gtk_status *gtk)
 {
 	return gtk->key_flags & IWL_WOWLAN_GTK_IDX_MASK;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 20c30a6be259..e47c0be28656 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1610,15 +1610,60 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	return true;
 }
 
+/* Occasionally, templates would be nice. This is one of those times ... */
+#define iwl_mvm_parse_wowlan_status_common(_ver)			\
+static struct iwl_wowlan_status *					\
+iwl_mvm_parse_wowlan_status_common_ ## _ver(struct iwl_mvm *mvm,	\
+					    void *_data, int len)	\
+{									\
+	struct iwl_wowlan_status *status;				\
+	struct iwl_wowlan_status_ ##_ver *data = _data;			\
+	int data_size;							\
+									\
+	if (len < sizeof(*data)) {					\
+		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");	\
+		return ERR_PTR(-EIO);					\
+	}								\
+									\
+	data_size = ALIGN(le32_to_cpu(data->wake_packet_bufsize), 4);	\
+	if (len != sizeof(*data) + data_size) {				\
+		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");	\
+		return ERR_PTR(-EIO);					\
+	}								\
+									\
+	status = kzalloc(sizeof(*status) + data_size, GFP_KERNEL);	\
+	if (!status)							\
+		return ERR_PTR(-ENOMEM);				\
+									\
+	/* copy all the common fields */				\
+	status->replay_ctr = data->replay_ctr;				\
+	status->pattern_number = data->pattern_number;			\
+	status->non_qos_seq_ctr = data->non_qos_seq_ctr;		\
+	memcpy(status->qos_seq_ctr, data->qos_seq_ctr,			\
+	       sizeof(status->qos_seq_ctr));				\
+	status->wakeup_reasons = data->wakeup_reasons;			\
+	status->num_of_gtk_rekeys = data->num_of_gtk_rekeys;		\
+	status->received_beacons = data->received_beacons;		\
+	status->wake_packet_length = data->wake_packet_length;		\
+	status->wake_packet_bufsize = data->wake_packet_bufsize;	\
+	memcpy(status->wake_packet, data->wake_packet,			\
+	       le32_to_cpu(status->wake_packet_bufsize));		\
+									\
+	return status;							\
+}
+
+iwl_mvm_parse_wowlan_status_common(v6)
+iwl_mvm_parse_wowlan_status_common(v7)
+iwl_mvm_parse_wowlan_status_common(v9)
+
 struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 {
-	struct iwl_wowlan_status_v7 *v7;
 	struct iwl_wowlan_status *status;
 	struct iwl_host_cmd cmd = {
 		.id = WOWLAN_GET_STATUSES,
 		.flags = CMD_WANT_SKB,
 	};
-	int ret, len, status_size, data_size;
+	int ret, len;
 	u8 notif_ver;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -1630,28 +1675,19 @@ struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 	}
 
 	len = iwl_rx_packet_payload_len(cmd.resp_pkt);
+
+	/* default to 7 (when we have IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL) */
+	notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+					    WOWLAN_GET_STATUSES, 7);
+
 	if (!fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL)) {
 		struct iwl_wowlan_status_v6 *v6 = (void *)cmd.resp_pkt->data;
 
-		status_size = sizeof(*v6);
-
-		if (len < status_size) {
-			IWL_ERR(mvm, "Invalid WoWLAN status response!\n");
-			status = ERR_PTR(-EIO);
-			goto out_free_resp;
-		}
-
-		data_size = ALIGN(le32_to_cpu(v6->wake_packet_bufsize), 4);
-
-		if (len != (status_size + data_size)) {
-			IWL_ERR(mvm, "Invalid WoWLAN status response!\n");
-			status = ERR_PTR(-EIO);
-			goto out_free_resp;
-		}
-
-		status = kzalloc(sizeof(*status) + data_size, GFP_KERNEL);
-		if (!status)
+		status = iwl_mvm_parse_wowlan_status_common_v6(mvm,
+							       cmd.resp_pkt->data,
+							       len);
+		if (IS_ERR(status))
 			goto out_free_resp;
 
 		BUILD_BUG_ON(sizeof(v6->gtk.decrypt_key) >
@@ -1676,48 +1712,37 @@ struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 		 * currently used key.
 		 */
 		status->gtk[0].key_flags = v6->gtk.key_index | BIT(7);
+	} else if (notif_ver == 7) {
+		struct iwl_wowlan_status_v7 *v7 = (void *)cmd.resp_pkt->data;
 
-		status->replay_ctr = v6->replay_ctr;
-
-		/* everything starting from pattern_number is identical */
-		memcpy(&status->pattern_number, &v6->pattern_number,
-		       offsetof(struct iwl_wowlan_status, wake_packet) -
-		       offsetof(struct iwl_wowlan_status, pattern_number) +
-		       data_size);
-
-		goto out_free_resp;
-	}
+		status = iwl_mvm_parse_wowlan_status_common_v7(mvm,
+							       cmd.resp_pkt->data,
+							       len);
+		if (IS_ERR(status))
+			goto out_free_resp;
 
-	v7 = (void *)cmd.resp_pkt->data;
-	notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
-					    WOWLAN_GET_STATUSES, 0);
+		status->gtk[0] = v7->gtk[0];
+		status->igtk[0] = v7->igtk[0];
+	} else if (notif_ver == 9) {
+		struct iwl_wowlan_status_v9 *v9 = (void *)cmd.resp_pkt->data;
 
-	status_size = sizeof(*status);
+		status = iwl_mvm_parse_wowlan_status_common_v9(mvm,
+							       cmd.resp_pkt->data,
+							       len);
+		if (IS_ERR(status))
+			goto out_free_resp;
 
-	/* only ver 9 has a different size */
-	if (notif_ver == IWL_FW_CMD_VER_UNKNOWN || notif_ver != 9)
-		status_size = sizeof(*v7);
+		status->gtk[0] = v9->gtk[0];
+		status->igtk[0] = v9->igtk[0];
 
-	if (len < status_size) {
-		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");
-		status = ERR_PTR(-EIO);
-		goto out_free_resp;
-	}
-	data_size = ALIGN(le32_to_cpu(v7->wake_packet_bufsize), 4);
-
-	if (len != (status_size + data_size)) {
-		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");
+		status->tid_tear_down = v9->tid_tear_down;
+	} else {
+		IWL_ERR(mvm,
+			"Firmware advertises unknown WoWLAN status response %d!\n",
+			notif_ver);
 		status = ERR_PTR(-EIO);
-		goto out_free_resp;
 	}
 
-	status = kzalloc(sizeof(*status) + data_size, GFP_KERNEL);
-	if (!status)
-		goto out_free_resp;
-
-	memcpy(status, v7, status_size);
-	memcpy(status->wake_packet, (u8 *)v7 + status_size, data_size);
-
 out_free_resp:
 	iwl_free_resp(&cmd);
 	return status;
-- 
2.28.0

