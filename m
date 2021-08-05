Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46F3E127B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 12:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbhHEKUC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 06:20:02 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51242 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240209AbhHEKT7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 06:19:59 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mBaTX-00240Q-4J; Thu, 05 Aug 2021 13:19:44 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu,  5 Aug 2021 13:19:30 +0300
Message-Id: <iwlwifi.20210805130823.02512b7a1443.Ibb023b09b86179ed049a195f4e32e887c2f4971d@changeid>
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
Subject: [PATCH 08/12] iwlwifi: mvm: Refactor setting of SSIDs for 6GHz scan
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

- Short SSIDs should always be added for direct SSIDs included
  in the scan request. However, this was not done in case that
  information for collocated APs was included. Fix this.
- With the above fix, if the FW also supports discovery of hidden
  APs over the 6GHz band, also set the corresponding full SSID
  information.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 104 +++++-------------
 1 file changed, 28 insertions(+), 76 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 82ab08af0e21..e1b436e805b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1661,22 +1661,32 @@ iwl_mvm_umac_scan_cfg_channels_v6(struct iwl_mvm *mvm,
 }
 
 static int
-iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm_scan_params *params,
-				    __le32 *cmd_short_ssid, u8 *cmd_bssid,
-				    u8 *scan_ssid_num, u8 *bssid_num)
+iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
+				    struct iwl_mvm_scan_params *params,
+				     struct iwl_scan_probe_params_v4 *pp)
 {
 	int j, idex_s = 0, idex_b = 0;
 	struct cfg80211_scan_6ghz_params *scan_6ghz_params =
 		params->scan_6ghz_params;
+	bool hidden_supported = fw_has_capa(&mvm->fw->ucode_capa,
+					    IWL_UCODE_TLV_CAPA_HIDDEN_6GHZ_SCAN);
 
-	if (!params->n_6ghz_params) {
-		for (j = 0; j < params->n_ssids; j++) {
-			cmd_short_ssid[idex_s++] =
-				cpu_to_le32(~crc32_le(~0, params->ssids[j].ssid,
-						      params->ssids[j].ssid_len));
-			(*scan_ssid_num)++;
+	for (j = 0; j < params->n_ssids && idex_s < SCAN_SHORT_SSID_MAX_SIZE;
+	     j++) {
+		if (!params->ssids[j].ssid_len)
+			continue;
+
+		pp->short_ssid[idex_s] =
+			cpu_to_le32(~crc32_le(~0, params->ssids[j].ssid,
+					      params->ssids[j].ssid_len));
+
+		if (hidden_supported) {
+			pp->direct_scan[idex_s].id = WLAN_EID_SSID;
+			pp->direct_scan[idex_s].len = params->ssids[j].ssid_len;
+			memcpy(pp->direct_scan[idex_s].ssid, params->ssids[j].ssid,
+			       params->ssids[j].ssid_len);
 		}
-		return 0;
+		idex_s++;
 	}
 
 	/*
@@ -1693,31 +1703,32 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm_scan_params *params,
 		/* First, try to place the short SSID */
 		if (scan_6ghz_params[j].short_ssid_valid) {
 			for (k = 0; k < idex_s; k++) {
-				if (cmd_short_ssid[k] ==
+				if (pp->short_ssid[k] ==
 				    cpu_to_le32(scan_6ghz_params[j].short_ssid))
 					break;
 			}
 
 			if (k == idex_s && idex_s < SCAN_SHORT_SSID_MAX_SIZE) {
-				cmd_short_ssid[idex_s++] =
+				pp->short_ssid[idex_s++] =
 					cpu_to_le32(scan_6ghz_params[j].short_ssid);
-				(*scan_ssid_num)++;
 			}
 		}
 
 		/* try to place BSSID for the same entry */
 		for (k = 0; k < idex_b; k++) {
-			if (!memcmp(&cmd_bssid[ETH_ALEN * k],
+			if (!memcmp(&pp->bssid_array[k],
 				    scan_6ghz_params[j].bssid, ETH_ALEN))
 				break;
 		}
 
 		if (k == idex_b && idex_b < SCAN_BSSID_MAX_SIZE) {
-			memcpy(&cmd_bssid[ETH_ALEN * idex_b++],
+			memcpy(&pp->bssid_array[idex_b++],
 			       scan_6ghz_params[j].bssid, ETH_ALEN);
-			(*bssid_num)++;
 		}
 	}
+
+	pp->short_ssid_num = idex_s;
+	pp->bssid_num = idex_b;
 	return 0;
 }
 
@@ -1865,60 +1876,6 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm_scan_params *params,
 	}
 }
 
-static void
-iwl_mvm_umac_scan_cfg_6g_direct_ssids(struct iwl_mvm *mvm,
-				      struct iwl_mvm_scan_params *params,
-				      struct iwl_scan_probe_params_v4 *pp)
-{
-	u8 next_free_idx = pp->short_ssid_num;
-	int i;
-
-	if (!fw_has_capa(&mvm->fw->ucode_capa,
-			 IWL_UCODE_TLV_CAPA_HIDDEN_6GHZ_SCAN)) {
-		IWL_DEBUG_SCAN(mvm,
-			       "6GHz hidden scan: Not supported by FW\n");
-		return;
-	}
-
-	for (i = params->n_ssids - 1; i >= 0; i--) {
-		__le32 short_ssid;
-		u8 ssid_idx, j;
-
-		if (!params->ssids[i].ssid_len)
-			continue;
-
-		short_ssid = cpu_to_le32(~crc32_le(~0, params->ssids[i].ssid,
-						   params->ssids[i].ssid_len));
-
-		for (j = 0; j < pp->short_ssid_num; j++)
-			if (short_ssid == pp->short_ssid[j])
-				break;
-
-		if (j == pp->short_ssid_num) {
-			/*
-			 * If there are no available slots for the short SSID, do not
-			 * place it.
-			 */
-			if (next_free_idx < SCAN_SHORT_SSID_MAX_SIZE)
-				ssid_idx = next_free_idx++;
-			else
-				continue;
-		} else {
-			ssid_idx = j;
-		}
-
-		if (ssid_idx >= PROBE_OPTION_MAX)
-			continue;
-
-		pp->direct_scan[ssid_idx].id = WLAN_EID_SSID;
-		pp->direct_scan[ssid_idx].len = params->ssids[i].ssid_len;
-		memcpy(pp->direct_scan[ssid_idx].ssid, params->ssids[i].ssid,
-		       params->ssids[i].ssid_len);
-	}
-
-	pp->short_ssid_num = next_free_idx;
-}
-
 static u8 iwl_mvm_scan_umac_chan_flags_v2(struct iwl_mvm *mvm,
 					  struct iwl_mvm_scan_params *params,
 					  struct ieee80211_vif *vif)
@@ -2445,15 +2402,10 @@ static int iwl_mvm_scan_umac_v14(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cp->n_aps_override[0] = IWL_SCAN_ADWELL_N_APS_GO_FRIENDLY;
 	cp->n_aps_override[1] = IWL_SCAN_ADWELL_N_APS_SOCIAL_CHS;
 
-	ret = iwl_mvm_umac_scan_fill_6g_chan_list(params, pb->short_ssid,
-						  pb->bssid_array[0],
-						  &pb->short_ssid_num,
-						  &pb->bssid_num);
+	ret = iwl_mvm_umac_scan_fill_6g_chan_list(mvm, params, pb);
 	if (ret)
 		return ret;
 
-	iwl_mvm_umac_scan_cfg_6g_direct_ssids(mvm, params, pb);
-
 	iwl_mvm_umac_scan_cfg_channels_v6_6g(params,
 					     params->n_channels,
 					     pb, cp, vif->type);
-- 
2.32.0

