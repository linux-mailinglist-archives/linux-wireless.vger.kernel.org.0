Return-Path: <linux-wireless+bounces-10588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B22393E918
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 21:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E3B281671
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jul 2024 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE7664C6;
	Sun, 28 Jul 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak5cV043"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782F8C06
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722195883; cv=none; b=f+KfxidUc7ha/PgmgdUXa9rhaF42VlxHys3dhwkhqcZEJry3JKOxafaSWZMbLRzT2fLAiofcgTMQKiodSjaOip4XcIKhBn8RjajbB1VCU0/yZ6L2X79y4YpX3P+CzePLi/+WkD3uM9U0KyLAZdpnELD3w72nwbhxZgpc/Fd4Rr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722195883; c=relaxed/simple;
	bh=5NwSAFfOvYVZqJz+3m0prpxcrJb+ZXQmcYlQ3CsrucE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OuFIchKznkAqug8nIYaDGjfYfFPJ9fdXYMP9c+CLKxfII1viac1q8s3iUd9Ttoghf1OKgc2t0udjjevdVyQSnu3ydGrzNPIG9K29bi9N8QtRobT1e7fNfpG62lvV/hiK4HunrVk74xinOvhicSwOyYhLNvAUtaK1gX8dQ0nI2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak5cV043; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aada2358fso536950366b.0
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jul 2024 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722195879; x=1722800679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7xcrHU0Szu9UHcNAjXMt+V1H9/ISPInQp2II3fpdd0=;
        b=ak5cV043+8FDSVSbvLP+Zj2ZVFCfD277LtsVnypnGqsrIyfGIOyECdKYaTCbvvmeeU
         izqctn18r5sCOOQmXxFO78H7GDBBDsifoB8jUtbGxZ5lG6ar4I1DtHiMo8yXnGv6X5ze
         uVGOiwUWSMKq3Rcizk7tvlHC5QuG9hzX94IvPLnRaYzWktTbnQhWt4nZscBFkFcjWSKI
         50r8dL/bM8Ti0Ck5HkLEwD9izt1YoLNKI3umnrW/qFiy/DGNlQCDKZp/iBcDErkQlloS
         IOCGR6E+lu4D029VGHFzCisxac3HVLg/En14szeHe9b8MTKhbXGWSy55y0xa6rXDbJnu
         RXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722195879; x=1722800679;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7xcrHU0Szu9UHcNAjXMt+V1H9/ISPInQp2II3fpdd0=;
        b=DzAYSThrj/HGs3Le3RkI/WvLeFakRnwkfuo//07vsbV2OFkcFXsIueeoAAwJ9Vrj4y
         02+cPpptzAgfJnCxGxl4Pto5mPoLsvGxpv7PfeuZPpdM+4rPozs/x1kS7P/lr2BXwnA7
         TEzRTbT6PHy6j/jBpGe0jBoetRxsy3ogLwiuJCUcIJR4moGjU+zHGM9XLdi0kYSDYyiO
         dq2SRPCqLpvDhRqWMMoSot+I462AISdfLaUASk43XZiJYROA4edCZqxOB676vOqKrmfJ
         gYOamTETgpR+51Za3sPz/vWZp+icnRF4tSXxRgX5kAWAm3Rww8s9A9KkXeD3NbEK40JB
         EjtA==
X-Gm-Message-State: AOJu0YzP67tIj0yLnHtT9tTwf7OPXYBXVCt5U1zFu6M00dt2KBMMpplZ
	PBRb7Dif4QjQyrLUL7MkrG8HI9rg2zk5hyvrzNTLTO1CO0kbeDsQzihEsA==
X-Google-Smtp-Source: AGHT+IEBOZq5bZRtAsktyesNPhkabQ299a/Hy0SzCAgyPVWb3A9UOaM/WhmFZKTUQWuCwYpevRq9bQ==
X-Received: by 2002:a17:907:72d1:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a7d3fa3f215mr487886266b.22.1722195878974;
        Sun, 28 Jul 2024 12:44:38 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aca51eea0sm420098766b.0.2024.07.28.12.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 12:44:38 -0700 (PDT)
Message-ID: <323190ee-5b88-4d37-bad0-b721cdfead1a@gmail.com>
Date: Sun, 28 Jul 2024 22:44:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 4/4] wifi: rtw88: Enable USB RX aggregation for
 8822c/8822b/8821c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
Content-Language: en-US
In-Reply-To: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable USB RX aggregation when there is at least 1 Mbps RX or TX
traffic, otherwise disable it.

USB RX aggregation improves the RX speed on certain ARM systems, like
the NanoPi NEO Core2. With RTL8811CU, before: 28 Mbps, after: 231 Mbps.

The official drivers for these chips use the same logic for SDIO, but
for some reason rtw88_sdio always enables RX aggregation, so this patch
only toggles aggregation for USB devices.

RTL8703B is likely not found in USB devices, and RTL8723DU doesn't like
aggregation.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 18 +++++++++++----
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 23 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 23 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 23 +++++++++++++++++++
 5 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 9d9d33a4a503..b3a089b4f707 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -210,8 +210,10 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
 					      watch_dog_work.work);
 	struct rtw_traffic_stats *stats = &rtwdev->stats;
+	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_watch_dog_iter_data data = {};
 	bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+	u32 tx_unicast_shift, rx_unicast_shift;
 	bool ps_active;
 
 	mutex_lock(&rtwdev->mutex);
@@ -236,13 +238,21 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	else
 		ps_active = false;
 
