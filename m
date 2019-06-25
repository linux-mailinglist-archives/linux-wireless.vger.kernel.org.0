Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A3652879
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfFYJpm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54664 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727729AbfFYJpl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:41 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0d-0007Nv-Ks; Tue, 25 Jun 2019 12:45:03 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 12/12] iwlwifi: fw api: support adwell HB default APs number api
Date:   Tue, 25 Jun 2019 12:44:52 +0300
Message-Id: <20190625094452.19034-13-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Support adaptive dwell high band default number of APs new api.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h | 15 +++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h     |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h     |  6 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c    | 12 +++++++++---
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 1a67a2a439ab..c4960f045415 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -750,6 +750,21 @@ struct iwl_scan_req_umac {
 			struct iwl_scan_umac_chan_param channel;
 			u8 data[];
 		} v8; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_8 */
+		struct {
+			u8 active_dwell[SCAN_TWO_LMACS];
+			u8 adwell_default_hb_n_aps;
+			u8 adwell_default_lb_n_aps;
+			u8 adwell_default_n_aps_social;
+			u8 general_flags2;
+			__le16 adwell_max_budget;
+			__le32 max_out_time[SCAN_TWO_LMACS];
+			__le32 suspend_time[SCAN_TWO_LMACS];
+			__le32 scan_priority;
+			u8 passive_dwell[SCAN_TWO_LMACS];
+			u8 num_of_fragments[SCAN_TWO_LMACS];
+			struct iwl_scan_umac_chan_param channel;
+			u8 data[];
+		} v9; /* SCAN_REQUEST_CMD_UMAC_API_S_VER_9 */
 	};
 } __packed;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 71438c40a637..7b65a94ba7dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -319,6 +319,7 @@ enum iwl_ucode_tlv_api {
 	IWL_UCODE_TLV_API_MBSSID_HE		= (__force iwl_ucode_tlv_api_t)52,
 	IWL_UCODE_TLV_API_WOWLAN_TCP_SYN_WAKE	= (__force iwl_ucode_tlv_api_t)53,
 	IWL_UCODE_TLV_API_FTM_RTT_ACCURACY      = (__force iwl_ucode_tlv_api_t)54,
+	IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP	= (__force iwl_ucode_tlv_api_t)57,
 
 	NUM_IWL_UCODE_TLV_API
 #ifdef __CHECKER__
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 0c938fe4cbe7..e3614f59d274 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1308,6 +1308,12 @@ static inline bool iwl_mvm_is_adaptive_dwell_v2_supported(struct iwl_mvm *mvm)
 			  IWL_UCODE_TLV_API_ADAPTIVE_DWELL_V2);
 }
 
+static inline bool iwl_mvm_is_adwell_hb_ap_num_supported(struct iwl_mvm *mvm)
+{
+	return fw_has_api(&mvm->fw->ucode_capa,
+			  IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP);
+}
+
 static inline bool iwl_mvm_is_oce_supported(struct iwl_mvm *mvm)
 {
 	/* OCE should never be enabled for LMAC scan FWs */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index d9ddf9ff6428..c284e6975b1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -83,8 +83,10 @@
 #define IWL_SCAN_ADWELL_MAX_BUDGET_FULL_SCAN 300
 /* adaptive dwell max budget time [TU] for directed scan */
 #define IWL_SCAN_ADWELL_MAX_BUDGET_DIRECTED_SCAN 100
-/* adaptive dwell default APs number */
-#define IWL_SCAN_ADWELL_DEFAULT_N_APS 2
+/* adaptive dwell default high band APs number */
+#define IWL_SCAN_ADWELL_DEFAULT_HB_N_APS 8
+/* adaptive dwell default low band APs number */
+#define IWL_SCAN_ADWELL_DEFAULT_LB_N_APS 2
 /* adaptive dwell default APs number in social channels (1, 6, 11) */
 #define IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL 10
 
@@ -1288,7 +1290,11 @@ static void iwl_mvm_scan_umac_dwell(struct iwl_mvm *mvm,
 		cmd->v7.adwell_default_n_aps_social =
 			IWL_SCAN_ADWELL_DEFAULT_N_APS_SOCIAL;
 		cmd->v7.adwell_default_n_aps =
-			IWL_SCAN_ADWELL_DEFAULT_N_APS;
+			IWL_SCAN_ADWELL_DEFAULT_LB_N_APS;
+
+		if (iwl_mvm_is_adwell_hb_ap_num_supported(mvm))
+			cmd->v9.adwell_default_hb_n_aps =
+				IWL_SCAN_ADWELL_DEFAULT_HB_N_APS;
 
 		/* if custom max budget was configured with debugfs */
 		if (IWL_MVM_ADWELL_MAX_BUDGET)
-- 
2.20.1

