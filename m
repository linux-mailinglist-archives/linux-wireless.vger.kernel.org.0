Return-Path: <linux-wireless+bounces-14940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF229BD87E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 23:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0501F23A54
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E058216E0D;
	Tue,  5 Nov 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AY3nD/Ab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1039D216A30;
	Tue,  5 Nov 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845448; cv=none; b=k51KPrj43qSOGhMLmJ6VYC2c9NG38qA7WbCWmJF0vatrAqIhoQUmQMqTrxm0b6axxfmYQjlJbT6Oh8nrrpMzEOd9kfVLk0UtJS9aej1FtxMhyb9cZTiVs8wZIid1EkCBj4WWLtvA5EZxgaRe2DQsldY9Bj5hjSYcBalctmAVMJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845448; c=relaxed/simple;
	bh=yN1iAjZ3dUlTmdXYaO46hky0MZxahlvVhwx52uOQvjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGZXTNRz7FP7oAe6m0Twk1JNMD1h1nTuL20hz1Ls/Lh96xtRVXhhNITxZxE5lPcdrpY/MIY/irnqJsU2M3sWAYpAuT5IkczwPfdnOKSXxlK4id/ftSoVLRaq9XFrvT9kspiQXLWQ/oH9A2756sI3FuWHyishOKTJ3w7hvSsncu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AY3nD/Ab; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ea50585bf2so63827227b3.3;
        Tue, 05 Nov 2024 14:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730845445; x=1731450245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEQ/EDhA1ID65wXatqZl8lMdqNMMroUAEvP0mLHL9A0=;
        b=AY3nD/AbFlkJlv9fr5qo+K67cZdPUjSSekLoja7505vxXg78pF4pnoFalwcd6VWU1D
         8/PhsD8piy5nKTx8ftCUKO3NgjD5H93QeOX5pBs4N/aSC5Gov/aSYq21jcBNdYWvGpVd
         2LGbsoh+/BXoAWsSkE3rTpfiMhnf12IVwC0f5fdYEM/Od+0kBGC+loevbq9e/63QYWz9
         VBs6PR721z3EzPzyBRdPJV6z29lbnCX/dW53T1aWGR+WYL9LAUfVvE7t5uZQCMycwgI6
         zEJUZhTuMUPBsvjv/t/rZ1Gnc5NDZOs1KrohHNQFQ71f6/BtaHqQ11fTaH0qxX6ivvlQ
         1LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730845445; x=1731450245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEQ/EDhA1ID65wXatqZl8lMdqNMMroUAEvP0mLHL9A0=;
        b=rYNCxNXKQIlDaalNpZeUypPUHs+5HElzvxHdAvu30jT9TnmNzCg/nCGpGGHF+vOKRb
         xz84AE0k7aBmO24VP5Mr3svTCQ3bDOiltqkWYFu/A1sisGe3og8kinkF4mkMhorEyD/h
         q/yzKHqAALKBp2RbQx9gHKPOea0DvIXi1BsBBYud4qDadysWmtsGVwnbK7cMSmaP7dLB
         1gdu4CzMbimYVUEfjz+9VwmPnGzg4q7pjVw1PRBJWv/4FvBdakBgCARHoCL9IF4dZmh/
         kgC5UTUCfAn05DYe46ifUaKZ8TvrIxVc7laoPHc6332AXNXPxkiITMinKCwDsARMNWfD
         k1eg==
X-Forwarded-Encrypted: i=1; AJvYcCV1K3kdoYdoM8g1lajxkQeiNhmVnfd9Z84lLt6uuAOqT4JAXjxJOkogQ/O0FVwvKcIfnAA65xE6CH19N2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9Eid0f0AoN8ofnmp3q1pz8hvoCe/msofCjQjwQQcW1k5OqTq
	KMErUaLFk/XgS6SwfqEXArJ47WLlTrbNG/40G1znabpmba8hhu+XIlP+26LpSlyt+tFyeylcRmN
	LrPAxtw2SqUcQ8vjkHB6BHYBq7npF3Q==
X-Google-Smtp-Source: AGHT+IEfVWLa2L1BfzDV1KSng02r16PCLMDF2VSafiQI2yK8DEgff2+kShsDwTG0Ufcnt9fALbngf8xunFt9556ToNU=
X-Received: by 2002:a05:690c:9c10:b0:6e3:bbc:338c with SMTP id
 00721157ae682-6ea64a9f4c7mr177734867b3.6.1730845445096; Tue, 05 Nov 2024
 14:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003021732.1954299-1-rosenp@gmail.com> <87ed3p95q8.fsf@toke.dk>
In-Reply-To: <87ed3p95q8.fsf@toke.dk>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 5 Nov 2024 14:23:54 -0800
Message-ID: <CAKxU2N-16SyWLTw5SPGy5mOeQO2tqOiVdYqS8Ts7s8BF_WpvQA@mail.gmail.com>
Subject: Re: [PATCHv2] wifi: ath9k: return by of_get_mac_address
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, nbd@nbd.name, 
	yangshiji66@outlook.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:21=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@toke.dk> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
>
> > When using nvmem, ath9k could potentially be loaded before nvmem, which
> > loads after mtd. This is an issue if DT contains an nvmem mac address.
> >
> > If nvmem is not ready in time for ath9k, -EPROBE_DEFER is returned. Pas=
s
> > it to _probe so that ath9k can properly grab a potentially present MAC
> > address.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: modified commit message
> >  drivers/net/wireless/ath/ath9k/init.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wirele=
ss/ath/ath9k/init.c
> > index f712bb6d1f47..5f4efc760183 100644
> > --- a/drivers/net/wireless/ath/ath9k/init.c
> > +++ b/drivers/net/wireless/ath/ath9k/init.c
> > @@ -647,9 +647,7 @@ static int ath9k_of_init(struct ath_softc *sc)
> >               ah->ah_flags |=3D AH_NO_EEP_SWAP;
> >       }
> >
> > -     of_get_mac_address(np, common->macaddr);
> > -
> > -     return 0;
> > +     return of_get_mac_address(np, common->macaddr);
>
> Hmm, so AFAICT, of_get_mac_address() can fail with lots of other error
> codes than EPROBE_DEFER, no? And with this change, if it does, we now
> abort the ath9k device init, where before we just ignored any errors.
>
> So, to be conservative, maybe it's better to do something like:
>
> ret =3D of_get_mac_address(np, common->macaddr);
> if (ret =3D=3D -EPROBE_DEFER)
>    return ret;
>
> return 0;
>
>
> WDYT?
I agree. Sent v3.
>
> -Toke

