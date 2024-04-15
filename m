Return-Path: <linux-wireless+bounces-6343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ABC8A5C2A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 22:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BB51C213CA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457615666B;
	Mon, 15 Apr 2024 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW2Emqne"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B61156879
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212689; cv=none; b=mtV853hDnQNui/B2Y5+LLYTtGZRAUdgFk6HUJIXlPn/n5e8OhNQPpyqchEdHH7VKQMi1lGiaNmpB4lK75iPjV+6kbgOlnBEKQJPfMOGrwPAHTrTV0aY7U8iLF/qTqFN9cWibK+sTq/od5YvQAhXEyKM34V3Lx1H2UaeKgzegP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212689; c=relaxed/simple;
	bh=XhW409dcGqMIcxIaz/ew0xDkfWGAYprjIJTZ5LNPOYI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ql3MmtEBwjAteEN2oVQs2vx8sdJf8dT7NZntJkL5iqTd0LA0k63/WGk4LVq3P+C62aremAZZFooUtSFMh8bxUt1X0dNoAVpxZ/pjilEwUHc5PJ5itCz+s3x28GByHKh7imC5Xsaqtaz7xRlBdsZDywE2qNet5aU8/tViwVoU5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW2Emqne; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4187481e384so6542275e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713212686; x=1713817486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PquhdbAvH+RnO1Q6+MrvNX/R6eKAwgVWRQQKrC0YQ5w=;
        b=dW2EmqneYkDTRKx8IYMKjQr7Pve0762Mu3jrcmXW+hJW+Yd8WEn2kBaslsP951aesk
         8fgyWndlzacz5htAez7K1aJGs7iHexVIfPgD/OlZ/SxepaqfoWGldTV9/T2i6loY/CQx
         CIaxeCZd4seZ0LY3waJqFlkuNiYpCMTCZR2kllNLGsWf8Qd7+tToV+vKYZ06uor/2TEX
         a8W8rik9KzMPcNZiy/ClKWDMaXj8k7ub25D4ZXz1XsjTbA0P4mdxzXZFHEIpPnPPJmIy
         Q3GqUEZjwRye66aZDi6Z75y0uhmeA6ZQpon14WiGzl145+jLTHCeHpSl8G0mWI7Ob4Ic
         +HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212686; x=1713817486;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PquhdbAvH+RnO1Q6+MrvNX/R6eKAwgVWRQQKrC0YQ5w=;
        b=wYhrZiSLGSjZVNS23Th6BD+44pGftf+zDuuyUqgHlZ2EoC8AifRp2L4XuVnvD7hYUQ
         gTk5H8szTHtEEl8AU45XxbcFcWayI96T1CL2x2DD3/O3gcZcfrCUcjCjn/b58lD83waZ
         cRO0phjAuysiI5UjAQuuxnW18Qaq2bb2uGEqXi6xB+woEKZbyCiI2ML9+gJFCV2zRRYn
         31HK8uGWplNZDfIx4o7uUqRDJ/MxGJMllPqxL49y6HdjLSY3j3b6jFa6BkIeZ7f5kIRA
         KphSPIaIdGjd0l1Y5OzWIiFBi6vcRC2XTgTRQWup9NvQd5pW5ougfD0duYhRiX0pZhTf
         1HaQ==
X-Gm-Message-State: AOJu0YwxtbdidY0lF2CN24SqpUP49y9fZB90KWnINgbQ7SB7OtBmQXO6
	fpCBuvPoMcfSCSahG50K2t7/P4rhpOJwQ7gobGVk0sz2tpW01694gRgNmbla
X-Google-Smtp-Source: AGHT+IG5RFywO6APPMf2XWoGrruD5tbiahxb8H1LvogRrKi3SYU4f8JD7TQcxf94RezyIb5qfJH3JQ==
X-Received: by 2002:a05:600c:548e:b0:418:792d:f8b4 with SMTP id iv14-20020a05600c548e00b00418792df8b4mr1569753wmb.23.1713212685568;
        Mon, 15 Apr 2024 13:24:45 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b004186eb69a55sm3767659wmq.25.2024.04.15.13.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:24:45 -0700 (PDT)
Message-ID: <1fe0fd6e-abfa-45da-8906-a2cdd2416548@gmail.com>
Date: Mon, 15 Apr 2024 23:24:44 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 2/6] wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
Content-Language: en-US
In-Reply-To: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
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
v5:
 - No change.

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



