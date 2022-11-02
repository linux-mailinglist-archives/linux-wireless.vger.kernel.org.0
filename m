Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4741661657A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKBPA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Nov 2022 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiKBPA6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Nov 2022 11:00:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCC6572
        for <linux-wireless@vger.kernel.org>; Wed,  2 Nov 2022 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667401254; x=1698937254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t24P7qyQ80m54ibMmlmRnnhyAeLJphpQp0eExAYvK8M=;
  b=DJlzYHdFg8F44nM5t5Cc7Z1iyZUnFOpo/90Onc0+c7kdrF/3bKWTp5JI
   wNCut5SRg2EMZNQltb8Y9U7jylGwkkJJ/Q+hhZuIPdUGRNxTRotmjcso0
   Ba9Ohd6zoBoSNJ/qaqxvTRnbAno78JWDa++QQdB/G7mZQwF9PrtpbPZxT
   51feqBKXXn4qfNsWfhT+4BLr1OmmKKEWnElU1Jqmg16USTj9/TfuP/xqX
   WeyMtOrfPTENl/abEaXmr8aXOrwG0l7EHtG70YZwDLYJGUlIVDsJufaTC
   LabRUUZ4dRO890JSdFxyx5gsXCQrH69w3lTLjnUvF3/lgwplNezl0/Qmv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371523479"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371523479"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="636810555"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="636810555"
Received: from apetrush-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.180.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:00:44 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/11] wifi: iwlwifi: mvm: support new key API
Date:   Wed,  2 Nov 2022 16:59:53 +0200
Message-Id: <20221102165239.ed9ccd814abc.Iacc7360de68807fbac19e5b67c86504b39cc15df@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102145958.342864-1-gregory.greenman@intel.com>
References: <20221102145958.342864-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In order to support MLD, the key API is also changing to have
station masks instead of just the station ID etc. Change the
driver to support this, and add the new code in a new file so
it's more clearly separated.

For now this isn't separated at the mac80211 ops level, which
we wanted to do, but we're calling these functions in a place
when pre-start keys are installed in iwl_mvm_start_ap_ibss(),
and the function has some glue logic to mac80211. We may want
to change that later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  79 ++++++
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  17 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 226 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  12 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   3 +
 7 files changed, 337 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index 43619acc29fd..d07982d8c897 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -71,6 +71,11 @@ enum iwl_data_path_subcmd_ids {
 	 */
 	SCD_QUEUE_CONFIG_CMD = 0x17,
 
+	/**
+	 * @SEC_KEY_CMD: security key command, uses &struct iwl_sec_key_cmd
+	 */
+	SEC_KEY_CMD = 0x18,
+
 	/**
 	 * @MONITOR_NOTIF: Datapath monitoring notification, using
 	 *	&struct iwl_datapath_monitor_notif
@@ -403,4 +408,78 @@ struct iwl_scd_queue_cfg_cmd {
 	} __packed u; /* TX_QUEUE_CFG_CMD_OPERATION_API_U_VER_1 */
 } __packed; /* TX_QUEUE_CFG_CMD_API_S_VER_3 */
 
