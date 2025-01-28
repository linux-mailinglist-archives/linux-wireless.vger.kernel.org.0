Return-Path: <linux-wireless+bounces-18073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C153A20D1C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 16:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4861163DDE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C01A9B4D;
	Tue, 28 Jan 2025 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3X6rZSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D91A9B39;
	Tue, 28 Jan 2025 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078393; cv=none; b=IYm5LHn3YKOX7Mrc6jRc5iBXeQ0oijd10BcIZpm/Ozb/4/lSxHq55+qXbzOxoS7WVYp1e6J8msk0rTCNUQTIZE1RLXzAs4raLhpTTQPXkZrb2IpyxL9x3xI0EWbotMtd/7ecrc0tGICAw6Q3T/kXXiCXNlXzwd6QA4fCdc3QgCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078393; c=relaxed/simple;
	bh=8JZxE6UgfRghb3JvX6OpbU1d+yFJbsGpI0F2Jk4oKFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMEc3/ELAVUzzsDGJehZ/eLWz0YnRuGpGWZYiXSN/CV594FFH6Gn3fAiggns9hDlnJUwQ9n0iJq427lUIKwcZymZBR3+Uxjbf3AW0ftQ53Qs2RxcB6CMC5wpWbjctkVKzid/ueuP7znkjjmGUKVIL01/0Vej36XdqSbH5PQHjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3X6rZSC; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb790888c6so1449918b6e.2;
        Tue, 28 Jan 2025 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738078391; x=1738683191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3i0cNBwpceh1IScb1q0q5cjagdTOOAVxRkSUFaKaQo=;
        b=D3X6rZSCkH+gdtISBcHpRcoqyNx/YFYz3UQRgZMBvikGRjckdkkcPKsgWoWyZHuu4B
         zZ6Becx/KnQ7NhP4vfifx1HIu0cGGKsmhaTnrEgT3cWhZV2xd9ZxJyClp8Jy8vzT55b6
         g9NCadaZcRGmB0nafb/LqUuWS8R3RHCrMV15Sz1n0tE7dXAav3CK2Ip2eokMj01sKUvC
         obfQkPS+11tkMdPmcvxdOdxwIU0PtDP9SV7Tf6Yo+jtbicTNbI9PLV5pxa49Z5hPqqM3
         mRGePsTaNbqSvGU7osD3tXy7Bu2Y69xCqrJvTO8MvfAhpXflZhkFzGQrBJyv8ZQereyA
         INvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738078391; x=1738683191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3i0cNBwpceh1IScb1q0q5cjagdTOOAVxRkSUFaKaQo=;
        b=EXRZnkpvjcVFx2UeXvueQtnRqYhd3W2pOyF22l1xNw1vT/PJVkxW8Lks2uhyVgZ7sN
         8Uo/ypNfJEit8Odml2E07st6InXkcDjGKkuZ87amELdwKDo9ELhHYa86dNOG08a1smgp
         ErAAqff4BovWKsMckt7qCQIY+bqSCrGupe5qI8MhHK59Rai9DR58868LDwvPsDGoDL9B
         GZmUtqrH6NOF/x++7fgGStlbDE7kEmrfc7HRpq8tfLUceoS+CkZtm64OxaOH8pqtJIJj
         +woDP/bxN0JjhAJAKqodFxQSfvwYScmox7C+aoijFTVsyP4foko0jmtiQuAjASfbZdbc
         qrUg==
X-Forwarded-Encrypted: i=1; AJvYcCUAIPBo5kFgJlqeXusHOf2YElfndKqHV1m6Hh8F58gTnrv8l/lFc6UORK2X2D9uE3Zgmmzl9imV@vger.kernel.org, AJvYcCWcj5WobHTHrhtUHrwfUgjgtccDl/xWvtNhCWmOF2bPWRlns29hx/++aNMeiqT66DMVttYe4KWHiSPWWR0V0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3GnG2hG20gX2vSldgtgCtTeUDpTOi3cH0kwA+I2G+dMPGmg00
	7GxB3zPRi5IxTra6eWluxmOXWDyQPo2W40EHk5bxMfy1fJ8jdFV32w8dQXi/3ySmiB3g3kEwJ1E
	zVWrTGSpviZKd2D0vwJ9k74QG3P0=
X-Gm-Gg: ASbGncuraPm9+NNJJi00aU2Ie8roGX/SRQEYxjvJ/FSaIjlM5Fg3YMeeT+uTxMo5tFC
	7kVOcX5crHWHaK5bQX9Rx/G+MFE8Cjoh52QxjxLagP6O0Nglcp/uB4yIiY6jNuCFbStmn6yMgQS
	YzkAmE2lZNERJIElNuc21PfAdmye5fBg==
X-Google-Smtp-Source: AGHT+IFVgUHgBoQ+P1RHpThk6E7tuYE2c27FpSojYlMmoJXQ9+b1GOH73A4mh7zQsm6lyLw50vEzJQhYrxAYXKrTNO0=
X-Received: by 2002:a05:6871:a4c7:b0:29e:6547:bffa with SMTP id
 586e51a60fabf-2b1c0ac9ac3mr24384623fac.21.1738078390683; Tue, 28 Jan 2025
 07:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87wmefguqt.fsf@kernel.org> <e64c416a975d8fcc4e245db78f31b0daef358e89.camel@tuxdriver.com>
In-Reply-To: <e64c416a975d8fcc4e245db78f31b0daef358e89.camel@tuxdriver.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Tue, 28 Jan 2025 07:32:58 -0800
X-Gm-Features: AWEUYZk8T3Rc6w2pDYe87v7mGJwmiOTftIhyMvPxPpZ53niVOGUcaBFs4HcjLik
Message-ID: <CAA93jw7wA2SAnBYfWBVHJQPA_T5+TOQ=vpr+rC64p1=OxbuuRw@mail.gmail.com>
Subject: Re: Stepping down as maintainer
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, ath12k@lists.infradead.org, 
	ath11k@lists.infradead.org, ath10k@lists.infradead.org, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 7:18=E2=80=AFAM John W. Linville <linville@tuxdrive=
r.com> wrote:
>
> On Tue, 2025-01-28 at 11:20 +0200, Kalle Valo wrote:
> > Hi everyone,
> >
> > I'm stepping down from all my maintainer roles. My first commit
>
> Well, my friend, I suppose the time has come for you to move on to
> something else? I truly hope that something exciting and rewarding
> awaits you!

I didn=C2=B4t know John was still on the list! Hi John! I have enjoyed your
return to retro-computing elsewhere.

>
> You have done a great job in this maintainer role, and I am very
> certain that you will be missed. Few people realize how thankless such
> a role can be, but I do. I hope you will now have some some time to
> enjoy your sauna as you consider what comes next for you.

I too, thank you for your service in this role, and hope you find
something rewarding to do.

>
> Thanks for the job you have done.
>
> Terveisin!
>
> John
> --
> John W. Linville        Someday the world will need a hero, and you
> linville@tuxdriver.com          might be all we have.  Be ready.
>
>


--=20
Dave T=C3=A4ht CSO, LibreQos

