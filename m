Return-Path: <linux-wireless+bounces-6040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9E89E3E9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 21:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359AC28382D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 19:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB15B157A44;
	Tue,  9 Apr 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsqesLq+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24859156C44
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692339; cv=none; b=NkDYMX4HQh2SqmwsVv/BpkIow3gDtDbZYwbcHZ6P5JFGc1OE7l4gVFQoGrZLKpllRjX66kI88F8j69D95dlULPVM9xs1N7aCfxuuqO1mSjTz7r807Nb7G++iVJSbxRJcY/+jdcyfCZjhkkGEgoOl6Og9XOvT+QX1s845U4ZWeKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692339; c=relaxed/simple;
	bh=SOyVV3diXCBvqBrbUiXG9OYF8FU0njvImItbIWboncs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D0uwCmgzdoDDBH+23Ghqb30jbUojUZUKoda3eZEv31rH0b6RbuHmcfDgbhFC6q4nOY39cKI1CVTCl2rivDA2aV3N90BCSE057vpGNeEKax6beMztJS8cIWx6pfKa5+whMcCvBmA5r4DbQNJhMBAjGRqw3V7TxoLpq/2WI2xlfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsqesLq+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso6760271a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712692336; x=1713297136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oltZamKT6W22EiCIradq0+6sEQwX8IjU9d58U9OuWXQ=;
        b=fsqesLq+tLzDEl5RFu2A7XfcOrvHiir1OPxIhcRZ34culaxJnohjeGv9F28qAdlllu
         /PmIYT1aN1E7LjBMhcFqm5uR1WU9dwlPuRPrD753zc9jfr6WyuYCiKAvk3aLJm34/vJL
         hasT2Yi9KS1Y1sGmrBaLUZKde7yPi+pgcpV0nooigsQHi9HWIkkKNfAWm/Y5V+KmasQX
         1MNM/Dp8qOl0ctFU0/Op6TxfMjBqjxXECnE5xo0Kkm6sv7Lqi1cHmLrHrER4rrJvjV8w
         NgpluvF8OUw7fdzRnLtgFkTFjZWIfUvJkBw6MWJ+nCP6pfckLjKGh6i/Jc7w/5gn7kGr
         S+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712692336; x=1713297136;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oltZamKT6W22EiCIradq0+6sEQwX8IjU9d58U9OuWXQ=;
        b=hqEDYrybXJw5x3bMrEzNL8kQnoMt4+k1FaZ5N8iTx+Z/7L3xaHeO1AfoFL1pMSlMfu
         bAQXxKwhNf0Ay1YUq6dma7wOtPb1CAukcJ61Zbj3plB3JVSvjTFLEjWzW2mTVT19JI3L
         M02EPkB9k7mvz6+bSc1gLSSeqvde9FNv6OpQl9CUHsphEST8M9kRAx186vt6FBuJE22/
         ex9KNl0pV9heXspgxYhAqD/6OuKc0JLdqEhDIAR/kIl0/YV3Sajr7qOPr/gdf92BkvR3
         E8KgDDYMonbxgijni9MvdDQOvdu/yTuThc1Pm4AL6Iy1476MlrBKqTq0fq7iQ4cHIg6p
         dtAg==
X-Gm-Message-State: AOJu0YxDdOdlLXD3LptKDgYw1nJ58KYbbBqBJiekRnPnzKm4gqozxaNR
	jCbkUMyaET6IF2P50KPXkNCzUJxRZD/HndNHmI3U2PgdwT3OAsUMo4sSlJfT33k=
X-Google-Smtp-Source: AGHT+IFaWCvxm4/pp+f7trlMnNLbO4/X1YXs0I+3R0wM52qQg81ast7STXHL5gD9fKRJVbpwuUxzfQ==
X-Received: by 2002:a50:9b19:0:b0:56e:238e:372c with SMTP id o25-20020a509b19000000b0056e238e372cmr319862edi.26.1712692336295;
        Tue, 09 Apr 2024 12:52:16 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id ev10-20020a056402540a00b0056c249798absm5590738edb.71.2024.04.09.12.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:52:15 -0700 (PDT)
Message-ID: <ed12ec17-ae6e-45fa-a72f-23e0a34654da@gmail.com>
Date: Tue, 9 Apr 2024 22:52:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 02/14] wifi: rtlwifi: rtl8192de: Fix low speed with
 WPA3-SAE
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Language: en-US
In-Reply-To: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some (all?) management frames are incorrectly reported to mac80211 as
decrypted when actually the hardware did not decrypt them. This results
in speeds 3-5 times lower than expected, 20-30 Mbps instead of 100
Mbps.

Fix this by checking the encryption type field of the RX descriptor.
rtw88 does the same thing.

This fix was tested only with rtl8192du, which will use the same code.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Patch is new in v4.
---
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |  5 ++---
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.h   | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index 192982ec8152..30b262c3f6d0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -413,7 +413,8 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	stats->icv = (u16)get_rx_desc_icv(pdesc);
 	stats->crc = (u16)get_rx_desc_crc32(pdesc);
 	stats->hwerror = (stats->crc | stats->icv);
-	stats->decrypted = !get_rx_desc_swdec(pdesc);
+	stats->decrypted = !get_rx_desc_swdec(pdesc) &&
+			   get_rx_desc_enc_type(pdesc) != RX_DESC_ENC_NONE;
 	stats->rate = (u8)get_rx_desc_rxmcs(pdesc);
 	stats->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
 	stats->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
@@ -426,8 +427,6 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	rx_status->band = hw->conf.chandef.chan->band;
 	if (get_rx_desc_crc32(pdesc))
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (!get_rx_desc_swdec(pdesc))
-		rx_status->flag |= RX_FLAG_DECRYPTED;
 	if (get_rx_desc_bw(pdesc))
 		rx_status->bw = RATE_INFO_BW_40;
 	if (get_rx_desc_rxht(pdesc))
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index 2992668c156c..f189ee2d9be2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -14,6 +14,15 @@
 #define USB_HWDESC_HEADER_LEN			32
 #define CRCLENGTH				4
 
+enum rtl92d_rx_desc_enc {
+	RX_DESC_ENC_NONE	= 0,
+	RX_DESC_ENC_WEP40	= 1,
+	RX_DESC_ENC_TKIP_WO_MIC	= 2,
+	RX_DESC_ENC_TKIP_MIC	= 3,
+	RX_DESC_ENC_AES		= 4,
+	RX_DESC_ENC_WEP104	= 5,
+};
+
 /* macros to read/write various fields in RX or TX descriptors */
 
 static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32 __val)
@@ -246,6 +255,11 @@ static inline u32 get_rx_desc_drv_info_size(__le32 *__pdesc)
 	return le32_get_bits(*__pdesc, GENMASK(19, 16));
 }
 
+static inline u32 get_rx_desc_enc_type(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, GENMASK(22, 20));
+}
+
 static inline u32 get_rx_desc_shift(__le32 *__pdesc)
 {
 	return le32_get_bits(*__pdesc, GENMASK(25, 24));
-- 
2.44.0



