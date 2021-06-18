Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36D93AC5AB
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhFRIF3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:05:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48066 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232801AbhFRIDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:03:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lu9RN-001YIf-65; Fri, 18 Jun 2021 11:01:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 11:01:14 +0300
Message-Id: <iwlwifi.20210618105614.dd25dd667798.I8db9adcdbb133304b58cf417f8698611138c83b4@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618080121.588233-1-luca@coelho.fi>
References: <20210618080121.588233-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 03/10] iwlwifi: support ver 6 of WOWLAN_CONFIGURATION and ver 10 of WOWLAN_GET_STATUSES
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Naftali Goldstein <naftali.goldstein@intel.com>

These two version updates deprecate the need to set/get the nonqos sequence
counter during suspend/resume flow respectively; NICs supporting this
version maintain this counter internally and don't lose it during the
suspend/resume flow.

Note that this means that for such NICs the NON_QOS_TX_COUNTER_CMD is no
longer ever sent.

Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 12 +++++----
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 26 ++++++++++++-------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 6488c0f8b471..5373182c1364 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -339,9 +339,10 @@ enum iwl_wowlan_flags {
 };
 
 /**
- * struct iwl_wowlan_config_cmd - WoWLAN configuration
+ * struct iwl_wowlan_config_cmd - WoWLAN configuration (versions 5 and 6)
  * @wakeup_filter: filter from &enum iwl_wowlan_wakeup_filters
- * @non_qos_seq: non-QoS sequence counter to use next
+ * @non_qos_seq: non-QoS sequence counter to use next.
+ *               Reserved if the struct has version >= 6.
  * @qos_seq: QoS sequence counters to use next
  * @wowlan_ba_teardown_tids: bitmap of BA sessions to tear down
  * @is_11n_connection: indicates HT connection
@@ -604,12 +605,13 @@ struct iwl_wowlan_status_v7 {
 } __packed; /* WOWLAN_STATUSES_API_S_VER_7 */
 
 /**
- * struct iwl_wowlan_status_v9 - WoWLAN status (version 9)
+ * struct iwl_wowlan_status_v9 - WoWLAN status (versions 9 and 10)
  * @gtk: GTK data
  * @igtk: IGTK data
  * @replay_ctr: GTK rekey replay counter
  * @pattern_number: number of the matched pattern
- * @non_qos_seq_ctr: non-QoS sequence counter to use next
+ * @non_qos_seq_ctr: non-QoS sequence counter to use next.
+ *                   Reserved if the struct has version >= 10.
  * @qos_seq_ctr: QoS sequence counters to use next
  * @wakeup_reasons: wakeup reasons, see &enum iwl_wowlan_wakeup_reason
  * @num_of_gtk_rekeys: number of GTK rekeys
@@ -638,7 +640,7 @@ struct iwl_wowlan_status_v9 {
 	u8 tid_tear_down;
 	u8 reserved[3];
 	u8 wake_packet[]; /* can be truncated from _length to _bufsize */
-} __packed; /* WOWLAN_STATUSES_API_S_VER_9 */
+} __packed; /* WOWLAN_STATUSES_RSP_API_S_VER_9 */
 
 /**
  * struct iwl_wowlan_status - WoWLAN status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 2e28cf299ef4..e86f0e949b86 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -636,7 +636,6 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 			  struct ieee80211_vif *vif, struct iwl_mvm_vif *mvmvif,
 			  struct ieee80211_sta *ap_sta)
 {
-	int ret;
 	struct iwl_mvm_sta *mvm_ap_sta = iwl_mvm_sta_from_mac80211(ap_sta);
 
 	/* TODO: wowlan_config_cmd->wowlan_ba_teardown_tids */
@@ -646,12 +645,16 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 	wowlan_config_cmd->flags = ENABLE_L3_FILTERING |
 		ENABLE_NBNS_FILTERING | ENABLE_DHCP_FILTERING;
 
-	/* Query the last used seqno and set it */
-	ret = iwl_mvm_get_last_nonqos_seq(mvm, vif);
-	if (ret < 0)
-		return ret;
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+				  WOWLAN_CONFIGURATION, 0) < 6) {
+		/* Query the last used seqno and set it */
+		int ret = iwl_mvm_get_last_nonqos_seq(mvm, vif);
+
+		if (ret < 0)
+			return ret;
 
-	wowlan_config_cmd->non_qos_seq = cpu_to_le16(ret);
+		wowlan_config_cmd->non_qos_seq = cpu_to_le16(ret);
+	}
 
 	iwl_mvm_set_wowlan_qos_seq(mvm_ap_sta, wowlan_config_cmd);
 
@@ -1534,9 +1537,12 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	}
 
 out:
-	mvmvif->seqno_valid = true;
-	/* +0x10 because the set API expects next-to-use, not last-used */
-	mvmvif->seqno = le16_to_cpu(status->non_qos_seq_ctr) + 0x10;
+	if (iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
+				    WOWLAN_GET_STATUSES, 0) < 10) {
+		mvmvif->seqno_valid = true;
+		/* +0x10 because the set API expects next-to-use, not last-used */
+		mvmvif->seqno = le16_to_cpu(status->non_qos_seq_ctr) + 0x10;
+	}
 
 	return true;
 }
@@ -1654,7 +1660,7 @@ struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 
 		status->gtk[0] = v7->gtk[0];
 		status->igtk[0] = v7->igtk[0];
-	} else if (notif_ver == 9) {
+	} else if (notif_ver == 9 || notif_ver == 10) {
 		struct iwl_wowlan_status_v9 *v9 = (void *)cmd.resp_pkt->data;
 
 		status = iwl_mvm_parse_wowlan_status_common_v9(mvm,
-- 
2.32.0