-	ewma_tp_add(&stats->tx_ewma_tp,
-		    (u32)(stats->tx_unicast >> RTW_TP_SHIFT));
-	ewma_tp_add(&stats->rx_ewma_tp,
-		    (u32)(stats->rx_unicast >> RTW_TP_SHIFT));
+	tx_unicast_shift = stats->tx_unicast >> RTW_TP_SHIFT;
+	rx_unicast_shift = stats->rx_unicast >> RTW_TP_SHIFT;
+
+	ewma_tp_add(&stats->tx_ewma_tp, tx_unicast_shift);
+	ewma_tp_add(&stats->rx_ewma_tp, rx_unicast_shift);
 	stats->tx_throughput = ewma_tp_read(&stats->tx_ewma_tp);
 	stats->rx_throughput = ewma_tp_read(&stats->rx_ewma_tp);
 
+	if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_USB && chip->ops->rx_aggregation) {
+		if (tx_unicast_shift < 1 && rx_unicast_shift < 1)
+			chip->ops->rx_aggregation(rtwdev, false);
+		else
+			chip->ops->rx_aggregation(rtwdev, true);
+	}
+
 	/* reset tx/rx statictics */
 	stats->tx_unicast = 0;
 	stats->rx_unicast = 0;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9d21637cf5d5..65bedd1668cc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -888,6 +888,7 @@ struct rtw_chip_ops {
 	void (*fill_txdesc_checksum)(struct rtw_dev *rtwdev,
 				     struct rtw_tx_pkt_info *pkt_info,
 				     u8 *txdesc);
+	void (*rx_aggregation)(struct rtw_dev *rtwdev, bool enable);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 55b6fe874710..3efdb41f22c5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1276,6 +1276,28 @@ static void rtw8821c_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 	fill_txdesc_checksum_common(txdesc, 16);
 }
 
+static void rtw8821c_rx_aggregation(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 size, timeout;
+	u16 val16;
+
+	rtw_write32_set(rtwdev, REG_RXDMA_AGG_PG_TH, BIT_EN_PRE_CALC);
+	rtw_write8_set(rtwdev, REG_TXDMA_PQ_MAP, BIT_RXDMA_AGG_EN);
+	rtw_write8_clr(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
+
+	if (enable) {
+		size = 0x5;
+		timeout = 0x20;
+	} else {
+		size = 0x0;
+		timeout = 0x1;
+	}
+	val16 = u16_encode_bits(size, BIT_RXDMA_AGG_PG_TH) |
+		u16_encode_bits(timeout, BIT_DMA_AGG_TO_V1);
+
+	rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -1724,6 +1746,7 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
 	.fill_txdesc_checksum	= rtw8821c_fill_txdesc_checksum,
+	.rx_aggregation		= rtw8821c_rx_aggregation,
 
 	.coex_set_init		= rtw8821c_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8821c_coex_cfg_ant_switch,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 0949eaa2b6c1..52bcdf3cf043 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1638,6 +1638,28 @@ static void rtw8822b_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 	fill_txdesc_checksum_common(txdesc, words);
 }
 
+static void rtw8822b_rx_aggregation(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 size, timeout;
+	u16 val16;
+
+	rtw_write32_set(rtwdev, REG_RXDMA_AGG_PG_TH, BIT_EN_PRE_CALC);
+	rtw_write8_set(rtwdev, REG_TXDMA_PQ_MAP, BIT_RXDMA_AGG_EN);
+	rtw_write8_clr(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
+
+	if (enable) {
+		size = 0x5;
+		timeout = 0x20;
+	} else {
+		size = 0x0;
+		timeout = 0x1;
+	}
+	val16 = u16_encode_bits(size, BIT_RXDMA_AGG_PG_TH) |
+		u16_encode_bits(timeout, BIT_DMA_AGG_TO_V1);
+
+	rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
+}
+
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -2214,6 +2236,7 @@ static struct rtw_chip_ops rtw8822b_ops = {
 	.adaptivity_init	= rtw8822b_adaptivity_init,
 	.adaptivity		= rtw8822b_adaptivity,
 	.fill_txdesc_checksum	= rtw8822b_fill_txdesc_checksum,
+	.rx_aggregation		= rtw8822b_rx_aggregation,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8822b_coex_cfg_ant_switch,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 2a90a879196b..9d3ed8992133 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4612,6 +4612,28 @@ static void rtw8822c_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 	fill_txdesc_checksum_common(txdesc, words);
 }
 
+static void rtw8822c_rx_aggregation(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 size, timeout;
+	u16 val16;
+
+	rtw_write32_set(rtwdev, REG_RXDMA_AGG_PG_TH, BIT_EN_PRE_CALC);
+	rtw_write8_set(rtwdev, REG_TXDMA_PQ_MAP, BIT_RXDMA_AGG_EN);
+	rtw_write8_clr(rtwdev, REG_RXDMA_AGG_PG_TH + 3, BIT(7));
+
+	if (enable) {
+		size = 0x5;
+		timeout = 0x20;
+	} else {
+		size = 0x0;
+		timeout = 0x1;
+	}
+	val16 = u16_encode_bits(size, BIT_RXDMA_AGG_PG_TH) |
+		u16_encode_bits(timeout, BIT_DMA_AGG_TO_V1);
+
+	rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
+}
+
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -5036,6 +5058,7 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.config_tx_path		= rtw8822c_config_tx_path,
 	.config_txrx_mode	= rtw8822c_config_trx_mode,
 	.fill_txdesc_checksum	= rtw8822c_fill_txdesc_checksum,
+	.rx_aggregation		= rtw8822c_rx_aggregation,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
-- 
2.45.2


