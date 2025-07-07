Return-Path: <linux-wireless+bounces-24892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B65AFBE6E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 00:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490887A5A55
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 22:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0D62877FE;
	Mon,  7 Jul 2025 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUo0oddH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C72116E7;
	Mon,  7 Jul 2025 22:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928921; cv=none; b=PWNfBZQj+J9SG5UYxxqdl4h2ugJalIqe4BCx+LJdC9FB1jGEAhXMZBWpkezNzARwAxCkkPs11R/NpDzr4odjWiffM3ROKY21hj4rofkYELrK92m1gBULZmBwewMGoxSBOzvjrW7OHHJtAOEoddSmxrVRkkSInhZsNWVQpCPYWTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928921; c=relaxed/simple;
	bh=BfplGAGYJSY9LdA74Otq/aYHP1O1UBCgPOBZ2j23Jrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TiQC36EdEzOKB/coUVIadN0ziF1TvK5EyEEEAbTHDi6GEnVJNFTQcvAyxFTzF6mGRcT30v/vIEr0oGUsM5zTuRkWtG52kbvy7RSaIPpssT2Z52PBgCCzIemroTfinMWiTG+mwyOMAZtROf/yWFQn9kMwA5r12ENxz2gzfMT5zVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUo0oddH; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8b3cc12dceso1987866276.1;
        Mon, 07 Jul 2025 15:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751928918; x=1752533718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyTXGd3oxrcdwN+ZWfUesTZPlQxy4H1ZYTRObcRWa8Q=;
        b=fUo0oddHCkZ5vUhnWZgCww7gTbNZ2EGpxT9yAsfFwyRry1wVtAN1BUhA36KxXY7x5U
         cA4RP2sHTEpOCzrrd7NVAnfWFdh33fhDO6DsMrqz9J8w6IjsRd3+GvofyYMrth7xUwLp
         vhs0wnStFZ0/H4zlCLmp9bkXxNGyk2BM4gE2Gjo9Hk8CpR2uN0lz3GDGutxaHxmQ3CGM
         E2UpCDYIUGErYWNl/HIU9+oQJHuaCPdV1Ek0GLpMktvk7+F5LWes3eY6BWIrCj6Dm6fo
         vxcosBcyfzPiLwqWwg+5SnQ5JbA1u2jWtDkULhOVoFs7HrmaQewfU2uB5XWUPtiunowr
         kmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751928918; x=1752533718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyTXGd3oxrcdwN+ZWfUesTZPlQxy4H1ZYTRObcRWa8Q=;
        b=U1sMkT5gNeGQPLnie6117kfF2yoOUZHmz0Jkv8WjbsCLFsEfK34vDMb5nrAUlSgTKU
         KDxccDHIrv5yMnqmW8VRQp/feji2cRb19l2F1orMTw9fK4YL+9shOsHzTisXB6gl8tph
         B6hwPbpZ/lODYkBSQzoAvpN3GiPeXWDGPLAELKmYxFL081ri3f6w15jGYo+O1TEuk5Qr
         wrszhH4lWKgZRFSj1V2vD70g6KtR0v/s9nwrLUhUno3HOJFQdYQVErjHNhmiDG3sblm0
         ivniOBQ/vgy0izOxo64fCv8cABNyH7mucDPQ/AzJUW8fCQMibMhfL9R2d3LYuVo16hsV
         8NdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeGtjZmDDklAD4ZXF85M9snMUc0BD6fePCKaq/YvjJONG/ZHxD1xFeM5QbtdUS/48JOSgSOUMvRIklFA==@vger.kernel.org, AJvYcCVfGawMTShJCGSzzRwHzv6DyOfe8x2215Zpzobr7jHdH84GvVKg49d2YDUjF+rbWBlbqvBWZKEc0qhv@vger.kernel.org, AJvYcCXbJOUIcufQAdfn5dcXN1hIgd7rLCKDvfga7XZfQziQXU6o+SbuDO/iJg7Ub8qrUO7r2nzSx0MrFH02XObB@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIWMtd22q5kJmJmEtZV1uowOz56ifaEIT+j2x5N8G3LSOyfAo
	UfDQzeqV1lTX2ixU7k6WdQ1sc7kqRa+nu1+ZQUVLW+zmOS8yymajnP2qijrS363/HAEE1UIXGH/
	k+gy9CDf3vIBJvidNTLPGWzMRfJ7njmE=
X-Gm-Gg: ASbGncuwZEwNC3EUui5DW50RpclzcmdNzfjT0MHcM+Z+1nOBqAOAej+8XR8bqrEUQjf
	8sYSmbVu53SzLoY1E9X/eZSm1t7/suQJdLLkws33mJ1QszKQxHnHGyJnKbg+NAPYcML5uQ+TkhI
	XJxDz8Rp3Kusdc8+z65aRcXwPvu8PeQ72nvd/xc/zqTRk5v9M7qbf9/mf6zXKCcSICP0w=
X-Google-Smtp-Source: AGHT+IFUqlSeXO7TN1tNOxRHWSczuY+UdbyZo5ZiJbvWxxUDKKmr0+ZLKF63xcIULGwasrd0gN8rpXhvNOBtbXtWouQ=
X-Received: by 2002:a05:690c:690e:b0:70e:18c0:daba with SMTP id
 00721157ae682-7166b7e8151mr182180917b3.25.1751928917782; Mon, 07 Jul 2025
 15:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214111.45687-1-rosenp@gmail.com> <8c6f18ca47bf0dd78b6675d8b94000679b6c75cd.camel@sipsolutions.net>
 <CAKxU2N9vs5o4tj-9KxCHKevWU+J9wv+ZCOeD8o602y1GY8FzNw@mail.gmail.com> <b3a63d616c1ca337f6b9d14a9afaafe73bfbe8cc.camel@sipsolutions.net>
In-Reply-To: <b3a63d616c1ca337f6b9d14a9afaafe73bfbe8cc.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 7 Jul 2025 15:55:06 -0700
X-Gm-Features: Ac12FXycPvJ6904Rtx31RRwaAeo58C7gGYz-ADfCLyeTnPkiok4GspDzrArWUl4
Message-ID: <CAKxU2N-XviPav1Bh0yidyMUr=QbMr=0jyYyHKc+h0oaM9vak=Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] wifi: rt2x00: add OF bindings + cleanup
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, yangshiji66@qq.com, ansuelsmth@gmail.com, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 11:36=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> On Mon, 2025-07-07 at 10:41 -0700, Rosen Penev wrote:
> > On Mon, Jul 7, 2025 at 2:01=E2=80=AFAM Johannes Berg <johannes@sipsolut=
ions.net> wrote:
> > >
> > > On Sun, 2025-07-06 at 14:41 -0700, Rosen Penev wrote:
> > > > It doesn't even compile. Added OF bindings, documentation, and othe=
r
> > > > stuff to hopefully this doesn't happen again.
> > > >
> > > > Rosen Penev (6):
> > > >   wifi: rt2x00: fix compilation
> > > >
> > >
> > > That was half covered by Felix already, and really shouldn't do two
> > > things at the same time anyway.
> > Just saw what you're talking about. That's gonna be annoying though.
> > The COMPILE_TEST commit will cause compilation to fail and the bot to
> > complain before Felix' patch gets merged.
> >
>
> Yeah well. That doesn't really mean it should be merged together though,
> and we can pretty easily make that work by just putting the further work
> in after net/wireless is merged back.
Looking at it again, I'm effectively removing rt2x00soc.c . Meaning
Felix' patch is mostly useless here.

It might make more sense to submit this series at a later time.
>
> johannes

