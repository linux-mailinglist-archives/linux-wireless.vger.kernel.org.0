Return-Path: <linux-wireless+bounces-28355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C49EC19E29
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 11:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000553B120E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 10:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664028FA91;
	Wed, 29 Oct 2025 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="b09DoViT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C11B6CE9
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761734873; cv=none; b=JGZfHHSB4B0TdgSGMoYFLtDZLsoHPiXllj48zAFWyGRCFG47AAfz7RruN+VnQDQVcJRpa+ebGl+2p8t6GDNtC4m3eVpLbE5iqrwrL3j7N/kPtL4p3u73FsqWwyc7lGxpALe04/HngyGNJmHUGXRtuYru7zZpwOJksluyXJOEhxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761734873; c=relaxed/simple;
	bh=8uAn4tm93X4+hDNmoS8hcyVeQIWlasw2bFg/RIuYFLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJHpgLwJeVgrv4FB9xbfCmmPMEyawbyxFCKn1KcWvF6SuaVmolPeJLXrT8U2FaiiMtPS9BBZepCPb2/RxiKiLCDtwNESJ6uUIuBg5w/1OqwqpOJZO4mJ3GPY3Z68oXwhN7x6RvaV1qfuMKal4CEWepnCJSde7FZc8UwEdjvLvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg; spf=pass smtp.mailfrom=ndoo.sg; dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b=b09DoViT; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-54a9852eb65so343244e0c.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1761734871; x=1762339671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=508RUHYtGWt7m+qwKA3ucuo9vF6Sp8x7k1q1kc3KEek=;
        b=b09DoViTdcJmoEx5oylRKCYbBC2Oxs0D5QEUt6bpy4T97MhwflKL5dTBdUSq6F8EzD
         HpGH2w7E2YtqaBuhHlr9K6c8FMVoHBKN6ndBIlU+0J4zMnzUzRU6+xX54ezilnN0TzUL
         /uxt/fgXgSuSuXj0ED13Xp938vHvhH3jf4ti8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761734871; x=1762339671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=508RUHYtGWt7m+qwKA3ucuo9vF6Sp8x7k1q1kc3KEek=;
        b=rH7TR7W489f0d75a0/lRmbhfpsKJM16XtpteeFqVaycFY9VGHqSWM9pR/WqVYbEPMS
         AszB1ikkBm3C4DYluJ1pQbs3DT94iMt+c3sMj91bCRS//LA7S4ztQ9s6j+Kq+gNOzTK3
         iF6EsYpV2+r73qihvCFt2yBn5ssCRqE4Lc27ZgZj8nW0V+gQH95qgiUJk/928HWFLzl1
         7TyEOXFVo4hh9Z6jHAcW/Da9kxzu+gvwdgaHIlYxm+CMc8l373k7OSYXhxdoMMnYq59C
         K7ru13mDK2YT5XJxVcuMWSueRHf6fjU+cUaMoRczwl62yVJQ3z0BZA8IxzWX7rBz5Jj6
         83+w==
X-Gm-Message-State: AOJu0YzQzfEqpM8yLcJMsYga9mIUyP0E1FFIQuwgebiw+nK5kCBIxi7n
	9z3ddx4N708T1PHEXo4QIn20Nff+aGc3c2o0Ka8Up7z1YY7ngNvnbTTD6z9OS4zd+acVg7zwziX
	6pXqUB/Yq9G3mPAgiIk/Hnb+uUmXcRdLU2O3MvTjl
X-Gm-Gg: ASbGnct3qA4/B75sw4tIG2miLHlh77lidlbgKz0nICf+fyJ1AYv/x2okG17qNkroGEG
	nmDrLIhp630vm4MtKDs7iEyJRkfgmXVE2Dvx/A3zGddDB2etteZejgIEw5QK7qSWcsKWRy3GDZY
	PmDD3i9bi0ewav3lPyFTqB7wEP5Hgk6X+iuruy0khgf3bvhnfYjTLEpPmlRGU6GiYaLOv12g/uv
	SMm3P6cvtQH5wMt09pFWcty419IMA1HOgVcaugadQWKD/B/iTCUZfxauDnSB91zGJQKs/H0HcAu
	5s5H71M8D36VoWBCBnyTtaWRYONa+wIO+vmafvC3kvK9RHr8attmr6D6icT/77f3AjcEbJzHy9q
	d
X-Google-Smtp-Source: AGHT+IEDHQYUr3yUS537R0XnX3QsrqoL6zbVsQm078qe5Qm+U2B7RvoN+4ZvyzO2Bi4ozoYEif249PETQfPhnHjPTBA=
X-Received: by 2002:a05:6102:512b:b0:5db:33e2:1e1a with SMTP id
 ada2fe7eead31-5db906c7927mr270324137.7.1761734870477; Wed, 29 Oct 2025
 03:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029012429.68658-1-me@ndoo.sg> <CAGb2v64omSs0uVL00n7vGRF_-=qb8xLCjdnyWRq_Caukf2ntXA@mail.gmail.com>
