Return-Path: <linux-wireless+bounces-11109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1390894B2FB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 00:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F91DB23466
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F51146A7A;
	Wed,  7 Aug 2024 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfpmWvWZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6315099D
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069393; cv=none; b=COme60OfMjPm+HGN+dZiPCdBSDxPOoKuS0ipr1q8nJQ0kRKexJsyLVd6SaJLvzwDKSXUe8uHtlKdrTCS8PrAbDVdBGvgkA2SdOjXJ+/f+8AtiPy8hFOv1pFNJPxS5c/Q7Zg5nrgsmLYJ0KnkpguyoDDlYhjXukLUzlJH3LssMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069393; c=relaxed/simple;
	bh=Fh2RWqtm56i2+WTBmqxIWRaSapcjKz+iBHActXmf41U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nflKRZEU7MfDHbQnkRZmo2gVPIxebvYosEGueg9ab9TVYeIYqBaAUMVy5akBJwOMBlhcHMj04mT32Pb8xH1Big5+krWIqDZNYi14CHPoFkscVjhW5YXP7uKNYubnRDx+Jq44+GC5fRBaXO17NhxUnzLnrvaXsvmut4rG6damwQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfpmWvWZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a61386so406065a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723069390; x=1723674190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ytRZqsYwgFuubJAxDI8mrUYLn6wZINR1ay3r2NNyESs=;
        b=NfpmWvWZaTFb55YgGSmPUvoYf+a8PbWxOllM2T8pKNuJiZ8zcRNbaSUnrZBBpqlFYQ
         0V/nOv7Fc+O9l98RkZSt8bATVg1KDIvOmw0HaanHpdDq6p7YIpZy7pnFCcWWwPjMWsbm
         ra1vNVWN/FrcvxtjFOIs8++hB1G3yY5TfgaC8t5PPjkXYN79TsSdx5/CrdrFdr6woWbE
         kLpByO7Txy+LoKOGdWtVfzwuaBGN/ZLDWyYtI1XH69UnSyqIpma+RePPRVwQUDvM/YjL
         HQ35bfL9rEXYvkw3ip9a/Q7rt8NgO76z+QeE2lY/4xqRdy7DiznISCR8AnYujNGLB5qs
         3N1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069390; x=1723674190;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytRZqsYwgFuubJAxDI8mrUYLn6wZINR1ay3r2NNyESs=;
        b=R4+S738u39ASkkn7WhVXLwtgxFTMc7rWUQL7sfkrdWJ+wV20xWMa+g77G02NN5zZSC
         yW9apn30goJwBk33Ye89GQ4CRILzM03mfAQuhf0o+hSObZ36nPCC3OoDLcTgwm+PZBqS
         DNTLryn0aLEpiSllLbVbF4dtblSxjXzG8CT32Qk2t1maEdk2gLPcvV2A4cjKyEZdN/wi
         k3unbtb2QGmIcGEfRQAEsNjWS7xqcaFp5l+vcAr1PjRyrAxGqaEed7bOTVGJMKckor4N
         +J5T3e8o96lX8rJVc/D6WBB6BkqlsLak91RSIDS4Vy3cqM51P7KgT6ITNeBMKfBR3O5n
         EYZg==
X-Gm-Message-State: AOJu0YxkJI6WmJDBiq5pkJF8CmMRfBVmjtXrnN1bJyKnd3x7a28rUoG3
	OUuiD38zLGlJSBBENK4NTcpcOz/DXQ1vafMRR9m9gGkC9JJLW3Ehs9dWhQ==
X-Google-Smtp-Source: AGHT+IF4Zn5ELFIEzLixsjq6/D2djQGVL5iJIVepasoalTv4XUYHdfLR+6sgPz8686FSbc3d7SvDAA==
X-Received: by 2002:a05:6402:5208:b0:5b8:f69b:65e8 with SMTP id 4fb4d7f45d1cf-5bbb1fa30cemr110579a12.0.1723069390001;
        Wed, 07 Aug 2024 15:23:10 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d3473dsm1305a12.63.2024.08.07.15.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 15:23:09 -0700 (PDT)
