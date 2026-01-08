Return-Path: <linux-wireless+bounces-30567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED28BD043AB
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 422E23023CA2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0F47DD4F;
	Thu,  8 Jan 2026 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViUHK0Bw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F138C47DD50
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878926; cv=none; b=Q+V3d9s1Tx3YXisE/T4FpOX0uoTRZEITlVuWsgN5SfywJ2TvZXBJQsqc4j/alvT/zCdJui6CrSHmFPJJ+IXxwHWKwqbEEJ59e+5zbafo3jNjUwFEcJEHkFCghWX2ncQdy94ZWReO9p6XAi6H6glNce5QZJyFdjGNRbnhiYM4JXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878926; c=relaxed/simple;
	bh=QofEQ/kjBc4/BTbJ+WN+GtZjjnIEf2MxkYVJyFVhzTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tNH1B1qqtlLbUfr2NZwodxyu6oKkQq/ce3jfn7/fu2XY+4706Q8QsH7NfiVp3psm5ULYni8v/kZgZyhSZsf+TOk4xaQ/+2/O8f214D8IG2qBJHtE6oJOU6tLa5BpZjRMU3VaN09fs3oGzA2/4N22C8+pskX3WQSReq+NW0OFqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViUHK0Bw; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121a0bcd364so3029632c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 05:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767878921; x=1768483721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeUPpD0Zua9siM6dxU6FaVOXLDp9L9DCIt+xoG7BMwo=;
        b=ViUHK0Bw3KujbEtreu0fPn9y+U7pteljWobebKB4gpjM2mVJ/xMvJ5U1P4N6YrFOfh
         gbJ0W/3cRduexjdlKjIn1nQ7kbl6tjWQgKhIWirhAGUjOy7obwq1NB5y4J1QEiR1MzO5
         dvUlWZRtT5H3w68+IKBjmyzGJDl20WufiC5Ct2q1Q2gS0JMV/TTUgFXVXfZpzyAIvdnu
         x61BXUGrQS8xMSMud6XLTR3BoTLSTSV3gyHHRxLBaEXVzjwDjlch2Jz4u5dN98naQK3f
         dllg+svNkGRBa1F5D3mGgcwUOwHASQCKaUuqqM6mwYkiE03ehz6007G2tywk1DDORWNb
         JhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767878921; x=1768483721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GeUPpD0Zua9siM6dxU6FaVOXLDp9L9DCIt+xoG7BMwo=;
        b=HZTntJdvBV6N4T3glkY/q2TKeU0vjhtT17xl3l9bRlZmgNpt+7y3RO6Wi1pf9EbAKL
         lK5jdQAexHhpvjbgcB93Bq8AvP8iXkjyJTkFs6ihr9ZnN3pWLD4QSGCZ1O462TSbqIEH
         7CRNfGn4K0ch1JXm6ZuiLmf5R/51GZiDWyS6l6Stu4ZA1MiNpL/4CIJtV4FKbkDACEqH
         7Amqm4l9hJ5dHwc/r5J4dEModMgwbjaylIMMAKnTgI/2WyTvtiJEBlFTJVzj+UXwdf72
         6V2Py7DOhG63TaYjwk/MswJ63ilL4zeg7E+w1EvgqRjnnysXPRKKkzo7OcfCheSZHVYR
         Rttw==
X-Forwarded-Encrypted: i=1; AJvYcCWdcNiUyqz0r1Xvh8uFcTNClUiaaCe3cEfWQk5476sqmjLFBEiK9LKAZn494A8zIBGrNDRjNc+Y+hCYwUGBpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV6lBqeEbVsOKIx56bdYk3qZH6Q/pqna4N9A6FSCE1aVc1MHQl
	yziTkX4Vn+z15UTAHf5n3L2neTj6aruNNFmiKlfVER/UgXGUzzo1ppChXATLmh633YLtC9N4G6L
	o0FOwFEPd8jNPaBLk0qLB6cJbJTMSj0E=
X-Gm-Gg: AY/fxX4GRVO2JkPC6I8/oAiW/koDq0sy4SgmcrfIb+ZMwvxMfKVX8qtGiSaYLMdB5j0
	3A4f1qN6bJwQBpDkkNDoi+nJ74weccJ5btUPiuGYyCX7EIOFjT3gBEJmReGTNM8fL9+oNx8yliv
	3AiuhzKKQX5wh7OlC5iP8FPp9ga4BAQX+0GTIYHclLnoRcU0q+ep3twC+Skyjrqt4Iu6n5zfTei
	FrCfYc63c+S8Jh/Q/pp02vZofE4P2oCs6DOYqQpdjOI+V19BtvRo2tmK++cgPqkX/juX5PRUEPT
	cqFNuQ==
X-Google-Smtp-Source: AGHT+IGzrySmMg3CQqu4Bhgvc3gOJ69zDsR5ERnUsBMLg41T6+MFI8yzLvMCR3A5zi1WRhawJTDLX9F0z1XK7f62B1I=
X-Received: by 2002:a05:7022:7a4:b0:119:e56c:18b1 with SMTP id
 a92af1059eb24-121f8b7c262mr5861666c88.25.1767878920946; Thu, 08 Jan 2026
 05:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107084149.173289-1-islituo@gmail.com> <20260107085949.GA35258@wp.pl>
 <d1806eda47fcb78344ed952e2a91b9c178650689.camel@sipsolutions.net>
In-Reply-To: <d1806eda47fcb78344ed952e2a91b9c178650689.camel@sipsolutions.net>
From: Tuo Li <islituo@gmail.com>
Date: Thu, 8 Jan 2026 21:28:30 +0800
X-Gm-Features: AQt7F2qLf2uCFIEOsP8sr-x_vQyroCQCJJNonI1l3UqJ9zk0Nqz7KrpsR6QGeck
Message-ID: <CADm8Te=TRTgCaRm0Ebgos8n0qZ+7HJ7Q80Ck+-d8NtCMdAb1Zw@mail.gmail.com>
Subject: Re: [PATCH v2] wifi: iwlegacy: 3945-rs: fix possible null-pointer
 dereferences in il3945_rs_get_rate()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Thu, Jan 8, 2026 at 8:02=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
> I can apply this if you want, but for the record,
>
> > > +++ b/drivers/net/wireless/intel/iwlegacy/3945-rs.c
> > > @@ -626,10 +626,15 @@ il3945_rs_get_rate(void *il_r, struct ieee80211=
_sta *sta, void *il_sta,
> > >
> > >     D_RATE("enter\n");
> > >
> > > +   if (!il_sta) {
> > > +           D_RATE("leave: No STA il data to update!\n");
> > > +           return;
> > > +   }
> > > +
>
> I don't see how this would be possible. _Maybe_ the other one, but I
> can't figure out any scenario in mac80211 where it could happen either.
>
> johannes

Thanks for the clarification.

I don't have a concrete mac80211 execution path that would result in
il_sta being NULL here either. This issue was reported by a static
analysis tool, and after reviewing the code I noticed that the handling is
not consistent with il3945_rs_tx_status(), which is why I submitted this
patch to add a defensive check.

If you believe this situation cannot occur in practice and the additional
check is unnecessary, I'm fine with dropping this change.

Thanks for taking the time to review this.

Best regards,
Tuo

