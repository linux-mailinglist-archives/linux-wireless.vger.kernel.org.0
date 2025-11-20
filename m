Return-Path: <linux-wireless+bounces-29167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD767C7476F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DEF4B2FBC0
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A89C347BC7;
	Thu, 20 Nov 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzgzvlfv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B70347BB6
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647808; cv=none; b=RHpU79+/iZ+OTdmqH4XN/pl+pLOE51qH3kXNyVNK2hxrDe8nnfp+YrXeR6ZGDzQ0hLmpbDHVKuhlQ0hI2n01jDC5NsBbBe6PTmoRBlZpZOEuJQHrmErHULqCs4mm17e67jBm612Fw0zzQJntgmpJhxcUWc2lGRz04GSold/SzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647808; c=relaxed/simple;
	bh=9yOmnCPDa4Tgo6LF3Rv1EiJQnd35BCZBrYDqUlMnuWM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kf60PSN6B4VhDHHZfphUWzweGbt0etfiYkf3jYK+ghBo/vQ+qnpzcjItof42RJ91Idb2q4jDJah35yht5PkTm4rioy5n8MxSfLb1SPODNvphBz62ByPGdawE5MyMqHkf/GyXyLV6vnWxOolE0R7GHFmMiU8DtxNUeQb8Xlpu1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzgzvlfv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so6287735e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763647805; x=1764252605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MU+liz4TT8KYn2BUOdt4y+OhlsI234OQEsdiZfpkg20=;
        b=gzgzvlfvy7WobJ7QGSmf/YaXP9vEyD1GWZz9w0liq7LgScoSO6xEfRFXNF0GjN56su
         3Ja77yCjztr1skZtStCActtLm3PAGtjMniWj6aYsFDPCb+o2MRVeuduMOMx1MXPSG3gV
         8dA3Onfw9SSXENM7/QZFPqpSD4o721T7BeUZdyyeIJdAj5Xpyct/Fj8J4+fc4ygS5zX2
         5X89pcJ9ANtTp1GiMfOiUm1ov7bTPot/j4+P1LG1Z3VMAKkcFeQyaAFqmtLIA93m3XCn
         QljTe5uph5izif3Y2bWClt6Ic2ML9m/0Ms8BN1AYgLgXbtvOAKakf/EZNmsFKRyC97fK
         UVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763647805; x=1764252605;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU+liz4TT8KYn2BUOdt4y+OhlsI234OQEsdiZfpkg20=;
        b=hhzJQF1IrTHgMursnK9izy6NHy7EpoZIwS8RxUh//vN4dUVqLXrw2af+/uB8QIwcRe
         qEbWHBn/sbV1hN1PO4MXjepXMN0zw2HbbFwkMhWVBwpfzsSQL0702/X0+vuNhzOZRsyB
         iimbQT3wtim9giMvrJDw9FHrLj13loCjN0ucRpZL6yax2u/394rJap+dv9cPLoTcoP2h
         +RGmNf3kwJU/vYmAh28y+AMg4iSG0mHmz99+vsLdHBf8j5yrQSRxuvEkUkOaInQQSHwz
         f3tzsJ6aFrz3mhTcaMJkmrKCPfMWoQIUo0lknE+WGTWpqKoE9P6Wgfa/Wyf2LnWOuWUt
         M6AQ==
X-Gm-Message-State: AOJu0Yxr0PAc05rXruglmn3tkMChogEF7bNtHWzFn/Pe6RVrx6DEsOZd
	loyqT24NPIoWbm7tBIjfEk3g+WHVFA+C8GdbhkChm/mh8XY0y/Dyfhp79OmOzw==
X-Gm-Gg: ASbGncv5YMeTIkdCBb8XAxsxKXGC8bPhS/BeQneFpD79BmaGBve6PH+MCCssp9zEixM
	Jp5aquJt02kBerJISRNUgBQKc/LuuBeXiUTAiw7WuvPcF1rzrnH3hjXsotqkZiI0HIAwJW02Yov
	6Usy9PIKAvZ+LOs4Log4bVXkrQxXuOlGRDTqYRX/T5BUqtPkOiaGIQvQKlR8GA2DjH2WKjxRryG
	srEtW2BwnUWfnm+EQ3jPt/BXtIKkpPpFZ/xaRblnAzL38QnDqq36A+8JhgBadHC8IjKRL+kTeey
	PYqlKBLIIkYWW3QgjuRO4npvX4glz7xKsYb90X528aJogBrEdWgwpntjYqJjSN4TY/R29nmya24
	h325ZzI5EAtUCavQ4vn4K3KJZVvai7aGpDvm771TuvDgWVS1UnE5+QSdKv8Et2PgO+nmlhVFXP2
	umES54g7ZMC/jbv43zByQ=
X-Google-Smtp-Source: AGHT+IF8Lb6meL71YWXZ9cqRzXx7CJKeuRmTm5orbDoIXsuaQZjWO1Wd9zkg26An/aMI+p0aq/AYSQ==
X-Received: by 2002:a05:600c:4f4c:b0:477:7479:f081 with SMTP id 5b1f17b1804b1-477b895aff7mr43088185e9.12.1763647804437;
        Thu, 20 Nov 2025 06:10:04 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e432sm5564940f8f.9.2025.11.20.06.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 06:10:04 -0800 (PST)
Message-ID: <1f46571d-855b-43e1-8bfc-abacceb96043@gmail.com>
Date: Thu, 20 Nov 2025 16:10:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 1/5] wifi: rtl8xxxu: Fix HT40 channel config for
 RTL8192CU, RTL8723AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Language: en-US
In-Reply-To: <c54a69c8-9c7a-4249-ac9c-8d6544483ae9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Flip the response rate subchannel. It was backwards, causing low
speeds when using 40 MHz channel width. "iw dev ... station dump"
showed a low RX rate, 11M or less.

Also fix the channel width field of RF6052_REG_MODE_AG.

Tested only with RTL8192CU, but these settings are identical for
RTL8723AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Reviewed-by.
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index d82cb7714314..be8ee6c30034 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -1252,7 +1252,7 @@ void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw)
 		opmode &= ~BW_OPMODE_20MHZ;
 		rtl8xxxu_write8(priv, REG_BW_OPMODE, opmode);
 		rsr &= ~RSR_RSC_BANDWIDTH_40M;
-		if (sec_ch_above)
+		if (!sec_ch_above)
 			rsr |= RSR_RSC_UPPER_SUB_CHANNEL;
 		else
 			rsr |= RSR_RSC_LOWER_SUB_CHANNEL;
@@ -1321,9 +1321,8 @@ void rtl8xxxu_gen1_config_channel(struct ieee80211_hw *hw)
 
 	for (i = RF_A; i < priv->rf_paths; i++) {
 		val32 = rtl8xxxu_read_rfreg(priv, i, RF6052_REG_MODE_AG);
-		if (hw->conf.chandef.width == NL80211_CHAN_WIDTH_40)
-			val32 &= ~MODE_AG_CHANNEL_20MHZ;
-		else
+		val32 &= ~MODE_AG_BW_MASK;
+		if (hw->conf.chandef.width != NL80211_CHAN_WIDTH_40)
 			val32 |= MODE_AG_CHANNEL_20MHZ;
 		rtl8xxxu_write_rfreg(priv, i, RF6052_REG_MODE_AG, val32);
 	}
-- 
2.51.1


