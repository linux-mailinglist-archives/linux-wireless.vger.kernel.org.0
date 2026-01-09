Return-Path: <linux-wireless+bounces-30603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB312D0AD1B
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 16:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C227C3009080
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB53231A072;
	Fri,  9 Jan 2026 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laXN4EjF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC831078B
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971587; cv=none; b=iNjhMR2mXWm9kxrstEUf5lUlfVYt2qJAHRFlEiTxc1MWSY4JSxHyLpv/9esGieOD5wgZDyQbn7I6sN+06ov6z3rDRAGVpZDSQmWmxY5P8Ds0YbYp0eTLkcqlMecTCYB9VbCYX+g6uZgSzC7eZoAXuFk01tHrZ2z77qTmqtahioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971587; c=relaxed/simple;
	bh=wYORjvxfGTh2FlvoiC40LPqMdmDdmaINSQzgG7fEXSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kamjim4SLJ1/450igIsrl9yLYehkHbeIclmW63N2fpoGmG21eAuK5RMW1BDzaS3vbQOF0KhAmq7IQiMA5/SbympHuhqDCBBv7BIc0FNxARQ2gzsLIaaU390UIZ99imUz3NCEjQJsast6nbQsHJdekG/LX2CZKw+zrXegwoD+A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laXN4EjF; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11df4458a85so2436574c88.1
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 07:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767971585; x=1768576385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qsb2Dg3enhb/RCQsOD5dT9sSlAt7mEO56NWa2vXj6gA=;
        b=laXN4EjFRkXP4vEHMjXOvUzJr7NTh7eHHbyXd4uJMcH0k8FlYZriBT3FAK7NZCgJvN
         BhHZMBB4LKEZsODKxpOBJhV3T0VOmSQtiSt5f4YgAOoqa6LACXTPyhoIo8ol+MAK5qtH
         evhrS+Vrm5ucWj4yU3/ZRALlkI7bn+9x8gIpxinW+D8zr8ED+fVYQ+OmrflqaVKN2mBS
         E5x7H0OGXxXH64vB6NVIjBhxJqnkY673zT33It5FKnfspU3FIVQLcBUq967xj6uJM0bJ
         WJMXZgiM7RLXIQ2gtvkCI/YjBizL6ARf/f9IOWwI4+p1X96nB/qoP3EpUWCmh0AKrax8
         t8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767971585; x=1768576385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qsb2Dg3enhb/RCQsOD5dT9sSlAt7mEO56NWa2vXj6gA=;
        b=G+SUKmTahg/0mxOBEynRlJoczW6h7MVfpy95/0Jsyux50/0HC3Ehkgyq0sU4uehg8k
         igDU5MADFK8NscD1xurbE1srYJMXDjwzX9j3AoWSmIg9F6CzQijBI7caiXmNyu+W9iP5
         GNxoVEp6Zok+Vb4Wata3vHYm5xANMw3WQwQam3hYQPy+NsHDO9cIuvJZ65x7FOTBsFFs
         Fm2qd+v1bh2Drf0WzHg/mo0ptK0QlkkzD6RFb7MBUSpwGTI5kjhAnVkuHIvqGNmHRcCP
         yoZ0nIh4F/ADSmwUM4SGhNLmJ8upsWWsIDxKHEI75asUoAQ20K1crbSnKuN0JTqnmGPl
         hkgQ==
X-Gm-Message-State: AOJu0Yw5gqGBZxZ9weWucVsgIgFOsd1IRMN5dbVx+gVwAeRhtSzM8M2n
	9VOOzRlYN8xFtQ6t/dBrz/RNRwCcCqCnFp/1O66y375pw1jgfY+kK2Gyi5ZIMviSclei4TJM75a
	bc7F1ndN/r+tbz1QziRSdo4/ts2QLKeA=
