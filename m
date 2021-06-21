Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6312D3AE440
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFUHkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48412 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229789AbhFUHkC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEV7-001aFa-M1; Mon, 21 Jun 2021 10:37:47 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:33 +0300
Message-Id: <iwlwifi.20210621103449.13417410e9ea.I140c16e70f8ac91cec7e8189e182e2f672c39258@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621073740.1105911-1-luca@coelho.fi>
References: <20210621073740.1105911-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 2/9] iwlwifi: mvm: introduce iwl_wowlan_kek_kck_material_cmd_v4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to pass the station id to teach the firmware on which
station id we want to configure the key material.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 13 ++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 30 +++++++++++++------
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 4dbf24128a98..ea2bd34e32a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -483,6 +483,19 @@ struct iwl_wowlan_kek_kck_material_cmd_v3 {
 	__le32  bigtk_cipher;
 } __packed; /* KEK_KCK_MATERIAL_API_S_VER_3 */
 
+struct iwl_wowlan_kek_kck_material_cmd_v4 {
+	__le32  sta_id;
+	u8	kck[IWL_KCK_MAX_SIZE];
+	u8	kek[IWL_KEK_MAX_SIZE];
+	__le16	kck_len;
+	__le16	kek_len;
+	__le64	replay_ctr;
+	__le32  akm;
+	__le32  gtk_cipher;
+	__le32  igtk_cipher;
+	__le32  bigtk_cipher;
+} __packed; /* KEK_KCK_MATERIAL_API_S_VER_4 */
+
 #define RF_KILL_INDICATOR_FOR_WOWLAN	0x87
 
 enum iwl_wowlan_rekey_status {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 8e5814a3b178..0777a709740b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -104,7 +104,7 @@ static const u8 *iwl_mvm_find_max_pn(struct ieee80211_key_conf *key,
 struct wowlan_key_data {
 	struct iwl_wowlan_rsc_tsc_params_cmd *rsc_tsc;
 	struct iwl_wowlan_tkip_params_cmd *tkip;
-	struct iwl_wowlan_kek_kck_material_cmd_v3 *kek_kck_cmd;
+	struct iwl_wowlan_kek_kck_material_cmd_v4 *kek_kck_cmd;
 	bool error, use_rsc_tsc, use_tkip, configure_keys;
 	int wep_key_idx;
 };
@@ -716,7 +716,8 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
 					    u32 cmd_flags)
 {
-	struct iwl_wowlan_kek_kck_material_cmd_v3 kek_kck_cmd = {};
+	struct iwl_wowlan_kek_kck_material_cmd_v4 kek_kck_cmd = {};
+	struct iwl_wowlan_kek_kck_material_cmd_v4 *_kek_kck_cmd = &kek_kck_cmd;
 	struct iwl_wowlan_tkip_params_cmd tkip_cmd = {};
 	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
@@ -725,7 +726,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		.use_rsc_tsc = false,
 		.tkip = &tkip_cmd,
 		.use_tkip = false,
-		.kek_kck_cmd = &kek_kck_cmd,
+		.kek_kck_cmd = _kek_kck_cmd,
 	};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
@@ -819,13 +820,9 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 						IWL_ALWAYS_LONG_GROUP,
 						WOWLAN_KEK_KCK_MATERIAL,
 						IWL_FW_CMD_VER_UNKNOWN);
-		if (WARN_ON(cmd_ver != 2 && cmd_ver != 3 &&
+		if (WARN_ON(cmd_ver != 2 && cmd_ver != 3 && cmd_ver != 4 &&
 			    cmd_ver != IWL_FW_CMD_VER_UNKNOWN))
 			return -EINVAL;
-		if (cmd_ver == 3)
-			cmd_size = sizeof(struct iwl_wowlan_kek_kck_material_cmd_v3);
-		else
-			cmd_size = sizeof(struct iwl_wowlan_kek_kck_material_cmd_v2);
 
 		memcpy(kek_kck_cmd.kck, mvmvif->rekey_data.kck,
 		       mvmvif->rekey_data.kck_len);
@@ -835,6 +832,21 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		kek_kck_cmd.kek_len = cpu_to_le16(mvmvif->rekey_data.kek_len);
 		kek_kck_cmd.replay_ctr = mvmvif->rekey_data.replay_ctr;
 		kek_kck_cmd.akm = cpu_to_le32(mvmvif->rekey_data.akm);
+		kek_kck_cmd.sta_id = cpu_to_le32(mvmvif->ap_sta_id);
+
+		if (cmd_ver == 4) {
+			cmd_size = sizeof(struct iwl_wowlan_kek_kck_material_cmd_v4);
+		} else {
+			if (cmd_ver == 3)
+				cmd_size =
+					sizeof(struct iwl_wowlan_kek_kck_material_cmd_v3);
+			else
+				cmd_size =
+					sizeof(struct iwl_wowlan_kek_kck_material_cmd_v2);
+			/* skip the sta_id at the beginning */
+			_kek_kck_cmd = (void *)
+				((u8 *)_kek_kck_cmd) + sizeof(kek_kck_cmd.sta_id);
+		}
 
 		IWL_DEBUG_WOWLAN(mvm, "setting akm %d\n",
 				 mvmvif->rekey_data.akm);
@@ -842,7 +854,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WOWLAN_KEK_KCK_MATERIAL, cmd_flags,
 					   cmd_size,
-					   &kek_kck_cmd);
+					   _kek_kck_cmd);
 		if (ret)
 			goto out;
 	}
-- 
2.32.0

