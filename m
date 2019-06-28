Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD275974F
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfF1JUd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54752 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726667AbfF1JUd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3R-0001ny-CE; Fri, 28 Jun 2019 12:20:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 12/20] iwlwifi: dbg_ini: enforce apply point early on buffer allocation tlv
Date:   Fri, 28 Jun 2019 12:20:00 +0300
Message-Id: <20190628092008.11049-13-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Apply buffer allocation TLV only if it is set to apply point
IWL_FW_INI_APPLY_EARLY.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 28 +++++++++++----------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 21df3e3a28e7..d61def45af57 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2518,16 +2518,11 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 	u32 buf_location = le32_to_cpu(alloc->tlv.buffer_location);
 
 	if (buf_location == IWL_FW_INI_LOCATION_SRAM_PATH) {
-		if (!WARN(pnt != IWL_FW_INI_APPLY_EARLY,
-			  "WRT: Invalid apply point %d for SMEM buffer allocation, aborting\n",
-			  pnt)) {
-			IWL_DEBUG_FW(trans,
-				     "WRT: applying SMEM buffer destination\n");
-
-			/* set sram monitor by enabling bit 7 */
-			iwl_set_bit(fwrt->trans, CSR_HW_IF_CONFIG_REG,
-				    CSR_HW_IF_CONFIG_REG_BIT_MONITOR_SRAM);
-		}
+		IWL_DEBUG_FW(trans, "WRT: applying SMEM buffer destination\n");
+		/* set sram monitor by enabling bit 7 */
+		iwl_set_bit(fwrt->trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_BIT_MONITOR_SRAM);
+
 		return;
 	}
 
@@ -2774,6 +2769,8 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 		struct iwl_ucode_tlv *tlv = iter;
 		void *ini_tlv = (void *)tlv->data;
 		u32 type = le32_to_cpu(tlv->type);
+		const char invalid_ap_str[] =
+			"WRT: ext=%d. Invalid apply point %d for %s\n";
 
 		switch (type) {
 		case IWL_UCODE_TLV_TYPE_DEBUG_INFO:
@@ -2782,15 +2779,20 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 		case IWL_UCODE_TLV_TYPE_BUFFER_ALLOCATION: {
 			struct iwl_fw_ini_allocation_data *buf_alloc = ini_tlv;
 
+			if (pnt != IWL_FW_INI_APPLY_EARLY) {
+				IWL_ERR(fwrt, invalid_ap_str, ext, pnt,
+					"buffer allocation");
+				goto next;
+			}
+
 			iwl_fw_dbg_buffer_apply(fwrt, ini_tlv, pnt);
 			iter += sizeof(buf_alloc->is_alloc);
 			break;
 		}
 		case IWL_UCODE_TLV_TYPE_HCMD:
 			if (pnt < IWL_FW_INI_APPLY_AFTER_ALIVE) {
-				IWL_ERR(fwrt,
-					"WRT: ext=%d. Invalid apply point %d for host command\n",
-					ext, pnt);
+				IWL_ERR(fwrt, invalid_ap_str, ext, pnt,
+					"host command");
 				goto next;
 			}
 			iwl_fw_dbg_send_hcmd(fwrt, tlv, ext);
-- 
2.20.1

