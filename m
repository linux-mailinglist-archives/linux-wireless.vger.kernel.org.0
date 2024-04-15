Return-Path: <linux-wireless+bounces-6349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97C8A5C86
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 22:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3081F21D90
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 20:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A515624B;
	Mon, 15 Apr 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5dA9U6G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC6154452
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214750; cv=none; b=HAXbgwhazv4XU9WGn48Wfy/peMnED9isvZiPr02Fa1rfTp4g1AfSDv/FQ4+rhSh47Cklnmg+Bd2nu/7BKtu1hN6ksyU0LBfU9Y5uwautQ7MuDlxtM1zfZhme+tZNa1fjr2jwCFqMQYItEMntP7fvbdT7BhLobjvKQzkaonyi138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214750; c=relaxed/simple;
	bh=kQN0kt5oVXpacVRwAEjqAK1YJVOvuB2myjA0tN0p3JM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=f8c2cwDKPs6A1OcmTTP3nuZ7omISYWIrgcBq6tJund/b5XFPXWx3f1tLjPqfC8vXQ/d68vSFL8ni+0UX5pmcl2cAMe8Sp5PbspSetd8d0+lf3jCYpaGmef0asm3qLjooQVomjzOFckr+4UJqUYm90zO8aZ+iER85WNAUzIGiOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5dA9U6G; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a526d381d2fso213346466b.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713214747; x=1713819547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plIeSWJsa7iunyh4xApmFLkqiJ1A+HUPE6O8GPAkAdU=;
        b=b5dA9U6GmJ6VCxlRfGRb8UpdxPHGL0sybYNBllbiMeu7rHxdc22tAZV+zy5Mtkk3n+
         j4HgCjYmMigfFAEKEI87cwPh4V4f58rig+0/gJXvEuMO/XrqMWGeDiC6BKCUa6LeDMe/
         1TbskThVZtg9L9Hfz2vds+/nfqklgWgUDcfGNQSASdIZ5QfyD572Z/GHK7To4d+3nfsa
         JsowlcJ2InbX9MFVyC9ZbxDWWWNVvNvtbLxKAhsL38K/zUpzvgrjRIu+BNN49hhO9Fab
         x4xJbSBsszbZ+8ZieKunzo3kE4H3qK8DBuP6sWZNONOPVFkaQa2z38umG8TD7bQxKsYA
         rPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214747; x=1713819547;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=plIeSWJsa7iunyh4xApmFLkqiJ1A+HUPE6O8GPAkAdU=;
        b=omUUSKZRzx4mj+oKk1NEHPbmOYHZR8F4ce8EHKO1fnIeOYtmfe9Ix6y+l0ZPrGlPIy
         uaI9CPQrhHZjZ80ctEk2K6PolJxVL8Qnt6n4FDM+Na+9Gm8xvkxDmjorKH2VhMWr12RR
         19cv7/Pr0honoGg0P/4TfEbe+BLbRh9WYHs2t8/gEf/0B+w3Gwp4Bjt9ARPXtwh6URW/
         Mh2o9rXwkRv80zMtWRCdEZjLXw8psIbcmi05YPhg0Ofs+FdnR+a1g64mCXrYCIW73L6U
         t9mmzZra5m5hOcyOtYa1fLW8xI69fWdchDivZhrjdsLE5n/3pAuR2HKyMXEBuNHlXR/U
         eZDQ==
X-Gm-Message-State: AOJu0YyrMfhJA99j2ncH8Kk7yfqT5rYWFZNn0wrWFEXVLrtV9GZ4s0j9
	F4dCB1VQjsbxo+pmw2enLUf8J1cx1DhQfZbyB/CcjuKRv3FZ1ZsGp1pyD0x8
X-Google-Smtp-Source: AGHT+IF3Eo9OthhLhCxbfNzFNuAGvI5sIsrC0HVKqrSx4Flz2Zr8SYJJ7oQV3VGzgu6NcVeAg4vJRw==
X-Received: by 2002:a17:906:3846:b0:a52:56e8:725a with SMTP id w6-20020a170906384600b00a5256e8725amr121625ejc.0.1713214747100;
        Mon, 15 Apr 2024 13:59:07 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090666d500b00a518bcb41c1sm5883941ejp.126.2024.04.15.13.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 13:59:06 -0700 (PDT)
