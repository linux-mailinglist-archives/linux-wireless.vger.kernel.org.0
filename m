Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852EA3E1279
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240230AbhHEKT7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:19:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51230 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240203AbhHEKT6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:58 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTV-00240Q-BY; Thu, 05 Aug 2021 13:19:43 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:28 +0300
Message-Id: <iwlwifi.20210805130823.28cd065e8c4a.Ic8406a78ee46b07e0ca1b8199522ef08ec6eef53@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805101934.431479-1-luca@coelho.fi>
References: <20210805101934.431479-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 06/12] iwlwifi: mvm: d3: implement RSC command version 5
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In later firmware we haven't needed the TSC anyway since
we have it already (and firmware image doesn't change),
but the new version adds the ability to send down replay
counters for more than one GTK. Implement that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   3 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 196 ++++++++++++++++--
 3 files changed, 191 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index ce060c3dfd7b..ee6b5844a871 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -550,7 +550,8 @@ enum iwl_legacy_cmds {
 	WOWLAN_CONFIGURATION = 0xe1,
 
 	/**
-	 * @WOWLAN_TSC_RSC_PARAM: &struct iwl_wowlan_rsc_tsc_params_cmd
+	 * @WOWLAN_TSC_RSC_PARAM: &struct iwl_wowlan_rsc_tsc_params_cmd_v4,
+	 *	&struct iwl_wowlan_rsc_tsc_params_cmd
 	 */
 	WOWLAN_TSC_RSC_PARAM = 0xe2,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index b2e7ef3ddc88..3ec82cae3981 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -6,6 +6,7 @@
  */
 #ifndef __iwl_fw_api_d3_h__
 #define __iwl_fw_api_d3_h__
+#include <iwl-trans.h>
 
 /**
  * enum iwl_d0i3_flags - d0i3 flags
@@ -389,11 +390,14 @@ struct iwl_wowlan_config_cmd {
 	u8 reserved;
 } __packed; /* WOWLAN_CONFIG_API_S_VER_5 */
 
+#define IWL_NUM_RSC	16
+#define WOWLAN_KEY_MAX_SIZE	32
+#define WOWLAN_GTK_KEYS_NUM     2
+#define WOWLAN_IGTK_KEYS_NUM	2
+
 /*
  * WOWLAN_TSC_RSC_PARAMS
  */
-#define IWL_NUM_RSC	16
-
 struct tkip_sc {
 	__le16 iv16;
 	__le16 pad;
@@ -425,11 +429,19 @@ struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 {
 	union iwl_all_tsc_rsc all_tsc_rsc;
 } __packed; /* ALL_TSC_RSC_API_S_VER_2 */
 
-struct iwl_wowlan_rsc_tsc_params_cmd {
+struct iwl_wowlan_rsc_tsc_params_cmd_v4 {
 	struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 params;
 	__le32 sta_id;
 } __packed; /* ALL_TSC_RSC_API_S_VER_4 */
 
+struct iwl_wowlan_rsc_tsc_params_cmd {
+	__le64 ucast_rsc[IWL_MAX_TID_COUNT];
+	__le64 mcast_rsc[WOWLAN_GTK_KEYS_NUM][IWL_MAX_TID_COUNT];
+	__le32 sta_id;
+#define IWL_MCAST_KEY_MAP_INVALID	0xff
+	u8 mcast_key_id_map[4];
+} __packed; /* ALL_TSC_RSC_API_S_VER_5 */
+
 #define IWL_MIC_KEY_SIZE	8
 struct iwl_mic_keys {
 	u8 tx[IWL_MIC_KEY_SIZE];
@@ -541,10 +553,6 @@ struct iwl_wowlan_gtk_status_v1 {
 	struct iwl_wowlan_rsc_tsc_params_cmd_ver_2 rsc;
 } __packed; /* WOWLAN_GTK_MATERIAL_VER_1 */
 
-#define WOWLAN_KEY_MAX_SIZE	32
-#define WOWLAN_GTK_KEYS_NUM     2
-#define WOWLAN_IGTK_KEYS_NUM	2
-
 /**
  * struct iwl_wowlan_gtk_status - GTK status
  * @key: GTK material
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index ad7308cc4b7f..00403b337060 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -211,7 +211,7 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 }
 
 struct wowlan_key_rsc_tsc_data {
-	struct iwl_wowlan_rsc_tsc_params_cmd *rsc_tsc;
+	struct iwl_wowlan_rsc_tsc_params_cmd_v4 *rsc_tsc;
 	bool have_rsc_tsc;
 };
 
@@ -327,6 +327,127 @@ static void iwl_mvm_wowlan_get_rsc_tsc_data(struct ieee80211_hw *hw,
 	}
 }
 
+struct wowlan_key_rsc_v5_data {
+	struct iwl_wowlan_rsc_tsc_params_cmd *rsc;
+	bool have_rsc;
+	int gtks;
+	int gtk_ids[4];
+};
+
+static void iwl_mvm_wowlan_get_rsc_v5_data(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_sta *sta,
+					   struct ieee80211_key_conf *key,
+					   void *_data)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+	struct wowlan_key_rsc_v5_data *data = _data;
+	struct ieee80211_key_seq seq;
+	__le64 *rsc;
+	int i;
+
+	/* only for ciphers that can be PTK/GTK */
+	switch (key->cipher) {
+	default:
+		return;
+	case WLAN_CIPHER_SUITE_TKIP:
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		break;
+	}
+
+	if (sta) {
+		rsc = data->rsc->ucast_rsc;
+	} else {
+		if (WARN_ON(data->gtks > ARRAY_SIZE(data->gtk_ids)))
+			return;
+		data->gtk_ids[data->gtks] = key->keyidx;
+		rsc = data->rsc->mcast_rsc[data->gtks % 2];
+		if (WARN_ON(key->keyidx >
+				ARRAY_SIZE(data->rsc->mcast_key_id_map)))
+			return;
+		data->rsc->mcast_key_id_map[key->keyidx] = data->gtks % 2;
+		if (data->gtks >= 2) {
+			int prev = data->gtks - 2;
+			int prev_idx = data->gtk_ids[prev];
+
+			data->rsc->mcast_key_id_map[prev_idx] =
+				IWL_MCAST_KEY_MAP_INVALID;
+		}
+		data->gtks++;
+	}
+
+	switch (key->cipher) {
+	default:
+		WARN_ON(1);
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+
+		/*
+		 * For non-QoS this relies on the fact that both the uCode and
+		 * mac80211 use TID 0 (as they need to to avoid replay attacks)
+		 * for checking the IV in the frames.
+		 */
+		for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
+			ieee80211_get_key_rx_seq(key, i, &seq);
+
+			rsc[i] = cpu_to_le64(((u64)seq.tkip.iv32 << 16) |
+					     seq.tkip.iv16);
+		}
+
+		data->have_rsc = true;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		/*
+		 * For non-QoS this relies on the fact that both the uCode and
+		 * mac80211/our RX code use TID 0 for checking the PN.
+		 */
+		if (sta) {
+			struct iwl_mvm_sta *mvmsta;
+			struct iwl_mvm_key_pn *ptk_pn;
+			const u8 *pn;
+
+			mvmsta = iwl_mvm_sta_from_mac80211(sta);
+			rcu_read_lock();
+			ptk_pn = rcu_dereference(mvmsta->ptk_pn[key->keyidx]);
+			if (WARN_ON(!ptk_pn)) {
+				rcu_read_unlock();
+				break;
+			}
+
+			for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
+				pn = iwl_mvm_find_max_pn(key, ptk_pn, &seq, i,
+						mvm->trans->num_rx_queues);
+				rsc[i] = cpu_to_le64((u64)pn[5] |
+						     ((u64)pn[4] << 8) |
+						     ((u64)pn[3] << 16) |
+						     ((u64)pn[2] << 24) |
+						     ((u64)pn[1] << 32) |
+						     ((u64)pn[0] << 40));
+			}
+
+			rcu_read_unlock();
+		} else {
+			for (i = 0; i < IWL_MAX_TID_COUNT; i++) {
+				u8 *pn = seq.ccmp.pn;
+
+				ieee80211_get_key_rx_seq(key, i, &seq);
+				rsc[i] = cpu_to_le64((u64)pn[5] |
+						     ((u64)pn[4] << 8) |
+						     ((u64)pn[3] << 16) |
+						     ((u64)pn[2] << 24) |
+						     ((u64)pn[1] << 32) |
+						     ((u64)pn[0] << 40));
+			}
+		}
+		data->have_rsc = true;
+		break;
+	}
+}
+
 static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif)
 {
@@ -334,35 +455,66 @@ static int iwl_mvm_wowlan_config_rsc_tsc(struct iwl_mvm *mvm,
 	int ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
 					WOWLAN_TSC_RSC_PARAM,
 					IWL_FW_CMD_VER_UNKNOWN);
-	struct wowlan_key_rsc_tsc_data data = {};
-	int size;
 	int ret;
 
-	data.rsc_tsc = kzalloc(sizeof(*data.rsc_tsc), GFP_KERNEL);
-	if (!data.rsc_tsc)
-		return -ENOMEM;
+	if (ver == 5) {
+		struct wowlan_key_rsc_v5_data data = {};
+		int i;
+
+		data.rsc = kmalloc(sizeof(*data.rsc), GFP_KERNEL);
+		if (!data.rsc)
+			return -ENOMEM;
+
+		memset(data.rsc, 0xff, sizeof(*data.rsc));
+
+		for (i = 0; i < ARRAY_SIZE(data.rsc->mcast_key_id_map); i++)
+			data.rsc->mcast_key_id_map[i] =
+				IWL_MCAST_KEY_MAP_INVALID;
+		data.rsc->sta_id = cpu_to_le32(mvmvif->ap_sta_id);
+
+		ieee80211_iter_keys(mvm->hw, vif,
+				    iwl_mvm_wowlan_get_rsc_v5_data,
+				    &data);
+
+		if (data.have_rsc)
+			ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
+						   CMD_ASYNC, sizeof(*data.rsc),
+						   data.rsc);
+		else
+			ret = 0;
+		kfree(data.rsc);
+	} else if (ver == 4 || ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN) {
+		struct wowlan_key_rsc_tsc_data data = {};
+		int size;
 
-	if (ver == 4) {
-		size = sizeof(*data.rsc_tsc);
-		data.rsc_tsc->sta_id = cpu_to_le32(mvmvif->ap_sta_id);
-	} else if (ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN) {
-		size = sizeof(data.rsc_tsc->params);
+		data.rsc_tsc = kzalloc(sizeof(*data.rsc_tsc), GFP_KERNEL);
+		if (!data.rsc_tsc)
+			return -ENOMEM;
+
+		if (ver == 4) {
+			size = sizeof(*data.rsc_tsc);
+			data.rsc_tsc->sta_id = cpu_to_le32(mvmvif->ap_sta_id);
+		} else {
+			/* ver == 2 || ver == IWL_FW_CMD_VER_UNKNOWN */
+			size = sizeof(data.rsc_tsc->params);
+		}
+
+		ieee80211_iter_keys(mvm->hw, vif,
+				    iwl_mvm_wowlan_get_rsc_tsc_data,
+				    &data);
+
+		if (data.have_rsc_tsc)
+			ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
+						   CMD_ASYNC, size,
+						   data.rsc_tsc);
+		else
+			ret = 0;
+		kfree(data.rsc_tsc);
 	} else {
 		ret = 0;
 		WARN_ON_ONCE(1);
-		goto out;
 	}
 
-	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_get_rsc_tsc_data,
-			    &data);
-
-	if (data.have_rsc_tsc)
-		ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_TSC_RSC_PARAM,
-					   CMD_ASYNC, size, data.rsc_tsc);
-	else
-		ret = 0;
-out:
-	kfree(data.rsc_tsc);
 	return ret;
 }
 
-- 
2.32.0

