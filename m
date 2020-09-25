Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4C279395
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 23:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgIYVbL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 17:31:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52376 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729008AbgIYVbL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 17:31:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLvJ3-002J1P-0X; Sat, 26 Sep 2020 00:31:05 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 26 Sep 2020 00:30:49 +0300
Message-Id: <iwlwifi.20200926002540.299959eeb47b.Ie1f3eecc06e3620098dda74f674f6409b90fe7fa@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925213053.454459-1-luca@coelho.fi>
References: <20200925213053.454459-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/15] iwlwifi: mvm: remove redundant support_umac_log field
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Currently we have the same info in two variables,
If umac_error_event_table is 0, we know that UMAC log is not supported,
so we don't need the support_umac_log field.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 32 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  2 +-
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ba7d57b40c79..ce0e0ff6193d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -216,7 +216,7 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 	struct iwl_lmac_alive *lmac1;
 	struct iwl_lmac_alive *lmac2 = NULL;
 	u16 status;
-	u32 lmac_error_event_table, umac_error_event_table;
+	u32 lmac_error_event_table, umac_error_table;
 
 	if (iwl_rx_packet_payload_len(pkt) == sizeof(*palive)) {
 		palive = (void *)pkt->data;
@@ -239,26 +239,22 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		mvm->trans->dbg.lmac_error_event_table[1] =
 			le32_to_cpu(lmac2->dbg_ptrs.error_event_table_ptr);
 
-	umac_error_event_table = le32_to_cpu(umac->dbg_ptrs.error_info_addr);
+	umac_error_table = le32_to_cpu(umac->dbg_ptrs.error_info_addr);
 
-	if (!umac_error_event_table) {
-		mvm->support_umac_log = false;
-	} else if (umac_error_event_table >=
-		   mvm->trans->cfg->min_umac_error_event_table) {
-		mvm->support_umac_log = true;
-	} else {
-		IWL_ERR(mvm,
-			"Not valid error log pointer 0x%08X for %s uCode\n",
-			umac_error_event_table,
-			(mvm->fwrt.cur_fw_img == IWL_UCODE_INIT) ?
-			"Init" : "RT");
-		mvm->support_umac_log = false;
+	if (umac_error_table) {
+		if (umac_error_table >=
+		    mvm->trans->cfg->min_umac_error_event_table) {
+			iwl_fw_umac_set_alive_err_table(mvm->trans,
+							umac_error_table);
+		} else {
+			IWL_ERR(mvm,
+				"Not valid error log pointer 0x%08X for %s uCode\n",
+				umac_error_table,
+				(mvm->fwrt.cur_fw_img == IWL_UCODE_INIT) ?
+				"Init" : "RT");
+		}
 	}
 
-	if (mvm->support_umac_log)
-		iwl_fw_umac_set_alive_err_table(mvm->trans,
-						umac_error_event_table);
-
 	alive_data->scd_base_addr = le32_to_cpu(lmac1->dbg_ptrs.scd_base_ptr);
 	alive_data->valid = status == IWL_ALIVE_STATUS_OK;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f39be84aa279..05b707e23e39 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -852,7 +852,6 @@ struct iwl_mvm {
 
 	bool hw_registered;
 	bool rfkill_safe_init_done;
-	bool support_umac_log;
 
 	u32 ampdu_ref;
 	bool ampdu_toggle;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 52a052e92b94..ae39d81d74c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -425,7 +425,7 @@ static void iwl_mvm_dump_umac_error_log(struct iwl_mvm *mvm)
 	struct iwl_umac_error_event_table table;
 	u32 base = mvm->trans->dbg.umac_error_event_table;
 
-	if (!mvm->support_umac_log &&
+	if (!base &&
 	    !(mvm->trans->dbg.error_event_table_tlv_status &
 	      IWL_ERROR_EVENT_TABLE_UMAC))
 		return;
-- 
2.28.0

