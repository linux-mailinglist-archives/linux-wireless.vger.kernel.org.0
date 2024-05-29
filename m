Return-Path: <linux-wireless+bounces-8266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A878D3986
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18141F2281C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9340159216;
	Wed, 29 May 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnU/STTc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E0158201
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993732; cv=none; b=qeiCy/SQd9lqts42i0WWb1P7pCCY+z70iS3R977Hr+YpY49nVEJO3jhBiv0H0zBmo0QmpO5iucGiY+ohJL95BfH4slO1t2VBF/ax56SbVdepWcyiQTpLE09duW8u8DDsV8QhNIyFEv1CYUZ4vRjQXj5IeBFYIoq+IeDUE/qRhuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993732; c=relaxed/simple;
	bh=AJTbSurAe/DImAjMG9/zWv9/rdmVlmL4oqspAeQ+nfI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mHUSmyghUkjBOo9uZzdXXjs6Y0J2yj8y7PeB0DXaJiFB9q5QlXZG4ThCfMjW/NazELhz1zcOG2OHLC0qXSRZZr9/fPWo3XUeRwllN0IAAg+2KrBTiF6gAI/zzLMi1/vYVgJNPIf4fwoiEwTWfV5zuBy4E5KG6hCGQAPjaiaD4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnU/STTc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6268034cf8so102672566b.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 07:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716993729; x=1717598529; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q7tOOG4Y1XFf8LJdwZaKz26hPu8Gxw9oJFmVVLZvTk=;
        b=dnU/STTcGJ1UtgnYt+kZsVKMRvQmAgkqHrdASnOwzqxWsOFQgNV0Y6mONLwBLwAqvd
         Ar5FUmg7hu1Y3F6wqdgi3nBAt2/ffImi5LrLMJQWuL2EH+aLZdfflZUD1dTimIgvMQgX
         ZBKpSk3TazcrXZTO7mEVJBYvXK/hFgjTwZwM4l13dyxtuV7e2lpGrZbx5UB/3Z2xEB9g
         bT0KE0cmutD+p8VekPAzW/LHQ9BOE6rCV3MjnLfAsBiXQR9b7rReOR/TRTbpRsuaBYkQ
         KcBVah3uWWfxAckFIn8qUpc3yG565vI5iX8/vwwkcqncWNoyI+dDiDEVVevwH/zYWuBt
         QxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993729; x=1717598529;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5q7tOOG4Y1XFf8LJdwZaKz26hPu8Gxw9oJFmVVLZvTk=;
        b=kJypuM9ktB0a5xf09iKsQv24k9x+e4NPJF3c+L8VAM/+mh0stgld+u0ay8f3M1S3m9
         ChaRo3TfM6hiH3+Ceyx3wNqOr5RoRbPhIUhmimN5cTH06p2OfZBU6EIYtinvgenEqX1y
         VoeSOJxTCMFuX3IiDZPuNRBk9i80NyMwqAxMasW4tcKrOYJYHTaam3yvDSPX/twZFb6U
         t88zfznYkzrbNiPKEv2K3UDLxEuvVm8pJgPeLImLX5gNYwZify6PFbnYjxZn9ndxJ5Z9
         mnFdgn0rVH7UYnF9voPvjvahRSfQlBNGLElfbWokF4jLHLs1Ctkd6tx+wZTCUYNtOltt
         9U/w==
X-Gm-Message-State: AOJu0YxDOu/KD67jxxYSD2pU1vodl577Ft7n4oQGrwwVmuVWs9eng/c2
	SDw0UOgzEqA9phMoVyNuLXbRUiQUl+/Y9KINQTH2dNQYP6LKkSrjxYBRNQ==
X-Google-Smtp-Source: AGHT+IFKX/KPQBIxMeOpMJuBfJr44CZnaixn7VlFd3TvQHDkBgJe3X3ezospupwxH2iDYydYvBswXg==
X-Received: by 2002:a50:8ad1:0:b0:578:5b30:8bfd with SMTP id 4fb4d7f45d1cf-5785b3098cemr12121239a12.21.1716993729051;
        Wed, 29 May 2024 07:42:09 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d0d5aba4sm4566659a12.71.2024.05.29.07.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 07:42:08 -0700 (PDT)
Message-ID: <0996d2d0-e7b8-4e43-ba12-63074ba9df1b@gmail.com>
Date: Wed, 29 May 2024 17:42:07 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtw88: usb: Further limit the TX aggregation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently the number of frames sent to the chip in a single USB Request
Block is limited only by the size of the TX buffer, which is 20 KiB.
Testing reveals that as many as 13 frames get aggregated. This is more
than what any of the chips would like to receive. RTL8822CU, RTL8822BU,
and RTL8821CU want at most 3 frames, and RTL8723DU wants only 1 frame
per URB.

RTL8723DU in particular reliably malfunctions during a speed test. All
traffic seems to stop. Pinging the AP no longer works.

Fix this problem by limiting the number of frames sent to the chip in a
single URB according to what each chip likes.

