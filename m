Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5363D97B21
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfHUNkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:40:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37860 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726484AbfHUNkL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:40:11 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0QoZ-0000lZ-Pi; Wed, 21 Aug 2019 16:38:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:55 +0300
Message-Id: <20190821133800.23636-14-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 13/18] iwlwifi: dbg_ini: align dbg tlv functions names to a single format
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

align the naming to iwl_dbg_tlv_*

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 20 +++++++++----------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  | 14 ++++++-------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 10 +++++-----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index fcaec410b3be..240e48b1d1c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -63,8 +63,8 @@
 #include "iwl-trans.h"
 #include "iwl-dbg-tlv.h"
 
-void iwl_fw_dbg_copy_tlv(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
-			 bool ext)
+void iwl_dbg_tlv_copy(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
+		      bool ext)
 {
 	struct iwl_apply_point_data *data;
 	struct iwl_fw_ini_header *header = (void *)&tlv->data[0];
@@ -106,7 +106,7 @@ void iwl_fw_dbg_copy_tlv(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 	data->offset += offset_size;
 }
 
-void iwl_alloc_dbg_tlv(struct iwl_trans *trans, size_t len, const u8 *data,
+void iwl_dbg_tlv_alloc(struct iwl_trans *trans, size_t len, const u8 *data,
 		       bool ext)
 {
 	struct iwl_ucode_tlv *tlv;
@@ -183,7 +183,7 @@ void iwl_alloc_dbg_tlv(struct iwl_trans *trans, size_t len, const u8 *data,
 	}
 }
 
-void iwl_fw_dbg_free(struct iwl_trans *trans)
+void iwl_dbg_tlv_free(struct iwl_trans *trans)
 {
 	int i;
 
@@ -198,8 +198,8 @@ void iwl_fw_dbg_free(struct iwl_trans *trans)
 	}
 }
 
-static int iwl_parse_fw_dbg_tlv(struct iwl_trans *trans, const u8 *data,
-				size_t len)
+static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,
+				 size_t len)
 {
 	struct iwl_ucode_tlv *tlv;
 	enum iwl_ucode_tlv_type tlv_type;
@@ -227,7 +227,7 @@ static int iwl_parse_fw_dbg_tlv(struct iwl_trans *trans, const u8 *data,
 		case IWL_UCODE_TLV_TYPE_REGIONS:
 		case IWL_UCODE_TLV_TYPE_TRIGGERS:
 		case IWL_UCODE_TLV_TYPE_DEBUG_FLOW:
-			iwl_fw_dbg_copy_tlv(trans, tlv, true);
+			iwl_dbg_tlv_copy(trans, tlv, true);
 			break;
 		default:
 			WARN_ONCE(1, "Invalid TLV %x\n", tlv_type);
@@ -238,7 +238,7 @@ static int iwl_parse_fw_dbg_tlv(struct iwl_trans *trans, const u8 *data,
 	return 0;
 }
 
-void iwl_load_fw_dbg_tlv(struct device *dev, struct iwl_trans *trans)
+void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 {
 	const struct firmware *fw;
 	int res;
@@ -250,8 +250,8 @@ void iwl_load_fw_dbg_tlv(struct device *dev, struct iwl_trans *trans)
 	if (res)
 		return;
 
-	iwl_alloc_dbg_tlv(trans, fw->size, fw->data, true);
-	iwl_parse_fw_dbg_tlv(trans, fw->data, fw->size);
+	iwl_dbg_tlv_alloc(trans, fw->size, fw->data, true);
+	iwl_dbg_tlv_parse_bin(trans, fw->data, fw->size);
 
 	trans->dbg.external_ini_loaded = true;
 	release_firmware(fw);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index 222cd789e07a..e4911ec6ce13 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,7 +28,7 @@
  *
  * BSD LICENSE
  *
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -77,11 +77,11 @@ struct iwl_apply_point_data {
 };
 
 struct iwl_trans;
-void iwl_load_fw_dbg_tlv(struct device *dev, struct iwl_trans *trans);
-void iwl_fw_dbg_free(struct iwl_trans *trans);
-void iwl_fw_dbg_copy_tlv(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
-			 bool ext);
-void iwl_alloc_dbg_tlv(struct iwl_trans *trans, size_t len, const u8 *data,
+void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans);
+void iwl_dbg_tlv_free(struct iwl_trans *trans);
+void iwl_dbg_tlv_copy(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
+		      bool ext);
+void iwl_dbg_tlv_alloc(struct iwl_trans *trans, size_t len, const u8 *data,
 		       bool ext);
 
 #endif /* __iwl_dbg_tlv_h__*/
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 7afc6e43502a..595dc2fbc3b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -648,7 +648,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 	len -= sizeof(*ucode);
 
 	if (iwlwifi_mod_params.enable_ini)
-		iwl_alloc_dbg_tlv(drv->trans, len, data, false);
+		iwl_dbg_tlv_alloc(drv->trans, len, data, false);
 
 	while (len >= sizeof(*tlv)) {
 		len -= sizeof(*tlv);
@@ -1156,7 +1156,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 		case IWL_UCODE_TLV_TYPE_TRIGGERS:
 		case IWL_UCODE_TLV_TYPE_DEBUG_FLOW:
 			if (iwlwifi_mod_params.enable_ini)
-				iwl_fw_dbg_copy_tlv(drv->trans, tlv, false);
+				iwl_dbg_tlv_copy(drv->trans, tlv, false);
 			break;
 		case IWL_UCODE_TLV_CMD_VERSIONS:
 			if (tlv_len % sizeof(struct iwl_fw_cmd_version)) {
@@ -1640,7 +1640,7 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 	init_completion(&drv->request_firmware_complete);
 	INIT_LIST_HEAD(&drv->list);
 
-	iwl_load_fw_dbg_tlv(drv->trans->dev, drv->trans);
+	iwl_dbg_tlv_load_bin(drv->trans->dev, drv->trans);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	/* Create the device debugfs entries. */
@@ -1662,8 +1662,8 @@ struct iwl_drv *iwl_drv_start(struct iwl_trans *trans)
 err_fw:
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	debugfs_remove_recursive(drv->dbgfs_drv);
+	iwl_dbg_tlv_free(drv->trans);
 #endif
-	iwl_fw_dbg_free(drv->trans);
 	kfree(drv);
 err:
 	return ERR_PTR(ret);
@@ -1693,7 +1693,7 @@ void iwl_drv_stop(struct iwl_drv *drv)
 	debugfs_remove_recursive(drv->dbgfs_drv);
 #endif
 
-	iwl_fw_dbg_free(drv->trans);
+	iwl_dbg_tlv_free(drv->trans);
 
 	kfree(drv);
 }
-- 
2.23.0.rc1

