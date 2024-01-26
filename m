Return-Path: <linux-wireless+bounces-2553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 200AD83D977
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE59D287F85
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08E41427F;
	Fri, 26 Jan 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ7AXBwN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132DE1426E
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269032; cv=none; b=I1SQYkoJhI6xbJ00PNqVu64f2i3gkmlf7C4nrZPoF7iiy4TBSO20QIDeUR69hof+Rptj1d7bQ/qIYiimjjkD/rwnJqMkEhPTG6SEWQ0BSbn2iy/5RHc8QKG0y7Qp2zY8rMz/JSABpqG5ma+PWKQS6Q7riqoyNnGo/ookBbAAro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269032; c=relaxed/simple;
	bh=Bq6C3UzimOMQhPszdu1oWlrX0R49ALd7JJdeTISGrRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isuX7LbWi26FuSnO58Xjq82vVXCMxxRTnOX6h0eeOcdbmmh2B6pPoQu4nZPVoHOwJhgy4woZ9M+hQtFmthsTGPnUMk5WO/fPTbvD72QgDL+e8aI1QzMXGLw8n2NqocUFEO5WsMENR2ri/vkQCAjrPEiFdbzk/MghwFTj0UDi7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ7AXBwN; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bc32b0fdadso12551339f.2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 03:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706269030; x=1706873830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq6C3UzimOMQhPszdu1oWlrX0R49ALd7JJdeTISGrRQ=;
        b=hQ7AXBwNJSUEFsB57CVcFkr9A4DhcziR9MXFPz8viazk6Fov16KXUkCfMUXi6fJF5J
         ZOTN09vFIe6S63nocPabHek4T2/tfxRxP3wlgMYyeu4ZtMQ+R7t1+ZECqJs1xuJ8LLT0
         iWpcPaKqS0k4TRjExgk400q+T7Is96IuJ853UhAK4qYjw/z75uFua/xsjtHvaRh8kAOj
         0ShqHZXy2rm7lLEzFeOUswwRALbcYfspO6oV+9T4uxLmJjfGKB4pB8d9IdV2W3XM72cE
         XHfiUG8Gi/DiKqEZe1F614npRM+DnV1aPO7xGL10wpY4cSYyq6GSTmAQVLlMf+D+s2hc
         rbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706269030; x=1706873830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq6C3UzimOMQhPszdu1oWlrX0R49ALd7JJdeTISGrRQ=;
        b=WDSfKgBz30bP6zy5NSESm/dyTzzGHAlk+/HAAlnfqINIH4QfoVH4mjXtLnB+wJwkwm
         uTpTB3yS8P2VjCB2T5uR/gqpOTsKMuqUqKa3atBXOa/sCiXAtYvTnF5aqDsvcvT91xxc
         Y9CSFMPPf/mDHtYoXQ5epVyFWEmSxfTXj3AbQb6jCr/Zepac9+bVccR0oB7qINiHy2On
         mmqSK8hjBTm7F0Cf2B6crlXkgpwJEQ+q0GMUp1w1ZYea6EeFVs3f2v54Th1Go7NtoFXz
         //T/Ea954HoHaim8tRiCOvtR2shjTQlHqwhDqHMHObonha088O6iZ0EtKOYjHFPz2+A1
         gx5g==
X-Gm-Message-State: AOJu0YwfmmlZkiGPetWqtWFxJoSoEDCARk/FsvaxEfBh54IdUsOVTY5k
	5qxFJQR6RT/fF1Zc30KLuNy7RfdVWd+u2zxoaZeDR3xl9q7/oqBnU5wc4t/nUYftdXWzmhlP2C2
	zJNpduGh7QPfpGE0xRKc+Cgbptns=
