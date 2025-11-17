Return-Path: <linux-wireless+bounces-29012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2368C620E1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 03:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F978351E25
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 02:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051A81DA0E1;
	Mon, 17 Nov 2025 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2IaqDOLh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFFA748F;
	Mon, 17 Nov 2025 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344940; cv=none; b=sF8U+pB0gW4N7CS1pBvOxd30YlMjTBmcOCdgSL0ZCsMwQf7GYeLVV6dABOvMoeBJ4DOVXZ6BwYGXAvmewu3P06/v9O/SVV9essKW7ugfN/NK9o/Sf7wK57hkVNknMwmEoMN70IbIZe0DZgfaPIVqQ620qCABhRjzLGlpWXxMEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344940; c=relaxed/simple;
	bh=19ToZnFGnGTkoyVO+qwa4bluatMOa+rOqc8R6QPj6TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkxfAvr6vsePkSvZh2lzyhLGN9MlnN6aomSQh6+ePLLPC5MignVBVPucJKdabL/5WwEWXrRTacTtWlK57oSJfuQ0YQvYGLp18WE1ByE/f+KrysIZNof/xYQg3yRfbnEly69GTiJuxIGK7q/TxDO1UXnRMC/YPnlyxaPRupjy1FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2IaqDOLh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rPPVDdizGhaDXfs++43PIyDsN5sz2Cg7XShXwxWk52A=; b=2IaqDOLhGffzEc2xfM+p7nmOrv
	DsX/Ey7Bfn3C7qsTedKBUWpme10A5cBUnrh0uIWbXT3u1tHsFo6ixbhShFEC2BWtExKNu5+5AKQTJ
	2GsvVh0DPCbWiK7V1lymt5wqoR0bFUap6G89fBEIneFlRgVOr6KGEsBQEemFFfKVnYkDZ9V1cwdUV
	pyO4IxN3qCkjT5fMz7bQSDEPAbAfTqzXl4IP9xAd+8g8oyYIei4Q3CepRvMyfMqx5OFktpUw1AW86
	QFu/2M5B+xjXHQDqtty7G8lL4rj5z/8edvL2mlg/xGEEFVQyYpSPq5zke2SwZLbeXc7KD6HOnyYtq
	r1uBJTaw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKoZK-0000000FHt7-1z77;
	Mon, 17 Nov 2025 02:02:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] ath: wil6210: fix a bunch of kernel-doc warnings
Date: Sun, 16 Nov 2025 18:02:13 -0800
Message-ID: <20251117020213.443126-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/kernel-doc.py reports 51 kernel-doc warnings in wil6210.h.
Fix all kernel-doc warnings reported in wil6210.h.

Several comments are changed from "/**" to "/*" since it appears that
"/**" was used for many non-kernel-doc comments.

- add kernel-doc for missing function parameters
- add one function "Returns:"
- correct kernel-doc struct name to match actual struct name in 2 places

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/wil6210/wil6210.h |   33 +++++++++----------
 1 file changed, 16 insertions(+), 17 deletions(-)

--- linux-next-20251114.orig/drivers/net/wireless/ath/wil6210/wil6210.h
+++ linux-next-20251114/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -58,7 +58,7 @@ union wil_tx_desc;
  */
 #define WIL_MAX_VIFS 4
 
-/**
+/*
  * extract bits [@b0:@b1] (inclusive) from the value @x
  * it should be @b0 <= @b1, or result is incorrect
  */
