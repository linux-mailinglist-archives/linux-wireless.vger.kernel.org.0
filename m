Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A398FD922
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfKOJam (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:30:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKOJal (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:30:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 43A54615C4; Fri, 15 Nov 2019 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810240;
        bh=PiIWvdSQZsP6jGeaQgl/Q7FZ/cwUfJpPJrXC/qOCe0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+v68EU6wikCqor8r+bmbmV88HB93OPCOBT63IGrx4kWP6bIbWmeVzJW/zIzwnAqo
         vcgrDhtDFQhW0j39U+pjldS1Nah2NZadbQDY9felshgWXwt7F9JcrOduRJsjmqVzwp
         W3+U4WhGUGKaR5TCwzDcIAWBkAP3drmsPWw0/Vxs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60E6061497;
        Fri, 15 Nov 2019 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810226;
        bh=PiIWvdSQZsP6jGeaQgl/Q7FZ/cwUfJpPJrXC/qOCe0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyApTf7f4vOVfbCz2yVQ5LVXyDJM+utozNP6I2v61oazwq7kHcZWSVJEXYfSFdLJD
         Z21rObgBQXDraro5SiAuLagdksYxHpc+5WiflJC+SPtrMavuuP7xWzAayvjOT53CDe
         D7c3XJD2LFTz6BnPLAXXI2L/JI6Esr6RDsYGuZ5I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60E6061497
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 27/49] ath11k: add hal_tx.h
Date:   Fri, 15 Nov 2019 11:28:51 +0200
Message-Id: <1573810153-29623-28-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal_tx.h | 80 ++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
new file mode 100644
index 000000000000..f955070bcf1e
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_HAL_TX_H
+#define ATH11K_HAL_TX_H
+
+#include "hal_desc.h"
+
+#define HAL_TX_ADDRX_EN			1
+#define HAL_TX_ADDRY_EN			2
+
+#define HAL_TX_ADDR_SEARCH_INDEX	0
+#define HAL_TX_ADDR_SEARCH_DEFAULT	1
+
+struct hal_tx_info {
+	u16 meta_data_flags; /* %HAL_TCL_DATA_CMD_INFO0_META_ */
+	u8 ring_id;
+	u32 desc_id;
+	enum hal_tcl_desc_type type;
+	enum hal_tcl_encap_type encap_type;
+	dma_addr_t paddr;
+	u32 data_len;
+	u32 pkt_offset;
+	enum hal_encrypt_type encrypt_type;
+	u32 flags0; /* %HAL_TCL_DATA_CMD_INFO1_ */
+	u32 flags1; /* %HAL_TCL_DATA_CMD_INFO2_ */
+	u16 addr_search_flags; /* %HAL_TCL_DATA_CMD_INFO0_ADDR(X/Y)_ */
+	u16 bss_ast_hash;
+	u8 tid;
+	u8 search_type; /* %HAL_TX_ADDR_SEARCH_ */
+	u8 lmac_id;
+	u8 dscp_tid_tbl_idx;
+};
+
+/* TODO: Check if the actual desc macros can be used instead */
+#define HAL_TX_STATUS_FLAGS_FIRST_MSDU		BIT(0)
+#define HAL_TX_STATUS_FLAGS_LAST_MSDU		BIT(1)
+#define HAL_TX_STATUS_FLAGS_MSDU_IN_AMSDU	BIT(2)
+#define HAL_TX_STATUS_FLAGS_RATE_STATS_VALID	BIT(3)
+#define HAL_TX_STATUS_FLAGS_RATE_LDPC		BIT(4)
+#define HAL_TX_STATUS_FLAGS_RATE_STBC		BIT(5)
+#define HAL_TX_STATUS_FLAGS_OFDMA		BIT(6)
+
+#define HAL_TX_STATUS_DESC_LEN		sizeof(struct hal_wbm_release_ring)
+
+/* Tx status parsed from srng desc */
+struct hal_tx_status {
+	enum hal_wbm_rel_src_module buf_rel_source;
+	u32 desc_id;
+	enum hal_wbm_tqm_rel_reason status;
+	u8 ack_rssi;
+	enum hal_tx_rate_stats_bw bw;
+	enum hal_tx_rate_stats_pkt_type pkt_type;
+	enum hal_tx_rate_stats_sgi sgi;
+	u8 mcs;
+	u16 num_tones_in_ru;
+	u32 flags; /* %HAL_TX_STATUS_FLAGS_ */
+	u32 tsf;
+	u32 ppdu_id;
+	u8 try_cnt;
+	u8 tid;
+	u16 peer_id;
+};
+
+void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
+				  struct hal_tx_info *ti);
+void ath11k_hal_tx_desc_sync(void *tx_desc_cached, void *hw_desc);
+void ath11k_hal_tx_status_parse(struct ath11k_base *ab,
+				struct hal_wbm_release_ring *desc,
+				struct hal_tx_status *ts);
+void ath11k_hal_tx_status_desc_sync(void *hw_desc, void *local_desc);
+void ath11k_hal_tx_set_dscp_tid_map(struct ath11k_base *ab, int id);
+int ath11k_hal_reo_cmd_send(struct ath11k_base *ab, struct hal_srng *srng,
+			    enum hal_reo_cmd_type type,
+			    struct ath11k_hal_reo_cmd *cmd);
+void ath11k_hal_tx_init_data_ring(struct ath11k_base *ab,
+				  struct hal_srng *srng);
+#endif

