Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF95A2F9310
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 15:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbhAQOxc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 09:53:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40736 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728859AbhAQOxZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 09:53:25 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l19Py-003sgA-IG; Sun, 17 Jan 2021 16:52:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 16:52:28 +0200
Message-Id: <iwlwifi.20210117164916.0c790e930484.I23ef2cb9c871e6adc4aab6be378f3811cb531155@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117145234.1435324-1-luca@coelho.fi>
References: <20210117145234.1435324-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 3/9] iwlwifi: parse phy integration string from FW TLV
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dror Moshe <drorx.moshe@intel.com>

Parse phy integration string from FW TLV.

Signed-off-by: Dror Moshe <drorx.moshe@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h |  1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h  |  3 +++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 597bc88479ba..7cd9c0bf5ba2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -93,6 +93,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_FW_RECOVERY_INFO	= 57,
 	IWL_UCODE_TLV_HW_TYPE			= 58,
 	IWL_UCODE_TLV_FW_FSEQ_VERSION		= 60,
+	IWL_UCODE_TLV_PHY_INTEGRATION_VERSION	= 61,
 
 	IWL_UCODE_TLV_PNVM_VERSION		= 62,
 	IWL_UCODE_TLV_PNVM_SKU			= 64,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index c93d247621ec..1dee4714e505 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -219,6 +219,9 @@ struct iwl_fw {
 	u8 human_readable[FW_VER_HUMAN_READABLE_SZ];
 
 	struct iwl_fw_dbg dbg;
+
+	u8 *phy_integration_ver;
+	u32 phy_integration_ver_len;
 };
 
 static inline const char *get_fw_dbg_mode_string(int mode)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index d44bc61c34f5..263c3c0bb8ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -127,6 +127,7 @@ static void iwl_dealloc_ucode(struct iwl_drv *drv)
 	kfree(drv->fw.dbg.mem_tlv);
 	kfree(drv->fw.iml);
 	kfree(drv->fw.ucode_capa.cmd_versions);
+	kfree(drv->fw.phy_integration_ver);
 
 	for (i = 0; i < IWL_UCODE_TYPE_MAX; i++)
 		iwl_free_fw_img(drv, drv->fw.img + i);
@@ -1143,6 +1144,19 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 			capa->n_cmd_versions =
 				tlv_len / sizeof(struct iwl_fw_cmd_version);
 			break;
+		case IWL_UCODE_TLV_PHY_INTEGRATION_VERSION:
+			if (drv->fw.phy_integration_ver) {
+				IWL_ERR(drv,
+					"phy integration str ignored, already exists\n");
+				break;
+			}
+
+			drv->fw.phy_integration_ver =
+				kmemdup(tlv_data, tlv_len, GFP_KERNEL);
+			if (!drv->fw.phy_integration_ver)
+				return -ENOMEM;
+			drv->fw.phy_integration_ver_len = tlv_len;
+			break;
 		default:
 			IWL_DEBUG_INFO(drv, "unknown TLV: %d\n", tlv_type);
 			break;
-- 
2.29.2

