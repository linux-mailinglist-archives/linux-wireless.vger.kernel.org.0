Return-Path: <linux-wireless+bounces-13907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4351F99ADB3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F231828241F
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2231CFECE;
	Fri, 11 Oct 2024 20:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5Zqy/5n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86E5199231
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679779; cv=none; b=sXImku6KZ1frAAB4WSzcuaqQOJcqI+E1wle6ashJbl/YnNsSY9C3eC6ljDZGD4by8rtEk/IB2jqKIUePD6gVCT5S+UPQmLboBhAmIdyT3Zj746+GqEPHS9fC6bI+xwR1udf2wykWom1tvluMV1K0PFpS1TAJh5pfyeftRvUVpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679779; c=relaxed/simple;
	bh=ZR1otjwyQcsAiVDZby/9yS02124ZFbvIW8lo6jkmLv0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=W4HJNu5YNRsHE5XhDg640Tbnh2eoPrroO3t/GrkFEljdXjkxf415bDY5CHOFgzsNJsdspc1D01Fs+jgXMKhkSRGKiDmpD5eaPCYxvWjjRGiq0WPriiTfNABGaAkS9c1h+gEyZkU0ttR2Xe+3ij08KtR7QUoyFHVgS1DRNd7ol4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5Zqy/5n; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so195919e87.3
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679776; x=1729284576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NN7Ak9ORNH/OGUqM97NWUI9Uzxb48T4Fo89ac4YOvfk=;
        b=h5Zqy/5noZ7wLvKkU8ltZCJARoMGzRgYIz+6lVm6d7dOo7Uxu9mcjsoYgnWvy6XdcG
         aR0/3PHwBgU2YPKwuQxzoNzKag42o+8C95h0GKdSvZjKFycWmb9qr6sgfaoH75xLxGck
         EqZKIjAGzYeqfOjCU/ph8C98BTqM8ELdGB81pJvruJXrWcJWeYuvdNeMpXjam1KuN3yw
         pIGE1hbbTOf+AmfjqPTmDLhxe3LBxtFjYkpnH8QsXtKb5XeDw2kDZ7C9ZppnKf5hiJTb
         9sRbiWITpK36P4W64+xD8g+UUIsTZsiiAoj2PbqzfIXb+FhLIWzLZi5jpEJFBNxQDhXk
         wjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679776; x=1729284576;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NN7Ak9ORNH/OGUqM97NWUI9Uzxb48T4Fo89ac4YOvfk=;
        b=HSXPcj2v9xU6WMelVxGECY1dfHvRTsZKcViNQcM+hB+TK0BXzxlnWBcF5DzKj6NwUT
         1mlvAopdwyxYuZlEPbdPhroXiZ1IrrhHuVg3sQkZAKcwQUrUTe3rMws7lHa6pzUpwN8v
         65tOQS5N5mTLOIXW3BOcyG3GyJnJ5gE5K5G8VsKS3V9aR7jRx2T+HHgmgkxBqWYx6PsF
         XSyHFOd0ezzYj4PdnbmRbeOYeRRVsoN9G7JI5RYkgbp3hnfphc+jdVJmzbosDAQOB8NO
         owa4EUVL1/P/E6LJDKIuIVeOr7+L+OoBdG85kUDA+18MQLyqmVgaCQay2Qs/xuhQ2oBz
         cSrQ==
X-Gm-Message-State: AOJu0YzgoMFD3JB/KTeHSOoUpYTvRd81Fq9hq84BKiCEHsKX9AxjXU4a
	FrH48o1DAzEfRtEOwRKOtc+jUmpIBeuDrQtNjU9Bh5RBXgTc1aZBsjGC3w==
X-Google-Smtp-Source: AGHT+IHR0FaJDxaVPLvW6/wAtk3kGQbE3pFNsFBvi/3qYR3/5TT96LLQoDuiLxQUh1tNK/hXVnFcQQ==
X-Received: by 2002:ac2:51c7:0:b0:539:e454:942e with SMTP id 2adb3069b0e04-539e45495c3mr941990e87.16.1728679775504;
        Fri, 11 Oct 2024 13:49:35 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51c69sm82740665e9.28.2024.10.11.13.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:49:35 -0700 (PDT)
Message-ID: <21dbccaf-82e2-48aa-9b11-dc217ca76309@gmail.com>
Date: Fri, 11 Oct 2024 23:49:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 07/22] wifi: rtw88: Enable data rate fallback for older
 chips
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
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


