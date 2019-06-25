Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB1452874
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfFYJpI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 05:45:08 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54616 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727928AbfFYJpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 05:45:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hfi0a-0007Nv-5m; Tue, 25 Jun 2019 12:45:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 05/12] iwlwifi: dbg_ini: abort region collection in case the size is 0
Date:   Tue, 25 Jun 2019 12:44:45 +0300
Message-Id: <20190625094452.19034-6-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625094452.19034-1-luca@coelho.fi>
References: <20190625094452.19034-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allows to abort region collection in case the region size is 0.
It is needed for future regions that their size might be 0.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 53 +++++++++++++--------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ca4dea1dceba..8e2cf7141f0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1674,20 +1674,24 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 		 struct iwl_dump_ini_mem_ops *ops)
 {
 	struct iwl_fw_ini_error_dump_header *header = (void *)(*data)->data;
-	u32 num_of_ranges, i, type = le32_to_cpu(reg->region_type);
+	u32 num_of_ranges, i, type = le32_to_cpu(reg->region_type), size;
 	void *range;
 
 	if (WARN_ON(!ops || !ops->get_num_of_ranges || !ops->get_size ||
 		    !ops->fill_mem_hdr || !ops->fill_range))
 		return;
 
+	size = ops->get_size(fwrt, reg);
+	if (!size)
+		return;
+
 	IWL_DEBUG_FW(fwrt, "WRT: collecting region: id=%d, type=%d\n",
 		     le32_to_cpu(reg->region_id), type);
 
 	num_of_ranges = ops->get_num_of_ranges(fwrt, reg);
 
 	(*data)->type = cpu_to_le32(type | INI_DUMP_BIT);
-	(*data)->len = cpu_to_le32(ops->get_size(fwrt, reg));
+	(*data)->len = cpu_to_le32(size);
 
 	header->region_id = reg->region_id;
 	header->num_of_ranges = cpu_to_le32(num_of_ranges);
@@ -1700,7 +1704,7 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 		IWL_ERR(fwrt,
 			"WRT: failed to fill region header: id=%d, type=%d\n",
 			le32_to_cpu(reg->region_id), type);
-		memset(*data, 0, le32_to_cpu((*data)->len));
+		memset(*data, 0, size);
 		return;
 	}
 
@@ -1711,7 +1715,7 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 			IWL_ERR(fwrt,
 				"WRT: failed to dump region: id=%d, type=%d\n",
 				le32_to_cpu(reg->region_id), type);
-			memset(*data, 0, le32_to_cpu((*data)->len));
+			memset(*data, 0, size);
 			return;
 		}
 		range = range + range_size;
@@ -1722,7 +1726,8 @@ iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt,
 static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
 				      struct iwl_fw_ini_trigger *trigger)
 {
-	int i, size = 0, hdr_len = sizeof(struct iwl_fw_error_dump_data);
+	int i, ret_size = 0, hdr_len = sizeof(struct iwl_fw_error_dump_data);
+	u32 size;
 
 	if (!trigger || !trigger->num_regions)
 		return 0;
@@ -1754,32 +1759,40 @@ static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
 		case IWL_FW_INI_REGION_CSR:
 		case IWL_FW_INI_REGION_LMAC_ERROR_TABLE:
 		case IWL_FW_INI_REGION_UMAC_ERROR_TABLE:
-			size += hdr_len + iwl_dump_ini_mem_get_size(fwrt, reg);
+			size = iwl_dump_ini_mem_get_size(fwrt, reg);
+			if (size)
+				ret_size += hdr_len + size;
 			break;
 		case IWL_FW_INI_REGION_TXF:
-			size += hdr_len + iwl_dump_ini_txf_get_size(fwrt, reg);
+			size = iwl_dump_ini_txf_get_size(fwrt, reg);
+			if (size)
+				ret_size += hdr_len + size;
 			break;
 		case IWL_FW_INI_REGION_RXF:
-			size += hdr_len + iwl_dump_ini_rxf_get_size(fwrt, reg);
+			size = iwl_dump_ini_rxf_get_size(fwrt, reg);
+			if (size)
+				ret_size += hdr_len + size;
 			break;
 		case IWL_FW_INI_REGION_PAGING:
-			size += hdr_len;
-			if (iwl_fw_dbg_is_paging_enabled(fwrt)) {
-				size += iwl_dump_ini_paging_get_size(fwrt, reg);
-			} else {
-				size += iwl_dump_ini_paging_gen2_get_size(fwrt,
-									  reg);
-			}
+			if (iwl_fw_dbg_is_paging_enabled(fwrt))
+				size = iwl_dump_ini_paging_get_size(fwrt, reg);
+			else
+				size = iwl_dump_ini_paging_gen2_get_size(fwrt,
+									 reg);
+			if (size)
+				ret_size += hdr_len + size;
 			break;
 		case IWL_FW_INI_REGION_DRAM_BUFFER:
 			if (!fwrt->trans->num_blocks)
 				break;
-			size += hdr_len +
-				iwl_dump_ini_mon_dram_get_size(fwrt, reg);
+			size = iwl_dump_ini_mon_dram_get_size(fwrt, reg);
+			if (size)
+				ret_size += hdr_len + size;
 			break;
 		case IWL_FW_INI_REGION_INTERNAL_BUFFER:
-			size += hdr_len +
-				iwl_dump_ini_mon_smem_get_size(fwrt, reg);
+			size = iwl_dump_ini_mon_smem_get_size(fwrt, reg);
+			if (size)
+				ret_size += hdr_len + size;
 			break;
 		case IWL_FW_INI_REGION_DRAM_IMR:
 			/* Undefined yet */
@@ -1787,7 +1800,7 @@ static int iwl_fw_ini_get_trigger_len(struct iwl_fw_runtime *fwrt,
 			break;
 		}
 	}
-	return size;
+	return ret_size;
 }
 
 static void iwl_fw_ini_dump_trigger(struct iwl_fw_runtime *fwrt,
-- 
2.20.1

