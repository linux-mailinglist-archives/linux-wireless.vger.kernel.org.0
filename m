Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47131A43D1
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfHaJxE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:53:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39766 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbfHaJxE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:53:04 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400O-0002OQ-BJ; Sat, 31 Aug 2019 12:49:12 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:50 +0300
Message-Id: <20190831094859.6391-11-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 10/19] iwlwifi: dbg_ini: remove debug flow TLV
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Debug flow TLV was removed from the FW. Remove the TLV from the driver
as well.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h | 11 -----------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c         |  2 --
 drivers/net/wireless/intel/iwlwifi/fw/file.h        |  3 +--
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c        |  1 -
 4 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index e02e289d29b1..798e61d4d683 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -140,17 +140,6 @@ struct iwl_fw_ini_hcmd_tlv {
 	struct iwl_fw_ini_hcmd hcmd;
 } __packed; /* FW_DEBUG_TLV_HCMD_API_S_VER_1 */
 
-/**
- * struct iwl_fw_ini_debug_flow_tlv - (IWL_UCODE_TLV_TYPE_DEBUG_FLOW)
- *
- * @header: header
- * @debug_flow_cfg: &enum iwl_fw_ini_debug_flow
- */
-struct iwl_fw_ini_debug_flow_tlv {
-	struct iwl_fw_ini_header header;
-	__le32 debug_flow_cfg;
-} __packed; /* FW_DEBUG_TLV_FLOW_TLV_S_VER_1 */
-
 #define IWL_FW_INI_MAX_REGION_ID	64
 #define IWL_FW_INI_MAX_NAME		32
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6e5a3289e04a..2d37628694d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2820,8 +2820,6 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 		case IWL_UCODE_TLV_TYPE_TRIGGERS:
 			iwl_fw_dbg_update_triggers(fwrt, ini_tlv, ext, pnt);
 			break;
-		case IWL_UCODE_TLV_TYPE_DEBUG_FLOW:
-			break;
 		default:
 			WARN_ONCE(1,
 				  "WRT: ext=%d. Invalid TLV 0x%x for apply point\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 73cd41480c2f..00db39427be7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -157,8 +157,7 @@ enum iwl_ucode_tlv_type {
 	IWL_UCODE_TLV_TYPE_HCMD			= IWL_UCODE_TLV_DEBUG_BASE + 2,
 	IWL_UCODE_TLV_TYPE_REGIONS		= IWL_UCODE_TLV_DEBUG_BASE + 3,
 	IWL_UCODE_TLV_TYPE_TRIGGERS		= IWL_UCODE_TLV_DEBUG_BASE + 4,
-	IWL_UCODE_TLV_TYPE_DEBUG_FLOW		= IWL_UCODE_TLV_DEBUG_BASE + 5,
-	IWL_UCODE_TLV_DEBUG_MAX = IWL_UCODE_TLV_TYPE_DEBUG_FLOW,
+	IWL_UCODE_TLV_DEBUG_MAX = IWL_UCODE_TLV_TYPE_TRIGGERS,
 
 	/* TLVs 0x1000-0x2000 are for internal driver usage */
 	IWL_UCODE_TLV_FW_DBG_DUMP_LST	= 0x1000,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 1351f7fe5ae2..ae61ad129f06 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1151,7 +1151,6 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 		case IWL_UCODE_TLV_TYPE_HCMD:
 		case IWL_UCODE_TLV_TYPE_REGIONS:
 		case IWL_UCODE_TLV_TYPE_TRIGGERS:
-		case IWL_UCODE_TLV_TYPE_DEBUG_FLOW:
 			if (iwlwifi_mod_params.enable_ini)
 				iwl_dbg_tlv_alloc(drv->trans, tlv, false);
 			break;
-- 
2.23.0.rc1