Message-ID: <6ae5945b-644e-45e4-a78f-4c7d9c987910@gmail.com>
Date: Mon, 15 Apr 2024 23:59:05 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Don't subtract 1 from the power index. This was added in commit
2fc0b8e5a17d ("rtl8xxxu: Add TX power base values for gen1 parts")
for unknown reasons. The vendor drivers don't do this.

Also correct the calculations of values written to
REG_OFDM0_X{C,D}_TX_IQ_IMBALANCE. According to the vendor driver,
these are used for TX power training.

With these changes rtl8xxxu sets the TX power of RTL8192CU the same
as the vendor driver.

None of this appears to have any effect on my RTL8192CU device.

Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v1 was a long time ago:
https://lore.kernel.org/linux-wireless/52c28b65-6f28-2cc0-7281-179bb1087c2a@gmail.com/

v2:
 - Use ternary operator and max_t in the for loops.
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 25 ++++++++-----------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 7bf0bbbd52c1..af58e5b2c846 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -1480,13 +1480,13 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 	u8 cck[RTL8723A_MAX_RF_PATHS], ofdm[RTL8723A_MAX_RF_PATHS];
 	u8 ofdmbase[RTL8723A_MAX_RF_PATHS], mcsbase[RTL8723A_MAX_RF_PATHS];
 	u32 val32, ofdm_a, ofdm_b, mcs_a, mcs_b;
-	u8 val8;
+	u8 val8, base;
 	int group, i;
 
 	group = rtl8xxxu_gen1_channel_to_group(channel);
 
-	cck[0] = priv->cck_tx_power_index_A[group] - 1;
-	cck[1] = priv->cck_tx_power_index_B[group] - 1;
+	cck[0] = priv->cck_tx_power_index_A[group];
+	cck[1] = priv->cck_tx_power_index_B[group];
 
 	if (priv->hi_pa) {
 		if (cck[0] > 0x20)
@@ -1497,10 +1497,6 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	ofdm[0] = priv->ht40_1s_tx_power_index_A[group];
 	ofdm[1] = priv->ht40_1s_tx_power_index_B[group];
-	if (ofdm[0])
-		ofdm[0] -= 1;
-	if (ofdm[1])
-		ofdm[1] -= 1;
 
 	ofdmbase[0] = ofdm[0] +	priv->ofdm_tx_power_index_diff[group].a;
 	ofdmbase[1] = ofdm[1] +	priv->ofdm_tx_power_index_diff[group].b;
@@ -1589,20 +1585,19 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	rtl8xxxu_write32(priv, REG_TX_AGC_A_MCS15_MCS12,
 			 mcs_a + power_base->reg_0e1c);
+	val8 = u32_get_bits(mcs_a + power_base->reg_0e1c, 0xff000000);
 	for (i = 0; i < 3; i++) {
-		if (i != 2)
-			val8 = (mcsbase[0] > 8) ? (mcsbase[0] - 8) : 0;
-		else
-			val8 = (mcsbase[0] > 6) ? (mcsbase[0] - 6) : 0;
+		base = i != 2 ? 8 : 6;
+		val8 = max_t(int, val8 - base, 0);
 		rtl8xxxu_write8(priv, REG_OFDM0_XC_TX_IQ_IMBALANCE + i, val8);
 	}
+
 	rtl8xxxu_write32(priv, REG_TX_AGC_B_MCS15_MCS12,
 			 mcs_b + power_base->reg_0868);
+	val8 = u32_get_bits(mcs_b + power_base->reg_0868, 0xff000000);
 	for (i = 0; i < 3; i++) {
-		if (i != 2)
-			val8 = (mcsbase[1] > 8) ? (mcsbase[1] - 8) : 0;
-		else
-			val8 = (mcsbase[1] > 6) ? (mcsbase[1] - 6) : 0;
+		base = i != 2 ? 8 : 6;
+		val8 = max_t(int, val8 - base, 0);
 		rtl8xxxu_write8(priv, REG_OFDM0_XD_TX_IQ_IMBALANCE + i, val8);
 	}
 }
-- 
2.44.0


