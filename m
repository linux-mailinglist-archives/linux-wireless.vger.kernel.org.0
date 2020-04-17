Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5BE1ADAE0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgDQKV4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:21:56 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56588 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728346AbgDQKVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:21:55 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO88-000Kba-Qv; Fri, 17 Apr 2020 13:21:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:37 +0300
Message-Id: <iwlwifi.20200417131727.b02153b94c1d.Ieb6291586d60f372d5a505604b18227ef97e7202@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417102142.2173014-1-luca@coelho.fi>
References: <20200417102142.2173014-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/10] iwlwifi: support version 9 of WOWLAN_GET_STATUS notification
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Add support for the new WOWLAN_GET_STATUS notification that contains a
new element that informs the driver of TIDs whose BA sessions were
closed during suspend.

Note that the new functionality of handling these closed sessions is not
implemented in this patch it.  It only aligns to the new API version.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 39 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 29 +++++++++-----
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 3643b6ba6385..c4562e1f8d18 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -618,7 +618,7 @@ struct iwl_wowlan_status_v6 {
  * @wake_packet_bufsize: wakeup packet buffer size
  * @wake_packet: wakeup packet
  */
-struct iwl_wowlan_status {
+struct iwl_wowlan_status_v7 {
 	struct iwl_wowlan_gtk_status gtk[WOWLAN_GTK_KEYS_NUM];
 	struct iwl_wowlan_igtk_status igtk[WOWLAN_IGTK_KEYS_NUM];
 	__le64 replay_ctr;
@@ -634,6 +634,43 @@ struct iwl_wowlan_status {
 	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
 } __packed; /* WOWLAN_STATUSES_API_S_VER_7 */
 
+/**
+ * struct iwl_wowlan_status - WoWLAN status
+ * @gtk: GTK data
+ * @igtk: IGTK data
+ * @replay_ctr: GTK rekey replay counter
+ * @pattern_number: number of the matched pattern
+ * @non_qos_seq_ctr: non-QoS sequence counter to use next
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
+struct iwl_wowlan_status {
+	struct iwl_wowlan_gtk_status gtk[WOWLAN_GTK_KEYS_NUM];
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
+} __packed; /* WOWLAN_STATUSES_API_S_VER_9 */
+
 static inline u8 iwlmvm_wowlan_gtk_idx(struct iwl_wowlan_gtk_status *gtk)
 {
 	return gtk->key_flags & IWL_WOWLAN_GTK_IDX_MASK;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 122ca7624073..222775714859 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1517,12 +1517,14 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 {
-	struct iwl_wowlan_status *v7, *status;
+	struct iwl_wowlan_status_v7 *v7;
+	struct iwl_wowlan_status *status;
 	struct iwl_host_cmd cmd = {
 		.id = WOWLAN_GET_STATUSES,
 		.flags = CMD_WANT_SKB,
 	};
-	int ret, len, status_size;
+	int ret, len, status_size, data_size;
+	u8 notif_ver;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1532,13 +1534,12 @@ struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 		return ERR_PTR(ret);
 	}
 
+	len = iwl_rx_packet_payload_len(cmd.resp_pkt);
 	if (!fw_has_api(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL)) {
 		struct iwl_wowlan_status_v6 *v6 = (void *)cmd.resp_pkt->data;
-		int data_size;
 
 		status_size = sizeof(*v6);
-		len = iwl_rx_packet_payload_len(cmd.resp_pkt);
 
 		if (len < status_size) {
 			IWL_ERR(mvm, "Invalid WoWLAN status response!\n");
@@ -1593,23 +1594,33 @@ struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 	}
 
 	v7 = (void *)cmd.resp_pkt->data;
-	status_size = sizeof(*v7);
-	len = iwl_rx_packet_payload_len(cmd.resp_pkt);
+	notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+					    WOWLAN_GET_STATUSES, 0);
+
+	status_size = sizeof(*status);
+
+	if (notif_ver == IWL_FW_CMD_VER_UNKNOWN || notif_ver < 9)
+		status_size = sizeof(*v7);
 
 	if (len < status_size) {
 		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");
 		status = ERR_PTR(-EIO);
 		goto out_free_resp;
 	}
+	data_size = ALIGN(le32_to_cpu(v7->wake_packet_bufsize), 4);
 
-	if (len != (status_size +
-		    ALIGN(le32_to_cpu(v7->wake_packet_bufsize), 4))) {
+	if (len != (status_size + data_size)) {
 		IWL_ERR(mvm, "Invalid WoWLAN status response!\n");
 		status = ERR_PTR(-EIO);
 		goto out_free_resp;
 	}
 
-	status = kmemdup(v7, len, GFP_KERNEL);
+	status = kzalloc(sizeof(*status) + data_size, GFP_KERNEL);
+	if (!status)
+		goto out_free_resp;
+
+	memcpy(status, v7, status_size);
+	memcpy(status->wake_packet, (u8 *)v7 + status_size, data_size);
 
 out_free_resp:
 	iwl_free_resp(&cmd);
-- 
2.25.1

