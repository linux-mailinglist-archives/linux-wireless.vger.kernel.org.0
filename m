Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF56E43078D
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245182AbhJQJmv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53700 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245179AbhJQJmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2ef-000YUg-3S; Sun, 17 Oct 2021 12:40:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:18 +0300
Message-Id: <iwlwifi.20211017123741.c5c6c863631e.I4b493f4eeabbfa1dc965ae012b72fc57de7d5f4f@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: mvm: Support new version of ranging response notification
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

As part of the new rate_n_flags, FW added a new version for
LOCATION_RANGE_RSP_NTFY, and it's internal structure -
LOCATION_RANGE_RSP_AP_ETRY_NTFY. Add support for this.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   | 7 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 5f27829f8996..12af94e166ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -1501,7 +1501,9 @@ struct iwl_tof_range_rsp_ap_entry_ntfy_v6 {
 	u8 reserved[3];
 	u8 rx_pn[IEEE80211_CCMP_PN_LEN];
 	u8 tx_pn[IEEE80211_CCMP_PN_LEN];
-} __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_6 */
+} __packed; /* LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_6,
+	       LOCATION_RANGE_RSP_AP_ETRY_NTFY_API_S_VER_7 */
+
 
 /**
  * enum iwl_tof_response_status - tof response status
@@ -1582,7 +1584,8 @@ struct iwl_tof_range_rsp_ntfy_v8 {
 	u8 last_report;
 	u8 reserved;
 	struct iwl_tof_range_rsp_ap_entry_ntfy_v6 ap[IWL_MVM_TOF_MAX_APS];
-} __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_8 */
+} __packed; /* LOCATION_RANGE_RSP_NTFY_API_S_VER_8,
+	       LOCATION_RANGE_RSP_NTFY_API_S_VER_9 */
 
 #define IWL_MVM_TOF_MCSI_BUF_SIZE  (245)
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 73be95fffb95..949fb790f8fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1154,6 +1154,7 @@ static u8 iwl_mvm_ftm_get_range_resp_ver(struct iwl_mvm *mvm)
 static bool iwl_mvm_ftm_resp_size_validation(u8 ver, unsigned int pkt_len)
 {
 	switch (ver) {
+	case 9:
 	case 8:
 		return pkt_len == sizeof(struct iwl_tof_range_rsp_ntfy_v8);
 	case 7:
@@ -1217,7 +1218,7 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		int peer_idx;
 
 		if (new_api) {
-			if (notif_ver == 8) {
+			if (notif_ver >= 8) {
 				fw_ap = &fw_resp_v8->ap[i];
 				iwl_mvm_ftm_pasn_update_pn(mvm, fw_ap);
 			} else if (notif_ver == 7) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 3b0d5a068541..e331e18b9ab1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1044,8 +1044,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	mvm->cmd_ver.range_resp =
 		iwl_fw_lookup_notif_ver(mvm->fw, LOCATION_GROUP,
 					TOF_RANGE_RESPONSE_NOTIF, 5);
-	/* we only support up to version 8 */
-	if (WARN_ON_ONCE(mvm->cmd_ver.range_resp > 8))
+	/* we only support up to version 9 */
+	if (WARN_ON_ONCE(mvm->cmd_ver.range_resp > 9))
 		goto out_free;
 
 	/*
-- 
2.33.0

