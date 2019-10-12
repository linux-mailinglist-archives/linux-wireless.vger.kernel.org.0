Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78808D5102
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbfJLQ3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:29:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48782 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728338AbfJLQ3h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:29:37 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGs-00062r-SQ; Sat, 12 Oct 2019 19:29:35 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:18 +0300
Message-Id: <20191012192536.98a269a24f9e.Id7ec5e7b6c31f289b3c6803da3f88fdac09f4b14@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 07/13] iwlwifi: mvm: add notification for missed VAP
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lior Cohen <lior2.cohen@intel.com>

A missed VAP notification will be sent from umac when
the station is out of sync with its associated non-transmitted
BSSID. The notification will be sent only if the transmitted
BSSID is an EMA-AP one.

The driver will consider this notification as connection loss.

Signed-off-by: Lior Cohen <lior2.cohen@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 19 +++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 23 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 69786343aff4..e7a1acedbcf1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -77,6 +77,10 @@ enum iwl_mac_conf_subcmd_ids {
 	 * @CHANNEL_SWITCH_TIME_EVENT_CMD: &struct iwl_chan_switch_te_cmd
 	 */
 	CHANNEL_SWITCH_TIME_EVENT_CMD = 0x4,
+	/**
+	 * @MISSED_VAP_NOTIF: &struct iwl_missed_vap_notif
+	 */
+	MISSED_VAP_NOTIF = 0xFA,
 	/**
 	 * @SESSION_PROTECTION_CMD: &struct iwl_mvm_session_prot_cmd
 	 */
@@ -140,6 +144,21 @@ struct iwl_probe_resp_data_notif {
 	u8 reserved[3];
 } __packed; /* PROBE_RESPONSE_DATA_NTFY_API_S_VER_1 */
 
+/**
+ * struct iwl_missed_vap_notif - notification of missing vap detection
+ *
+ * @mac_id: the mac for which the ucode sends the notification for
+ * @num_beacon_intervals_elapsed: beacons elpased with no vap profile inside
+ * @profile_periodicity: beacons period to have our profile inside
+ * @reserved: reserved for alignment purposes
+ */
+struct iwl_missed_vap_notif {
+	__le32 mac_id;
+	u8 num_beacon_intervals_elapsed;
+	u8 profile_periodicity;
+	u8 reserved[2];
+} __packed; /* MISSED_VAP_NTFY_API_S_VER_1 */
+
 /**
  * struct iwl_channel_switch_noa_notif - Channel switch NOA notification
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 70bb150ee0ca..d9c23cd96336 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1610,3 +1610,26 @@ void iwl_mvm_channel_switch_noa_notif(struct iwl_mvm *mvm,
 out_unlock:
 	rcu_read_unlock();
 }
+
+void iwl_mvm_rx_missed_vap_notif(struct iwl_mvm *mvm,
+				 struct iwl_rx_cmd_buffer *rxb)
+{
+	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	struct iwl_missed_vap_notif *mb = (void *)pkt->data;
+	struct ieee80211_vif *vif;
+	u32 id = le32_to_cpu(mb->mac_id);
+
+	IWL_DEBUG_INFO(mvm,
+		       "missed_vap notify mac_id=%u, num_beacon_intervals_elapsed=%u, profile_periodicity=%u\n",
+		       le32_to_cpu(mb->mac_id),
+		       mb->num_beacon_intervals_elapsed,
+		       mb->profile_periodicity);
+
+	rcu_read_lock();
+
+	vif = iwl_mvm_rcu_dereference_vif_id(mvm, id, true);
+	if (vif)
+		iwl_mvm_connection_loss(mvm, vif, "missed vap beacon");
+
+	rcu_read_unlock();
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 43257579ab48..f0246969dca0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1680,6 +1680,8 @@ void iwl_mvm_mac_ctxt_recalc_tsf_id(struct iwl_mvm *mvm,
 				    struct ieee80211_vif *vif);
 void iwl_mvm_probe_resp_data_notif(struct iwl_mvm *mvm,
 				   struct iwl_rx_cmd_buffer *rxb);
+void iwl_mvm_rx_missed_vap_notif(struct iwl_mvm *mvm,
+				 struct iwl_rx_cmd_buffer *rxb);
 void iwl_mvm_channel_switch_noa_notif(struct iwl_mvm *mvm,
 				      struct iwl_rx_cmd_buffer *rxb);
 /* Bindings */
-- 
2.23.0

