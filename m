Return-Path: <linux-wireless+bounces-13064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C593D97D9CD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 21:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBBFB222D4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6D17E016;
	Fri, 20 Sep 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpF6mLPw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B14291E
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726860457; cv=none; b=a9NHWRot4QE/piReCFT8iEU3VW1kSi0FVlkksRkjBE7tsBJLbG6RmFrXLGDLn+NW6b6RualcHQ5BjsaepQzNVYEF0OHmJgIMZWVFPmoro3lWm5kpQi9Uoj92BjWe4753IRaccxNNy6hfwr24yEw0mBNxPgojh9DCRvSCbCGFexk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726860457; c=relaxed/simple;
	bh=gNMezo6x+7CCkTnChtOSlHw03zO2PSH1GwY6hSj+vEg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kuSIXRufdJd8aKVpKh7lhUWRY98PPSm0o7P58kGYJ9OoIz/pSOX56eTx4sslt5aUhPCiwPvgrOjdlsaS78hw94keGyJhzA/S5i3J0xb52Ub5JNApjmg4ZPDiSrOiYalOH4/IfSSM225s14Te29e938izg2rLIN+cKq/xaFRxxxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpF6mLPw; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c46680a71bso1043577a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 12:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726860453; x=1727465253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l67TR7LJXrMmCitG+lbYmYj3xiJ6+iF3iLqebNfvjlo=;
        b=kpF6mLPwVByW75OYf3e+rVutYBUyDwRTUD0iF4S4SjM4Wi20HfSgmVsa5VtF8Hom4R
         IKjd7H9/BGEiXLXirow6PhPvGkevJdh7ZYl6boMqN1ulk157RoNfXbmuf8Ayu9rA/Mal
         OZ6/hV51uZgRpg9bYgPEq7l9MfXkBSQMcNQJ+JwEJ/lB5j5s909ZgrLZp4k7gjXHqXvb
         xq+9qhXe1BpiDlrEHzQfqeFxb+Ly8eTymDYPJwwxroVkeLQd1Mw+xNu07yMZ9KvRBPQd
         XSLcX1K2rPB+iW+dJErTv33d134zMaSwcow90bUhqXNVkfn9MEVmAqUuiMyHddteTqH7
         El5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726860453; x=1727465253;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l67TR7LJXrMmCitG+lbYmYj3xiJ6+iF3iLqebNfvjlo=;
        b=v3ZoL/1W5ko0jWA3+rBuQRtGOGg1XYNr1ByVooS+arUbm7BVoPt9iXLE8O7Hrf6twS
         bRN4yl59xbpD0ZbZhQ9FmPYfmbqmAUMnOEprUbl7R2wuA4NDRlGslJmDxKYLbj21A20r
         zwTO84ScNfpBe0myE2Amv70lEgdz/q6oXkglcfnbMNv1KCjrbQa3yCyeDk4LYNO5Pe5l
         7Pggoc0GiFT1TWpRaOHaNn3wpJybJk4Wt02IiJQrSmzYdBAE1wD6RzgQVpOUdGCfeMvW
         MFKgkipxQ+063ITTjKZQqLiTqDNOG2CjAtL4nVYeEceRAQwcGg11EsTNgfTzeVJX0sQh
         e1uA==
X-Gm-Message-State: AOJu0Ywj6FdLj9K0PdRCzx0DInee6QxAMrmaFqfR8N1wdOiVow9zTchi
	hD4Fju+adGpzK3cx6aCTPgoX2QTpnndhwWaWiUWhmSZocZpMHcWSOVq6jA==
X-Google-Smtp-Source: AGHT+IEiTn7uz3QKmP3bp4Lg6SJy1gsVoAr6cOwW71c3XaSN6z2Rqtj7ZEG9DvP5M+rzDfmAXGKqpw==
X-Received: by 2002:a05:6402:280b:b0:5a1:c496:2447 with SMTP id 4fb4d7f45d1cf-5c464a417cdmr2599852a12.21.1726860452655;
        Fri, 20 Sep 2024 12:27:32 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc8a51dsm7495866a12.97.2024.09.20.12.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 12:27:32 -0700 (PDT)
Message-ID: <913f1747-38fc-4409-85a4-57bb9cee506b@gmail.com>
Date: Fri, 20 Sep 2024 22:27:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtw88: Parse the RX descriptor with a single
 function
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

Tested with RTL8811CU, RTL8811AU, and RTL8812AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Delete RX_DRV_INFO_SZ_UNIT_8703B, it's unused now.
 - Change the type of rx_desc8 and phy_status to void* to avoid casting.
 - Mention the tested chips.
---
 drivers/net/wireless/realtek/rtw88/main.h     |  5 +-
 drivers/net/wireless/realtek/rtw88/pci.c      |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 56 +--------------
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 43 +-----------
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 43 +-----------
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 43 +-----------
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 44 +-----------
 drivers/net/wireless/realtek/rtw88/rx.c       | 70 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/rx.h       | 64 ++++++++---------
 drivers/net/wireless/realtek/rtw88/sdio.c     |  3 +-
 drivers/net/wireless/realtek/rtw88/usb.c      |  4 +-
 11 files changed, 106 insertions(+), 271 deletions(-)

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
index e3ac748ad646..77399b8dd8cd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -29,9 +29,6 @@
 #define TBTT_PROHIBIT_HOLD_TIME 0x80
 #define TBTT_PROHIBIT_HOLD_TIME_STOP_BCN 0x64
 
-/* raw pkt_stat->drv_info_sz is in unit of 8-bytes */
-#define RX_DRV_INFO_SZ_UNIT_8703B 8
-
 #define TRANS_SEQ_END			\
 	0xFFFF,				\
 	RTW_PWR_CUT_ALL_MSK,		\
@@ -1032,57 +1029,6 @@ static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
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
@@ -1948,7 +1894,7 @@ static const struct rtw_chip_ops rtw8703b_ops = {
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
index 66f9419588cf..1de93fc9efe9 100644
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
+void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
+			  struct rtw_rx_pkt_stat *pkt_stat,
+			  struct ieee80211_rx_status *rx_status)
+{
+	u32 desc_sz = rtwdev->chip->rx_pkt_desc_sz;
+	struct rtw_rx_desc *rx_desc = rx_desc8;
+	struct ieee80211_hdr *hdr;
+	u32 enc_type, swdec;
+	void *phy_status;
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
+	hdr = phy_status + pkt_stat->drv_info_sz;
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
index 9f0019112987..6b7dee245c0a 100644
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
+void rtw_rx_query_rx_desc(struct rtw_dev *rtwdev, void *rx_desc8,
+			  struct rtw_rx_pkt_stat *pkt_stat,
+			  struct ieee80211_rx_status *rx_status);
 void rtw_update_rx_freq_from_ie(struct rtw_dev *rtwdev, struct sk_buff *skb,
 				struct ieee80211_rx_status *rx_status,
 				struct rtw_rx_pkt_stat *pkt_stat);
diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index b67e551fcee3..f0b06ed8f76d 100644
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
index dbc7d8d73494..ba314d90ab3f 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -571,8 +571,8 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 
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


