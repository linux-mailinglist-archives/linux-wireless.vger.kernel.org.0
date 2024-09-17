Return-Path: <linux-wireless+bounces-12927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D586497B5F4
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 00:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84341284B3F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2024 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A7615C144;
	Tue, 17 Sep 2024 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMcdoBlO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D8208D0
	for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726613766; cv=none; b=f5zBbCWuQI8qj1S7qeSPl420eFeCaQBNIMcfpklIcB2PPif1lVazUPLpv/Tp4FJyCWik2oDkJZn+LmPXaHbtrAcVj0u8MMGTWmmnpZnH7oFbvEkN1Lq0H2qmncd95RhgCWGa/MJYqID4CBgrftwTHZo1+vumArkSS6nfdDDsirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726613766; c=relaxed/simple;
	bh=P/Nj+Sq7nlq1i6cIrvMdlnbfaNgrOnLYM8W1XWu8v1E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U1CaFt3L31SQqhfNky7bepiLcnnW3IY6LtA47VgvGG1v0IFfeTWIO58bwD44nZkmCY/8ZRFuaPKOddcx5TFPiRazTnl0G+ZF2G1HAVr/DWNq+HMhnBDcZTnOezbWdWj0iB1vThwxoVqpjh5oi3BgkWczeW555i+OXImvXs9zLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMcdoBlO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83562f9be9so665624066b.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Sep 2024 15:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726613762; x=1727218562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2rHRLbz2t7lLUfpGRLA1tuEuiKYKmEdLJc4JPatCElQ=;
        b=DMcdoBlOCX6ypybtvHiozaWt6jrNq3ebhI7XIeKO2VRNiWm7GtLY5GUqQsTepXCNk/
         nHp2GGZrlmi+qq86iUf81QP7JD0YbzSDtJp46mkUVdhR2IQe5dDu2lVLTjsLP6vrMHY/
         OpCw8tbnDHU2WIVArV56zWgtkSB9/NiS0RtgwSLEUYjQ8ySYxx++Mpp7B3Hf8xwzu612
         V8BHADbyahG1UG6LJmpyh5kVlIeVOscNGuIjtNtgK+unz4p8gLDGHKLqnfNqaniAKdza
         pU0zMuwGaTsiv/ZDc9HIqSe0Cri4HMOvX/R9IQWKMXn9e1zi/JJdRZZ/nNPxqodlnmvf
         qwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726613762; x=1727218562;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rHRLbz2t7lLUfpGRLA1tuEuiKYKmEdLJc4JPatCElQ=;
        b=QpP2fq2s+9c9oyrH0t2sCf3g3qqHjQxaAHJ9KGkXwKEEvH5lXK9J3bi3V8FoL6vbGs
         6z34aSpJQ6pg8eOvqhvA9cNe/hfsBg3pSEGwUYzwbY/B3219qZf+CMWomNmHrakp6+Ao
         H/wrH7xgeWOdSE6GaJ611bQrXoh8dSzesAluUvhaAAsM3vw5EZhFs+OGJ15dCL7WT91J
         paawcoDQ+HUqGVrhx97WJDG8zIj93UK3sSaKM5gG/dr+pWOgpG3MsgFRn5kjCBvCuKLQ
         VSrsJdBJM/OrXCchExyTcgV/OAlTB7ljtkMjNcxiDMoA/Lvg+2HtAYX7CGrCtCwajBb/
         BAiA==
X-Gm-Message-State: AOJu0Yz86PVJLLpbpK+vxhBeaJup647joRHwwaNmUal5ctqh1NxrJpoQ
	28D59EcaO0LPHeuKwyNC+zsuWPqUJBcYJ+ewyD591W8RrF3TLWwJSzEmtw==
X-Google-Smtp-Source: AGHT+IGw48AEJYcfpNU/qguWzK6g7mD8favMAv3It5FOdGhYM8Vi9/YYjXOsRhcKsa681iSN+ImFqw==
X-Received: by 2002:a17:907:e697:b0:a8d:fa3:bb24 with SMTP id a640c23a62f3a-a9029438205mr1752467266b.23.1726613761505;
        Tue, 17 Sep 2024 15:56:01 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df5cfsm509234066b.146.2024.09.17.15.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 15:56:01 -0700 (PDT)
