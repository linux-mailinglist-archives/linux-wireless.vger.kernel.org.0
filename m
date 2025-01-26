Return-Path: <linux-wireless+bounces-17982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C8A1CF0D
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 23:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2357118869BC
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 22:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D651C42056;
	Sun, 26 Jan 2025 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJmx/uLk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFF5672
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737932127; cv=none; b=BsjRpyjO6+1nlqmYzJIovcc81asbM/0yAtDs4X+/IOsFYZeyNqJ1SVPnEdNqR7aGRmxB2uzfmRogLXkFnSKPjTuse5ajploE1RamerbuvPNAcfgaS0n9BbSc62pRsxrc4xnYFdD4rE0xu0pxe/PiLbOo2HdTmKeosbL2KjnZxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737932127; c=relaxed/simple;
	bh=0NjwfEV7c1Cnl8JJC7l6mj3K4B1jSXL+l92ARzj655g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sglDQLLQpyyhmrKadb2/bLHSJzZKmZg+dufhWTT1XwenKWMPSn0ItvpCvpuKcx7UxS9zSBjh+KWJO2Qu/rxxAOOjLOBUJCmpfMyq6nzH0IPX+sVz42ybyk8yJWxGprtONF+6Appi7RXh05wGTIyLAMdaZybpNdeFUeqG6RGrUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJmx/uLk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361f796586so41421145e9.3
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 14:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737932124; x=1738536924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5EtVVmXK9RUn9c7FB4vD/ZeyH2PJH8S2j7sOqMdv61c=;
        b=JJmx/uLkHkmm+0EwgZFAY+5k5GIpFXMERsLjmGiNx7q8o8NIIxLVsD4VB3ZXmcwyLF
         kl7b8Ac0Dqc0caEr3A+nhmPBAGGZIM2pfF64ZvRy3+Zlb+UdZ9z1gTBBovw8ZLsYPmfx
         OkhfhB0TVOUysC2lVmAcdqF/Al4CUSxdHN5qPaV8lyMUe/QZtFh+NwS323vuthkawIf5
         syK+BdXDFF1RL7ss3j/YsU0NY6JIwAqsjP3TssxOX0ZeQIQ0TESfK8dH7ZPgG1WBKNbf
         dlKGT9oevGYSQhpziUo0cp+M//Gd76KTf+p2P9750NG786aSoRStWW4QqRKkGfV9gB2s
         vgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737932124; x=1738536924;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EtVVmXK9RUn9c7FB4vD/ZeyH2PJH8S2j7sOqMdv61c=;
        b=Tiv25CmXKwtS+c6DhxtOHZ5I8ebh9OaKN0mVgV6WG7LH+UQ8fxqJwcVvHfQvfs8J+0
         QP8sf5FymZ318Bl/ZVYt7+hEI25qI2rn9vBhIjShuSFdwgYe9p6W9amYKGKSVgh3jCgR
         vl2Kn7oyniuJ7lXmhVqYSSkOJ9iA8FudBMgnvT4R7YPX2y47VFMm9KwhBP52TCH7gfNL
         G9wbAceLND6DsxP1G60wx+GYpZI5vHQa+9OV6bcp9GmOI233Fz3LXSyrUqMfv5vlOq+7
         h8xMBB7S8xrS2ob/HagRvgRedUO6I5Y44kThZyIyJKiXs09724pw3WegWqBm/iMj4kac
         jbyQ==
X-Gm-Message-State: AOJu0YzGxxoZTULpmyJM5Kehz9mE6w5NuosEg4Y5RUPmTfLdm8VXSFE6
	JqoaRL6zOKNMIuxEaQkKPTaM5vP2BvQhqyKsIpiTvD8YDDKAXDvZiEFXUQ==
X-Gm-Gg: ASbGnctTgLnH/xxuukzLxp161Cqrr4t+uq4R4jY40ootY/MgS44cmUPPhZf1vphOPHs
	qvLNuAWq80Udzj1TL+vFYcdTNtPiVhCPo15eJElAdRsfDVJD92EuCTN3AbWLWUDKZfyHfO9BfZA
	XBXnI6HIIyYNcuGJJfiMy0NeLTikDwFiYn3oaax5CC7lJLLWCKI907p9y6Y8EQEUYpqoRfespy4
	PWa3Z2ME+TPsPM89RDd7PRjMMWwMegiKyFVoduOUUYrm3wuruMDxiNp+snVKu8MoXyDVkgrg6i/
	JalRfNx3P/px
X-Google-Smtp-Source: AGHT+IF7tq1ByzF6+fk4airyca8eaR1tiwkfRo4WOuaIRtk6we6C/bngkBwwA15SAdSGHo0F7QZmOg==
X-Received: by 2002:a05:600c:46cb:b0:434:f0df:9fd with SMTP id 5b1f17b1804b1-438913c5b82mr354946865e9.2.1737932124307;
        Sun, 26 Jan 2025 14:55:24 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd508257sm107223215e9.23.2025.01.26.14.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 14:55:23 -0800 (PST)
Message-ID: <02424d4b-96a8-4c30-933c-7abbefc520c5@gmail.com>
Date: Mon, 27 Jan 2025 00:55:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 3/7] wifi: rtw88: Extend struct rtw_pwr_track_tbl for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Language: en-US
In-Reply-To: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently this struct has the members required for chips with 2 RF
paths. Add more members to support chips with 4 RF paths, like the
RTL8814AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 62cd4c526301..e40e62302984 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1130,14 +1130,26 @@ struct rtw_rfe_def {
  * For 2G there are cck rate and ofdm rate with different settings.
  */
 struct rtw_pwr_track_tbl {
+	const u8 *pwrtrk_5gd_n[RTW_PWR_TRK_5G_NUM];
+	const u8 *pwrtrk_5gd_p[RTW_PWR_TRK_5G_NUM];
+	const u8 *pwrtrk_5gc_n[RTW_PWR_TRK_5G_NUM];
+	const u8 *pwrtrk_5gc_p[RTW_PWR_TRK_5G_NUM];
 	const u8 *pwrtrk_5gb_n[RTW_PWR_TRK_5G_NUM];
 	const u8 *pwrtrk_5gb_p[RTW_PWR_TRK_5G_NUM];
 	const u8 *pwrtrk_5ga_n[RTW_PWR_TRK_5G_NUM];
 	const u8 *pwrtrk_5ga_p[RTW_PWR_TRK_5G_NUM];
+	const u8 *pwrtrk_2gd_n;
+	const u8 *pwrtrk_2gd_p;
+	const u8 *pwrtrk_2gc_n;
+	const u8 *pwrtrk_2gc_p;
 	const u8 *pwrtrk_2gb_n;
 	const u8 *pwrtrk_2gb_p;
 	const u8 *pwrtrk_2ga_n;
 	const u8 *pwrtrk_2ga_p;
+	const u8 *pwrtrk_2g_cckd_n;
+	const u8 *pwrtrk_2g_cckd_p;
+	const u8 *pwrtrk_2g_cckc_n;
+	const u8 *pwrtrk_2g_cckc_p;
 	const u8 *pwrtrk_2g_cckb_n;
 	const u8 *pwrtrk_2g_cckb_p;
 	const u8 *pwrtrk_2g_ccka_n;
-- 
2.48.1