+/**
+ * enum iwl_sec_key_flags - security key command key flags
+ * @IWL_SEC_KEY_FLAG_CIPHER_MASK: cipher mask
+ * @IWL_SEC_KEY_FLAG_CIPHER_WEP: WEP cipher
+ * @IWL_SEC_KEY_FLAG_CIPHER_CCMP: CCMP/CMAC cipher
+ * @IWL_SEC_KEY_FLAG_CIPHER_TKIP: TKIP cipher
+ * @IWL_SEC_KEY_FLAG_CIPHER_GCMP: GCMP/GMAC cipher
+ * @IWL_SEC_KEY_FLAG_NO_TX: don't install for TX
+ * @IWL_SEC_KEY_FLAG_KEY_SIZE: large key size (WEP-104, GCMP-256, GMAC-256)
+ * @IWL_SEC_KEY_FLAG_MFP: MFP is in used for this key
+ * @IWL_SEC_KEY_FLAG_MCAST_KEY: this is a multicast key
+ * @IWL_SEC_KEY_FLAG_SPP_AMSDU: SPP A-MSDU should be used
+ */
+enum iwl_sec_key_flags {
+	IWL_SEC_KEY_FLAG_CIPHER_MASK	= 0x07,
+	IWL_SEC_KEY_FLAG_CIPHER_WEP	= 0x01,
+	IWL_SEC_KEY_FLAG_CIPHER_CCMP	= 0x02,
+	IWL_SEC_KEY_FLAG_CIPHER_TKIP	= 0x03,
+	IWL_SEC_KEY_FLAG_CIPHER_GCMP	= 0x05,
+	IWL_SEC_KEY_FLAG_NO_TX		= 0x08,
+	IWL_SEC_KEY_FLAG_KEY_SIZE	= 0x10,
+	IWL_SEC_KEY_FLAG_MFP		= 0x20,
+	IWL_SEC_KEY_FLAG_MCAST_KEY	= 0x40,
+	IWL_SEC_KEY_FLAG_SPP_AMSDU	= 0x80,
+};
+
+#define IWL_SEC_WEP_KEY_OFFSET	3
+
+/**
+ * struct iwl_sec_key_cmd - security key command
+ * @action: action from &enum iwl_ctxt_action
+ * @u.add.sta_mask: station mask for the new key
+ * @u.add.key_id: key ID (0-7) for the new key
+ * @u.add.key_flags: key flags per &enum iwl_sec_key_flags
+ * @u.add.key: key material. WEP keys should start from &IWL_SEC_WEP_KEY_OFFSET.
+ * @u.add.tkip_mic_rx_key: TKIP MIC RX key
+ * @u.add.tkip_mic_tx_key: TKIP MIC TX key
+ * @u.add.rx_seq: RX sequence counter value
+ * @u.add.tx_seq: TX sequence counter value
+ * @u.modify.old_sta_mask: old station mask
+ * @u.modify.new_sta_mask: new station mask
+ * @u.modify.key_id: key ID
+ * @u.modify.key_flags: new key flags
+ * @u.remove.sta_mask: station mask
+ * @u.remove.key_id: key ID
+ * @u.remove.key_flags: key flags
+ */
+struct iwl_sec_key_cmd {
+	__le32 action;
+	union {
+		struct {
+			__le32 sta_mask;
+			__le32 key_id;
+			__le32 key_flags;
+			u8 key[32];
+			u8 tkip_mic_rx_key[8];
+			u8 tkip_mic_tx_key[8];
+			__le64 rx_seq;
+			__le64 tx_seq;
+		} __packed add; /* SEC_KEY_ADD_CMD_API_S_VER_1 */
+		struct {
+			__le32 old_sta_mask;
+			__le32 new_sta_mask;
+			__le32 key_id;
+			__le32 key_flags;
+		} __packed modify; /* SEC_KEY_MODIFY_CMD_API_S_VER_1 */
+		struct {
+			__le32 sta_mask;
+			__le32 key_id;
+			__le32 key_flags;
+		} __packed remove; /* SEC_KEY_REMOVE_CMD_API_S_VER_1 */
+	} __packed u; /* SEC_KEY_OPERATION_API_U_VER_1 */
+} __packed; /* SEC_KEY_CMD_API_S_VER_1 */
+
 #endif /* __iwl_fw_api_datapath_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
index 11e814b7cad0..b28fcf0cf9cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/Makefile
@@ -7,6 +7,7 @@ iwlmvm-y += power.o coex.o
 iwlmvm-y += tt.o offloading.o tdls.o
 iwlmvm-y += ftm-responder.o ftm-initiator.o
 iwlmvm-y += rfi.o
