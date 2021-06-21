Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5D13AE43F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 09:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhFUHkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 03:40:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48418 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229641AbhFUHkD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 03:40:03 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvEV8-001aFa-U2; Mon, 21 Jun 2021 10:37:48 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 21 Jun 2021 10:37:34 +0300
Message-Id: <iwlwifi.20210621103449.45218d913d07.I61a086936508230d86b454636945ceb0b9ea09fd@changeid>
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
Subject: [PATCH 3/9] iwlwifi: mvm: introduce iwl_wowlan_get_status_cmd
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We need to pass the station id to teach the firmware on which
station id we want to get the status.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  4 +++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 31 ++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index ea2bd34e32a3..b2e7ef3ddc88 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -496,6 +496,10 @@ struct iwl_wowlan_kek_kck_material_cmd_v4 {
 	__le32  bigtk_cipher;
 } __packed; /* KEK_KCK_MATERIAL_API_S_VER_4 */
 
+struct iwl_wowlan_get_status_cmd {
+	__le32  sta_id;
+} __packed; /* WOWLAN_GET_STATUSES_CMD_API_S_VER_1 */
+
 #define RF_KILL_INDICATOR_FOR_WOWLAN	0x87
 
 enum iwl_wowlan_rekey_status {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 0777a709740b..6a259d867d90 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1612,15 +1612,27 @@ iwl_mvm_parse_wowlan_status_common(v6)
 iwl_mvm_parse_wowlan_status_common(v7)
 iwl_mvm_parse_wowlan_status_common(v9)
 
-struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
+static struct iwl_wowlan_status *
+iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 {
 	struct iwl_wowlan_status *status;
+	struct iwl_wowlan_get_status_cmd get_status_cmd = {
+		.sta_id = cpu_to_le32(sta_id),
+	};
 	struct iwl_host_cmd cmd = {
 		.id = WOWLAN_GET_STATUSES,
 		.flags = CMD_WANT_SKB,
+		.data = { &get_status_cmd, },
+		.len = { sizeof(get_status_cmd), },
 	};
 	int ret, len;
 	u8 notif_ver;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					   WOWLAN_GET_STATUSES,
+					   IWL_FW_CMD_VER_UNKNOWN);
+
+	if (cmd_ver == IWL_FW_CMD_VER_UNKNOWN)
+		cmd.len[0] = 0;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1708,32 +1720,37 @@ struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm)
 }
 
 static struct iwl_wowlan_status *
-iwl_mvm_get_wakeup_status(struct iwl_mvm *mvm)
+iwl_mvm_get_wakeup_status(struct iwl_mvm *mvm, u8 sta_id)
 {
-	int ret;
+	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					   OFFLOADS_QUERY_CMD,
+					   IWL_FW_CMD_VER_UNKNOWN);
+	__le32 station_id = cpu_to_le32(sta_id);
+	u32 cmd_size = cmd_ver != IWL_FW_CMD_VER_UNKNOWN ? sizeof(station_id) : 0;
 
 	if (!mvm->net_detect) {
 		/* only for tracing for now */
 		int ret = iwl_mvm_send_cmd_pdu(mvm, OFFLOADS_QUERY_CMD, 0,
-					       0, NULL);
+					       cmd_size, &station_id);
 		if (ret)
 			IWL_ERR(mvm, "failed to query offload statistics (%d)\n", ret);
 	}
 
-	return iwl_mvm_send_wowlan_get_status(mvm);
+	return iwl_mvm_send_wowlan_get_status(mvm, sta_id);
 }
 
 /* releases the MVM mutex */
 static bool iwl_mvm_query_wakeup_reasons(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif)
 {
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_wowlan_status_data status;
 	struct iwl_wowlan_status *fw_status;
 	int i;
 	bool keep;
 	struct iwl_mvm_sta *mvm_ap_sta;
 
-	fw_status = iwl_mvm_get_wakeup_status(mvm);
+	fw_status = iwl_mvm_get_wakeup_status(mvm, mvmvif->ap_sta_id);
 	if (IS_ERR_OR_NULL(fw_status))
 		goto out_unlock;
 
@@ -1911,7 +1928,7 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 	u32 reasons = 0;
 	int i, n_matches, ret;
 
-	fw_status = iwl_mvm_get_wakeup_status(mvm);
+	fw_status = iwl_mvm_get_wakeup_status(mvm, IWL_MVM_INVALID_STA);
 	if (!IS_ERR_OR_NULL(fw_status)) {
 		reasons = le32_to_cpu(fw_status->wakeup_reasons);
 		kfree(fw_status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b0223f1c52f2..7be747738016 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1795,7 +1795,6 @@ void iwl_mvm_ipv6_addr_change(struct ieee80211_hw *hw,
 void iwl_mvm_set_default_unicast_key(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif, int idx);
 extern const struct file_operations iwl_dbgfs_d3_test_ops;
-struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm);
 #ifdef CONFIG_PM
 void iwl_mvm_set_last_nonqos_seq(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
-- 
2.32.0

