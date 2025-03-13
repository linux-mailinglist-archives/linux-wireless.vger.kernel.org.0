Return-Path: <linux-wireless+bounces-20351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63990A6024B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 21:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34E216D3F3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E1B42AA9;
	Thu, 13 Mar 2025 20:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjwUEoe3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F71F4297
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897008; cv=none; b=luPEFTQz/HxCtPvBb+3vnaUG5ofctTJBrnlJK8jSraVuaAFNrh8UHx5xLiktm2VLrE1eujeY3rxXQka0PSzEESD7URO26/OQIhHzfzd9hIM1J8bHPK1GcYLu0m0jJJ7oyZXkVBr8fD83nAqSAcNFBm7X5rj+9QiM42PeExnwsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897008; c=relaxed/simple;
	bh=x67tj4d4sGFh6pMNLKZLO1owKYl8+zRNeQo7k9U82Wo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cLTH23T4KaRpOOaZmxOSnVjVow3UzkrgrI5dDhs+pWvSIEycXva+7lZsGcUbJvhqNm3SBVoJ+hhaSA6PXvUg/6hXY7X3QC/OwIxbYCMVjiPVFjg/CC6HAmJTwbUMELYg2jdAQ7Dr1Em2bLsuwZ3AJU+siJp1GLcy8ZIrfh5Q4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjwUEoe3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2659234a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897004; x=1742501804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wurt4MgbZ3YF+714ARk9/Fo2sMYfuH9nOgbrs+dz6eo=;
        b=FjwUEoe3wBn3wibgBxG6ofF09OV84fty3cA7HE1kGUeyhbnvg20SxdjQHP42bG4qQm
         exsWN/wAQuco6IOK0xIk9IAWuTAa1qhI/rCIkiSFUg5nQBhSEmydxMeYVq2d0iRNGLXO
         Ydyr+MJpI0uDZc3vyOsXP7mssoiZzIFWtSOkTv50GWtxoimMmpxsEitkGnIpdEwOsPY7
         +IkbkZeGNP8M4Ixvr12IkwJoECKIZ/Epg/sh2NnH+qMFMiaaVPTRIcRpBA8fdM7iL20J
         QzL2ddfM+jfXp60jYjFUuDpaBoIsluxn5qbkeirErTC2zug1JEzL0u0/o87kdsT1ogvh
         vaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897004; x=1742501804;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wurt4MgbZ3YF+714ARk9/Fo2sMYfuH9nOgbrs+dz6eo=;
        b=DOyQ5M/doPQgsaDBzeFrYKN4bi5bsKPyOEp2g2d4U7euCD4ZD3UCVCpR8rwwbOeOQj
         hWE0OvVLYwQkozW9RIC0/VoKDjFf0jJr/5K821pBRgJXocbD6YdDteCzfw+ksrOVDoQ9
         ojSuCNJ15OZwCdQNJa/HHsQ9dE6vjYjerB7W4edQGh/XoRJwrD17u/FCruB12FErA/PJ
         JIPO+KYYlMz2ef1zFrud2yKvoJewW3SYQcpvZSv6NSMyloFDXenWV4TGCNNLKXDLPU3H
         oNqF+U/5tCBCjlBi1rjUyraqp1lxdCUjf1e/vJExxqTg43j1YNGN/2P9FHZVZrUQhZBa
         914w==
X-Gm-Message-State: AOJu0YwTRCUmFeHXRGhyLV5/+YXb6f2yrxbE6Eu2mfTI4KXXnmuzpNPq
	/gZp2F4jCfdL1AgVCHvL3+QHDKxmeUk72XgEsUN+xRUC2SMtkRY6tulUTQ==
X-Gm-Gg: ASbGncsNWUyDxFGr7oKhgdzsJVJs+uMgceTSsDJL8EFxv2HkQFA84GPJ84AjOQA8QIB
	N5o1PV9YP/kT+mvC6YScUqvk4J/1hvEMma4q9fpZwVMLS+iy9LCXEhOxC4w/PG8/nAN89uOnfPz
	qJEbh3QP0fnlRfY7/GebuMyMMOeFu1E2trHv+HmO2+dFGh7JRFr98GPHVAz8oAN3U+/9OeNed+w
	K80ynBhaT4Xra8vssPatI5LRSQAqSaio93ZRocGhGXmhr/ou1cmV9MwYgMSyWSseSU0p9ftI6tl
	cNKx08CU/plz2kb9p4U3XKAB8/OVvwo2xrGxo/I7KYcy6LwcP7Z1XQ==
X-Google-Smtp-Source: AGHT+IF7qpteoazS4G04wuXTl/n9k8FyMlt6JU+4vMlZkygV3EoFOMw0F3Ibo+o5Vz+hb1stTR4L6A==
X-Received: by 2002:a05:6402:50d0:b0:5e5:310d:256e with SMTP id 4fb4d7f45d1cf-5e814ed9ee6mr3572682a12.14.1741897004036;
        Thu, 13 Mar 2025 13:16:44 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad38b4sm1115200a12.60.2025.03.13.13.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 13:16:43 -0700 (PDT)
Message-ID: <39d594a4-7099-4a6c-97be-51a7ab614777@gmail.com>
Date: Thu, 13 Mar 2025 22:16:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 1/4] wifi: rtw88: usb: Enable switching the RTL8814AU
 to USB 3
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Content-Language: en-US
In-Reply-To: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Realtek wifi 5 devices which support USB 3 are weird: when first
plugged in, they pretend to be USB 2. The driver needs to send some
commands to the device, which make it disappear and come back as a
USB 3 device.

The method used to switch the RTL8812AU also works for the RTL8814AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index c8092fa0d9f1..a78f59fcde58 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1094,7 +1094,8 @@ static int rtw_usb_switch_mode_new(struct rtw_dev *rtwdev)
 
 static bool rtw_usb3_chip_old(u8 chip_id)
 {
-	return chip_id == RTW_CHIP_TYPE_8812A;
+	return chip_id == RTW_CHIP_TYPE_8812A ||
+	       chip_id == RTW_CHIP_TYPE_8814A;
 }
 
 static bool rtw_usb3_chip_new(u8 chip_id)
-- 
2.48.1


