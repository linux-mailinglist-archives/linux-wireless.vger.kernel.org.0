Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065542876D0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgJHPKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:10:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54544 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730650AbgJHPKR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:10:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYP-002Qut-1R; Thu, 08 Oct 2020 18:10:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:47 +0300
Message-Id: <iwlwifi.20201008180656.700e6e2e3077.Icdd807b6a3ad3fed806449ea0a13f856aa20e632@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008150949.331882-1-luca@coelho.fi>
References: <20201008150949.331882-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/13] iwlwifi: mvm: support ADD_STA_CMD_API_S ver 12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

ADD_STA_CMD_API_S ver 12 was added in order to properly support
auxiliary activities in CDB NICs. In the new version we don't need
to allocate an aux station at initialization, instead we add an
aux station only when an auxiliary activity that requires a dedicated Tx
queue is needed. For now the only case we need this kind of activity is
when using hot spot 2.0

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 40 +++++++++++++++----
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 14 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 37 +++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 19 +++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  6 +++
 7 files changed, 102 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index c010e6febbf4..d43e0d3f3a12 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -380,7 +380,7 @@ struct iwl_mvm_add_sta_cmd {
 	u8 add_modify;
 	u8 awake_acs;
 	__le16 tid_disable_tx;
-	__le32 mac_id_n_color;
+	__le32 mac_id_n_color;  /* can be used for lmac id when using cmd v12 */
 	u8 addr[ETH_ALEN];	/* _STA_ID_MODIFY_INFO_API_S_VER_1 */
 	__le16 reserved2;
 	u8 sta_id;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e665596a4d83..80b52010d47b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1491,10 +1491,23 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 			goto error;
 	}
 
-	/* Add auxiliary station for scanning */
-	ret = iwl_mvm_add_aux_sta(mvm);
-	if (ret)
-		goto error;
+	/*
+	 * Add auxiliary station for scanning.
+	 * Newer versions of this command implies that the fw uses
+	 * internal aux station for all aux activities that don't
+	 * requires a dedicated data queue.
+	 */
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+				  ADD_STA,
+				  0) < 12) {
+		 /*
+		  * In old version the aux station uses mac id like other
+		  * station and not lmac id
+		  */
+		ret = iwl_mvm_add_aux_sta(mvm, MAC_INDEX_AUX);
+		if (ret)
+			goto error;
+	}
 
 	/* Add all the PHY contexts */
 	i = 0;
@@ -1643,10 +1656,21 @@ int iwl_mvm_load_d3_fw(struct iwl_mvm *mvm)
 	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++)
 		RCU_INIT_POINTER(mvm->fw_id_to_mac_id[i], NULL);
 
-	/* Add auxiliary station for scanning */
-	ret = iwl_mvm_add_aux_sta(mvm);
-	if (ret)
-		goto error;
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+				  ADD_STA,
+				  0) < 12) {
+		/*
+		 * Add auxiliary station for scanning.
+		 * Newer versions of this command implies that the fw uses
+		 * internal aux station for all aux activities that don't
+		 * requires a dedicated data queue.
+		 * In old version the aux station uses mac id like other
+		 * station and not lmac id
+		 */
+		ret = iwl_mvm_add_aux_sta(mvm, MAC_INDEX_AUX);
+		if (ret)
+			goto error;
+	}
 
 	return 0;
  error:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 79770b78122d..27b2a68c97f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1223,7 +1223,8 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 
 	/* async_handlers_wk is now blocked */
 
-	iwl_mvm_rm_aux_sta(mvm);
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP, ADD_STA, 0) < 12)
+		iwl_mvm_rm_aux_sta(mvm);
 
 	iwl_mvm_stop_device(mvm);
 
@@ -3804,6 +3805,17 @@ static int iwl_mvm_roc(struct ieee80211_hw *hw,
 		if (fw_has_capa(&mvm->fw->ucode_capa,
 				IWL_UCODE_TLV_CAPA_HOTSPOT_SUPPORT)) {
 			/* Use aux roc framework (HS20) */
+			if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+						  ADD_STA, 0) >= 12) {
+				u32 lmac_id;
+
+				lmac_id = iwl_mvm_get_lmac_id(mvm->fw,
+							      channel->band);
+				ret = iwl_mvm_add_aux_sta(mvm, lmac_id);
+				if (WARN(ret,
+					 "Failed to allocate aux station"))
+					goto out_unlock;
+			}
 			ret = iwl_mvm_send_aux_roc_cmd(mvm, channel,
 						       vif, duration);
 			goto out_unlock;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 1fbb52713493..875281cf7fc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -698,14 +698,28 @@ static void iwl_mvm_scan_fill_tx_cmd(struct iwl_mvm *mvm,
 	tx_cmd[0].rate_n_flags = iwl_mvm_scan_rate_n_flags(mvm,
 							   NL80211_BAND_2GHZ,
 							   no_cck);
-	tx_cmd[0].sta_id = mvm->aux_sta.sta_id;
+
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+				  ADD_STA,
+				  0) < 12) {
+		tx_cmd[0].sta_id = mvm->aux_sta.sta_id;
+		tx_cmd[1].sta_id = mvm->aux_sta.sta_id;
+
+	/*
+	 * Fw doesn't use this sta anymore, pending deprecation via HOST API
+	 * change
+	 */
+	} else {
+		tx_cmd[0].sta_id = 0xff;
+		tx_cmd[1].sta_id = 0xff;
+	}
 
 	tx_cmd[1].tx_flags = cpu_to_le32(TX_CMD_FLG_SEQ_CTL |
 					 TX_CMD_FLG_BT_DIS);
