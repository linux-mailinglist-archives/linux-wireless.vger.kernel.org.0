Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC223DDAAF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhHBOTk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:19:40 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50860 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235042AbhHBOSx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:18:53 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYdd-001xoA-Uv; Mon, 02 Aug 2021 17:09:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:09:43 +0300
Message-Id: <iwlwifi.20210802170640.ffb540a70212.Ia2bb9bc9435b833820bcc7dc30adcedb5a5a9869@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802140944.90143-1-luca@coelho.fi>
References: <20210802140944.90143-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 11/12] iwlwifi: mvm: Add support for hidden network scan on 6GHz band
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Add support for discovery of hidden networks on the 6GHz band,
by including the scan request direct SSIDs in the FW scan request
command:

- In case a short SSID matches one of the direct SSIDs in the scan
  request command, add the matching SSID in the same offset in the
  'direct_ssids' array.
- Otherwise, add the SSID in one of the available slots.

Additionally, as a preparation to handle hidden APs, refactor
iwl_mvm_umac_scan_cfg_channels_v6_6g() the function.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 90 +++++++++++++++----
 2 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 9a8c7b7a0816..6c8e9f3a6af2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -414,6 +414,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_PROTECTED_TWT		= (__force iwl_ucode_tlv_capa_t)56,
 	IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE		= (__force iwl_ucode_tlv_capa_t)57,
 	IWL_UCODE_TLV_CAPA_PASSIVE_6GHZ_SCAN		= (__force iwl_ucode_tlv_capa_t)58,
+	IWL_UCODE_TLV_CAPA_HIDDEN_6GHZ_SCAN		= (__force iwl_ucode_tlv_capa_t)59,
 	IWL_UCODE_TLV_CAPA_BROADCAST_TWT		= (__force iwl_ucode_tlv_capa_t)60,
 
 	/* set 2 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 4899d8f90bab..82ab08af0e21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1724,9 +1724,8 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm_scan_params *params,
 /* TODO: this function can be merged with iwl_mvm_scan_umac_fill_ch_p_v6 */
 static void
 iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
-				     u32 n_channels, __le32 *cmd_short_ssid,
-				     u8 *cmd_bssid, u8 scan_ssid_num,
-				     u8 bssid_num,
+				     u32 n_channels,
+				     struct iwl_scan_probe_params_v4 *pp,
 				     struct iwl_scan_channel_params_v6 *cp,
 				     enum nl80211_iftype vif_type)
 {
@@ -1741,7 +1740,7 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
 		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
-		bool force_passive, found = false,
+		bool force_passive, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
 
 		cfg->v1.channel_num = params->channels[i]->hw_value;
@@ -1766,9 +1765,9 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 				scan_6ghz_params[j].unsolicited_probe;
 			psc_no_listen |= scan_6ghz_params[j].psc_no_listen;
 
-			for (k = 0; k < scan_ssid_num; k++) {
+			for (k = 0; k < pp->short_ssid_num; k++) {
 				if (!scan_6ghz_params[j].unsolicited_probe &&
-				    le32_to_cpu(cmd_short_ssid[k]) ==
+				    le32_to_cpu(pp->short_ssid[k]) ==
 				    scan_6ghz_params[j].short_ssid) {
 					/* Relevant short SSID bit set */
 					if (s_ssid_bitmap & BIT(k)) {
@@ -1778,7 +1777,10 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 
 					/*
 					 * Use short SSID only to create a new
-					 * iteration during channel dwell.
+					 * iteration during channel dwell or in
+					 * case that the short SSID has a
+					 * matching SSID, i.e., scan for hidden
+					 * APs.
 					 */
 					if (n_used_bssid_entries >= 3) {
 						s_ssid_bitmap |= BIT(k);
@@ -1786,6 +1788,12 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 						n_used_bssid_entries -= 3;
 						found = true;
 						break;
+					} else if (pp->direct_scan[k].len) {
+						s_ssid_bitmap |= BIT(k);
+						s_max++;
+						found = true;
+						allow_passive = false;
+						break;
 					}
 				}
 			}
@@ -1793,8 +1801,8 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 			if (found)
 				continue;
 
-			for (k = 0; k < bssid_num; k++) {
-				if (!memcmp(&cmd_bssid[ETH_ALEN * k],
+			for (k = 0; k < pp->bssid_num; k++) {
+				if (!memcmp(&pp->bssid_array[k],
 					    scan_6ghz_params[j].bssid,
 					    ETH_ALEN)) {
 					if (!(bssid_bitmap & BIT(k))) {
@@ -1849,7 +1857,7 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 			force_passive |= (unsolicited_probe_on_chan &&
 					  (s_max > 1 || b_max > 3));
 		}
-		if (force_passive ||
+		if ((allow_passive && force_passive) ||
 		    (!flags && !cfg80211_channel_is_psc(params->channels[i])))
 			flags |= IWL_UHB_CHAN_CFG_FLAG_FORCE_PASSIVE;
 
@@ -1857,6 +1865,60 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 	}
 }
 
+static void
+iwl_mvm_umac_scan_cfg_6g_direct_ssids(struct iwl_mvm *mvm,
+				      struct iwl_mvm_scan_params *params,
+				      struct iwl_scan_probe_params_v4 *pp)
+{
+	u8 next_free_idx = pp->short_ssid_num;
+	int i;
+
+	if (!fw_has_capa(&mvm->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_HIDDEN_6GHZ_SCAN)) {
+		IWL_DEBUG_SCAN(mvm,
+			       "6GHz hidden scan: Not supported by FW\n");
+		return;
+	}
+
+	for (i = params->n_ssids - 1; i >= 0; i--) {
+		__le32 short_ssid;
+		u8 ssid_idx, j;
+
+		if (!params->ssids[i].ssid_len)
+			continue;
+
+		short_ssid = cpu_to_le32(~crc32_le(~0, params->ssids[i].ssid,
+						   params->ssids[i].ssid_len));
+
+		for (j = 0; j < pp->short_ssid_num; j++)
+			if (short_ssid == pp->short_ssid[j])
+				break;
+
+		if (j == pp->short_ssid_num) {
+			/*
+			 * If there are no available slots for the short SSID, do not
+			 * place it.
+			 */
+			if (next_free_idx < SCAN_SHORT_SSID_MAX_SIZE)
+				ssid_idx = next_free_idx++;
+			else
+				continue;
+		} else {
+			ssid_idx = j;
+		}
+
+		if (ssid_idx >= PROBE_OPTION_MAX)
+			continue;
+
+		pp->direct_scan[ssid_idx].id = WLAN_EID_SSID;
+		pp->direct_scan[ssid_idx].len = params->ssids[i].ssid_len;
+		memcpy(pp->direct_scan[ssid_idx].ssid, params->ssids[i].ssid,
+		       params->ssids[i].ssid_len);
+	}
+
+	pp->short_ssid_num = next_free_idx;
+}
+
 static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
 					  struct iwl_mvm_scan_params *params,
 					  struct ieee80211_vif *vif)
@@ -2390,13 +2452,11 @@ static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
+	iwl_mvm_umac_scan_cfg_6g_direct_ssids(mvm, params, pb);
+
 	iwl_mvm_umac_scan_cfg_channels_v6_6g(params,
 					     params->n_channels,
-					     pb->short_ssid,
-					     pb->bssid_array[0],
-					     pb->short_ssid_num,
-					     pb->bssid_num, cp,
-					     vif->type);
+					     pb, cp, vif->type);
 	cp->count = params->n_channels;
 	if (!params->n_ssids ||
 	    (params->n_ssids == 1 && !params->ssids[0].ssid_len))
-- 
2.32.0

