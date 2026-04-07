Return-Path: <linux-wireless+bounces-34491-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gImtKn9B1Wk73gcAu9opvQ
	(envelope-from <linux-wireless+bounces-34491-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 19:40:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDD93B2790
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 19:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6229A303CA49
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15DD33F38B;
	Tue,  7 Apr 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4cAwiv6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78934404F
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583330; cv=pass; b=Y+ta8DxlJdMb/z6OYdU8cNc/eyYaFRoSRFEvJ6KqsHznpKSBVXOE1HByBG58ezel+0uEe4xYFKpTbG8D+Z+xi0MZXoENMnMjsXYNuC83XFS1yalv68QrjEPo3sF4QOR33byK5SE+5P4z7gAeaIZYQQYKclWcmHve8pbpvDW9Mv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583330; c=relaxed/simple;
	bh=bVcou+Gprm8jI+MgNIWQTYr42AbaKd/ho0YCL94TYdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sta8NbzQmXNAEKThv5KaegLm3X/s0s9J77sZZSs424GhVMfdGxWa6pzNDLFf9I3CgSvzCJA6fiX+n+BEei331DPoVi5JyPd5ReYUwPzU8PlzvSS5HTJNCUgR+BPJreLFZJMIT+qfHMbUNpJP71UgPXyjfODcPhEfBW4gUbQvc5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4cAwiv6; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-953a5defbbdso53480241.1
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 10:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775583328; cv=none;
        d=google.com; s=arc-20240605;
        b=SXah3ySnSaysWYXXs0B895Fkx20wzKF/dvZUkqHgSrgyfRhEYnrz2tFnlF5mRtyMrl
         srPmRi4h/yCgCJWPHzDJa/MULW+9phCZdoOZK8f/cCacsSpd82USFOkY+PWtE9Ep2HMx
         xyE13+aGzoj58ALN5F6A3JJNvAPyAMkajAqa9dmVqlzG/Jmwa4uTikUPQBWvZWP6O/iI
         UNkxE090eLxmpU/pK/ba8DCIHlKoKJgueLo/zBhxbPj0qDQLYVRJ6ZkCo1VbNxKCRWBN
         cw9mhSWjh8259UfW3bUDGVfNU/ecWDPVanxhKZUDSlC4vydtqqrYp61nJ4c4qxlt1xDd
         Kr/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0d7dSyKzAyZ8PECEnJjvu70SAnmL644NrgpjRWVsEo=;
        fh=z13KRDOBL26GXrXq9EJJjW8Udv+4Is3MOUPGIn9PAN4=;
        b=gIs3xwDgbVAcFbrA+wcpieG4pRA3zjI7Sp3qwbKBO2f21RnmUO1KNVNSRvRnmJhgKA
         gax4u5nIWvyRRIFd+WBy4w27PljYSa0AM02EjB+mZ5oRyA7TPvgwkKV+XU8YN0XiiaEI
         KbF7sSwUtx7fbOeyoj3IiaGeiz+hFBH1vGExnCcYZ7GFaI9XWtsZZT9Ndf2AD2GAOnmL
         US7EnRv7Xz349kXV8rNtJcKzIaciKrFDaYs84Yepj+CQrbIuzRyAmlcn4e76P1xXc6cw
         YUp0T9W74sk3dnCv9OTI2lBrXskx/CJ2W+Yo8VibTKQe1ver4Q7R+Xi1fzmUm0JOy1d7
         AUFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775583328; x=1776188128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0d7dSyKzAyZ8PECEnJjvu70SAnmL644NrgpjRWVsEo=;
        b=F4cAwiv6xG/b3XUADEDIdJBqQk+j2gWcrri+DtPEKJAT1/ca5p83YNVNnFdmqf+GSQ
         eZeeGa7hP3mYZhXf7thT7tPM4zkpW9+S6XOkrqMnWxh4x796RbGY9ppMZeVaKsKDYL+M
         7oLTJNGRzLx1Jmz2GHKgtuH565TI6OMyL6MoGx5hmBlrlwZlZ7ziAHFtS1ACjdPfZyuX
         se3NPNCFbnMiMdjcNyONdB1YmSQkbtEaTvqNKMECRJawfHzoM6oknl2g4pF1bFejaPsK
         j+PSffQb7eXJiWAVviiaMm9jCOP6PR5COpBfL/hhpHoj4V4XLuTCNGWJb0pH0DqqlOZ9
         70RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583328; x=1776188128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0d7dSyKzAyZ8PECEnJjvu70SAnmL644NrgpjRWVsEo=;
        b=YAiCr3Vpj/eG6QCzm/mrjyC5asSGkLz/eYcG90XdhB4ygab5VoGBUUKyeYzRIDM0EY
         eQP6R8Of9TJ296emF/QzocHTAf+8yyU2LHaDY8kLxexRKk7KEH1+3iaGBm5SFGCUJveP
         FPgpevH5LCKPLb45SMGtRJrHaPSsujoRdwLuCTMpaJQRCL3hA53/65Z11UwgTfB3d9V8
         mYx/zqwdv1/zDU5fe2GIVDz0IztAwEffq3HKaHEczSOZvsyhm4RTa9gECyPnRqgXMM/M
         fptGdk9O6oZgA348tNAC9eCyqVU3fXtD3irijXPhEpYGDQ1l4CXtoqVBMYm2Ut0NJc53
         LBTg==
X-Gm-Message-State: AOJu0Yz2whhbV0GYoRsBSSqkLFTILwNRQ+UgYvpJcxFo1FgN9+j8aD5x
	3NpkHzXnbzkIDJ9WkgB/Nbb6hPcvpG1N6F4XYG29PUbN91Oht+TL7h5FFoCV8Xo5sTUgj8EQUvC
	UV4ewvheO75XnTC3UGpMHCkqHVimht8I=
X-Gm-Gg: AeBDiesCNkswFOKbBRWFJ8iE/P9bgZHRVQDcW+2Gbf5T1u4H2tATENvKW3BHrACTggl
	U+bOD1RKJ/iOx65p0X+flf5GYsiVe+SK5QIcWotBuEb0xBdn4nLN8LUUuwn5D9Ac+Zv+aimpxP/
	uoEg+BkxI9C2lEr83Sfsw6QtbN1arUKDouNNZv+K3sseLoXCpIC5nGcvyjYBWymNqW2asmP02jd
	/MMzE45kcRxW3eeEVAmKE+JHsZXv0EkgEwxvBAR4ZMy5qaudf17qSffHtGVFO0Wx9oT0BOZD4vX
	H7jSt/V58atQHg/94y8tQpNW9oWHamZ8EzQrjTQ1
X-Received: by 2002:a05:6102:94d:b0:5f8:e41e:e5cc with SMTP id
 ada2fe7eead31-605a5034c28mr5433959137.9.1775583328358; Tue, 07 Apr 2026
 10:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
 <20260406234739.29926-5-joshuaklinesmith@gmail.com> <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
 <CANs=ypgdgB_3stm5bCvO8RTat-sxs0N6SAaeYSQ-dyq43U-ZBg@mail.gmail.com>
 <ddc4ccfe-27e0-7558-9b5b-27b4c4fe54b3@candelatech.com> <CANs=ypgceH4NL5xOr2C1FPp8KvDCcUWTu10i+DiXntuOmAfJVA@mail.gmail.com>
 <5e197844-804e-51d7-a1de-e9e7686bad0a@candelatech.com>
In-Reply-To: <5e197844-804e-51d7-a1de-e9e7686bad0a@candelatech.com>
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
Date: Tue, 7 Apr 2026 13:35:15 -0400
X-Gm-Features: AQROBzAV6xaHAvXHRyVUe2RM59GmP1ed74mWrJcyksvjS9RgAmFB4oykGjkFOUg
Message-ID: <CANs=yphvbzzDHFsZZexSW-7YZTU5zRc4P_iapvCH=NK0f_XbMg@mail.gmail.com>
Subject: Re: [PATCH wireless 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in
 sta_poll RSSI extraction
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-34491-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,candelatech.com:email,candelatech.com:url]
X-Rspamd-Queue-Id: 0DDD93B2790
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 Ben Greear wrote:
> If you talked some AI bot into finding non public source, or if it can
> actually generate useful c code out of vendor binaries, then I am not
> sure how legit that is to even post.

Hi Ben,

Thank you for raising this point. After considering your feedback, I
realize my workflow has involved analysis of proprietary vendor
binaries, which raises legitimate provenance and licensing concerns
for kernel submissions. I should not have submitted patches derived
from that process.

I am withdrawing my outstanding patches from this series. I will not
submit further patches based on this workflow.

Going forward, I will limit my contributions to fixes based solely on
publicly available GPL-licensed sources and will clearly document the
source and rationale in my commit messages.

Thank you again for taking the time to flag this.

On Tue, Apr 7, 2026 at 1:31=E2=80=AFPM Ben Greear <greearb@candelatech.com>=
 wrote:
>
> On 4/7/26 09:58, Joshua Klinesmith wrote:
> > On 4/7/26 12:31, Ben Greear wrote:
> >> I am more concerned about the trickier patches that you have been post=
ing
> >> that is utilizing work from upstream vendor code.  How much of that is=
 pure
> >> AI driven?  How much testing has been done to see if there are actual =
stability
> >> or performance improvements when testing actual hardware?
> >
> > Hi Ben,
> >
> > To be straightforward: my workflow involves pulling GitHub issues into
> > AI prompts along with firmware analysis tooling to identify potential
> > fixes. I have an MT6000 available, but I have not been doing thorough
> > on-hardware testing before submitting. That is a gap I need to close.
> >
> > I will hold off on submitting further patches to the mt76 driver until
> > I have a proper test workflow in place and can verify changes on real
> > hardware.
> >
> > I appreciate you raising this directly.
>
> Please be sure to add note about using AI to patch submissions,
> and link to original bug reports you are trying to fix.
>
> Possibly some of this is useful, but you need to do significant tests
> with real hardware if you are proposing non-trivial changes.
>
> If you are referencing publicly available upstream driver source, then
> be clear about that and provide links.  'Reverse Engineering' could mean =
a lot of things,
> some of which is grey area for patch submission.  If you talked some AI b=
ot
> into finding non public source, or if it can actually generate useful c c=
ode out of
> vendor binaries, then I am not sure how legit that is to even post.
>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>