@@ -433,7 +433,7 @@ extern struct fw_map fw_mapping[MAX_FW_M
  * @cid: CID value
  * @tid: TID value
  *
- * @cidxtid field encoded as bits 0..3 - CID; 4..7 - TID
+ * Returns: @cidxtid field encoded as bits 0..3 - CID; 4..7 - TID
  */
 static inline u8 mk_cidxtid(u8 cid, u8 tid)
 {
@@ -444,8 +444,7 @@ static inline u8 mk_cidxtid(u8 cid, u8 t
  * parse_cidxtid - parse @cidxtid field
  * @cid: store CID value here
  * @tid: store TID value here
- *
- * @cidxtid field encoded as bits 0..3 - CID; 4..7 - TID
+ * @cidxtid: field encoded as bits 0..3 - CID; 4..7 - TID
  */
 static inline void parse_cidxtid(u8 cidxtid, u8 *cid, u8 *tid)
 {
@@ -500,7 +499,7 @@ enum { /* for wil_ctx.mapped_as */
 	wil_mapped_as_page = 2,
 };
 
-/**
+/*
  * struct wil_ctx - software context for ring descriptor
  */
 struct wil_ctx {
@@ -514,7 +513,7 @@ struct wil_desc_ring_rx_swtail { /* rele
 	dma_addr_t pa;
 };
 
-/**
+/*
  * A general ring structure, used for RX and TX.
  * In legacy DMA it represents the vring,
  * In enahnced DMA it represents the descriptor ring (vrings are handled by FW)
@@ -531,7 +530,7 @@ struct wil_ring {
 	bool is_rx;
 };
 
-/**
+/*
  * Additional data for Rx ring.
  * Used for enhanced DMA RX chaining.
  */
@@ -543,7 +542,7 @@ struct wil_ring_rx_data {
 	u16 buff_size;
 };
 
-/**
+/*
  * Status ring structure, used for enhanced DMA completions for RX and TX.
  */
 struct wil_status_ring {
@@ -586,8 +585,8 @@ struct wil_net_stats {
 	u32 ft_roams; /* relevant in STA mode */
 };
 
-/**
- * struct tx_rx_ops - different TX/RX ops for legacy and enhanced
+/*
+ * struct wil_txrx_ops - different TX/RX ops for legacy and enhanced
  * DMA flow
  */
 struct wil_txrx_ops {
@@ -627,7 +626,7 @@ struct wil_txrx_ops {
 	irqreturn_t (*irq_rx)(int irq, void *cookie);
 };
 
-/**
+/*
  * Additional data for Tx ring
  */
 struct wil_ring_tx_data {
@@ -658,7 +657,7 @@ enum { /* for wil6210_priv.status */
 struct pci_dev;
 
 /**
- * struct tid_ampdu_rx - TID aggregation information (Rx).
+ * struct wil_tid_ampdu_rx - TID aggregation information (Rx).
  *
  * @reorder_buf: buffer to reorder incoming aggregated MPDUs
  * @last_rx: jiffies of last rx activity
@@ -728,7 +727,7 @@ enum wil_rekey_state {
 	WIL_REKEY_WAIT_M4_SENT = 2,
 };
 
-/**
+/*
  * struct wil_sta_info - data for peer
  *
  * Peer identified by its CID (connection ID)
@@ -741,7 +740,7 @@ struct wil_sta_info {
 	u8 mid;
 	enum wil_sta_status status;
 	struct wil_net_stats stats;
-	/**
+	/*
 	 * 20 latency bins. 1st bin counts packets with latency
 	 * of 0..tx_latency_res, last bin counts packets with latency
 	 * of 19*tx_latency_res and above.
@@ -882,7 +881,7 @@ struct wil6210_vif {
 	struct work_struct enable_tx_key_worker;
 };
 
-/**
+/*
  * RX buffer allocated for enhanced DMA RX descriptors
  */
 struct wil_rx_buff {
@@ -891,7 +890,7 @@ struct wil_rx_buff {
 	int id;
 };
 
-/**
+/*
  * During Rx completion processing, the driver extracts a buffer ID which
  * is used as an index to the rx_buff_mgmt.buff_arr array and then the SKB
  * is given to the network stack and the buffer is moved from the 'active'
@@ -1147,7 +1146,7 @@ static inline void wil_c(struct wil6210_
 	wil_w(wil, reg, wil_r(wil, reg) & ~val);
 }
 
-/**
+/*
  * wil_cid_valid - check cid is valid
  */
 static inline bool wil_cid_valid(struct wil6210_priv *wil, int cid)