Message-ID: <6efd784f-d07f-42c2-a84f-4beba2db25dc@gmail.com>
Date: Wed, 18 Sep 2024 01:56:00 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtw88: Parse the RX descriptor with a single
 function
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
Content-Language: en-US
In-Reply-To: <dae7994f-3491-40de-b537-ebf68df084bb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

rtw8703b_query_rx_desc(), rtw8723d_query_rx_desc(),
rtw8821c_query_rx_desc(), rtw8822b_query_rx_desc(), and
rtw8822c_query_rx_desc() are almost identical, so replace them all with
a single function, rtw_rx_query_rx_desc().

Also, access the RX descriptor using a struct with __le32 members and
le32_get_bits().

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  5 +-
 drivers/net/wireless/realtek/rtw88/pci.c      |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 53 +-------------
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 43 +-----------
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 43 +-----------
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 43 +-----------
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 44 +-----------
 drivers/net/wireless/realtek/rtw88/rx.c       | 70 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/rx.h       | 64 ++++++++---------
 drivers/net/wireless/realtek/rtw88/sdio.c     |  3 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |  4 +-
 11 files changed, 106 insertions(+), 268 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 83180c488c37..05cfb235f272 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -848,9 +848,8 @@ struct rtw_chip_ops {
 	void (*phy_set_param)(struct rtw_dev *rtwdev);
 	void (*set_channel)(struct rtw_dev *rtwdev, u8 channel,
 			    u8 bandwidth, u8 primary_chan_idx);
-	void (*query_rx_desc)(struct rtw_dev *rtwdev, u8 *rx_desc,
-			      struct rtw_rx_pkt_stat *pkt_stat,
-			      struct ieee80211_rx_status *rx_status);
+	void (*query_phy_status)(struct rtw_dev *rtwdev, u8 *phy_status,
+				 struct rtw_rx_pkt_stat *pkt_stat);
 	u32 (*read_rf)(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 		       u32 addr, u32 mask);
 	bool (*write_rf)(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 0b9b8807af2c..f71e41d6f97c 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1065,7 +1065,7 @@ static u32 rtw_pci_rx_napi(struct rtw_dev *rtwdev, struct rtw_pci *rtwpci,
 		dma_sync_single_for_cpu(rtwdev->dev, dma, RTK_PCI_RX_BUF_SIZE,
 					DMA_FROM_DEVICE);
 		rx_desc = skb->data;
-		chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat, &rx_status);
+		rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat, &rx_status);
 
 		/* offset from rx_desc to payload */
 		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index e3ac748ad646..8949b0696f53 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -1032,57 +1032,6 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 		query_phy_status_ofdm(rtwdev, phy_status, pkt_stat);
 }
 
-static void rtw8703b_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
-				   struct rtw_rx_pkt_stat *pkt_stat,
-				   struct ieee80211_rx_status *rx_status)
-{
-	struct ieee80211_hdr *hdr;
-	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
-	u8 *phy_status = NULL;
-
-	memset(pkt_stat, 0, sizeof(*pkt_stat));
-
-	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
-	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
-	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
-	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
-			      GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
-	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
-	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
-	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
-	pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
-	pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
-	pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
-	pkt_stat->ppdu_cnt = 0;
-	pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
-
-	pkt_stat->drv_info_sz *= RX_DRV_INFO_SZ_UNIT_8703B;
-
-	if (pkt_stat->is_c2h)
-		return;
-
-	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
-				       pkt_stat->drv_info_sz);
-
-	pkt_stat->bw = GET_RX_DESC_BW(rx_desc);
-
-	if (pkt_stat->phy_status) {
-		phy_status = rx_desc + desc_sz + pkt_stat->shift;
-		query_phy_status(rtwdev, phy_status, pkt_stat);
-	}
-
-	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
-
-	/* Rtl8723cs driver checks for size < 14 or size > 8192 and
-	 * simply drops the packet. Maybe this should go into
-	 * rtw_rx_fill_rx_status()?
-	 */
-	if (pkt_stat->pkt_len == 0) {
-		rx_status->flag |= RX_FLAG_NO_PSDU;
-		rtw_dbg(rtwdev, RTW_DBG_RX, "zero length packet");
-	}
-}
-
 #define ADDA_ON_VAL_8703B 0x03c00014
 
 static
