Return-Path: <linux-wireless+bounces-27841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DDEBC0288
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 06:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EFDC4E88FA
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 04:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E72C21859A;
	Tue,  7 Oct 2025 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIdPjC1u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7805C4C9F
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 04:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811420; cv=none; b=pfkxq8WgnPFXgvhGxv5VKI28oAgM9oYwrcbkQMUdRCh3Em2Y2KFXT+if8Z/0J3f3p/kJNODnj4t9J5oPNSkde58RwHuTynylXgiuQ7dAXEwROgW+YCo5JRfsGtBAb9L2p8srjKOAW7q9M16ASH2JZtueFleAfgCkQxA4Y7hbueg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811420; c=relaxed/simple;
	bh=33ewjYkb4qoFkkq0fX8pWFVAxvzax+lpS2Yg53heRLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyHI9HR8o5lPXyW77ub8xsHTxpIOe+3a2ArjI54mGKVx6JonltNtVaKvkqas6+KaYQEMeca+zirJe8bScAS/Ws/JFvTm2O2/TTfgS4RRureXAN/h9ATpvqpg+odUFf60ZF1dwhZnnYz3py9A44NAiIU/D9pmPDvo2nGK1SExHfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIdPjC1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67DDC4CEF1
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 04:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759811419;
	bh=33ewjYkb4qoFkkq0fX8pWFVAxvzax+lpS2Yg53heRLg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=fIdPjC1uBAeGidI3TdvLjGBaFrrjdrDFqgN3yAnIORJkHDjR0uGsJEa7Z2SFuzIPU
	 /IRZtQP+IMqkFdYJrZl8qxxwTVqUhon8OK0s/IBHf3NWi8CGWZCFU0Ka45Zmvml5Xg
	 FxG0RuuqKbjE/4vgQFP0hC2IL4Pfrbz0l2bZ6RqjCRgFCT66zT1vHFmJbwIrPc+ZKv
	 1Q8Q+Tr5PairLe/60oc6i7Kf7HbjNCQqOQ5j63VR1T335lQojcF5x/vor18lEKezgg
	 6W0I2aMdG5r6w8iN3RzmSEzs5MAoxXPkvWSClYsvg97BRfjzTb/PWLW+gkC9iQ5OQA
	 bd6EffE3lRjJg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso62149141fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Oct 2025 21:30:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YyYUaPIoMOgE6XT8HF/r740J+3laMiWrQHy8KlPgcSjWe2CwmBL
	9Z9DITR3MXaVK9LG3rKLg+wTzcAUotV/Mim1gfZJeKfalz35jx6SO0PwusftwzMjiySIsAHsw3o
	1RIGb1NsGp9rFHym04nLbHVVGothSLSE=
X-Google-Smtp-Source: AGHT+IHYg3D7tiGpbxNGeGRo6iabMU4brCVrPZKp3O/2A56FdjfE/684Z/RFeDpLQX+bS8W1L3whBaHxHRFXKtRMl5Q=
X-Received: by 2002:a05:651c:25db:10b0:337:f57a:6851 with SMTP id
 38308e7fff4ca-375f525765bmr4408111fa.14.1759811418233; Mon, 06 Oct 2025
 21:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2e09391-d2fd-4456-ae45-103239dbac74@gmai.com>
 <CAGb2v66VXhx0ymHGOdS33W2QxUMxew1xW--+hrs+jy48u6MfoA@mail.gmail.com> <252f428e-8903-4d3f-8337-d42e6a2ad4a4@gmai.com>
In-Reply-To: <252f428e-8903-4d3f-8337-d42e6a2ad4a4@gmai.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 7 Oct 2025 12:30:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v66iOCSm6ST4Bw4ioRjjnNvHCxSaGWcNS0SLWOk=ELy+5w@mail.gmail.com>
X-Gm-Features: AS18NWBZ9y8hGD18GPcXmgFcqXiLhk4F0H2Z81m6IicqdpApkT5ncP5KiOug_eU
Message-ID: <CAGb2v66iOCSm6ST4Bw4ioRjjnNvHCxSaGWcNS0SLWOk=ELy+5w@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Ukraine (UA) on 6GHz
To: Dmitry Geurkov <d.geurkov@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

So actually it is already enabled in the latest release of the database:

https://git.kernel.org/pub/scm/linux/kernel/git/wens/wireless-regdb.git/tre=
e/db.txt?h=3Dmaster-2025-07-10#n1984

23 dBm is 200 mW.

So if it doesn't work for you yet, perhaps check the database version
on your system?


Thanks
ChenYu

On Sat, Oct 4, 2025 at 11:57=E2=80=AFPM Dmitry Geurkov <d.geurkov@gmail.com=
> wrote:
>
> Hi ChenYu,
>
> Here is official website with text of amendment that was approved and
> became a law as of 13 August 2025
>
> https://zakon.rada.gov.ua/laws/show/976-2025-%D0%BF#Text
>
> The text is in Ukrainian language but you can use google translate and
> translation is pretty much accurate
>
> If you have any questions feel free to ask, thanks in advance
>
>
> On 10/4/2025 5:38 PM, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Sat, Oct 4, 2025 at 10:36=E2=80=AFPM Dmitry Geurkov <d.geurkov@gmail=
.com> wrote:
> >> Hi,
> >>
> >> 6GHz wireless band was recently allowed by Ukraine government for WiFi
> >> 6e standard indoor use.
> >>
> >> Could you please add the appropriate setting to wireless-regdb
> >>
> >> I'm not familiar with wireless-regdb format nor an expert on wireless
> >> technology to create PR myself
> >>
> >> You can find all needed information here
> >>
> >> https://eba.com.ua/en/v-ukrayini-dozvoleno-vykorystannya-novitnoyi-rad=
iotehnologiyi-wi-fi-6e/
> >> <https://eba.com.ua/en/v-ukrayini-dozvoleno-vykorystannya-novitnoyi-ra=
diotehnologiyi-wi-fi-6e/>
> >>
> >>
> >> https://mrt-cert.com/en/gjxw/4323.html
> >> <https://mrt-cert.com/en/gjxw/4323.html>
> >>
> >>
> >> Best regards from Ukraine
> > Thank you for the notice.
> >
> > Would it be possible to provide a link to an official document or web p=
age
> > that describes the change? Something from a government ministry or offi=
ce.
> > We prefer those as reference over second hand sources.
> >
> >
> > Thanks
> > ChenYu

