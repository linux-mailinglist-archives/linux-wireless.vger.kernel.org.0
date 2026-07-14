Return-Path: <linux-wireless+bounces-39097-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eaLOAHd4Vmqn6QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39097-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:57:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ABB757A88
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 19:57:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=HzVzJAd8;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39097-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39097-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C54B31A0ADC
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C631E851;
	Tue, 14 Jul 2026 17:52:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2377F3126B0
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 17:52:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051541; cv=none; b=mKdWHCv+gnyq1BaKwsRPxrgGkRAjkOPE3XYCt6SI7Jnjjer83OSGWMQ6BSVT465C/UGqUUHv+gKxvBL1pebshuk+mlBqjKdzO0HDZQGSUpzFcziD1bekvjWeCW8J5qxDB2HrfrW2XOsUfG7+XBq6J+56Sw7q6bLrF5XOJ6Qo3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051541; c=relaxed/simple;
	bh=mlae/lkDPvA6UHvzVumik/UBaj343DJycP+KZT21HTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEkdXUXbqCmKek0JMvmDmOR0L4A+JnHyBQhbq2ps/2XmrWGwSj1NY1ZSPzqHIdpxjFtSx5yHgL8MhPy3nZtl+GQnc/Xy6WhkNpgERrDUuMNqEKZap+jZ4TyZgHHFg1khkw3gwyzdmr302HbM5UAq+iHmO/Yh3iTlv7gFNvjfQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HzVzJAd8; arc=none smtp.client-ip=95.215.58.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784051531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ij7j7s/jH59tqxTiyYXspASFf43o47cHui6+04S+o+k=;
	b=HzVzJAd8HeW7cgDFRTF1XTcMLGFN5MvZ/gXUminM1lB7cT/QyzjtTA7Y6Ty6NPJAG3oa6I
	7Os3MEiVW1u0qbJLL4bg4gjauI7OjgkScCcJc6NqGmRDyKiwENXHoOj0qusRsRHoVAZLF+
	pPJ7BHGILRdEQcD56ANLOCz9zuyzqc4=
From: luka.gejak@linux.dev
To: linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com,
	straube.linux@gmail.com,
	luka.gejak@linux.dev
Subject: [RFC PATCH v1 8/9] wifi: rtw88: 8723bs: implement the SDIO transfer contract
Date: Tue, 14 Jul 2026 19:51:06 +0200
Message-ID: <b0d0a5fb2769e582aeb6b0a42b0b6aa16320efc0.1784047561.git.luka.gejak@linux.dev>
In-Reply-To: <cover.1784047561.git.luka.gejak@linux.dev>
References: <cover.1784047561.git.luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-39097-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:pkshih@realtek.com,m:straube.linux@gmail.com,m:luka.gejak@linux.dev,m:straubelinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,linux-wireless@vger.kernel.org]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86ABB757A88

From: Luka Gejak <luka.gejak@linux.dev>

Feed received beacons and probe responses to the association beacon wait,
and use the RTL8723BS RX aggregation thresholds and RX-only interrupt
contract.

Match the vendor SDIO TX path: preserve the response-recognition control
bit, route management and voice traffic through the high-priority FIFO,
separate the FIFO dword length from the block-rounded CMD53 transfer size,
zero-pad transfers, gate writes on OQT and cached dedicated/public free
pages, and relatch the RQPN split when the hardware counters are empty.
Keep the fixed management/reserved-page descriptor offset, yield after each
management write, and report management completion at SDIO DMA completion
because the vendor SW_DEFINE value cannot uniquely match asynchronous TX
reports.

Finally, bound the per-AC software TX FIFO: stop a mac80211 queue at the
high watermark and resume it after the drain path reaches the low
watermark.
This prevents unbounded queueing latency and uplink congestion collapse.

Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/net/wireless/realtek/rtw88/sdio.c | 443 +++++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/sdio.h |  18 +
 2 files changed, 408 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 5b40d74b16ee..6b55716b063b 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -20,6 +20,15 @@
 #include "tx.h"
 
 #define RTW_SDIO_INDIRECT_RW_RETRIES			50