@@ -1948,7 +1897,7 @@ static const struct rtw_chip_ops rtw8703b_ops = {
 	.read_efuse		= rtw8703b_read_efuse,
 	.phy_set_param		= rtw8703b_phy_set_param,
 	.set_channel		= rtw8703b_set_channel,
-	.query_rx_desc		= rtw8703b_query_rx_desc,
+	.query_phy_status	= query_phy_status,
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_tx_power_index	= rtw8723x_set_tx_power_index,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 7f33e141e646..86a5e2497641 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -227,47 +227,6 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 	}
 }
 
-static void rtw8723d_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
-				   struct rtw_rx_pkt_stat *pkt_stat,
-				   struct ieee80211_rx_status *rx_status)
-{
-	struct ieee80211_hdr *hdr;
-	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
-	u8 *phy_status = NULL;
-
-	memset(pkt_stat, 0, sizeof(*pkt_stat));
-
-	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
-	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
-	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
-	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
-			      GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
-	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
-	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
-	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
-	pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
-	pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
-	pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
-	pkt_stat->ppdu_cnt = 0;
-	pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
-
-	/* drv_info_sz is in unit of 8-bytes */
-	pkt_stat->drv_info_sz *= 8;
-
-	/* c2h cmd pkt's rx/phy status is not interested */
-	if (pkt_stat->is_c2h)
-		return;
-
-	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
-				       pkt_stat->drv_info_sz);
-	if (pkt_stat->phy_status) {
-		phy_status = rx_desc + desc_sz + pkt_stat->shift;
-		query_phy_status(rtwdev, phy_status, pkt_stat);
-	}
-
-	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
-}
-
 static bool rtw8723d_check_spur_ov_thres(struct rtw_dev *rtwdev,
 					 u8 channel, u32 thres)
 {
@@ -1433,7 +1392,7 @@ static void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
 static const struct rtw_chip_ops rtw8723d_ops = {
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723x_read_efuse,
-	.query_rx_desc		= rtw8723d_query_rx_desc,
+	.query_phy_status	= query_phy_status,
 	.set_channel		= rtw8723d_set_channel,
 	.mac_init		= rtw8723x_mac_init,
 	.shutdown		= rtw8723d_shutdown,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 9d21c4b1450e..66c79956e8e5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -679,47 +679,6 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 	}
 }
 
