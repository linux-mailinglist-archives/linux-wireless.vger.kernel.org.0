Return-Path: <linux-wireless+bounces-27919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B670EBC8E82
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781523AD067
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864A52E0909;
	Thu,  9 Oct 2025 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxOHoCUA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70CB2E040E
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010824; cv=none; b=tlJPuBLtucMM8XFvd0cag3vznjZFJ5vJQ5L5J//JiPPmce0/rGK6gyQyQdoviOcoEz0Psy1NumJWLM1zc55lxBlenXAlJdXtzSGErOg2jxviQ2OCfPjDGNrva2qnvXhdxxzpGiB9XcRKY542CNAEDP7erjKq+CEV+YqBl7sCDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010824; c=relaxed/simple;
	bh=ZkSUbHHtXhW4XFXcbCgjCdkRQVyf3SxYhugkiAr2aP8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aX1/QMW46nMBQ98g4s+mye31yyYPfWceUh+wh+xGn6QuxkEehOWbvrBAB8A9w5JefppDMeA6NMqLUTpoCKbml+pTsDWjI/P8WCJd7klr1HJZmST30PW8+Yg9dzB7gspEdosZje5Punih+UTuhNekUV1ebMiDH55C8uVVPUccv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxOHoCUA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46b303f755aso7042165e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 04:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760010821; x=1760615621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aRDvLLmD3O10+N99pCm4+Pt03Flt/TqoXVXfov44zPQ=;
        b=HxOHoCUAb363F3HCKXsgAyZ/C4ozi/8G7ol1U+YaHoT9sBBR/YO74IHmR9ifkbtnti
         WVCOCr6OQmpRCGq7aKS1e2/BXDPMpaUdFXdRFy8OiXx9HZExD1hS1IV95I6gpTF8BGDY
         2eIsTpjwIOOSajiBUPtvUrjHbV1YnD9ROjkB9GRIGVEBQHVo1+NP3uMupXOcnmuvVch3
         I9+fvAuXN+iD8QeN8+wb/pmJvT2OWFH0UMu4h+SdkwVn/46p3t1xXv8GT8C0FI5NDZjX
         VoiH0+5S5SO/lvsSzkj6TOPHVqHIZmZYwTJoS4EhAlNonUfaWEGrDR3HFPVgf4+PXfCX
         L2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760010821; x=1760615621;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRDvLLmD3O10+N99pCm4+Pt03Flt/TqoXVXfov44zPQ=;
        b=Bi5AQ+S1D+OqLC9mebe6laGr3/R/boLRJRRHHmsNnEGPmhn9iCcpZIuwimldgu6Oph
         o8TSAKjCBysQgirNLN57tCncCL76XGihi7GtydzfSDwYOLmSXnFoY1wIT/Hej6yocybI
         ApHlu18XORU+CJGhX/+tYPA0E00B19c2uKWO5TRQqsBc5jKj0awonuxjD0mbVCACsVSI
         cyjdMwN/t0qIs/vHf082hgr7jRu8xUlJZ2jPj1L/66WHG9uB4Kwg2wcKxYszmFMraioo
         yrwuYIdYfUmaqGoFlcQmnY/KvFgCWGPcyo7XqGh1M59+vZDxiizWF/c3gUb7oiN4Mq8e
         wZKg==
X-Gm-Message-State: AOJu0YzdUsLmWleAhiSdUChveXhuOwiEDShLzxVBZicw6dYBrCRdVwyx
	r1MHUgfpMcYKs/DS2nNKhyvMh5uSG9CALqpp1Wsbtgy/0EEItguPsyWdDXTeJA==
X-Gm-Gg: ASbGncuwkU8j1/as+HGDJR4h8xOIMlH1+4G6Mj2w6a3BH4tCNEkVaI1++3vq9ax+ywi
	3KpDM3ML54PcAXlJq/u8YmO9a3+ZsWPmOg5kiBTUT5+1KO36iWZA/HoLiFjweL+F3Qrq9eOGgVU
	aKH+mJw7yyng5L4VIuT884Iny2UKhqmhWSOEKat0g6iv4yNq5QjvdkpeUQlFbAfd2sPI3t+VBF7
	A3JgO+fluH5IFJoQ/GVUlZNh4MXCEwG9oEmlFLOJ//eu3vGdEj0/kjL3JkqowXzgE5ZY2W4LHnv
	6amrFNnH44M+hryDiGHV3jITHUhUWUPf0zDW5336g0SyOfghdkhMWKmQ8+y0ZsvmYomNeJDEWQ4
	p+p3YxOWH4+lUNbZipPmWkG3OC11dpVwHNzAibJpFyseSHEMDqO+3gMSpqeGO1SGeqMxXPkloXY
	r6
X-Google-Smtp-Source: AGHT+IHabjhmzqBU7kzyQgmLSlkkeAq+73EK30uhfUGQjWhrAB/0UQ786oJle5lLXoZM4xxCIul+mQ==
X-Received: by 2002:a05:600c:529a:b0:46e:37a3:3ec1 with SMTP id 5b1f17b1804b1-46fa9af1797mr56675075e9.24.1760010820567;
        Thu, 09 Oct 2025 04:53:40 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf18bbe7sm43940175e9.20.2025.10.09.04.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 04:53:40 -0700 (PDT)
Message-ID: <1f544dc4-17f6-4401-995d-5cb4567b82fa@gmail.com>
Date: Thu, 9 Oct 2025 14:53:37 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/3] wifi: rtl8xxxu: Dump the efuse right after
 reading it
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>
References: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
Content-Language: en-US
In-Reply-To: <cdbe1a18-f6f1-4575-bad9-e85db8101247@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Someone reported a problem with their TP-Link WN722N (RTL8188EUS):

usb 1-1: This Realtek USB WiFi dongle (0x2357:0x010c) is untested!
usb 1-1: Please report results to Jes.Sorensen@gmail.com
usb 1-1: Fatal - failed to parse EFuse
rtl8xxxu: probe of 1-1:1.0 failed with error -22

This error can happen when the first two bytes of the efuse don't have
the expected magic value of 0x8129. In a situation like this it could
be useful to see the contents of the efuse.

Dump the efuse right after reading it, before trying to parse it.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index f083429fb507..3a2cb06fa905 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -7910,15 +7910,15 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 		goto err_set_intfdata;
 	}
 
+	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE)
+		rtl8xxxu_dump_efuse(priv);
+
 	ret = priv->fops->parse_efuse(priv);
 	if (ret) {
 		dev_err(&udev->dev, "Fatal - failed to parse EFuse\n");
 		goto err_set_intfdata;
 	}
 
-	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_EFUSE)
-		rtl8xxxu_dump_efuse(priv);
-
 	rtl8xxxu_print_chipinfo(priv);
 
 	ret = priv->fops->load_firmware(priv);
-- 
2.51.0


