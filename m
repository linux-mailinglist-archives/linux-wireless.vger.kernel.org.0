Return-Path: <linux-wireless+bounces-24932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF5AFC9C0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 13:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099361BC1381
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 11:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298D1289362;
	Tue,  8 Jul 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJOIprM+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60752285C87
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974802; cv=none; b=WyCfyuP5euTwA6JiR1INkyWbXko9rGCLhnQFqmy+fPcm44e09QLlcmEgtisJCSF52NgnkBbxxUxT9E3e03Op/JgWG26C5mkNkX93HJwQQQBOh0ituM2/lR7OroKxqtmjaf/9I2f+VP90v6JCo7YIWic+Ftnr3UjWvC9wIBJTMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974802; c=relaxed/simple;
	bh=PP/nRES0refSi9cq4gobfXymUJyYLoSYF83VL/rzCtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJYPFmJkEqUvyklOIX2DLxsLB3fAjtnVBVImSBNA8zbyADqFc6ZsqeTL4xmYZh+VYFEmhilTy6e+r8xUszVWzQv6+9/K91qUjQ39frjXYDh4mZgSnt2ywOyYcEO9FuVVHiZqx4Z7+H95miNUgVaHFH/yQkvi7ztnXbyz0g3UqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJOIprM+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso840087266b.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751974799; x=1752579599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7XsSwbUp/mOEc+OxUU7ZniY2O1w0jJOgkWGd25EIFQ=;
        b=kJOIprM+ZmRWh9w+D1HWMhzmEModEbUCNUtgMwHe0bfQXsj/LAIYdkPi6QMiHLXiZR
         +mHBSigpjqDV++wgAU+br5xHbRr3K8rnkmTUn7NtRA8icsX8Iob4B87hmBloP9wVGKZN
         OG64QAQbPVrp7E9/8t/F6ySmr+MLR//ght3jJAJmC82g0jM8be7QXral/uun970S1SI6
         UtIyVVKt0YlaX7nWJeo4xzKbxtS4os0y57iJtHTNo0OHMoVBTAeJNysPHbhGziQWWFPG
         h/w2GcikdBJngCh4HN7Nn2YjOXgX648r9Qkuxk8N3OLqWkl8UbQW8KPdS5uiKv+uTdsk
         4bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974799; x=1752579599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7XsSwbUp/mOEc+OxUU7ZniY2O1w0jJOgkWGd25EIFQ=;
        b=SFCYKX6ZiyVBQ3p3cQ+eLm2CSNfhI6sbWmZa9J4NDXzOeKivlIOnNVHOmsrHc/ut8I
         aSA+fH60EZgOsCrovfdSBl8liNEoqagbr4NhFakQ8uBpEWMxHri7gUD5CbmvdUMjtdFm
         ZXuKquR/2w/JX6ZDOqnF1/6WHUsPB/1zkkSZvjxD92zSUHcBYXtIRdgIvg4Kq8kFn7ph
         w/sngpcHJfXj7JJlOuaNLbe3WV5Yc7RfRBogNppvZm5etw4mldMSZXaLoVJlYs3uFE7h
         Gvg9ICgUkw2y1nBDyc6goYjlFgTgJ3Afx6EK+MgXZAj80qM2kghn8mCG9c3WcT/qGRba
         tgIQ==
X-Gm-Message-State: AOJu0YxZZSEYsVn4XECu33c7v2e20Pqx7zUTRyUV+wEUA4vX1qXF2hk6
	hQq6PuKQoMrB0MUCTQCHU5BIfwW9Vq7pWDNKcs9Nci21v0sJAmbpBrIfQ8jmhr5R9NhRonQgoTl
	MEhIaMT8Dz5hRFPuTbBWOyFY4Q+rTkJU=
X-Gm-Gg: ASbGnctKvmlGFlH8Rzpkjp8KHYc8GZfXkIJawTPvMSTSM48owwwBgE12Ms3tcnoNM3F
	WbRYZlRXHWgCNQV/OF3oiFwYCF1SZNUHLB/HmCKT1z3B1RNkGLMshwmwN6fbsiA+Hd2JzVzfcWR
	jsTk5duwzTSUpTRxTbYaJPGv+NIG0C0MBoEpWQw7o7BW9OBw==
X-Google-Smtp-Source: AGHT+IEgo+vtTl/4je9Or1P8ZGqyStCFwDFnHVRBlyQUIwLsLNLozuoL+jpw14UVciDTtVLIPM/DyZ5JzZsZyyJ/RNk=
X-Received: by 2002:a17:907:d84a:b0:adb:428f:f748 with SMTP id
 a640c23a62f3a-ae6b00c14a2mr292905066b.21.1751974798305; Tue, 08 Jul 2025
 04:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708015005.6470-1-pkshih@gmail.com> <CAGb2v67YNZG_-MtJT_pncaqeQULj3FGLj7jpSUSOGTXe2ipGag@mail.gmail.com>
 <CAHrRpu=rcXQzBO-NdDYBxj02WpMAHyP8ZdQhU=ScO=bOQXk9Tw@mail.gmail.com>
In-Reply-To: <CAHrRpu=rcXQzBO-NdDYBxj02WpMAHyP8ZdQhU=ScO=bOQXk9Tw@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Tue, 8 Jul 2025 19:39:38 +0800
X-Gm-Features: Ac12FXwsPwSkxK_ZxMMIBpip1weD1s7hAJdxb58jw0nksGX7kpyDzz9o3eael0k
Message-ID: <CAHrRpunOPwX18qc8cUhHwjg40SvqvVYXQg1ZFjBSeVUa9QgkXw@mail.gmail.com>
Subject: Re: [PATCH v3] wireless-regdb: Update regulatory info for CEPT
 countries for 6GHz listed by WiFi Alliance
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping-Ke Shih <pkshih@gmail.com> wrote:
>
> Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > On Tue, Jul 8, 2025 at 9:50=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> =
wrote:
> > >
> > > From: Ping-Ke Shih <pkshih@realtek.com>
> > >
> > > The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
> > > countries including
> > >  - Albania (AL)
> > >  - Andorra (AD)
> > >  - Austria (AT)
> > >  - Belgium (BE)
> > >  - Georgia (GE)
> > >  - Iceland (IS)
> > >  - Liechtenstein (LI)
> > >  - Macedonia, The Former Yugoslav Republic of (MK)
> > >  - Moldova, Republic of (MD)
> > >  - Monaco (MC)
> > >  - Montenegro (ME)
> > >  - Norway (NO)
> > >  - Switzerland (CH)
> > >  - T=C3=BCrky (TR)
> > >  - Ukraine (UA)
> > > Add 6 GHz frequency entry if not being added yet.
> > >
> > > The following are skipped as they do not have corresponding entries i=
n
> > > the database yet. Adding an entry just for 6 GHz would cause 2.4 GHz =
and
> > > 5 GHz bands from the world domain to stop working.
> > >  - Faroe Islands (FO)
> > >  - Gibraltar (GI)
> > >  - Isle of Man (IM)
> > >  - San Marino (SM)
> > >  - Holy See (Vatican City State) (VA)
> >
> > I also went through the whole list, and it seems "Bosnia and Herzegovin=
a" (BA)
> > is missing a 6 GHz entry. Could you send a followup patch to add it?
> >
>
> Sure. I will go through whole CEPT countries for 6 GHz entries.

As a result, BA is a country missing a 6 GHz entry. SM and VA are
countries without
entries in database. I sent a patch to add BA then.

