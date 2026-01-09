Return-Path: <linux-wireless+bounces-30585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7FED06DFB
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 03:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB5823014DB6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 02:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E112E2663;
	Fri,  9 Jan 2026 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l68Qpp0c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C63033C8
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767926570; cv=none; b=o95is2OzPAO/mUyglhmlSSfIYJ07ZYnCYeBE6xMYTio8BRxGUMlI9AckoeDV+oQYiCUFKpY7Sj734Y1q+nPiFutxK1/UvJa3ht9mRmzMKbecQmDpDp0DfHkC+CaBHzFKdVDF+8z/CF9XSbPpZkJdBGAlt8q1fTrWJJ4fFe9FPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767926570; c=relaxed/simple;
	bh=WPzbKvLmmiBtcdw5cmuOr7HfN/huAT2BwtyjiFVJTcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMYRT01zgArNTpSZvRh43hnILq3bS5sQBwwyp1TM034HtXhRRAQQqPY6c0VIZGy8kzo/xOPJMbQbVDeikEP/3S2mh5vzqss3XfL1eM73hS4+EgvPHJKloP5s2Kxm/CMS7fgqvNmHRVyFUXyydXvIXNYB3G3YyagWAeX9SXcPt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l68Qpp0c; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-11f3e3f0cacso4235096c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 18:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767926568; x=1768531368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pKwa9EyVKBu4K9f933OjN3qf+4pYS1JLmujmtYkYJI=;
        b=l68Qpp0cANyFT4xg99dXkGZ25SPAjk9Gwu28vGhoTmocug845dbWJ8DxNBfuVfwCof
         OLrLmzg15+qWRXuMkQ/Oc8d2ygJ6B2iMesRlCHcOYesCdjhQLstdtzjUYr/X4P0g7Bdg
         ophPkTqsXs660433mEfNwjGgt1q664S+51FtInjcuxVBYWJ40YaFgBnGGk7niHVgIH2c
         dDemiHZ8O7X+sDrPA5h+ImijcsOSV9iPiR9BQ4X9UxwgpSPiDQv0pOsZI5N09W223U+P
         bawKS8aFgYNxLsons+FZ6c3qyrsnvoNAMx6c/zL0eyIOri1xxRBd2UGVgQQGQq4kk8iQ
         GvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767926568; x=1768531368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pKwa9EyVKBu4K9f933OjN3qf+4pYS1JLmujmtYkYJI=;
        b=nsqEAusuZ2BKOY/T6SGtNkh1bHIcZzaJNYPxyDPUNkr9nakLUmJVBY+2hdM39ARw9A
         4fbGwBp08i2UebNGHqM1eb4s/zTXKlox/dAAZVfBQASZV9PAgYbhF0pokpZ0LdALUcN+
         s13lNu3L/JvnkoigtpOEMDlyyEEpVrwLRsa/ETJ/AJVqkTOv0trEaEoXLyg4bsC5SUQ9
         NxxwqWfWDyAkBkDtSt1UlWD847zFkCmAG0msAerjRkrTCz5FCxeU91+ouF2WQpoeq8+p
         ytr9TXS/aLU07ePOppYWC7MbVY+YvjGPz7NhmYbfny2jfvaH04Ljg/ZiCud48On5vTPe
         8y8A==
X-Forwarded-Encrypted: i=1; AJvYcCVGjwA1aSw+0Yor+Um3PEiW+3r8AgnAQLsPqapn0zjAoSs/qe128+kxsQnAE/gVhyLtAFe6VQ2tp9XWoxVcpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw98xKe5/XXfdDUCIr79XRCfCMU47drTbJ4Y6rlfP3d2ZJSJRx7
	WoI42ek+RHxRcvWltT1r90Fni97oeJbSgdEsM+Nfzicnq3ABtAKXX2WQF5QXgFT8j0oVQXCebjJ
	lVO8ffD0kjR0nGopPuZuq66bibidIs0HKSuGd1Cg=
