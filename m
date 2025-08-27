Return-Path: <linux-wireless+bounces-26708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61D8B38801
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C25F684A4D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0723E340;
	Wed, 27 Aug 2025 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCvbKHnu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6C171CD
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313336; cv=none; b=ekwsVZ77Xg5cv1+F8krFGxlv1IajLLd18OmpLVknTrUIRivvRdNtOhHCGbZB4WSrveh3PF9ZTtZK+mW9fud49w+373N0PiY0Vy7AiBenDOjRSpVULPFxH4kvhpeAXLt7rsIyWP74hExDfUO8rGiGgqnDzAssQyV4XkntCUj7tRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313336; c=relaxed/simple;
	bh=icqYe5V2c3pQlfyNvsoKWxY+K3nBbHIMy9JpWxk1TzQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VqOSX0iu+dJeG4rrn7vj1Nr+RlyQTTzoYExlhgfqw/iXqrSGLUyWSp2RImwb2d43E6HukAo9+G4czFQwqMQcQzxgAxIriz6lf1pEexnxRPAROm74V7uempZ77pVDqgjWkPXcs9jp57xWM9PorV0UCBskrqPpCFwWm7JD4m4kqDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCvbKHnu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b004954so117325e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313332; x=1756918132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J0rJ2XtNSqshHSDZBghYUipfdF2xvPqUlk12jrfOnTk=;
        b=LCvbKHnuXrPY49bTprH7R9ybX7NjaFaaZMia+oMElkhMcGLfw84JSwG8+2IyBq7tKd
         TsdlwE7wvP1++4MEV1ELYkQQxalUb+3Tc1/OeDK8iHB5WbA2ZWbv9O9x5rM5ZZCJF6iZ
         wfau25MRSpmVlr3DiqAauy51FP+Mdz0mW/1K9oMZ535xDswn78fyzp8J5l1sYSSsvXXJ
         ifxOdtYBdx/0h4uWY69BtsV2EMEe8+Wt6iUgHv+FMF5NauYfwU/qOWC0TKV5i9jHz9eT
         +j+SwqA1vh3TcWRFR+AotdC3h1+otBi0At6JBTtjqMekz4vXY5gzPdv0NujRpRGDBpag
         ctBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313332; x=1756918132;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0rJ2XtNSqshHSDZBghYUipfdF2xvPqUlk12jrfOnTk=;
        b=bImCUOX0LXApabVmK5qMyPv3rqW5SBeGLm9wEzjYf6fkAr6IczUpDn5I2CiIHRbzoJ
         h/0N7cNe8QoiIuKOcrQSkb5q10I5bcfGr6J3Whn/tD94Ko4qlxGV03CnNy6r+RpTuX1k
         zmU+0w2gmCOl6nq2Cwnf4nzi55VKP1IwMTH3gDAd8EiiPWQ1bqNER7VGtupepySYVwKU
         Gu9POJbaVAWt/gBHqZx94783S9MtIXvNONQflLRaxqXegz/gPFkBzpVtxngPAe4VxeJB
         aExTK1YBW8Uvo5gzNhDeH8vt/zaHy+fSHP8Ry4FyWZjbYnCRcPivh9cTtL5jqZ/afzgy
         oY6g==
X-Gm-Message-State: AOJu0YweWOit9SfjcVbMZk/EX9u5BSoZTXHvitbiGJArV/Cem9tOaCni
	v6k5Y8z8Gz8QnMkM7mvwU1Fp62KbhRNvHutYRt1A3Bfs6cArCpahGVeFjhztJg==
X-Gm-Gg: ASbGnctbaUbIu2hqNG0j2kOGBK805rNsqDmr3zQcQzPdhB+581swoytFB4SxuqEUFaq
	ASNYytHhpns1of4NhztHLeMEBqapNA0KRSfdrYjCIQduQj5IaEEzWLjZpQ9GzIPAMtT6AoGBCb7
	CvtotoDuFHx2sVoZpqrRt9+LiY35R+ELrkkoByqRSNuLVRTyT32JBWU7FpuXz8rlnehhd+r5uA3
	xTiw0eTJLd1cdjBnv5S5GlWbOCqBa0pEf0LmmmWJ2/s3W00TYwH8vacuohq5RzS4qHvnEF18yT2
	bwoiglOhRzUxRqPEKImlz4+yoaRXO+ZcsbIw9z4FnWYcMrbfP2nIYrWXfr0ZVWUPNwDfZbxdPFT
	UmEg+tTbpRYtqb2t9rkcUN5NVRmyuUg==
X-Google-Smtp-Source: AGHT+IEwbgcAHAdYohtu4u7gOWGdRI3lRdcvJkGQpRmlp5v84waliGvcLaAc/334WC9IbEgJB1fjTg==
X-Received: by 2002:a05:6000:2089:b0:3cb:d8e2:48b2 with SMTP id ffacd0b85a97d-3cbd8e24b73mr4650181f8f.13.1756313332444;
        Wed, 27 Aug 2025 09:48:52 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc890b178bsm3995492f8f.52.2025.08.27.09.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:48:51 -0700 (PDT)
Message-ID: <321a9d86-4327-418e-89f1-eb8fb242cc13@gmail.com>
Date: Wed, 27 Aug 2025 19:48:50 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 01/11] wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8852CU, RTL8852AU, and RTL8922AU need a different mapping of TX
queue to DMA channel compared to their PCI versions, so make
get_ch_dma in struct rtw89_chip_ops an array and add
rtw89_core_get_ch_dma_v2().

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Use the new get_ch_dma chip op and add rtw89_core_get_ch_dma_v2()
   instead of modifying rtw89_core_get_ch_dma().
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
index 20d8f2221f81..86ef54ddda5b 100644
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
index ecfbcff85047..ff3362d1f602 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3760,7 +3760,7 @@ struct rtw89_chip_ops {
 	void (*fill_txdesc_fwcmd)(struct rtw89_dev *rtwdev,
 				  struct rtw89_tx_desc_info *desc_info,
 				  void *txdesc);
-	u8 (*get_ch_dma)(struct rtw89_dev *rtwdev, u8 qsel);
+	u8 (*get_ch_dma[RTW89_HCI_TYPE_NUM])(struct rtw89_dev *rtwdev, u8 qsel);
 	int (*cfg_ctrl_path)(struct rtw89_dev *rtwdev, bool wl);
 	int (*mac_cfg_gnt)(struct rtw89_dev *rtwdev,
 			   const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
@@ -7203,7 +7203,7 @@ u8 rtw89_chip_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	return chip->ops->get_ch_dma(rtwdev, qsel);
+	return chip->ops->get_ch_dma[rtwdev->hci.type](rtwdev, qsel);
 }
 
 static inline
@@ -7452,6 +7452,7 @@ void rtw89_core_fill_txdesc_fwcmd_v2(struct rtw89_dev *rtwdev,
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
index 8eb0cb9bb23e..55646abf44d6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2817,7 +2817,9 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
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
2.50.1


