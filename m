Return-Path: <linux-wireless+bounces-37492-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U3YgJL5+JmrTXQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37492-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 10:35:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E78946541B6
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 10:35:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="QV6Dd/Sd";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37492-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37492-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CE5F30453BD
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456DD26AE5;
	Mon,  8 Jun 2026 08:22:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330983ACF0B
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 08:22:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906967; cv=pass; b=KjbP49M9nRUDGHcm8ZM3L/cQay7nOYXitpaEm4j6yrOl7sGqgTBSyk/RWDOflznFYX6WI0t06crcJRzI6Okm4Q8MW8TFCoAY1GBQOqKkvT/R9Nh3jMLny08ccjjdGy6YaSP2egJ5bMbLt2YVShoY4Fo4bVDaT8de8J4r3lukRjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906967; c=relaxed/simple;
	bh=V1Q+qFMXpxVeNP3nVattManJN37EJsg6DFMu6D3ZRck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LamrZT1tn7sBjIumADgAAXG8XP3JxX++VA8seETzy4jGs8JmmjCN/uHyNyPt8QVvUlpJdO4O/JEkFCUJBlugqrveQwzK1htZFR/v7MrtfabYtOAXqUXxk+GyO90zgcY8IBMYBKBm0BUXYEWgFE5Zqnl/BeVGPCEMIPW4iOZDbH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV6Dd/Sd; arc=pass smtp.client-ip=209.85.208.173
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39676d82b7fso39651511fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 01:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780906961; cv=none;
        d=google.com; s=arc-20240605;
        b=amQeEovyhreLZNTJcPGCDA/rgnZbT0dp7kcFuyTAQfsshXx+reE7Vrilfh7k2H/Gwl
         YcY9JzLzenSko95cMR7BEsaI1A5I+Jwppxfv6zfqXDNT/EzuVheSLZPZwxA9fJ4dnZR+
         bv8O4EIBGoxz8UocugBp8k43KOtflnYu1VoVE4D6B7Q8GVq6QiBBoScyimVztzVckNdw
         kxTH5VbM0sjHfVIhFSlv+XIxxMbMu5hmqIhPvAVeEt1E2aFVkolFBB0QAFjVEnEUDNRc
         asUbVLcvPEPv8V+7pE57rjRTrGfI1riFUkfdStdj7T1ru6CQShsnORJbdSAhF4op+pze
         J7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=V1Q+qFMXpxVeNP3nVattManJN37EJsg6DFMu6D3ZRck=;
        fh=hdzZC+/8zcbG7mUL1LVwezAX2ERL/XV9wrrwvnUlU2g=;
        b=k9uFW4dX9vxvqgpMIKWD4MNAdEfxoUBLvEpjK7H7/b3ByEb1FhhUoUptsJXmwVKZY/
         /iKaDhKV+fheYwPNp2/pNl2cXJsWHnyjY7bECWvLWJi4QgD4tq6EedMGzTs08ruiHNZt
         Oi6r7/P9I+D1ve1YeHMHt/3yMlaXUySopkVj55hZ0/xCF2aL/qBMJ8lO0BUw/j7AQOIS
         u/W3mVleCbsk/XvXn+C6yIWsA+YVkWYuqVpzy3+IFYQi4HnkGxFdSJQ12Vxdm1sUL3oX
         G0xAnT6jzYwt3lDjnpnTQxT4QfvyDT/jHMFpJwLcyJ6emkIQe+gKux/C0UBOx2daJuH7
         eM7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780906961; x=1781511761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V1Q+qFMXpxVeNP3nVattManJN37EJsg6DFMu6D3ZRck=;
        b=QV6Dd/SdegluSPRJ77ZY0YwyaM5npmnXyya5RA3aWm1lzNNHp0k3x1/T43vdaS3DOK
         YDi1T3Jnb2JLgt+mbisyf5s10I79VAVk2sFT+yNHCwyy8ljX68+5xK9KtErdKjbRbo1u
         S+ZjDgdx9y9j1d+9XsdqRupED50Z0/06OkR1EZDCxOy+aTaOsvYdDv/4hzWT9y5QEwyK
         L0vquLmiQcFyZI2ptJKNJF7b6hQv6LQAm7iQ5CcoBuZwcLKmGoiFloZJVf1SzxY/Ozk0
         KXIzRgxZh+KSNaYAFlGmgfrlgH1hMuSGDOKQr4++6Dphuq0gY8w2Ec2h1H+ki4HOP+ar
         hOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906961; x=1781511761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1Q+qFMXpxVeNP3nVattManJN37EJsg6DFMu6D3ZRck=;
        b=Tk7Ck9Gk43O4mWt8RxDJcIUklgAx6drDKx9ypMj1oYa1fMZ2S1orT/Lq1aboKOLJi3
         sj7UUm8Y2/AmDhxlrZNWrNMW0Dq5pxgKgKS7ORRlFATFXu0XSlZJCkKl6R0Mwspfzmyb
         rWcAxY05wtAh2eiCepOIbuXgUgF4vdFsL+0rx7gvO8iczKaH+5FtUzhJbK1xFzEvy9b/
         GvxQg3dnExqHoxcWP1nCHG/nmeH0xVFZU4fClFYjQhiu8IuQzR8wZuAJBS9FmAcdJUDC
         hpKpKvk7Cg5gc0y1JzBoN9GthdvsDbEDw6NUP3+1QZ+TJC7IsoL6IhIkHYoQXbatn57K
         eoBg==
