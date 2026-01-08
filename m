Return-Path: <linux-wireless+bounces-30574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 312BCD032B4
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 14:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B5430133E9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233D4E2A17;
	Thu,  8 Jan 2026 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPRy/BrT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29B4DF3D6
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879676; cv=none; b=Lr7b1p+XXnDd1NmgVBp6bd6QOlveY9JeoMPT9MWgsR958zjYsj2vDchlSR1CY1tRDLFhb+BLQNiUj1LnX93sndP/sX5Ngt0jNEMUtc17NFNOWSDod2H74ZXkUgRmFS2bnJNy+JtGU4JU9ga2jcmcATtSJRy8PmbzAmSSZEGOe3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879676; c=relaxed/simple;
	bh=Y/redTSJJiFiCIi0nEgY3wpVQ796lO42ejJF82iJWUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzagXoB4mkKED5pF59JmIJOawlly4qU4XkzYdR9ZUpih5EvtVigOMqF+npPvC8deJV9mM6VEZt+i5WZTQUCpSrm6iHLKtNJr0PRW8/KNSS/sdRPURtCSrGyBy/le/EKimM0kEcoh1tEzSdrBN/kHxn03KqySW4YON93OIpucOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPRy/BrT; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-11dd2370722so581662c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 05:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767879672; x=1768484472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVx1Iceo8H7a1MGTgjly/2JCA8xXNTM+xi7dMPJELl0=;
        b=mPRy/BrTHA4R/O3GrEYstmYPWODMeq8S9ZBXGu654VfGwYINTaX215HEQdRgw7foSr
         eKYYQhk9vkgN0DraAHkN/GakreJ4n5tFQ7gRmI707x5QVFFt1/gzguOFEwij6LBPCpSP
         yAQfIv8qttbdBcnUDDtvxZWL1jVY0Qt9fqV0iI9eospKJdNg/S2Gkw3FaZDAJSs0jVpb
         Xe5XY5ovrnu84Hfaq724/Haa1mTjsZaL2QwDXXtHJRgiswAgKKdJtG6e1pkW15Y526km
         jBGNGProj4vZCKGab2vWUrthzFi6HBBNd9zEFpNp0ZfuP00g9mJtdOnztvDXUSDXL3Cz
         4ICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879672; x=1768484472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVx1Iceo8H7a1MGTgjly/2JCA8xXNTM+xi7dMPJELl0=;
        b=pAa9DPtR994sPKLaM1lwx8osEkaacnqnnOJowsF96VGANsBOvu/b2IfvwZUq/XrXzj
         exxVn8jUCOT4KGvvelsSDv28knkcIAzrt7U8yir7HVme8wBtS1ruSHUN9LTeXPpS9X2a
         XDnR9vK3+E6+112xxeizQSRZV10ZaGXK8kzndpNvzt+c52yTMN58s/h9J8pzi67hzi+d
         d/gHm0YpMn5NqHUNuvGhlYVIO6ZYQRxVYMCC4UsydP7NXv4xfVzS+befM0mit+ZdQ8Cl
         LT2GSPutil66bFbnOS7aP+ZTe1L0/KU4DMuTf6STbhuvcTXOybarE0YNYFVQG07LCY1Q
         VhqQ==
X-Gm-Message-State: AOJu0YwBsf+CdhcG1DRgi++f8aMFXIH3BFO9PBxWq3aRxur9mCGriGOH
	Ibs466lHgUu0mpsNTxeV1QNsuFG1vNA+94FMEjlSsVp/VmAsi+T0nRzufxubsxA2SCnOiVtvNTu
	DpPP30GBJuVBBKP5SnIT1g7xsY+p8QOY=
X-Gm-Gg: AY/fxX46QveRDBBu6ndXT2HpEkdgOudx0FRvrwGuGHKYkXRgq50k+9aze77RjKm19o1
	bgutZh2f1bMSDXXFX4cZpwXaKogU7IyeZfM0kDPGpD7Rmilh9V0t3wWLaRKzTOOttZ7YZm45b3b
	YVAsv4h0VgAXtq4QpATgO+YZvOWlXYfVup8i1SBV0s/LbJ+9mmPwp9YOeWJ+dxq/+F+92BAkG+k
	7GLygu7P9Hk0y8glxsFRUYxaKOJTGEgSqWcYKdIlasu/VdqoAxjjEjhBsJcAp7m8aHyiR8=
X-Google-Smtp-Source: AGHT+IED4kahw/QTcOzvyLqi8VxXqpDij6yBcyCz96pxa/5L/h6mgwzj8m7N1Ix8DmHT16XLMDX9eiIrewOayG7LiZs=
X-Received: by 2002:a05:7022:107:b0:11d:f682:e475 with SMTP id
 a92af1059eb24-121f8b5fdefmr5831812c88.40.1767879672498; Thu, 08 Jan 2026
 05:41:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107031203.170628-1-islituo@gmail.com> <87eco14u4p.fsf@toke.dk>
In-Reply-To: <87eco14u4p.fsf@toke.dk>
From: Tuo Li <islituo@gmail.com>
Date: Thu, 8 Jan 2026 21:41:02 +0800
X-Gm-Features: AQt7F2pqOthA3klwGzptaR_WtK8tBiNPP3U3wvNQ9jLQbjxTnCf10grChNQvqo8
Message-ID: <CADm8Te=peTkMfSFqfHdj6AW-O88Jz3mtqQDn6rYwAn59zE5ZWQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath9k: add a defensive NULL check to prevent
 null-pointer dereference in ath9k_beacon_remove_slot()
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 6:03=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@toke.dk> wrote:
>
> Tuo Li <islituo@gmail.com> writes:
>
> > In this function, bf is guarded by an if statement, indicating that it =
may
> > be NULL:
> >
> >   if (bf && bf->bf_mpdu) {...}
> >
> > If bf is NULL, calling list_add_tail() may result in a null-pointer
> > dereference:
> >
> >   list_add_tail(&bf->list, &sc->beacon.bbuf);
> >
> > Therefore, add a defensive NULL check before invoking list_add_tail() t=
o
> > prevent this issue.
> >
> > Signed-off-by: Tuo Li <islituo@gmail.com>
>
> Are you fixing an actual bug here? Otherwise, this is not worth the
> churn...
>
> -Toke

Thanks for pointing this out.

This issue was reported by a static analysis tool. After reviewing the
code, I noticed that bf is guarded by an if statement, which indicates
that it may be NULL, so I added a defensive check before the other
dereference.

However, I have not been able to identify a concrete execution path in
which bf would actually be NULL at that point. I'm fine with dropping
this change if it is considered unnecessary.

Best regards,
Tuo