-static void rtw8821c_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
-				   struct rtw_rx_pkt_stat *pkt_stat,
-				   struct ieee80211_rx_status *rx_status)
-{
-	struct ieee80211_hdr *hdr;
-	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
-	u8 *phy_status = NULL;
-
-	memset(pkt_stat, 0, sizeof(*pkt_stat));
-
-	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
-	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
-	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
-	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
-			      GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
-	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
-	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
-	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
-	pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
-	pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
-	pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
-	pkt_stat->ppdu_cnt = GET_RX_DESC_PPDU_CNT(rx_desc);
-	pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
-
-	/* drv_info_sz is in unit of 8-bytes */
-	pkt_stat->drv_info_sz *= 8;
-
-	/* c2h cmd pkt's rx/phy status is not interested */
-	if (pkt_stat->is_c2h)
-		return;
-
-	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
-				       pkt_stat->drv_info_sz);
-	if (pkt_stat->phy_status) {
-		phy_status = rx_desc + desc_sz + pkt_stat->shift;
-		query_phy_status(rtwdev, phy_status, pkt_stat);
-	}
-
-	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
-}
-
 static void
 rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 {
@@ -1686,7 +1645,7 @@ static const struct rtw_prioq_addrs prioq_addrs_8821c = {
 static const struct rtw_chip_ops rtw8821c_ops = {
 	.phy_set_param		= rtw8821c_phy_set_param,
 	.read_efuse		= rtw8821c_read_efuse,
-	.query_rx_desc		= rtw8821c_query_rx_desc,
+	.query_phy_status	= query_phy_status,
 	.set_channel		= rtw8821c_set_channel,
 	.mac_init		= rtw8821c_mac_init,
 	.read_rf		= rtw_phy_read_rf,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 650585086e8f..24f76a36f23e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -934,47 +934,6 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 	}
 }
 
-static void rtw8822b_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
-				   struct rtw_rx_pkt_stat *pkt_stat,
-				   struct ieee80211_rx_status *rx_status)
-{
-	struct ieee80211_hdr *hdr;
-	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
-	u8 *phy_status = NULL;
-
-	memset(pkt_stat, 0, sizeof(*pkt_stat));
-
-	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
-	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
-	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
-	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
-			      GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
-	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
-	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
-	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
-	pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
-	pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
-	pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
-	pkt_stat->ppdu_cnt = GET_RX_DESC_PPDU_CNT(rx_desc);
-	pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
-
-	/* drv_info_sz is in unit of 8-bytes */
-	pkt_stat->drv_info_sz *= 8;
-
-	/* c2h cmd pkt's rx/phy status is not interested */
-	if (pkt_stat->is_c2h)
-		return;
-
-	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
-				       pkt_stat->drv_info_sz);
-	if (pkt_stat->phy_status) {
-		phy_status = rx_desc + desc_sz + pkt_stat->shift;
-		query_phy_status(rtwdev, phy_status, pkt_stat);
-	}
-
-	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
-}
-
 static void
 rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 {
@@ -2175,7 +2134,7 @@ static const struct rtw_prioq_addrs prioq_addrs_8822b = {
 static const struct rtw_chip_ops rtw8822b_ops = {
 	.phy_set_param		= rtw8822b_phy_set_param,
 	.read_efuse		= rtw8822b_read_efuse,
-	.query_rx_desc		= rtw8822b_query_rx_desc,
+	.query_phy_status	= query_phy_status,
 	.set_channel		= rtw8822b_set_channel,
 	.mac_init		= rtw8822b_mac_init,
 	.read_rf		= rtw_phy_read_rf,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index a5531e663dde..da74e66bda84 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2690,48 +2690,6 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
 	}
 }
 
-static void rtw8822c_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
-				   struct rtw_rx_pkt_stat *pkt_stat,
-				   struct ieee80211_rx_status *rx_status)
-{
-	struct ieee80211_hdr *hdr;
-	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
-	u8 *phy_status = NULL;
-
-	memset(pkt_stat, 0, sizeof(*pkt_stat));
-
-	pkt_stat->phy_status = GET_RX_DESC_PHYST(rx_desc);
-	pkt_stat->icv_err = GET_RX_DESC_ICV_ERR(rx_desc);
-	pkt_stat->crc_err = GET_RX_DESC_CRC32(rx_desc);
-	pkt_stat->decrypted = !GET_RX_DESC_SWDEC(rx_desc) &&
-			      GET_RX_DESC_ENC_TYPE(rx_desc) != RX_DESC_ENC_NONE;
-	pkt_stat->is_c2h = GET_RX_DESC_C2H(rx_desc);
-	pkt_stat->pkt_len = GET_RX_DESC_PKT_LEN(rx_desc);
-	pkt_stat->drv_info_sz = GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
-	pkt_stat->shift = GET_RX_DESC_SHIFT(rx_desc);
-	pkt_stat->rate = GET_RX_DESC_RX_RATE(rx_desc);
-	pkt_stat->cam_id = GET_RX_DESC_MACID(rx_desc);
-	pkt_stat->ppdu_cnt = GET_RX_DESC_PPDU_CNT(rx_desc);
-	pkt_stat->tsf_low = GET_RX_DESC_TSFL(rx_desc);
-
-	/* drv_info_sz is in unit of 8-bytes */
-	pkt_stat->drv_info_sz *= 8;
-
-	/* c2h cmd pkt's rx/phy status is not interested */
-	if (pkt_stat->is_c2h)
-		return;
-
-	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
-				       pkt_stat->drv_info_sz);
-	pkt_stat->hdr = hdr;
-	if (pkt_stat->phy_status) {
-		phy_status = rx_desc + desc_sz + pkt_stat->shift;
-		query_phy_status(rtwdev, phy_status, pkt_stat);
-	}
-
-	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status, phy_status);
-}
-
 static void
 rtw8822c_set_write_tx_power_ref(struct rtw_dev *rtwdev, u8 *tx_pwr_ref_cck,
 				u8 *tx_pwr_ref_ofdm)