X-Google-Smtp-Source: AGHT+IG6uZ39MU1wUeX0D/BgNk+OX/kfyNKMr0CgvQhakXKnln8nqMHbbev8WnfBSxepk7I11mhg7VW07G/YrGWHMvY=
X-Received: by 2002:a6b:580a:0:b0:7bf:60bf:ed0f with SMTP id
 m10-20020a6b580a000000b007bf60bfed0fmr1671863iob.7.1706269030189; Fri, 26 Jan
 2024 03:37:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGb2v66xVLqr+tUSD_6uzguGXtj04WfbpT0z9M28r8z-g62Z=A@mail.gmail.com>
 <CAPuHQ=GSuKW5=T0GXXCq7Pf9jw=zcEnms-fEJey68QUWH1ishQ@mail.gmail.com>
 <a5123274d5a8d80d554ffb786e25bef72d45f69b.camel@sipsolutions.net>
 <CAPuHQ=HSJNXx_ukS4G=+AsM=qp2yMA4mKD=NHDpq+BoMMLSv+Q@mail.gmail.com> <CAAgmp6vdK-bMJCnXUqhPPADRcd3sJXeFvuSOt5_7HCSV2dVKEQ@mail.gmail.com>
In-Reply-To: <CAAgmp6vdK-bMJCnXUqhPPADRcd3sJXeFvuSOt5_7HCSV2dVKEQ@mail.gmail.com>
From: b.K.il.h.u+tigbuh@gmail.com
Date: Fri, 26 Jan 2024 12:36:58 +0100
Message-ID: <CAPuHQ=F5QXXaELZLApK7WiveXSDoUeH-YEHM4RrZy6qLkibS8Q@mail.gmail.com>
Subject: Re: WiF Transmit Power Control (TPC) Regulatory Requirements?
To: Petko Bordjukov <bordjukov@gmail.com>
Cc: wireless-regdb <wireless-regdb@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>, thomas.huehn@hs-nordhausen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I've read their research when it was published and I view it as
influential results. Their approach jointly optimizes transmit rate
and power for each and every frame (i.e., for each link and each
direction every time).

However, we are talking about much lower hanging fruit if all you want
is an attic mounted access point that tries not to interfere too much
with the neighbors while still dealing with blind spots within the
house. I still think that the periodic global adjustment method also
used by Cisco should be legal and very easy to implement on OpenWrt.

On Fri, Jan 26, 2024 at 11:46=E2=80=AFAM Petko Bordjukov <bordjukov@gmail.c=
om> wrote:
>
> Hi,
>
> The only project I've heard of that implements such functionality is
> https://github.com/thuehn/Minstrel-Blues.
>
> On Thu, Jan 4, 2024 at 12:02=E2=80=AFPM <b.K.il.h.u+tigbuh@gmail.com> wro=
te:
> >
> > Ideally, TPC should be a fully automatic mechanism that reduces
> > transmit power between the two points to as low of a level as possible
> > while delivering the same quality of service. The purpose is to reduce
> > the excess headroom in each link. I.e., if you could still link with
> > 65Mb/s towards a given direction using 14dBmW, you should not transmit
> > with 20dBmW.
> >
> > Some only set the AP TX power globally (i.e., same towards all of its
> > connected clients at the moment) to tackle the hidden/exposed node
> > problem, but again must do this adaptively and change this constantly
> > without human intervention. There exist multiple advanced algorithms
> > for this, some proprietary tuned for corporate deployment.
> >
> > Actually, if we accepted automatically retuning tx power with iw based
> > on actual link stats of momentarily connected clients every 60s with
> > cron, this could be added to OpenWrt pretty easily.
> >
> > > Class A devices control their transmit power within =C2=B13 dB and cl=
ass B devices control their power within =C2=B19 dB.
> >
> > - https://www.litepoint.com/blog/wi-fi-6-ofdma/
> > - https://www.cisco.com/c/en/us/td/docs/wireless/controller/technotes/8=
-3/b_RRM_White_Paper/tpc.html
> >
> > > On Thu, 2024-01-04 at 10:07 +0100, b.K.il.h.u+tigbuh@gmail.com wrote:
> > > > You can find a wording in most such regulations that if TPC is not
> > > > supported, the maximal TX power must be reduced by 3 dBmW. Hence in
> > > > all such cases, the entries in db.txt contain 3 less than the maxim=
um.
> > > >
> > > > If, on the other hand, you know of a country that specifies that
> > > > devices lacking TPC may not use the band at all, all such band entr=
ies
> > > > must be omitted (commented out along with a URL).

