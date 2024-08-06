Return-Path: <linux-wireless+bounces-11041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E54B949713
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8EF282810
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8B74E26;
	Tue,  6 Aug 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH2w2BoO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688F762EF
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966461; cv=none; b=sodDgwd+slpt5OcKBMp3OduKQGUhGkPuqCy6CrAgQNFbMesjVSX7O0Y+QvafJSikWUX5KnwlChj3xRKoLz//qTpgyiGm0NZXmSuDMcvJzlmM5oftzh17vR1x6TymG+2qE2OJeDqU8FPk9DdfqFjgD1npB7jQkultkRrjkckHLvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966461; c=relaxed/simple;
	bh=F1Xqqw5H1d6LJpgWNtIHaaR0eHJG4G3BgRkpUgm5ypk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GuQAr7EEA6Ke6Z6+MjzGQMWGUNdvX+yDqKI6xsvpifXzqoRsJGWU4p2bHDwlZLJhOcAoGi+IEpfUTzl+7NiQzMc3Spa1UwZ5A93XENiPHNYQxpAuHWEzOzxrosWU8Yab+a/XFdrbEzeu1mLrCNimyUkAkUlehAe4QWqY7K7Frl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH2w2BoO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7ad02501c3so92533866b.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722966458; x=1723571258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iD5zmmU44/dH61DO+JJYxKDQxPxwOjlmbQ3tJbwIFf0=;
        b=JH2w2BoOIhM7GWrPVPhnIXkBgJUQFKEu+PP+whgp5BUmeDgZuf50Q8ytZwYyPT17b+
         UOTFDMpn/vXSBl+WknxFaxaCLdrzCNqPD+w31fGMPyjnFmwcLqZWeBr1xmIs43Ad2Hn8
         cf51kOs/2rzd7BITz2kw3gXkzLZhr5TSGeG/o0AXA01I9SWqYAWcT0yNMh2fJT2S4xpX
         uwDm7XZ+tPO04uTdQTXwnAJoe2q4YFxwXZksKwvXXxjtMx560s6uzxo35FCEcDlnkz5o
         JgqjwpM+9gP+kAQwM7+rks9+nbv2HAb9R55lukBrv8PFaRlvDCGI+pOFEwT2wZABYpWa
         pdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966458; x=1723571258;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iD5zmmU44/dH61DO+JJYxKDQxPxwOjlmbQ3tJbwIFf0=;
        b=HCaXngh7K25HnZhLqcfOZxFXvixjlOWGE1HMI9kGq1ywK5HqZtPTtzSdkb74nnT1As
         l/uByQsgZCtYCs9cd4PRzCOEowBI4ce3NDbYEMRjsVZIKzvFuVNzjMjirDWFVt4PxS/R
         RQqvBuKmf1+krk1hPY+DyNMuz8b9/1mEToSYcjDY8YDdsATdaXWp/bNN93lGIKsfBmgf
         OCJVUpPRklcKUCxL1oU2VeCQQ3qR2x6RSIe3qFTmZnoy97HKR5T/Yht8R8Z9HVk7Wfky
         4ckFhbmI4xxh6YjsPvuQSUelbw+dUMvL/Gfpvlsflzn9jdiNZlEIgp5/5hHPPTQhSq2T
         NuuA==
X-Gm-Message-State: AOJu0YySO+FXbgKXgEeWhqLA8w3pS2zMFafd2Wekn2nMA1f8CcCstKZ1
	7uHWy8kfW5Wu/ovK0QXMPLbRUPFSWmJjfxVWldlSnZJP6bdh4RlPZsoXtg==
X-Google-Smtp-Source: AGHT+IEYpN2N7OrZdWozvLORzvd0sl5GL3UY+uCvT2P30MrZHfNn1LvQWLrUbN4wXamfUwUZMwVt5Q==
X-Received: by 2002:a17:906:c115:b0:a7d:9f92:9107 with SMTP id a640c23a62f3a-a7dc51bdf6cmr1051189966b.58.1722966457550;
        Tue, 06 Aug 2024 10:47:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0b6casm564509766b.51.2024.08.06.10.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:47:37 -0700 (PDT)
Message-ID: <3b7b3655-9ec5-4277-b0ff-5535b1fdf281@gmail.com>
Date: Tue, 6 Aug 2024 20:47:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 4/4] wifi: rtw88: Enable USB RX aggregation for
 8822c/8822b/8821c
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
References: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
Content-Language: en-US
In-Reply-To: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Enable USB RX aggregation when there is at least 1 Mbps RX or TX
traffic, otherwise disable it.

USB RX aggregation improves the RX speed on certain ARM systems, like
the NanoPi NEO Core2. With RTL8821CU, before: 28 Mbps, after: 231 Mbps.

The official drivers for these chips use the same logic for SDIO, but
for some reason the SDIO driver in rtw88 always enables RX aggregation,
so this patch only toggles aggregation for USB devices.

RTL8703B is likely not found in USB devices, and RTL8723DU doesn't like
aggregation.

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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
index 9c58b7a41b95..fd944248e6e7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -212,6 +212,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	struct rtw_traffic_stats *stats = &rtwdev->stats;
 	struct rtw_watch_dog_iter_data data = {};
 	bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
+	u32 tx_unicast_mbps, rx_unicast_mbps;
 	bool ps_active;
 
 	mutex_lock(&rtwdev->mutex);
@@ -236,13 +237,17 @@ static void rtw_watch_dog_work(struct work_struct *work)
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
 
+	rtw_hci_dynamic_rx_agg(rtwdev,
+			       tx_unicast_mbps >= 1 || rx_unicast_mbps >= 1);
+
 	/* reset tx/rx statictics */
 	stats->tx_unicast = 0;
 	stats->rx_unicast = 0;
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
index 4c7ba5c76a57..cbb5e17e65d1 100644
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


