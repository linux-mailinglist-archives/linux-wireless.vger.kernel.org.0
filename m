Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6D7468464
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 12:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384792AbhLDLOd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 06:14:33 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50426 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350310AbhLDLOb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 06:14:31 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtSwa-0017RD-AU; Sat, 04 Dec 2021 13:11:04 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 13:10:52 +0200
Message-Id: <iwlwifi.20211204130722.083e4b47055e.If7483d854e3d07f81236d314b8155cd5996f306c@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204111053.852455-1-luca@coelho.fi>
References: <20211204111053.852455-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 11/12] iwlwifi: fw: add support for splitting region type bits
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In next region tlv (3) region type is going to be split into bit mask
without affecting the ops for handling region type, so we just mask
the type independent of the version due to all versions having the
same bits usage.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |  8 +++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c    | 14 +++++++++-----
 .../net/wireless/intel/iwlwifi/fw/error-dump.h | 18 ++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   | 10 +++++-----
 4 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index b37392719398..1c302cdbde5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -124,6 +124,9 @@ struct iwl_fw_ini_region_internal_buffer {
  * @hdr: debug header
  * @id: region id. Max id is &IWL_FW_INI_MAX_REGION_ID
  * @type: region type. One of &enum iwl_fw_ini_region_type
+ * @sub_type: region sub type
+ * @sub_type_ver: region sub type
+ * @reserved: not in use
  * @name: region name
  * @dev_addr: device address configuration. Used by
  *	&IWL_FW_INI_REGION_DEVICE_MEMORY, &IWL_FW_INI_REGION_PERIPHERY_MAC,
@@ -146,7 +149,10 @@ struct iwl_fw_ini_region_internal_buffer {
 struct iwl_fw_ini_region_tlv {
 	struct iwl_fw_ini_header hdr;
 	__le32 id;
-	__le32 type;
+	u8 type;
+	u8 sub_type;
+	u8 sub_type_ver;
+	u8 reserved;
 	u8 name[IWL_FW_INI_MAX_NAME];
 	union {
 		struct iwl_fw_ini_region_dev_addr dev_addr;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index c8a08bdfefa4..fa3a7a3c3a61 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1988,17 +1988,18 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_dump_entry *entry;
-	struct iwl_fw_error_dump_data *tlv;
+	struct iwl_fw_ini_error_dump_data *tlv;
 	struct iwl_fw_ini_error_dump_header *header;
-	u32 type = le32_to_cpu(reg->type), id = le32_to_cpu(reg->id);
+	u32 type = reg->type;
+	u32 id = le32_to_cpu(reg->id);
 	u32 num_of_ranges, i, size;
 	void *range;
 
 	/*
-	 * The higher part of the ID in version 2 is irrelevant for
+	 * The higher part of the ID from 2 is irrelevant for
 	 * us, so mask it out.
 	 */
-	if (le32_to_cpu(reg->hdr.version) == 2)
+	if (le32_to_cpu(reg->hdr.version) >= 2)
 		id &= IWL_FW_INI_REGION_V2_MASK;
 
 	if (!ops->get_num_of_ranges || !ops->get_size || !ops->fill_mem_hdr ||
@@ -2017,6 +2018,9 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 
 	tlv = (void *)entry->data;
 	tlv->type = reg->type;
+	tlv->sub_type = reg->sub_type;
+	tlv->sub_type_ver = reg->sub_type_ver;
+	tlv->reserved = reg->reserved;
 	tlv->len = cpu_to_le32(size);
 
 	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n", id,
@@ -2291,7 +2295,7 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		}
 
 		reg = (void *)reg_data.reg_tlv->data;
-		reg_type = le32_to_cpu(reg->type);
+		reg_type = reg->type;
 		if (reg_type >= ARRAY_SIZE(iwl_dump_ini_region_ops))
 			continue;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 9036b32ec765..079fa0023bd8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -231,6 +231,24 @@ struct iwl_fw_error_dump_mem {
 /* Use bit 31 as dump info type to avoid colliding with region types */
 #define IWL_INI_DUMP_INFO_TYPE BIT(31)
 
+/**
+ * struct iwl_fw_error_dump_data - data for one type
+ * @type: &enum iwl_fw_ini_region_type
+ * @sub_type: sub type id
+ * @sub_type_ver: sub type version
+ * @reserved: not in use
+ * @len: the length starting from %data
+ * @data: the data itself
+ */
+struct iwl_fw_ini_error_dump_data {
+	u8 type;
+	u8 sub_type;
+	u8 sub_type_ver;
+	u8 reserved;
+	__le32 len;
+	__u8 data[];
+} __packed;
+
 /**
  * struct iwl_fw_ini_dump_entry
  * @list: list of dump entries
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 7ab98b419cc1..49526fdcf9d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -59,7 +59,7 @@ dbg_ver_table[IWL_DBG_TLV_TYPE_NUM] = {
 	[IWL_DBG_TLV_TYPE_DEBUG_INFO]	= {.min_ver = 1, .max_ver = 1,},
 	[IWL_DBG_TLV_TYPE_BUF_ALLOC]	= {.min_ver = 1, .max_ver = 1,},
 	[IWL_DBG_TLV_TYPE_HCMD]		= {.min_ver = 1, .max_ver = 1,},
-	[IWL_DBG_TLV_TYPE_REGION]	= {.min_ver = 1, .max_ver = 2,},
+	[IWL_DBG_TLV_TYPE_REGION]	= {.min_ver = 1, .max_ver = 3,},
 	[IWL_DBG_TLV_TYPE_TRIGGER]	= {.min_ver = 1, .max_ver = 1,},
 	[IWL_DBG_TLV_TYPE_CONF_SET]	= {.min_ver = 1, .max_ver = 1,},
 };
@@ -177,14 +177,14 @@ static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
 	const struct iwl_fw_ini_region_tlv *reg = (const void *)tlv->data;
 	struct iwl_ucode_tlv **active_reg;
 	u32 id = le32_to_cpu(reg->id);
-	u32 type = le32_to_cpu(reg->type);
+	u8 type = reg->type;
 	u32 tlv_len = sizeof(*tlv) + le32_to_cpu(tlv->length);
 
 	/*
-	 * The higher part of the ID in version 2 is irrelevant for
+	 * The higher part of the ID in from version 2 is irrelevant for
 	 * us, so mask it out.
 	 */
-	if (le32_to_cpu(reg->hdr.version) == 2)
+	if (le32_to_cpu(reg->hdr.version) >= 2)
 		id &= IWL_FW_INI_REGION_V2_MASK;
 
 	if (le32_to_cpu(tlv->length) < sizeof(*reg))
@@ -1244,7 +1244,7 @@ static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
 		}
 
 		reg = (void *)(*active_reg)->data;
-		reg_type = le32_to_cpu(reg->type);
+		reg_type = reg->type;
 
 		if (reg_type != IWL_FW_INI_REGION_DRAM_BUFFER ||
 		    !(BIT(le32_to_cpu(reg->dram_alloc_id)) & failed_alloc))
-- 
2.33.1

