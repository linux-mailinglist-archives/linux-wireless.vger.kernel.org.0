Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630D14A97AF
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357456AbiBDKZV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37960 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241228AbiBDKZU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:20 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmH-0005zM-Vu;
        Fri, 04 Feb 2022 12:25:19 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:25:03 +0200
Message-Id: <iwlwifi.20220204122220.457da4cc95eb.Ic98472bab5f5475f1e102547644caaae89ce4c4a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204102511.606112-1-luca@coelho.fi>
References: <20220204102511.606112-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH 04/12] iwlwifi: mvm: Passively scan non PSC channels only when requested so
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Non PSC channels should generally be scanned based on information about
collocated APs obtained during scan on legacy bands, and otherwise
should not be scanned unless specifically requested so (as there are
relatively many non PSC channels, scanning them passively is time consuming
and interferes with regular data traffic).

Thus, modify the scan logic to avoid passively scanning PSC channels
if there is no information about collocated APs and the scan is not
a passive scan.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 42 ++++++++++++++-----
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 8c7cb491330d..901df916baa4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1728,27 +1728,37 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
 }
 
 /* TODO: this function can be merged with iwl_mvm_scan_umac_fill_ch_p_v6 */
-static void
-iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
+static u32
+iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm *mvm,
+				     struct iwl_mvm_scan_params *params,
 				     u32 n_channels,
 				     struct iwl_scan_probe_params_v4 *pp,
 				     struct iwl_scan_channel_params_v6 *cp,
 				     enum nl80211_iftype vif_type)
 {
-	struct iwl_scan_channel_cfg_umac *channel_cfg = cp->channel_config;
 	int i;
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
 		params->scan_6ghz_params;
+	u32 ch_cnt;
 
-	for (i = 0; i < params->n_channels; i++) {
+	for (i = 0, ch_cnt = 0; i < params->n_channels; i++) {
 		struct iwl_scan_channel_cfg_umac *cfg =
-			&cp->channel_config[i];
+			&cp->channel_config[ch_cnt];
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
 		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
 		bool force_passive, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
 
+		/*
+		 * Avoid performing passive scan on non PSC channels unless the
+		 * scan is specifically a passive scan, i.e., no SSIDs
+		 * configured in the scan command.
+		 */
+		if (!cfg80211_channel_is_psc(params->channels[i]) &&
+		    !params->n_6ghz_params && params->n_ssids)
+			continue;
+
 		cfg->v1.channel_num = params->channels[i]->hw_value;
 		cfg->v2.band = 2;
 		cfg->v2.iter_count = 1;
@@ -1868,8 +1878,16 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 		else
 			flags |= bssid_bitmap | (s_ssid_bitmap << 16);
 
-		channel_cfg[i].flags |= cpu_to_le32(flags);
+		cfg->flags |= cpu_to_le32(flags);
+		ch_cnt++;
 	}
+
+	if (params->n_channels > ch_cnt)
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz: reducing number channels: (%u->%u)\n",
+			       params->n_channels, ch_cnt);
+
+	return ch_cnt;
 }
 
 static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
@@ -2415,10 +2433,14 @@ static int iwl_mvm_scan_umac_v14_and_above(struct iwl_mvm *mvm,
 
 	iwl_mvm_umac_scan_fill_6g_chan_list(mvm, params, pb);
 
-	iwl_mvm_umac_scan_cfg_channels_v6_6g(params,
-					     params->n_channels,
-					     pb, cp, vif->type);
-	cp->count = params->n_channels;
+	cp->count = iwl_mvm_umac_scan_cfg_channels_v6_6g(mvm, params,
+							 params->n_channels,
+							 pb, cp, vif->type);
+	if (!cp->count) {
+		mvm->scan_uid_status[uid] = 0;
+		return -EINVAL;
+	}
+
 	if (!params->n_ssids ||
 	    (params->n_ssids == 1 && !params->ssids[0].ssid_len))
 		cp->flags |= IWL_SCAN_CHANNEL_FLAG_6G_PSC_NO_FILTER;
-- 
2.34.1

