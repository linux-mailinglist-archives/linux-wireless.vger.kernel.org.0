Return-Path: <linux-wireless+bounces-14398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A59ACBF3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5A9283EAA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A201A2C27;
	Wed, 23 Oct 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjmZlEbk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DD146018
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692638; cv=none; b=sU3K7WTcKdriIrWMc2r46go9nTBh4xmLaDBKSQRfF1xQz4XvxYcIxBqS+hnY6gX7hHkb0qMLrs3yuF+84AFEM39TYKIT3tikuHLNU08Vhq+90vgyBwW5ozGkZNwTD58e6l3e+36UiPxxkK0CqvTvzhw8iWAzOpua4No88kpqwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692638; c=relaxed/simple;
	bh=bEMeIv+r27O27GHplyaHJa1RItI1VkZu3H/O3dsvvug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QOV2SG9vmsebaisR8/mIzsXYu1b7UQue4WwjG5qgXsiiBTWnIMngj0g7xlB/4NkYrH0EXzzpxjKPfnbaYQ51qDTMhDgwBYHz6vejgsvyzoQh6f3ycWY1Q6VPSSgI8LBtg5ZlA+M4Ms6FyaXaI57GzT6jiDnZprqSZ8tCZZUh2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjmZlEbk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so949425466b.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692635; x=1730297435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ylihSXIJrCe4gMIUzB2+ciEthPB+OOecrstc1Nrsg48=;
        b=bjmZlEbkf1IF9Kh6b0H0/fNhRbUgGR6XlzXOmPXCWIMznpc2hV/9mnhnusRNWGlG17
         zg6fCNs/gPodQ/TSbptzuNZaWsxKPVqu4HgbcrCifImfUcl3NPgrRvqioEpMRgZbjTnR
         I0zfgZ6ALsTR9+mxQM9pFu6mkwjf9DLeMvscOauSEvtWrGmcS1CfQRCYosHQhPRe3MPK
         Gvc3xZQ/1ahwnOZu7ZNtELyHoR8toMpHCYCtfwKoa8zLvLMJF1NTdfQmZFsf0v6hMD3Z
         8v+xvqaPnEcVwWlVgwH+WoBcdlqjal+tut/ErOTP5lz9CnNgsVbauwbkEY8bRuGFzrGk
         T1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692635; x=1730297435;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylihSXIJrCe4gMIUzB2+ciEthPB+OOecrstc1Nrsg48=;
        b=piH8yWMqwV2HjWYQoUMWLtp7PYxKka7DVqIUigSS9W+TjCJXBWxKIaY1TlvXqcTIF6
         3eCpppE6VJBE6m5Y9A37EinLNmjTrsazEyILikybPcL3YfS0BCsEQvPDRgcLA33/YOxC
         4RMrqoWEXe0T8QimhzvKDAAO7cNxxjCS1WbW6NPZ90myL4b1Z0m3blVCeJ3OC0J/6tge
         6W7s0nhkWhhz0RuXlYmvILZbjHjAsZ93Mm8aPpJ7XofJleGf09PbzIdTKMJu/eS/ihUP
         6hgDMVXmpRZcxnfDF4pq57shD246IMNq2lLuIv2UgsczZu+ucgIXUSrwIRNacC8xkO5W
         A5SA==
X-Gm-Message-State: AOJu0YzM4Baqg7BBQWseXCXcNrqqlJnmkFbsCtieyg0HRPZKVekn13kA
	7iZ7ouTW+T7iGoZdfHZ7tjLwtckkKUYlPY1mugGIUalfC63nJPiL45MovA==
X-Google-Smtp-Source: AGHT+IEG/PgLYZle+JKsWsV77wwpv/nY2njdsZ0UYWU2zkT+yvuwgg+q+FufmUIoxlsXRC1cnZSijg==
X-Received: by 2002:a17:907:2ce6:b0:a7a:9f0f:ab18 with SMTP id a640c23a62f3a-a9abf87fb38mr265444866b.20.1729692634429;
        Wed, 23 Oct 2024 07:10:34 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ab1d92eb4sm215989066b.48.2024.10.23.07.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:10:34 -0700 (PDT)