+#define RTW_SDIO_OQT_TIMEOUT_MS				1000
+
+/* 8723BS SDIO TX FIFO back-pressure watermarks: stop the mac80211 queue once
+ * the per-AC software FIFO fills past the high watermark, and wake it from the
+ * TX drain path once it falls back to the low one. Bounds the queueing latency
+ * that otherwise causes uplink bufferbloat / congestion collapse.
+ */
+#define RTW_SDIO_TX_FIFO_HIWATER			16
+#define RTW_SDIO_TX_FIFO_LOWATER			8
 
 static bool rtw_sdio_is_bus_addr(u32 addr)
 {
@@ -479,8 +488,14 @@ static u32 rtw_sdio_get_tx_addr(struct rtw_dev *rtwdev, size_t size,
 		txaddr = FIELD_PREP(REG_SDIO_CMD_ADDR_MSK,
 				    REG_SDIO_CMD_ADDR_TXFF_HIGH);
 		break;
-	case RTW_TX_QUEUE_VI:
 	case RTW_TX_QUEUE_VO:
+		if (rtw_is_8723bs_sdio(rtwdev)) {
+			txaddr = FIELD_PREP(REG_SDIO_CMD_ADDR_MSK,
+					    REG_SDIO_CMD_ADDR_TXFF_HIGH);
+			break;
+		}
+		fallthrough;
+	case RTW_TX_QUEUE_VI:
 		txaddr = FIELD_PREP(REG_SDIO_CMD_ADDR_MSK,
 				    REG_SDIO_CMD_ADDR_TXFF_NORMAL);
 		break;
@@ -491,6 +506,8 @@ static u32 rtw_sdio_get_tx_addr(struct rtw_dev *rtwdev, size_t size,
 		break;
 	case RTW_TX_QUEUE_MGMT:
 		txaddr = FIELD_PREP(REG_SDIO_CMD_ADDR_MSK,
+				    rtw_is_8723bs_sdio(rtwdev) ?
+				    REG_SDIO_CMD_ADDR_TXFF_HIGH :
 				    REG_SDIO_CMD_ADDR_TXFF_EXTRA);
 		break;
 	default:
@@ -548,40 +565,111 @@ static int rtw_sdio_read_port(struct rtw_dev *rtwdev, u8 *buf, size_t count)
 	return ret;
 }
 
+static void rtw_sdio_init_free_txpg(struct rtw_dev *rtwdev)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	const struct rtw_page_table *pg_tbl;
+	u32 free_txpg;
+	u16 pubq_num;
+
+	if (!rtw_is_8723bs_sdio(rtwdev))
+		return;
+
+	pg_tbl = &rtwdev->chip->page_table[0];
+	pubq_num = rtwdev->fifo.acq_pg_num - pg_tbl->hq_num - pg_tbl->lq_num -
+		   pg_tbl->nq_num - pg_tbl->exq_num - pg_tbl->gapq_num;
+	free_txpg = rtw_read32(rtwdev, REG_SDIO_FREE_TXPG);
+	if (free_txpg) {
+		atomic_set(&rtwsdio->free_pg_high, free_txpg & 0xff);
+		atomic_set(&rtwsdio->free_pg_normal, (free_txpg >> 8) & 0xff);
+		atomic_set(&rtwsdio->free_pg_low, (free_txpg >> 16) & 0xff);
+		atomic_set(&rtwsdio->free_pg_pub, (free_txpg >> 24) & 0xff);
+	} else {
+		atomic_set(&rtwsdio->free_pg_high, pg_tbl->hq_num);
+		atomic_set(&rtwsdio->free_pg_normal, pg_tbl->nq_num);
+		atomic_set(&rtwsdio->free_pg_low, pg_tbl->lq_num);
+		atomic_set(&rtwsdio->free_pg_pub, pubq_num);
+	}
+
+	atomic_set(&rtwsdio->tx_oqt_free,
+		   rtw_read8(rtwdev, REG_SDIO_OQT_FREE_PG));
+}
+
+static void rtw_sdio_sync_free_txpg(struct rtw_dev *rtwdev)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	u32 free_txpg = rtw_read32(rtwdev, REG_SDIO_FREE_TXPG);
+
+	if (!free_txpg)
+		return;
+
+	atomic_set(&rtwsdio->free_pg_high, free_txpg & 0xff);
+	atomic_set(&rtwsdio->free_pg_normal, (free_txpg >> 8) & 0xff);
+	atomic_set(&rtwsdio->free_pg_low, (free_txpg >> 16) & 0xff);
+	atomic_set(&rtwsdio->free_pg_pub, (free_txpg >> 24) & 0xff);
+}
+
+static int rtw_sdio_8723bs_free_txpg(struct rtw_dev *rtwdev, u8 queue)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+
+	switch (queue) {
+	case RTW_TX_QUEUE_BCN:
+	case RTW_TX_QUEUE_H2C:
+	case RTW_TX_QUEUE_HI0:
+	case RTW_TX_QUEUE_MGMT:
+	case RTW_TX_QUEUE_VO:
+		return atomic_read(&rtwsdio->free_pg_high);
+	case RTW_TX_QUEUE_VI:
+		return atomic_read(&rtwsdio->free_pg_normal);
+	case RTW_TX_QUEUE_BE:
+	case RTW_TX_QUEUE_BK:
+		return atomic_read(&rtwsdio->free_pg_low);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int rtw_sdio_check_free_txpg(struct rtw_dev *rtwdev, u8 queue,
 				    size_t count)
 {
 	unsigned int pages_free, pages_needed;
 
-	if (rtw_chip_wcpu_8051(rtwdev)) {
-		u32 free_txpg;
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+		int dedicated = rtw_sdio_8723bs_free_txpg(rtwdev, queue);
 
-		free_txpg = rtw_sdio_read32(rtwdev, REG_SDIO_FREE_TXPG);
+		if (dedicated < 0)
+			return dedicated;
+		pages_free = dedicated + atomic_read(&rtwsdio->free_pg_pub);
+		pages_needed = DIV_ROUND_UP(count, rtwdev->chip->page_size);
+		if (pages_needed <= pages_free)
+			return 0;
+
+		rtw_sdio_sync_free_txpg(rtwdev);
+		dedicated = rtw_sdio_8723bs_free_txpg(rtwdev, queue);
+		pages_free = dedicated + atomic_read(&rtwsdio->free_pg_pub);
+	} else if (rtw_chip_wcpu_8051(rtwdev)) {
+		u32 free_txpg = rtw_sdio_read32(rtwdev, REG_SDIO_FREE_TXPG);
 
 		switch (queue) {
 		case RTW_TX_QUEUE_BCN:
 		case RTW_TX_QUEUE_H2C:
 		case RTW_TX_QUEUE_HI0:
 		case RTW_TX_QUEUE_MGMT:
-			/* high */
 			pages_free = free_txpg & 0xff;
 			break;
 		case RTW_TX_QUEUE_VI:
 		case RTW_TX_QUEUE_VO:
-			/* normal */
 			pages_free = (free_txpg >> 8) & 0xff;
 			break;
 		case RTW_TX_QUEUE_BE:
 		case RTW_TX_QUEUE_BK:
-			/* low */
 			pages_free = (free_txpg >> 16) & 0xff;
 			break;
 		default:
-			rtw_warn(rtwdev, "Unknown mapping for queue %u\n", queue);
 			return -EINVAL;
 		}
-
-		/* add the pages from the public queue */
 		pages_free += (free_txpg >> 24) & 0xff;
 	} else {
 		u32 free_txpg[3];
@@ -632,44 +720,137 @@ static int rtw_sdio_check_free_txpg(struct rtw_dev *rtwdev, u8 queue,
 	return 0;
 }
 
+static int rtw_sdio_wait_tx_oqt(struct rtw_dev *rtwdev)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	int i;
+	u8 free;
+
+	if (!rtw_is_8723bs_sdio(rtwdev))
+		return 0;
+
+	if (atomic_add_unless(&rtwsdio->tx_oqt_free, -1, 0))
+		return 0;
+
+	for (i = 0; i < RTW_SDIO_OQT_TIMEOUT_MS; i++) {
+		free = rtw_read8(rtwdev, REG_SDIO_OQT_FREE_PG);
+		if (free) {
+			atomic_set(&rtwsdio->tx_oqt_free, free - 1);
+			return 0;
+		}
+		usleep_range(1000, 2000);
+	}
+
+	return -EBUSY;
+}
+
+static void rtw_sdio_8723bs_consume_txpg(struct rtw_dev *rtwdev, u8 queue,
+					 unsigned int pages)
+{
+	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	atomic_t *dedicated;
+	int free;
+
+	switch (queue) {
+	case RTW_TX_QUEUE_VI:
+		dedicated = &rtwsdio->free_pg_normal;
+		break;
+	case RTW_TX_QUEUE_BE:
+	case RTW_TX_QUEUE_BK:
+		dedicated = &rtwsdio->free_pg_low;
+		break;
+	default:
+		dedicated = &rtwsdio->free_pg_high;
+		break;
+	}
+
+	free = atomic_read(dedicated);
+	if (pages <= free) {
+		atomic_sub(pages, dedicated);
+	} else {
+		atomic_set(dedicated, 0);
+		atomic_sub(pages - free, &rtwsdio->free_pg_pub);
+	}
+}
+
+static struct rtw_sdio_tx_data *rtw_sdio_get_tx_data(struct sk_buff *skb);
+
 static int rtw_sdio_write_port(struct rtw_dev *rtwdev, struct sk_buff *skb,
 			       enum rtw_tx_queue_type queue)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
+	struct rtw_sdio_tx_data *tx_data = rtw_sdio_get_tx_data(skb);
+	unsigned int orig_len = skb->len;
+	bool rtl8723bs = rtw_is_8723bs_sdio(rtwdev);
+	bool quiet = rtl8723bs && tx_data->is_mgmt;
+	unsigned int pages;
 	bool bus_claim;
 	size_t txsize;
+	size_t write_size;
 	u32 txaddr;
 	int ret;
 
-	txaddr = rtw_sdio_get_tx_addr(rtwdev, skb->len, queue);
-	if (!txaddr)
-		return -EINVAL;
+	if (rtl8723bs) {
+		txsize = round_up(orig_len, 4);
+		write_size = txsize > RTW_SDIO_BLOCK_SIZE ?
+			     round_up(txsize, RTW_SDIO_BLOCK_SIZE) : txsize;
+	} else {
+		txsize = sdio_align_size(rtwsdio->sdio_func, orig_len);
+		write_size = txsize;
+	}
 
-	txsize = sdio_align_size(rtwsdio->sdio_func, skb->len);
+	if (write_size > orig_len) {
+		unsigned int padding = write_size - orig_len;
+
+		if (skb_tailroom(skb) < padding) {
+			ret = pskb_expand_head(skb, 0,
+					       padding - skb_tailroom(skb),
+					       GFP_KERNEL);
+			if (ret)
+				return ret;
+		}
+		skb_put_zero(skb, padding);
+	}
+
+	txaddr = rtw_sdio_get_tx_addr(rtwdev, txsize, queue);
+	if (!txaddr) {
+		ret = -EINVAL;
+		goto out_trim;
+	}
 
 	ret = rtw_sdio_check_free_txpg(rtwdev, queue, txsize);
 	if (ret)
-		return ret;
+		goto out_trim;
+	ret = rtw_sdio_wait_tx_oqt(rtwdev);
+	if (ret)
+		goto out_trim;
 
 	if (!IS_ALIGNED((unsigned long)skb->data, RTW_SDIO_DATA_PTR_ALIGN))
 		rtw_warn(rtwdev, "Got unaligned SKB in %s() for queue %u\n",
 			 __func__, queue);
 
 	bus_claim = rtw_sdio_bus_claim_needed(rtwsdio);
-
 	if (bus_claim)
 		sdio_claim_host(rtwsdio->sdio_func);
-
-	ret = sdio_memcpy_toio(rtwsdio->sdio_func, txaddr, skb->data, txsize);
-
+	ret = sdio_memcpy_toio(rtwsdio->sdio_func, txaddr, skb->data,
+			       write_size);
 	if (bus_claim)
 		sdio_release_host(rtwsdio->sdio_func);
 
+	if (!ret && quiet)
+		usleep_range(1000, 2000);
+	if (!ret && rtl8723bs) {
+		pages = DIV_ROUND_UP(txsize, rtwdev->chip->page_size);
+		rtw_sdio_8723bs_consume_txpg(rtwdev, queue, pages);
+	}
 	if (ret)
 		rtw_warn(rtwdev,
 			 "Failed to write %zu byte(s) to SDIO port 0x%08x",
-			 txsize, txaddr);
+			 write_size, txaddr);
 
+out_trim:
+	if (write_size > orig_len)
+		skb_trim(skb, orig_len);
 	return ret;
 }
 