X-Gm-Gg: AY/fxX7bWqP4Xxm2utjFaWI0HJWutuL4GCZqgx+b5WSdkh5Dj3088D7fVrg9jyfJ1wL
	IX+nQ2j7fhH2S9p1dW+pj3Qxs/BhcKakbS8y7AzbhwkFhnuYN0K6yEihnmwi5t3Rda6D7Mn8whT
	5mcoSRI9SP+Ty+QAXZ4EDw8o/ZIHRHMdzlP1g/mywdZRmI58QAhnGCC5sc8S9vypKCmR4V8pM/c
	Z+7w3GgdlRu8qzBkD3QRK/tnFv/pP0oFpyqG3dTlKcPKKAYjTipNSEeDR6/GolMShWowkY=
X-Google-Smtp-Source: AGHT+IHtylA/bxKOBQa/5BrpQpDXWs7TrQhxamkqSqCTi0u9shFX4Ro8wkaVn7J682/HFMquHhNVpIK+9G7htYcHUKk=
X-Received: by 2002:a05:7022:6993:b0:11b:9b9f:4283 with SMTP id
 a92af1059eb24-121f8b46117mr7202025c88.24.1767926567604; Thu, 08 Jan 2026
 18:42:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107084149.173289-1-islituo@gmail.com> <20260107085949.GA35258@wp.pl>
 <d1806eda47fcb78344ed952e2a91b9c178650689.camel@sipsolutions.net>
 <CADm8Te=TRTgCaRm0Ebgos8n0qZ+7HJ7Q80Ck+-d8NtCMdAb1Zw@mail.gmail.com> <20260108163355.GA38716@wp.pl>
In-Reply-To: <20260108163355.GA38716@wp.pl>
From: Tuo Li <islituo@gmail.com>
Date: Fri, 9 Jan 2026 10:42:25 +0800
X-Gm-Features: AQt7F2puqd3rzMSKKBihnXPOShxjvwMtondWsrDyyKM5rLYlV7nlEaDJOzUsLHA
Message-ID: <CADm8TemGjSooBLR+0+rk+izhZcSSHruSjTeMFeH9-KpqZGd+1Q@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: iwlegacy: 3945-rs: fix possible null-pointer
 dereferences in il3945_rs_get_rate()
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:33=E2=80=AFAM Stanislaw Gruszka <stf_xl@wp.pl> wr=
ote:
>
> On Thu, Jan 08, 2026 at 09:28:30PM +0800, Tuo Li wrote:
> > On Thu, Jan 8, 2026 at 8:02=E2=80=AFPM Johannes Berg <johannes@sipsolut=
ions.net> wrote:
> > > I can apply this if you want, but for the record,
> > >
> > > > > +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > > > > @@ -626,10 +626,15 @@ il3945_rs_get_rate(void *il_r, struct ieee8=
0211_sta *sta, void *il_sta,
> > > > >
> > > > >     D_RATE("enter\n");
> > > > >
> > > > > +   if (!il_sta) {
> > > > > +           D_RATE("leave: No STA il data to update!\n");
> > > > > +           return;
> > > > > +   }
> > > > > +
> > >
> > > I don't see how this would be possible. _Maybe_ the other one, but I
> > > can't figure out any scenario in mac80211 where it could happen eithe=
r.
>
> Regarding checking the rs_sta->il, we can get rid of the ->il
> backpointer, it's only used for printing debug messages in a few
> functions. I don't think person needing to debug 3945 rate scaling
> algorithm exist nowadays :-)
>
> I'll send patch for that.
>
> > I don't have a concrete mac80211 execution path that would result in
> > il_sta being NULL here either. This issue was reported by a static
> > analysis tool, and after reviewing the code I noticed that the handling=
 is
> > not consistent with il3945_rs_tx_status(), which is why I submitted thi=
s
> > patch to add a defensive check.
>
> IMO is ok to have defensive checks (in reasonable amount :-)
>
> They can be marked with WARN_ON_ONCE like this:
>
>    if (WARN_ON_ONCE(!il_sta))
>         return
>
> that would clearly indicate the check is for 'not possible' scenario.
>
> Regards
> Stanislaw
>
>

Hi Stanislaw,

Thanks for your reply.

I will add a defensive WARN_ON_ONCE() at the beginning of
il3945_rs_get_rate() to catch this unexpected condition, and will submit a
v3 patch accordingly.

Best regards,
Tuo