@@ -4991,7 +4949,7 @@ static const struct rtw_prioq_addrs prioq_addrs_8822c = {
 static const struct rtw_chip_ops rtw8822c_ops = {
 	.phy_set_param		= rtw8822c_phy_set_param,
 	.read_efuse		= rtw8822c_read_efuse,
-	.query_rx_desc		= rtw8822c_query_rx_desc,
+	.query_phy_status	= query_phy_status,
 	.set_channel		= rtw8822c_set_channel,
 	.mac_init		= rtw8822c_mac_init,
 	.dump_fw_crash		= rtw8822c_dump_fw_crash,
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 66f9419588cf..e5c1177e8a76 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -187,11 +187,10 @@ void rtw_update_rx_freq_from_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(rtw_update_rx_freq_from_ie);
 
-void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
-			   struct rtw_rx_pkt_stat *pkt_stat,
-			   struct ieee80211_hdr *hdr,
-			   struct ieee80211_rx_status *rx_status,
-			   u8 *phy_status)
+static void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
+				  struct rtw_rx_pkt_stat *pkt_stat,
+				  struct ieee80211_hdr *hdr,
+				  struct ieee80211_rx_status *rx_status)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 	u8 path;
@@ -242,5 +241,64 @@ void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 	}
 
 	rtw_rx_addr_match(rtwdev, pkt_stat, hdr);
+
+	/* Rtl8723cs driver checks for size < 14 or size > 8192 and
+	 * simply drops the packet.
+	 */
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8703B && pkt_stat->pkt_len == 0) {
+		rx_status->flag |= RX_FLAG_NO_PSDU;
+		rtw_dbg(rtwdev, RTW_DBG_RX, "zero length packet");
+	}
+}
+
+void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc8,
+			  struct rtw_rx_pkt_stat *pkt_stat,
+			  struct ieee80211_rx_status *rx_status)
+{
+	struct rtw_rx_desc *rx_desc = (struct rtw_rx_desc *)rx_desc8;
+	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
+	struct ieee80211_hdr *hdr;
+	u32 enc_type, swdec;
+	u8 *phy_status;
+
+	memset(pkt_stat, 0, sizeof(*pkt_stat));
+
+	pkt_stat->pkt_len = le32_get_bits(rx_desc->w0, RTW_RX_DESC_W0_PKT_LEN);
+	pkt_stat->crc_err = le32_get_bits(rx_desc->w0, RTW_RX_DESC_W0_CRC32);
+	pkt_stat->icv_err = le32_get_bits(rx_desc->w0, RTW_RX_DESC_W0_ICV_ERR);
+	pkt_stat->drv_info_sz = le32_get_bits(rx_desc->w0,
+					      RTW_RX_DESC_W0_DRV_INFO_SIZE);
+	enc_type = le32_get_bits(rx_desc->w0, RTW_RX_DESC_W0_ENC_TYPE);
+	pkt_stat->shift = le32_get_bits(rx_desc->w0, RTW_RX_DESC_W0_SHIFT);
+	pkt_stat->phy_status = le32_get_bits(rx_desc->w0, RTW_RX_DESC_W0_PHYST);
+	swdec = le32_get_bits(rx_desc->w0, RTW_RX_DESC_W0_SWDEC);
+	pkt_stat->decrypted = !swdec && enc_type != RX_DESC_ENC_NONE;
+
+	pkt_stat->cam_id = le32_get_bits(rx_desc->w1, RTW_RX_DESC_W1_MACID);
+
+	pkt_stat->is_c2h = le32_get_bits(rx_desc->w2, RTW_RX_DESC_W2_C2H);
+	pkt_stat->ppdu_cnt = le32_get_bits(rx_desc->w2, RTW_RX_DESC_W2_PPDU_CNT);
+
+	pkt_stat->rate = le32_get_bits(rx_desc->w3, RTW_RX_DESC_W3_RX_RATE);
+
+	pkt_stat->bw = le32_get_bits(rx_desc->w4, RTW_RX_DESC_W4_BW);
+
+	pkt_stat->tsf_low = le32_get_bits(rx_desc->w5, RTW_RX_DESC_W5_TSFL);
+
+	/* drv_info_sz is in unit of 8-bytes */
+	pkt_stat->drv_info_sz *= 8;
+
+	/* c2h cmd pkt's rx/phy status is not interested */
+	if (pkt_stat->is_c2h)
+		return;
+
+	phy_status = rx_desc8 + desc_sz + pkt_stat->shift;
+	hdr = (struct ieee80211_hdr *)(phy_status + pkt_stat->drv_info_sz);
+	pkt_stat->hdr = hdr;
+
+	if (pkt_stat->phy_status)
+		rtwdev->chip->ops->query_phy_status(rtwdev, phy_status, pkt_stat);
+
+	rtw_rx_fill_rx_status(rtwdev, pkt_stat, hdr, rx_status);
 }