+
 	tx_cmd[1].rate_n_flags = iwl_mvm_scan_rate_n_flags(mvm,
 							   NL80211_BAND_5GHZ,
 							   no_cck);
-	tx_cmd[1].sta_id = mvm->aux_sta.sta_id;
 }
 
 static void
@@ -1117,6 +1131,10 @@ static void iwl_mvm_fill_scan_config_v1(struct iwl_mvm *mvm, void *config,
 
 	memcpy(&cfg->mac_addr, &mvm->addresses[0].addr, ETH_ALEN);
 
+	/* This function should not be called when using ADD_STA ver >=12 */
+	WARN_ON_ONCE(iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					   ADD_STA, 0) >= 12);
+
 	cfg->bcast_sta_id = mvm->aux_sta.sta_id;
 	cfg->channel_flags = channel_flags;
 
@@ -1165,6 +1183,10 @@ static void iwl_mvm_fill_scan_config_v2(struct iwl_mvm *mvm, void *config,
 
 	memcpy(&cfg->mac_addr, &mvm->addresses[0].addr, ETH_ALEN);
 
+	/* This function should not be called when using ADD_STA ver >=12 */
+	WARN_ON_ONCE(iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					   ADD_STA, 0) >= 12);
+
 	cfg->bcast_sta_id = mvm->aux_sta.sta_id;
 	cfg->channel_flags = channel_flags;
 
@@ -1278,7 +1300,16 @@ int iwl_mvm_config_scan(struct iwl_mvm *mvm)
 
 	memset(&cfg, 0, sizeof(cfg));
 
-	cfg.bcast_sta_id = mvm->aux_sta.sta_id;
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+				  ADD_STA, 0) < 12)
+		cfg.bcast_sta_id = mvm->aux_sta.sta_id;
+	/*
+	 * Fw doesn't use this sta anymore, pending deprecation via HOST API
+	 * change.
+	 */
+	else
+		cfg.bcast_sta_id = 0xff;
+
 	cfg.tx_chains = cpu_to_le32(iwl_mvm_get_valid_tx_ant(mvm));
 	cfg.rx_chains = cpu_to_le32(iwl_mvm_scan_rx_ant(mvm));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 4b2dcd60d496..017537944fd0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1538,8 +1538,15 @@ static int iwl_mvm_add_int_sta_common(struct iwl_mvm *mvm,
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.sta_id = sta->sta_id;
-	cmd.mac_id_n_color = cpu_to_le32(FW_CMD_ID_AND_COLOR(mac_id,
-							     color));
+
+	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP, ADD_STA,
+				  0) >= 12 &&
+	    sta->type == IWL_STA_AUX_ACTIVITY)
+		cmd.mac_id_n_color = cpu_to_le32(mac_id);
+	else
+		cmd.mac_id_n_color = cpu_to_le32(FW_CMD_ID_AND_COLOR(mac_id,
+								     color));
+
 	if (fw_has_api(&mvm->fw->ucode_capa, IWL_UCODE_TLV_API_STA_TYPE))
 		cmd.station_type = sta->type;
 
@@ -2032,7 +2039,7 @@ static int iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
 	return 0;
 }
 
-int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm)
+int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
 {
 	int ret;
 
@@ -2045,7 +2052,11 @@ int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm)
 	if (ret)
 		return ret;
 
-	ret = iwl_mvm_add_int_sta_with_queue(mvm, MAC_INDEX_AUX, 0, NULL,
+	/*
+	 * In CDB NICs we need to specify which lmac to use for aux activity
+	 * using the mac_id argument place to send lmac_id to the function
+	 */
+	ret = iwl_mvm_add_int_sta_with_queue(mvm, lmac_id, 0, NULL,
 					     &mvm->aux_sta, &mvm->aux_queue,
 					     IWL_MVM_TX_FIFO_MCAST);
 	if (ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 7b4120ce208c..d7578c981a65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -540,7 +540,7 @@ int iwl_mvm_sta_tx_agg_flush(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 int iwl_mvm_sta_tx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 		       int tid, u8 queue, bool start);
 
-int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm);
+int iwl_mvm_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id);
 int iwl_mvm_rm_aux_sta(struct iwl_mvm *mvm);
 
 int iwl_mvm_alloc_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
@@ -582,5 +582,4 @@ void iwl_mvm_add_new_dqa_stream_wk(struct work_struct *wk);
 int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 struct iwl_mvm_int_sta *sta, u8 *addr, u32 cipher,
 			 u8 *key, u32 key_len);
-
 #endif /* __sta_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 3a57a260081a..7ad6c9ab4737 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -134,6 +134,12 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 	} else {
 		/* do the same in case of hot spot 2.0 */
 		iwl_mvm_flush_sta(mvm, &mvm->aux_sta, true);
+		/* In newer version of this command an aux station is added only
+		 * in cases of dedicated tx queue and need to be removed in end
+		 * of use */
+		if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					  ADD_STA, 0) >= 12)
+			iwl_mvm_rm_aux_sta(mvm);
 	}
 
 	mutex_unlock(&mvm->mutex);
-- 
2.28.0

