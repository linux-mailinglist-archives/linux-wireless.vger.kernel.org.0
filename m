Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594AA62C511
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239093AbiKPQoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbiKPQnZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB5B65EC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6722AB81DBF
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883FDC433D7;
        Wed, 16 Nov 2022 16:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616773;
        bh=yXTBYLKDGdc+yKHG1u2j2kJjKo1odXchzlJB4BwWIxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nGdPharb1EueLxsziDtrEcgwzXdc6Vg6XLMZxbJFhOl5+Mw74krfCYFI7pSxLZQVW
         P4KaLGiPnu2TiAvNjI/vs5kQdgH/K02ekb7RrDSo9mIJ9NhY0Gn/fnETTyfE44Gdou
         3saqGdcqLQDumIP1cYNl1j9EadfYpithfA5h+dhtfjzbD+bo3RGgiYz9Me/MIiBkOk
         rsb8BYLgfw5zvQkixzSR6kMfswtRt7eippczOR27NJ87IBiOMqFdFUNRteo5g6/EEm
         +3MxxVDIwiS1DjhwYto9jCAglDK2YmntlGp73+IiVdpLr/aOIclwdzCqwUjK/Kz7FZ
         5KsO9q1XJgPOw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 24/50] wifi: ath12k: add hal_tx.c
