Return-Path: <linux-wireless+bounces-28458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44527C28611
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF3D4E965C
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060DE2FFFA4;
	Sat,  1 Nov 2025 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzpVPHSK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C0F224B0E
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024844; cv=none; b=pT19w9uW1+ApskrgJCdcdXchyAp3HsABBlvF/y+1CWrxh5Eyfg7CASSQFrip7cQWAOOhwbjN7d3vF8prh+K7dNe4KUin4Ixl6kpv0WQhBzg0NBaW0YFDzrf2ddHcCGUT9Tn9LVYyS6FK9lL8h2sLRR+Oz/lYnkJIUSt/Qz53dvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024844; c=relaxed/simple;
	bh=HVRDnfuB0enF4iVG2/A+E2VGefHu53rdTS/s37EICZA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R16ZEUG/J+TVlZcXPaeoVLkyajwLL+znLpW5WLc0M8sd/4mGgkcyTtwfrBGhGRyNiWAb33WGs4WDEXv59rshlIjawlwz9HOqNX9iBvZREq5YrTxos6OmJzQnOlF+k/gMPINZD6jVhglh1ZuDfsFwpOBLD1HM5QOtSiOR0Sxfr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzpVPHSK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c8632fcbso367681f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762024841; x=1762629641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1IocHzXTlU5q4PcdHFM0f/zZqOHtSpZQuEiOCgx9To=;
        b=CzpVPHSK8EjBxDByftsdIkNxqCbXxVwn2iUZ9822vjt4IbYrosdRralKFcgkgCp2kw
         BjXVkcKCmQW8wGqTR0hR0p60xRK9Sf2smGNxkDL8FYaWD49TpAVeU5P1DiVx1C7q16H4
         AuRlmAlxrHLVIV4kSOXAymhBJUdn4XLFSNc0+MV687++oDP6oZ69XbjXRmWBYCJE8UTF
         ZiP8ZEVT2kj8SbpXxJNtKRGm07pzOkjiSgh9aKF31lyjWbKxtoTRKlQSGihk0InGmR7e
         0Wrzp1SqVd1tZ128QGz27v2MW8zI3rS+PjvYLzhHOi+5zQP5KHmoGC5KoYYzbC6KGmPD
         gAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762024841; x=1762629641;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1IocHzXTlU5q4PcdHFM0f/zZqOHtSpZQuEiOCgx9To=;
        b=PX0zn1FXCjT8tPhy5IHu8RmQqw9WZABXyUk73PmS0mK2WnRcNx1v0n2jsYM9eXsxsL
         MdAM3Z6bvDuyNPzYyrZ8oweRnpVUoOIIUZKo6CRgsJwsBHrOe5uCeyx22rA7pxfFHmqv
         EcmSNo195ZaVHAGl3oHjoWA6gUSMr8oLcrMieAXwCIwGDNkJNz75aSyfeSYSU5ZeQ9Z2
         PEr4MkCrdYG9FKccuzXdqFEuxQIVwU2glwQsknn0Cw2VyXZCh8pzly4nD+2dLk4ZOx/m
         pNtxJk3Xu8GSkuuKhBghdbMh1XVIjv1+Sl+hDmsaALiwLMNwR8T5udkZFNs6keEkHA7O
         J8yw==
X-Gm-Message-State: AOJu0YxZjlpJ3kWjFg/Le56EFdPV5Go0NDIlMpMkgeibhwSZG+8B9q1E
	aOR3Hm/LninBuun9+l84Yw7Pobz9LuyAEN8GEgMwThm6CAdrbZk03TZZ95FEOA==
X-Gm-Gg: ASbGncvtZQcdI7pgeLwU4btd9NKupeAibsWoQyyieSS6sATojcvejrNSHSVZWcBCxCG
	4BRhvbQn9pXSIIoABeOGciPKfGtVMrDlA7ykwzANL6ShFlfWylK/XPXvEzX6E3MvBFLGoJjRYAe
	IMkPQRfcaI/yzWYdzJnLoRtfwrvSWFPxS1LkYewXNx26IMA99fT8815mdYMxJa9GxNL9vNutRgV
	P28ZEO6WdGMbXyKpcyJAV/ikUQehKaPR9SIMznoaTeAcIYkZ00f/kJSZ5TaCwNNHJEdM6RwU6OI
	ExBoub3lB+5yYBApmNchq399vnUpZbxxnPonxMtZbW2kQxpCX3CwWBiqdO/YTxH+4IXBS3m4p58
	vr64Udc73f5QN95fl1Ff7H/QvgpwTbjOZn/3axciJeRXGp32tCH8Ar8+8PWlMS6iFgf+fy8fXpS
	HnJu3x1wYHYNqes0SmynY=
X-Google-Smtp-Source: AGHT+IFVHjgdY10+PMT9gzrcDuQy1qLC65Wbj02gvpTBOLdbvMESP5jWbfzwDFY9o2gd0MoguVODiQ==
X-Received: by 2002:a5d:5f50:0:b0:429:b8f9:a87e with SMTP id ffacd0b85a97d-429bd6887f5mr7220140f8f.20.1762024841053;
        Sat, 01 Nov 2025 12:20:41 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1c9esm10741832f8f.22.2025.11.01.12.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:20:40 -0700 (PDT)
Message-ID: <6c7b2f01-2c78-47c8-a4c4-98cd3060d7f3@gmail.com>
Date: Sat, 1 Nov 2025 21:20:38 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 02/12] wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
 <3904dd9f-2178-41e5-95c2-7a9f6268e935@gmail.com>
