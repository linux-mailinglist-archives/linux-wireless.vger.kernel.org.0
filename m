Return-Path: <linux-wireless+bounces-6571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08F8AAF79
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657452842ED
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FB86278;
	Fri, 19 Apr 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQTgmdox"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EB1E867
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533781; cv=none; b=P7DWheEJepTOg5mpgYn0dkahFevsFMrOAAWIxpqvw+Ua8iSWACGvueT7GGLuTFVdPkdJVkCuo/82AflMbNQlm1C/MdygPo0SyVUJTfQTzac9/qfZ6J2EU0Q/Nm8v9t+X0544mfdLEGlxCRT1hP8bZPXlf7rKzZtW1Bpgr1cx+PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533781; c=relaxed/simple;
	bh=H/fDmkuWcGZE398ZUR+nuzSFjRcaUj0e7ji2syCM3XU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ltv43G71z0oEJ6lU9k8agaEY+0zas5KcKJaDXmGEsVPuFNA/lfYCrseGJo4mfjmT7wFhSBmK/PLMDbldF5twlnujepPnreRsb9SsCZC28fzuhq6MJdOKm+doUO6KaKAdjvyMMowfuhlR8OkNTWGqkEM9HoZaMGAY+mr6xxaCpN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQTgmdox; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so2080913a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713533778; x=1714138578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDN1u1MTA7i+7tP+k9O28kzd/+AN89B3ZIXa0MvQiJ0=;
        b=LQTgmdoxG6455TVf0AqTXp+MdEM9MoMHIvUeC78DLuWtecQT16PTnx/9+lRk6nRl1t
         so/bTsZtLUlPq2Adt/qs6uroQrcTCy0UD0uFfnCVaABS6DwmeoZ9Eztr3v7w9I/zZS51
         FpvIadM2g7r/c31bnF25zKjq1nYBskSIiGWiP2COgN/Rhr3Lg+WIO7/EzHiWV5wCIcg7
         NIzVCUmnm81sY/XJuEMGsXR210dqqqUnkyhm5AncHThZkA2J89pHdWxlXI5DjKgXdEgk
         7cSpQBZwIbq9wsqVu9Jx8CFgKPIYThEcGzH66zc8aVbZEljNkerpPTe3+CGdqWhWdC1y
         FfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713533778; x=1714138578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDN1u1MTA7i+7tP+k9O28kzd/+AN89B3ZIXa0MvQiJ0=;
        b=mtqNdqLvfSck7iebM8+KTZ1exxwJ3Qp/eyGOI+p3xdQntRwt/9zzePyZ2MS6tLEXUw
         HFnZFe+jrtz+A4imfVTfNHE7/bRWLXr9zN4Q0fhN5xZEXPUJ04QkYyM2zxoLf3m7291f
         p/PtuzMG0g3ICX/+ZNnNChlPEhSgO2h74z5fzKR+IpJ7hBpmrhv7+lXmll5PDfnvf+yB
         3UCkfM+xeLIr0Au8Mct5E9bf3m1UznRaU+el2YK7sAv7vqYTPJWn7XSw6bu7Bb4SmNyw
         ZLn9Teie73wzX2GzD6SkJX/ZkKMP7P6tNaGQ5xmohambrse2dZWesrngFxrOpU2YRNZp
         LcXg==
X-Gm-Message-State: AOJu0YyNGBF7tKNB5AHBvZhDGky5yYNn9v6ful1YFmSwgBPfJTABNTKg
	eynq5XsY21cKeek8I2gad5y9zf5z4Z9jtY8izNtUsV6aFDEhVGaqmXMrLBdl
X-Google-Smtp-Source: AGHT+IEJLM1VrhadbKVRyrf/m4to2eJnUGUlV8QphSKsaQrkUfMoni6/PQwgAiSw22YV6MfDw5xQ3A==
X-Received: by 2002:a50:ab56:0:b0:565:dfac:a686 with SMTP id t22-20020a50ab56000000b00565dfaca686mr1389459edc.38.1713533778104;
        Fri, 19 Apr 2024 06:36:18 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id d6-20020a50fb06000000b005705e7ee65esm2142843edq.56.2024.04.19.06.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:36:17 -0700 (PDT)
Message-ID: <86487e41-bed9-42e0-8ac1-ecc75f1a1f84@gmail.com>
Date: Fri, 19 Apr 2024 16:36:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 2/6] wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
Content-Language: en-US
In-Reply-To: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
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
v6:
 - No change.

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