Date:   Wed, 16 Nov 2022 18:38:36 +0200
Message-Id: <20221116163902.24996-25-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org>
References: <20221116163902.24996-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal_tx.c | 145 +++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.c b/drivers/net/wireless/ath/ath12k/hal_tx.c
new file mode 100644
index 000000000000..869e07e406fe
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/hal_tx.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "hal_desc.h"
+#include "hal.h"
+#include "hal_tx.h"
+#include "hif.h"
+
+#define DSCP_TID_MAP_TBL_ENTRY_SIZE 64
+
+/* dscp_tid_map - Default DSCP-TID mapping
+ *=================
+ * DSCP        TID
+ *=================
+ * 000xxx      0
+ * 001xxx      1
+ * 010xxx      2
+ * 011xxx      3
+ * 100xxx      4
+ * 101xxx      5
+ * 110xxx      6
+ * 111xxx      7
+ */
+static inline u8 dscp2tid(u8 dscp)
+{
+	return dscp >> 3;
+}
+
+void ath12k_hal_tx_cmd_desc_setup(struct ath12k_base *ab,
+				  struct hal_tcl_data_cmd *tcl_cmd,
+				  struct hal_tx_info *ti)
+{
+	tcl_cmd->buf_addr_info.info0 =
+		le32_encode_bits(ti->paddr, BUFFER_ADDR_INFO0_ADDR);
+	tcl_cmd->buf_addr_info.info1 =
+		le32_encode_bits(((uint64_t)ti->paddr >> HAL_ADDR_MSB_REG_SHIFT),
+				 BUFFER_ADDR_INFO1_ADDR);
+	tcl_cmd->buf_addr_info.info1 |=
+		le32_encode_bits((ti->rbm_id), BUFFER_ADDR_INFO1_RET_BUF_MGR) |
+		le32_encode_bits(ti->desc_id, BUFFER_ADDR_INFO1_SW_COOKIE);
+
+	tcl_cmd->info0 =
+		le32_encode_bits(ti->type, HAL_TCL_DATA_CMD_INFO0_DESC_TYPE) |
+		le32_encode_bits(ti->bank_id, HAL_TCL_DATA_CMD_INFO0_BANK_ID);
+
+	tcl_cmd->info1 =
+		le32_encode_bits(ti->meta_data_flags,
+				 HAL_TCL_DATA_CMD_INFO1_CMD_NUM);
+
+	tcl_cmd->info2 = cpu_to_le32(ti->flags0) |
+		le32_encode_bits(ti->data_len, HAL_TCL_DATA_CMD_INFO2_DATA_LEN) |
+		le32_encode_bits(ti->pkt_offset, HAL_TCL_DATA_CMD_INFO2_PKT_OFFSET);
+
+	tcl_cmd->info3 = cpu_to_le32(ti->flags1) |
+		le32_encode_bits(ti->tid, HAL_TCL_DATA_CMD_INFO3_TID) |
+		le32_encode_bits(ti->lmac_id, HAL_TCL_DATA_CMD_INFO3_PMAC_ID) |
+		le32_encode_bits(ti->vdev_id, HAL_TCL_DATA_CMD_INFO3_VDEV_ID);
+
+	tcl_cmd->info4 = le32_encode_bits(ti->bss_ast_idx,
+					  HAL_TCL_DATA_CMD_INFO4_SEARCH_INDEX) |
+			 le32_encode_bits(ti->bss_ast_hash,
+					  HAL_TCL_DATA_CMD_INFO4_CACHE_SET_NUM);
+	tcl_cmd->info5 = 0;
+}
+
+void ath12k_hal_tx_set_dscp_tid_map(struct ath12k_base *ab, int id)
+{
+	u32 ctrl_reg_val;
+	u32 addr;
+	u8 hw_map_val[HAL_DSCP_TID_TBL_SIZE], dscp, tid;
+	int i;
+	u32 value;
+
+	ctrl_reg_val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
+					 HAL_TCL1_RING_CMN_CTRL_REG);
+	/* Enable read/write access */
+	ctrl_reg_val |= HAL_TCL1_RING_CMN_CTRL_DSCP_TID_MAP_PROG_EN;
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
+			   HAL_TCL1_RING_CMN_CTRL_REG, ctrl_reg_val);
+
+	addr = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL1_RING_DSCP_TID_MAP +
+	       (4 * id * (HAL_DSCP_TID_TBL_SIZE / 4));
+
+	/* Configure each DSCP-TID mapping in three bits there by configure
+	 * three bytes in an iteration.
+	 */
+	for (i = 0, dscp = 0; i < HAL_DSCP_TID_TBL_SIZE; i += 3) {
+		tid = dscp2tid(dscp);
+		value = u32_encode_bits(tid, HAL_TCL1_RING_FIELD_DSCP_TID_MAP0);
+		dscp++;
+
+		tid = dscp2tid(dscp);
+		value |= u32_encode_bits(tid, HAL_TCL1_RING_FIELD_DSCP_TID_MAP1);
+		dscp++;
+
+		tid = dscp2tid(dscp);
+		value |= u32_encode_bits(tid, HAL_TCL1_RING_FIELD_DSCP_TID_MAP2);
+		dscp++;
+
+		tid = dscp2tid(dscp);
+		value |= u32_encode_bits(tid, HAL_TCL1_RING_FIELD_DSCP_TID_MAP3);
+		dscp++;
+
+		tid = dscp2tid(dscp);
+		value |= u32_encode_bits(tid, HAL_TCL1_RING_FIELD_DSCP_TID_MAP4);
+		dscp++;
+
+		tid = dscp2tid(dscp);
+		value |= u32_encode_bits(tid, HAL_TCL1_RING_FIELD_DSCP_TID_MAP5);
+		dscp++;
+
+		tid = dscp2tid(dscp);
+		value |= u32_encode_bits(tid, HAL_TCL1_RING_FIELD_DSCP_TID_MAP6);
+		dscp++;
+
+		tid = dscp2tid(dscp);
+		value |= u32_encode_bits(tid, HAL_TCL1_RING_FIELD_DSCP_TID_MAP7);
+		dscp++;
+
+		memcpy(&hw_map_val[i], &value, 3);
+	}
+
+	for (i = 0; i < HAL_DSCP_TID_TBL_SIZE; i += 4) {
+		ath12k_hif_write32(ab, addr, *(u32 *)&hw_map_val[i]);
+		addr += 4;
+	}
+
+	/* Disable read/write access */
+	ctrl_reg_val = ath12k_hif_read32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
+					 HAL_TCL1_RING_CMN_CTRL_REG);
+	ctrl_reg_val &= ~HAL_TCL1_RING_CMN_CTRL_DSCP_TID_MAP_PROG_EN;
+	ath12k_hif_write32(ab, HAL_SEQ_WCSS_UMAC_TCL_REG +
+			   HAL_TCL1_RING_CMN_CTRL_REG,
+			   ctrl_reg_val);
+}
+
+void ath12k_hal_tx_configure_bank_register(struct ath12k_base *ab, u32 bank_config,
+					   u8 bank_id)
+{
+	ath12k_hif_write32(ab, HAL_TCL_SW_CONFIG_BANK_ADDR + 4 * bank_id,
+			   bank_config);
+}

