Return-Path: <linux-wireless+bounces-18963-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B45AA370F1
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 22:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC6316CC41
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Feb 2025 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B671F4185;
	Sat, 15 Feb 2025 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghXp9jPY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BECEE56C
	for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739656768; cv=none; b=XYe4W4PwxFxM5wb45gw+8jI0yMOw30hb1YSiaYpnTf79RwheOgMz4aFizUp6hTg97IQMOKpw8efnYCwVDX5xX93N5vjj1if3ugfjlLQWFfKSJkODjVvhARahC11J0/KqABAn77IxJ90Z82gEHTYf9ueG9D71Nd3CUujbXegMejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739656768; c=relaxed/simple;
	bh=lpaIeRy5838Rysfr9zYAhfeANwvaxqxLzWRBATGFemY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MzFQ71JW1U8gRyUvRvxjwkymRkSGkVLThpGO9EqeHcGuXKL9goeYjRvcxJ14aeVHozQlQucD/QVLjIYOzhsJkthQoBLfc6ccu3djyOfFUJ9Kg3Kw/2hzOGrsKrpNipTTCn06fQE/jr2dgYHSPOGVer2rzzHSQOjJYEwYYDrZPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghXp9jPY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e050b1491eso52327a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 15 Feb 2025 13:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739656765; x=1740261565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N9xT4cuLlJ+K8+8PmJXgCZwV44cEbTnclU9WvsKTO0s=;
        b=ghXp9jPYVy67GpMCyY4Jwy07UBYNzPwJ58KBA0uyGO2j7Yiz0fk+4vL+8KEbNkVkrI
         wC9JBptFfL6zE2bHiBBH3L2z2GQ3d3rU+Jn0rXHkq6mFJ+mbPkbaK/v5+LQGSBi4Qv3G
         RgqcEjrrm9K63FZocKSnQtGiYIWKc4lzKumfHCx+crlWlB4p4+UXMriFiOBd456bvYFN
         2WIgYdidg8XK45jYhHhFLG3V0ZGIH2smjNb8v7gIIQ/B6stcy9UhoHmEnszG6CSCvSs5
         fi2bjdHObP/EJK3DNpiTeMKUrS1FOoSFyyJ1pPlbat+bcKVUZPsTbnCi0h1WYsHd9sFD
         QtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739656765; x=1740261565;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9xT4cuLlJ+K8+8PmJXgCZwV44cEbTnclU9WvsKTO0s=;
        b=mfYefFwb/va5bbRr5ThdMXh9UYrS8fcjt7aUaLwqCpZewzWUyK5vYkfLoEWQifhpET
         9TR/qt07T2F7l1kT0U8B6BtdHZgD0eLpxBZMFjMJKaa2J8icCC+LTJl/9vNlRJ6+8o6N
         fMbkkQdkpfsjor5DWJiVhqJ3Htq6V6qXLJwBqX6Y2BBqaRFvN+b+hNOv/GgZhIaTi71Y
         z+8HB97g8nPYSp9YPQmPrBxhyvuhaaCfJnpTTs0Pp+92j4hVB46VwugqvoRS+AKoSU6Q
         kv8pt179Bagn4hL9hMvxkF7O5GUCTYnRAjTjq9+7pC8JYolIkt7OZ7foj5AX6tiww9uM
         oguQ==
X-Gm-Message-State: AOJu0YyVhYIT+LcY8te5ekS0j/+FvmcTvVH/BbkBchUFFpwEm9azzzeO
	x7iaOmObV64OhLfRxQiC8rxgEU4y6XlMVPSGSSk4redChFiCTmti/hfy3g==
X-Gm-Gg: ASbGncsBMu3OrEvzXbN+++gyX33iYOlGezMwD5bWTwW2sz8hatmBdV7aCcpreVUVRrK
	xUM9b0ClivUfqQ0bPjZVEM9qbHt8hsTR31WI9c9cHa6HLvAHsS2bjiGlCaW7jEBpCTsjggfhoLB
	N8TWsZkESELtZkKNcV4gldo1Ze3niDwc2k/8LWgB1XdTCe+dRtm1x8CI3/Mu6CPR+F1CBmSG8RC
	lcY8lYepmDM/79v9EbZ3Oifa+86jPObsEOKqwK+ZzpKB+0inde1YlqnexDWMAwR/Kve8M47Ji82
	wjJ6TLm7hejOvT+ruu4pYJZ5
X-Google-Smtp-Source: AGHT+IHw9A1kPSMueAIPZ5zgJtUMTrzOBxZdC8xCr02//0uusUNpDfIzxBNq6PxFVeDWut0wb/NnDg==
X-Received: by 2002:a05:6402:42cb:b0:5dc:92a9:8a5 with SMTP id 4fb4d7f45d1cf-5e037224506mr4175744a12.6.1739656764532;
        Sat, 15 Feb 2025 13:59:24 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4692sm5023359a12.31.2025.02.15.13.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 13:59:23 -0800 (PST)
Message-ID: <9bb25bb0-ee46-4390-af6c-6bbd9edf3121@gmail.com>
Date: Sat, 15 Feb 2025 23:59:22 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle
 MCS16-31
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
Content-Language: en-US
In-Reply-To: <12ab9180-45e9-40e5-98e0-6ef7b6c463d5@gmail.com>
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
---
 drivers/net/wireless/realtek/rtw88/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index e222d3c01a77..9baafea65d64 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -101,8 +101,9 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 		*nss = 4;
 		*mcs = rate - DESC_RATEVHT4SS_MCS0;
 	} else if (rate >= DESC_RATEMCS0 &&
-		   rate <= DESC_RATEMCS15) {
+		   rate <= DESC_RATEMCS31) {
 		*mcs = rate - DESC_RATEMCS0;
+		*nss = 0;
 	}
 }
 
-- 
2.48.1