Message-ID: <b4c0d54c-6755-4b0f-9dd7-f9196fd74b68@gmail.com>
Date: Thu, 8 Aug 2024 01:23:06 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 4/4] wifi: rtw88: Enable USB RX aggregation for
 8822c/8822b/8821c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
Content-Language: en-US
In-Reply-To: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable USB RX aggregation when there is at least 1 Mbps RX or TX
traffic, otherwise disable it.

USB RX aggregation improves the RX speed of RTL8811CU on certain ARM
systems, like the NanoPi NEO Core2. Before: 28 Mbps, after: 231 Mbps.

It also improves the RX speed of RTL8822CU on some x86_64 systems.
Before: ~200 Mbps, after: ~300 Mbps.

The official drivers for these chips use the same logic for SDIO, but
for some reason the SDIO driver in rtw88 always enables RX aggregation,
so this patch only toggles aggregation for USB devices.

RTL8703B is likely not found in USB devices, and RTL8723DU doesn't like
aggregation.

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Move call to rtw_hci_dynamic_rx_agg() after call to
   rtw_phy_dynamic_mechanism().
 - Mention the effect on RTL8822CU.

v3:
 - Add Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

v2:
 - Rename {tx,rx}_unicast_shift to {tx,rx}_unicast_mbps.
 - Move the RX aggregation code from rtw8822c.c, rtw8822b.c, rtw8821c.c
   to usb.c.
 - Delete the rx_aggregation member from struct rtw_chip_ops and add
   dynamic_rx_agg member to struct rtw_hci_ops.
 - Rebase on top of the latest rtw-next.
---
 drivers/net/wireless/realtek/rtw88/hci.h  |  7 ++++
 drivers/net/wireless/realtek/rtw88/main.c | 13 +++++---
 drivers/net/wireless/realtek/rtw88/pci.c  |  1 +
 drivers/net/wireless/realtek/rtw88/sdio.c |  1 +
 drivers/net/wireless/realtek/rtw88/usb.c  | 40 +++++++++++++++++++++++
 5 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/hci.h b/drivers/net/wireless/realtek/rtw88/hci.h
index 830d7532f2a3..96aeda26014e 100644
--- a/drivers/net/wireless/realtek/rtw88/hci.h
+++ b/drivers/net/wireless/realtek/rtw88/hci.h
@@ -18,6 +18,7 @@ struct rtw_hci_ops {
 	void (*deep_ps)(struct rtw_dev *rtwdev, bool enter);
 	void (*link_ps)(struct rtw_dev *rtwdev, bool enter);
 	void (*interface_cfg)(struct rtw_dev *rtwdev);
+	void (*dynamic_rx_agg)(struct rtw_dev *rtwdev, bool enable);
 
 	int (*write_data_rsvd_page)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
 	int (*write_data_h2c)(struct rtw_dev *rtwdev, u8 *buf, u32 size);
@@ -72,6 +73,12 @@ static inline void rtw_hci_interface_cfg(struct rtw_dev *rtwdev)
 	rtwdev->hci.ops->interface_cfg(rtwdev);
 }
 
+static inline void rtw_hci_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
+{
+	if (rtwdev->hci.ops->dynamic_rx_agg)
+		rtwdev->hci.ops->dynamic_rx_agg(rtwdev, enable);
+}
+
 static inline int
 rtw_hci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 9c58b7a41b95..b0c9b0ff7017 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -212,6 +212,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	struct rtw_traffic_stats *stats = &rtwdev->stats;
 	struct rtw_watch_dog_iter_data data = {};
 	bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+	u32 tx_unicast_mbps, rx_unicast_mbps;
 	bool ps_active;
 
 	mutex_lock(&rtwdev->mutex);
