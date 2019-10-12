Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279ACD50BC
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfJLPs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48696 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729427AbfJLPs4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:56 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdL-0005yf-7r; Sat, 12 Oct 2019 18:48:43 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:22 +0300
Message-Id: <20191012184707.2385e38f13e4.I578488b770d6f705c06099bd1d3e40acf7695ea9@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012154828.9249-1-luca@coelho.fi>
References: <20191012154828.9249-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 10/16] iwlwifi: dbg_ini: implement monitor allocation flow
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allow allocating fragmented buffers for several allocation IDs.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 249 +++++++++++++++++-
 1 file changed, 248 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 1cec10a60cba..c657acf61fe9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -314,6 +314,34 @@ void iwl_dbg_tlv_del_timers(struct iwl_trans *trans)
 }
 IWL_EXPORT_SYMBOL(iwl_dbg_tlv_del_timers);
 
+static void iwl_dbg_tlv_fragments_free(struct iwl_trans *trans,
+				       enum iwl_fw_ini_allocation_id alloc_id)
+{
+	struct iwl_fw_mon *fw_mon;
+	int i;
+
+	if (alloc_id <= IWL_FW_INI_ALLOCATION_INVALID ||
+	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM)
+		return;
+
+	fw_mon = &trans->dbg.fw_mon_ini[alloc_id];
+
+	for (i = 0; i < fw_mon->num_frags; i++) {
+		struct iwl_dram_data *frag = &fw_mon->frags[i];
+
+		dma_free_coherent(trans->dev, frag->size, frag->block,
+				  frag->physical);
+
+		frag->physical = 0;
+		frag->block = NULL;
+		frag->size = 0;
+	}
+
+	kfree(fw_mon->frags);
+	fw_mon->frags = NULL;
+	fw_mon->num_frags = 0;
+}
+
 void iwl_dbg_tlv_free(struct iwl_trans *trans)
 {
 	struct iwl_dbg_tlv_node *tlv_node, *tlv_node_tmp;
@@ -357,6 +385,9 @@ void iwl_dbg_tlv_free(struct iwl_trans *trans)
 			kfree(tlv_node);
 		}
 	}
+
+	for (i = 0; i < ARRAY_SIZE(trans->dbg.fw_mon_ini); i++)
+		iwl_dbg_tlv_fragments_free(trans, i);
 }
 
 static int iwl_dbg_tlv_parse_bin(struct iwl_trans *trans, const u8 *data,
@@ -418,6 +449,187 @@ void iwl_dbg_tlv_init(struct iwl_trans *trans)
 	}
 }
 