X-Gm-Gg: AY/fxX4kpPRNA4Oq7tTtumlV5rsrYNAFcGcTGJYf9egnWD0HYx4ms1vP7dMmct4UjHX
	1ppk1+7hMsngI1UbKLhEPchTbvJ+hpjLi6c6u+LChq39rWltu1Nemlb+10u341qd6HhjD1a47fR
	2Yh+YOPhiCtVAZrGrJUoQO9dX8psfUDfg9rNHIKJ3va+/r3I/+v+uF7M4XSc2MnQdQWXdKk6s3u
	dIOylxLHfzp+Rm933c/JFXmvvY34jJUJJ/P+203SPF4AvAgeNf7Bel129bMjFWD/vL1E7M=
X-Google-Smtp-Source: AGHT+IGx9U3vDvpPxzlH+MGaDo+dUNQNRqw67udM75RVmExZz+7RFg1WPhii30NiTu/vkgXUrupcMeLbV8Mns4Xmxl4=
X-Received: by 2002:a05:7022:621:b0:122:9d:bd43 with SMTP id
 a92af1059eb24-122009dc38cmr5494185c88.19.1767971585223; Fri, 09 Jan 2026
 07:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109034014.187124-1-islituo@gmail.com> <20260109090227.GA48150@wp.pl>
In-Reply-To: <20260109090227.GA48150@wp.pl>
From: Tuo Li <islituo@gmail.com>
Date: Fri, 9 Jan 2026 23:12:55 +0800
X-Gm-Features: AQt7F2ptWObMroha8JQQJyN75fK905-7VE3N52KjCPUvCdw9LbR3s076dKwFbSM
Message-ID: <CADm8Tenw9kpk9suABMEYguURxtWrXRaRAiXogxUfwSash-c0ng@mail.gmail.com>
Subject: Re: [PATCH v3] wifi: iwlegacy: 3945-rs: add a defensive WARN_ON_ONCE
 for il_sta in il3945_rs_get_rate()
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stanislaw,

On Fri, Jan 9, 2026 at 5:02=E2=80=AFPM Stanislaw Gruszka <stf_xl@wp.pl> wro=
te:
>
> Hi Tuo,
>
> On Fri, Jan 09, 2026 at 11:40:14AM +0800, Tuo Li wrote:
> > In this function, il_sta is not expected to be NULL. Add a defensive
> > WARN_ON_ONCE() to catch this unexpected condition and aid debugging.
> >
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> > ---
> > v3:
> > * Replace plain NULL check with WARN_ON_ONCE() and update subject to be=
tter
> >   reflect defensive nature of the check.
> >   Thanks to Johannes Berg and Stanislaw Gruszka for helpful advice.
> > v2:
> > * Return early for uninitialized STA il data and align D_RATE messages =
with
> >   il3945_rs_tx_status(). Add a wifi: prefix to the patch title.
> >   Thanks to Stanislaw Gruszka for the helpful advice.
> > ---
> >  drivers/net/wireless/intel/iwlegacy/3945-rs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/ne=
t/wireless/intel/iwlegacy/3945-rs.c
> > index 1826c37c090c..463565ce14af 100644
> > --- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > @@ -626,6 +626,9 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_sta=
 *sta, void *il_sta,
> >
> >       D_RATE("enter\n");
> >
> > +     if (WARN_ON_ONCE(!il_sta))
> > +             return;
> > +
>
> Sorry for giving you wrong advice before, but after examining related cod=
e
> I agree with Johannes the il_sta can not be NULL.
> Now, I think we should just remove il_sta/rs_sta pointer check.
>
> Regards
> Stanislaw

Thanks for the follow-up and your patience. I appreciate you taking
another look at the code.

Just to confirm, would you like me to submit a v4 patch that removes the
unnecessary il_sta / rs_sta checks, e.g.:

in il3945_rs_get_rate():

- if (rs_sta && !rs_sta->il) {
+ if (!rs_sta->il) {

and in il3945_rs_tx_status():

- if (!il_sta) {
-     D_RATE("leave: No STA il data to update!\n");
-     return;
- }

If a v4 is not needed, I'm also fine with dropping this patch series.

Best regards,
Tuo

