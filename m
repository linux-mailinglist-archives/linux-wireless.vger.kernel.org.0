Return-Path: <linux-wireless+bounces-24895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64789AFC014
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 03:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70234A5EA9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 01:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D851EA7C6;
	Tue,  8 Jul 2025 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0BMvpoM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6E35893;
	Tue,  8 Jul 2025 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938613; cv=none; b=cIC+7jAqixLWwIU9yYAi958mpaLNlyfeNmXfGf1ltHpGiqbCfR2R7iOS/B4gwNcgVpuDe1yERDzGGqc+bKrRF9x8hulRTgFv4KT6VTgnzEBz7hSFyc21dMLCgylAbtfeoDAuWmi/O7j0Zjn3ZnS+Us2WnPmk5jFfVHFd5OuID98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938613; c=relaxed/simple;
	bh=Avaxz9DSkFwEoHjjtMp8udC5ARHJAivgQoHarpXCuSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLjcqBd6n2M+OKHluizaFPPfW1iUOXVr4B3RoHh9v9ktf+Z6ppRYAeV1kj4H4UgYDaN8qwpgDh/qjC3RNP1kPEt2yodwk6ClvtCMHYuwpqE6HYwWLQ+mtJFc7j4wb3tamz65RwjEh9HUM6kZ2RIla8R5hN6uz/Y1Uz8m+6wvos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0BMvpoM; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e898fb745beso4278949276.1;
        Mon, 07 Jul 2025 18:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751938611; x=1752543411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdPVyMeaiZRcAvUnLtrLn4eKjhsWSi1DSHgzYkr8RpU=;
        b=W0BMvpoMd1gA2s7ws/JN2m21h/1E5cSoykmsyQJlm4DkVLBjoMhA+WLuAeqawD14Op
         aoZJsg1x3hfOE5iNEOJFYsRiJkLTE+CuvZ2qYOj/ID6BUQRWvq/XuPWlO7dKV/3+FOhP
         33ez2DSksuBcy67FOwBXaPZOc1TJczgM6lNsnG20l9l6j+ARcOwf+8ujPzWXk013UbIY
         +Wg7x3zhNMngYF4HFy4wFdl94VT4LgHOScKOmohedA/1hoTrTXe2YSVNGUFilj+HPyn9
         ylRLUgrmnjXcPtwcovcYacggUSFkqKSDMbaN2BnSmjDuMxA6/eOa62tJ8YRotofemMZT
         xfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751938611; x=1752543411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdPVyMeaiZRcAvUnLtrLn4eKjhsWSi1DSHgzYkr8RpU=;
        b=rY1X3dc3yRrIGINoQmnijkm4DpB8SA/HT62xnE5eNxhmrx+hBCA7F0THvyCZHAc4AP
         WExDB2lhGds8m46tinKz61dYA/sUDMV0XcoE+5SdrGi97KYl3SRfb/x+Ses1so7Ma2CW
         2fn6Ki8fp1aY3G6Pv6jLdV0tBMWlADc2COFnu0W/ovLIEyUm8oyNT3rYyxDxB1tjUYfV
         0cn2Dl90CkgeKJ7NqcxRdgI3K1+FgesJQZZTp8Iz510sckw+h8DvXMkBO/sJB6ydLR6c
         aG8lpgAKCb28foffVyFJciuT9olhXnGt1JbxLNATUpDlC8Wi5/IEapu8wc+HWBibvAac
         zx2g==
X-Forwarded-Encrypted: i=1; AJvYcCU3FfIxjjBOKqYfNERF3bhjSoyosWuFkLHKha52JlmZQe0Yq38Uhwji1MoPOHkB1irneBA8B/Vwzu5E@vger.kernel.org, AJvYcCUDT86tY3ttMgOGZ69YU5Y0lBclYgkQq8MeHasA94Hyf3lRNS0HeOfzJKinCcM3mT1TKr8NaSbL/bX6BA==@vger.kernel.org, AJvYcCUuV7df80a5Vtqfj2hYu2XhBRZvshF64wS/TvNKZArO/Vo5Z00G9Wl9G0DC3UWDWLEonvOj7iXKr1waaFi1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgqq+mSp4KdzcHCd49v9gQfdCIOKVjFTKegOT2GNlEU5k4G3nr
	gk/w1AQOz2InTWbEsUebBAaQ2Vp4o2aiHp2gjdAFR0XcXQMx5NgEQjJL5oLRYQvVqxAlWVde+11
	LK+t4w8O0EeoQrLczr1Tib9GRjgfKMsI=
X-Gm-Gg: ASbGncuKVQxB9cLkgOkZ0T7A9VZEP3KU93uXgm63e7ki8lMyRTs/aN3BICmKe2BuhGA
	kSEyVJvJG7HtYHjWl4JHCe5fEvWHUq+WR6OzcAt9zYApkVIF9EEB2IOYzEej4GGtTGmUMeD/vvU
	xMR1YntkvXiAbedgwhqlr5z0vWGT1BsTu4Ildos/4BfVw39IEkMQuOXvCw
X-Google-Smtp-Source: AGHT+IFO1Gnx5DoyCjQ11hDnHQ411dqNvWC7iyWPTVkw3YPYOqNHtqbngJRaccnYpOD1O+rv6jI0VYqZFUnmW4/GDEk=
X-Received: by 2002:a05:690c:6281:b0:70e:4d8:5cab with SMTP id
 00721157ae682-717a06d14f8mr12559327b3.2.1751938610962; Mon, 07 Jul 2025
 18:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250706214111.45687-1-rosenp@gmail.com> <20250706214111.45687-7-rosenp@gmail.com>
 <aGxyD3mtzdNZPPnx@makrotopia.org>
In-Reply-To: <aGxyD3mtzdNZPPnx@makrotopia.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 7 Jul 2025 18:36:40 -0700
X-Gm-Features: Ac12FXx7wdzhMSpG9qsFW5oZq8dvKPM90aqNfnrzqCYvgI2qkd94oIBt5lbPXeQ
Message-ID: <CAKxU2N8cLYm5if7TJ_YMnQ0V9n3E6GSk_F-tYkqOpNfeDA5a-w@mail.gmail.com>
Subject: Re: [PATCH 6/6] MIPS: dts: ralink: mt7628a: add wifi binding
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, 
	yangshiji66@qq.com, ansuelsmth@gmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 6:19=E2=80=AFPM Daniel Golle <daniel@makrotopia.org>=
 wrote:
>
> On Sun, Jul 06, 2025 at 02:41:11PM -0700, Rosen Penev wrote:
> > MT7620A devices all contain a wifi device as part of the SOC. Add it
> > here to get it working.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  arch/mips/boot/dts/ralink/mt7620a.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
>
> The commit title
>
> MIPS: dts: ralink: mt7628a: add wifi binding
That is embarrassing. I'm blaming my new Linux setup.
>
> seems wrong as the commit (correctly) touches mt7620a.dtsi and not
> mt7628a.dtsi (which would be wrong as the WiFi part of MT7628A is
> already supported by the mt76 driver and part of the device tree).
> Also the word 'binding' seems wrong in this context, you are adding
> a node to the device tree, not to the device tree bindings.
>
> I'd hence suggest to change the commit title to
>
> MIPS: dts: ralink: mt7620a: add wifi
Will do

