Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A581B7C10
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgDXQr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57980 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728568AbgDXQrW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U0-000OcH-DA; Fri, 24 Apr 2020 19:47:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:46:57 +0300
Message-Id: <iwlwifi.20200424194456.5d5c50750a52.I17e33fc268c2097b7c42877f86cef2aa163b913a@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 01/11] iwlwifi: dbg: set debug descriptor to NULL outside of iwl_fw_free_dump_desc
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

To avoid static analysis warning and to make the flow more readable, set
the debug descriptor to NULL outside iwl_fw_free_dump_desc and only in
the required places.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 37c8b6cc2ec7..4df10f3d99d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2198,12 +2198,11 @@ static u32 iwl_dump_ini_file_gen(struct iwl_fw_runtime *fwrt,
 }
 
 static inline void iwl_fw_free_dump_desc(struct iwl_fw_runtime *fwrt,
-					 const struct iwl_fw_dump_desc **desc)
+					 const struct iwl_fw_dump_desc *desc)
 {
-	if (desc && *desc != &iwl_dump_desc_assert)
-		kfree(*desc);
+	if (desc && desc != &iwl_dump_desc_assert)
+		kfree(desc);
 
-	*desc = NULL;
 	fwrt->dump.lmac_err_id[0] = 0;
 	if (fwrt->smem_cfg.num_lmacs > 1)
 		fwrt->dump.lmac_err_id[1] = 0;
@@ -2315,7 +2314,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	unsigned long idx;
 
 	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
-		iwl_fw_free_dump_desc(fwrt, &desc);
+		iwl_fw_free_dump_desc(fwrt, desc);
 		return 0;
 	}
 
@@ -2336,7 +2335,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	wk_data = &fwrt->dump.wks[idx];
 
 	if (WARN_ON(wk_data->dump_data.desc))
-		iwl_fw_free_dump_desc(fwrt, &wk_data->dump_data.desc);
+		iwl_fw_free_dump_desc(fwrt, wk_data->dump_data.desc);
 
 	wk_data->dump_data.desc = desc;
 	wk_data->dump_data.monitor_only = monitor_only;
@@ -2593,10 +2592,12 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 
 out:
-	if (iwl_trans_dbg_ini_valid(fwrt->trans))
+	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
 		iwl_fw_error_dump_data_free(dump_data);
-	else
-		iwl_fw_free_dump_desc(fwrt, &dump_data->desc);
+	} else {
+		iwl_fw_free_dump_desc(fwrt, dump_data->desc);
+		dump_data->desc = NULL;
+	}
 
 	clear_bit(wk_idx, &fwrt->dump.active_wks);
 }
-- 
2.26.2

