Return-Path: <linux-wireless+bounces-11278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4094E32B
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 22:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9601F20F5C
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 20:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B8014885B;
	Sun, 11 Aug 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhYMPz4w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F979F4
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 20:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409949; cv=none; b=uWzMGq45MAynMS25kSDB5t2OblgXlVfl2MGbJPCbuzCUhHTU0siTythJTt155wVsUmNhRUHrl7OXOAF0L/gcKX85QlHQbM+9HYfQ+R/16k2TwA6DU9wXKbqMHdTq4IJqYWsJOzWTE1/FNFxDnxWzW3wx+34TcbTNdSrfyuaERus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409949; c=relaxed/simple;
	bh=2dG7EwsgX4817eo2ABOiZxO5p/EJUh33LsFiu3OcL4w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bTeLoOOSs1vDc8QnEubnPtJg60GzDfQbVWbT/TIY9UjHJJxL/5mXjyV8k8Redgg3FA2CuNCsnv0cn7FUwK4MVJ9psgOea4V8Iugca+zuP+05gAA33k+to0GQwvle6BSb3nkgjFZU+xDgrx+SB3hMep1dGn6bJ1OYcU4kSCR7fe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhYMPz4w; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso3619189a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723409946; x=1724014746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VxoP5jqOrmEukqxZ8mZcQnnsSwanjDTB7CimugclTws=;
        b=NhYMPz4wksUpY/E0nwAD7YEW8ptqopHtSzh65QrHDEcyWPZJubIIu2LEhvRx/rfJ9N
         uQN9Bw0FeV6WEnNj8OxWyVI6tLmyvHJWr5guQmG4UbUjNSiBn6jUuidXEEvSloLM62qC
         TawA51N8ynfJGk+4qwkeHmbjGlTbnWvhdJptZAPyaE7PGCNyMz8YiQnidiGOsMBF0Lfq
         hp5cdtiYsqVL9yh1GaFfDAs51hmF+GLMRCuHp/KUdBA7ax6lbSHoN/pGweY4mlYL9Q0S
         oxCRBWJ2/CuYFtpXkAzaROqOqns2FEwFVhO6PryFjN64F+M1tIwmpAUkf0VIf43CC5nY
         x+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723409946; x=1724014746;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VxoP5jqOrmEukqxZ8mZcQnnsSwanjDTB7CimugclTws=;
        b=QrjWBw0z9tDwr9smGGv3BPG5ohcawWrdZvx67BYePNaAgT515gxXEe50NuY752muqm
         pFnIYNbzjIyjgWCMhvAeaeUVgNH4c5TZJksqIYMeZTYGiwFgTsdUpOv+jWq/rKysNTZk
         jximiSVSlGcowVezj5e1mP6PU/GtI3ftp+rMSQl8AcRIMzc4R+AqsYMAxq2qdmhz5a9U
         bhA0xxJlWaQSA03D8wZsOMoBZZmrW2HdtkuDzWIcGadalFcoRw7/hMjaYxrAOvQ5ZM91
         6nk+nXYJSWXjj8dRsVJ+EwUG8vI6j/BS31USuFiMFHF788rtB9UyFTficUNYHYiM31Mm
         xWsg==
X-Gm-Message-State: AOJu0YzuU8D3NbaaeIkRHD5vHQaFlrjT7HTmp2JuDUHKeyRZue5kHNPT
	Mbn/NcbkOhtwEbsEw+pHiY8poGHwyo8V0pzn5P7y41EkYtj7DPX6kbtUpw==
X-Google-Smtp-Source: AGHT+IGNOvHJDZ8JSgh/oRa05gYj4U6mkrRHrgrBoDvtiKQa5lz2V0ctrkdAbQO3Vb7M+sTKS4ekgA==
X-Received: by 2002:a05:6402:40d2:b0:5ba:cb82:a776 with SMTP id 4fb4d7f45d1cf-5bd0a535cefmr5612619a12.9.1723409946046;
        Sun, 11 Aug 2024 13:59:06 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e07a9sm1580910a12.78.2024.08.11.13.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 13:59:05 -0700 (PDT)
Message-ID: <7a45d3c5-ada6-41ca-be67-44cce5c28045@gmail.com>
Date: Sun, 11 Aug 2024 23:59:04 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 07/20] wifi: rtw88: Enable data rate fallback for older chips
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8811AU fails to perform the 4-way handshake when the AP is too far
because it transmits the EAPOL frames at MCS9 and when that doesn't
work it retries 48 times with the same rate, to no avail.

Retrying 48 times with the same rate seems pointless. Set the
appropriate field in the TX descriptor to allow it to use lower rates
when retrying.

Set it for RTL8723D and RTL8703B because they interpret this field the
same way as RTL8811A.

The newer RTL8822C, RTL8822B, RTL8821C seem to interpret this field in
the TX descriptor differently, so leave it alone for those chips.