@@ -677,7 +858,11 @@ static void rtw_sdio_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 
-	rtwsdio->irq_mask = REG_SDIO_HIMR_RX_REQUEST | REG_SDIO_HIMR_CPWM1;
+	if (rtw_is_8723bs_sdio(rtwdev))
+		rtwsdio->irq_mask = REG_SDIO_HIMR_RX_REQUEST;
+	else
+		rtwsdio->irq_mask = REG_SDIO_HIMR_RX_REQUEST |
+				       REG_SDIO_HIMR_CPWM1;
 }
 
 static void rtw_sdio_enable_rx_aggregation(struct rtw_dev *rtwdev)
@@ -685,6 +870,7 @@ static void rtw_sdio_enable_rx_aggregation(struct rtw_dev *rtwdev)
 	u8 size, timeout;
 
 	switch (rtwdev->chip->id) {
+	case RTW_CHIP_TYPE_8723B:
 	case RTW_CHIP_TYPE_8703B:
 	case RTW_CHIP_TYPE_8821A:
 	case RTW_CHIP_TYPE_8812A:
@@ -712,6 +898,8 @@ static void rtw_sdio_enable_rx_aggregation(struct rtw_dev *rtwdev)
 		    FIELD_PREP(BIT_DMA_AGG_TO_V1, timeout));
 
 	rtw_write8_set(rtwdev, REG_RXDMA_MODE, BIT_DMA_MODE);