-EXPORT_SYMBOL(rtw_rx_fill_rx_status);
+EXPORT_SYMBOL(rtw_rx_query_rx_desc);
diff --git a/drivers/net/wireless/realtek/rtw88/rx.h b/drivers/net/wireless/realtek/rtw88/rx.h
index 9f0019112987..7f22e73b6b57 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.h
+++ b/drivers/net/wireless/realtek/rtw88/rx.h
@@ -14,42 +14,40 @@ enum rtw_rx_desc_enc {
 	RX_DESC_ENC_WEP104	= 5,
 };
 
-#define GET_RX_DESC_PHYST(rxdesc)                                              \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(26))
-#define GET_RX_DESC_ICV_ERR(rxdesc)                                            \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(15))
-#define GET_RX_DESC_CRC32(rxdesc)                                              \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(14))
-#define GET_RX_DESC_SWDEC(rxdesc)                                              \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), BIT(27))
-#define GET_RX_DESC_C2H(rxdesc)                                                \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x02), BIT(28))
-#define GET_RX_DESC_PKT_LEN(rxdesc)                                            \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(13, 0))
-#define GET_RX_DESC_DRV_INFO_SIZE(rxdesc)                                      \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(19, 16))
-#define GET_RX_DESC_SHIFT(rxdesc)                                              \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(25, 24))
-#define GET_RX_DESC_ENC_TYPE(rxdesc)                                           \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x00), GENMASK(22, 20))
-#define GET_RX_DESC_RX_RATE(rxdesc)                                            \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x03), GENMASK(6, 0))
-#define GET_RX_DESC_MACID(rxdesc)                                              \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x01), GENMASK(6, 0))
-#define GET_RX_DESC_PPDU_CNT(rxdesc)                                           \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x02), GENMASK(30, 29))
-#define GET_RX_DESC_TSFL(rxdesc)                                               \
-	le32_get_bits(*((__le32 *)(rxdesc) + 0x05), GENMASK(31, 0))
-#define GET_RX_DESC_BW(rxdesc)                                                 \
-	(le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(5, 4)))
+struct rtw_rx_desc {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+} __packed;
+
+#define RTW_RX_DESC_W0_PKT_LEN		GENMASK(13, 0)
+#define RTW_RX_DESC_W0_CRC32		BIT(14)
+#define RTW_RX_DESC_W0_ICV_ERR		BIT(15)
+#define RTW_RX_DESC_W0_DRV_INFO_SIZE	GENMASK(19, 16)
+#define RTW_RX_DESC_W0_ENC_TYPE		GENMASK(22, 20)
+#define RTW_RX_DESC_W0_SHIFT		GENMASK(25, 24)
+#define RTW_RX_DESC_W0_PHYST		BIT(26)
+#define RTW_RX_DESC_W0_SWDEC		BIT(27)
+
+#define RTW_RX_DESC_W1_MACID		GENMASK(6, 0)
+
+#define RTW_RX_DESC_W2_C2H		BIT(28)
+#define RTW_RX_DESC_W2_PPDU_CNT		GENMASK(30, 29)
+
+#define RTW_RX_DESC_W3_RX_RATE		GENMASK(6, 0)
+
+#define RTW_RX_DESC_W4_BW		GENMASK(5, 4)
+
+#define RTW_RX_DESC_W5_TSFL		GENMASK(31, 0)
 
 void rtw_rx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		  struct sk_buff *skb);
-void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
-			   struct rtw_rx_pkt_stat *pkt_stat,
-			   struct ieee80211_hdr *hdr,
-			   struct ieee80211_rx_status *rx_status,
-			   u8 *phy_status);
+void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
+			  struct rtw_rx_pkt_stat *pkt_stat,
+			  struct ieee80211_rx_status *rx_status);
 void rtw_update_rx_freq_from_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
 				struct ieee80211_rx_status *rx_status,
 				struct rtw_rx_pkt_stat *pkt_stat);
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index 21d0754dd7f6..601b30070f53 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -981,8 +981,7 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 
 	while (true) {
 		rx_desc = skb->data;
-		chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
-					 &rx_status);
+		rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat, &rx_status);
 		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
 			     pkt_stat.shift;
 
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index e83ab6fb83f5..2641059d3561 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -570,8 +570,8 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 
 		do {
 			rx_desc = skb->data;
-			chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
-						 &rx_status);
+			rtw_rx_query_rx_desc(rtwdev, rx_desc, &pkt_stat,
+					     &rx_status);
 			pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
 				     pkt_stat.shift;
 
-- 
2.46.0


