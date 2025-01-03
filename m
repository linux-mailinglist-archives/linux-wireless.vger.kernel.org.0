Return-Path: <linux-wireless+bounces-17055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C6A00CBC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 18:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DE27A1BC4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75871FC108;
	Fri,  3 Jan 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPTSIQWU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E11F9EDF;
	Fri,  3 Jan 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925468; cv=none; b=KJRzWq13LDFDYV91aclKUPYNp6BIgfj4WIXlJcrtwsXZ40x9/Z+LO7nMSpMLg0tTWvrVlRHaqJezgESKoZr0IE7jLa8jlU81iWncd9PcjJ6Tjs7i+7qheG5ZAydkD6SsvEAQUIbWJj6m3ll2l7PlZVLpbxc/kXHtUBalcuh4g34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925468; c=relaxed/simple;
	bh=VkCJQVoiRk2IblJ1K3+RMjfMrwoKMGDda4NAbDTenDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9z69/VHj/pAstG4fFcyfrCJJ5YgdsOPKD26pp6qYKcpXsqSTrkcpYwBgh50PI4tCrwjEuzy1EodxxBPxXNsdPSCXjWEPYr5/9qjlmxXBzP+Vhp3NAFuIe6SFMC5l2sOAJqm+1fowPnSJAgDUf4Rq8RRtGcfnR8cEXtbdM+F83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPTSIQWU; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29fad34bb62so6368121fac.1;
        Fri, 03 Jan 2025 09:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735925466; x=1736530266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkCJQVoiRk2IblJ1K3+RMjfMrwoKMGDda4NAbDTenDM=;
        b=MPTSIQWU5KagRXgpEof3wd7Zz40bf3K01f8ni9fm5yJ+zKHrLnjNm4wCRVIrgm2W/d
         jprK4R3JehIuq4qEkvjL/r4jZEmQo20OcqPQEUrAFaZDCb4m5uZ24TjtTY80Yp/E7xg8
         eR/9bhpHjPUIMxTxfG0UhoZiZQp9XsRUehqo7q0vJYevF3GENqQtTUUFO2gGiZaTFbH+
         bEi6m6l7k5vG47XxNVDSX6yjCu//FC3JJFW8gBP0GGFfPa0LejeY3/hDJ+VRsqDxhWzf
         1rskW/cO2WkyxC0vdLYj6Xwd7X7/gqTl7Z4T4MeH1ryHHJT1Pst4E/gdH8R8w/+/h3xi
         5gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735925466; x=1736530266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkCJQVoiRk2IblJ1K3+RMjfMrwoKMGDda4NAbDTenDM=;
        b=Fso/MuJo0Trdb9ab4KSf4iV6mYEJLEbk+LDYdibLuvoRcpI/3+FMOpXNfi7Waz54uC
         n8pWi6WkYGd1o2f8pBzCnrLfwqRdSdUnZ3ydLfnRwdVtRX/zgq304Ot/Ntdcq69rA6Fh
         RT1MzKrJ4zQkb/vqp7OimL3v4rZCd/EnXIrbir2nPpXcjr0tH6CPfcfJevKg3gtOwFDm
         gaklVvcpDapr5IhgfFsji5lnHdsck1i8Ytpz/xkOVfXLcMHpeibVdQzKImTrh5uCfxQ2
         kTe7i6xBSDyrSP8kLDj4/C0YYKLBZ8srgZtwljJC3rcw/Fzey5s6J6HLYp9ARdwyGrYC
         z5YA==
X-Forwarded-Encrypted: i=1; AJvYcCUTH9jCVQtMOLaIKGGk5aQQn6cDMS8UsiK1s5di+VBKr4olbWtgzBT/RBMfA4Yja7iWi3g8v82lsgqFfoY=@vger.kernel.org, AJvYcCWFMmUaqUMzQ4E/jHSVjzbY3b2VTIeRhXvQj8ux3nkkHgvmZSMMieoF+LcrG4QgesxpgOBXRrthxhKQneqIFKk=@vger.kernel.org, AJvYcCXxr39lNfv/xn47ipbrmq2OpwVQxKaRaQPFjKSDRkH623Y5rv4ITN9YpjDb42smQ4UJ/6huvTH0@vger.kernel.org
X-Gm-Message-State: AOJu0YwxeGqbz6wvPiMWZ6gbP6giDCNkkdKB7yORnKgs54Eq3J8m67PD
	ZDtGTJbi8EIMhB3enU3kAjNNbiVGyTXruxa6/7dVxgj9q38rHI3vpPsL7PX5zaLzngPF0iyxOOY
	3bYo9c0cMSvlCZsOAkiy1BGkS/4w=
