Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1535E3E1278
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbhHEKT7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:19:59 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51224 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240199AbhHEKT5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTU-00240Q-8e; Thu, 05 Aug 2021 13:19:42 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:27 +0300
Message-Id: <iwlwifi.20210805130823.c6f77325c430.I798ce9d757492a9e3d223c1de5d4e62ebbc00b2c@changeid>
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
Subject: [PATCH 05/12] iwlwifi: mvm: d3: make key reprogramming iteration optional
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Now that only reprogramming is left in the initial key iteration,
skip it entirely on unified firmware images instead of skipping
only the command sending inside of it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 102 +++++++++-----------
 1 file changed, 48 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 61490f17a1fa..ad7308cc4b7f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -101,8 +101,8 @@ static const u8 *iwl_mvm_find_max_pn(struct ieee80211_key_conf *key,
 	return ret;
 }
 
-struct wowlan_key_data {
-	bool error, configure_keys;
+struct wowlan_key_reprogram_data {
+	bool error;
 	int wep_key_idx;
 };
 
@@ -114,7 +114,7 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct wowlan_key_data *data = _data;
+	struct wowlan_key_reprogram_data *data = _data;
 	int ret;
 
 	switch (key->cipher) {
@@ -152,18 +152,14 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 			wkc.wep_key.key_offset = data->wep_key_idx;
 		}
 
-		if (data->configure_keys) {
-			mutex_lock(&mvm->mutex);
-			ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0,
-						   sizeof(wkc), &wkc);
-			data->error = ret != 0;
-
-			mvm->ptk_ivlen = key->iv_len;
-			mvm->ptk_icvlen = key->icv_len;
-			mvm->gtk_ivlen = key->iv_len;
-			mvm->gtk_icvlen = key->icv_len;
-			mutex_unlock(&mvm->mutex);
-		}
+		mutex_lock(&mvm->mutex);
+		ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0, sizeof(wkc), &wkc);
+		data->error = ret != 0;
+
+		mvm->ptk_ivlen = key->iv_len;
+		mvm->ptk_icvlen = key->icv_len;
+		mvm->gtk_ivlen = key->iv_len;
+		mvm->gtk_icvlen = key->icv_len;
 
 		/* don't upload key again */
 		return;
@@ -190,30 +186,28 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		break;
 	}
 
-	if (data->configure_keys) {
-		mutex_lock(&mvm->mutex);
+	mutex_lock(&mvm->mutex);
+	/*
+	 * The D3 firmware hardcodes the key offset 0 as the key it
+	 * uses to transmit packets to the AP, i.e. the PTK.
+	 */
+	if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
+		mvm->ptk_ivlen = key->iv_len;
+		mvm->ptk_icvlen = key->icv_len;
+		ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 0);
+	} else {
 		/*
-		 * The D3 firmware hardcodes the key offset 0 as the key it
-		 * uses to transmit packets to the AP, i.e. the PTK.
+		 * firmware only supports TSC/RSC for a single key,
+		 * so if there are multiple keep overwriting them
+		 * with new ones -- this relies on mac80211 doing
+		 * list_add_tail().
 		 */
-		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE) {
-			mvm->ptk_ivlen = key->iv_len;
-			mvm->ptk_icvlen = key->icv_len;
-			ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 0);
-		} else {
-			/*
-			 * firmware only supports TSC/RSC for a single key,
-			 * so if there are multiple keep overwriting them
-			 * with new ones -- this relies on mac80211 doing
-			 * list_add_tail().
-			 */
-			mvm->gtk_ivlen = key->iv_len;
-			mvm->gtk_icvlen = key->icv_len;
-			ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 1);
-		}
-		mutex_unlock(&mvm->mutex);
-		data->error = ret != 0;
+		mvm->gtk_ivlen = key->iv_len;
+		mvm->gtk_icvlen = key->icv_len;
+		ret = iwl_mvm_set_sta_key(mvm, vif, sta, key, 1);
 	}
+	mutex_unlock(&mvm->mutex);
+	data->error = ret != 0;
 }
 
 struct wowlan_key_rsc_tsc_data {
@@ -839,30 +833,30 @@ static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 {
 	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
-	struct wowlan_key_data key_data = {
-		.configure_keys = !unified,
-	};
+	struct wowlan_key_reprogram_data key_data = {};
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
 	u8 cmd_ver;
 	size_t cmd_size;
 
-	/*
-	 * if we have to configure keys, call ieee80211_iter_keys(),
-	 * as we need non-atomic context in order to take the
-	 * required locks.
-	 */
-	/*
-	 * Note that currently we don't use CMD_ASYNC in the iterator.
-	 * In case of key_data.configure_keys, all the configured commands
-	 * are SYNC, and iwl_mvm_wowlan_program_keys() will take care of
-	 * locking/unlocking mvm->mutex.
-	 */
-	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_program_keys,
-			    &key_data);
+	if (!unified) {
+		/*
+		 * if we have to configure keys, call ieee80211_iter_keys(),
+		 * as we need non-atomic context in order to take the
+		 * required locks.
+		 */
+		/*
+		 * Note that currently we don't use CMD_ASYNC in the iterator.
+		 * In case of key_data.configure_keys, all the configured
+		 * commands are SYNC, and iwl_mvm_wowlan_program_keys() will
+		 * take care of locking/unlocking mvm->mutex.
+		 */
+		ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_program_keys,
+				    &key_data);
 
-	if (key_data.error)
-		return -EIO;
+		if (key_data.error)
+			return -EIO;
+	}
 
 	ret = iwl_mvm_wowlan_config_rsc_tsc(mvm, vif);
 	if (ret)
-- 
2.32.0

