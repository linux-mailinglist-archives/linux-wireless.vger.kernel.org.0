Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61B72D0196
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 09:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLFIWz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 03:22:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:34668 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726077AbgLFIWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 03:22:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=localhost.localdomain)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1klpJ1-003A2r-0h; Sun, 06 Dec 2020 10:22:07 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun,  6 Dec 2020 10:21:54 +0200
Message-Id: <iwlwifi.20201206100942.367e06852726.Ic35b8d1a328903195ec7cb887a9cb198b7d8f856@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206082159.440198-1-luca@coelho.fi>
References: <20201206082159.440198-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/12] iwlwifi: mvm: iterate active stations when updating statistics
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Instead of enumerating all possible stations iterate only active ones.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 36 ++++++++-------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 0059c83c2783..2ffe92d79148 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -689,30 +689,20 @@ iwl_mvm_rx_stats_check_trigger(struct iwl_mvm *mvm, struct iwl_rx_packet *pkt)
 	iwl_fw_dbg_collect_trig(&mvm->fwrt, trig, NULL);
 }
 
-static void iwl_mvm_update_avg_energy(struct iwl_mvm *mvm,
-				      u8 energy[IWL_MVM_STATION_COUNT_MAX])
+static void iwl_mvm_stats_energy_iter(void *_data,
+				      struct ieee80211_sta *sta)
 {
-	int i;
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	u8 *energy = _data;
+	u32 sta_id = mvmsta->sta_id;
 
-	if (WARN_ONCE(mvm->fw->ucode_capa.num_stations >
-		      IWL_MVM_STATION_COUNT_MAX,
-		      "Driver and FW station count mismatch %d\n",
-		      mvm->fw->ucode_capa.num_stations))
+	if (WARN_ONCE(sta_id >= IWL_MVM_STATION_COUNT_MAX, "sta_id %d >= %d",
+		      sta_id, IWL_MVM_STATION_COUNT_MAX))
 		return;
 
-	rcu_read_lock();
-	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
-		struct iwl_mvm_sta *sta;
-
-		if (!energy[i])
-			continue;
+	if (energy[sta_id])
+		mvmsta->avg_energy = energy[sta_id];
 
-		sta = iwl_mvm_sta_from_staid_rcu(mvm, i);
-		if (!sta)
-			continue;
-		sta->avg_energy = energy[i];
-	}
-	rcu_read_unlock();
 }
 
 static void
@@ -793,8 +783,8 @@ iwl_mvm_handle_rx_statistics_tlv(struct iwl_mvm *mvm,
 
 	for (i = 0; i < ARRAY_SIZE(average_energy); i++)
 		average_energy[i] = le32_to_cpu(stats->average_energy[i]);
-	iwl_mvm_update_avg_energy(mvm, average_energy);
-
+	ieee80211_iterate_stations_atomic(mvm->hw, iwl_mvm_stats_energy_iter,
+					  average_energy);
 	/*
 	 * Don't update in case the statistics are not cleared, since
 	 * we will end up counting twice the same airtime, once in TCM
@@ -904,8 +894,8 @@ void iwl_mvm_handle_rx_statistics(struct iwl_mvm *mvm,
 		bytes = (void *)&stats->load_stats.byte_count;
 		air_time = (void *)&stats->load_stats.air_time;
 	}
-
-	iwl_mvm_update_avg_energy(mvm, energy);
+	ieee80211_iterate_stations_atomic(mvm->hw, iwl_mvm_stats_energy_iter,
+					  energy);
 
 	/*
 	 * Don't update in case the statistics are not cleared, since
-- 
2.29.2

