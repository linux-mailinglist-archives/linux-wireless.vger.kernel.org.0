Return-Path: <linux-wireless+bounces-16360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F559F0671
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF86828435B
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3C1AA1DF;
	Fri, 13 Dec 2024 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrAGPxIe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5221A8F9D;
	Fri, 13 Dec 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078966; cv=none; b=D1FZuQI36T6WxBSlBzO7pCxNVPNZIaXG2ZWRXvs9m94jiNTMYrINSdB2omK41nlc4tqHxZygnXfNt/+5zo6KZgSeFyrhVm9E8LE0Y7RvCsniALMnPaqVs9iJAKaHWWqldNh3ye1S0AHHwKfDYgfMYj6xalfFud/Rq4Be3Ra5lU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078966; c=relaxed/simple;
	bh=cwDAQSL6vuttS2U979Dz48haJPwu372rR4K4KD1V+60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HP5yijdPpYgvHRk/Y5XaQe//1ngDPDylpGfhR/ixghuJ/9IPcu0cQQoOW6uDB2dbC8HBR3hPLaOgosKo7PWXVaQUKyHgyAS8ONvRZUyA+gGSf08ZUpNxpMTl3dgo7hpueEAr0eHueIszmqVgGtBcnqyxJstkoh57dpFgBdSUTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrAGPxIe; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71e1d7130a5so776156a34.0;
        Fri, 13 Dec 2024 00:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734078964; x=1734683764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4mjN3RvlXaIu4Z7K4aTVENMghR+huMJZIDwJoq1+Bg=;
        b=SrAGPxIe/ifCKM36zSQOMfWDLxZyNX5UjSj+MA55nBzaHzBFs55ChdiP8iwvorc2et
         LPh3gwOXPaA1ysDjp+SwWsg9U3okWYlYpFLAUjbKXVverZE9vyWa+UeSBYYjdhOB8ky8
         YCD/pmAaAIY3bu86QR23sVjbN/Jzxx6QqCAzS5ksoRtLdQGSTWE0744hixqiyWWeOIPn
         /nrJywhGnMCuO07Wdjf9o0rZ3coWmaU+TXnp7pQDdeKL8b62+1Y/ykcX9iyzQrLLqSuK
         ohk4WnHeh+Bjjl4cSPuOzVBCp4WJiEduPVRqejPY1oFUnzzPh5Z1M0dBN4a43SjCuByG
         K3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734078964; x=1734683764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4mjN3RvlXaIu4Z7K4aTVENMghR+huMJZIDwJoq1+Bg=;
        b=ThtiX9kz7mZG1Qr6XX+EQK5t95i/rs1uoA64XICe+5Vb4m8v+DmLLEv2n3v0pU7O0R
         FrCxlxnVtIPk0vbakYl6e7/t3TcEFiB5a6KRhcqCyEuwEtEh7sQdVKj/Dm/pBtTq68xH
         swUhK3Bp1Amo7QN5RNsBkOd/qvKo8HxgGYvJE1SvaTIFwnYDIEs4ZBMToPUlAf9aRL9Y
         ajBHglIVC0BNTXVb6QYX9XZaVR6/DEzy/wPbG1SYy1ZOTRSLibu7nmFbEkFY7s2pGI7g
         UhiL+JLlbLyMyP6nxCTfiTD9+rkpjag8FR+eA7sH26kOgdVIuX0wg9Dujat3Y4NSybA4
         tI8A==
X-Forwarded-Encrypted: i=1; AJvYcCVA1xfEnfbhfNeDiXLT43B8P8YZPtPpEXi2sS2Wi0xZkqrEKz0mptUrmKI0tGwXfWN0bWowyj4pGaw03qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/uvHyYJCMv7SEJgTV925m22s6Jsy+Bzxe49CO+xIhuVvHsQjD
	M3UB/9oWcj1t3mF5AzovIKYv3jsHpobS2R71SX1ceUIytuWYFr8xuTcIxk5YKbMQ1WrE6e73J2p
	3NU6Lr3//DyxN8Pp6x8hW1mxEHQUoUiGG1umLng==
