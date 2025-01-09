Return-Path: <linux-wireless+bounces-17269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CCCA082E2
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 23:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B74A188B7CE
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1332054FD;
	Thu,  9 Jan 2025 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeoN8nZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A2A2D
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736462535; cv=none; b=DucE1gunquMYZv+IJsVa/UoJj/bq7eDwd2Y7LLtgsznHoGmztNvr343ElI680B835vjAMh+dMHZjm1ddFmNuLbN4GPffZS976CQWsslq3YcbkbvP9FcU3ppclEnh2rcIGLnIa6GJTG+hFYyxXAyPHrS6XVoIdqcpnn6vuCNN1Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736462535; c=relaxed/simple;
	bh=DjYuCCJdFBk6hUzZs3vdRDgyZjFBuG35LC86rX6Y1Jk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=inQGlIIap1ZDd6KdQIkDyPsGJJIkkFPtxi29qpY919t5IPeE/3sVjTa7+Ec+kf73lqTQrorusJlyFVLDMIu0IYsZ9M9nSoIsOfjvl9BsDJ0NgFC627FptyTaDdcgQuAlI+9UJ7CU1Yg6hDTcdKcKYPfg9QXS3ApAfDfm/ROHh3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeoN8nZK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aab925654d9so294113566b.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 14:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736462532; x=1737067332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/tJwFf2wY7vSBYnR553Q1oGgOief7TZ40aHFz+iKJkg=;
        b=BeoN8nZKdPsCxub2UQsyoaQkcJGmbwHvUkDXj9RUVMAlhL793zXRwfQe8aB2PEwbwP
         0zZTeBcdNab4nev0cJVzHfE4IkYAck9HGdnr+1loO7hoAx/SHCFcf8QsPMG7y1SXjJmH
         t2JYkbkYufmvQI7+gIHT6Vl9QYc/etJk+i0sH352YdQGujTjnt9+b2jqLNHV87/h+MNn
         JWVUmrdnesA1SC9gxlr1VPWLUriEtavAtiD/JbyAmSrmqrBDA7lqqu0IeUKSdG93pwaS
         ExZMZ1QllHVhsvRb9wVScuVfr5aq+dAodb6+QWRO5ltggsWsrif0hY0BH4uLX/14aQ2c
         m7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736462532; x=1737067332;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/tJwFf2wY7vSBYnR553Q1oGgOief7TZ40aHFz+iKJkg=;
        b=nRHIhnxIo/8SsTBGLzH2nqnhTEemlVkE3T/moVumMBVKExmuaDbjxnkqxGjsuSsN6r
         dU9wKmc2HwbwST2muJUrAAHciBJY2fHFugtzoOXuYpWXIc8/JVZIDsqGnGX1MbMyxPAy
         DjbgrbMeBd3tSZGL77SDHOFUTmn7yTz0uUBlzUvpK/RoepoiWgqfgLJ/YvOxJ4fmJ5bz
         qbJtYje7IWW5Xy0G38ZLU+ZLJ/8NwybMq7FliLqrlqYbdGqqjAKX1vRPWXZ1ZFcXCj5W
         AjWXXrNSfHtDL9VBP4nyr2cf0KASWpyzMU9ZJZ9xKk/5h6L9/RdlG30f4kqS2soMrDk/
         sWfw==
X-Forwarded-Encrypted: i=1; AJvYcCXY4FAWpldgXtxoMpi2JIZRdn5LMMF81LnvDElnJmKN2MEm+tDTUz83T9d3mMoFg3pX3BPBWSds92M/eVEmVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyouC8XVe61/z+/RX2lPJtj1p+x4IXFwfxDxk1w4EfQuH+HHJPR
	DdHs9I2RyFThAZ1pPMZ3ND6yWpFg6mf0xcHGb3UDqaSyUtomugAC53BE4A==
X-Gm-Gg: ASbGncuLHE63aCB7hTOstmb7hO8qWJvkr0m8I3njUNIpuJzHXo9YdJUDYEMFC9DDHRq
	ExDISN7JLzy0hfA0QslOfumdRPtjth+AiH7njaHpppNnJB4DQg+awEG8IxRux4SMDlY5Ugfc62s
	VP2fpcpk6BvGoXpXhisxKZBln077htmy2FVCrxUDy/PdUny15I6LQ2T4ST/f8dEI/RUTveZjnP1
	9TAKRpOxFZ92SO6zipHJD1F0ESlU6lYNvlRd+qN7ei8y2U2ZmU+R7ETqdLrpbDD
X-Google-Smtp-Source: AGHT+IGp6Vxx5KGH7fFJZB+NLq65GSQuS4ju9nWqfEkJ8z8IRGxTNUAwAb6EE6DjI+WXxscGl72C4A==
X-Received: by 2002:a17:907:704:b0:aae:bd36:b198 with SMTP id a640c23a62f3a-ab2abcab421mr699035366b.47.1736462531576;
        Thu, 09 Jan 2025 14:42:11 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c905f0b3sm111641866b.21.2025.01.09.14.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 14:42:11 -0800 (PST)
