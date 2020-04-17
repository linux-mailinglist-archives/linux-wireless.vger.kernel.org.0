Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19CD1ADAE9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgDQKWE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:22:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56632 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729105AbgDQKWB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:22:01 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPO8C-000Kba-QN; Fri, 17 Apr 2020 13:21:57 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 17 Apr 2020 13:21:42 +0300
Message-Id: <iwlwifi.20200417131727.bd46e6240590.Ibda6d9d330a1ae49670152cede34629b280f6cf9@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200417102142.2173014-1-luca@coelho.fi>
References: <20200417102142.2173014-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/10] iwlwifi: yoyo: support IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT time point
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allow the driver to perform dump collection in case of alive notification
timeout in yoyo mode.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 42 ++++++++++++++-------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 8daa83cdc72c..39c8332be3ac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2329,26 +2329,40 @@ IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect_desc);
 int iwl_fw_dbg_error_collect(struct iwl_fw_runtime *fwrt,
 			     enum iwl_fw_dbg_trigger trig_type)
 {
-	int ret;
-	struct iwl_fw_dump_desc *iwl_dump_error_desc;
-
 	if (!test_bit(STATUS_DEVICE_ENABLED, &fwrt->trans->status))
 		return -EIO;
 
-	iwl_dump_error_desc = kmalloc(sizeof(*iwl_dump_error_desc), GFP_KERNEL);
-	if (!iwl_dump_error_desc)
-		return -ENOMEM;
+	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
+		if (trig_type != FW_DBG_TRIGGER_ALIVE_TIMEOUT)
+			return -EIO;
 
-	iwl_dump_error_desc->trig_desc.type = cpu_to_le32(trig_type);
-	iwl_dump_error_desc->len = 0;
+		iwl_dbg_tlv_time_point(fwrt,
+				       IWL_FW_INI_TIME_POINT_HOST_ALIVE_TIMEOUT,
+				       NULL);
+	} else {
+		struct iwl_fw_dump_desc *iwl_dump_error_desc;
+		int ret;
 
-	ret = iwl_fw_dbg_collect_desc(fwrt, iwl_dump_error_desc, false, 0);
-	if (ret)
-		kfree(iwl_dump_error_desc);
-	else
-		iwl_trans_sync_nmi(fwrt->trans);
+		iwl_dump_error_desc =
+			kmalloc(sizeof(*iwl_dump_error_desc), GFP_KERNEL);
 
-	return ret;
+		if (!iwl_dump_error_desc)
+			return -ENOMEM;
+
+		iwl_dump_error_desc->trig_desc.type = cpu_to_le32(trig_type);
+		iwl_dump_error_desc->len = 0;
+
+		ret = iwl_fw_dbg_collect_desc(fwrt, iwl_dump_error_desc,
+					      false, 0);
+		if (ret) {
+			kfree(iwl_dump_error_desc);
+			return ret;
+		}
+	}
+
+	iwl_trans_sync_nmi(fwrt->trans);
+
+	return 0;
 }
 IWL_EXPORT_SYMBOL(iwl_fw_dbg_error_collect);
 
-- 
2.25.1

