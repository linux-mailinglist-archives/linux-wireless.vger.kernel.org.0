Return-Path: <linux-wireless+bounces-30425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11170CFC8FB
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 09:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D6BF300FA2E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1A3274B5C;
	Wed,  7 Jan 2026 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaniZMwW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A081DF258
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767773835; cv=none; b=ezq/TROj8+j0X5H/Dv3VDdMI6wCXl7KQEqZ5xJ0SZbE3UCJfndmB1kmeoIl7bbo1AHnf24gCz8n1o2iKQyCWCT5yq2PW6zmo20nbt4Uo+R2cK6mXiRrA6bXlMVe+jq6V+82sQPFa6QrWbtHaDvQrjznn8bl7dBgf2n/ciKlkwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767773835; c=relaxed/simple;
	bh=zeOgNxusn4rgZWH5Ci+peiWRUn7O8H6+l6YudMDdn/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBTQA1ehFJzuhyyKiPG+noiDIbmd3W3B9brcaTBs+ckOtYpd7uTN9liRmRHpO8UD/PgtBG7BRWH7cDhOMsSZ1F2O5Uuhw3nAMqZpH3/luuA5iUSMTef8qoFew5oWjB21OQMjSkBhVFlIaTHq3y8QjXKYTft1yb9MSRkceMPtzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaniZMwW; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12056277571so1383219c88.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 00:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767773833; x=1768378633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BiWpH1gipBD/IHM0D4S5vCZJNxf4Ua0GGjsTz2952U=;
        b=YaniZMwWhkgVz4QX0jed1c3sQzHmXCOyKGcIhTSAU+myPEK9eWeHc8NEKV3e0Hs1hH
         MQ+1cjMN5C6SaYeV4bm8VrIuhm2pPpTCT72CaoBlO+lPwKOA8pXq77Iiw5H+zagJeKmM
         ix6w+iw2I980ZJfJoQrWs5SjZOxhCXBLpYINObu38Ffsg9MDnrfv69oLi//+alwagrko
         cNYee5V9bl5oJYArMJp0L9cZSDpx2ZI0Xa30e51WqdYKt9carLqFQUjpvgQywqL37bxG
         aPfKGd9a6IfPAIqu4qNb/gyqRE640DXkUMfRP7BqZUes8wpVKZ2MIDY939LhVnYFLw49
         PW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767773833; x=1768378633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6BiWpH1gipBD/IHM0D4S5vCZJNxf4Ua0GGjsTz2952U=;
        b=cx/KsljInh2GwHsBSJBgNCcgx293DQgKRk8fUV/X2WW9vxnAUG9lQhnr/nJvp/BN4N
         eHpzBWf9y3+Mp/yWlhPGXyTROSRfhDnCEK4bqRcmJinjx49lyLeLTNMtGOOBaubY6azm
         KF3XvNU4Nd+CKcq+tJvog555Mg1MnxTqG6tbp1KH2+6QwEN6muxm0LBOc2KpaX37UYY0
         N+TXT7/UjMdLv24HKiMoYrIqq3XMrx1EHLWRiau0n82IuOEkDGSYGaqckofyATTMlM7X
         s3DBrXjym6kXt5xRh1fQEk6c/oiQ2VOpE+F2o1JVT6ZfdIpKhFB6RTUBuMhgY1RIGTzN
         kMZQ==
X-Gm-Message-State: AOJu0YxJUetSDpZRUB5OOAq1V2kxj3XwgWQwMk6PCey2W9r76EwMxwff
	+FJyQ5ME7Q9OguQPGLVNDPjEjqtgFTk4iJlZ/7P57oD/sE9fnySMQ4xewyUW4jPiWwJuV5H0Hi1
	Ua17z3/uvC17wVZ9E8oBkLnXTEAvyhqw=