+iwlmvm-y += mld-key.o
 iwlmvm-$(CONFIG_IWLWIFI_DEBUGFS) += debugfs.o debugfs-vif.o
 iwlmvm-$(CONFIG_IWLWIFI_LEDS) += led.o
 iwlmvm-$(CONFIG_PM) += d3.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 156283237e2a..e923e9a75c92 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2306,6 +2306,9 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 			 */
 			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
 				      &mvm->status)) {
+				/* first remove remaining keys */
+				iwl_mvm_sec_key_remove_ap(mvm, vif);
+
 				/*
 				 * Remove AP station now that
 				 * the MAC is unassoc
@@ -3464,6 +3467,8 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	struct iwl_mvm_sta *mvmsta = NULL;
 	struct iwl_mvm_key_pn *ptk_pn;
 	int keyidx = key->keyidx;
+	u32 sec_key_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
+	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
 	int ret, i;
 	u8 key_offset;
 
@@ -3603,7 +3608,12 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			mvmsta->pairwise_cipher = key->cipher;
 
 		IWL_DEBUG_MAC80211(mvm, "set hwcrypto key\n");
-		ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, key_offset);
+
+		if (sec_key_ver)
+			ret = iwl_mvm_sec_key_add(mvm, vif, sta, key);
+		else
+			ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, key_offset);
+
 		if (ret) {
 			IWL_WARN(mvm, "set key failed\n");
 			key->hw_key_idx = STA_KEY_IDX_INVALID;
@@ -3656,7 +3666,10 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		}
 
 		IWL_DEBUG_MAC80211(mvm, "disable hwcrypto key\n");
-		ret = iwl_mvm_remove_sta_key(mvm, vif, sta, key);
+		if (sec_key_ver)
+			ret = iwl_mvm_sec_key_del(mvm, vif, sta, key);
+		else
+			ret = iwl_mvm_remove_sta_key(mvm, vif, sta, key);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
new file mode 100644
index 000000000000..e27c893502f7
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2022 Intel Corporation
+ */
+#include <linux/kernel.h>
+#include <net/mac80211.h>
+#include "mvm.h"
+#include "fw/api/context.h"
+#include "fw/api/datapath.h"
+
+static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct ieee80211_key_conf *keyconf)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (vif->type == NL80211_IFTYPE_AP &&
+	    !(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		return BIT(mvmvif->mcast_sta.sta_id);
+
+	if (sta) {
+		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
+		return BIT(mvmsta->sta_id);
+	}
+
+	if (vif->type == NL80211_IFTYPE_STATION &&
+	    mvmvif->ap_sta_id != IWL_MVM_INVALID_STA)
+		return BIT(mvmvif->ap_sta_id);
+
+	/* invalid */
+	return 0;
+}
+
+static u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 struct ieee80211_key_conf *keyconf)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	u32 flags = 0;
+
+	if (!(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+		flags |= IWL_SEC_KEY_FLAG_MCAST_KEY;
+
+	switch (keyconf->cipher) {
+	case WLAN_CIPHER_SUITE_WEP104:
+		flags |= IWL_SEC_KEY_FLAG_KEY_SIZE;
+		fallthrough;
+	case WLAN_CIPHER_SUITE_WEP40:
+		flags |= IWL_SEC_KEY_FLAG_CIPHER_WEP;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		flags |= IWL_SEC_KEY_FLAG_CIPHER_TKIP;
+		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+	case WLAN_CIPHER_SUITE_CCMP:
+		flags |= IWL_SEC_KEY_FLAG_CIPHER_CCMP;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		flags |= IWL_SEC_KEY_FLAG_KEY_SIZE;
+		fallthrough;
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		flags |= IWL_SEC_KEY_FLAG_CIPHER_GCMP;
+		break;
+	}
+
+	rcu_read_lock();
+	if (!sta && vif->type == NL80211_IFTYPE_STATION &&
+	    mvmvif->ap_sta_id != IWL_MVM_INVALID_STA) {
+		u8 sta_id = mvmvif->ap_sta_id;
+
+		sta = rcu_dereference_check(mvm->fw_id_to_mac_id[sta_id],
+					    lockdep_is_held(&mvm->mutex));
+	}
+
+	if (!IS_ERR_OR_NULL(sta) && sta->mfp)
+		flags |= IWL_SEC_KEY_FLAG_MFP;
+	rcu_read_unlock();
+
+	return flags;
+}
+
+static int __iwl_mvm_sec_key_del(struct iwl_mvm *mvm, u32 sta_mask,
+				 u32 key_flags, u32 keyidx, u32 flags)
+{
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
+	struct iwl_sec_key_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+		.u.remove.sta_mask = cpu_to_le32(sta_mask),
+		.u.remove.key_id = cpu_to_le32(keyidx),
+		.u.remove.key_flags = cpu_to_le32(key_flags),
+	};
+
+	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, flags, sizeof(cmd), &cmd);
+}
+
+int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
+			struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *keyconf)
+{
+	u32 sta_mask = iwl_mvm_get_sec_sta_mask(mvm, vif, sta, keyconf);
+	u32 key_flags = iwl_mvm_get_sec_flags(mvm, vif, sta, keyconf);
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
+	struct iwl_sec_key_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.u.add.sta_mask = cpu_to_le32(sta_mask),
+		.u.add.key_id = cpu_to_le32(keyconf->keyidx),
+		.u.add.key_flags = cpu_to_le32(key_flags),
+		.u.add.tx_seq = cpu_to_le64(atomic64_read(&keyconf->tx_pn)),
+	};
+	int ret;
+
+	if (WARN_ON(keyconf->keylen > sizeof(cmd.u.add.key)))
+		return -EINVAL;
+
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104)
+		memcpy(cmd.u.add.key + IWL_SEC_WEP_KEY_OFFSET, keyconf->key,
+		       keyconf->keylen);
+	else
+		memcpy(cmd.u.add.key, keyconf->key, keyconf->keylen);
+
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_TKIP) {
+		memcpy(cmd.u.add.tkip_mic_rx_key,
+		       keyconf->key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+		       8);
+		memcpy(cmd.u.add.tkip_mic_tx_key,
+		       keyconf->key + NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY,
+		       8);
+	}
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+	if (ret)
+		return ret;
+
+	/*
+	 * For WEP, the same key is used for multicast and unicast so need to
+	 * upload it again. If this fails, remove the original as well.
+	 */
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104) {
+		cmd.u.add.key_flags ^= cpu_to_le32(IWL_SEC_KEY_FLAG_MCAST_KEY);
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+		if (ret)
+			__iwl_mvm_sec_key_del(mvm, sta_mask, key_flags,
+					      keyconf->keyidx, 0);
+	}
+
+	return ret;
+}
+
+static int _iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct ieee80211_key_conf *keyconf,
+				u32 flags)
+{
+	u32 sta_mask = iwl_mvm_get_sec_sta_mask(mvm, vif, sta, keyconf);
+	u32 key_flags = iwl_mvm_get_sec_flags(mvm, vif, sta, keyconf);
+	int ret;
+
+	ret = __iwl_mvm_sec_key_del(mvm, sta_mask, key_flags, keyconf->keyidx,
+				    flags);
+	if (ret)
+		return ret;
+
+	/* For WEP, delete the key again as unicast */
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104) {
+		key_flags ^= IWL_SEC_KEY_FLAG_MCAST_KEY;
+		ret = __iwl_mvm_sec_key_del(mvm, sta_mask, key_flags,
+					    keyconf->keyidx, flags);
+	}
+
+	return ret;
+}
+
+int iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
+			struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *keyconf)
+{
+	return _iwl_mvm_sec_key_del(mvm, vif, sta, keyconf, 0);
+}
+
+static void iwl_mvm_sec_key_remove_ap_iter(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_sta *sta,
+					   struct ieee80211_key_conf *key,
+					   void *data)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	if (key->hw_key_idx == STA_KEY_IDX_INVALID)
+		return;
+
+	if (sta)
+		return;
+
+	_iwl_mvm_sec_key_del(mvm, vif, NULL, key, CMD_ASYNC);
+	key->hw_key_idx = STA_KEY_IDX_INVALID;
+}
+
+void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
+			       struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	u32 sec_key_id = WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD);
+	u8 sec_key_ver = iwl_fw_lookup_cmd_ver(mvm->fw, sec_key_id, 0);
+
+	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION ||
+		    mvmvif->ap_sta_id == IWL_MVM_INVALID_STA))
+		return;
+
+	if (!sec_key_ver)
+		return;
+
+	ieee80211_iter_keys_rcu(mvm->hw, vif,
+				iwl_mvm_sec_key_remove_ap_iter,
+				NULL);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 1ccb3cad7cdc..19d7a4f4ccdc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2079,6 +2079,18 @@ void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 			     struct dentry *dir);
 #endif
 
