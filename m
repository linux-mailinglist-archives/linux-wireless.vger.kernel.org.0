Return-Path: <linux-wireless+bounces-34769-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF8BF4x832lAUAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34769-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:54:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10414040E8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 13:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC52E301114E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 11:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F40534B693;
	Wed, 15 Apr 2026 11:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyM3hYfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F03264EA
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254087; cv=pass; b=MkCLMK6sLDWfvBZzeMr2B990pQKsZA1yW9TU9ckoCsPl1CMsW5FuQ0l344K3EfZI6+uNjq07tMMoVulhWGCQDkxPjlFoFCNQxMbMx1WFcShn8lgXLXKEbCLBXY47QPpgUOq0QhJgUEpidk1ADgSYRwAj933IjHcTjHKKgdMQWQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254087; c=relaxed/simple;
	bh=2vZwi8QEEi+HIwgWCDasjUUY50blYwrtVhN1djXYqjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6mc2i4N55mVy2J7FM4P+XblReYzHVlbOvso/EkC0jHsV0AUWD7I2SFLiLyWdy4uJQk+xYMTVT3wLcxNGstk9K340IFgzRQdqMpZoPubYhiyP8yDlzSAAdrWazept5PPTowGNtG+liH4Nfv9f2kZtjNBg1RuZ6AGXFAEXa0HIHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyM3hYfm; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6501d242e3fso6259193d50.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 04:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776254085; cv=none;
        d=google.com; s=arc-20240605;
        b=dwv23rbtFpWozIgGB4qGCqjoa9oBdn+7ZiOK+uMBCoOCfREJ3ZxmSa9YKC5ygDPfnl
         KrZHKibDTpQkbl/2iF6a2qMI0y2TPJEwvlYdeE8+s46OfDCnIWebuuGzKv6hEDBjVdsE
         GOvS6xgAdharGyabzCswSQcvmR+tes+x2mJdY98b/rF5fM1NQ51h1fOOhAOoe8zm9nWp
         84LIZhHaslg9CI/JE50upL5DDirI0PDRnX3PqwN4KerpDlm68Aqm2TrDOAnm7w3KYgfF
         FaZaJMtrggmhULJSiph5NljoUkMG6Uh1rffMYG9s2AkFqa9e9DDA+fCcOf0CFDx4erSY
         KkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2vZwi8QEEi+HIwgWCDasjUUY50blYwrtVhN1djXYqjI=;
        fh=y+WJCG7EzXz6KeDuPKcy6t4pIRp0BMkpunbNgSsuDko=;
        b=AnNff6SIixRouuaPhIgFaXx3s374ETT6kccab0qFKsDo+rBtpRNMEKJ9CEzcAxw9zb
         5UpYxK2Aw7cKhlbm673o6wDzzDu+iJMiYSK8uX8E3tGGH/AdaGIOl563bevohFpFdeoD
         DKIMkRK3WUsoOvbEesKDatUpWKlFhk6vLO/R9vtpX3PZhZ47i+4NbFhEM9nFSOUvB6aO
         MrRIo+c79goiV8HRSj0+uwSWpRMC544BNvFjNey8TUB8SPta/uA/kDkfHD4BYJnqSAQx
         Et4vwWdPRCrhkXw/tNTiLuSnBo+UYz2H4/vgbgrVaySc1CzL2BP/g7KBy/O7v5e+flgc
         gd6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776254085; x=1776858885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vZwi8QEEi+HIwgWCDasjUUY50blYwrtVhN1djXYqjI=;
        b=CyM3hYfmcpA5dxt2KYlNkcLalD9TnlkHmxSlE3wyAhYoeJJ9PF7RAeSwdKYUc8djIj
         JwYBIFrRg/rt9l1hBHpDwuClZehJ+TMuciNhI6/Gi9H6Zj9hVCxr1HvX2qZzUacpbo1k
         SEJn992myLRXPeIUFf1NSBCM7yr9ipBnxJPyIm5gZCad+aVXJNOkySxAByhz8l7HBhHi
         hYxgz56Ixd59ebUSbA0ttcObPBVI0xn5h5MNgM+z9BWpnlYFdw/8u2vB5Z0oIZZ2IwWb
         kLyajxe/gg6bxJ8RLup/OHNxM8ScGmvaYheOYIpEHI2HzAVqrmNkeIG+zQ7zLtlZpg0P
         7vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776254085; x=1776858885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2vZwi8QEEi+HIwgWCDasjUUY50blYwrtVhN1djXYqjI=;
        b=Vhyu/MQVNeGdNFCuL5KGVudWfA8c/T69K2+GEA0jeFhF5auRfoG2gFTXnvUkWXpAvS
         +7z6DNL5uHeYyQFAIf4vq0pXVAWDw7WcCVX0DdopbQqpXvpGQAuFkcfh9UTYcp6lCEUv
         JRG8/ONl2eItAbbfpwqxfe1mJuUY7w848DGKPozmqdsnDxHKQxsQyOCwtaX3f45Ukh2X
         kTMopI1X1O6MxiEX5Bke4Hkpy1rmt324LZ1ppszEMMpgF4mBut+aNqUTYAsDviZgHIQb
         weTN8O8t/biZLhVnEymIZZw2OYXcC2/cPYtSYDh53KC3tbdngklfuy4Vz2vWC/GJRID0
         ASsA==