X-Gm-Gg: AY/fxX4E/Shs0Rx3aip65Xw4CDlxVISllscqn/sg2VsGlENSakt5OSgVoo8zvGbJ5/I
	e30b00VakQi/eGfEC4XC8NLytZGHSmAoBAQB0NyAzO2j/x93rdreru60DJcAzft/vWXSDs2Dtwn
	wf5fsfx64zHziE5iXfqvMfVGHFGBKwwvvLDJW56Vpq91L/ru3VM5LMnTpc5TTeahF6i87fxCHIp
	J9b+6QUEMt+PIm36DeL97663hj3XxfcG7b/WPb4If3epCdRmPnKBBy2YqN3ZcELIu3wAI5k6z17
	BVGfJQ==
X-Google-Smtp-Source: AGHT+IGP+L7rQRP3NxxP9+raEOJP0AxjwnzC1M2v73I5ETNjsbYcpPIpL0s6EMeRunuqszm2ADm+seaXzMH/3Uz+1II=
X-Received: by 2002:a05:7022:697:b0:119:e56b:98a5 with SMTP id
 a92af1059eb24-121f8b0db87mr1394873c88.12.1767773832727; Wed, 07 Jan 2026
 00:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107071001.172132-1-islituo@gmail.com> <20260107074438.GA34085@wp.pl>
 <20260107080641.GB34085@wp.pl>
In-Reply-To: <20260107080641.GB34085@wp.pl>
From: Tuo Li <islituo@gmail.com>
Date: Wed, 7 Jan 2026 16:16:51 +0800
X-Gm-Features: AQt7F2qLfNbC0b4W-_Jj9jJBx_ey77SONTPrxckaLR-CxmrI03-IjKZnzhljjKE
Message-ID: <CADm8TektKWu_-995cm+Z11eapTindr86YuWLHYefmfK8PLR2Gg@mail.gmail.com>
Subject: Re: [PATCH] iwlegacy: 3945-rs: fix possible null-pointer dereferences
 in il3945_rs_get_rate()
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:06=E2=80=AFPM Stanislaw Gruszka <stf_xl@wp.pl> wro=
te:
>
> On Wed, Jan 07, 2026 at 08:44:40AM +0100, Stanislaw Gruszka wrote:
> > On Wed, Jan 07, 2026 at 03:10:01PM +0800, Tuo Li wrote:
> > > In this function, il_sta is assigned to rs_sta, and rs_sta is derefer=
enced
> > > at several points. If il_sta is NULL, this can lead to null-pointer
> > > dereferences. To fix this issue, add an early check for il_sta and re=
turn
> > > if it is NULL, consistent with the handling in il3945_rs_tx_status().
> > >
> > > Signed-off-by: Tuo Li <islituo@gmail.com>
> > > ---
> > >  drivers/net/wireless/intel/iwlegacy/3945-rs.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/wireless/intel/iwlegacy/3945-rs.c b/drivers/=
net/wireless/intel/iwlegacy/3945-rs.c
> > > index 1826c37c090c..c13268093a6e 100644
> > > --- a/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > > +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > > @@ -626,8 +626,13 @@ il3945_rs_get_rate(void *il_r, struct ieee80211_=
sta *sta, void *il_sta,
> > >
> > >     D_RATE("enter\n");
> > >
> > > +   if (!il_sta) {
> > > +           D_RATE("leave: No STA il data available!\n");
> > > +           return;
> > > +   }
> > > +
> > >     /* Treat uninitialized rate scaling data same as non-existing. */
> > > -   if (rs_sta && !rs_sta->il) {
> > > +   if (!rs_sta->il) {
> > >             D_RATE("Rate scaling information not initialized yet.\n")=
;
> > >             il_sta =3D NULL;
> > Please also change to return here instead of setting il_sta to NULL.
> > And make D_RATE messages similar to il3945_rs_tx_status() i.e. :
> >
> >           if (!il_sta) {
> >                   D_RATE("leave: No STA il data to update!\n");
> >                   return;
> >           }
> >
> >           /* Treat uninitialized rate scaling data same as non-existing=
. */
> >           if (!rs_sta->il) {
> >                   D_RATE("leave: STA il data uninitialized!\n");
> >                   return;
> >           }
>
> Please also add 'wifi:' prefix to the patch title.
>
> Thanks
> Stanislaw

Hi Stanislaw,

Thank you for your reply. I will update the patch according to your
suggestions and submit a v2.

Sincerely,
Tuo