+/* new MLD related APIs */
+int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
+			struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *keyconf);
+int iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
+			struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *keyconf);
+void iwl_mvm_sec_key_remove_ap(struct iwl_mvm *mvm,
+			       struct ieee80211_vif *vif);
+
 int iwl_rfi_send_config_cmd(struct iwl_mvm *mvm,
 			    struct iwl_rfi_lut_entry *rfi_table);
 struct iwl_rfi_freq_table_resp_cmd *iwl_rfi_get_freq_table(struct iwl_mvm *mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 5b8e9a06f6d4..9699433137bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -547,6 +547,7 @@ static const struct iwl_hcmd_names iwl_mvm_data_path_names[] = {
 	HCMD_NAME(TLC_MNG_CONFIG_CMD),
 	HCMD_NAME(CHEST_COLLECTOR_FILTER_CONFIG_CMD),
 	HCMD_NAME(SCD_QUEUE_CONFIG_CMD),
+	HCMD_NAME(SEC_KEY_CMD),
 	HCMD_NAME(MONITOR_NOTIF),
 	HCMD_NAME(THERMAL_DUAL_CHAIN_REQUEST),
 	HCMD_NAME(STA_PM_NOTIF),
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index cbd8053a9e35..515dd3e0730d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1954,6 +1954,9 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		if (vif->cfg.assoc)
 			return ret;
 
+		/* first remove remaining keys */
+		iwl_mvm_sec_key_remove_ap(mvm, vif);
+
 		/* unassoc - go ahead - remove the AP STA now */
 		mvmvif->ap_sta_id = IWL_MVM_INVALID_STA;
 	}
-- 
2.35.3

