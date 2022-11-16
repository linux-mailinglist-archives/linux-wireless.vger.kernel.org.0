Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A9E62C4FC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbiKPQnk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiKPQm6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:42:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5E75F6D
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FC9CB81DFC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FFAC433D6;
        Wed, 16 Nov 2022 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616751;
        bh=w1rQc49ptoM1sbj3yug/9mfiKKI0YtDqC3yWFPoIosA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cq8//xJ8SDqJvlAmSpnI28u1+KROp6e+mmGa1LHuDB826OPa3kQTtqyA15me5rkCf
         v8E7AN3QZMlduCtVBKiwtDql3xNZdBEYgaSorC5NWtCuptMBN4+nG2rA3psCFGo9oC
         oPQQnKTPCJ5tFDF2QOYUW3/OUY6KmFxw8M6Kwb991/UpREgT1u/s/HdDsCUqTcuphe
         T8TQ9+F4LkrdgPf/N0mNpSHNhP6r6vMVqfPcprXGmmvH1G5HNdvhCyNzhGW0ar3qUb
         j9gG1rwzSX1/mb94FbBVFGraMxo6OrsUhFYVxJj0WAzgbgohvFQANixb86dZyh+NI+
         AHyMue7F1+TMg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 04/50] wifi: ath12k: add ce.h
