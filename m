Return-Path: <linux-wireless+bounces-8831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C7B904C2B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4E31C20C17
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 06:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F761649A8;
	Wed, 12 Jun 2024 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MasULxCz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31D33FE
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175567; cv=none; b=TXCWCUh/KDVGydGaNQxW9ejK4wgRCVRk6hvcUJmH6jAJOseJUyrAAXDjP6h66TNlk4Y0VOzix7+IQZnTUDBzcxVyAnMpIY5zoosKcSX61vflfBUOPKqSsEorPmDma2kASETcAHk0NyZG1GqYGKF9Am5q71d92h1deL5ZYiqF/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175567; c=relaxed/simple;
	bh=M+ByotX85QqFoKH1CGs6ag1PR5bpr0RqYC4ycTYopog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BTxCZLb/Div/glZIvHchNVgGxfdDBmuFuF+9KgdF+eq6e9ffO3p2xKuaoYKtVdqsiMfR3hrhDcY0Hw7ZC+fl2dF0RMikwgAMSeyGJLXMBNfrG2TZBC9eaF+C2Etlb83XUqZRffL53Z8IV8WtBglSRsCcsgf+DF8k2fzep6HY4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MasULxCz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f480624d0dso16655395ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 23:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718175565; x=1718780365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl10qwpmLa02HE1asgrlwFLmOS0nrUF9GeMdbClxF+4=;
        b=MasULxCzoWs96KjJvI39LFEdq/LiQwUGJ20wGuZ6w3F/wVeXXVNX5eFfF76BWtmzkJ
         aFjApyQyxdTp3JbLiHYSmS1Z9IYvSfW7viT4xxGTvvGqh4ulg638EB+N5cI+eT6XTFwb
         9aF+Hx4ZGbgMjFqWMdlLj1DM7N84Olwp6GxnovrH49VWNIibtRdFwOQrFwkfsRBevcBh
         5sn3oxo9yvujYf2pxwhmS7VbbpGI3/aty5Qz7LKduAHRgte5UQTttAT9CyMVLiBN0HCC
         ebpG6sE0oB2RSYCIrY4IgC9mNDAtqmH0UWD75OP55yQthUtYkos2dShxTD+mVjf704OI
         kJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175565; x=1718780365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zl10qwpmLa02HE1asgrlwFLmOS0nrUF9GeMdbClxF+4=;
        b=hPSj5DkSKOXDhHMJedr+KCNKFVMBG/4gXPFE8YSdbTw5rpqLU/0Wqfh/azDDOUv13V
         ftnaRLQ4QnT81LayMJZRMsPRWAR6v+3IJGt4wH5Co2N6MFSoa5ShKe3F+8vEkMKWLcR9
         H1jVOTC48LeFJaCwTBzez5BM84LpyQ7sqNL3/lqr0YZ16Np7rK+6buFDCt1dHDWYQqL2
         H+SY6liuHcvbui909qlCDxcImwUo3whRm75hO+jwxB5d8CFPeE0SD6vRlY/rb0HcmMnX
         efCCUlT9xRo7RCNGkbl5HBmCMNyi6ndkLoeudvrWLUwjDiQfngCo9EZPxpswioNMOzk+
         KQ3w==
X-Gm-Message-State: AOJu0YwlnZsBcUhzwn3ILjNEjh1sGNi2iZC05yOK/4X00963eKgRmnWN
	3tovHoBBOv8rgglDtRmXGWXFATwx8HtkDfTAg7aCymw/I5gohCT8FCwC7j63uifOBWOOm7mtoKv
	QWis9iZ/SMg67zq+ogrtKclwZX7A=
X-Google-Smtp-Source: AGHT+IFOlMM2OZ5tFb4DNlJ372Kc96gbQ3DSmRT9GrL/219XVC+QZ/hHprGK1u/P7LpWd9dZTqlwXtXnnw0DeUDqjT4=
X-Received: by 2002:a17:90a:de18:b0:2bf:8ce5:dc51 with SMTP id
 98e67ed59e1d1-2c4a76d4e4bmr1223035a91.35.1718175565067; Tue, 11 Jun 2024
 23:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
 <868343c920c24204972ddaa108e5d00e@realtek.com> <CA+GA0_vA1KRRyvnURfdjwVv5JBkRhkjdQnwrRWWKmZs9_z-X1w@mail.gmail.com>
 <c5b42d8b818b4bd5ac8a6921a29f9f18@realtek.com> <CA+GA0_vHeYLNw88KCnD9NACofA5rPJppj0nWZi+v5FqZLmpomA@mail.gmail.com>
 <9bec9d852273467fbf66af68e3c4d325@realtek.com>