X-Gm-Message-State: AOJu0YyvR1HM9NBRx/D/HGc7Cq34I0uhyb9uZ98jcxtpvX8RGSFJJjgu
	eKfOhH/caSLHAuMxzB7ZcPIImTX11LuU1Gdt4sy2uRCszEfuu3/3/hepmBCujB7V4MBv0X1L49p
	Vldk9dT+1D+VTnoU+ZkhkLmjVf9JnF7Yp5brDN9k=
X-Gm-Gg: Acq92OFcQvwBAMIcAajSJ7bCtlGupSSffbQ32qG71We6Jyc30aYtK+liIQd3q0GQiME
	HU0yIvzCaFvzmisRpGxB1nKWzcQa9JFUqVlWN+3JKwGdrQJk2hsc2vymSMa1qIR/DJ+WGwgHyiW
	ngBK4f8vIoW9jEeUXuHvYt3l83MNU6uDb5Ny8GUvVoWpG0hJe2jzYxcumxZJLT8tHSE8O3JYl90
	uFYnpWwtR9tyvKhYl7jKdI7eEfvLN59eDDkpTppwUF3NWd/a3zNSWdjYik/kenPgQCTap+U2I69
	Np6suK5WoarhrfiGg/Trmq+kddNC9FZSwvs9hWkuNl/bG+2Yt6H0YjUt43ZjdDrc
X-Received: by 2002:a05:6512:401f:b0:5aa:6f89:9375 with SMTP id
 2adb3069b0e04-5aa87c2dc8emr3420712e87.29.1780906960721; Mon, 08 Jun 2026
 01:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1779269054-14963-mlmmj-1e4bac1a@vger.kernel.org> <CA+icZUVmdgL1A6mpFxMEtMtikwbkH5qWWyuEn-JOeSU80Q-mvA@mail.gmail.com>
In-Reply-To: <CA+icZUVmdgL1A6mpFxMEtMtikwbkH5qWWyuEn-JOeSU80Q-mvA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 8 Jun 2026 10:22:04 +0200
X-Gm-Features: AVVi8CeMsvFLoPHpvde1CSJd4sX1IbpHt0U0DPJeWSDYS8aJyqEOTGjtyrzfxmU
Message-ID: <CA+icZUWx8_ULgXkiOyeVuJDA4PCTvfFttcdYQphCHausdueu3A@mail.gmail.com>
Subject: Re: Unable to unsubscribe from linux-wireless@vger.kernel.org
To: postmaster@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-wireless@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>, 
	Sedat Dilek <sedat.dilek@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:postmaster@kernel.org,m:konstantin@linuxfoundation.org,m:linux-wireless@vger.kernel.org,m:sedat.dilek@gmail.com,m:sedat.dilek@googlemail.com,m:sedatdilek@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37492-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sedatdilek@gmail.com,linux-wireless@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sedatdilek@gmail.com,linux-wireless@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,googlemail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sedat.dilek@gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E78946541B6

Hi Konstantin et all,

Can you please check or help me find the right person?

I registered linux-wireless ML via <sedat.dilek@googlemail.com> email
(email confirmed in monthly bounce-email from ML).
In 2005 short xxx@gmail.com was not allowed these days for users from Germa=
ny.
This restriction changed some years later.

All my unsubscription emails are sent as <sedat.dilek@gmail.com> and fail.
I still get emails from linux-wireless ML.

So, how can I unsubscribe successfully?
Any hints/help much appreciated.

Thanks in advance.

Best thanks,
-Sedat-




On Wed, May 20, 2026 at 11:31=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> Hi Postmaster,
>
> can you help me with the unsubscription?
>
> I sent an email to:
>
> linux-wireless+unsubscribe@vger.kernel.org
>
> And get the below answer.
>
> Best thanks and Best regards,
> -Sedat-
>
> ---------- Forwarded message ---------
> From: <linux-wireless+help@vger.kernel.org>
> Date: Wed, May 20, 2026 at 11:26=E2=80=AFAM
> Subject: Unable to unsubscribe from linux-wireless@vger.kernel.org
> To: <sedat.dilek@gmail.com>
>
>
> Greetings!
>
> This is the mlmmj program managing the <linux-wireless@vger.kernel.org>
> mailing list.
>
> You were unable to be unsubscribed from the list because you are not
> subscribed.
>
> If you are receiving messages, perhaps a different email address is
> subscribed. To find out which address you are subscribed with, refer to t=
he
> message welcoming you to the list, or look at the envelope "Return-Path"
> header of a message you receive from the list.

