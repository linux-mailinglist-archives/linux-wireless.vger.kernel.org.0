Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA25926EA
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfHSOfz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 10:35:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36894 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbfHSOfz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 10:35:55 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hziku-0007sP-Ag; Mon, 19 Aug 2019 17:35:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 17:35:01 +0300
Message-Id: <20190819143507.6989-17-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819143507.6989-1-luca@coelho.fi>
References: <20190819143507.6989-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 16/22] iwlwifi: mvm: iwl_mvm_wowlan_config_key_params is for wowlan only
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Now that d0i3 is dead, this function can't be called from d0i3
flows. Change its signature and make it static.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c  | 64 +++++---------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 12 ----
 2 files changed, 15 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 2ddc6cc56d1d..89839a83d8c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -735,40 +735,16 @@ iwl_mvm_get_wowlan_config(struct iwl_mvm *mvm,
 	return 0;
 }
 
-static void
-iwl_mvm_iter_d0i3_ap_keys(struct iwl_mvm *mvm,
-			  struct ieee80211_vif *vif,
-			  void (*iter)(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       struct ieee80211_sta *sta,
-				       struct ieee80211_key_conf *key,
-				       void *data),
-			  void *data)
-{
-	struct ieee80211_sta *ap_sta;
-
-	rcu_read_lock();
-
-	ap_sta = rcu_dereference(mvm->fw_id_to_mac_id[mvm->d0i3_ap_sta_id]);
-	if (IS_ERR_OR_NULL(ap_sta))
-		goto out;
-
-	ieee80211_iter_keys_rcu(mvm->hw, vif, iter, data);
-out:
-	rcu_read_unlock();
-}
-
-int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     bool d0i3,
-				     u32 cmd_flags)
+static int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
+					    struct ieee80211_vif *vif,
+					    u32 cmd_flags)
 {
 	struct iwl_wowlan_kek_kck_material_cmd kek_kck_cmd = {};
 	struct iwl_wowlan_tkip_params_cmd tkip_cmd = {};
 	bool unified = fw_has_capa(&mvm->fw->ucode_capa,
 				   IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 	struct wowlan_key_data key_data = {
-		.configure_keys = !d0i3 && !unified,
+		.configure_keys = !unified,
 		.use_rsc_tsc = false,
 		.tkip = &tkip_cmd,
 		.use_tkip = false,
@@ -784,25 +760,16 @@ int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	 * if we have to configure keys, call ieee80211_iter_keys(),
 	 * as we need non-atomic context in order to take the
 	 * required locks.
-	 * for the d0i3 we can't use ieee80211_iter_keys(), as
-	 * taking (almost) any mutex might result in deadlock.
 	 */
-	if (!d0i3) {
-		/*
-		 * Note that currently we don't propagate cmd_flags
-		 * to the iterator. In case of key_data.configure_keys,
-		 * all the configured commands are SYNC, and
-		 * iwl_mvm_wowlan_program_keys() will take care of
-		 * locking/unlocking mvm->mutex.
-		 */
-		ieee80211_iter_keys(mvm->hw, vif,
-				    iwl_mvm_wowlan_program_keys,
-				    &key_data);
-	} else {
-		iwl_mvm_iter_d0i3_ap_keys(mvm, vif,
-					  iwl_mvm_wowlan_program_keys,
-					  &key_data);
-	}
+	/*
+	 * Note that currently we don't propagate cmd_flags
+	 * to the iterator. In case of key_data.configure_keys,
+	 * all the configured commands are SYNC, and
+	 * iwl_mvm_wowlan_program_keys() will take care of
+	 * locking/unlocking mvm->mutex.
+	 */
+	ieee80211_iter_keys(mvm->hw, vif, iwl_mvm_wowlan_program_keys,
+			    &key_data);
 
 	if (key_data.error) {
 		ret = -EIO;
@@ -830,7 +797,7 @@ int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
 	}
 
 	/* configure rekey data only if offloaded rekey is supported (d3) */
-	if (mvmvif->rekey_data.valid && !d0i3) {
+	if (mvmvif->rekey_data.valid) {
 		memset(&kek_kck_cmd, 0, sizeof(kek_kck_cmd));
 		memcpy(kek_kck_cmd.kck, mvmvif->rekey_data.kck,
 		       NL80211_KCK_LEN);
@@ -881,8 +848,7 @@ iwl_mvm_wowlan_config(struct iwl_mvm *mvm,
 		 * that isn't really a problem though.
 		 */
 		mutex_unlock(&mvm->mutex);
-		ret = iwl_mvm_wowlan_config_key_params(mvm, vif, false,
-						       CMD_ASYNC);
+		ret = iwl_mvm_wowlan_config_key_params(mvm, vif, CMD_ASYNC);
 		mutex_lock(&mvm->mutex);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2cf5d31ad3ed..03f3faa02781 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1802,21 +1802,9 @@ void iwl_mvm_set_default_unicast_key(struct ieee80211_hw *hw,
 extern const struct file_operations iwl_dbgfs_d3_test_ops;
 struct iwl_wowlan_status *iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm);
 #ifdef CONFIG_PM
-int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
-				     struct ieee80211_vif *vif,
-				     bool host_awake,
-				     u32 cmd_flags);
 void iwl_mvm_set_last_nonqos_seq(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
 #else
-static inline int iwl_mvm_wowlan_config_key_params(struct iwl_mvm *mvm,
-						   struct ieee80211_vif *vif,
-						   bool host_awake,
-						   u32 cmd_flags)
-{
-	return 0;
-}
-
 static inline void
 iwl_mvm_set_last_nonqos_seq(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 {
-- 
2.23.0.rc1