+	if (rtw_is_8723bs_sdio(rtwdev))
+		rtw_write8_set(rtwdev, REG_RXDMA_MODE, 3 << 2);
 }
 
 static void rtw_sdio_enable_interrupt(struct rtw_dev *rtwdev)
@@ -749,9 +937,50 @@ static int rtw_sdio_setup(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static void rtw_sdio_8723bs_check_rqpn(struct rtw_dev *rtwdev)
+{
+	const struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
+	const struct rtw_page_table *pg_tbl;
+	u32 free_txpg;
+	u16 pubq_num;
+
+	if (!rtw_is_8723bs_sdio(rtwdev))
+		return;
+
+	free_txpg = rtw_read32(rtwdev, REG_SDIO_FREE_TXPG);
+	if (free_txpg || !fifo->acq_pg_num)
+		return;
+
+	pg_tbl = &chip->page_table[0];
+	if (fifo->acq_pg_num <= pg_tbl->hq_num + pg_tbl->lq_num +
+				    pg_tbl->nq_num + pg_tbl->exq_num +
+				    pg_tbl->gapq_num)
+		return;
+
+	pubq_num = fifo->acq_pg_num - pg_tbl->hq_num - pg_tbl->lq_num -
+		   pg_tbl->nq_num - pg_tbl->exq_num - pg_tbl->gapq_num;
+	rtw_write32(rtwdev, REG_RQPN_NPQ,
+		    BIT_RQPN_NE(pg_tbl->nq_num, pg_tbl->exq_num));
+	rtw_write32(rtwdev, REG_RQPN,
+		    BIT_RQPN_HLP(pg_tbl->hq_num, pg_tbl->lq_num, pubq_num));
+}
+
 static int rtw_sdio_start(struct rtw_dev *rtwdev)
 {
+	u32 clear;
+
+	rtw_sdio_8723bs_check_rqpn(rtwdev);
+	rtw_sdio_init_free_txpg(rtwdev);
 	rtw_sdio_enable_rx_aggregation(rtwdev);
+
+	if (rtw_is_8723bs_sdio(rtwdev)) {
+		clear = rtw_read32(rtwdev, REG_SDIO_HISR) &
+			RTW_SDIO_HISR_CLEAR_MASK;
+		if (clear)
+			rtw_write32(rtwdev, REG_SDIO_HISR, clear);
+	}
+
 	rtw_sdio_enable_interrupt(rtwdev);
 
 	return 0;
@@ -831,6 +1060,8 @@ static void rtw_sdio_interface_cfg(struct rtw_dev *rtwdev)
 
 	val = rtw_read32(rtwdev, REG_SDIO_TX_CTRL);
 	val &= 0xfff8;
+	if (rtw_is_8723bs_sdio(rtwdev))
+		val |= BIT_SDIO_TX_CTRL_ALWAYS_RECOGNIZE;
 	rtw_write32(rtwdev, REG_SDIO_TX_CTRL, val);
 }
 
@@ -844,42 +1075,82 @@ static struct rtw_sdio_tx_data *rtw_sdio_get_tx_data(struct sk_buff *skb)
 	return (struct rtw_sdio_tx_data *)info->status.status_driver_data;
 }
 
