Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A318F58E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgCWNTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:19:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43388 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728357AbgCWNTh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:19:37 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzP-00023f-HJ; Mon, 23 Mar 2020 15:19:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:13 +0200
Message-Id: <iwlwifi.20200323151304.e5e694fd8e2d.I15151bddf589f13b0e0a45c28b96bbcd73bcfdeb@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/14] iwlwifi: yoyo: add PCI config space region type
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add a new region type that allows us to dump the PCI config space.
This is mostly the same as dumping a memory region, but reading from
the device's config space instead.

In order to make this generic and independent of the trans type, we
make a function called iwl_dump_ini_config_iter() that calls a new op
in the transport to read its config space.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 39 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |  6 +++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  3 ++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 91df1ee25dd0..d5dda93c3953 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1108,6 +1108,38 @@ static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int iwl_dump_ini_config_iter(struct iwl_fw_runtime *fwrt,
+				    struct iwl_dump_ini_region_data *reg_data,
+				    void *range_ptr, int idx)
+{
+	struct iwl_trans *trans = fwrt->trans;
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	__le32 *val = range->data;
+	u32 addr = le32_to_cpu(reg->addrs[idx]) +
+		   le32_to_cpu(reg->dev_addr.offset);
+	int i;
+
+	/* we shouldn't get here if the trans doesn't have read_config32 */
+	if (WARN_ON_ONCE(!trans->ops->read_config32))
+		return -EOPNOTSUPP;
+
+	range->internal_base_addr = cpu_to_le32(addr);
+	range->range_data_size = reg->dev_addr.size;
+	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
+		int ret;
+		u32 tmp;
+
+		ret = trans->ops->read_config32(trans, addr + i, &tmp);
+		if (ret < 0)
+			return ret;
+
+		*val++ = cpu_to_le32(tmp);
+	}
+
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 				     struct iwl_dump_ini_region_data *reg_data,
 				     void *range_ptr, int idx)
@@ -2052,7 +2084,12 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_range = iwl_dump_ini_csr_iter,
 	},
 	[IWL_FW_INI_REGION_DRAM_IMR] = {},
-	[IWL_FW_INI_REGION_PCI_IOSF_CONFIG] = {},
+	[IWL_FW_INI_REGION_PCI_IOSF_CONFIG] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_config_iter,
+	},
 };
 
 static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 4208e720f6e6..bf2f00b89214 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -236,6 +236,12 @@ static int iwl_dbg_tlv_alloc_region(struct iwl_trans *trans,
 		return -EINVAL;
 	}
 
+	if (type == IWL_FW_INI_REGION_PCI_IOSF_CONFIG &&
+	    !trans->ops->read_config32) {
+		IWL_ERR(trans, "WRT: Unsupported region type %u\n", type);
+		return -EOPNOTSUPP;
+	}
+
 	active_reg = &trans->dbg.active_regions[id];
 	if (*active_reg) {
 		IWL_WARN(trans, "WRT: Overriding region id %u\n", id);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 7b3b1f4c99b4..bba527b339b5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -544,6 +544,8 @@ struct iwl_trans_rxq_dma_data {
  * @read_mem: read device's SRAM in DWORD
  * @write_mem: write device's SRAM in DWORD. If %buf is %NULL, then the memory
  *	will be zeroed.
+ * @read_config32: read a u32 value from the device's config space at
+ *	the given offset.
  * @configure: configure parameters required by the transport layer from
  *	the op_mode. May be called several times before start_fw, can't be
  *	called after that.
@@ -614,6 +616,7 @@ struct iwl_trans_ops {
 			void *buf, int dwords);
 	int (*write_mem)(struct iwl_trans *trans, u32 addr,
 			 const void *buf, int dwords);
+	int (*read_config32)(struct iwl_trans *trans, u32 ofs, u32 *val);
 	void (*configure)(struct iwl_trans *trans,
 			  const struct iwl_trans_config *trans_cfg);
 	void (*set_pmi)(struct iwl_trans *trans, bool state);
-- 
2.25.1

