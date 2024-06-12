Return-Path: <linux-wireless+bounces-8828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F872904B19
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 07:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32DADB20EDB
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 05:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57C36AF8;
	Wed, 12 Jun 2024 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLQV5Eih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1063838F
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171766; cv=none; b=MJyvfC/BWJ0U2G+7icdJvqWSvYrnybdy1zf8JlZqwGq7wzoUqJFlbyrN3MdpXkpPNW/y9Xxkob/fkzbs9+y7hFxxLEVocUpxaT1qmT2FkZXrOktn4y7kyspcA48JCY9zPtTfM/2G9MBpJgyNBssjz4uakCMTJ7pObdCb4O2jUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171766; c=relaxed/simple;
	bh=b9yhks8V9I8fvGe0gXrRea1m0rrtje6Vd08UZ/b9zhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxXwaz2jQwvTTvCc6hM4VIfBgrsz6eFCQCsWpy8pmhcVL5S/ubpz2C7q/sAGTe4oHiZ0S/XWbWV0ElwTnGWK3AaCCfden3qnQnlBpab2F0qHNbyNanAKGZvZiWBceoJvXA0WI4MhPJ3FYo7L8pbl5stSE2EJyZTscHw41DEdqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLQV5Eih; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6ce533b6409so1462743a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jun 2024 22:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718171765; x=1718776565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9yhks8V9I8fvGe0gXrRea1m0rrtje6Vd08UZ/b9zhg=;
        b=NLQV5EihW+iVCjqFebTEGZ9eYStylSwOQ1Qs9eejoHXx1kz1ZY5k+ZW5owMjdH1IZU
         h+cOafSZyznhnHi7hXcrvelBvCv247P23W9r+oCnu6gBtY2de+rJyuW5DHDYuWVFfAJA
         gDqtUrY7cIcW4D4VZHuYBIiWKMCIkjMs2CYl+iLYdGboA0ogsIi76+Nfn61K3aAY1t5Q
         lXhfoR/zvO9Z312r/7PlHTEC+5BW5LIsqWHooK67Ky+GHyTmVtkA8O6wpdvOfDSLq7Gl
         suEIalGcrZESk3/cvIK6eLNFAWsj6qqIdIwK48xcjoN1Wua8vsEuykjp6DM3hRHDaCRF
         JoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718171765; x=1718776565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9yhks8V9I8fvGe0gXrRea1m0rrtje6Vd08UZ/b9zhg=;
        b=MSpzzO/fDa+cYeN56B/7W5nxpgRyDwwufT9RWqX72pnSZrqas5OQJIqxOJ64sq4RM5
         eSmv6ZYJwgS+CgmobhX1LRL7W82vrpobOC9QEN41v+5dbuXBvYf/g223hHyJEvDLIO0p
         3pQlSqJhxz4mcdb8o6AXMAKZ8uy+pubkMXIDqY5COYIpzcspn7DsNHn2aOWnG3A9bnnS
         CS4TYahJGwMv7lxpjU+KqjxgTvf8QrF5E5Z5s5AvKaSRouqtKIsesS1UQf52CxcdfHKs
         0IjbxCDuKIXEOBlsApS1lrnNpnVCfrNApcUcKQE9rz2PJ4aRgGVEs277Kl5SX4Ektf2y
         1FPQ==
X-Gm-Message-State: AOJu0YyNFSaLb8Vx4DOLIJhqu2D56R4s2foNhMhsQVdlZWo/Zo1Br9VX
	itZTSEdnprP1EhwUV+92yuMH+yv8AEeFxmksVHZ0uT39D+CS9Vz3Xg/v5ZP2zSGHWqykWs59Uk7
	IaO4Pe0QVinpfVaKHvKxjoI3yAg4=
X-Google-Smtp-Source: AGHT+IHU6A3HqqcErVawiN2dlfDvAmGAZm2kTpKrNy0faB7DvlHLOKB0+YDhhIq86GNtfudIs3Ym85zE6LEfevRY3GE=
X-Received: by 2002:a05:6a20:918a:b0:1b6:d9fa:8bd with SMTP id
 adf61e73a8af0-1b8a9bc011cmr1354161637.25.1718171764665; Tue, 11 Jun 2024
 22:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+GA0_t7RPsqQ2XztOtRyW3BVZfE54h+Rg+fxRNPL8qwQWKeDw@mail.gmail.com>
 <868343c920c24204972ddaa108e5d00e@realtek.com> <CA+GA0_vA1KRRyvnURfdjwVv5JBkRhkjdQnwrRWWKmZs9_z-X1w@mail.gmail.com>
 <c5b42d8b818b4bd5ac8a6921a29f9f18@realtek.com>
In-Reply-To: <c5b42d8b818b4bd5ac8a6921a29f9f18@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Wed, 12 Jun 2024 07:55:52 +0200
Message-ID: <CA+GA0_vHeYLNw88KCnD9NACofA5rPJppj0nWZi+v5FqZLmpomA@mail.gmail.com>
Subject: Re: rtw88 multicast failure in AP mode
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	=?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C5=9Br., 12 cze 2024 o 03:30 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=
=82(a):
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > wt., 11 cze 2024 o 04:32 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=82=
(a):
> > >
> > > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > > Let's assume we have 3 systems: A and B use 8821CU chip, and C uses
> > > > another chip from a different vendor.
> > > >
> > > > If A is in AP mode and A and B use the rtw88 driver, pinging A from=
 B
> > > > and C by local name doesn't work because name resolution fails: ava=
hi
> > > > on B and C sends a multicast request to resolve A.local, A sees it =
and
> > > > responds, but neither B nor C sees the response.
> > > >
> > > > In the same situation, but with A and B using the rtl8821cu driver
> > > > (from https://github.com/morrownr/8821cu-20210916.git), everything
> > > > works - B and C see A's response and can resolve A.local.
> > > >
> > > > If C is in AP mode, resolving C from A and B also works.
> > > >
> > > > This leads me to believe there's something wrong with rtw88 when
> > > > sending multicast packets in AP mode.
> > >
> > > Have you captured air packets sent by C (AP mode)? (To check if TX pr=
operly.)
> >
> > Yes, I see packets in both directions on both C and A if C is in AP mod=
e.
> >
> > > Have you tried non-secure connection? (To check if encryption properl=
y.)
> >
> > Nothing changes - rtw88 in AP mode sends multicast packets, but other
> > devices don't see them.
>
> How can you assert other devices don't see them? Receivers don't ACK
> multicast/broadcast packets, so have you added debug log in A or B?

Because I don't see them in tcpdump output.

> Compare air packets in non-secure connection between what A and C plays A=
P mode.

I'm not sure what "air packets" mean. I don't have a radio sniffing
tool to see what's
going on, and by the time packets are available in the driver, they were al=
ready
processed and filtered by hardware, so they can't be considered "air".
If you have a specific place in the driver where you want me to put
debugs, let me know.

