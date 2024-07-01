Return-Path: <linux-wireless+bounces-9795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F25991EAB5
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 00:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7021F2249D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 22:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD4A8120F;
	Mon,  1 Jul 2024 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beIWvZBQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5F4F602
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871674; cv=none; b=rMskPltvLbwUZkI1mh+OdEt+0aHkTtz5Ut9KeWGSMbY4LKPxe/JeLm3eEvwMk3WhsHHWk3yYBFhEFzpqF68+1st6SGWNRoe4yTBhJHl0IG1AVxi/Lm4wBgE4gCNo9+zlg9O3ST+FwVZxMKUr7mrcf3dki/AO/gcznR5hNqE0YC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871674; c=relaxed/simple;
	bh=K9WeiJMepvP3bvyvoRaE3WzlwKk+A3kRKK25uJgrcMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXitYJKA+aArDd0mlnC20Wddz06d3IS+t68K09lcCuLYFTpEWz8ogbXBZF9nwC3dWpWQoSDEl+TNElgZ/ev+cX0Pxa2Fzhiyg0pAaz/Eg6uMi1jczsoIBhUX1vbXL/YrNwS2Ov2Y/OXbFubEIGLcgrDI8extvrTesiXbStouxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beIWvZBQ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64f4fd64773so10796217b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719871672; x=1720476472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9WeiJMepvP3bvyvoRaE3WzlwKk+A3kRKK25uJgrcMw=;
        b=beIWvZBQObhyFoZqeyX5fQKquP0GgDhipiYKAZUi7gNcA+zsgrWxVhI7HrjR+xglXk
         9bxajckFHHkYpQV4ACUl/wlbzHHAerqFpIxOvpAVT06PBcM1wucRZ8FrcHbKY8TAYbNc
         mrOTAA8P7SU0eiBumhXdLiDizeVkRUKUmL4cmSBbfy3mRZ5FT256ZCttg4eTZcAd65JR
         RJu/WU8sNCAt1rk0t+qMXR7A1j8KKvnGUsqFQAJI8fKkIv3Xxkm6PSAKCSj1/VsWsLGz
         sMV783keJTEz6hGCymxlDV6BRTJ9WjihVU8QGAnEV7I/2S8ckQYaiMuzqKijuTJAtjxG
         5gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719871672; x=1720476472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9WeiJMepvP3bvyvoRaE3WzlwKk+A3kRKK25uJgrcMw=;
        b=iuV9S1qoi225qg2F9lojJkGGCQSXs19aKwnFR87d3ofdkn1UeUBH5wz+lIaFfAs6Zg
         ViOOnhl767zUj35muEEb3yarm4catqMgpAKJ88yoIrCgLMga3XBQeqEFRfz5UIRmxhe2
         l13CZfwsCWmzjfcbePy0G0EIk7R/bPz4YDD+bUXeGLGVYnTGmkV9UeEhHWE59ccvErOU
         gA16Cf8aIkaETTl87pgBuoh66vU5JYPH+NwbMzTZzG+6kAbhwin8tgj+HXayB81yM1ne
         qsJAhKkIZhIK8q7H0w+FCJUnGQtnsI1doAxv/6fnqwgdHAAA/xOA9IniuBvl5hhMqjZN
         EUmA==
X-Gm-Message-State: AOJu0YybePAbR60X7pHBluRq+71C3YLO+8lQNxqytRM7kqbhTBY0UubD
	w/84+nzxerb0rui0if/J+BrZ32OeXMUaDAM0UNJC9pKYuUFipiHusGRuGE7HalOPp5ffxESHBom
	EZS1ENDUJv+OL5RPdyiY1Jd/io2SJBarN
X-Google-Smtp-Source: AGHT+IFqkTlb6H/f/SX5y9lYpZk7tgdkebWbMsdox+aCNPllEDZl6YZak34oklhJU+NS+Qx2fv0UmwsUXmFAiiuPdzw=
X-Received: by 2002:a05:690c:c07:b0:646:5fc3:f9f0 with SMTP id
 00721157ae682-64c711440bemr97633257b3.11.1719871672453; Mon, 01 Jul 2024
 15:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628223237.16222-1-rosenp@gmail.com> <8f826bf3e6c2a676c4db37fdfd5b10e364abbb51.camel@sipsolutions.net>
 <CAKxU2N-L+B_DSTA9nsseDgnzCtgOvtSgd6pShEF-MmA=DQCR7A@mail.gmail.com> <a95d943d72123ddf4079262003516f29f52b06ad.camel@sipsolutions.net>
In-Reply-To: <a95d943d72123ddf4079262003516f29f52b06ad.camel@sipsolutions.net>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 1 Jul 2024 15:07:40 -0700
Message-ID: <CAKxU2N91jXA9hjdbPkfdQnHa1iehdBE+_K4QdsRGGfKu9V_sJw@mail.gmail.com>
Subject: Re: [PATCH] iw: fix formats under MIPS64/PPC
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 2:58=E2=80=AFPM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Mon, 2024-07-01 at 14:28 -0700, Rosen Penev wrote:
> > On Mon, Jul 1, 2024 at 3:01=E2=80=AFAM Johannes Berg <johannes@sipsolut=
ions.net> wrote:
> > >
> > > On Fri, 2024-06-28 at 15:32 -0700, Rosen Penev wrote:
> > > > __SANE_USERSPACE_TYPES__ needs to be defined to get consistent 64-b=
it
> > > > type defines and to fix -Wformat warnings.
> > > >
> > >
> > > How does this even work? Pretty much every file I checked in iw inclu=
des
> > > iw.h _last_ (or close to it), after netlink, nl80211.h etc., so ...?
> > > Doesn't really seem like it would have any effect?
> > I only tested compilation of iw itself, not of any project that uses it=
.
>
> Hm? It's iw itself only anyway? But where did you see warnings/errors,
> and why did they go away when this shouldn't have really done anything?
The whole codebase.

They go away because if the define is found before any header
inclusion, __u64 gets defined to unsigned long long.

Note that the header after the define include linux headers.

The impacted architectures can be found in the kernel with

git grep SANE_USERSPACE arch
>
> johannes
> >