-static void rtw_sdio_tx_skb_prepare(struct rtw_dev *rtwdev,
-				    struct rtw_tx_pkt_info *pkt_info,
-				    struct sk_buff *skb,
-				    enum rtw_tx_queue_type queue)
+static int rtw_sdio_align_tx_skb(struct sk_buff *skb, unsigned int headroom)
+{
+	unsigned int misalign, needed;
+	int ret;
+
+	misalign = (unsigned long)skb->data & (RTW_SDIO_DATA_PTR_ALIGN - 1);
+	if (!misalign)
+		return 0;
+
+	needed = headroom + RTW_SDIO_DATA_PTR_ALIGN - 1;
+	if (skb_headroom(skb) < needed) {
+		ret = pskb_expand_head(skb, needed - skb_headroom(skb), 0,
+				       GFP_KERNEL);
+		if (ret)
+			return ret;
+
+		misalign = (unsigned long)skb->data &
+			   (RTW_SDIO_DATA_PTR_ALIGN - 1);
+		if (!misalign)
+			return 0;
+	}
+
+	needed = headroom + misalign;
+	if (skb_headroom(skb) < needed)
+		return -ENOSPC;
+
+	skb_push(skb, misalign);
+	memmove(skb->data, skb->data + misalign, skb->len - misalign);
+	skb_trim(skb, skb->len - misalign);
+
+	return 0;
+}
+
+static int rtw_sdio_tx_skb_prepare(struct rtw_dev *rtwdev,
+				   struct rtw_tx_pkt_info *pkt_info,
+				   struct sk_buff *skb,
+				   enum rtw_tx_queue_type queue)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	unsigned long data_addr, aligned_addr;
+	bool fixed_8723bs_offset;
 	size_t offset;
 	u8 *pkt_desc;