Content-Language: en-US
In-Reply-To: <3904dd9f-2178-41e5-95c2-7a9f6268e935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8852CU, RTL8852AU, and RTL8922AU need a different mapping of TX
queue to DMA channel compared to their PCI versions, so make
get_ch_dma in struct rtw89_chip_ops an array and add
rtw89_core_get_ch_dma_v2().

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Use the new get_ch_dma chip op and add rtw89_core_get_ch_dma_v2()
   instead of modifying rtw89_core_get_ch_dma().

v4:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/core.c     | 19 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  5 +++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  4 +++-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  4 +++-
 8 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1b5a40e9821c..1f92be300ea7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -759,6 +759,25 @@ u8 rtw89_core_get_ch_dma_v1(struct rtw89_dev *rtwdev, u8 qsel)
 }
 EXPORT_SYMBOL(rtw89_core_get_ch_dma_v1);
 
+u8 rtw89_core_get_ch_dma_v2(struct rtw89_dev *rtwdev, u8 qsel)
+{
+	switch (qsel) {
+	default:
+		rtw89_warn(rtwdev, "Cannot map qsel to dma v2: %d\n", qsel);
+		fallthrough;
+	case RTW89_TX_QSEL_BE_0:
+	case RTW89_TX_QSEL_VO_0:
+		return RTW89_TXCH_ACH0;
+	case RTW89_TX_QSEL_BK_0:
+	case RTW89_TX_QSEL_VI_0:
+		return RTW89_TXCH_ACH2;
+	case RTW89_TX_QSEL_B0_MGMT:
+	case RTW89_TX_QSEL_B0_HI:
+		return RTW89_TXCH_CH8;
+	}
+}
+EXPORT_SYMBOL(rtw89_core_get_ch_dma_v2);
+
 static void
 rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 			       struct rtw89_core_tx_request *tx_req)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f8b443894db9..c7b48bd000c7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3764,7 +3764,7 @@ struct rtw89_chip_ops {
 	void (*fill_txdesc_fwcmd)(struct rtw89_dev *rtwdev,
 				  struct rtw89_tx_desc_info *desc_info,
 				  void *txdesc);
-	u8 (*get_ch_dma)(struct rtw89_dev *rtwdev, u8 qsel);
+	u8 (*get_ch_dma[RTW89_HCI_TYPE_NUM])(struct rtw89_dev *rtwdev, u8 qsel);
 	int (*cfg_ctrl_path)(struct rtw89_dev *rtwdev, bool wl);
 	int (*mac_cfg_gnt)(struct rtw89_dev *rtwdev,
 			   const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
@@ -7253,7 +7253,7 @@ u8 rtw89_chip_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	return chip->ops->get_ch_dma(rtwdev, qsel);
+	return chip->ops->get_ch_dma[rtwdev->hci.type](rtwdev, qsel);
 }
 
 static inline
@@ -7507,6 +7507,7 @@ void rtw89_core_fill_txdesc_fwcmd_v2(struct rtw89_dev *rtwdev,
 				     void *txdesc);
 u8 rtw89_core_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel);
 u8 rtw89_core_get_ch_dma_v1(struct rtw89_dev *rtwdev, u8 qsel);
+u8 rtw89_core_get_ch_dma_v2(struct rtw89_dev *rtwdev, u8 qsel);
 void rtw89_core_rx(struct rtw89_dev *rtwdev,
 		   struct rtw89_rx_desc_info *desc_info,
 		   struct sk_buff *skb);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index edcbda124916..2019f6022cbb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2537,7 +2537,9 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
-	.get_ch_dma		= rtw89_core_get_ch_dma,
+	.get_ch_dma		= {rtw89_core_get_ch_dma,
+				   rtw89_core_get_ch_dma,
+				   NULL,},
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 232f4c1bee1b..fa347dbebf9a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2178,7 +2178,9 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
-	.get_ch_dma		= rtw89_core_get_ch_dma,
+	.get_ch_dma		= {rtw89_core_get_ch_dma,
+				   rtw89_core_get_ch_dma_v2,
+				   NULL,},
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 0777e336aaa1..38cd151f8c3f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -842,7 +842,9 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
-	.get_ch_dma		= rtw89_core_get_ch_dma,
+	.get_ch_dma		= {rtw89_core_get_ch_dma,
+				   rtw89_core_get_ch_dma,
+				   NULL,},
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index b3a79ebc7e75..15ba780492d6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -708,7 +708,9 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
-	.get_ch_dma		= rtw89_core_get_ch_dma,
+	.get_ch_dma		= {rtw89_core_get_ch_dma,
+				   NULL,
+				   NULL,},
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 440801d63343..ee1915307376 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2962,7 +2962,9 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc,
 	.fill_txdesc		= rtw89_core_fill_txdesc_v1,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v1,
-	.get_ch_dma		= rtw89_core_get_ch_dma,
+	.get_ch_dma		= {rtw89_core_get_ch_dma,
+				   rtw89_core_get_ch_dma_v2,
+				   NULL,},
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v1,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v1,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 6aa19ad259ac..61f3a0a3f440 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2821,7 +2821,9 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc_v2,
 	.fill_txdesc		= rtw89_core_fill_txdesc_v2,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v2,
-	.get_ch_dma		= rtw89_core_get_ch_dma,
+	.get_ch_dma		= {rtw89_core_get_ch_dma,
+				   rtw89_core_get_ch_dma_v2,
+				   NULL,},
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v2,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v2,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v2,
-- 
2.51.1


