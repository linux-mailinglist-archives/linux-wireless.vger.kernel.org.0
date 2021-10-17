Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04EB430787
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 11:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbhJQJmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 05:42:37 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53664 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241728AbhJQJmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 05:42:36 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc2eX-000YUg-B3; Sun, 17 Oct 2021 12:40:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 12:40:12 +0300
Message-Id: <iwlwifi.20211017123741.ec280bcb32cb.Iac0da0e22d7c3c0e237867c9113a06ddd95c7a51@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017094019.442271-1-luca@coelho.fi>
References: <20211017094019.442271-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: parse debug exclude data from firmware file
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Parse the memory dump exclusion TLVs from the firmware file
and save the data to be able to apply them later upon dump.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h |  7 ++++
 drivers/net/wireless/intel/iwlwifi/fw/img.h  |  8 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 42 ++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 6c8e9f3a6af2..3a031070d367 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -100,6 +100,9 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_PNVM_SKU			= 64,
 	IWL_UCODE_TLV_TCM_DEBUG_ADDRS		= 65,
 
+	IWL_UCODE_TLV_SEC_TABLE_ADDR		= 66,
+	IWL_UCODE_TLV_D3_KEK_KCK_ADDR		= 67,
+
 	IWL_UCODE_TLV_FW_NUM_STATIONS		= IWL_UCODE_TLV_CONST_BASE + 0,
 
 	IWL_UCODE_TLV_TYPE_DEBUG_INFO		= IWL_UCODE_TLV_DEBUG_BASE + 0,
@@ -956,6 +959,10 @@ struct iwl_fw_tcm_error_addr {
 	__le32 addr;
 }; /* FW_TLV_TCM_ERROR_INFO_ADDRS_S */
 
+struct iwl_fw_dump_exclude {
+	__le32 addr, size;
+};
+
 static inline size_t _iwl_tlv_array_len(const struct iwl_ucode_tlv *tlv,
 					size_t fixed_size, size_t var_size)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 6099d1edaff2..993bda17fa30 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -176,6 +176,10 @@ struct iwl_fw_dbg {
 	u32 dump_mask;
 };
 
+struct iwl_dump_exclude {
+	u32 addr, size;
+};
+
 /**
  * struct iwl_fw - variables associated with the firmware
  *
@@ -198,6 +202,8 @@ struct iwl_fw_dbg {
  *	we get the ALIVE from the uCode
  * @phy_integration_ver: PHY integration version string
  * @phy_integration_ver_len: length of @phy_integration_ver
+ * @dump_excl: image dump exclusion areas for RT image
+ * @dump_excl_wowlan: image dump exclusion areas for WoWLAN image
  */
 struct iwl_fw {
 	u32 ucode_ver;
@@ -229,6 +235,8 @@ struct iwl_fw {
 
 	u8 *phy_integration_ver;
 	u32 phy_integration_ver_len;
+
+	struct iwl_dump_exclude dump_excl[2], dump_excl_wowlan[2];
 };
 
 static inline const char *get_fw_dbg_mode_string(int mode)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 6712ff6772e7..8296b71aa76f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -549,6 +549,43 @@ static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
 	return 0;
 }
 
+static void iwl_drv_set_dump_exclude(struct iwl_drv *drv,
+				     enum iwl_ucode_tlv_type tlv_type,
+				     const void *tlv_data, u32 tlv_len)
+{
+	const struct iwl_fw_dump_exclude *fw = tlv_data;
+	struct iwl_dump_exclude *excl;
+
+	if (tlv_len < sizeof(*fw))
+		return;
+
+	if (tlv_type == IWL_UCODE_TLV_SEC_TABLE_ADDR) {
+		excl = &drv->fw.dump_excl[0];
+
+		/* second time we find this, it's for WoWLAN */
+		if (excl->addr)
+			excl = &drv->fw.dump_excl_wowlan[0];
+	} else if (fw_has_capa(&drv->fw.ucode_capa,
+			       IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG)) {
+		/* IWL_UCODE_TLV_D3_KEK_KCK_ADDR is regular image */
+		excl = &drv->fw.dump_excl[0];
+	} else {
+		/* IWL_UCODE_TLV_D3_KEK_KCK_ADDR is WoWLAN image */
+		excl = &drv->fw.dump_excl_wowlan[0];
+	}
+
+	if (excl->addr)
+		excl++;
+
+	if (excl->addr) {
+		IWL_DEBUG_FW_INFO(drv, "found too many excludes in fw file\n");
+		return;
+	}
+
+	excl->addr = le32_to_cpu(fw->addr) & ~FW_ADDR_CACHE_CONTROL;
+	excl->size = le32_to_cpu(fw->size);
+}
+
 static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				const struct firmware *ucode_raw,
 				struct iwl_firmware_pieces *pieces,
@@ -1165,6 +1202,11 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				return -ENOMEM;
 			drv->fw.phy_integration_ver_len = tlv_len;
 			break;
+		case IWL_UCODE_TLV_SEC_TABLE_ADDR:
+		case IWL_UCODE_TLV_D3_KEK_KCK_ADDR:
+			iwl_drv_set_dump_exclude(drv, tlv_type,
+						 tlv_data, tlv_len);
+			break;
 		default:
 			IWL_DEBUG_INFO(drv, "unknown TLV: %d\n", tlv_type);
 			break;
-- 
2.33.0

