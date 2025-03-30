Return-Path: <linux-wireless+bounces-20978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03929A75A69
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 16:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001C71889DDE
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DBA1B87EE;
	Sun, 30 Mar 2025 14:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpXz/1dc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B31EA65
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743346584; cv=none; b=ewDyJfxQSJnxOMl4a0GFzIIANUax5/Rf8T374cBpOkhJZQ/VH9nvkKNtU/dmoRhq9NK844lD6lwDOahGl9oQjap3/j9UUksYW4uc7eq4Xeminvnioqa8eNVm2dyp+CpjKjxcEE5GULGmxPRSs3YNjGFrVZzAPycnorHXOnHJ508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743346584; c=relaxed/simple;
	bh=9fcUdw29rbLGk3ahIfyKqXx6AxQpgvyyEGYnqWTIMgA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KsXXan8rVS0J4gED3ThIi/l2vJOeFU/TMx3b+DICYOnxaUPKL6DZDaxGS8De/E3xIrxBTMLHowcLsebELhYr0oR0zhin0CwJ3qWxU5Q8aurH5pd4CbTvk9o1aHCc7L83B2Xf7U7h1e7kiWGRRw6oKAg0BgsCxYOqkLzVaUIp5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpXz/1dc; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so5838595a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743346580; x=1743951380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DfXsGWvuKF/f8Xw17g38ZQdDEyNaz1J85VXPzbt0Wjg=;
        b=XpXz/1dcuJyVX5AZPHxc+1DvyGc+Cna5fl3XpDOFi5+B4X0lni0CCRRW2NpAje4vvp
         sa2g+RUNKvAsm1xjfFWJG3LseP1xf31gley7kKwBDQw2Qx52wjzTrj4S3rpNwlIGJXWx
         Q61D6KSiDgoqfZbiln+k1WVLoisf6Axjuq1zs4/P0Ej06I0yHoN8dyiALS8qSFUftzgS
         3VTy7bFksyiutwaSJkRJdva7YucumY8bz16iYBLg94WwmCcsCKThd8elKioAxwV8OD2I
         LDl5oyzooD8t4p6MeAkUSygZaFHiGpNHW3XkTaFXC4IV534yp7q/WUNMTEOVg00ks5ff
         i3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743346580; x=1743951380;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfXsGWvuKF/f8Xw17g38ZQdDEyNaz1J85VXPzbt0Wjg=;
        b=w3ZTslqibyFQzpyIzyciEhNyre+lAXZoD+RQhKMOwXqWUgiWxtB4Jfnvrb90qQPQRI
         OdLsqd5qwz8u0C5sMPm+O8lZ8E1ViWPStngpuZf959+AENELc63dHnuLqhHJpoJUz4Ay
         6QlCUUrkxle1XdhgELaFZsLJakYCFCAmZV2YTeotADoJYebq7CHaqjjYQZlPl4i5IBuh
         /Of61V3GN+GsZCd2ylrAfO5WPYAVzFg4XlR3hmxpJqUL2eA1UpGibjFVdNKp1h483gnl
         a+eOTaCKSqLSMGrudkdicKjsYDf/INyV76nf1u0YaqMBd3HAwrVUMnYU8cvkOVBrWi44
         h3QA==
X-Gm-Message-State: AOJu0Yw/9zWGeAQ5dSem3siLFAE1NVa3akECaqJSsrAAcH6JK9vlYMP9
	RV/NvT7nM+W22UfTUKpOn4BNjmiwIZpGN9Aqt8lTAIFoBWuNuCkfZ3/3kg==
X-Gm-Gg: ASbGncvdoXVAEqTXqXt6jalUaNLYtAQwxqzGw3SvK7Wwzzu4vx3ztNLPSm0Y7+Zlogy
	DbA1c22ETTg1U1ZGx3C+XHhLOc/v59w4DDeVItLUqoO+VLpuROY6QR/yr0QsBlBhTIYeOE3SOe2
	ra+kR2t5vJv7fzA3uzyxJbLpvL0GAgKreiJEaLJAKx4XAQd59n6D0eW54PMJeu6zEji/ed7TlNU
	eAwnq03ktNHVvUGOI8dInkH448WMNWV5/S+KKVx2jshdtLDyk9+rV0gN8OBVPHw9VO7PtFDLOLs
	PpTx3heBUo6LGuY4GPl0iohx4x9Gp1kYnMj5e31Y4DK2oRoKJ0pUmA==
X-Google-Smtp-Source: AGHT+IFYK4xMtL+vXFxidSSlRpw8LLUsKXnYH7ZAofFCJ8vqzDpU2nUra2e+hIZdL/pViF34h0H37A==
X-Received: by 2002:a05:6402:2714:b0:5e6:1838:e8c6 with SMTP id 4fb4d7f45d1cf-5edfdbff155mr4927409a12.22.1743346580231;
        Sun, 30 Mar 2025 07:56:20 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edfaacd006sm2817821a12.79.2025.03.30.07.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 07:56:19 -0700 (PDT)
Message-ID: <58edd8f7-76c0-464b-97c2-88db0ce2a897@gmail.com>
Date: Sun, 30 Mar 2025 17:56:17 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 2/4] wifi: rtw88: usb: Enable RX aggregation for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
Content-Language: en-US
In-Reply-To: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let the chip transfer several frames in a single USB Request Block.
This is supposed to improve the RX speed.

It can use the same code used for RTL8822CU, RTL8822BU, and RTL8821CU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index a78f59fcde58..54fb835e65e1 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -866,6 +866,7 @@ static void rtw_usb_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
 	case RTW_CHIP_TYPE_8822C:
 	case RTW_CHIP_TYPE_8822B:
 	case RTW_CHIP_TYPE_8821C:
+	case RTW_CHIP_TYPE_8814A:
 		rtw_usb_dynamic_rx_agg_v1(rtwdev, enable);
 		break;
 	case RTW_CHIP_TYPE_8821A:
-- 
2.49.0


