Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F852D4CAD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbgLIVRs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:17:48 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35600 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388097AbgLIVRn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:17:43 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pT-003Drx-6v; Wed, 09 Dec 2020 23:16:55 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:06 +0200
Message-Id: <iwlwifi.20201209231351.53bce4f8353d.Ia6944582bd2c748387aaef96755d8919c5d25dc1@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 02/47] iwlwifi: yoyo: add the ability to dump phy periphery
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

This enables analyzing phy/HW bugs.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 77 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 18 +++++
 2 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index ab4a8b942c81..579c1929729e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1066,9 +1066,10 @@ struct iwl_dump_ini_region_data {
 	struct iwl_fwrt_dump_data *dump_data;
 };
 
-static int iwl_dump_ini_prph_iter(struct iwl_fw_runtime *fwrt,
-				  struct iwl_dump_ini_region_data *reg_data,
-				  void *range_ptr, int idx)
+static int
+iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
+			   struct iwl_dump_ini_region_data *reg_data,
+			   void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1090,6 +1091,58 @@ static int iwl_dump_ini_prph_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int
+iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
+			   struct iwl_dump_ini_region_data *reg_data,
+			   void *range_ptr, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	__le32 *val = range->data;
+	u32 indirect_wr_addr = WMAL_INDRCT_RD_CMD1;
+	u32 indirect_rd_addr = WMAL_MRSPF_1;
+	u32 prph_val;
+	u32 addr = le32_to_cpu(reg->addrs[idx]);
+	u32 dphy_state;
+	u32 dphy_addr;
+	unsigned long flags;
+	int i;
+
+	range->internal_base_addr = cpu_to_le32(addr);
+	range->range_data_size = reg->dev_addr.size;
+
+	if (fwrt->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		indirect_wr_addr = WMAL_INDRCT_CMD1;
+
+	indirect_wr_addr += le32_to_cpu(reg->dev_addr.offset);
+	indirect_rd_addr += le32_to_cpu(reg->dev_addr.offset);
+
+	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
+		return -EBUSY;
+
+	dphy_addr = (reg->dev_addr.offset) ? WFPM_LMAC2_PS_CTL_RW :
+					     WFPM_LMAC1_PS_CTL_RW;
+	dphy_state = iwl_read_umac_prph_no_grab(fwrt->trans, dphy_addr);
+
+	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
+		if (dphy_state == HBUS_TIMEOUT ||
+		    (dphy_state & WFPM_PS_CTL_RW_PHYRF_PD_FSM_CURSTATE_MSK) !=
+		    WFPM_PHYRF_STATE_ON) {
+			*val++ = cpu_to_le32(WFPM_DPHY_OFF);
+			continue;
+		}
+
+		iwl_write_prph_no_grab(fwrt->trans, indirect_wr_addr,
+				       WMAL_INDRCT_CMD(addr + i));
+		prph_val = iwl_read_prph_no_grab(fwrt->trans,
+						 indirect_rd_addr);
+		*val++ = cpu_to_le32(prph_val);
+	}
+
+	iwl_trans_release_nic_access(fwrt->trans, &flags);
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
 				 void *range_ptr, int idx)
@@ -2152,9 +2205,14 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
 		.get_size = iwl_dump_ini_mem_get_size,
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
-		.fill_range = iwl_dump_ini_prph_iter,
+		.fill_range = iwl_dump_ini_prph_mac_iter,
+	},
+	[IWL_FW_INI_REGION_PERIPHERY_PHY] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_prph_phy_iter,
 	},
-	[IWL_FW_INI_REGION_PERIPHERY_PHY] = {},
 	[IWL_FW_INI_REGION_PERIPHERY_AUX] = {},
 	[IWL_FW_INI_REGION_PAGING] = {
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
@@ -2188,6 +2246,7 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 				struct list_head *list)
 {
 	struct iwl_fw_ini_trigger_tlv *trigger = dump_data->trig;
+	enum iwl_fw_ini_time_point tp_id = le32_to_cpu(trigger->time_point);
 	struct iwl_dump_ini_region_data reg_data = {
 		.dump_data = dump_data,
 	};
@@ -2218,6 +2277,14 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		if (reg_type >= ARRAY_SIZE(iwl_dump_ini_region_ops))
 			continue;
 
+		if (reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY &&
+		    tp_id != IWL_FW_INI_TIME_POINT_FW_ASSERT) {
+			IWL_WARN(fwrt,
+				 "WRT: trying to collect phy prph at time point: %d, skipping\n",
+				 tp_id);
+			continue;
+		}
+
 		size += iwl_dump_ini_mem(fwrt, list, &reg_data,
 					 &iwl_dump_ini_region_ops[reg_type]);
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index fa3f15778fc7..4417fefe834e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -473,4 +473,22 @@ enum {
 
 #define IWL_D3_SLEEP_STATUS_SUSPEND	0xD3
 #define IWL_D3_SLEEP_STATUS_RESUME	0xD0
+
+#define WMAL_INDRCT_RD_CMD1_OPMOD_POS 28
+#define WMAL_INDRCT_RD_CMD1_BYTE_ADDRESS_MSK 0xFFFFF
+#define WMAL_CMD_READ_BURST_ACCESS 2
+#define WMAL_MRSPF_1 0xADFC20
+#define WMAL_INDRCT_RD_CMD1 0xADFD44
+#define WMAL_INDRCT_CMD1 0xADFC14
+#define WMAL_INDRCT_CMD(addr) \
+	((WMAL_CMD_READ_BURST_ACCESS << WMAL_INDRCT_RD_CMD1_OPMOD_POS) | \
+	 ((addr) & WMAL_INDRCT_RD_CMD1_BYTE_ADDRESS_MSK))
+
+#define WFPM_LMAC1_PS_CTL_RW 0xA03380
+#define WFPM_LMAC2_PS_CTL_RW 0xA033C0
+#define WFPM_PS_CTL_RW_PHYRF_PD_FSM_CURSTATE_MSK 0x0000000F
+#define WFPM_PHYRF_STATE_ON 5
+#define HBUS_TIMEOUT 0xA5A5A5A1
+#define WFPM_DPHY_OFF 0xDF10FF
+
 #endif				/* __iwl_prph_h__ */
-- 
2.29.2

