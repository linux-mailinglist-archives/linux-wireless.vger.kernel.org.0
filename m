Return-Path: <linux-wireless+bounces-17558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C864A127DB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5CB1674DB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE1160799;
	Wed, 15 Jan 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+sJGfZ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4D15D5C5
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956319; cv=none; b=Www+3NXvJ6R9HPaZzKpfP+RLOhko8tgp1/n1bxJbMwoe4IiJ2tPVcCdL5R9tuEFtiwHli1wMtooOdF8IcuuIDv1KkD7WtzbpxklgjF6FMS24nqm8r30sUI44fmiZ2EZ+w5iFW5ENv6J5lUEWwFKTZ58BwSgqysoSpX5friZDOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956319; c=relaxed/simple;
	bh=5yYJCdYHfb+lhQpVHmMs3C12rfT7I7/yw/E1i/e0xhM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LAEkUQF5vze0qbc3WQ13KWYrH5h7DDKr6oBc45DnH1EY/TM1Fmd0a40v6j+Y4cuGIKBbOpBzpLEVoNujyoCQ1P9SRoQewzpwhwArb8Jq2Dh3fiCwdQc6782tjDUJQdxrQZmHRaeTqE3yqqWJhhospCA5M3mgX8Kz52b2iub2Il4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+sJGfZ1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso49182595e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 07:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736956315; x=1737561115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gDsM2ndKvgfuiO8anHB17sGgKpa4aAq7L6HCTfeIO+g=;
        b=E+sJGfZ1RfdbBVORZEyIS9JJpujQNXXX+UJpFms0fObjwtOoG7VeYzpUdWj55PqJHd
         n/mMUkA2wCTz1fHc51IfjZtToEhzwd3ex4Wp/8DR0ps5+CdyLJ/jpzmbW3Djwnxl38hR
         F76Pl2baYD8IOq8sSoGwFWAfuxCQrhI+3Qc2av4/eaRt+WQlLIeOobwZqvWHkFcD/z69
         hmkEPoQAJ6WbK452jts0xB9RBW1zaKPFEkkHw7Z699C24Fi+z/H8D7+3Yiu9i6qK25xC
         kLtTSL3cd9ofwqfEQqWSyGtkTGdBJ/qXo8R/YUUsztKxMj6s512ZprYYdn5799J3BtuR
         t0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736956315; x=1737561115;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDsM2ndKvgfuiO8anHB17sGgKpa4aAq7L6HCTfeIO+g=;
        b=H/34jPtTwTajiitdKspVzq2gTwjtdrbqcymYw8N5pHFJI/9h2T1n9nUeJwlcOmkE56
         HqRWRWjiH6SD47INgxYpJ569bCnHda+38wFlDG4H+84vWc313FhNW5Xt2oPP4GPOPSU5
         np/AY/gQ4YiU22ZT1be1aLHW1yBNZqdalwB5gN80OonBJnbqvDoF1nZl6H4RBRmOcsyG
         MEFqZg7lSI3o+mg5U6ej8XolH038ifYEElgZnTUhGLSSpQp9s3vBlHjYhJ5Ja+01mqSz
         u933H85urZ1gY5meAb5zZAP+6H5AMli/LCiqikd4DEFZl9foAXzhQ+G+MYCZblOqchq8
         y5YA==
X-Forwarded-Encrypted: i=1; AJvYcCXHQafZdvK7zLKb+6h9TyPE+MOLaN027rF/Zjf+4X4hZPDVBBcF3v68bbpl9RZ63AISiIw2MjbDJat23pBByA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6cLdlPbJbVtYcn7PSvfmGi8sW+A8mwwxU4brZ6ff1OVJy0byu
	AsnxryzlBNiCkFuZ6ACPD5L9OLbITnWQQYx3UhvRGeiiINMRrafD
X-Gm-Gg: ASbGncsjrZELKPMZkcyDuyrhUJi48ZSMito9NG+ucNJKLh4LrM5jnxnXD30GSVmCAtg
	R/9dHqNH8HhzZvkKbKw5t9tZrKbCP4YSVsTMw/lIPLYTsqPdTK04aMGrApIlx09e19Kenq4xBVF
	k/FFJj5xNtgi9GAXIeGETP74/Vh4kazHkVXXdHblFErfTfUaqy4WSVv7uBAPPDIBinVkAYniFu8
	YaaxxEoblFlsrzIlBxbvSknIMBBrUkPgtzO/NOOwjy8Jfa1G/ZPoTK5CwiTzMRf
X-Google-Smtp-Source: AGHT+IH2Wk5NDH5amNjWMHnfS2nod63hl5c1HrBMrz5wvoPhOL0TwZPC0+HQeAQGGYRgkdFqinzfvA==
X-Received: by 2002:a05:600c:4455:b0:434:fbcd:1382 with SMTP id 5b1f17b1804b1-436e26a80b6mr303296075e9.11.1736956315180;
        Wed, 15 Jan 2025 07:51:55 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c749a127sm27859965e9.7.2025.01.15.07.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:51:54 -0800 (PST)
