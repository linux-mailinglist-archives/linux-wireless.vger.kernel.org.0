Return-Path: <linux-wireless+bounces-2127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364A3830E2E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 21:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3971C21627
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A0250EC;
	Wed, 17 Jan 2024 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vg+I1cL1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D656250E6
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705524549; cv=none; b=KQC/H/pnrcXyMF/HTzYyDL0qw73iMDQ77DEZ7whZcZRuyJEJQf0bEsp1d6G5SFSpNLuGQHV1x2wd7lbe4vqlKv/e9lfdFaJnzMqAuim3jy/BflYPkL1fOTge7B37Y8NsLRhCCxhthDa9lqwzZXxcuYuOsPQchHgW0Zm1r9IApgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705524549; c=relaxed/simple;
	bh=2jw/67wsavPFyTpLjwOxvtAtIWo6f7nqeH3s+5xdi+I=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=UogPhj3f3n1qKFARC7gWqPCZCOX3WPCisq811zl5kmuSWpMKIJF/CpZxYpWQ7zJt+QzTHwq4vgOWg6JCzo7/7tHicYuCAfFZDYfjvOa6xErpW/oDfvaNbbpM7RTCdqje84rDvbRrOwA4xBYqHKTwG6l8xvEWBQfRjs0n8dtmzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vg+I1cL1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d480c6342dso87247665ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 12:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1705524545; x=1706129345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jw/67wsavPFyTpLjwOxvtAtIWo6f7nqeH3s+5xdi+I=;
        b=Vg+I1cL1KnbsbZti3AYKPdx8wRbXWnlFMGsapZFsYKCuIHmRx9lj5vi15DaGjDQsbN
         ypReZBsLJc815gZ31xNNSAZQ7RLsAMAyZbOeLISsnITz/Z3Z5hy6xvNQKVvx8kAaHpy6
         HwdDvIDtCF6R9eNnAwK6lhgIBT3lZ9vuFHDhsdY7BFdYZ3/9W8yKL4WnUWLsYHeXBu0Z
         8vZBWNtYb4kQJP08mkAqpfsTsQlLZjxe85WgW7Y6BCZ2/ISrNWqgBE7EauT2ZfUfOFTg
         AzUlDOU47Nxr2GDmMrRZ6LVkxzFG1zFqD/Cu8MeQ1hHN7tArqNOxUKw34zZ8LZfXBAvI
         YoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705524545; x=1706129345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jw/67wsavPFyTpLjwOxvtAtIWo6f7nqeH3s+5xdi+I=;
        b=sMprc1N9BIzURjg4gHsa0gmlCK0mVkKoLnp/Z84XmzHR+q3XdJJ4QKIBnvZutZZe8L
         wEZB84bqUgwPrqpeNNd4wMnDnqf5gNUOV0SoJMBdXdlUlJxEeeBoBMPlic/RG/LhzjB6
         o42xgiesT0ngab1TLVuEjCbfMm660iRcdGSC6H7pFUsLsDacTL20sW7/cwO3QOrwngPs
         IOkeSK8C5UhuxHbZSHuILawhEe+o/Mj36cWiaCI8T4lvBYIQSPTYIACUKRnMsKYk3lo9
         n0hQU11Jk3mcPGia7ndNI4lao3nWO6xYttyP0oWqUqvUr8u8uOP/uNHypcWCJmhyQJtg
         rkfg==
X-Gm-Message-State: AOJu0Yy9OGd7JiEYu13041JGJDBIWmYWvsTkmkkP4VIj1lLy3AsOiPnG
	1V0PjbBLF3XKsWqKTxu0EC6S6LYGODtRSw1BtTo=
X-Google-Smtp-Source: AGHT+IGIGGR+OFqr3eoNenYqwToiKmrKfu/hy4QVt7QFirKckM6zqpJjnAn/sanSnytMc8Ux8JyPdJLpgE0opwEaFVc=
X-Received: by 2002:a17:902:db10:b0:1d5:4e3e:3c26 with SMTP id
 m16-20020a170902db1000b001d54e3e3c26mr12214342plx.43.1705524545468; Wed, 17
 Jan 2024 12:49:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36972ff5-0c48-4bd2-8f9a-9649bfa24225@lexina.in>
 <11c7333aee0d45fd9fbfc65f6e2a3aa2@realtek.com> <216e8522-fa56-4d54-ae32-74c6008a2075@lexina.in>
 <0969b1ca039e423dbcc41de18db023c6@realtek.com> <cc54a8b2-2fea-406c-8d4a-24ddfd34f983@lexina.in>
 <0be52db8941c4e609bfda6c69a14184e@realtek.com> <CAFBinCDT2Pj_BYqCtk+i7y8LPU2qwah-4Scdq29ONBqs3wt0pQ@mail.gmail.com>
 <8192e59807e14525b821317a5f550ea4@realtek.com> <CAFBinCBf2XM-W8-_YEGXydy4kLHHar7Fv5=GoKddjE9f0hTkAw@mail.gmail.com>
 <e4ccf840-a38c-455e-af75-5f4db8a97702@lexina.in>
In-Reply-To: <e4ccf840-a38c-455e-af75-5f4db8a97702@lexina.in>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 17 Jan 2024 21:48:54 +0100
Message-ID: <CAFBinCAsuCqEVJq-No-+D-T644mQ-qsez-Di-=s9gricOrk3wQ@mail.gmail.com>
Subject: Re: rtw88: rtl8822cs AP mode not working
To: Viacheslav <adeep@lexina.in>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	=?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viacheslav,

On Wed, Jan 17, 2024 at 10:48=E2=80=AFAM Viacheslav <adeep@lexina.in> wrote=
:
[...]
> > 3) Has anybody tried AP mode with rtw88 on a (supported) USB chipset?
> > If my thought (from #2) is correct then AP mode would show the same
> > problems there.
>
> I have USB RTL8821CU. It works in AP mode:
Thank you - this helps a lot as it narrows down the problem a lot!
If RTL8821CU works in AP mode the problem must be one of:
- a bug in sdio.c (in my opinion this is the most likely cause -
starting point: rtw_sdio_write_data_rsvd_page())
- some missing bits that are only SDIO relevant (in other words: code
that hasn't made it from the downstream driver into rtw88 yet)
- chipset specific differences (RTL8821C vs RTL8822C)
- a bug in the existing code that only affects SDIO cards (but doesn't
affect PCI / USB chips)
- a combination of any of those issues

I won't have time to look into this any further before the weekend.
Once I have more findings I'll let you know.

[...]
> > 4) Viacheslav, I think you previously mentioned that you did a bit of
> > work with the downstream driver.
> > It would be awesome if you could also take a look at the rtw88 and
> > downstream driver code and start comparing them (logic that's
> > different or completely missing from rtw88 is suspicious).
> >
>
> I made some minor fixes to restore functionality after kernel updates.
> But in this case, I will need help to understand where and how to start
> figuring this out.
The last rtw88 sdio bug fixes also only required changing only a few lines =
each.
As always: the tricky part is finding out what to change (without
breaking something else) :-)

> Moreover, we've encountered another problem: after two or three days the
> client WiFi connection stops working, the network interface loses its
> DHCP address, and consequently nothing else works.
Can you please confirm (to avoid any misunderstanding) that:
- this is in STA mode (meaning: RTL8822CS is connected to another AP)
- "loses it's DHCP address" means traffic stops flowing, even DHCP
renew is not working anymore
- (does restarting the interface: ip link set down ...; ip link set up
... work?)


Best regards,
Martin