+	int ret;
+
+	fixed_8723bs_offset = rtw_is_8723bs_sdio(rtwdev) &&
+			      (queue == RTW_TX_QUEUE_MGMT ||
+			       queue == RTW_TX_QUEUE_BCN);
+
+	if (fixed_8723bs_offset) {
+		ret = rtw_sdio_align_tx_skb(skb, chip->tx_pkt_desc_sz);
+		if (ret)
+			return ret;
+	}
 
 	pkt_desc = skb_push(skb, chip->tx_pkt_desc_sz);
 
 	data_addr = (unsigned long)pkt_desc;
 	aligned_addr = ALIGN(data_addr, RTW_SDIO_DATA_PTR_ALIGN);
 
-	if (data_addr != aligned_addr) {
+	if (!fixed_8723bs_offset && data_addr != aligned_addr) {
 		/* Ensure that the start of the pkt_desc is always aligned at
 		 * RTW_SDIO_DATA_PTR_ALIGN.
 		 */
 		offset = RTW_SDIO_DATA_PTR_ALIGN - (aligned_addr - data_addr);
-
 		pkt_desc = skb_push(skb, offset);
-
-		/* By inserting padding to align the start of the pkt_desc we
-		 * need to inform the firmware that the actual data starts at
-		 * a different offset than normal.
-		 */
 		pkt_info->offset += offset;
+		memset(pkt_desc + chip->tx_pkt_desc_sz, 0, offset);
 	}
 
 	memset(pkt_desc, 0, chip->tx_pkt_desc_sz);
-
 	pkt_info->qsel = rtw_sdio_get_tx_qsel(rtwdev, skb, queue);
-
 	rtw_tx_fill_tx_desc(rtwdev, pkt_info, skb);
 	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, pkt_desc);
