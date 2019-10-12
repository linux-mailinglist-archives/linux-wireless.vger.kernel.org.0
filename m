Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3EFFD50BB
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbfJLPsy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48688 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729427AbfJLPsx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:53 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdN-0005yf-Ju; Sat, 12 Oct 2019 18:48:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:25 +0300
Message-Id: <20191012184707.6c18ceb905b4.I363d34e5ae1774e88953fc542c3d785d6c833c57@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012154828.9249-1-luca@coelho.fi>
References: <20191012154828.9249-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 13/16] iwlwifi: dbg_ini: support FW response/notification region type
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allow the driver to collect FW response/notification region type
during dump and allow triggering dump collection for a given FW
response/notification.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 53 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  3 ++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 32 +++++++++++
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 591c9f07a64c..cc4627d27602 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1057,9 +1057,11 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 /**
  * struct iwl_dump_ini_region_data - region data
  * @reg_tlv: region TLV
+ * @dump_data: dump data
  */
 struct iwl_dump_ini_region_data {
 	struct iwl_ucode_tlv *reg_tlv;
+	struct iwl_fwrt_dump_data *dump_data;
 };
 
 static int iwl_dump_ini_prph_iter(struct iwl_fw_runtime *fwrt,
@@ -1449,6 +1451,27 @@ iwl_dump_ini_err_table_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int iwl_dump_ini_fw_pkt_iter(struct iwl_fw_runtime *fwrt,
+				    struct iwl_dump_ini_region_data *reg_data,
+				    void *range_ptr, int idx)
+{
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	struct iwl_rx_packet *pkt = reg_data->dump_data->fw_pkt;
+	u32 pkt_len;
+
+	if (!pkt)
+		return -EIO;
+
+	pkt_len = iwl_rx_packet_payload_len(pkt);
+
+	memcpy(&range->fw_pkt_hdr, &pkt->hdr, sizeof(range->fw_pkt_hdr));
+	range->range_data_size = cpu_to_le32(pkt_len);
+
+	memcpy(range->data, pkt->data, pkt_len);
+
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static void *
 iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 			     struct iwl_dump_ini_region_data *reg_data,
@@ -1753,6 +1776,23 @@ iwl_dump_ini_err_table_get_size(struct iwl_fw_runtime *fwrt,
 	return size;
 }
 
+static u32
+iwl_dump_ini_fw_pkt_get_size(struct iwl_fw_runtime *fwrt,
+			     struct iwl_dump_ini_region_data *reg_data)
+{
+	u32 size = 0;
+
+	if (!reg_data->dump_data->fw_pkt)
+		return 0;
+
+	size += iwl_rx_packet_payload_len(reg_data->dump_data->fw_pkt);
+	if (size)
+		size += sizeof(struct iwl_fw_ini_error_dump) +
+			sizeof(struct iwl_fw_ini_error_dump_range);
+
+	return size;
+}
+
 /**
  * struct iwl_dump_ini_mem_ops - ini memory dump operations
  * @get_num_of_ranges: returns the number of memory ranges in the region.
@@ -1976,7 +2016,12 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_mem_hdr = iwl_dump_ini_err_table_fill_header,
 		.fill_range = iwl_dump_ini_err_table_iter,
 	},
-	[IWL_FW_INI_REGION_RSP_OR_NOTIF] = {},
+	[IWL_FW_INI_REGION_RSP_OR_NOTIF] = {
+		.get_num_of_ranges = iwl_dump_ini_single_range,
+		.get_size = iwl_dump_ini_fw_pkt_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_fw_pkt_iter,
+	},
 	[IWL_FW_INI_REGION_DEVICE_MEMORY] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
 		.get_size = iwl_dump_ini_mem_get_size,
@@ -2012,7 +2057,9 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 				struct list_head *list)
 {
 	struct iwl_fw_ini_trigger_tlv *trigger = dump_data->trig;
-	struct iwl_dump_ini_region_data reg_data = {};
+	struct iwl_dump_ini_region_data reg_data = {
+		.dump_data = dump_data,
+	};
 	int i;
 	u32 size = 0;
 	u64 regions_mask = le64_to_cpu(trigger->regions_mask);
@@ -2155,6 +2202,8 @@ static void iwl_dump_ini_list_free(struct list_head *list)
 static void iwl_fw_error_dump_data_free(struct iwl_fwrt_dump_data *dump_data)
 {
 	dump_data->trig = NULL;
+	kfree(dump_data->fw_pkt);
+	dump_data->fw_pkt = NULL;
 }
 
 static void iwl_fw_error_ini_dump(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index a7bf17e5ca9c..f008e1bbfdf4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -65,6 +65,7 @@
 #define __fw_error_dump_h__
 
 #include <linux/types.h>
+#include "fw/api/cmdhdr.h"
 
 #define IWL_FW_ERROR_DUMP_BARKER	0x14789632
 #define IWL_FW_INI_ERROR_DUMP_BARKER	0x14789633
@@ -327,6 +328,7 @@ struct iwl_fw_ini_fifo_hdr {
  * @dram_base_addr: base address of dram monitor range
  * @page_num: page number of memory range
  * @fifo_hdr: fifo header of memory range
+ * @fw_pkt: FW packet header of memory range
  * @data: the actual memory
  */
 struct iwl_fw_ini_error_dump_range {
@@ -336,6 +338,7 @@ struct iwl_fw_ini_error_dump_range {
 		__le64 dram_base_addr;
 		__le32 page_num;
 		struct iwl_fw_ini_fifo_hdr fifo_hdr;
+		struct iwl_cmd_header fw_pkt_hdr;
 	};
 	__le32 data[];
 } __packed;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index f813b2333565..4f2a4d88f399 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -940,6 +940,33 @@ int iwl_dbg_tlv_gen_active_trigs(struct iwl_fw_runtime *fwrt, u32 new_domain)
 	return 0;
 }
 
+static bool iwl_dbg_tlv_check_fw_pkt(struct iwl_fw_runtime *fwrt,
+				     struct iwl_fwrt_dump_data *dump_data,
+				     union iwl_dbg_tlv_tp_data *tp_data,
+				     u32 trig_data)
+{
+	struct iwl_rx_packet *pkt = tp_data->fw_pkt;
+	struct iwl_cmd_header *wanted_hdr = (void *)&trig_data;
+
+	if (pkt && ((wanted_hdr->cmd == 0 && wanted_hdr->group_id == 0) ||
+		    (pkt->hdr.cmd == wanted_hdr->cmd &&
+		     pkt->hdr.group_id == wanted_hdr->group_id))) {
+		struct iwl_rx_packet *fw_pkt =
+			kmemdup(pkt,
+				sizeof(*pkt) + iwl_rx_packet_payload_len(pkt),
+				GFP_ATOMIC);
+
+		if (!fw_pkt)
+			return false;
+
+		dump_data->fw_pkt = fw_pkt;
+
+		return true;
+	}
+
+	return false;
+}
+
 static int
 iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt,
 		       struct list_head *active_trig_list,
@@ -1039,6 +1066,11 @@ void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 		iwl_dbg_tlv_set_periodic_trigs(fwrt);
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
 		break;
+	case IWL_FW_INI_TIME_POINT_FW_RSP_OR_NOTIF:
+		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
+		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data,
+				       iwl_dbg_tlv_check_fw_pkt);
+		break;
 	default:
 		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
-- 
2.23.0