Message-ID: <43a58f4a-6579-40f8-bb92-6bee8075c72e@gmail.com>
Date: Fri, 10 Jan 2025 00:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [RESEND. PATCH] drivers/mediatek: Fix some mt7601u vendor could
 not connect
To: Jakub Kicinski <kuba@kernel.org>, WangYuli <wangyuli@uniontech.com>
Cc: guanwentao@uniontech.com, linux-wireless@vger.kernel.org
References: <A9442D62405552CE+20240715094714.1553336-1-wangyuli@uniontech.com>
 <20240715065426.73ba0869@kernel.org>
Content-Language: en-US
In-Reply-To: <20240715065426.73ba0869@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2024 16:54, Jakub Kicinski wrote:
> On Mon, 15 Jul 2024 17:47:14 +0800 WangYuli wrote:
>> Some mt7601 devices cannot establish a connection properly.
>> This patch fixes the issue.
>> We do not know why, but it just works.
> 
> Any chance we can gate this on the version of EEPROM or chip or
> something else? It'd be good to avoid regressions on older devices.
> Or possibly - could we issue the MCU command as a test and disable
> the calibration if it fails?

(Removed some people and lists from CC because they seemed
unnecessary.)

Hi Jakub,

I have Tenda W311MI2 which works with vanilla mt7601u, and a no-name
"free driver" device from Aliexpress which doesn't. They have the
same USB IDs.

The Tenda:

Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: ASIC revision: 76010001 MAC revision: 76010500                
Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: Firmware Version: 0.1.00 Build: 7640 Build time: 201302052146____
Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: EEPROM ver:0d fae:00                                                                                                     

00000000: 01 76 00 0d 50 2b 73 e8 19 76 ff ff ff ff ff ff  .v..P+s..v......
00000010: 01 02 8f 14 01 76 00 00 4a 00 01 00 80 50 08 00  .....v..J....P..
00000020: 03 00 02 00 00 00 ff 01 40 60 80 ff ff ff ff ff  ........@`......
00000030: ff ff ff ff 11 ff 04 28 ff ff 78 01 ff ff 99 99  .......(..x.....
00000040: 8c 88 ff 07 08 00 00 00 00 00 00 00 00 00 00 00  ................
00000050: 00 00 1b 1b 1b 1b 1b 1b 1c 1c 1c 1c 1c 1c 1c 1c  ................
00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 80 00  ................
00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
000000d0: 20 f9 00 00 00 00 00 00 00 00 00 00 00 00 05 05   ...............
000000e0: 03 03 04 00 00 00 02 00 00 00 02 00 00 00 02 00  ................
000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................

The no-name:

Jan 09 21:50:34 ideapad2 kernel: mt7601u 1-4:1.0: ASIC revision: 76010001 MAC revision: 76010500                                                
Jan 09 21:50:34 ideapad2 kernel: mt7601u 1-4:1.0: EEPROM ver:0d fae:00                                                                                                     

00000000: 01 76 00 0d 00 50 11 00 5b 9b ff ff ff ff ff ff  .v...P..[.......
00000010: 01 02 8f 14 01 76 00 00 4a 00 01 00 80 50 08 00  .....v..J....P..
00000020: 03 00 02 00 00 00 ff 01 40 60 80 ff ff ff ff ff  ........@`......
00000030: ff ff ff ff 11 ff 04 10 ff ff 82 01 ff ff 99 99  ................
00000040: 8c 88 ff 07 08 00 00 00 00 00 00 00 00 00 00 00  ................
00000050: 00 00 05 05 05 04 04 04 05 05 06 06 07 07 07 07  ................
00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 80 00  ................
00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
000000d0: 1e f9 00 00 00 00 00 00 00 00 00 00 00 00 05 05  ................
000000e0: 03 03 04 00 00 00 02 00 00 00 02 00 00 00 02 00  ................
000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................

The no-name device seems to die after uploading the third chunk of
the firmware:

Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Firmware Version: 0.1.00 Build: 7640 Build time: 201302052146____
Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 64
Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 14400
Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 28736
Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:09a8 failed:-110
Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:09a8 failed:-110
Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:0734 failed:-110
Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:42 off:0230 failed:-110
Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:0080 failed:-110
Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:0080 failed:-110
Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:0080 failed:-110
Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: probe with driver mt7601u failed with error -110

Removing the call to mt7601u_vendor_reset() fixes that problem.
The firmware uploads, the device connects to my network. The
Tenda still works. The driver included in Windows 10 doesn't do
that reset with either device.

At first I tried with len=8192 because that's what the Windows
driver does but it didn't help.

After fixing the firmware upload, I had some USB disconnects with
the no-name device. They were kind of random. Now I'm testing it
with those two MCU_CAL_DPD removed. The Windows driver doesn't
seem to use MCU_CAL_DPD with the Tenda. I didn't check with the
other one.

I hope this helps.

