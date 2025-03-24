Return-Path: <linux-wireless+bounces-20776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EC2A6E065
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 18:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8381B16CACD
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870A0262803;
	Mon, 24 Mar 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PesrHXDy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2826158D;
	Mon, 24 Mar 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835629; cv=none; b=KK8395dQdRXPTWU6kijUCr0EKdQnkkYAtSwtcamt+sJfSE0CeRTrxTHvu+qYhkBwliZ2eozJSx58/jc7SY6NfMSZoI8cDiR7qNe3NYNOjucZz0PWFp+SAopzUMWU0NOt2peURaHRxNgfbahP3x/aDZJC8Gx9Ivc0sEh3kF8qb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835629; c=relaxed/simple;
	bh=QZ+ADSPlR4WN2OpqtNqLf9bC//Y4z9l5vR66G7an/rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTLPSueC6EriTXAmWZFHugE+D6azMdNTx9gf7Nt2E4TEJdlb5gJ07KNQEhns9hf3FFiuIL4r1ePSP15Zg9LHzns7BzgW2p4tO/SB9k25XNMsECVrt1a8m7jD6PLVQ/sjMwhFEhY7k+mKF5fwTXtHk9v8PtfqIRStPPvJVQgiIk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PesrHXDy; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85e15dc801aso398341139f.2;
        Mon, 24 Mar 2025 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742835627; x=1743440427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiK+XbItIIUrna1hCKyECwMMmXpIkkNG/K+3Wgt4kIY=;
        b=PesrHXDyc2egOW3Yng5HB3nWuusGNns8nwmnrO1/I+aeD2jBUgJjM92xtalZNq2is2
         bRNoUIc6FFmtzSZ/QaA/wCc7Y7OZTwimXWTOZYL6Y6+kjrFLJ+Lnf8GF0wu4ZDFpgJvo
         MhdZxeEjHWJYhdF9ifCEVaGyjzImcne+TMYfdPWy4P4ra/ElCerxRvA9T5AAAajSJCms
         dzUXDXPz+N6tl5VLyWBc8fxPbQ0dJsRmYh614DgRgnfN7tMOysfvmrQn2aacpeahK3O/
         zQ0lY9/rMLhS92XzTDhVUc3M6ngxMNMTs1sfoy8Y4oHkri3I7BUk2GI9jWmad/BLmv4l
         fvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742835627; x=1743440427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiK+XbItIIUrna1hCKyECwMMmXpIkkNG/K+3Wgt4kIY=;
        b=qTPoduoHGYxjCZKPno7uVckoCuL+07fJn7VCJ5Gf3Emvq+I/ZGGbgUQ+4E+4QLp1zq
         SaYTp1opnO9zH+BEqrSd3BUj7pBy79gIeYPWA/m+VLyj+ue1wZNsxXXN27kxNxCpeaPw
         QWJHMtASt73iXFuWExRYDwuB9MAQj8ExiE4Xn59lFbqJ6nNhuedjWxbds+nVwQzmdjgB
         XZLhUjgFqh0SPTJWVzB+cy2snnrN4/YKyJYftSqTlX6Sx0TqvSj3E5J63DBHPYYX1qye
         2cZgKESVH75uugncY1rq75jZ96O6qoFgYLDUg1LUjYVCCs6PbaOxrdHeXYtao0xKOXHc
         Ot2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTWNtpaynrCPPNZNQsQVNLdbcg/jGzDyVR2YnxqMI/jFn+QqVXIHO6GFxeNzF0rwnW9+tMFYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHCqUej0nVyPAsCVdezl1QLMMYh2UtMICZ+sYyBglEBmRpIHD
	HQZpBiz8zaN4Jj9Hyu1+wvbP5eNonZul9XOuhUYxPVSS0cYAmMl6rEkB6zpo40wtIZ9e79kcKRD
	hKvCg266jFKvGdfxBGsXDs3aMuks=
X-Gm-Gg: ASbGncvi2Px1UpyA7GThXKGjS6cOYSIKczdtQOyDhB9f+4D/o2FoghtjoH65raO6xcg
	fNt/4JtW8/94KSSXPbFaFqFMfnlPPv1Cxx7qFC4qAj6bxfbd9KtctQjEpTyAEgqi77sQ/rgJVA4
	aBOKPRXnWoMyMSGZYPAHi9Sahdow==
X-Google-Smtp-Source: AGHT+IHMCuHkLI+ZDUJnWpVX+8/mF1/t8QEJVpvny4ENE1co6tCTIr4wVdurMNYnEssqNhr49BHxYweG0qiMZKPx//w=
X-Received: by 2002:a05:6e02:3207:b0:3d4:712e:29eb with SMTP id
 e9e14a558f8ab-3d5960ccfacmr148634145ab.5.1742835626661; Mon, 24 Mar 2025
 10:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313134942.52ff54a140ec.If390bbdc46904cf451256ba989d7a056c457af6e@changeid>
 <CAL+tcoB3zku2EtLT2yJ9qPCSuN2=x-T-avqcZ-LJ2Q-mU5xLVg@mail.gmail.com> <db7a40f500c0b595bc2ee0f9524bacbc592dc72d.camel@sipsolutions.net>
In-Reply-To: <db7a40f500c0b595bc2ee0f9524bacbc592dc72d.camel@sipsolutions.net>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 25 Mar 2025 00:59:48 +0800
X-Gm-Features: AQ5f1Jq5vlEVgzazVwvL-JDorvj_Ino1GgoGhgWzAbm9431-nmRADWw-ma4jpww
Message-ID: <CAL+tcoBHbK=xDEp7RHqUHxSZqNOcd7kxAEdPC7aZq8RaWtDa0Q@mail.gmail.com>
Subject: Re: [RFC PATCH] wifi: free SKBTX_WIFI_STATUS skb tx_flags flag
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:56=E2=80=AFAM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Tue, 2025-03-25 at 00:53 +0800, Jason Xing wrote:
> >
> > Thanks for working on this. After net-next is open, I will use this
> > bit to finish the bpf timestamping in the rx path :)
>
> :)
>
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -481,9 +481,6 @@ enum {
> > >         /* reserved */
> > >         SKBTX_RESERVED =3D 1 << 3,
> >
> > It might conflict with the bluetooth commit [1], I presume.
> >
> > [1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blue=
tooth-next.git/commit/?id=3Dc6c3dc495a6ce5b9dfed4df08c3220207e7103bd
>
> True, just context though, we can deal with that.
>
> > >
> > > -       /* generate wifi status information (where possible) */
> > > -       SKBTX_WIFI_STATUS =3D 1 << 4,
> > > -
> >
> > Better use SKBTX_RESERVED. No strong preference here since I'm going to=
 use it.
>
> I can't have two called SKBTX_RESERVED, but I'm not sure it's worth
> renaming it rather than removing? No strong opinion though. The context
> conflict will happen either way ;)

Sure, we can ignore it. As I mentioned, this released bit will be used soon=
 :)

>
> johannes
>

