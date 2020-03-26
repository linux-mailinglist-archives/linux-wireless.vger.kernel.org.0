Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6DC9193F4B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgCZMzV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:55:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44192 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728065AbgCZMzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:55:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHS2Z-00040Z-8m; Thu, 26 Mar 2020 14:55:19 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:54:59 +0200
Message-Id: <iwlwifi.20200326145047.9f3f3a11ed27.Ib4d0c471da9c50d9981541a7f5926db384a0f7ce@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326125510.621842-1-luca@coelho.fi>
References: <20200326125510.621842-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/12] iwlwifi: mvm: add support for non EDCA based measurements
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

Add support for requesting trigger-based / non trigger-based
measurements.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 9 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      | 5 ++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index a0d6802c2715..0214e553d5ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -427,6 +427,9 @@ struct iwl_tof_range_req_ap_entry_v2 {
  *	Default algo type is ML.
  * @IWL_INITIATOR_AP_FLAGS_MCSI_REPORT: Send the MCSI for each FTM frame to the
  *	driver.
+ * @IWL_INITIATOR_AP_FLAGS_NON_TB: Use non trigger based flow
+ * @IWL_INITIATOR_AP_FLAGS_TB: Use trigger based flow
+ * @IWL_INITIATOR_AP_FLAGS_SECURED: request secured measurement
  */
 enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_ASAP = BIT(1),
@@ -436,6 +439,9 @@ enum iwl_initiator_ap_flags {
 	IWL_INITIATOR_AP_FLAGS_ALGO_LR = BIT(5),
 	IWL_INITIATOR_AP_FLAGS_ALGO_FFT = BIT(6),
 	IWL_INITIATOR_AP_FLAGS_MCSI_REPORT = BIT(8),
+	IWL_INITIATOR_AP_FLAGS_NON_TB = BIT(9),
+	IWL_INITIATOR_AP_FLAGS_TB = BIT(10),
+	IWL_INITIATOR_AP_FLAGS_SECURED = BIT(11),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 6e1ea921c299..9e21f5e5d364 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -278,6 +278,10 @@ iwl_mvm_ftm_target_chandef_v2(struct iwl_mvm *mvm,
 		return -EINVAL;
 	}
 
+	/* non EDCA based measurement must use HE preamble */
+	if (peer->ftm.trigger_based || peer->ftm.non_trigger_based)
+		*format_bw |= IWL_LOCATION_FRAME_FORMAT_HE;
+
 	*ctrl_ch_position = (peer->chandef.width > NL80211_CHAN_WIDTH_20) ?
 		iwl_mvm_get_ctrl_pos(&peer->chandef) : 0;
 
@@ -349,6 +353,11 @@ iwl_mvm_ftm_put_target_common(struct iwl_mvm *mvm,
 		FTM_PUT_FLAG(ALGO_LR);
 	else if (IWL_MVM_FTM_INITIATOR_ALGO == IWL_TOF_ALGO_TYPE_FFT)
 		FTM_PUT_FLAG(ALGO_FFT);
+
+	if (peer->ftm.trigger_based)
+		FTM_PUT_FLAG(TB);
+	else if (peer->ftm.non_trigger_based)
+		FTM_PUT_FLAG(NON_TB);
 }
 
 static int
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7b6d14445f1b..c9c40965de4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -193,6 +193,8 @@ static const struct cfg80211_pmsr_capabilities iwl_mvm_pmsr_capa = {
 		.non_asap = 1,
 		.request_lci = 1,
 		.request_civicloc = 1,
+		.trigger_based = 1,
+		.non_trigger_based = 1,
 		.max_bursts_exponent = -1, /* all supported */
 		.max_ftms_per_burst = 0, /* no limits */
 		.bandwidths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
@@ -201,7 +203,8 @@ static const struct cfg80211_pmsr_capabilities iwl_mvm_pmsr_capa = {
 			      BIT(NL80211_CHAN_WIDTH_80),
 		.preambles = BIT(NL80211_PREAMBLE_LEGACY) |
 			     BIT(NL80211_PREAMBLE_HT) |
-			     BIT(NL80211_PREAMBLE_VHT),
+			     BIT(NL80211_PREAMBLE_VHT) |
+			     BIT(NL80211_PREAMBLE_HE),
 	},
 };
 
-- 
2.25.1