Also configure RTL8822CU, RTL8822BU, and RTL8821CU to expect 3 frames
per URB.

RTL8703B may or may not be found in USB devices. Declare that it wants
only 1 frame per URB, just in case.

Tested with RTL8723DU and RTL8811CU.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c      | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  2 ++
 drivers/net/wireless/realtek/rtw88/reg.h      |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
 drivers/net/wireless/realtek/rtw88/usb.c      |  4 +++-
 9 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 0dba8aae7716..fca90759c268 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1186,6 +1186,7 @@ static int __priority_queue_cfg(struct rtw_dev *rtwdev,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
+	u8 val8;
 
 	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_1, pg_tbl->hq_num);
 	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_2, pg_tbl->lq_num);
@@ -1201,6 +1202,17 @@ static int __priority_queue_cfg(struct rtw_dev *rtwdev,
 	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2 + 2, fifo->rsvd_boundary);
 	rtw_write16(rtwdev, REG_BCNQ1_BDNY_V1, fifo->rsvd_boundary);
 	rtw_write32(rtwdev, REG_RXFF_BNDY, chip->rxff_size - C2H_PKT_BUF - 1);
+
+	if (rtwdev->hci.type == RTW_HCI_TYPE_USB) {
+		val8 = rtw_read8(rtwdev, REG_AUTO_LLT_V1);
+		u8p_replace_bits(&val8, chip->usb_tx_agg_desc_num,
+				 BIT_MASK_BLK_DESC_NUM);
+		rtw_write8(rtwdev, REG_AUTO_LLT_V1, val8);
+
+		rtw_write8(rtwdev, REG_AUTO_LLT_V1 + 3, chip->usb_tx_agg_desc_num);
+		rtw_write8_set(rtwdev, REG_TXDMA_OFFSET_CHK + 1, BIT(1));
+	}
+
 	rtw_write8_set(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1);
 
 	if (!check_hw_ready(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1, 0))
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 49894331f7b4..49a3fd4fb7dc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1197,6 +1197,8 @@ struct rtw_chip_info {
 	u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
 	const struct rtw_fwcd_segs *fwcd_segs;
 
+	u8 usb_tx_agg_desc_num;
+
 	u8 default_1ss_tx_path;
 
 	bool path_div_supported;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index b122f226924b..572651b3aa4b 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -270,6 +270,7 @@
 #define BIT_MASK_BCN_HEAD_1_V1	0xfff
 #define REG_AUTO_LLT_V1		0x0208
 #define BIT_AUTO_INIT_LLT_V1	BIT(0)
+#define BIT_MASK_BLK_DESC_NUM	0xf0
 #define REG_DWBCN0_CTRL		0x0208
 #define BIT_BCN_VALID		BIT(16)
 #define REG_TXDMA_OFFSET_CHK	0x020C
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 8919f9e11f03..222608de33cd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -2013,6 +2013,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.tx_stbc = false,
 	.max_power_index = 0x3f,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
+	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
 
 	.path_div_supported = false,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index f8df4c84d39f..15620fd224e0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2194,6 +2194,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.rfe_defs = rtw8723d_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8723d_rfe_defs),
 	.rx_ldpc = false,
+	.usb_tx_agg_desc_num = 1,
 	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index fe5d8e188350..1c7289534c5c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -2029,6 +2029,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.rfe_defs = rtw8821c_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8821c_rfe_defs),
 	.rx_ldpc = false,
+	.usb_tx_agg_desc_num = 3,
 	.pwr_track_tbl = &rtw8821c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 3017a9760da8..aeb90d45290c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2574,6 +2574,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
 	.rx_ldpc = true,
+	.usb_tx_agg_desc_num = 3,
 	.edcca_th = rtw8822b_edcca_th,
 	.l2h_th_ini_cs = 10 + EDCCA_IGI_BASE,
 	.l2h_th_ini_ad = -14 + EDCCA_IGI_BASE,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index cd965edc29ce..afc0b4d8b59d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5399,6 +5399,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.bfer_mu_max_num = 1,
 	.rx_ldpc = true,
 	.tx_stbc = true,
+	.usb_tx_agg_desc_num = 3,
 	.edcca_th = rtw8822c_edcca_th,
 	.l2h_th_ini_cs = 60,
 	.l2h_th_ini_ad = 45,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index d204d138afe2..057c0ffbe944 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -379,7 +379,9 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwusb, struct sk_buff_head *list
 
 		skb_iter = skb_peek(list);
 
-		if (skb_iter && skb_iter->len + skb_head->len <= RTW_USB_MAX_XMITBUF_SZ)
+		if (skb_iter &&
+		    skb_iter->len + skb_head->len <= RTW_USB_MAX_XMITBUF_SZ &&
+		    agg_num < rtwdev->chip->usb_tx_agg_desc_num)
 			__skb_unlink(skb_iter, list);
 		else
 			skb_iter = NULL;
-- 
2.45.1


