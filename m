Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7927AAA6
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgI1JXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 05:23:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52762 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726566AbgI1JXb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 05:23:31 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kMpNZ-002KgD-0S; Mon, 28 Sep 2020 12:23:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 28 Sep 2020 12:23:15 +0300
Message-Id: <iwlwifi.20200928121852.6ec5889d793d.I32ad41a27f046a4047cf852c83936142fca4f20b@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928092321.649185-1-luca@coelho.fi>
References: <20200928092321.649185-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/12] iwlwifi: mvm: support new KEK KCK api
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Nathan Errera <nathan.errera@intel.com>

Add a new version to iwl_wowlan_kek_kck_material_cmd
struct to support akm and send the new cmd if supported.

Signed-off-by: Nathan Errera <nathan.errera@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h | 14 +++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    | 17 +++++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 9525843efb8d..cc7f89905222 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -493,7 +493,7 @@ struct iwl_wowlan_tkip_params_cmd {
 #define IWL_KCK_MAX_SIZE	32
 #define IWL_KEK_MAX_SIZE	32
 
-struct iwl_wowlan_kek_kck_material_cmd {
+struct iwl_wowlan_kek_kck_material_cmd_v2 {
 	u8	kck[IWL_KCK_MAX_SIZE];
 	u8	kek[IWL_KEK_MAX_SIZE];
 	__le16	kck_len;
@@ -501,6 +501,18 @@ struct iwl_wowlan_kek_kck_material_cmd {
 	__le64	replay_ctr;
 } __packed; /* KEK_KCK_MATERIAL_API_S_VER_2 */
 
+struct iwl_wowlan_kek_kck_material_cmd_v3 {
+	u8	kck[IWL_KCK_MAX_SIZE];
+	u8	kek[IWL_KEK_MAX_SIZE];
+	__le16	kck_len;
+	__le16	kek_len;
+	__le64	replay_ctr;
+	__le32  akm;
+	__le32  gtk_cipher;
+	__le32  igtk_cipher;
+	__le32  bigtk_cipher;
+} __packed; /* KEK_KCK_MATERIAL_API_S_VER_3 */
+
 #define RF_KILL_INDICATOR_FOR_WOWLAN	0x87
 
 enum iwl_wowlan_rekey_status {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d7e887264976..3a1e5ac46ea0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -70,6 +70,7 @@
 #include "iwl-modparams.h"
 #include "fw-api.h"
 #include "mvm.h"
+#include "fw/img.h"
 
 void iwl_mvm_set_rekey_data(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
@@ -739,7 +740,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
 					    u32 cmd_flags)
 {
-	struct iwl_wowlan_kek_kck_material_cmd kek_kck_cmd = {};
+	struct iwl_wowlan_kek_kck_material_cmd_v3 kek_kck_cmd = {};
 	struct iwl_wowlan_tkip_params_cmd tkip_cmd = {};
 	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
@@ -751,6 +752,8 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
+	u8 cmd_ver;
+	size_t cmd_size;
 
 	key_data.rsc_tsc = kzalloc(sizeof(*key_data.rsc_tsc), GFP_KERNEL);
 	if (!key_data.rsc_tsc)
@@ -833,6 +836,16 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 
 	/* configure rekey data only if offloaded rekey is supported (d3) */
 	if (mvmvif->rekey_data.valid) {
+		cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+						WOWLAN_KEK_KCK_MATERIAL);
+		if (WARN_ON(cmd_ver != 2 && cmd_ver != 3 &&
+			    cmd_ver != IWL_FW_CMD_VER_UNKNOWN))
+			return -EINVAL;
+		if (cmd_ver == 3)
+			cmd_size = sizeof(struct iwl_wowlan_kek_kck_material_cmd_v3);
+		else
+			cmd_size = sizeof(struct iwl_wowlan_kek_kck_material_cmd_v2);
+
 		memset(&kek_kck_cmd, 0, sizeof(kek_kck_cmd));
 		memcpy(kek_kck_cmd.kck, mvmvif->rekey_data.kck,
 		       NL80211_KCK_LEN);
@@ -844,7 +857,7 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 
 		ret = iwl_mvm_send_cmd_pdu(mvm,
 					   WOWLAN_KEK_KCK_MATERIAL, cmd_flags,
-					   sizeof(kek_kck_cmd),
+					   cmd_size,
 					   &kek_kck_cmd);
 		if (ret)
 			goto out;
-- 
2.28.0