Message-ID: <2b3e3e6f-541b-4a3b-8ca3-65b267e6a95a@gmail.com>
Date: Wed, 23 Oct 2024 17:10:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 07/22] wifi: rtw88: Enable data rate fallback for older
 chips
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
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
v2:
 - Initialise old_datarate_fb_limit for every chip.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 2 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/pci.c      | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 drivers/net/wireless/realtek/rtw88/sdio.c     | 2 +-
 drivers/net/wireless/realtek/rtw88/tx.c       | 6 +++++-
 drivers/net/wireless/realtek/rtw88/tx.h       | 4 +++-
 drivers/net/wireless/realtek/rtw88/usb.c      | 4 ++--
 12 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 168e19187ba7..19de5ba555a9 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1290,7 +1290,7 @@ static void rtw_fill_rsvd_page_desc(struct rtw_dev *rtwdev, struct sk_buff *skb,
 	rtw_tx_rsvd_page_pkt_info_update(rtwdev, &pkt_info, skb, type);
 	pkt_desc = skb_push(skb, chip->tx_pkt_desc_sz);
 	memset(pkt_desc, 0, chip->tx_pkt_desc_sz);
-	rtw_tx_fill_tx_desc(&pkt_info, skb);
+	rtw_tx_fill_tx_desc(rtwdev, &pkt_info, skb);
 }
 
 static inline u8 rtw_len_to_page(unsigned int len, u8 page_size)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index af4876327837..64bc43cdd209 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1204,6 +1204,7 @@ struct rtw_chip_info {
 	u8 usb_tx_agg_desc_num;
 	bool hw_feature_report;
 	u8 c2h_ra_report_size;
+	bool old_datarate_fb_limit;
 
 	u8 default_1ss_tx_path;
 
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index f71e41d6f97c..0ecaefc4c83d 100644
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
index 97dbc77f037a..f6f6635b46e1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1964,6 +1964,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
+	.old_datarate_fb_limit = true,
 
 	.path_div_supported = false,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index f6a08b06f853..a0bf37a58632 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2135,6 +2135,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.usb_tx_agg_desc_num = 1,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
+	.old_datarate_fb_limit = true,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index e17d0193ca6f..39dc8244f744 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1972,6 +1972,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
+	.old_datarate_fb_limit = false,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 7360ce0a193e..419eb14c5467 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2513,6 +2513,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
+	.old_datarate_fb_limit = false,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 17d4d9bddd83..56085f220fcd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5333,6 +5333,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
 	.c2h_ra_report_size = 7,
+	.old_datarate_fb_limit = false,
 	.default_1ss_tx_path = BB_PATH_A,
 	.path_div_supported = true,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index f0b06ed8f76d..799230eb5f16 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -864,7 +864,7 @@ static void rtw_sdio_tx_skb_prepare(struct rtw_dev *rtwdev,
 
 	pkt_info->qsel = rtw_sdio_get_tx_qsel(rtwdev, skb, queue);
 
-	rtw_tx_fill_tx_desc(pkt_info, skb);
+	rtw_tx_fill_tx_desc(rtwdev, pkt_info, skb);
 	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, pkt_desc);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index dae7ca148865..6ed470dd6f22 100644
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
@@ -67,6 +68,9 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 
 	tx_desc->w4 = le32_encode_bits(pkt_info->rate, RTW_TX_DESC_W4_DATARATE);
 
+	if (rtwdev->chip->old_datarate_fb_limit)
+		tx_desc->w4 |= le32_encode_bits(0x1f, RTW_TX_DESC_W4_DATARATE_FB_LIMIT);
+
 	tx_desc->w5 = le32_encode_bits(pkt_info->short_gi, RTW_TX_DESC_W5_DATA_SHORT) |
 		      le32_encode_bits(pkt_info->bw, RTW_TX_DESC_W5_DATA_BW) |
 		      le32_encode_bits(pkt_info->ldpc, RTW_TX_DESC_W5_DATA_LDPC) |
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 3d544fd7f60f..d34cdeca16f1 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -44,6 +44,7 @@ struct rtw_tx_desc {
 #define RTW_TX_DESC_W3_NAVUSEHDR BIT(15)
 #define RTW_TX_DESC_W3_MAX_AGG_NUM GENMASK(21, 17)
 #define RTW_TX_DESC_W4_DATARATE GENMASK(6, 0)
+#define RTW_TX_DESC_W4_DATARATE_FB_LIMIT GENMASK(12, 8)
 #define RTW_TX_DESC_W4_RTSRATE GENMASK(28, 24)
 #define RTW_TX_DESC_W5_DATA_SHORT BIT(4)
 #define RTW_TX_DESC_W5_DATA_BW GENMASK(6, 5)
@@ -94,7 +95,8 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
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
index ba314d90ab3f..a3d2b40ec67b 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -458,7 +458,7 @@ static int rtw_usb_write_data(struct rtw_dev *rtwdev,
 	skb_put_data(skb, buf, size);
 	skb_push(skb, chip->tx_pkt_desc_sz);
 	memset(skb->data, 0, chip->tx_pkt_desc_sz);
-	rtw_tx_fill_tx_desc(pkt_info, skb);
+	rtw_tx_fill_tx_desc(rtwdev, pkt_info, skb);
 	rtw_tx_fill_txdesc_checksum(rtwdev, pkt_info, skb->data);
 
 	ret = rtw_usb_write_port(rtwdev, qsel, skb,
@@ -525,7 +525,7 @@ static int rtw_usb_tx_write(struct rtw_dev *rtwdev,
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