+
+	return 0;
 }
 
 static int rtw_sdio_write_data(struct rtw_dev *rtwdev,
@@ -889,9 +1160,10 @@ static int rtw_sdio_write_data(struct rtw_dev *rtwdev,
 {
 	int ret;
 
-	rtw_sdio_tx_skb_prepare(rtwdev, pkt_info, skb, queue);
-
-	ret = rtw_sdio_write_port(rtwdev, skb, queue);
+	memset(rtw_sdio_get_tx_data(skb), 0, sizeof(struct rtw_sdio_tx_data));
+	ret = rtw_sdio_tx_skb_prepare(rtwdev, pkt_info, skb, queue);
+	if (!ret)
+		ret = rtw_sdio_write_port(rtwdev, skb, queue);
 	dev_kfree_skb_any(skb);
 
 	return ret;
@@ -929,14 +1201,37 @@ static int rtw_sdio_tx_write(struct rtw_dev *rtwdev,
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	enum rtw_tx_queue_type queue = rtw_tx_queue_mapping(skb);
 	struct rtw_sdio_tx_data *tx_data;
-
-	rtw_sdio_tx_skb_prepare(rtwdev, pkt_info, skb, queue);
+	int ret;
 
 	tx_data = rtw_sdio_get_tx_data(skb);
+	memset(tx_data, 0, sizeof(*tx_data));
+	if (skb->len >= sizeof(struct ieee80211_hdr_3addr)) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+		tx_data->is_mgmt = ieee80211_is_mgmt(hdr->frame_control);
+	}
+
+	ret = rtw_sdio_tx_skb_prepare(rtwdev, pkt_info, skb, queue);
+	if (ret)
+		return ret;
+
 	tx_data->sn = pkt_info->sn;
+	tx_data->tx_pkt_offset = pkt_info->offset;
 
 	skb_queue_tail(&rtwsdio->tx_queue[queue], skb);
 
+	/* Back-pressure on the data ACs (BK/BE/VI/VO): once the FIFO fills past
+	 * the high watermark, stop the corresponding mac80211 queue so it stops
+	 * handing us frames, bounding the queueing latency. Resumed from the TX
+	 * drain path once the FIFO drains below the low watermark.
+	 */
+	if (rtw_is_8723bs_sdio(rtwdev) && queue < RTW_TX_QUEUE_BCN &&
+	    !rtwsdio->queue_stopped[queue] &&
+	    skb_queue_len(&rtwsdio->tx_queue[queue]) >= RTW_SDIO_TX_FIFO_HIWATER) {
+		rtwsdio->queue_stopped[queue] = true;
+		ieee80211_stop_queue(rtwdev->hw, skb_get_queue_mapping(skb));
+	}
+
 	return 0;
 }
 
@@ -965,6 +1260,11 @@ static void rtw_sdio_rx_skb(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	rtw_update_rx_freq_for_invalid(rtwdev, skb, rx_status, pkt_stat);
 	rtw_rx_stats(rtwdev, pkt_stat->vif, skb);
 
+	if (skb->len >= sizeof(struct ieee80211_hdr_3addr))
+		rtw8723bs_auth_sync_rx(rtwdev,
+				       (struct ieee80211_hdr *)skb->data,
+				       skb->len, pkt_stat, rx_status);
+
 	ieee80211_rx_irqsafe(rtwdev->hw, skb);
 }
 
@@ -1079,15 +1379,14 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 	struct ieee80211_hw *hw = sdio_get_drvdata(sdio_func);
 	struct rtw_sdio *rtwsdio;
 	struct rtw_dev *rtwdev;
+	u32 clear;
 	u32 hisr;
 
 	rtwdev = hw->priv;
 	rtwsdio = (struct rtw_sdio *)rtwdev->priv;
-
 	rtwsdio->irq_thread = current;
 
 	hisr = rtw_read32(rtwdev, REG_SDIO_HISR);
-
 	if (hisr & REG_SDIO_HISR_TXERR)
 		rtw_sdio_tx_err_isr(rtwdev);
 	if (hisr & REG_SDIO_HISR_RX_REQUEST) {
@@ -1095,7 +1394,12 @@ static void rtw_sdio_handle_interrupt(struct sdio_func *sdio_func)
 		rtw_sdio_rx_isr(rtwdev);
 	}
 
-	rtw_write32(rtwdev, REG_SDIO_HISR, hisr);
+	if (rtw_is_8723bs_sdio(rtwdev))
+		clear = hisr & rtwsdio->irq_mask & RTW_SDIO_HISR_CLEAR_MASK;
+	else
+		clear = hisr & RTW_SDIO_HISR_CLEAR_MASK;
+	if (clear)
+		rtw_write32(rtwdev, REG_SDIO_HISR, clear);
 
 	rtwsdio->irq_thread = NULL;
 }
@@ -1212,11 +1516,20 @@ static void rtw_sdio_indicate_tx_status(struct rtw_dev *rtwdev,
 	struct rtw_sdio_tx_data *tx_data = rtw_sdio_get_tx_data(skb);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hw *hw = rtwdev->hw;
-
-	skb_pull(skb, rtwdev->chip->tx_pkt_desc_sz);
-
-	/* enqueue to wait for tx report */
-	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS) {
+	u8 tx_pkt_offset = tx_data->tx_pkt_offset;
+
+	if (!tx_pkt_offset)
+		tx_pkt_offset = rtwdev->chip->tx_pkt_desc_sz;
+	skb_pull(skb, tx_pkt_offset);
+
+	/* The RTL8723BS vendor descriptor uses SW_DEFINE/sn=0 for management
+	 * frames, so there is no unique key for matching asynchronous C2H TX
+	 * reports. Report completion at SDIO DMA completion, as the vendor
+	 * dump_mgntframe_and_wait() path does; data frames keep the normal C2H
+	 * report queue.
+	 */
+	if (info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS &&
+	    !(rtw_is_8723bs_sdio(rtwdev) && tx_data->is_mgmt)) {
 		rtw_tx_report_enqueue(rtwdev, skb, tx_data->sn);
 		return;
 	}
@@ -1231,24 +1544,38 @@ static void rtw_sdio_indicate_tx_status(struct rtw_dev *rtwdev,
 	ieee80211_tx_status_irqsafe(hw, skb);
 }
 
-static void rtw_sdio_process_tx_queue(struct rtw_dev *rtwdev,
-				      enum rtw_tx_queue_type queue)
+static int rtw_sdio_process_tx_queue(struct rtw_dev *rtwdev,
+				     enum rtw_tx_queue_type queue,
+				     bool *processed)
 {
 	struct rtw_sdio *rtwsdio = (struct rtw_sdio *)rtwdev->priv;
 	struct sk_buff *skb;
+	u16 q_map;
 	int ret;
 
+	*processed = false;
 	skb = skb_dequeue(&rtwsdio->tx_queue[queue]);
 	if (!skb)
-		return;
+		return 0;
 
+	*processed = true;
+	q_map = skb_get_queue_mapping(skb);
 	ret = rtw_sdio_write_port(rtwdev, skb, queue);
 	if (ret) {
 		skb_queue_head(&rtwsdio->tx_queue[queue], skb);
-		return;
+		return ret;
 	}
 
 	rtw_sdio_indicate_tx_status(rtwdev, skb);
+
+	if (rtw_is_8723bs_sdio(rtwdev) && queue < RTW_TX_QUEUE_BCN &&
+	    rtwsdio->queue_stopped[queue] &&
+	    skb_queue_len(&rtwsdio->tx_queue[queue]) <= RTW_SDIO_TX_FIFO_LOWATER) {
+		rtwsdio->queue_stopped[queue] = false;
+		ieee80211_wake_queue(rtwdev->hw, q_map);
+	}
+
+	return 0;
 }
 
 static void rtw_sdio_tx_handler(struct work_struct *work)
@@ -1257,6 +1584,7 @@ static void rtw_sdio_tx_handler(struct work_struct *work)
 		container_of(work, struct rtw_sdio_work_data, work);
 	struct rtw_sdio *rtwsdio;
 	struct rtw_dev *rtwdev;
+	bool processed;
 	int limit, queue;
 
 	rtwdev = work_data->rtwdev;
@@ -1267,7 +1595,14 @@ static void rtw_sdio_tx_handler(struct work_struct *work)
 
 	for (queue = RTK_MAX_TX_QUEUE_NUM - 1; queue >= 0; queue--) {
 		for (limit = 0; limit < 1000; limit++) {
-			rtw_sdio_process_tx_queue(rtwdev, queue);
+			if (rtw_sdio_process_tx_queue(rtwdev, queue, &processed))
+				break;
+
+			if (rtw_is_8723bs_sdio(rtwdev) &&
+			    queue == RTW_TX_QUEUE_MGMT && processed) {
+				queue_work(rtwsdio->txwq, &work_data->work);
+				return;
+			}
 
 			if (skb_queue_empty(&rtwsdio->tx_queue[queue]))
 				break;
@@ -1294,8 +1629,10 @@ static int rtw_sdio_init_tx(struct rtw_dev *rtwdev)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < RTK_MAX_TX_QUEUE_NUM; i++)
+	for (i = 0; i < RTK_MAX_TX_QUEUE_NUM; i++) {
 		skb_queue_head_init(&rtwsdio->tx_queue[i]);
+		rtwsdio->queue_stopped[i] = false;
+	}
 	rtwsdio->tx_handler_data = kmalloc_obj(*rtwsdio->tx_handler_data);
 	if (!rtwsdio->tx_handler_data)
 		goto err_destroy_wq;
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.h b/drivers/net/wireless/realtek/rtw88/sdio.h
index 457e8b02380e..00f28ecfaf7d 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.h
+++ b/drivers/net/wireless/realtek/rtw88/sdio.h
@@ -22,6 +22,7 @@
 
 /* SDIO Tx Control */
 #define REG_SDIO_TX_CTRL			(SDIO_LOCAL_OFFSET + 0x0000)
+#define BIT_SDIO_TX_CTRL_ALWAYS_RECOGNIZE	BIT(4)
 
 /*SDIO status timeout*/
 #define REG_SDIO_TIMEOUT			(SDIO_LOCAL_OFFSET + 0x0002)
@@ -77,6 +78,14 @@
 /* the following two are RTL8188 SDIO Specific */
 #define REG_SDIO_HISR_MCU_ERR			BIT(28)
 #define REG_SDIO_HISR_TSF_BIT32_TOGGLE		BIT(29)
+#define RTW_SDIO_HISR_CLEAR_MASK		\
+	(REG_SDIO_HISR_TXERR | REG_SDIO_HISR_RXERR | \
+	 REG_SDIO_HISR_TXFOVW | REG_SDIO_HISR_RXFOVW | \
+	 REG_SDIO_HISR_TXBCNOK | REG_SDIO_HISR_TXBCNERR | \
+	 REG_SDIO_HISR_C2HCMD | REG_SDIO_HISR_CPWM1 | \
+	 REG_SDIO_HISR_CPWM2 | REG_SDIO_HISR_HSISR_IND | \
+	 REG_SDIO_HISR_GTINT3_IND | REG_SDIO_HISR_GTINT4_IND | \
+	 REG_SDIO_HISR_PSTIMEOUT | REG_SDIO_HISR_OCPINT)
 
 /* HCI Current Power Mode */
 #define REG_SDIO_HCPWM				(SDIO_LOCAL_OFFSET + 0x0019)
@@ -140,6 +149,8 @@ struct sdio_device_id;
 
 struct rtw_sdio_tx_data {
 	u8 sn;
+	u8 tx_pkt_offset;
+	bool is_mgmt;
 };
 
 struct rtw_sdio_work_data {
@@ -159,6 +170,13 @@ struct rtw_sdio {
 	struct workqueue_struct *txwq;
 	struct rtw_sdio_work_data *tx_handler_data;
 	struct sk_buff_head tx_queue[RTK_MAX_TX_QUEUE_NUM];
+	bool queue_stopped[RTK_MAX_TX_QUEUE_NUM];
+
+	atomic_t free_pg_high;
+	atomic_t free_pg_normal;
+	atomic_t free_pg_low;
+	atomic_t free_pg_pub;
+	atomic_t tx_oqt_free;
 };
 
 extern const struct dev_pm_ops rtw_sdio_pm_ops;
-- 
2.55.0


