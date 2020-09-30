Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EB327E9FB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgI3Nbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 09:31:31 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53302 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728149AbgI3Nba (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 09:31:30 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNcCe-002MJ5-9v; Wed, 30 Sep 2020 16:31:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 16:31:13 +0300
Message-Id: <iwlwifi.20200930161256.1c7a59fd3164.I68005f0015ad04e53d0239e2d2ee85d5ffdeaa37@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930133123.924256-1-luca@coelho.fi>
References: <20200930133123.924256-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: mvm: location: set the HLTK when PASN station is added
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When a PASN station is added, set the HLTK to FW.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-responder.c         | 43 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 15 +++++++
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index e24e5bc7b40c..e940ef138f55 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -306,6 +306,16 @@ iwl_mvm_ftm_responder_dyn_cfg_cmd(struct iwl_mvm *mvm,
 	return ret;
 }
 
+static void iwl_mvm_resp_del_pasn_sta(struct iwl_mvm *mvm,
+				      struct ieee80211_vif *vif,
+				      struct iwl_mvm_pasn_sta *sta)
+{
+	list_del(&sta->list);
+	iwl_mvm_rm_sta_id(mvm, vif, sta->int_sta.sta_id);
+	iwl_mvm_dealloc_int_sta(mvm, &sta->int_sta);
+	kfree(sta);
+}
+
 int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      u8 *addr, u32 cipher, u8 *tk, u32 tk_len,
@@ -313,9 +323,26 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 {
 	int ret;
 	struct iwl_mvm_pasn_sta *sta;
+	struct iwl_mvm_pasn_hltk_data hltk_data = {
+		.addr = addr,
+		.hltk = hltk,
+	};
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LOCATION_GROUP,
+					   TOF_RESPONDER_DYN_CONFIG_CMD, 2);
 
 	lockdep_assert_held(&mvm->mutex);
 
+	if (cmd_ver < 3) {
+		IWL_ERR(mvm, "Adding PASN station not supported by FW\n");
+		return -ENOTSUPP;
+	}
+
+	hltk_data.cipher = iwl_mvm_cipher_to_location_cipher(cipher);
+	if (hltk_data.cipher == IWL_LOCATION_CIPHER_INVALID) {
+		IWL_ERR(mvm, "invalid cipher: %u\n", cipher);
+		return -EINVAL;
+	}
+
 	sta = kmalloc(sizeof(*sta), GFP_KERNEL);
 	if (!sta)
 		return -ENOBUFS;
@@ -327,23 +354,17 @@ int iwl_mvm_ftm_respoder_add_pasn_sta(struct iwl_mvm *mvm,
 		return ret;
 	}
 
-	// TODO: set the HLTK to fw
+	ret = iwl_mvm_ftm_responder_dyn_cfg_v3(mvm, vif, NULL, &hltk_data);
+	if (ret) {
+		iwl_mvm_resp_del_pasn_sta(mvm, vif, sta);
+		return ret;
+	}
 
 	memcpy(sta->addr, addr, ETH_ALEN);
 	list_add_tail(&sta->list, &mvm->resp_pasn_list);
 	return 0;
 }
 
-static void iwl_mvm_resp_del_pasn_sta(struct iwl_mvm *mvm,
-				      struct ieee80211_vif *vif,
-				      struct iwl_mvm_pasn_sta *sta)
-{
-	list_del(&sta->list);
-	iwl_mvm_rm_sta_id(mvm, vif, sta->int_sta.sta_id);
-	iwl_mvm_dealloc_int_sta(mvm, &sta->int_sta);
-	kfree(sta);
-}
-
 int iwl_mvm_ftm_resp_remove_pasn_sta(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif, u8 *addr)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ba1b74d10577..40e102f2017f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2161,4 +2161,19 @@ static inline int iwl_umac_scan_get_max_profiles(const struct iwl_fw *fw)
 	return (ver == IWL_FW_CMD_VER_UNKNOWN || ver < 3) ?
 		IWL_SCAN_MAX_PROFILES : IWL_SCAN_MAX_PROFILES_V2;
 }
+
+static inline
+enum iwl_location_cipher iwl_mvm_cipher_to_location_cipher(u32 cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_CCMP:
+		return IWL_LOCATION_CIPHER_CCMP_128;
+	case WLAN_CIPHER_SUITE_GCMP:
+		return IWL_LOCATION_CIPHER_GCMP_128;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		return IWL_LOCATION_CIPHER_GCMP_256;
+	default:
+		return IWL_LOCATION_CIPHER_INVALID;
+	}
+}
 #endif /* __IWL_MVM_H__ */
-- 
2.28.0

