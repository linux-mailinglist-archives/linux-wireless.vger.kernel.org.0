Return-Path: <linux-wireless+bounces-21088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC42A7922B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E769416BAAE
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3F1FC3;
	Wed,  2 Apr 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0ZvoRSx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE078F45
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607809; cv=none; b=XXzF9jI9EsveV83RGB5JLmshCv8t4qxoIoGvKwsTX+LCsVPNfcdJuiwpzqBqVC+V8biJYfThD+eyvy/cjmMbhh05Ru1EVaXtNuAh8sB7XV6aYBZ+ZuSxe/S3CV3xdSWndOAccLl+cBIhaf3CrD8soLGf5bRsc9K8brOk1nz7IG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607809; c=relaxed/simple;
	bh=1h4SzRexHYVNROVlbnzfDohEzMJ9KH0KMDkREUwmeaM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XmOzOczsdhXiULQ0pkgWva7Xj0U6kHwZz4/QdVewBJrlI9vkrd0M7zv1h0uGCvwTYikA6Ye5Wq0wXBhitfWs111mtUjE8lrQvn+oDLeeoSBaV/U9QrXJVPTI9tfXLzxInBlQTucW4PpgU02dcxtVesCmtKf6Srn+g1hwIrXgf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0ZvoRSx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so12899337a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743607806; x=1744212606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lNN2C6Lw81HiAEOn4QUZUVpsWka9DrVA0E0zTnuIz7o=;
        b=F0ZvoRSxFxqBwJ9mZg65HEj7Vk5O2gQIICqIc+1/fRACXiJ6v+15RwQZD9ZvU/Ybnp
         EYHGYC88WYP+LgSh7XKd24Z/+etkRkNI2ovF31c/sPGuuKIXzQmbHg53TiFrT6k8JyO5
         qMaPEbHYFPtRrZ2DYNkdlKAhq/l4PUW0vssFTkgHXevPLQmXKik3Uh9Q3SeXxgd/oooj
         eUA4nZN8GGrbdXtwYG9Wvvg/onICxIyKcpwJeWG5MgE7Pbh56A9J2l+8fBIsOt/y7Yq5
         mJe2PwZz2Mbz+pKLahKFJijETKFGY/3FztzeLLcs7M6CZN+rCuUYnA1RIMaorwIdWIS7
         uKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743607806; x=1744212606;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNN2C6Lw81HiAEOn4QUZUVpsWka9DrVA0E0zTnuIz7o=;
        b=rNvp/ik2cf3cq7PrN7WCkLaC8YAtdDDdu6sTRMXpbXWdejPsq6nLaG+pjk+DrptCMa
         zn2we75KUXZZ07oO2tE41iQKErXJSSoT13tciQdjms0uTRRBPIs+/KAbkkSVNOpqor08
         +k0xB0YPbvRQFFyBJRiiPLR1EOHQIIaiSf4d2XeC5UVRxotb6RuN9aLrYFiF+fPdKusE
         98DxLbG/lRMffDZ92HIsKY0GChxpn6v0uDWV3JaBU1WEv3KxOMXQKM4VnqdC1oWtmUcy
         Q4z5rVWcra9XLrCzPOApJHSQ77CdB11kJPTJ1Ue4VB15+J1uw9kT45YJiXxPebibh5az
         us+g==
X-Gm-Message-State: AOJu0YyusbKkuAdu4BArCVmkZPSmrwa+c+S3/umfoa84Udy8dzwvJO2Y
	rzj1N/r7AUl4znnrstiBY/M3m6/nNmSdjxngkJDDhP+a5ZNblevzRIxruw==
X-Gm-Gg: ASbGnct1cQBSEbZQ3Z0nEZOYmz1H/8OsT9BYoKdw+aCJW78ZlXxMRG9xy0f9Xw95rto
	Nqqbw5xck5EJULenIJiKRP3jiwcc7iEetv4dRpyJmseyZFeoyGZxb5A7ikztJexe07Jwvsgqt+o
	cl66uoPTYpgufpjcTIPh0yHtxieb1n0VoMXI/k8WIBxwpqmGOIgSM99EiOpi8lP07sV1IGBkoK5
	Ur7VWSe48rPDfRMp9j8JSJcQhdZ0iOXuTlTyNR408aiLl98hUiuOpumZVbLOCTsCj6KEhJ3+GQV
	h89/PYtMdWEFoZAUERfn6bEPatmFiDl81u52BdSt5rnWUAhxdBQcwg==
X-Google-Smtp-Source: AGHT+IGkTfS9VxUYndSDypO3N6WqaxiJaX2izmoLeMhOPdWPa70MvfWdgpMxYdT4GQGfCQM3/PLVEw==
X-Received: by 2002:a05:6402:524d:b0:5e5:bdfe:6bfb with SMTP id 4fb4d7f45d1cf-5edfd0fdba1mr14503255a12.16.1743607805901;
        Wed, 02 Apr 2025 08:30:05 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae4bsm8634055a12.1.2025.04.02.08.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 08:30:05 -0700 (PDT)
Message-ID: <d3608f70-e04f-4f6b-987a-022c8e317165@gmail.com>
Date: Wed, 2 Apr 2025 18:30:02 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 1/4] wifi: rtw88: usb: Enable switching the
 RTL8814AU to USB 3
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
Content-Language: en-US
In-Reply-To: <257632d8-4347-45bc-ab39-4e88d87cdb3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Realtek wifi 5 devices which support USB 3 are weird: when first
plugged in, they pretend to be USB 2. The driver needs to send some
commands to the device, which make it disappear and come back as a
USB 3 device.

The method used to switch the RTL8812AU also works for the RTL8814AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.

v3:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 667473b7a9f5..4994f5934e80 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1092,7 +1092,8 @@ static int rtw_usb_switch_mode_new(struct rtw_dev *rtwdev)
 
 static bool rtw_usb3_chip_old(u8 chip_id)
 {
-	return chip_id == RTW_CHIP_TYPE_8812A;
+	return chip_id == RTW_CHIP_TYPE_8812A ||
+	       chip_id == RTW_CHIP_TYPE_8814A;
 }
 
 static bool rtw_usb3_chip_new(u8 chip_id)
-- 
2.49.0


