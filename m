Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD35E279394
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgIYVbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52362 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728969AbgIYVbI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvJ2-002J1P-95; Sat, 26 Sep 2020 00:31:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:48 +0300
Message-Id: <iwlwifi.20200926002540.8c621903db59.I1cc7afedc0ff2009fe1abf007684339f299b73aa@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/15] iwlwifi: mvm: add support for new WOWLAN_TSC_RSC_PARAM version
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dan Halperin <Dan1.Halperin@intel.com>

- Change the iwl_all_tsc_rsc struct to hold a sta_id (__le32) field,
  while preserving the union, used in the older version.
- Adjust the use of this command according to the TLV.

Signed-off-by: Dan Halperin <Dan1.Halperin@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 11 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 41 +++++++++++++++----
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index c44384be75ad..9525843efb8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -451,10 +451,15 @@ union iwl_all_tsc_rsc {
 	struct iwl_aes_rsc_tsc aes;
 }; /* ALL_TSC_RSC_API_S_VER_2 */
 
-struct iwl_wowlan_rsc_tsc_params_cmd {
+struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 {
 	union iwl_all_tsc_rsc all_tsc_rsc;
 } __packed; /* ALL_TSC_RSC_API_S_VER_2 */
 
+struct iwl_wowlan_rsc_tsc_params_cmd {
+	struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 params;
+	__le32 sta_id;
+} __packed; /* ALL_TSC_RSC_API_S_VER_4 */
+
 #define IWL_MIC_KEY_SIZE	8
 struct iwl_mic_keys {
 	u8 tx[IWL_MIC_KEY_SIZE];
@@ -534,7 +539,7 @@ struct iwl_wowlan_gtk_status_v1 {
 	u8 reserved[3];
 	u8 decrypt_key[16];
 	u8 tkip_mic_key[8];
-	struct iwl_wowlan_rsc_tsc_params_cmd rsc;
+	struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 rsc;
 } __packed; /* WOWLAN_GTK_MATERIAL_VER_1 */
 
 #define WOWLAN_KEY_MAX_SIZE	32
@@ -559,7 +564,7 @@ struct iwl_wowlan_gtk_status {
 	u8 key_flags;
 	u8 reserved[2];
 	u8 tkip_mic_key[8];
-	struct iwl_wowlan_rsc_tsc_params_cmd rsc;
+	struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 rsc;
 } __packed; /* WOWLAN_GTK_MATERIAL_VER_2 */
 
 #define IWL_WOWLAN_GTK_IDX_MASK		(BIT(0) | BIT(1))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 081d35497ccb..d7e887264976 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -245,8 +245,10 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		if (sta) {
 			u64 pn64;
 
-			tkip_sc = data->rsc_tsc->all_tsc_rsc.tkip.unicast_rsc;
-			tkip_tx_sc = &data->rsc_tsc->all_tsc_rsc.tkip.tsc;
+			tkip_sc =
+			   data->rsc_tsc->params.all_tsc_rsc.tkip.unicast_rsc;
+			tkip_tx_sc =
+				&data->rsc_tsc->params.all_tsc_rsc.tkip.tsc;
 
 			rx_p1ks = data->tkip->rx_uni;
 
@@ -265,7 +267,7 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 			rx_mic_key = data->tkip->mic_keys.rx_unicast;
 		} else {
 			tkip_sc =
-				data->rsc_tsc->all_tsc_rsc.tkip.multicast_rsc;
+			  data->rsc_tsc->params.all_tsc_rsc.tkip.multicast_rsc;
 			rx_p1ks = data->tkip->rx_multi;
 			rx_mic_key = data->tkip->mic_keys.rx_mcast;
 		}
@@ -302,13 +304,16 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		if (sta) {
 			u64 pn64;
 
-			aes_sc = data->rsc_tsc->all_tsc_rsc.aes.unicast_rsc;
-			aes_tx_sc = &data->rsc_tsc->all_tsc_rsc.aes.tsc;
+			aes_sc =
+			   data->rsc_tsc->params.all_tsc_rsc.aes.unicast_rsc;
+			aes_tx_sc =
+				&data->rsc_tsc->params.all_tsc_rsc.aes.tsc;
 
 			pn64 = atomic64_read(&key->tx_pn);
 			aes_tx_sc->pn = cpu_to_le64(pn64);
 		} else {
-			aes_sc = data->rsc_tsc->all_tsc_rsc.aes.multicast_rsc;
+			aes_sc =
+			   data->rsc_tsc->params.all_tsc_rsc.aes.multicast_rsc;
 		}
 
 		/*
@@ -772,10 +777,28 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	}
 
 	if (key_data.use_rsc_tsc) {
-		ret = iwl_mvm_send_cmd_pdu(mvm,
-					   WOWLAN_TSC_RSC_PARAM, cmd_flags,
-					   sizeof(*key_data.rsc_tsc),
+		int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+						WOWLAN_TSC_RSC_PARAM);
+		int size;
+
+		if (ver == 4) {
+			size = sizeof(*key_data.rsc_tsc);
+			key_data.rsc_tsc->sta_id =
+				cpu_to_le32(mvmvif->ap_sta_id);
+
+		} else if (ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN) {
+			size = sizeof(key_data.rsc_tsc->params);
+		} else {
+			ret = 0;
+			WARN_ON_ONCE(1);
+			goto out;
+		}
+
+		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
+					   cmd_flags,
+					   size,
 					   key_data.rsc_tsc);
+
 		if (ret)
 			goto out;
 	}
-- 
2.28.0

