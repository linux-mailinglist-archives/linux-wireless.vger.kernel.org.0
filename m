Return-Path: <linux-wireless+bounces-19077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E37A38FA0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 00:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355B9167064
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 23:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF54D1AA1F4;
	Mon, 17 Feb 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgegO3BN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F38748F
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834998; cv=none; b=h/GQrv8foSjf9nb7Vs4OeNU8hroUyR7adaiFwXzJ5kVT9S/GBm22BmLEOPBWRvevP+5u/d0+qmenedntruVL29gjH3qGJ/lY6J3xsd4Yi+7tzreAU/90tmDfqFz4Ls9A2vlc2niCHotNdEP+V6CYXjNc5WfS8xDnLDDANQmDix0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834998; c=relaxed/simple;
	bh=ObRENpelm1V9RBMnvyRMw9Qa4B6xC7JneM41L/v5rQo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Snd7mC1Y9CdRlZNxBWSYpuFWT3HyB/nvvrvTw3fp5kzofRVKFr80L+x1wzdne4i8ltL2y+Noj7Z3QlIreNTtM1v1SHXMN8nofJfC4Tr4sZ9GZFFNvytT+Kzt2J/pXnEaMbhBUr6MHbjJ9MqCm3BcP0DCs/FCYhp2h1ApO1rFN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgegO3BN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso838802366b.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 15:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739834995; x=1740439795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ss7xXIBn5ZqlmKZfmSDWl73Dfw49B4HhLbiWoBrZjJs=;
        b=lgegO3BNjLzHSL/TOkkxJkKnlVFMZdbPuO0scWooVvHh4x5c88k4OVFWGJF7EBW33/
         vtxu8P3k5M7lAX9FxJMnH2EReQFtmAz4t2LFbQ79KNPoERxE5vx4Oe16G8XpAAnJTDRO
         l1Cy4YQY8ZLrv0hS+Ck9eCE1jB7y9hijZF+ZdTC+dFzycR7ozCVAwVx9s04kjDuQSet3
         MlXNJadVT0igVmEVhECVf3L/tTPEtPoljSm7MWqwZme1Dig8MC02QGIFwoIr2sPlYVyY
         Z0D4ilSKENCbfMoYb2yW/1zH39uhE7M1bs/tVt+zSgeB8krjwDiRszRhIO1dAMgnLgLC
         7d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739834995; x=1740439795;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss7xXIBn5ZqlmKZfmSDWl73Dfw49B4HhLbiWoBrZjJs=;
        b=VafhRETVB+AmkdtwU0L3+2NzDgXT8jwc6MZEU2lGo0tuSx1zFzB5HBWZDvGtqlII2Z
         HRLQD13TdX4f3OMQN7SBdvvwui+JqZ3DJmjO/4EEiyDGCatIQZj9FBgd/HbZM9A5eR0i
         mx5nakfWO2ooDItSnYBaR/IYZ+XGvRv6fH6HMMmKIXQTaiSp9gKgnww2pYoJHApUUlQf
         Uq6LiJzwGX8wPNMgq8nX8+ZKwdR8GbblwwGIJBM05f6avO74NZKxj6AgzajrLIDC7Frg
         xX4w/VV3yklGygaksTtN/vCEexRfp1MjF1hb2I0fuQSroNrvmSfMlRfmFr5fH0peIjUv
         WtcA==
X-Gm-Message-State: AOJu0YwAZ/IZXLflRGNBZFq4R449VJI2i5QKBRiE2/h3Zgvn4c9wzeuu
	1Q/eVNVuWEfXt1YPCmJq1oiStDZtzhEq3HI7mi7M/kemLHdckOCqZgmf0A==
X-Gm-Gg: ASbGncufb16K7LxF6tWqCY+phwLipW7Bu/hK9WVyDtMBp2R2JOPau4iE9eFd4g7mNuv
	feqPr+eUu+Jy5+w+2nOx2iF9/d48w45cMkv0muhap8ZdisHVutAJ+A3D84+XBW44ILYLThfAKir
	GxppY6HUsA297/fXAtEYSyR0SzaYUIO4AasgCUE4g0Jlfi35hU+bgGrev5heHwQkjM9TRrov2tY
	6XR9HERPQznw1PR1SW26fHr2Z9+dbHwhPNM/h8TwWU+DeNZtiKiDA5xt1klHdWc5C2WD2gLsV95
	tcadmTx8Fd1Mrsh1kK8JkWK3
X-Google-Smtp-Source: AGHT+IGmFvmeq5EkU/AhK6W/KGM9aXDjql5H/hFuUQGbKnBJJEmlUzXIn2ut5UsdRVZZUmbn1jWTFg==
X-Received: by 2002:a17:906:6a03:b0:aae:8495:e064 with SMTP id a640c23a62f3a-abb70d77263mr1268098666b.40.1739834995056;
        Mon, 17 Feb 2025 15:29:55 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53397f47sm953858766b.127.2025.02.17.15.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:29:54 -0800 (PST)
Message-ID: <d0a5a86b-4869-47f6-a5a7-01c0f987cc7f@gmail.com>
Date: Tue, 18 Feb 2025 01:29:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle
 MCS16-31
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Language: en-US
In-Reply-To: <3908a496-d687-40fb-a1af-6add5c7e1dd4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This function translates the rate number reported by the hardware into
something mac80211 can understand. It was ignoring the 3SS and 4SS HT
rates. Translate them too.

Also set *nss to 0 for the HT rates, just to make sure it's
initialised.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Set *nss for the HT rates.

v3:
 - Set *nss before *mcs.
---
 drivers/net/wireless/realtek/rtw88/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index e222d3c01a77..66819f694405 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -101,7 +101,8 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 		*nss = 4;
 		*mcs = rate - DESC_RATEVHT4SS_MCS0;
 	} else if (rate >= DESC_RATEMCS0 &&
-		   rate <= DESC_RATEMCS15) {
+		   rate <= DESC_RATEMCS31) {
+		*nss = 0;
 		*mcs = rate - DESC_RATEMCS0;
 	}
 }
-- 
2.48.1


