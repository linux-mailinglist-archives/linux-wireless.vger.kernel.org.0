Return-Path: <linux-wireless+bounces-30632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C61A3D0D6B7
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 14:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB2303012BD3
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Jan 2026 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC532A1BF;
	Sat, 10 Jan 2026 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7KUGsWk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A51F03EF
	for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768052955; cv=none; b=OebfnceeLKYiIN6JIetGflZmCGZgRw5Ka6E0Ek9Iw20o48tqJQwxsoOJ2LKnj7Vr8udH3MTdu7DmLdOHHU33PkJNc6+lAHqpOQ9Cxd78KfX198iv4ET0KO4Su3OGPE684K3EWjw0SO6XAYah/fAPrKmS/UrU6Z7NL8wMwJi53zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768052955; c=relaxed/simple;
	bh=+2JDJcIhy5DoMn0OG0tTP+h2ajzosPU0TcVGu0Rxq1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWvR6CNS/Hhtdr3IOGNAh2+i8uuD4tRpL3EzyI5PHI0jAcvqLKBPS0MfFoY4jQx15Z5GBxI1ooIWcM7tNdoWrNvNjsokbC0CAP2TQ/+IZWIDfl93TUMil6m903vDfsDxP4wb5YT4eVjH7QZZYw6iAeXfMYJb25qR2mMC3RD1cVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7KUGsWk; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11f42e97340so3088130c88.0
        for <linux-wireless@vger.kernel.org>; Sat, 10 Jan 2026 05:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768052953; x=1768657753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CWWbAlBJOYS6AxG37Qt7t2pXQXnaY6JTvH+pxI9DBk=;
        b=G7KUGsWkWBINc7WWXab9hk1YX4YXmetxxOMO1mGayW/xgQrIIYPESSoK3MdtnpS9jF
         j/vG/82Sx2OVwHdQal7PQLT7bcnfp5qCSNc6w++vFNKsrwamVn7MQkj49ECgZcFfFP+R
         gklSkKOCxdqQm6/AJ4s/kb9ktMMX96b1dOEn7VEqGKTnVQYAuR9iJvW6IAQTWfwnOZ2X
         XNAsIOcelOgqJlTWQ/tRKlFD2hm1XAIyqcFWINsd/07W2GqfMQ5X8WOsJC8ggDDCOsVl
         x4i+xH5EK/dsJwuMaDFhv5ESYEOWZnNHKmXJkmF7oVvLxPNLF0QXQtTd6VhFJ/SXsGL+
         fKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768052953; x=1768657753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CWWbAlBJOYS6AxG37Qt7t2pXQXnaY6JTvH+pxI9DBk=;
        b=OaeTUDptIHj1Vcwe+VuS9zYTtJ/e9owd16ywXE3+qXj9PrJLIdpomWHiXlA3MjDNHl
         GMwvf3qHlFCPtAP0/JKJd7EA+AJBWBvDahHfICamoH2ynv0B+41nZK+/6KvhHBTRKRE/
         NRWaUrQ47x2oazyx1vMTci9+/HCfCUxEQZ6iR3gQ/3IGQ+UIDVLE1acr4dPDydRJoy7K
         fyAs6laKwaofMseNNWzqixKi/NKfj7wkcA99UckUKjl3jlkgt4RHF5RkQBVYCXkIMXHR
         0jNLUQqO57vH5PL/1+wRGF9HlKcMk4suIKWMFGKS22q45hXa4Yyqi4tAa/cyhh9c5AAY
         dG1Q==
X-Gm-Message-State: AOJu0YwVV46s/8KxWNniRdJ51/klUBMGGNijn7d+GNKz1xrkFpmB+Ayb
	yVNKEnfJCkl+kYUqXPZ19qvIUTOtNghD0e+kd7R+TMQXrzGaGuEfJ/vxDeaNoJVNWh57tIkSkOn
	koakwFP1S/HMVbVn7qp9WFglIK1YhJVw=
X-Gm-Gg: AY/fxX570lK5Edu9EjfzBd8cin2tmmMSK5aDDIhwNOzrR/grm9x/FeAkXKeDn2osOyZ
	woaiIfa7Rz2RYB/bNBcMmq4OUJoJ6iiYvHomtyE1v6S4XljRy0YskSGCDR1crfxMuE15zc2VJYY
	7r12I6LNdk5sTMRe1VwW/z6sUokfRMpLzUdNi4oFgk4yyJ3sWSpGO/WeMO61tOs0NggQogXN+bb
	BBdFO2ZQJ0BPtCWkIjZ0pRoIjYxkxIBZDU1EhB01TvZjSyptURAxu86BX6ivAEg8KgAh5U=
X-Google-Smtp-Source: AGHT+IGcq+jUcmYtKY+oGzu0hbmzpZDQ3ePHovr4WnoUvhTHaLr+9koSAshL5kilgFf0KNynXkMvygn8dsQhND6WFnE=
X-Received: by 2002:a05:7022:e14:b0:11a:61ef:7949 with SMTP id
 a92af1059eb24-121f8aca755mr13210659c88.9.1768052953106; Sat, 10 Jan 2026
 05:49:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109034014.187124-1-islituo@gmail.com> <20260109090227.GA48150@wp.pl>
 <CADm8Tenw9kpk9suABMEYguURxtWrXRaRAiXogxUfwSash-c0ng@mail.gmail.com> <20260109204235.GA48564@wp.pl>
In-Reply-To: <20260109204235.GA48564@wp.pl>
From: Tuo Li <islituo@gmail.com>
Date: Sat, 10 Jan 2026 21:49:04 +0800
X-Gm-Features: AQt7F2q0YywYnqf0drHJw-XOQxJ13IbISNYdVZdFaTdbnDe3tONyvceB4TuFxBA
Message-ID: <CADm8Te=SCAW0gP3QTwb5vtDNhbqqwEFUKNkwgAvBkA6vqVQw7A@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: iwlegacy: 3945-rs: add a defensive WARN_ON_ONCE
 for il_sta in il3945_rs_get_rate()
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stanislaw,

On Sat, Jan 10, 2026 at 4:42=E2=80=AFAM Stanislaw Gruszka <stf_xl@wp.pl> wr=
ote:
>
> Hi
>
> On Fri, Jan 09, 2026 at 11:12:55PM +0800, Tuo Li wrote:
> > > Sorry for giving you wrong advice before, but after examining related=
 code
> > > I agree with Johannes the il_sta can not be NULL.
> > > Now, I think we should just remove il_sta/rs_sta pointer check.
> > >
> > > Regards
> > > Stanislaw
> >
> > Thanks for the follow-up and your patience. I appreciate you taking
> > another look at the code.
> >
> > Just to confirm, would you like me to submit a v4 patch that removes th=
e
> > unnecessary il_sta / rs_sta checks, e.g.:
> >
> > in il3945_rs_get_rate():
> >
> > - if (rs_sta && !rs_sta->il) {
> > + if (!rs_sta->il) {
> >
> > and in il3945_rs_tx_status():
> >
> > - if (!il_sta) {
> > -     D_RATE("leave: No STA il data to update!\n");
> > -     return;
> > - }
>
> Yes, please post those changes as v4.
>
> Thanks
> Stanislaw

Thanks for your reply.

I will post these changes and submit a v4 patch shortly.

Best regards,
Tuo