Tested with RTL8811AU and RTL8723DU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 2 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/pci.c      | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/sdio.c     | 2 +-
 drivers/net/wireless/realtek/rtw88/tx.c       | 6 +++++-
 drivers/net/wireless/realtek/rtw88/tx.h       | 4 +++-
 drivers/net/wireless/realtek/rtw88/usb.c      | 4 ++--
 9 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index ac53e3e30af0..69ebddf69dbb 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1285,7 +1285,7 @@ static void rtw_fill_rsvd_page_desc(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	rtw_tx_rsvd_page_pkt_info_update(rtwdev, &pkt_info, skb, type);
 	pkt_desc = skb_push(skb, chip->tx_pkt_desc_sz);
 	memset(pkt_desc, 0, chip->tx_pkt_desc_sz);
-	rtw_tx_fill_tx_desc(&pkt_info, skb);
+	rtw_tx_fill_tx_desc(rtwdev, &pkt_info, skb);
 }
 
 static inline u8 rtw_len_to_page(unsigned int len, u8 page_size)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 49af0daa5e67..0cd37c3da3c3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1206,6 +1206,7 @@ struct rtw_chip_info {
 	u8 usb_tx_agg_desc_num;
 	bool hw_feature_report;
 	u8 c2h_ra_report_size;
+	bool old_datarate_fb_limit;
 
 	u8 default_1ss_tx_path;
 
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 0b9b8807af2c..ecc2b3d29035 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -824,7 +824,7 @@ static int rtw_pci_tx_write_data(struct rtw_dev *rtwdev,
 	pkt_desc = skb_push(skb, chip->tx_pkt_desc_sz);
 	memset(pkt_desc, 0, tx_pkt_desc_sz);
 	pkt_info->qsel = rtw_pci_get_tx_qsel(skb, queue);
-	rtw_tx_fill_tx_desc(pkt_info, skb);
+	rtw_tx_fill_tx_desc(rtwdev, pkt_info, skb);
 	dma = dma_map_single(&rtwpci->pdev->dev, skb->data, skb->len,
 			     DMA_TO_DEVICE);
 	if (dma_mapping_error(&rtwpci->pdev->dev, dma))
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index c2af095af5a9..ffd9857348a3 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -2018,6 +2018,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
+	.old_datarate_fb_limit = true,
 
 	.path_div_supported = false,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 44fbf53c0c2b..e31570c7b01c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2176,6 +2176,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.usb_tx_agg_desc_num = 1,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
+	.old_datarate_fb_limit = true,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 21d0754dd7f6..26321a072df7 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -864,7 +864,7 @@ static void rtw_sdio_tx_skb_prepare(struct rtw_dev *rtwdev,
 
 	pkt_info->qsel = rtw_sdio_get_tx_qsel(rtwdev, skb, queue);
 
-	rtw_tx_fill_tx_desc(pkt_info, skb);
+	rtw_tx_fill_tx_desc(rtwdev, pkt_info, skb);
 	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, pkt_desc);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index c02ac673be32..42f4e5141fe7 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -32,7 +32,8 @@ void rtw_tx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	}
 }
 
-void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
+void rtw_tx_fill_tx_desc(struct rtw_dev *rtwdev,
+			 struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 {
 	struct rtw_tx_desc *tx_desc = (struct rtw_tx_desc *)skb->data;
 	bool more_data = false;
@@ -66,6 +67,9 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 
 	tx_desc->w4 = le32_encode_bits(pkt_info->rate, RTW_TX_DESC_W4_DATARATE);
 
+	if (rtwdev->chip->old_datarate_fb_limit)
+		tx_desc->w4 |= le32_encode_bits(0x1f, RTW_TX_DESC_W4_DATARATE_FB_LIMIT);
+
 	tx_desc->w5 = le32_encode_bits(pkt_info->short_gi, RTW_TX_DESC_W5_DATA_SHORT) |
 		      le32_encode_bits(pkt_info->bw, RTW_TX_DESC_W5_DATA_BW) |
 		      le32_encode_bits(pkt_info->ldpc, RTW_TX_DESC_W5_DATA_LDPC) |
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 324189606257..056d3d7ded0a 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -43,6 +43,7 @@ struct rtw_tx_desc {
 #define RTW_TX_DESC_W3_NAVUSEHDR BIT(15)
 #define RTW_TX_DESC_W3_MAX_AGG_NUM GENMASK(21, 17)
 #define RTW_TX_DESC_W4_DATARATE GENMASK(6, 0)
+#define RTW_TX_DESC_W4_DATARATE_FB_LIMIT GENMASK(12, 8)
 #define RTW_TX_DESC_W4_RTSRATE GENMASK(28, 24)
 #define RTW_TX_DESC_W5_DATA_SHORT BIT(4)
 #define RTW_TX_DESC_W5_DATA_BW GENMASK(6, 5)
@@ -93,7 +94,8 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 			    struct rtw_tx_pkt_info *pkt_info,
 			    struct ieee80211_sta *sta,
 			    struct sk_buff *skb);
-void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb);
+void rtw_tx_fill_tx_desc(struct rtw_dev *rtwdev,
+			 struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb);
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn);
 void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src);
 void rtw_tx_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index e83ab6fb83f5..05aa8ffe7d8f 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -457,7 +457,7 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
 	skb_put_data(skb, buf, size);
 	skb_push(skb, chip->tx_pkt_desc_sz);
 	memset(skb->data, 0, chip->tx_pkt_desc_sz);
-	rtw_tx_fill_tx_desc(pkt_info, skb);
+	rtw_tx_fill_tx_desc(rtwdev, pkt_info, skb);
 	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, skb->data);
 
 	ret = rtw_usb_write_port(rtwdev, qsel, skb,
@@ -524,7 +524,7 @@ static int rtw_usb_tx_write(struct rtw_dev *rtwdev,
 	pkt_desc = skb_push(skb, chip->tx_pkt_desc_sz);
 	memset(pkt_desc, 0, chip->tx_pkt_desc_sz);
 	ep = qsel_to_ep(rtwusb, pkt_info->qsel);
-	rtw_tx_fill_tx_desc(pkt_info, skb);
+	rtw_tx_fill_tx_desc(rtwdev, pkt_info, skb);
 	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, skb->data);
 	tx_data = rtw_usb_get_tx_data(skb);
 	tx_data->sn = pkt_info->sn;
-- 
2.46.0


