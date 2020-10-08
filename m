Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F1E2876CC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 17:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbgJHPKH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 11:10:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54454 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730881AbgJHPJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 11:09:57 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kQXYI-002Qut-LV; Thu, 08 Oct 2020 18:09:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  8 Oct 2020 18:09:38 +0300
Message-Id: <iwlwifi.20201008180656.798744ad514e.Ibb0d88586a34acc904bf319974d791faafb7a905@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008150949.331882-1-luca@coelho.fi>
References: <20201008150949.331882-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/13] iwlwifi: mvm: read and parse SKU ID if available
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

In v5 of the ALIVE notification, we may receive the SKU ID of the
device in use.  Read and store it locally for future access.  This
will be needed to find the correct PNVM (platform NVM) to pass to the
firmware.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 25 ++++++++++++++++---
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 45a9df0d42ed..caae7b5aa9e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -995,6 +995,7 @@ struct iwl_trans {
 	u32 hw_rf_id;
 	u32 hw_id;
 	char hw_id_str[52];
+	u32 sku_id[3];
 
 	u8 rx_mpdu_cmd, rx_mpdu_cmd_hdr_size;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1c966586c8a8..fda86c582049 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -216,10 +216,29 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	u16 status;
 	u32 lmac_error_event_table, umac_error_table;
 
-	/* we don't use the SKU ID from v5 yet, so handle it as v4 */
+	/*
+	 * For v5 and above, we can check the version, for older
+	 * versions we need to check the size.
+	 */
 	if (iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
-				    UCODE_ALIVE_NTFY, 0) == 5 ||
-	    iwl_rx_packet_payload_len(pkt) == sizeof(struct iwl_alive_ntf_v4)) {
+				    UCODE_ALIVE_NTFY, 0) == 5) {
+		struct iwl_alive_ntf_v5 *palive;
+
+		palive = (void *)pkt->data;
+		umac = &palive->umac_data;
+		lmac1 = &palive->lmac_data[0];
+		lmac2 = &palive->lmac_data[1];
+		status = le16_to_cpu(palive->status);
+
+		mvm->trans->sku_id[0] = le32_to_cpu(palive->sku_id.data[0]);
+		mvm->trans->sku_id[1] = le32_to_cpu(palive->sku_id.data[1]);
+		mvm->trans->sku_id[2] = le32_to_cpu(palive->sku_id.data[2]);
+
+		IWL_DEBUG_FW(mvm, "Got sku_id: 0x0%x 0x0%x 0x0%x\n",
+			     mvm->trans->sku_id[0],
+			     mvm->trans->sku_id[1],
+			     mvm->trans->sku_id[2]);
+	} else if (iwl_rx_packet_payload_len(pkt) == sizeof(struct iwl_alive_ntf_v4)) {
 		struct iwl_alive_ntf_v4 *palive;
 
 		palive = (void *)pkt->data;
-- 
2.28.0

