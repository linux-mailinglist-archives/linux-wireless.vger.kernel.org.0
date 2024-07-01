Return-Path: <linux-wireless+bounces-9799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51491EACA
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 00:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3821F222C7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 22:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB685923;
	Mon,  1 Jul 2024 22:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ljzs8rfj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840538394
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 22:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872584; cv=none; b=NpY+pYQcH6BG6OnHNiy/2lVoLHyqG98BMWYzrNy9S1SCOVYv87WfqQsLHgVZagTtdlpH1+UO5mqR3Wc3lf6CyoadPH+euKySZfGTFt40ggPmxqfyIz1ZVEoNLMOUMdje5mtlof1rCWol4lk1fYytfZE8oHt+IPeXXzoxtQJYa+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872584; c=relaxed/simple;
	bh=SWKMbWdT9aAdPmtjNc2uc29Jb04r/YzphsQk0d9jZr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iU8Td8Eu9Rj2JwZ0PQyby0lKz4yjsg/Q9ea39ZVJb0Id9Qv9PrrwBZtWOzeRXd8cbCduaGx01421kIrx0YVwGEB0IhbzawqQaU5jgW/BuXaMuDD9wk1P8AKNyWTNbp1oiVnE7Dtc50xKAOWMqPysQDZflt968j40qy67q1RC05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ljzs8rfj; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64361817e78so33532317b3.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719872582; x=1720477382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGyHU8XReqOFRXdPifxV5NrHgf0cvzTE1JX9SO9Ifb8=;
        b=Ljzs8rfj0d8cG16FJSJ3XIHirn9skruV8zt+2CQUlcj0OtHCAgA8Tw4EZsLEW2PN0T
         YMigvstDg0WEko5GSd+cD9liie0gH47j6MkSOKNdvRdoWAne8GosrxUi98l6H8/WYogq
         auwJWgc85pwANhKad17+GbDTJDvXxkO/COyq1N2zOo8csSQYnzgt+6SwIk0eNMmhwaSf
         XkQgZxh7lUmHqdIl/URquw2VWdzEoQb3mbF+xkRESakiU3wD+hdIE5BcBgvgZFUdVWOq
         wZclVCMB2ls6ll+pQffdAMhsKhu05QLAUZ+Vzrz1hxfW1fQg9plbClLyvDRMWD0p8z3T
         bwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719872582; x=1720477382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGyHU8XReqOFRXdPifxV5NrHgf0cvzTE1JX9SO9Ifb8=;
        b=VgMkMmjvU4h5mMwvvOTKAYmJ6SZGe2y4X7WJJCJekuH0asu0nRmhYwHya3AvKp6Jxi
         RlkevH+BP+ap75aZUTJVbPaXsenwA7t2N59xEYrQeXC2UEeZvCjL/m0aQozdeXwhO6aL
         1FYm+B3mUNEQVjjd1Yug0dsTccfZj2Z3ZyTJT7EoV8Ir1ft/gqIdnHRCOJUSDAdusLFr
         YAZ9BoRVnBFQvSJO3qKx0AYXmbDS5ZV/ucajR1jcohQnsqaKK9bVsESrE+MU/stmvTOa
         jQkUUbtSByuRZkElrCaY19Kbp8HEbOtU8GHwSwQunA30PvneQoSJXeMPhYKo43mLXtsJ
         PpIg==
X-Gm-Message-State: AOJu0Yycj/nnrMyv7/tLuoDHHrIxtomwbFXLG1QA7BhkrtJ0OmX+X4cG
	u4BJsyLBNI3KJ1YB7c/5L6zDvv+aUsnwXpK/+Nl6Fd8Om4FyHEsvlmo41Om3rdON1aO4g1m1JlL
	TatlO4/H3g5OaYs/fVHMJLA6o1PgKfA==
X-Google-Smtp-Source: AGHT+IFySrZn9ifNvmfbUtPcvihwQUnaRZlIDgL+grmopJ/WZ0rypKrynqnauuA3jQ8qbgbZSu8tk+H6+sc+aa+I0u4=
X-Received: by 2002:a81:b04d:0:b0:618:ce10:2fcd with SMTP id
 00721157ae682-64c71cd7bb7mr76690537b3.26.1719872581986; Mon, 01 Jul 2024
 15:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628223237.16222-1-rosenp@gmail.com> <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
 <CAKxU2N-L+B_DSTA9nsseDgnzCtgOvtSgd6pShEF-MmA=DQCR7A@mail.gmail.com>
 <a95d943d72123ddf4079262003516f29f52b06ad.camel@sipsolutions.net>
 <CAKxU2N91jXA9hjdbPkfdQnHa1iehdBE+_K4QdsRGGfKu9V_sJw@mail.gmail.com>
 <1dd82a549053f7c2d841a966704664ca785b14c9.camel@sipsolutions.net>
 <CAKxU2N-SH2pKTq4tQX+cJEceQ3EHN2nxQK+krr8q3VQ7a-3nrg@mail.gmail.com> <28fecb57a105ec177ccaf3a2742fade8a77b9102.camel@sipsolutions.net>
In-Reply-To: <28fecb57a105ec177ccaf3a2742fade8a77b9102.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 1 Jul 2024 15:22:51 -0700
Message-ID: <CAKxU2N8efnro015Bvc_EkeMPnB6BgepwMH5chvUwZGGdVfW+ig@mail.gmail.com>
Subject: Re: [PATCH] iw: fix formats under MIPS64/PPC
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 3:19=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Mon, 2024-07-01 at 15:16 -0700, Rosen Penev wrote:
> > On Mon, Jul 1, 2024 at 3:10=E2=80=AFPM Johannes Berg <johannes@sipsolut=
ions.net> wrote:
> > >
> > > On Mon, 2024-07-01 at 15:07 -0700, Rosen Penev wrote:
> > > >
> > > > They go away because if the define is found before any header
> > > > inclusion, __u64 gets defined to unsigned long long.
> > >
> > > It *isn't* found before any header inclusion though.
> > >
> > > For pretty much all of the C files, "iw.h" comes _last_ in the list o=
f
> > > included headers.
> > Oh I see what you mean. No real idea. However without this patch, I get
> >
> > event.c: In function 'parse_nan_match':
>
> OK, well, event.c is one of those cases where indeed most things are
> included indirectly via iw.h, so it would actually work ... but most
> files don't do that. Maybe lucky that they don't use 64-bit types (yet)?
>
> > I submitted a similar patch to fio and was advised to move the define
> > into the Makefiles. Not too sure how to do that here.
> >
>
> Probably a good idea, just add
>
>  CFLAGS +=3D -D__SANE_USERSPACE_TYPES__
Right. My thinking was to match against the system being built.

I guess it doesn't really hurt to just define everywhere. That's what
this patch does anyway.
>
> in the an appropriate place with the others.
>
> johannes

