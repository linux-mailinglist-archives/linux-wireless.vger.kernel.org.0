Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A87D2D4CB7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbgLIVSc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:18:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35722 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726877AbgLIVSc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:18:32 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6py-003Drx-NF; Wed, 09 Dec 2020 23:17:27 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:48 +0200
Message-Id: <iwlwifi.20201209231352.ee57c3214d05.I810d7de33fb08001ef1a2e24714d5b68932e088e@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 44/47] iwlwifi: mvm: add size checks for range response notification
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The range response notification has several versions. Check the
notification size according to the expected notification version.
Notifications with incorrect size will be ignored.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index d121f682f875..a4fd0bf9ba19 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -977,9 +977,44 @@ iwl_mvm_ftm_pasn_update_pn(struct iwl_mvm *mvm,
 	}
 }
 
+static u8 iwl_mvm_ftm_get_range_resp_ver(struct iwl_mvm *mvm)
+{
+	if (!fw_has_api(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_API_FTM_NEW_RANGE_REQ))
+		return 5;
+
+	/* Starting from version 8, the FW advertises the version */
+	if (mvm->cmd_ver.range_resp >= 8)
+		return mvm->cmd_ver.range_resp;
+	else if (fw_has_api(&mvm->fw->ucode_capa,
+			    IWL_UCODE_TLV_API_FTM_RTT_ACCURACY))
+		return 7;
+
+	/* The first version of the new range request API */
+	return 6;
+}
+
+static bool iwl_mvm_ftm_resp_size_validation(u8 ver, unsigned int pkt_len)
+{
+	switch (ver) {
+	case 8:
+		return pkt_len == sizeof(struct iwl_tof_range_rsp_ntfy_v8);
+	case 7:
+		return pkt_len == sizeof(struct iwl_tof_range_rsp_ntfy_v7);
+	case 6:
+		return pkt_len == sizeof(struct iwl_tof_range_rsp_ntfy_v6);
+	case 5:
+		return pkt_len == sizeof(struct iwl_tof_range_rsp_ntfy_v5);
+	default:
+		WARN_ONCE(1, "FTM: unsupported range response version %u", ver);
+		return false;
+	}
+}
+
 void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 {
 	struct iwl_rx_packet *pkt = rxb_addr(rxb);
+	unsigned int pkt_len = iwl_rx_packet_payload_len(pkt);
 	struct iwl_tof_range_rsp_ntfy_v5 *fw_resp_v5 = (void *)pkt->data;
 	struct iwl_tof_range_rsp_ntfy_v6 *fw_resp_v6 = (void *)pkt->data;
 	struct iwl_tof_range_rsp_ntfy_v7 *fw_resp_v7 = (void *)pkt->data;
@@ -988,6 +1023,7 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	bool new_api = fw_has_api(&mvm->fw->ucode_capa,
 				  IWL_UCODE_TLV_API_FTM_NEW_RANGE_REQ);
 	u8 num_of_aps, last_in_batch;
+	u8 notif_ver = iwl_mvm_ftm_get_range_resp_ver(mvm);
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -995,6 +1031,9 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		return;
 	}
 
+	if (unlikely(!iwl_mvm_ftm_resp_size_validation(notif_ver, pkt_len)))
+		return;
+
 	if (new_api) {
 		if (iwl_mvm_ftm_range_resp_valid(mvm, fw_resp_v8->request_id,
 						 fw_resp_v8->num_of_aps))
@@ -1021,11 +1060,10 @@ void iwl_mvm_ftm_range_resp(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 		int peer_idx;
 
 		if (new_api) {
-			if (mvm->cmd_ver.range_resp == 8) {
+			if (notif_ver == 8) {
 				fw_ap = &fw_resp_v8->ap[i];
 				iwl_mvm_ftm_pasn_update_pn(mvm, fw_ap);
-			} else if (fw_has_api(&mvm->fw->ucode_capa,
-					      IWL_UCODE_TLV_API_FTM_RTT_ACCURACY)) {
+			} else if (notif_ver == 7) {
 				fw_ap = (void *)&fw_resp_v7->ap[i];
 			} else {
 				fw_ap = (void *)&fw_resp_v6->ap[i];
-- 
2.29.2