+static int iwl_dbg_tlv_alloc_fragment(struct iwl_fw_runtime *fwrt,
+				      struct iwl_dram_data *frag, u32 pages)
+{
+	void *block = NULL;
+	dma_addr_t physical;
+
+	if (!frag || frag->size || !pages)
+		return -EIO;
+
+	while (pages) {
+		block = dma_alloc_coherent(fwrt->dev, pages * PAGE_SIZE,
+					   &physical,
+					   GFP_KERNEL | __GFP_NOWARN);
+		if (block)
+			break;
+
+		IWL_WARN(fwrt, "WRT: Failed to allocate fragment size %lu\n",
+			 pages * PAGE_SIZE);
+
+		pages = DIV_ROUND_UP(pages, 2);
+	}
+
+	if (!block)
+		return -ENOMEM;
+
+	frag->physical = physical;
+	frag->block = block;
+	frag->size = pages * PAGE_SIZE;
+
+	return pages;
+}
+
+static int iwl_dbg_tlv_alloc_fragments(struct iwl_fw_runtime *fwrt,
+				       enum iwl_fw_ini_allocation_id alloc_id)
+{
+	struct iwl_fw_mon *fw_mon;
+	struct iwl_fw_ini_allocation_tlv *fw_mon_cfg;
+	u32 num_frags, remain_pages, frag_pages;
+	int i;
+
+	if (alloc_id < IWL_FW_INI_ALLOCATION_INVALID ||
+	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM)
+		return -EIO;
+
+	fw_mon_cfg = &fwrt->trans->dbg.fw_mon_cfg[alloc_id];
+	fw_mon = &fwrt->trans->dbg.fw_mon_ini[alloc_id];
+
+	if (fw_mon->num_frags ||
+	    fw_mon_cfg->buf_location !=
+	    cpu_to_le32(IWL_FW_INI_LOCATION_DRAM_PATH))
+		return 0;
+
+	num_frags = le32_to_cpu(fw_mon_cfg->max_frags_num);
+	if (!fw_has_capa(&fwrt->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_DBG_BUF_ALLOC_CMD_SUPP)) {
+		if (alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
+			return -EIO;
+		num_frags = 1;
+	}
+
+	remain_pages = DIV_ROUND_UP(le32_to_cpu(fw_mon_cfg->req_size),
+				    PAGE_SIZE);
+	num_frags = min_t(u32, num_frags, BUF_ALLOC_MAX_NUM_FRAGS);
+	num_frags = min_t(u32, num_frags, remain_pages);
+	frag_pages = DIV_ROUND_UP(remain_pages, num_frags);
+
+	fw_mon->frags = kcalloc(num_frags, sizeof(*fw_mon->frags), GFP_KERNEL);
+	if (!fw_mon->frags)
+		return -ENOMEM;
+
+	for (i = 0; i < num_frags; i++) {
+		int pages = min_t(u32, frag_pages, remain_pages);
+
+		IWL_DEBUG_FW(fwrt,
+			     "WRT: Allocating DRAM buffer (alloc_id=%u, fragment=%u, size=0x%lx)\n",
+			     alloc_id, i, pages * PAGE_SIZE);
+
+		pages = iwl_dbg_tlv_alloc_fragment(fwrt, &fw_mon->frags[i],
+						   pages);
+		if (pages < 0) {
+			u32 alloc_size = le32_to_cpu(fw_mon_cfg->req_size) -
+				(remain_pages * PAGE_SIZE);
+
+			if (alloc_size < le32_to_cpu(fw_mon_cfg->min_size)) {
+				iwl_dbg_tlv_fragments_free(fwrt->trans,
+							   alloc_id);
+				return pages;
+			}
+			break;
+		}
+
+		remain_pages -= pages;
+		fw_mon->num_frags++;
+	}
+
+	return 0;
+}
+
+static int iwl_dbg_tlv_apply_buffer(struct iwl_fw_runtime *fwrt,
+				    enum iwl_fw_ini_allocation_id alloc_id)
+{
+	struct iwl_fw_mon *fw_mon;
+	u32 remain_frags, num_commands;
+	int i, fw_mon_idx = 0;
+
+	if (!fw_has_capa(&fwrt->fw->ucode_capa,
+			 IWL_UCODE_TLV_CAPA_DBG_BUF_ALLOC_CMD_SUPP))
+		return 0;
+
+	if (alloc_id < IWL_FW_INI_ALLOCATION_INVALID ||
+	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM)
+		return -EIO;
+
+	if (le32_to_cpu(fwrt->trans->dbg.fw_mon_cfg[alloc_id].buf_location) !=
+	    IWL_FW_INI_LOCATION_DRAM_PATH)
+		return 0;
+
+	fw_mon = &fwrt->trans->dbg.fw_mon_ini[alloc_id];
+
+	/* the first fragment of DBGC1 is given to the FW via register
+	 * or context info
+	 */
+	if (alloc_id == IWL_FW_INI_ALLOCATION_ID_DBGC1)
+		fw_mon_idx++;
+
+	remain_frags = fw_mon->num_frags - fw_mon_idx;
+	if (!remain_frags)
+		return 0;
+
+	num_commands = DIV_ROUND_UP(remain_frags, BUF_ALLOC_MAX_NUM_FRAGS);
+
+	IWL_DEBUG_FW(fwrt, "WRT: Applying DRAM destination (alloc_id=%u)\n",
+		     alloc_id);
+
+	for (i = 0; i < num_commands; i++) {
+		u32 num_frags = min_t(u32, remain_frags,
+				      BUF_ALLOC_MAX_NUM_FRAGS);
+		struct iwl_buf_alloc_cmd data = {
+			.alloc_id = cpu_to_le32(alloc_id),
+			.num_frags = cpu_to_le32(num_frags),
+			.buf_location =
+				cpu_to_le32(IWL_FW_INI_LOCATION_DRAM_PATH),
+		};
+		struct iwl_host_cmd hcmd = {
+			.id = WIDE_ID(DEBUG_GROUP, BUFFER_ALLOCATION),
+			.data[0] = &data,
+			.len[0] = sizeof(data),
+		};
+		int ret, j;
+
+		for (j = 0; j < num_frags; j++) {
+			struct iwl_buf_alloc_frag *frag = &data.frags[j];
+			struct iwl_dram_data *fw_mon_frag =
+				&fw_mon->frags[fw_mon_idx++];
+
+			frag->addr = cpu_to_le64(fw_mon_frag->physical);
+			frag->size = cpu_to_le32(fw_mon_frag->size);
+		}
+		ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
+		if (ret)
+			return ret;
+
+		remain_frags -= num_frags;
+	}
+
+	return 0;
+}
+
+static void iwl_dbg_tlv_apply_buffers(struct iwl_fw_runtime *fwrt)
+{
+	int ret, i;
+
+	for (i = 0; i < IWL_FW_INI_ALLOCATION_NUM; i++) {
+		ret = iwl_dbg_tlv_apply_buffer(fwrt, i);
+		if (ret)
+			IWL_WARN(fwrt,
+				 "WRT: Failed to apply DRAM buffer for allocation id %d, ret=%d\n",
+				 i, ret);
+	}
+}
+
 static void iwl_dbg_tlv_send_hcmds(struct iwl_fw_runtime *fwrt,
 				   struct list_head *hcmd_list)
 {
@@ -670,6 +882,36 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt,
 	return 0;
 }
 
+static void iwl_dbg_tlv_init_cfg(struct iwl_fw_runtime *fwrt)
+{
+	enum iwl_fw_ini_buffer_location *ini_dest = &fwrt->trans->dbg.ini_dest;
+	int ret, i;
+
+	iwl_dbg_tlv_gen_active_trigs(fwrt, IWL_FW_DBG_DOMAIN);
+
+	*ini_dest = IWL_FW_INI_LOCATION_INVALID;
+	for (i = 0; i < IWL_FW_INI_ALLOCATION_NUM; i++) {
+		struct iwl_fw_ini_allocation_tlv *fw_mon_cfg =
+			&fwrt->trans->dbg.fw_mon_cfg[i];
+		u32 dest = le32_to_cpu(fw_mon_cfg->buf_location);
+
+		if (dest == IWL_FW_INI_LOCATION_INVALID)
+			continue;
+
+		if (*ini_dest == IWL_FW_INI_LOCATION_INVALID)
+			*ini_dest = dest;
+
+		if (dest != *ini_dest)
+			continue;
+
+		ret = iwl_dbg_tlv_alloc_fragments(fwrt, i);
+		if (ret)
+			IWL_WARN(fwrt,
+				 "WRT: Failed to allocate DRAM buffer for allocation id %d, ret=%d\n",
+				 i, ret);
+	}
+}
+
 void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 			    enum iwl_fw_ini_time_point tp_id,
 			    union iwl_dbg_tlv_tp_data *tp_data)
@@ -686,7 +928,12 @@ void iwl_dbg_tlv_time_point(struct iwl_fw_runtime *fwrt,
 
 	switch (tp_id) {
 	case IWL_FW_INI_TIME_POINT_EARLY:
-		iwl_dbg_tlv_gen_active_trigs(fwrt, IWL_FW_DBG_DOMAIN);
+		iwl_dbg_tlv_init_cfg(fwrt);
+		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
+		break;
+	case IWL_FW_INI_TIME_POINT_AFTER_ALIVE:
+		iwl_dbg_tlv_apply_buffers(fwrt);
+		iwl_dbg_tlv_send_hcmds(fwrt, hcmd_list);
 		iwl_dbg_tlv_tp_trigger(fwrt, trig_list, tp_data, NULL);
 		break;
 	default:
-- 
2.23.0

