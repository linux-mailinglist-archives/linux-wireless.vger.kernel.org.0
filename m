Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26A5FD8F4
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKOJ3h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:29:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51650 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfKOJ3h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:29:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 62A436127B; Fri, 15 Nov 2019 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810175;
        bh=eF9YcReED50y6xRQcQT4r6LjSIxCxhIhVsoIjVyknrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcLeCnFuqMzbwUzwdgQgO6SFF5Xqz6Fe+TCZrbT+RmR8buHAUfw8xjFt2MNlhR5bw
         3DuKT04A9JNDpHVqnHHrqZrq9G5F9zBZL+Py4EJowDyvXJnowA0aP8jZZHuqkfSy/K
         4f/+5ZIvwgc5URIg/cjT9HnlOfBczV+uoHTUEcos=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1C2DE61180;
        Fri, 15 Nov 2019 09:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810170;
        bh=eF9YcReED50y6xRQcQT4r6LjSIxCxhIhVsoIjVyknrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OsDCrVgGa6aygBJNV/tw+fOE3orNHbJsaMno0ylJJB/N+dj2DmxgrjcGjtF54Rv2f
         /z4SC47nxFPdClKfmR8Qf2cyz9LP0POlKXpqiADJNiUu67sx82voPNbHps9xAp67w0
         vQLJEYpFCeUrBe4IjSQLKNqpGjKy0aW+OO8xngUI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1C2DE61180
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 07/49] ath11k: add ce.h
Date:   Fri, 15 Nov 2019 11:28:31 +0200
Message-Id: <1573810153-29623-8-git-send-email-kvalo@codeaurora.org>
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
 drivers/net/wireless/ath/ath11k/ce.h | 178 +++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
new file mode 100644
index 000000000000..6174eac84410
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_CE_H
+#define ATH11K_CE_H
+
+#define CE_COUNT 12
+
+/* Byte swap data words */
+#define CE_ATTR_BYTE_SWAP_DATA 2
+
+/* no interrupt on copy completion */
+#define CE_ATTR_DIS_INTR		8
+
+/* Host software's Copy Engine configuration. */
+#ifdef __BIG_ENDIAN
+#define CE_ATTR_FLAGS CE_ATTR_BYTE_SWAP_DATA
+#else
+#define CE_ATTR_FLAGS 0
+#endif
+
+/* Threshold to poll for tx completion in case of Interrupt disabled CE's */
+#define ATH11K_CE_USAGE_THRESHOLD 32
+
+void ath11k_ce_byte_swap(void *mem, u32 len);
+
+/*
+ * Directions for interconnect pipe configuration.
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
+#define ATH11K_CE_RX_POST_RETRY_JIFFIES 50
+
+struct ath11k_base;
+
+/* Establish a mapping between a service/direction and a pipe. */
+struct service_to_pipe {
+	__le32 service_id;
+	__le32 pipedir;
+	__le32 pipenum;
+};
+
+/*
+ * Configuration information for a Copy Engine pipe.
+ * Passed from Host to Target during startup (one per CE).
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
+	/*
+	 * Max source send size for this CE.
+	 * This is also the minimum size of a destination buffer.
+	 */
+	unsigned int src_sz_max;
+
+	/* #entries in destination ring - Must be a power of 2 */
+	unsigned int dest_nentries;
+
+	void (*recv_cb)(struct ath11k_base *, struct sk_buff *);
+};
+
+#define CE_DESC_RING_ALIGN 8
+
+struct ath11k_ce_ring {
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
+	struct sk_buff *skb[0];
+};
+
+struct ath11k_ce_pipe {
+	struct ath11k_base *ab;
+	u16 pipe_num;
+	unsigned int attr_flags;
+	unsigned int buf_sz;
+	unsigned int rx_buf_needed;
+
+	void (*send_cb)(struct ath11k_ce_pipe *);
+	void (*recv_cb)(struct ath11k_base *, struct sk_buff *);
+
+	struct tasklet_struct intr_tq;
+	struct ath11k_ce_ring *src_ring;
+	struct ath11k_ce_ring *dest_ring;
+	struct ath11k_ce_ring *status_ring;
+};
+
+struct ath11k_ce {
+	struct ath11k_ce_pipe ce_pipe[CE_COUNT];
+	/* Protects rings of all ce pipes */
+	spinlock_t ce_lock;
+};
+
+void ath11k_ce_cleanup_pipes(struct ath11k_base *ab);
+void ath11k_ce_rx_replenish_retry(struct timer_list *t);
+void ath11k_ce_per_engine_service(struct ath11k_base *ab, u16 ce_id);
+int ath11k_ce_send(struct ath11k_base *ab, struct sk_buff *skb, u8 pipe_id,
+		   u16 transfer_id);
+void ath11k_ce_rx_post_buf(struct ath11k_base *ab);
+int ath11k_ce_init_pipes(struct ath11k_base *ab);
+int ath11k_ce_alloc_pipes(struct ath11k_base *ab);
+void ath11k_ce_free_pipes(struct ath11k_base *ab);
+int ath11k_ce_get_attr_flags(int ce_id);
+void ath11k_ce_poll_send_completed(struct ath11k_base *ab, u8 pipe_id);
+#endif