@@ -236,10 +237,11 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	else
 		ps_active = false;
 
-	ewma_tp_add(&stats->tx_ewma_tp,
-		    (u32)(stats->tx_unicast >> RTW_TP_SHIFT));
-	ewma_tp_add(&stats->rx_ewma_tp,
-		    (u32)(stats->rx_unicast >> RTW_TP_SHIFT));
+	tx_unicast_mbps = stats->tx_unicast >> RTW_TP_SHIFT;
+	rx_unicast_mbps = stats->rx_unicast >> RTW_TP_SHIFT;
+
+	ewma_tp_add(&stats->tx_ewma_tp, tx_unicast_mbps);
+	ewma_tp_add(&stats->rx_ewma_tp, rx_unicast_mbps);
 	stats->tx_throughput = ewma_tp_read(&stats->tx_ewma_tp);
 	stats->rx_throughput = ewma_tp_read(&stats->rx_ewma_tp);
 
@@ -259,6 +261,9 @@ static void rtw_watch_dog_work(struct work_struct *work)
 
 	rtw_phy_dynamic_mechanism(rtwdev);
 
+	rtw_hci_dynamic_rx_agg(rtwdev,
+			       tx_unicast_mbps >= 1 || rx_unicast_mbps >= 1);
+
 	data.rtwdev = rtwdev;
 	/* rtw_iterate_vifs internally uses an atomic iterator which is needed
 	 * to avoid taking local->iflist_mtx mutex
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 5d0580da13fb..0b9b8807af2c 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1601,6 +1601,7 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.deep_ps = rtw_pci_deep_ps,
 	.link_ps = rtw_pci_link_ps,
 	.interface_cfg = rtw_pci_interface_cfg,
+	.dynamic_rx_agg = NULL,
 
 	.read8 = rtw_pci_read8,
 	.read16 = rtw_pci_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 763aa8212a4b..21d0754dd7f6 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -1157,6 +1157,7 @@ static struct rtw_hci_ops rtw_sdio_ops = {
 	.deep_ps = rtw_sdio_deep_ps,
 	.link_ps = rtw_sdio_link_ps,
 	.interface_cfg = rtw_sdio_interface_cfg,
+	.dynamic_rx_agg = NULL,
 
 	.read8 = rtw_sdio_read8,
 	.read16 = rtw_sdio_read16,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 64d68366812c..e83ab6fb83f5 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -766,6 +766,45 @@ static void rtw_usb_interface_cfg(struct rtw_dev *rtwdev)
 	rtw_usb_init_burst_pkt_len(rtwdev);
 }
 
+static void rtw_usb_dynamic_rx_agg_v1(struct rtw_dev *rtwdev, bool enable)
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
+static void rtw_usb_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
+{
+	switch (rtwdev->chip->id) {
+	case RTW_CHIP_TYPE_8822C:
+	case RTW_CHIP_TYPE_8822B:
+	case RTW_CHIP_TYPE_8821C:
+		rtw_usb_dynamic_rx_agg_v1(rtwdev, enable);
+		break;
+	case RTW_CHIP_TYPE_8723D:
+		/* Doesn't like aggregation. */
+		break;
+	case RTW_CHIP_TYPE_8703B:
+		/* Likely not found in USB devices. */
+		break;
+	}
+}
+
 static struct rtw_hci_ops rtw_usb_ops = {
 	.tx_write = rtw_usb_tx_write,
 	.tx_kick_off = rtw_usb_tx_kick_off,
@@ -775,6 +814,7 @@ static struct rtw_hci_ops rtw_usb_ops = {
 	.deep_ps = rtw_usb_deep_ps,
 	.link_ps = rtw_usb_link_ps,
 	.interface_cfg = rtw_usb_interface_cfg,
+	.dynamic_rx_agg = rtw_usb_dynamic_rx_agg,
 
 	.write8  = rtw_usb_write8,
 	.write16 = rtw_usb_write16,
-- 
2.45.2


