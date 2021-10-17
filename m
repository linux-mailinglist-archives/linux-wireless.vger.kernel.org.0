Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECC430989
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbhJQOCQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 10:02:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53958 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343802AbhJQOCP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 10:02:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc6hk-000Yi6-9S; Sun, 17 Oct 2021 17:00:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 16:59:49 +0300
Message-Id: <iwlwifi.20211017165728.a1825bbba397.I10315577fb41dfcec15c92e8f6785d9655f74c6a@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017135954.504836-1-luca@coelho.fi>
References: <20211017135954.504836-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/10] iwlwifi: mvm: set BT-coex high priority for 802.1X/4-way-HS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Set BT coex high priority during the 802.1X handshake to avoid
issues where BT is active enough to kill all the big negotiation
frames that we may need to send (e.g. with a large certificate),
leading to the connection not being established correctly. Give
WiFi priority over BT during this short but critical phase.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h   | 3 +++
 drivers/net/wireless/intel/iwlwifi/fw/file.h      | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 8 ++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 2 ++
 5 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 7be7715b431d..11f0bd283e49 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -138,6 +138,8 @@ struct iwl_mac_data_ibss {
  * @FLEXIBLE_TWT_SUPPORTED: AP supports flexible TWT schedule
  * @PROTECTED_TWT_SUPPORTED: AP supports protected TWT frames (with 11w)
  * @BROADCAST_TWT_SUPPORTED: AP and STA support broadcast TWT
+ * @COEX_HIGH_PRIORITY_ENABLE: high priority mode for BT coex, to be used
+ *	during 802.1X negotiation (and allowed during 4-way-HS)
  */
 enum iwl_mac_data_policy {
 	TWT_SUPPORTED = BIT(0),
@@ -145,6 +147,7 @@ enum iwl_mac_data_policy {
 	FLEXIBLE_TWT_SUPPORTED = BIT(2),
 	PROTECTED_TWT_SUPPORTED = BIT(3),
 	BROADCAST_TWT_SUPPORTED = BIT(4),
+	COEX_HIGH_PRIORITY_ENABLE = BIT(5),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index c65196daf55b..565918054ed1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -420,6 +420,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_PASSIVE_6GHZ_SCAN		= (__force iwl_ucode_tlv_capa_t)58,
 	IWL_UCODE_TLV_CAPA_HIDDEN_6GHZ_SCAN		= (__force iwl_ucode_tlv_capa_t)59,
 	IWL_UCODE_TLV_CAPA_BROADCAST_TWT		= (__force iwl_ucode_tlv_capa_t)60,
+	IWL_UCODE_TLV_CAPA_COEX_HIGH_PRIO		= (__force iwl_ucode_tlv_capa_t)61,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index e31d81a40339..cfb69e49a687 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -604,6 +604,12 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 
 		ctxt_sta->is_assoc = cpu_to_le32(1);
 
+		if (!mvmvif->authorized &&
+		    fw_has_capa(&mvm->fw->ucode_capa,
+				IWL_UCODE_TLV_CAPA_COEX_HIGH_PRIO))
+			ctxt_sta->data_policy |=
+				cpu_to_le32(COEX_HIGH_PRIORITY_ENABLE);
+
 		/*
 		 * allow multicast data frames only as long as the station is
 		 * authorized, i.e., GTK keys are already installed (if needed)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index adca7c78b815..5277f63dac3d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3201,6 +3201,8 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			/* enable beacon filtering */
 			WARN_ON(iwl_mvm_enable_beacon_filter(mvm, vif, 0));
 
+			mvmvif->authorized = 1;
+
 			/*
 			 * Now that the station is authorized, i.e., keys were already
 			 * installed, need to indicate to the FW that
@@ -3217,6 +3219,12 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 			/* Multicast data frames are no longer allowed */
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 
+			/*
+			 * Set this after the above iwl_mvm_mac_ctxt_changed()
+			 * to avoid sending high prio again for a little time.
+			 */
+			mvmvif->authorized = 0;
+
 			/* disable beacon filtering */
 			ret = iwl_mvm_disable_beacon_filter(mvm, vif, 0);
 			WARN_ON(ret &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index cc11961b0d83..4277536e31c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -297,6 +297,7 @@ struct iwl_probe_resp_data {
  *	see enum &iwl_mvm_low_latency_cause for causes.
  * @low_latency_actual: boolean, indicates low latency is set,
  *	as a result from low_latency bit flags and takes force into account.
+ * @authorized: indicates the AP station was set to authorized
  * @ps_disabled: indicates that this interface requires PS to be disabled
  * @queue_params: QoS params for this MAC
  * @bcast_sta: station used for broadcast packets. Used by the following
@@ -330,6 +331,7 @@ struct iwl_mvm_vif {
 	bool monitor_active;
 	u8 low_latency: 6;
 	u8 low_latency_actual: 1;
+	u8 authorized:1;
 	bool ps_disabled;
 	struct iwl_mvm_vif_bf_data bf_data;
 
-- 
2.33.0