X-Gm-Gg: ASbGnct/qJM+Q8GlfOz0qXMcVpTpbN7m6qpC7uufFKZrbXGre1T81vJY5zW5SUDRa80
	2mrmGI2aNwoBHZfS4t0vgffrU3LHl3TD0DQR1yM2Hw/fn2MFRwvug
X-Google-Smtp-Source: AGHT+IGv8bsmLDf1bWVTKaXEgfvA2PqOOdYrUgxm71ByeJc5Z2kLhK08e9vgpB5bdpgBwwQ6hIWkcXkwMTwXA8Vva/0=
X-Received: by 2002:a05:6871:530e:b0:29f:ecfc:32df with SMTP id
 586e51a60fabf-2a7fb234a55mr31178294fac.14.1735925465925; Fri, 03 Jan 2025
 09:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103075107.1337533-1-anarsoul@gmail.com> <f69874f3c11f4c7b8b0e3026796bb452@realtek.com>
In-Reply-To: <f69874f3c11f4c7b8b0e3026796bb452@realtek.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 3 Jan 2025 09:30:39 -0800
Message-ID: <CA+E=qVfsHw_YqwVNPjhp9QydC9RUo=9U6ddA6StrmDNzgrUCxQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>, Fiona Klute <fiona.klute@gmx.de>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 1:13=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> > Fix 3 typos in 8703b driver. 2 typos in calibration routines are not
> > fatal and do not seem to have any impact, just fix them to match vendor
> > driver.
>
> Just curious how you can find these typos?

I added traces to sdio_* functions in linux (see [1]), so I can
capture register access traces. I captured the traces from both rtw88
and the vendor driver and wrote a simple parser that decodes the
traces, see [2]. I guess it would be easier with an USB device, where
we have usbmon. I really wish there was something like usbmon for
SDIO.

I also added traces for C2H messages to both drivers, since they go
through sdio_memcpy_fromio() that I don't trace.

Once I had the traces, I manually compared them (along with register
dumps, rtw88 has it in debugfs, vendor driver in proc) trying to find
the writes that do not match. Unfortunately, rtw88 and vendor driver
flows are different enough, so I couldn't come up with a way to
compare it automatically

Adrian and Bitterblue supported me on #linux-wireless on IRC, and one
of the typos in IQK calibration was actually found by Bitterblue.

It took ~5 evenings and 1 weekend to get to REG_OFDM0_TX_PSD_NOISE
(0xce4). Once I changed it from 0 to 0x10000000 via reg_write over
debugfs, it magically fixed the issue. I changed it back to 0 to
confirm that it breaks it again, and then back to 0x10000000 to see it
working. Then it was just a matter of grep to find where this register
is written in rtw88 and compare the corresponding code to the vendor
driver.

[1] https://github.com/anarsoul/rtl8723cs-re/blob/master/sdio_traces.patch
[2] https://github.com/anarsoul/rtl8723cs-re

> > However the last one in rtw8703b_set_channel_bb() clears too many bits
> > in REG_OFDM0_TX_PSD_NOISE, causing TX and RX issues (neither rate goes
> > above MCS0-MCS1). Vendor driver clears only 2 most significant bits.
> >
> > With the last typo fixed, the driver is able to reach MCS7 on Pinebook
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
> Is this urgent? If not, I will take this via rtw-next tree.

Not really, since there aren't not a lot of users of 8723cs, but it
makes rtw88_8723cs driver usable on rtl8723cs. I don't really have any
preference on what tree it goes in

Regards,
Vasily

>

