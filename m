Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A523DDFBA
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhHBS7V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51048 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231273AbhHBS7S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:18 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9W-001ySl-37; Mon, 02 Aug 2021 21:59:07 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:55 +0300
Message-Id: <iwlwifi.20210802215208.39a00ca1a1a6.Ifb4adeb4edd2b72232046dd2d59c0b3732f497c2@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802185856.175567-1-luca@coelho.fi>
References: <20210802185856.175567-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.5-pre1
Subject: [PATCH 09/10] iwlwifi: mvm: support new station key API
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The new version 3 of the station key API has gotten rid of the
strange hole in the sequence counter values, support that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |  8 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 31 ++++++++++---------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index 12b2f2c48387..f1a3e14880e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -384,13 +384,17 @@ struct iwl_mvm_add_sta_key_cmd_v1 {
  * @rx_mic_key: TKIP RX unicast or multicast key
  * @tx_mic_key: TKIP TX key
  * @transmit_seq_cnt: TSC, transmit packet number
+ *
+ * Note: This is used for both v2 and v3, the difference being
+ * in the way the common.rx_secur_seq_cnt is used, in v2 that's
+ * the strange hole format, in v3 it's just a u64.
  */
 struct iwl_mvm_add_sta_key_cmd {
 	struct iwl_mvm_add_sta_key_common common;
 	__le64 rx_mic_key;
 	__le64 tx_mic_key;
 	__le64 transmit_seq_cnt;
-} __packed; /* ADD_MODIFY_STA_KEY_API_S_VER_2 */
+} __packed; /* ADD_MODIFY_STA_KEY_API_S_VER_2, ADD_MODIFY_STA_KEY_API_S_VER_3 */
 
 /**
  * enum iwl_mvm_add_sta_rsp_status - status in the response to ADD_STA command
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 84953d7e5f09..7e9951993af8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3228,6 +3228,9 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 	int i, size;
 	bool new_api = fw_has_api(&mvm->fw->ucode_capa,
 				  IWL_UCODE_TLV_API_TKIP_MIC_KEYS);
+	int api_ver = iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					    ADD_STA_KEY,
+					    new_api ? 2 : 1);
 
 	if (sta_id == IWL_MVM_INVALID_STA)
 		return -EINVAL;
@@ -3240,7 +3243,7 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
 		key_flags |= cpu_to_le16(STA_KEY_FLG_TKIP);
-		if (new_api) {
+		if (api_ver >= 2) {
 			memcpy((void *)&u.cmd.tx_mic_key,
 			       &key->key[NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY],
 			       IWL_MIC_KEY_SIZE);
@@ -3261,7 +3264,7 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 	case WLAN_CIPHER_SUITE_CCMP:
 		key_flags |= cpu_to_le16(STA_KEY_FLG_CCM);
 		memcpy(u.cmd.common.key, key->key, key->keylen);
-		if (new_api)
+		if (api_ver >= 2)
 			pn = atomic64_read(&key->tx_pn);
 		break;
 	case WLAN_CIPHER_SUITE_WEP104:
@@ -3277,7 +3280,7 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 	case WLAN_CIPHER_SUITE_GCMP:
 		key_flags |= cpu_to_le16(STA_KEY_FLG_GCMP);
 		memcpy(u.cmd.common.key, key->key, key->keylen);
-		if (new_api)
+		if (api_ver >= 2)
 			pn = atomic64_read(&key->tx_pn);
 		break;
 	default:
@@ -3303,28 +3306,28 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 		struct ieee80211_key_seq seq = {};
 		u8 _rx_pn[IEEE80211_MAX_PN_LEN] = {}, *rx_pn = _rx_pn;
 		int rx_pn_len = 8;
+		/* there's a hole at 2/3 in FW format depending on version */
+		int hole = api_ver >= 3 ? 0 : 2;
 
 		ieee80211_get_key_rx_seq(key, i, &seq);
 
 		if (key->cipher == WLAN_CIPHER_SUITE_TKIP) {
 			rx_pn[0] = seq.tkip.iv16;
 			rx_pn[1] = seq.tkip.iv16 >> 8;
-			/* hole at 2/3 in FW format */
-			rx_pn[4] = seq.tkip.iv32;
-			rx_pn[5] = seq.tkip.iv32 >> 8;
-			rx_pn[6] = seq.tkip.iv32 >> 16;
-			rx_pn[7] = seq.tkip.iv32 >> 24;
+			rx_pn[2 + hole] = seq.tkip.iv32;
+			rx_pn[3 + hole] = seq.tkip.iv32 >> 8;
+			rx_pn[4 + hole] = seq.tkip.iv32 >> 16;
+			rx_pn[5 + hole] = seq.tkip.iv32 >> 24;
 		} else if (key_flags & cpu_to_le16(STA_KEY_FLG_EXT)) {
 			rx_pn = seq.hw.seq;
 			rx_pn_len = seq.hw.seq_len;
 		} else {
 			rx_pn[0] = seq.ccmp.pn[0];
 			rx_pn[1] = seq.ccmp.pn[1];
-			/* hole at 2/3 in FW format */
-			rx_pn[4] = seq.ccmp.pn[2];
-			rx_pn[5] = seq.ccmp.pn[3];
-			rx_pn[6] = seq.ccmp.pn[4];
-			rx_pn[7] = seq.ccmp.pn[5];
+			rx_pn[2 + hole] = seq.ccmp.pn[2];
+			rx_pn[3 + hole] = seq.ccmp.pn[3];
+			rx_pn[4 + hole] = seq.ccmp.pn[4];
+			rx_pn[5 + hole] = seq.ccmp.pn[5];
 		}
 
 		if (iwl_mvm_pn_cmp(rx_pn, (u8 *)&u.cmd.common.rx_secur_seq_cnt,
@@ -3333,7 +3336,7 @@ static int iwl_mvm_send_sta_key(struct iwl_mvm *mvm,
 			       rx_pn_len);
 	}
 
-	if (new_api) {
+	if (api_ver >= 2) {
 		u.cmd.transmit_seq_cnt = cpu_to_le64(pn);
 		size = sizeof(u.cmd);
 	} else {
-- 
2.32.0