In-Reply-To: <CAGb2v64omSs0uVL00n7vGRF_-=qb8xLCjdnyWRq_Caukf2ntXA@mail.gmail.com>
From: Andrew Yong <me@ndoo.sg>
Date: Wed, 29 Oct 2025 18:47:32 +0800
X-Gm-Features: AWmQ_bki6ZRBv2B276xYm3W6fj98b7-xdtKtov3wVDjWgQYzAM_RquLVDN2OPiU
Message-ID: <CA+yTfBB57CA5c=bKdOjPWYR7F9Nq38Bao3+Q3LKYjOYJJ8WfxQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Malaysia (MY)
 for 2025
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good day ChenYu,

Indeed, the commit message is also largely the same, there was
actually no differences relating to Wi-Fi class assignments, just some
moving around of the table rows because of changes to other unrelated
class assignments.

I just wanted to at least get the reference updated so that the next
person who comes along doesn't have to check against issue 2 of 2025.

I should have mentioned that on the new patch thread to save you the
extra comparison, sorry!

Andrew

On Wed, Oct 29, 2025 at 2:22=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wrot=
e:
>
> On Wed, Oct 29, 2025 at 9:24=E2=80=AFAM Andrew Yong <me@ndoo.sg> wrote:
> >
> > Malaysia Communications and Multimedia Commission announced CLASS ASSIG=
NMENT NO. 2 OF 2025[1].
> >
> > With reference to class assignments on pages 9 and 10, and Power Spectr=
al Density (PSD) limits on page 20, update the following rules:
> >
> > 2400-2500 MHz: Align previous 2402-2482 MHz rule to class assignment
> > 5150-5250 MHz:
> >   1. Align previous 5170-5250 MHz rule to class assignment
> >   2. Mark as NO-OUTDOOR
> > 5250-5350 MHz:
> >   1. Align previous 5250-5330 MHz rule to class assignment
> >   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calcu=
lated at 20 MHz channel width
> >   3. Mark as NO-OUTDOOR
> > 5470-5650 MHz:
> >   1. Align previous 5490-5650 MHz rule to class assignment
> >   2. Limit EIRP from 1 W to 200 mW due to PSD limit of 10 mW/MHz, calcu=
lated at 20 MHz channel width
> > 5725-5875 MHz: Align previous 5735-5835 MHz rule to class assignment
> > 5925-6425 MHz: Increase EIRP from 200 mW to 250 mW (remains within PSD =
limit of 12.5 mW/MHz)
> >
> > [1] https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignme=
nt-No-2-of-2025.pdf
> >
> > Signed-off-by: Andrew Yong <me@ndoo.sg>
>
> I applied it on top of your previous patch. Conflict resolution shrunk
> the patch down to just the URL change.
>
> ChenYu
>
> > ---
> >  db.txt | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index 1d17271..dc72989 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1450,14 +1450,16 @@ country MX: DFS-FCC
> >         (5925 - 6425 @ 320), (12), NO-OUTDOOR
> >
> >  # Source:
> > -# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-sig=
ned_19012022.pdf
> > +# https://www.mcmc.gov.my/skmmgovmy/media/General/pdf2/Class-Assignmen=
t-No-2-of-2025.pdf
> >  country MY: DFS-FCC
> > -       (2402 - 2482 @ 40), (500 mW)
> > -       (5170 - 5250 @ 80), (1000 mW), AUTO-BW
> > -       (5250 - 5330 @ 80), (1000 mW), DFS, AUTO-BW
> > -       (5490 - 5650 @ 160), (1000 mW), DFS
> > -       (5735 - 5835 @ 80), (1000 mW)
> > -       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> > +       (2400 - 2500 @ 40), (500 mW)
> > +       (5150 - 5250 @ 80), (1000 mW), AUTO-BW, NO-OUTDOOR
> > +       # 5250 - 5350 MHz regulatory limit is 1000 mW, but 200 mW reach=
es the PSD limit of 10 mW / MHz at 20 MHz channel width
> > +       (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, NO-OUTDOOR
> > +       # 5470 - 5650 MHz regulatory limit is 1000 mW, but 200 mW reach=
es the PSD limit of 10 mW / MHz at 20 MHz channel width
> > +       (5470 - 5650 @ 160), (200 mW), DFS
> > +       (5725 - 5875 @ 80), (1000 mW)
> > +       (5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
> >
> >  # Source:
> >  # https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
> > --
> > 2.50.1 (Apple Git-155)
> >
> >