In-Reply-To: <9bec9d852273467fbf66af68e3c4d325@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Wed, 12 Jun 2024 08:59:13 +0200
Message-ID: <CA+GA0_v0ee_VCRzwd-bA+XqMFZcMWs0oG0s_jFk6CjC0vV82ww@mail.gmail.com>
Subject: Re: rtw88 multicast failure in AP mode
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	=?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 12 cze 2024 o 08:08 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=
=82(a):
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > =C5=9Br., 12 cze 2024 o 03:30 Ping-Ke Shih <pkshih@realtek.com> napisa=
=C5=82(a):
> > >
> > > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > > wt., 11 cze 2024 o 04:32 Ping-Ke Shih <pkshih@realtek.com> napisa=
=C5=82(a):
> > > > >
> > > > > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > > > > Let's assume we have 3 systems: A and B use 8821CU chip, and C =
uses
> > > > > > another chip from a different vendor.
> > > > > >
> > > > > > If A is in AP mode and A and B use the rtw88 driver, pinging A =
from B
> > > > > > and C by local name doesn't work because name resolution fails:=
 avahi
> > > > > > on B and C sends a multicast request to resolve A.local, A sees=
 it and
> > > > > > responds, but neither B nor C sees the response.
> > > > > >
> > > > > > In the same situation, but with A and B using the rtl8821cu dri=
ver
> > > > > > (from https://github.com/morrownr/8821cu-20210916.git), everyth=
ing
> > > > > > works - B and C see A's response and can resolve A.local.
> > > > > >
> > > > > > If C is in AP mode, resolving C from A and B also works.
> > > > > >
> > > > > > This leads me to believe there's something wrong with rtw88 whe=
n
> > > > > > sending multicast packets in AP mode.
> > > > >
> > > > > Have you captured air packets sent by C (AP mode)? (To check if T=
X properly.)
> > > >
> > > > Yes, I see packets in both directions on both C and A if C is in AP=
 mode.
> > > >
> > > > > Have you tried non-secure connection? (To check if encryption pro=
perly.)
> > > >
> > > > Nothing changes - rtw88 in AP mode sends multicast packets, but oth=
er
> > > > devices don't see them.
> > >
> > > How can you assert other devices don't see them? Receivers don't ACK
> > > multicast/broadcast packets, so have you added debug log in A or B?
> >
> > Because I don't see them in tcpdump output.
>
> Multicast packets from A (in AP mode) didn't present in tcpdump output of=
 B, but
> multicast packets from C (in AP mode) did present in tcpdump output of B?

Yes

> > > Compare air packets in non-secure connection between what A and C pla=
ys AP mode.
> >
> > I'm not sure what "air packets" mean. I don't have a radio sniffing
> > tool to see what's
> > going on,
>
> rtw88 can be a sniffer.
>
>   sudo iw dev wlan0 interface add mon0 type monitor
>   sudo ifconfig mon0 up
>   sudo wireshark  // select mon0, and switch channel by GUI toolbar
>
>
> > and by the time packets are available in the driver, they were already
> > processed and filtered by hardware, so they can't be considered "air".
> > If you have a specific place in the driver where you want me to put
> > debugs, let me know.
>
> I didn't have a specific place. Just want to know how you confirmed
> "AP sent packets" and "STA received packets". It seems like you didn't
> capture packets in the air. So please setup rtw88 to do that. By the way,
> monitor mode of rtw88 has broken [1] somehow. Please use older kernel to
> capture packets.
>
> [1] https://lore.kernel.org/linux-wireless/5318640d6eb74301b1fbf6d9385ba6=
9e@realtek.com/T/#m6984dfc4a85b389511c253c2b97547a4148e83d9

Ok, I'll try that.