X-Gm-Gg: ASbGncuUpFODl1ZEJWSunmHKnuABa2O065UvRXILzze83XgbDcAi2jz5FugPVlYjfKM
	wUjbcAcYOnFWCsyKT8ap9nUkuwmYJzYu/l24g
X-Google-Smtp-Source: AGHT+IEjGqxi8FLoj8CpGN2+LUvhxpaV3aY/lsPFS2q6djXX+/0dDgyAdcTFPpNQeTOP7455einSNxdeVpg/wUeZCdU=
X-Received: by 2002:a05:6870:3c08:b0:284:ff51:58ad with SMTP id
 586e51a60fabf-2a3ac8b7939mr1173933fac.27.1734078963999; Fri, 13 Dec 2024
 00:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122180435.1637479-1-alexthreed@gmail.com>
 <be2f054e-5ff8-4fcb-ad50-0dc0d5c03bf5@broadcom.com> <CAF4oh-NtqAX6gqz3DnLes6oR3RhZyOEvSfOk=rPPPm=1XzGAWQ@mail.gmail.com>
 <7c85313c-58e2-4bff-a525-a40f8aadcab9@broadcom.com>
In-Reply-To: <7c85313c-58e2-4bff-a525-a40f8aadcab9@broadcom.com>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Fri, 13 Dec 2024 11:35:53 +0300
Message-ID: <CAF4oh-MufW98ooTQstJFRF1222hNyOdaCVUaLMpYsRzqo6FGZg@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: remove misleading log messages
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Kalle Valo <kvalo@kernel.org>, brcm80211-dev-list.pdl@broadcom.com, 
	brcm80211@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:30=E2=80=AFPM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 12/9/2024 9:08 PM, Alex Shumsky wrote:
> > On Tue, Nov 26, 2024 at 2:02=E2=80=AFPM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On 11/22/2024 7:04 PM, Alex Shumsky wrote:
> >>> Currently when debug info enabled, dmesg spammed every few minutes wi=
th
> >>> misleading messages like:
> >>>     brcmf_netdev_start_xmit phy0-sta0: insufficient headroom (0)
> >>>
> >>> Do not log this when headroom is actually sufficient.
> >>
> >> Thanks for your patch. The message may be misleading, but it is actual=
ly
> >> information that we need to cow the packet. The zero value indicates
> >> that this is needed because skb_header_cloned(skb) is true. So it is
> >> still useful in my opinion. If you want to make the message less
> >> misleading for that case I would be happy to ack the patch.
> >>
> >> Regards,
> >> Arend
> >
> > Thanks for the review and sorry for the delayed response.
> > Do "%s: clone skb header\n" rephrase make sense to you?
>
> I would say:
>
> brcmf_dbg(INFO, "%s: %s headroom\n", brcmf_ifname(ifp),
>            head_delta ? "insufficient" : "unmodifiable");

Thanks.
Sent [PATCH v2] wifi: brcmfmac: clarify unmodifiable headroom log message.
I'm not sure whether I have to link new version with changed subject,
I haven't found a way

> > I have no deep knowledge of this code, and if you think the original me=
ssage
> > is actually useful, I'm ok to leave a log message as it is.
> > Initially I had guessed it was an unintentional log message because it =
has
> > misleading text and logs spammed every few minutes - too rarely to cons=
ider
> > It as a real performance issue.
>
> If you enable debug prints you should expect performance impact. If you
> want to capture debug message with negligible performance loss you
> should use ftrace. Debug prints in brcmfmac are setup as trace events.

I expressed my thoughts poorly here.
By "performance issue" I meant the clone process itself, not the log messag=
es.
I have read "insufficient headroom" message as "look, we need to copy heade=
rs,
if this happens too often, look into this issue and make it zero-copy"

> Regards,
> Arend