Message-ID: <54abe45f-a26d-4606-8f13-6b27b22d4811@gmail.com>
Date: Wed, 15 Jan 2025 17:51:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] drivers/mediatek: Fix some mt7601u vendor could
 not connect
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, WangYuli <wangyuli@uniontech.com>
Cc: guanwentao@uniontech.com, linux-wireless@vger.kernel.org
References: <A9442D62405552CE+20240715094714.1553336-1-wangyuli@uniontech.com>
 <20240715065426.73ba0869@kernel.org>
 <43a58f4a-6579-40f8-bb92-6bee8075c72e@gmail.com>
Content-Language: en-US
In-Reply-To: <43a58f4a-6579-40f8-bb92-6bee8075c72e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/01/2025 00:42, Bitterblue Smith wrote:
> On 15/07/2024 16:54, Jakub Kicinski wrote:
>> On Mon, 15 Jul 2024 17:47:14 +0800 WangYuli wrote:
>>> Some mt7601 devices cannot establish a connection properly.
>>> This patch fixes the issue.
>>> We do not know why, but it just works.
>>
>> Any chance we can gate this on the version of EEPROM or chip or
>> something else? It'd be good to avoid regressions on older devices.
>> Or possibly - could we issue the MCU command as a test and disable
>> the calibration if it fails?
> 
> (Removed some people and lists from CC because they seemed
> unnecessary.)
> 
> Hi Jakub,
> 
> I have Tenda W311MI2 which works with vanilla mt7601u, and a no-name
> "free driver" device from Aliexpress which doesn't. They have the
> same USB IDs.
> 
> The Tenda:
> 
> Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: ASIC revision: 76010001 MAC revision: 76010500                
> Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: Firmware Version: 0.1.00 Build: 7640 Build time: 201302052146____
> Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: EEPROM ver:0d fae:00                                                                                                     
> 
> 00000000: 01 76 00 0d 50 2b 73 e8 19 76 ff ff ff ff ff ff  .v..P+s..v......
> 00000010: 01 02 8f 14 01 76 00 00 4a 00 01 00 80 50 08 00  .....v..J....P..
> 00000020: 03 00 02 00 00 00 ff 01 40 60 80 ff ff ff ff ff  ........@`......
> 00000030: ff ff ff ff 11 ff 04 28 ff ff 78 01 ff ff 99 99  .......(..x.....
> 00000040: 8c 88 ff 07 08 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000050: 00 00 1b 1b 1b 1b 1b 1b 1c 1c 1c 1c 1c 1c 1c 1c  ................
> 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 80 00  ................
> 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 000000d0: 20 f9 00 00 00 00 00 00 00 00 00 00 00 00 05 05   ...............
> 000000e0: 03 03 04 00 00 00 02 00 00 00 02 00 00 00 02 00  ................
> 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 
> The no-name:
> 
> Jan 09 21:50:34 ideapad2 kernel: mt7601u 1-4:1.0: ASIC revision: 76010001 MAC revision: 76010500                                                
> Jan 09 21:50:34 ideapad2 kernel: mt7601u 1-4:1.0: EEPROM ver:0d fae:00                                                                                                     
> 
> 00000000: 01 76 00 0d 00 50 11 00 5b 9b ff ff ff ff ff ff  .v...P..[.......
> 00000010: 01 02 8f 14 01 76 00 00 4a 00 01 00 80 50 08 00  .....v..J....P..
> 00000020: 03 00 02 00 00 00 ff 01 40 60 80 ff ff ff ff ff  ........@`......
> 00000030: ff ff ff ff 11 ff 04 10 ff ff 82 01 ff ff 99 99  ................
> 00000040: 8c 88 ff 07 08 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000050: 00 00 05 05 05 04 04 04 05 05 06 06 07 07 07 07  ................
> 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 80 00  ................
> 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 000000d0: 1e f9 00 00 00 00 00 00 00 00 00 00 00 00 05 05  ................
> 000000e0: 03 03 04 00 00 00 02 00 00 00 02 00 00 00 02 00  ................
> 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> 
> The no-name device seems to die after uploading the third chunk of
> the firmware:
> 
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Firmware Version: 0.1.00 Build: 7640 Build time: 201302052146____
> Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 64
> Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 14400
> Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 28736
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:09a8 failed:-110
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:09a8 failed:-110
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:0734 failed:-110
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:42 off:0230 failed:-110
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:0080 failed:-110
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:0080 failed:-110
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:0080 failed:-110
> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: probe with driver mt7601u failed with error -110
> 
> Removing the call to mt7601u_vendor_reset() fixes that problem.
> The firmware uploads, the device connects to my network. The
> Tenda still works. The driver included in Windows 10 doesn't do
> that reset with either device.
> 
> At first I tried with len=8192 because that's what the Windows
> driver does but it didn't help.
> 
> After fixing the firmware upload, I had some USB disconnects with
> the no-name device. They were kind of random. Now I'm testing it
> with those two MCU_CAL_DPD removed. The Windows driver doesn't
> seem to use MCU_CAL_DPD with the Tenda. I didn't check with the
> other one.
> 
> I hope this helps.

So after using the no-name device some more, I can say that only
the mt7601u_vendor_reset() needs to be removed to make this device
work.

The USB disconnects only happen in one port, no idea why. They
happen with or without the MCU_CAL_DPD.

