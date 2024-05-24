Return-Path: <linux-wireless+bounces-8048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A158CE8FC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7A01C2091B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 17:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7284376EB;
	Fri, 24 May 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K4zlo4ui"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B946FC3
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570146; cv=none; b=glLbJ2fdMaE6DaqmgQT3qIChZzflC+mS04m4GmXX/7g5BzpEJ/NlsEqHNiRDbDQlmA/SsUPpjh8uL6P2fB/pxQYUKspnco6OpaRbrzwf2OAm027xWT0UKr7upPoIKkOrnoNKRna+blkGL0dLYoZiz1zdndNhD8noEXipCuroRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570146; c=relaxed/simple;
	bh=wqOOh/1pKHk21Rs8PmFaDPTbCwsmNAhdP7Z6CT4+k80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VedxpkBUiWqCa+VsyVnH9hNTZO16SdZnFLkGoHfpMkF3ALlqe/CH3gGaJv5sx0xGJ/C6ZpKa+Qswgp73XMu+6D59g0rPq+T4Rc+hNQDTF/yIUJknBaIHkdietCu9X5h+MagHSlJVPRYhtoKI+jiQD2wmelJMzcDNAwc/vR09VjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K4zlo4ui; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6267639e86so134329566b.2
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716570143; x=1717174943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9kMv49pJMKnl/VPl7t2oqoLc0rJiWrPx5Kz6TyTRjM=;
        b=K4zlo4uiPZxN9+YaT/WGiMUwQaaiqRY2o8/sYdAQaMdkRZcB677nEJXAca2mtN9zaV
         FoVZDnHTNZI+fYxjzjbYNEn6B14MPbYZJNwiRxBP3ol74TfoGKDwdPm+pNIDT1gSiZi3
         9gzVEn3Yj+IhYY5mTe9S0DqwJ1nPL8tzTXFUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570143; x=1717174943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9kMv49pJMKnl/VPl7t2oqoLc0rJiWrPx5Kz6TyTRjM=;
        b=cXVrHCO8iKL+9sEsbfZUe7pLqZx4xpu4n/lC3pm2bxLeCdp1dNW4+0F83qsQ1xHsZv
         nxtotOQzTQj6d+/imMZcip0YfAPmD0n97rgLs0F0OR2SboedOImFCYMLHDaKcTgv3qQy
         9rZVGw6kox4gjgohn4hi8JvuUvPJ6vvgnP5NNDnP8arZLxV/jou3EjE9cTFiM4As56bk
         EfDbtplce1yfh6KsnGRLKu2lk9J7eNoubw6+5f6avsEJKI5dQLLpn8zyfxvc8z5jiGr1
         HvOQ19QtX5WLhRN00qN6u5hAfSyPJxb7NW5HnLje6+Uz/C7JYmmfeQmAkZzLGKYOAYkM
         PPBA==
X-Gm-Message-State: AOJu0Yy6FqNI4D7l7erlf8LIMPpKP2Qnhrmke3ghdwWgloGQ2LCrtQMa
	qs7MUBUC28X9kSOPpLCwTO57rrZ0foJGz7ROZg2ZSUbPiRje8HZEW+fv4ARK64qbiRWJRIIVFdJ
	4PQ==
X-Google-Smtp-Source: AGHT+IHrhwGiBYiFBvV9F4XKo0MySGkikK8kQ+6B68iIpUxkVCfhosiMPVhOV1bLi1kUqFlblD9lww==
X-Received: by 2002:a17:906:f14d:b0:a5a:6687:c6a9 with SMTP id a640c23a62f3a-a62649c07f7mr194648766b.42.1716570142803;
        Fri, 24 May 2024 10:02:22 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f95esm153907866b.104.2024.05.24.10.02.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 10:02:22 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5a5cb0e6b7so1321623266b.1
        for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 10:02:21 -0700 (PDT)
X-Received: by 2002:a17:907:9386:b0:a62:1b4f:6018 with SMTP id
 a640c23a62f3a-a6265148c51mr161965166b.54.1716570141375; Fri, 24 May 2024
 10:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418060626.431202-1-yu-hao.lin@nxp.com> <20240418060626.431202-2-yu-hao.lin@nxp.com>
 <Zk6TklTIbxZxIWyb@google.com> <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB9638DC958102D07A7B7084B6D1F52@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 24 May 2024 10:02:05 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
Message-ID: <CA+ASDXOE2Pwv3kRhwkAd1e3+U8zxZi7cX0TeLDkycQya9xkdPA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 2:46=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > From: Brian Norris <briannorris@chromium.org>
> >
> > On Thu, Apr 18, 2024 at 02:06:25PM +0800, David Lin wrote:
> > > +static int
> > > +mwifiex_cfg80211_probe_client(struct wiphy *wiphy,
> > > +                           struct net_device *dev, const u8 *peer,
> > > +                           u64 *cookie) {
> > > +     return -EOPNOTSUPP;
> > > +}
> > > +
> >
> > > +             mwifiex_cfg80211_ops.probe_client =3D
> > > +                     mwifiex_cfg80211_probe_client;
> >
> > For the record, I feel like this question was not adequately handled fr=
om v8.
> > That thread is:
> >
> > https://lore.kern/
> > el.org%2Fall%2FCA%2BASDXM1PEMRyxRpBryJ7G6e7yzG8Ku%2Bg2_qpHN3g5d
> > jFpAWkw%40mail.gmail.com%2F&data=3D05%7C02%7Cyu-hao.lin%40nxp.com%
> > 7C0b65f7e4a5fc46c8bdbc08dc7ac2c9ff%7C686ea1d3bc2b4c6fa92cd99c5c301
> > 635%7C0%7C0%7C638520224227876720%7CUnknown%7CTWFpbGZsb3d8eyJ
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C0%7C%7C%7C&sdata=3DMpqW1U4yTgDcM0g20DRSAxEnHkNNkd2hwsZrVAxg8p
> > w%3D&reserved=3D0
> > Re: [EXT] Re: [PATCH v8 1/2] wifi: mwifiex: add host mlme for client mo=
de
>
> The difference with and without hooking probe_client() is that "poll_comm=
and_supported" of hostapd will be set or not.
> If "poll_command_supported" is not set (won't hook probe_client), it will=
 let hostapd to set "use_monitor" and client can't
> connect to AP.

Yes, I already said that in the above reply.

If you read my v8 reply, my suggestion was that you need to fix
hostapd, rather than advertise lies in the kernel. You don't support
probe_client, so you shouldn't advertise it.

I think you should dig into the reasoning from this commit to figure
out what to do:
https://w1.fi/cgit/hostap/commit/?id=3Da11241fa114923b47892ad3279966839e9c2=
741d

Personally, I'm not sure what hostapd is doing with
NL80211_CMD_PROBE_CLIENT ... but you're the one submitting the code,
not me.

> Maybe I can put following comments:
>
> Hook probe_client to avoid hostapd to set "poll_command_supported" as 0 a=
nd set "use_monitor" to 1.

If we really can't fix hostapd, I'd avoid using such literal
descriptions of implementation details like variable names. Maybe
better:

"hostapd looks for NL80211_CMD_PROBE_CLIENT support; otherwise, it
requires monitor-mode support (which mwifiex doesn't support). Provide
fake probe_client support to work around this."

But again, please actually explore the reason hostapd is doing this
first, and see if you can fix it.

Brian

