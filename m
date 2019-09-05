Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB89AA40E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388562AbfIENNd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:13:33 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41014 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388541AbfIENNd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:13:33 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZL-0005yI-MB; Thu, 05 Sep 2019 16:13:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:40 +0300
Message-Id: <20190905131241.23487-18-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905131241.23487-1-luca@coelho.fi>
References: <20190905131241.23487-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 17/18] iwlwifi: dbg_ini: use linked list to store debug TLVs
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Use a linked list to maintain the debug TLVs instead of a single buffer.
This way, the driver does not need to iterate over the binary file twice
and allocates smaller chunks of memory. Also, in case one allocation
fails the driver will work with the partial configuration instead of
aborting the entire debug configuration.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  15 ++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 121 ++++++------------
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.h  |  12 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   3 -
 4 files changed, 49 insertions(+), 102 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6d69ed17e7f8..78e13cd182cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2783,10 +2783,13 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 				    enum iwl_fw_ini_apply_point pnt,
 				    bool ext)
 {
-	void *iter = data->data;
+	struct iwl_apply_point_data *iter;
 
-	while (iter && iter < data->data + data->size) {
-		struct iwl_ucode_tlv *tlv = iter;
+	if (!data->list.next)
+		return;
+
+	list_for_each_entry(iter, &data->list, list) {
+		struct iwl_ucode_tlv *tlv = &iter->tlv;
 		void *ini_tlv = (void *)tlv->data;
 		u32 type = le32_to_cpu(tlv->type);
 
@@ -2799,7 +2802,7 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 				IWL_ERR(fwrt,
 					"WRT: ext=%d. Invalid apply point %d for buffer allocation\n",
 					ext, pnt);
-				goto next;
+				break;
 			}
 			iwl_fw_dbg_buffer_apply(fwrt, ini_tlv, pnt);
 			break;
@@ -2808,7 +2811,7 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 				IWL_ERR(fwrt,
 					"WRT: ext=%d. Invalid apply point %d for host command\n",
 					ext, pnt);
-				goto next;
+				break;
 			}
 			iwl_fw_dbg_send_hcmd(fwrt, tlv, ext);
 			break;
@@ -2826,8 +2829,6 @@ static void _iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
 				  ext, type);
 			break;
 		}
-next:
-		iter += sizeof(*tlv) + le32_to_cpu(tlv->length);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 5948d769eed0..7c1e76ee7ede 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -66,102 +66,56 @@
 void iwl_dbg_tlv_copy(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 		      bool ext)
 {
-	struct iwl_apply_point_data *data;
+	struct iwl_apply_point_data *dbg_cfg, *tlv_copy;
 	struct iwl_fw_ini_header *header = (void *)&tlv->data[0];
+	u32 tlv_type = le32_to_cpu(tlv->type);
+	u32 len = le32_to_cpu(tlv->length);
 	u32 apply_point = le32_to_cpu(header->apply_point);
 
-	int copy_size = le32_to_cpu(tlv->length) + sizeof(*tlv);
-	int offset_size = copy_size;
-
 	if (le32_to_cpu(header->tlv_version) != 1)
 		return;
 
 	if (WARN_ONCE(apply_point >= IWL_FW_INI_APPLY_NUM,
-		      "Invalid apply point id %d\n", apply_point))
+		      "Invalid apply point %d\n", apply_point))
 		return;
 
+	IWL_DEBUG_FW(trans, "WRT: read TLV 0x%x, apply point %d\n",
+		     tlv_type, apply_point);
+
 	if (ext)
-		data = &trans->dbg.apply_points_ext[apply_point];
+		dbg_cfg = &trans->dbg.apply_points_ext[apply_point];
 	else
