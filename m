Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099C035B2D9
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbhDKJqv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:46:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44420 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235005AbhDKJqu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:46:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfn-000Jkq-JX; Sun, 11 Apr 2021 12:46:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:19 +0300
Message-Id: <iwlwifi.20210411124417.b6560a5de0cd.I5dac9c60faed7f48b06d352aa2d65bcf8142c2dc@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411094630.431873-1-luca@coelho.fi>
References: <20210411094630.431873-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/12] iwlwifi: remove TCM events
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Nobody uses that in the user space.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h   |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c | 18 ++----------------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e2a37ac7c4b1..4d9d4d6892fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -591,7 +591,6 @@ struct iwl_mvm_tcm {
 		enum iwl_mvm_traffic_load global_load;
 		bool low_latency[NUM_MAC_INDEX_DRIVER];
 		bool change[NUM_MAC_INDEX_DRIVER];
-		bool global_change;
 	} result;
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index b6b481ff1518..c566be99a4c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1030,15 +1030,9 @@ iwl_mvm_tcm_load(struct iwl_mvm *mvm, u32 airtime, unsigned long elapsed)
 	return IWL_MVM_TRAFFIC_LOW;
 }
 
-struct iwl_mvm_tcm_iter_data {
-	struct iwl_mvm *mvm;
-	bool any_sent;
-};
-
 static void iwl_mvm_tcm_iter(void *_data, u8 *mac, struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_tcm_iter_data *data = _data;
-	struct iwl_mvm *mvm = data->mvm;
+	struct iwl_mvm *mvm = _data;
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	bool low_latency, prev = mvmvif->low_latency & LOW_LATENCY_TRAFFIC;
 
@@ -1060,22 +1054,15 @@ static void iwl_mvm_tcm_iter(void *_data, u8 *mac, struct ieee80211_vif *vif)
 	} else {
 		iwl_mvm_update_quotas(mvm, false, NULL);
 	}
-
-	data->any_sent = true;
 }
 
 static void iwl_mvm_tcm_results(struct iwl_mvm *mvm)
 {
-	struct iwl_mvm_tcm_iter_data data = {
-		.mvm = mvm,
-		.any_sent = false,
-	};
-
 	mutex_lock(&mvm->mutex);
 
 	ieee80211_iterate_active_interfaces(
 		mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
-		iwl_mvm_tcm_iter, &data);
+		iwl_mvm_tcm_iter, mvm);
 
 	if (fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_UMAC_SCAN))
 		iwl_mvm_config_scan(mvm);
@@ -1257,7 +1244,6 @@ static unsigned long iwl_mvm_calc_tcm_stats(struct iwl_mvm *mvm,
 	}
 
 	load = iwl_mvm_tcm_load(mvm, total_airtime, elapsed);
-	mvm->tcm.result.global_change = load != mvm->tcm.result.global_load;
 	mvm->tcm.result.global_load = load;
 
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
-- 
2.31.0