X-Forwarded-Encrypted: i=1; AFNElJ++JUj3mi1doqhQS5fxDDoTXnbse5LvMSgXmIKecojXbb4mTvjZYFlwGwo6XzsJ8BLmqUFw4qHFnna1EyuqXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBR9gtGY1YcvZiVufWwp9mrYkwN4IZwv9Uz42n3EBspTBCmZ7N
	9t7X/JIIO3gvAxYBiolCvCQ6vL/y9H+lOgK52dMRgpJUs/TrCAhDvnA74U6yVyfWNYa1nFSWPhK
	DgzI6gJvDICHEMpJjJPFa8Z0phAvCxcQzgQ==
X-Gm-Gg: AeBDietrHlSSfG+Q4jLsXpVCeWD3cSu24vUgBqNZ1fuWzFxItqUxpm7emENvweOOt9g
	AiJyyncQrlZFwRST147qA3E5SA6/YJ+HV4XqfGBNtz2sSL3Y2amv9Zw62Wh5hly1TXH48Wde458
	OnHamRAy0+IepXUQiX9Z6O7sJJn+iE0RNKFKI2DuHY7/NAXiZvotCqFcW/XdTzd46GUxpYdH8kK
	r7hsv0emuyiZ+y73BamFS4qoN/oB0Lp9GS+sOBN5+xT84EEBMJY2/DoiVjmFeJJLNIKNw0UbqQH
	oeYZ6ai2du8sqSXg
X-Received: by 2002:a05:690e:c49:b0:652:e1f6:2436 with SMTP id
 956f58d0204a3-652e1f6512fmr2057669d50.19.1776254085024; Wed, 15 Apr 2026
 04:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DHS1BJ5XFYRC.GCF9PXS0OSRI@ubuntu.com> <c62a448843f189d78187de18d3fcb955f2779d13.camel@sipsolutions.net>
 <DHSUDVMGW0PS.2LYWKGG1C1135@ubuntu.com> <CAOiHx==kVm0OKWRKi4VHSEEr6ZygzrpNiA=zj+zEHT6_rgZ3CQ@mail.gmail.com>
 <DHTPAVC76140.1JLO3HNQARQ9Q@ubuntu.com>
In-Reply-To: <DHTPAVC76140.1JLO3HNQARQ9Q@ubuntu.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 15 Apr 2026 13:54:31 +0200
X-Gm-Features: AQROBzCWFymNwi5sMvsyuMNJgPtayHKvsZuFuoGcUyQ5-Qe0j95I0SeibDZjGXI
Message-ID: <CAOiHx=n8awRRvArvG8sWqEokojXL6ppFRJ8_SOuGAddDb1D32A@mail.gmail.com>
Subject: Re: Firmware for reverse engineering b43?
To: Joshua Peisach <jpeisach@ubuntu.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, b43-dev@lists.infradead.org, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34769-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E10414040E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 1:44=E2=80=AFPM Joshua Peisach <jpeisach@ubuntu.com=
> wrote:
>
> On Tue Apr 14, 2026 at 8:24 AM EDT, Jonas Gorski wrote:
> > On Tue, Apr 14, 2026 at 1:31=E2=80=AFPM Joshua Peisach <jpeisach@ubuntu=
.com> wrote:
> >>
> >> On Tue Apr 14, 2026 at 5:14 AM EDT, Johannes Berg wrote:
> >> > I think there's no easy answer - what are you even trying to achieve=
?
> >> > Does b43 not work sufficiently well? Do you even know if some specif=
ic
> >> > calibration have a tendency to go out of whack? Is there later firmw=
are
> >> > that has some advantage (given how little actually happens in firmwa=
re
> >> > in these devices, I'd be surprised by that) but isn't compatible wit=
h
> >> > the driver now, and you want to change that?
> >> >
> >> > I'd be tempted to say that if there's no problem there don't try to =
fix
> >> > anything, the hardware is ancient anyway, likely has few users, and
> >> > those users would probably be fine with just leaving it?
> >> >
> >> > johannes
> >>
> >> The BCM4321 (nphy) doesn't connect to my 5G network, so I figured that
> >> by filling in TODOs and FIXME's, I could eventually get something
> >> working.
> >>
> >> Other than that, I was thinking of making improvements for the sake of
> >> improving the driver.
> >
> > The initial version of the brcm80211 softmac driver [1] should also
> > help in making sense of some of the code (flag names etc). While it
> > officially only supports BCM43224 and newer on BCMA, it still had
> > remnants of support for older N-PHY revisions, so may help in finding
> > differences or explaining what code does.
> >
> > I once considered trying to clean up b43 based on brcmsmac, but never
> > got around to it.
>
> It does appear to be similar - even the current brcm80211. So much so
> that I sometimes need to think about whether b43 is actually a
> duplicated driver.
>
> Since b43 is in an orphan state, I thought it would be a great place to
> start for kernel development. 5G doesn't work on that iMac, some of the
> PHYs, like the AC PHYs appear to be incomplete - it felt reasonable.
>
> Because I'm one of those "there's always room for improvement people",
> I was going to try to improve the driver, filling out TODOs, fixing
> hardcoded register numbers, etc. But if it's best left alone.. then I
> guess we can do that.
>
> That is, assuming b43 is actually supposed to be a separate driver,
> because if brcmsmac basically has the same code, then maybe we should
> focus to centralizing everything? But then there's b43legacy.. hm...

It is/was intentionally a separate driver: Broadcom didn't want to
maintain support for obsolete chips (anything SSB, anything older than
BCM43224), so the decision was to have b43 support all the "legacy"
chips, while brcm80211 supports everything never. Since they were both
based on the same driver, they are (more or less) the same
architecture.

But now that Broadcom has essentially abandoned the softmac part of
brcm80211 since several years, I don't think there would be many
objections on unifying it with b43.

Best regards,
Jonas

