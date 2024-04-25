Return-Path: <linux-wireless+bounces-6867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0C8B27EC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 20:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA97A282519
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD52814EC76;
	Thu, 25 Apr 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMN02cCo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B414D457
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068763; cv=none; b=holiQ12yGxolQTEntqikelOjU61+IEud14fa1/vx96WUSTmhXZlkKddFLsmJQpwFgSGdXLWFx4vHLkB3GVVoYwULyplaj41LO/KJszVryrrUu/xb3uSQuj1PwGK7bq8aiJkO4NZdtmu0gWC4B+9D/KK3UhwfzYspzSasLdcAWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068763; c=relaxed/simple;
	bh=xqx1Rj1VRgZWpA0YCcAdbFkSzFb2sfbxZ2k6i+FZYUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UFmK/bnyEtvUHcE57AthbcUt15vqUKqJbBKeJFqWUHj0jq0HBFckiMk67CwfTZ3tr8TW54ff7em+IuAWuqoRhlFIZBNmn/SGLivVGMo91rqGnFf0oPN6bWr6EatDAgokI5BsxJ6jldf15tBWX3PSJQpruImXYmSxkvxCokY8p0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMN02cCo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a58872c07d8so442806266b.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714068760; x=1714673560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnm0xCFEJQ3UzFjtfrIg2RYR7skrcdN90SRk/A7sNi4=;
        b=QMN02cCoZOHF10Vrq5fzwLqiUXWK1tTneS74He7WFvlqoZ1g74X2XJXhWZ3VoAWFzf
         eB+IRYX0TZtoUBXkI/Uegee2Ao9eTmjuZgRoC6hqkkJY9GkvE+WY5bafC4Se8eP447nz
         QypgLf5FKUVWCLIJerOhbYJs0zb4l0wSpIwBtCRSousNBuFaLZ0av+qcGr2cgG2DVHQQ
         4SeVS23U7+S29jZlzFTWTa4+4rnmUQ/B4d/+OdZRCKcqCa6BA/ZZ0xImsQWLlOKjL4Gm
         0fkx0n/HJQmkGVRk5PHc9z6rdQDuGSaOtmuVd/VfeGw3gziyxrnJEZvszVXqezJp1YLo
         w1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714068760; x=1714673560;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnm0xCFEJQ3UzFjtfrIg2RYR7skrcdN90SRk/A7sNi4=;
        b=GIjG29+zJQWIgHEL2LY/KIaotYy+QP98SoPF8vQ5miyL29bXzOn47Vtxg4LFDz88rR
         VP0SLisbb4r4CRrjia4JM81VtUKZnX8ynXUohrUfXuLeCRllMb7Umifn05JbCZQKP4cT
         EIr1+gLIKax7Aa4KWce/C3cad4NFkDqj2qM2Lm+bFZbNw/4zg5hnCh8h11vcQ9t9n39R
         uMYuIx4D1snnZxQ07ZxdD5Kzo8lyrJKvWgLFnWmgn42ZJDEPmzONE6PoaB10BDWMYPin
         qQbcmMOjGYl47WnAl2rJjPT+6XxWeP4673xW8n9UdWfrBKz0z7QB45BB2BTzmMymmH+H
         w3+g==
X-Gm-Message-State: AOJu0Yy8EIXAS8WO2cTkGfb/RurM4sAhCxvAoMCv0H97NfZo/jQSOvSe
	Db+qeLnbh37I4S+Vcm7ZmXduumPZaTl+fB1pw4pCzYNweJCQkpfitG8iq3al
X-Google-Smtp-Source: AGHT+IGE1M1mpT6KQo/7PKv1kJQIrUgaEfTW0sR1QooAautaYB+SMyPNVHVScFMC4nxQFADVraqWDA==
X-Received: by 2002:a17:906:b341:b0:a55:5958:cb00 with SMTP id cd1-20020a170906b34100b00a555958cb00mr3207004ejb.38.1714068760530;
        Thu, 25 Apr 2024 11:12:40 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709070b1100b00a558206b2c5sm8617656ejl.99.2024.04.25.11.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 11:12:39 -0700 (PDT)
Message-ID: <4d600435-f0ea-46b0-bdb4-e60f173da8dd@gmail.com>
Date: Thu, 25 Apr 2024 21:12:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 2/6] wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
Content-Language: en-US
In-Reply-To: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
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
v7:
 - No change.

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


