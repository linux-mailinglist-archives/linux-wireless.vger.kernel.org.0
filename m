Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D75A5913B1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiHLQKu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbiHLQKo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF6F402C2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F739B8247E
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7986EC433B5;
        Fri, 12 Aug 2022 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320632;
        bh=bnC1sdo0RRI6xwZXqYA9nwt6fANQTYIM3zT4cXCCt9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUJqlOWGldZHMIDJBLFFovWFaQ4eMOUwQUngXVXy0wUNoIOLq7DIEKfRe7qvP8WNc
         ZThowHnxxvwDPtM7mBlDsVjq+UxzSwdVvogMmnVfFoXcR53Y5Hb/Ivar6b9bOPfdQi
         JQMRMemwNw3Q9bBEdYnKwV3vgO6GAa2vi5uoshXMMrdXjbJNw9npR8szv9w5yUfOhP
         fYSqvqQN2BAJmTDuxsFAhIdp0REvKmqqvZ1XZFqNFUr6tZQFKtjhNaGlnlRU82o1me
         PSz7l+rDNPI3KUMTHwRhDR6LXPNH0qxqU4BLWJu/7gjzbZ1qJ1MKf4m31B/ErWoyz7
         60/nK/Hg/INDw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 24/50] wifi: ath12k: add hal_tx.c
Date:   Fri, 12 Aug 2022 19:09:37 +0300
Message-Id: <20220812161003.27279-25-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/net/wireless/ath/ath12k/hal_tx.c | 137 +++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.c b/drivers/net/wireless/ath/ath12k/hal_tx.c
new file mode 100644
index 000000000000..ac6f83ec06c2
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/hal_tx.c
@@ -0,0 +1,137 @@
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
+ *
+ * DSCP        TID
+ * 000000      0
+ * 001000      1
+ * 010000      2
+ * 011000      3
+ * 100000      4
+ * 101000      5
+ * 110000      6
+ * 111000      7
+ */
+static const u8 dscp_tid_map[DSCP_TID_MAP_TBL_ENTRY_SIZE] = {
+	0, 0, 0, 0, 0, 0, 0, 0,
+	1, 1, 1, 1, 1, 1, 1, 1,
+	2, 2, 2, 2, 2, 2, 2, 2,
+	3, 3, 3, 3, 3, 3, 3, 3,
+	4, 4, 4, 4, 4, 4, 4, 4,
+	5, 5, 5, 5, 5, 5, 5, 5,
+	6, 6, 6, 6, 6, 6, 6, 6,
+	7, 7, 7, 7, 7, 7, 7, 7,
+};
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
+	u8 hw_map_val[HAL_DSCP_TID_TBL_SIZE];
+	int i;
+	u32 value;
+	int cnt = 0;
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
+	for (i = 0; i < DSCP_TID_MAP_TBL_ENTRY_SIZE; i += 8) {
+		value = u32_encode_bits(dscp_tid_map[i],
+					HAL_TCL1_RING_FIELD_DSCP_TID_MAP0) |
+			u32_encode_bits(dscp_tid_map[i + 1],
+					HAL_TCL1_RING_FIELD_DSCP_TID_MAP1) |
+			u32_encode_bits(dscp_tid_map[i + 2],
+					HAL_TCL1_RING_FIELD_DSCP_TID_MAP2) |
+			u32_encode_bits(dscp_tid_map[i + 3],
+					HAL_TCL1_RING_FIELD_DSCP_TID_MAP3) |
+			u32_encode_bits(dscp_tid_map[i + 4],
+					HAL_TCL1_RING_FIELD_DSCP_TID_MAP4) |
+			u32_encode_bits(dscp_tid_map[i + 5],
+					HAL_TCL1_RING_FIELD_DSCP_TID_MAP5) |
+			u32_encode_bits(dscp_tid_map[i + 6],
+					HAL_TCL1_RING_FIELD_DSCP_TID_MAP6) |
+			u32_encode_bits(dscp_tid_map[i + 7],
+					HAL_TCL1_RING_FIELD_DSCP_TID_MAP7);
+
+		memcpy(&hw_map_val[cnt], &value, 3);
+		cnt += 3;
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

