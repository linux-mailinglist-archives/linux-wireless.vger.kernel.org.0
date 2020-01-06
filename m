Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83ED130EF5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgAFIzO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:14 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51372 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbgAFIzN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:13 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAJ-0007qa-J0; Mon, 06 Jan 2020 10:55:12 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:54:54 +0200
Message-Id: <20200106085502.363205-5-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 04/12] iwlwifi: yoyo: remove the iwl_dbg_tlv_gen_active_trigs() function
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We only call this function from a single place and it's very
very small and self-contained anyway, so remove the function and move
the code into the caller.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 4acb24f8fc11..31a0e885faf6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -908,27 +908,6 @@ iwl_dbg_tlv_gen_active_trig_list(struct iwl_fw_runtime *fwrt,
 	}
 }
 
-static int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt,
-					u32 new_domain)
-{
-	int i;
-
-	fwrt->trans->dbg.domains_bitmap = new_domain;
-
-	IWL_DEBUG_FW(fwrt,
-		     "WRT: Generating active triggers list, domain 0x%x\n",
-		     fwrt->trans->dbg.domains_bitmap);
-
-	for (i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.time_point); i++) {
-		struct iwl_dbg_tlv_time_point_data *tp =
-			&fwrt->trans->dbg.time_point[i];
-
-		iwl_dbg_tlv_gen_active_trig_list(fwrt, tp);
-	}
-
-	return 0;
-}
-
 static bool iwl_dbg_tlv_check_fw_pkt(struct iwl_fw_runtime *fwrt,
 				     struct iwl_fwrt_dump_data *dump_data,
 				     union iwl_dbg_tlv_tp_data *tp_data,
@@ -1002,7 +981,18 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 	enum iwl_fw_ini_buffer_location *ini_dest = &fwrt->trans->dbg.ini_dest;
 	int ret, i;
 
-	iwl_dbg_tlv_gen_active_trigs(fwrt, IWL_FW_DBG_DOMAIN);
+	fwrt->trans->dbg.domains_bitmap = IWL_FW_DBG_DOMAIN;
+
+	IWL_DEBUG_FW(fwrt,
+		     "WRT: Generating active triggers list, domain 0x%x\n",
+		     fwrt->trans->dbg.domains_bitmap);
+
+	for (i = 0; i < ARRAY_SIZE(fwrt->trans->dbg.time_point); i++) {
+		struct iwl_dbg_tlv_time_point_data *tp =
+			&fwrt->trans->dbg.time_point[i];
+
+		iwl_dbg_tlv_gen_active_trig_list(fwrt, tp);
+	}
 
 	*ini_dest = IWL_FW_INI_LOCATION_INVALID;
 	for (i = 0; i < IWL_FW_INI_ALLOCATION_NUM; i++) {
-- 
2.24.1