Date:   Wed, 16 Nov 2022 18:38:16 +0200
Message-Id: <20221116163902.24996-5-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/ce.h | 184 +++++++++++++++++++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
new file mode 100644
index 000000000000..17cf16235e0b
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_CE_H
+#define ATH12K_CE_H
+
+#define CE_COUNT_MAX 16
+
+/* Byte swap data words */
+#define CE_ATTR_BYTE_SWAP_DATA 2
+
+/* no interrupt on copy completion */
+#define CE_ATTR_DIS_INTR		8
+
+/* Host software's Copy Engine configuration. */
+#define CE_ATTR_FLAGS 0
+
+/* Threshold to poll for tx completion in case of Interrupt disabled CE's */
+#define ATH12K_CE_USAGE_THRESHOLD 32
+
+/* Directions for interconnect pipe configuration.
+ * These definitions may be used during configuration and are shared
+ * between Host and Target.
+ *
+ * Pipe Directions are relative to the Host, so PIPEDIR_IN means
+ * "coming IN over air through Target to Host" as with a WiFi Rx operation.
+ * Conversely, PIPEDIR_OUT means "going OUT from Host through Target over air"
+ * as with a WiFi Tx operation. This is somewhat awkward for the "middle-man"
+ * Target since things that are "PIPEDIR_OUT" are coming IN to the Target
+ * over the interconnect.
+ */
+#define PIPEDIR_NONE		0
+#define PIPEDIR_IN		1 /* Target-->Host, WiFi Rx direction */
+#define PIPEDIR_OUT		2 /* Host->Target, WiFi Tx direction */
+#define PIPEDIR_INOUT		3 /* bidirectional */
+#define PIPEDIR_INOUT_H2H	4 /* bidirectional, host to host */
+
+/* CE address/mask */
+#define CE_HOST_IE_ADDRESS	0x00A1803C
+#define CE_HOST_IE_2_ADDRESS	0x00A18040
+#define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
+
+#define CE_HOST_IE_3_SHIFT	0xC
+
+#define CE_RING_IDX_INCR(nentries_mask, idx) (((idx) + 1) & (nentries_mask))
+
+#define ATH12K_CE_RX_POST_RETRY_JIFFIES 50
+
+struct ath12k_base;
+
+/* Establish a mapping between a service/direction and a pipe.
+ * Configuration information for a Copy Engine pipe and services.
+ * Passed from Host to Target through QMI message and must be in
+ * little endian format.
+ */
+struct service_to_pipe {
+	__le32 service_id;
+	__le32 pipedir;
+	__le32 pipenum;
+};
+
+/* Configuration information for a Copy Engine pipe.
+ * Passed from Host to Target through QMI message during startup (one per CE).
+ *
+ * NOTE: Structure is shared between Host software and Target firmware!
+ */
+struct ce_pipe_config {
+	__le32 pipenum;
+	__le32 pipedir;
+	__le32 nentries;
+	__le32 nbytes_max;
+	__le32 flags;
+	__le32 reserved;
+};
+
+struct ce_attr {
+	/* CE_ATTR_* values */
+	unsigned int flags;
+
+	/* #entries in source ring - Must be a power of 2 */
+	unsigned int src_nentries;
+
+	/* Max source send size for this CE.
+	 * This is also the minimum size of a destination buffer.
+	 */
+	unsigned int src_sz_max;
+
+	/* #entries in destination ring - Must be a power of 2 */
+	unsigned int dest_nentries;
+
+	void (*recv_cb)(struct ath12k_base *ab, struct sk_buff *skb);
+};
+
+#define CE_DESC_RING_ALIGN 8
+
+struct ath12k_ce_ring {
+	/* Number of entries in this ring; must be power of 2 */
+	unsigned int nentries;
+	unsigned int nentries_mask;
+
+	/* For dest ring, this is the next index to be processed
+	 * by software after it was/is received into.
+	 *
+	 * For src ring, this is the last descriptor that was sent
+	 * and completion processed by software.
+	 *
+	 * Regardless of src or dest ring, this is an invariant
+	 * (modulo ring size):
+	 *     write index >= read index >= sw_index
+	 */
+	unsigned int sw_index;
+	/* cached copy */
+	unsigned int write_index;
+
+	/* Start of DMA-coherent area reserved for descriptors */
+	/* Host address space */
+	void *base_addr_owner_space_unaligned;
+	/* CE address space */
+	u32 base_addr_ce_space_unaligned;
+
+	/* Actual start of descriptors.
+	 * Aligned to descriptor-size boundary.
+	 * Points into reserved DMA-coherent area, above.
+	 */
+	/* Host address space */
+	void *base_addr_owner_space;
+
+	/* CE address space */
+	u32 base_addr_ce_space;
+
+	/* HAL ring id */
+	u32 hal_ring_id;
+
+	/* keep last */
+	struct sk_buff *skb[];
+};
+
+struct ath12k_ce_pipe {
+	struct ath12k_base *ab;
+	u16 pipe_num;
+	unsigned int attr_flags;
+	unsigned int buf_sz;
+	unsigned int rx_buf_needed;
+
+	void (*send_cb)(struct ath12k_ce_pipe *pipe);
+	void (*recv_cb)(struct ath12k_base *ab, struct sk_buff *skb);
+
+	struct tasklet_struct intr_tq;
+	struct ath12k_ce_ring *src_ring;
+	struct ath12k_ce_ring *dest_ring;
+	struct ath12k_ce_ring *status_ring;
+	u64 timestamp;
+};
+
+struct ath12k_ce {
+	struct ath12k_ce_pipe ce_pipe[CE_COUNT_MAX];
+	/* Protects rings of all ce pipes */
+	spinlock_t ce_lock;
+	struct ath12k_hp_update_timer hp_timer[CE_COUNT_MAX];
+};
+
+extern const struct ce_attr ath12k_host_ce_config_qcn9274[];
+extern const struct ce_attr ath12k_host_ce_config_wcn7850[];
+
+void ath12k_ce_cleanup_pipes(struct ath12k_base *ab);
+void ath12k_ce_rx_replenish_retry(struct timer_list *t);
+void ath12k_ce_per_engine_service(struct ath12k_base *ab, u16 ce_id);
+int ath12k_ce_send(struct ath12k_base *ab, struct sk_buff *skb, u8 pipe_id,
+		   u16 transfer_id);
+void ath12k_ce_rx_post_buf(struct ath12k_base *ab);
+int ath12k_ce_init_pipes(struct ath12k_base *ab);
+int ath12k_ce_alloc_pipes(struct ath12k_base *ab);
+void ath12k_ce_free_pipes(struct ath12k_base *ab);
+int ath12k_ce_get_attr_flags(struct ath12k_base *ab, int ce_id);
+void ath12k_ce_poll_send_completed(struct ath12k_base *ab, u8 pipe_id);
+int ath12k_ce_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
+				  u8 *ul_pipe, u8 *dl_pipe);
+int ath12k_ce_attr_attach(struct ath12k_base *ab);
+void ath12k_ce_get_shadow_config(struct ath12k_base *ab,
+				 u32 **shadow_cfg, u32 *shadow_cfg_len);
+#endif

