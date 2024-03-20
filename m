Return-Path: <linux-wireless+bounces-5025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DD88817F1
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D03281558
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A85026C;
	Wed, 20 Mar 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUDl2SZm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A010FF
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963217; cv=none; b=i+QmH7/LbCXcDRaFzGCSOYbgesG30nFOKB04A6vb0H741ViUEWF7bOnh9ANvhbXyZ5lUWfxG2SoSVA3SVgj4OUfcLeC5OXecSUTh9FG7AzZV2pzTsD58WhkRRRMUr2Ui6yxaSf88NgGaBZjupoR3kh3G5yo0dTkRgljQF3NRfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963217; c=relaxed/simple;
	bh=6gAnxmNesU0m4oJQJqLtEem85jNA+ioiHrPZ1OiBMFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C6TDJ+CYDtAN9YusPAc3JWAb9IDWABgF4G6sqPL6mV3dnBqSjin8IpT/1HVdX73TrQkushjTeP+SLJNAsP9i6Y9goZMAuJwTJIEMTQ6yUviPzx7QOcekcHw8PXS0UG/mkQ2D5WQrXlLbqbg6R4YfVk7XOKUCIrWk6Le/dVtrXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RUDl2SZm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4146a1ac117so1717945e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 12:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963214; x=1711568014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G6G9ga9aBauTIUuVk4Fdva7fQHms204p0KIBOxtfITY=;
        b=RUDl2SZmlaVzThApnr26UcuvrsTcEUgPGkLDCPLNzlTOgFKdX2CahzGW58o7q1kZe2
         3bG+pjy5Z8STcZ9TylDBnHAl+891WmrB98R0fLV2+upq7reTdqYT1k3Pizhs2Q44pphL
         dWAi09trqFwiRhOOPa9dG4ygVE+Au9bHYEp5vmAEAcYl8S5Y4VHYlUFNUDLp4qkXOg3G
         H1HrFGs93oQ1as57QcFnD6XsXSD+wRyMQZbOGvjA+mOmE3Gb/u25DyXYqSkwXOBcGuXj
         s/uiFscOdAgVqSeFk8pWUh/1A2JwFFJKDaL4S8rdK5YfnNzZeqr4Y2Zrp62MzsO61X+3
         KZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963214; x=1711568014;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G6G9ga9aBauTIUuVk4Fdva7fQHms204p0KIBOxtfITY=;
        b=Dm5pGJiibjqdWUvAynQjTO9EEChxpSEMHpxwS8/gJ8kipaHWyXX/SNJ7phTNo89q/Y
         nc5k9TN4Byqrh2aPkGfIb/Yke4c02kq+E4y9/1depAI7o6gVyOodEgXGBud3B8V1ZTe2
         DXAxGGlqDCnvesSA5xk6kHMj+jidUHumT38bYESEmCZ6I2KQ6Exvd+Jv/LrcqlmtO3g5
         2d4OYF6lavgSPR8reoy5TfkBdfMXp1ANnKHiAdEe74BNmjImeTFrl24nfUxO82L+7Fuj
         n2KmsXS882Y10+fMq8P0vXVksNx8ieuZ97lQAa1gWri21aIbqYydTT/SYaMlwgovNIEF
         Ekcg==
X-Gm-Message-State: AOJu0YyX8R+qru01JvuHfB0+QqvJw5nMY0oKNd2evqePdGiJRfhpz8KH
	XTT8t3MGkOdsmb8GALbGYyne9xAXXsBAGDGHFGe+CwsTFrfu+TO7qNy1BJGj
X-Google-Smtp-Source: AGHT+IE8J4fyGGk9J6AEWFWnU3eVX9HZO4iuAPWr9ejG9NUn/UZMRj/zjZ7+KXC0idtnnheD13djTw==
X-Received: by 2002:a05:600c:512a:b0:414:6d7d:937f with SMTP id o42-20020a05600c512a00b004146d7d937fmr532668wms.4.1710963213923;
        Wed, 20 Mar 2024 12:33:33 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0041330d49604sm3176610wmb.45.2024.03.20.12.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 12:33:33 -0700 (PDT)
Message-ID: <bc6da9fe-f6e1-4b00-b776-72c9d845ed4d@gmail.com>
Date: Wed, 20 Mar 2024 21:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 01/12] wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
In-Reply-To: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Different channels have different TX power settings. rtl8192de is using
the TX power setting from the wrong channel in the 5 GHz band because
_rtl92c_phy_get_rightchnlplace expects an array which includes all the
channel numbers, but it's using an array which includes only the 5 GHz
channel numbers.

Use the array channel_all (defined in rtl8192de/phy.c) instead of
the incorrect channel5g (defined in core.c).

Tested only with rtl8192du, which will use the same TX power code.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - No change.

v2:
 - No change from v1, which was originally sent separately:
https://lore.kernel.org/linux-wireless/9995b805-ef8b-47c9-b176-ff540066039a@gmail.com/
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d835a27429f0..56b5cd032a9a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -892,8 +892,8 @@ static u8 _rtl92c_phy_get_rightchnlplace(u8 chnl)
 	u8 place = chnl;
 
 	if (chnl > 14) {
-		for (place = 14; place < ARRAY_SIZE(channel5g); place++) {
-			if (channel5g[place] == chnl) {
+		for (place = 14; place < ARRAY_SIZE(channel_all); place++) {
+			if (channel_all[place] == chnl) {
 				place++;
 				break;
 			}
-- 
2.43.2