-		data = &trans->dbg.apply_points[apply_point];
-
-	/*
-	 * Make sure we still have room to copy this TLV. Offset points to the
-	 * location the last copy ended.
-	 */
-	if (WARN_ONCE(data->offset + offset_size > data->size,
-		      "Not enough memory for apply point %d\n",
-		      apply_point))
-		return;
-
-	memcpy(data->data + data->offset, (void *)tlv, copy_size);
-	data->offset += offset_size;
-}
-
-void iwl_dbg_tlv_alloc(struct iwl_trans *trans, size_t len, const u8 *data,
-		       bool ext)
-{
-	struct iwl_ucode_tlv *tlv;
-	u32 size[IWL_FW_INI_APPLY_NUM] = {0};
-	int i;
-
-	while (len >= sizeof(*tlv)) {
-		u32 tlv_len, tlv_type, apply;
-		struct iwl_fw_ini_header *hdr;
-
-		len -= sizeof(*tlv);
-		tlv = (void *)data;
-
-		tlv_len = le32_to_cpu(tlv->length);
-		tlv_type = le32_to_cpu(tlv->type);
+		dbg_cfg = &trans->dbg.apply_points[apply_point];
 
-		if (len < tlv_len)
-			return;
-
-		len -= ALIGN(tlv_len, 4);
-		data += sizeof(*tlv) + ALIGN(tlv_len, 4);
-
-		if (tlv_type < IWL_UCODE_TLV_DEBUG_BASE ||
-		    tlv_type > IWL_UCODE_TLV_DEBUG_MAX)
-			continue;
-
-		hdr = (void *)&tlv->data[0];
-		apply = le32_to_cpu(hdr->apply_point);
-
-		if (le32_to_cpu(hdr->tlv_version) != 1)
-			continue;
-
-		IWL_DEBUG_FW(trans, "WRT: read TLV 0x%x, apply point %d\n",
-			     le32_to_cpu(tlv->type), apply);
-
-		if (WARN_ON(apply >= IWL_FW_INI_APPLY_NUM))
-			continue;
-
-		size[apply] += sizeof(*tlv) + tlv_len;
+	tlv_copy = kzalloc(sizeof(*tlv_copy) + len, GFP_KERNEL);
+	if (!tlv_copy) {
+		IWL_ERR(trans, "WRT: No memory for TLV 0x%x, apply point %d\n",
+			tlv_type, apply_point);
+		return;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(size); i++) {
-		void *mem;
+	INIT_LIST_HEAD(&tlv_copy->list);
+	memcpy(&tlv_copy->tlv, tlv, sizeof(*tlv) + len);
 
-		if (!size[i])
-			continue;
+	if (!dbg_cfg->list.next)
+		INIT_LIST_HEAD(&dbg_cfg->list);
 
-		mem = kzalloc(size[i], GFP_KERNEL);
+	list_add_tail(&tlv_copy->list, &dbg_cfg->list);
 
-		if (!mem) {
-			IWL_ERR(trans, "No memory for apply point %d\n", i);
-			return;
-		}
+	trans->dbg.ini_valid = true;
+}
 
-		if (ext) {
-			trans->dbg.apply_points_ext[i].data = mem;
-			trans->dbg.apply_points_ext[i].size = size[i];
-		} else {
-			trans->dbg.apply_points[i].data = mem;
-			trans->dbg.apply_points[i].size = size[i];
-		}
+static void iwl_dbg_tlv_free_list(struct list_head *list)
+{
+	if (!list || !list->next)
+		return;
 
-		trans->dbg.ini_valid = true;
+	while (!list_empty(list)) {
+		struct iwl_apply_point_data *node =
+			list_entry(list->next, typeof(*node), list);
+
+		list_del(&node->list);
+		kfree(node);
 	}
 }
 
@@ -170,13 +124,13 @@ void iwl_dbg_tlv_free(struct iwl_trans *trans)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(trans->dbg.apply_points); i++) {
-		kfree(trans->dbg.apply_points[i].data);
-		trans->dbg.apply_points[i].size = 0;
-		trans->dbg.apply_points[i].offset = 0;
+		struct iwl_apply_point_data *data;
+
+		data = &trans->dbg.apply_points[i];
+		iwl_dbg_tlv_free_list(&data->list);
 
-		kfree(trans->dbg.apply_points_ext[i].data);
-		trans->dbg.apply_points_ext[i].size = 0;
-		trans->dbg.apply_points_ext[i].offset = 0;
+		data = &trans->dbg.apply_points_ext[i];
+		iwl_dbg_tlv_free_list(&data->list);
 	}
 }
 
@@ -232,7 +186,6 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans)
 	if (res)
 		return;
 
-	iwl_dbg_tlv_alloc(trans, fw->size, fw->data, true);
 	iwl_dbg_tlv_parse_bin(trans, fw->data, fw->size);
 
 	trans->dbg.external_ini_loaded = true;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
index e4911ec6ce13..72552de801d4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h
@@ -66,14 +66,12 @@
 
 /**
  * struct iwl_apply_point_data
- * @data: start address of this apply point data
- * @size total size of the data
- * @offset: current offset of the copied data
+ * @list: list to go through the TLVs of the apply point
+ * @tlv: a debug TLV
  */
 struct iwl_apply_point_data {
-	void *data;
-	int size;
-	int offset;
+	struct list_head list;
+	struct iwl_ucode_tlv tlv;
 };
 
 struct iwl_trans;
@@ -81,7 +79,5 @@ void iwl_dbg_tlv_load_bin(struct device *dev, struct iwl_trans *trans);
 void iwl_dbg_tlv_free(struct iwl_trans *trans);
 void iwl_dbg_tlv_copy(struct iwl_trans *trans, struct iwl_ucode_tlv *tlv,
 		      bool ext);
-void iwl_dbg_tlv_alloc(struct iwl_trans *trans, size_t len, const u8 *data,
-		       bool ext);
 
 #endif /* __iwl_dbg_tlv_h__*/
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 595dc2fbc3b3..3792b421746e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -647,9 +647,6 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 	len -= sizeof(*ucode);
 
-	if (iwlwifi_mod_params.enable_ini)
-		iwl_dbg_tlv_alloc(drv->trans, len, data, false);
-
 	while (len >= sizeof(*tlv)) {
 		len -= sizeof(*tlv);
 		tlv = (void *)data;
-- 
2.23.0.rc1

