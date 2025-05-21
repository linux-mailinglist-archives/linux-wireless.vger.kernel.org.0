Return-Path: <linux-wireless+bounces-23245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E93B8ABFE06
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 22:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7591BA7CD6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527AC29C35C;
	Wed, 21 May 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBA9mmoT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A92673BA;
	Wed, 21 May 2025 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860200; cv=none; b=jb3qiQWh8Y9cn08jznDO6WfRhZsO/6CDu1dsydVLup8aU9XE+lUsrfJBqw7dhPQ98mJjUuleFp/suX2skTuykZCXB0fWcoPsF5Az/XERe2iB335ipvZ+4HnMEG/AeA73O1Q1m6nr40lgdJ1prVApqODVvGw1e9unMkeJ7s11Kzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860200; c=relaxed/simple;
	bh=IwrRCiDNtk8v6QhRVXRTWIgPaS40Y4CEAbnOkbHmGGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVo9fbqXiYCwLR32AwgDPuwjfrYyu/P5dIO2TexELM8ukGS+1uLPgfzXBtmpV4xXlCgMux/fs88GzDzmK3Uh4vGboDuLIp/vbXyUr5p1pPUboA2hJT+rnDXsANbbgCDh5G/Z8YWwDGeLzxdudj2AxpoRusmLba8tyO0aF5jyWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBA9mmoT; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70dda931089so32711587b3.1;
        Wed, 21 May 2025 13:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747860197; x=1748464997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/DjaVjylUwkku9SaRveOg/Gwyx+o4sa3Ygm6F3w6CM=;
        b=KBA9mmoT+rT9ToW6m+fzXgrZRpoRf2L+v0g6S/n6Bxu0TBNZpqNHg07xuclo9Jb7BH
         GEKOLRxWl1ETfAPHw3nEZm3FMmlBi5HoL4ejW1UPiLZCPsqPtOYLPdiEgMJUAbadUAD3
         HUAiuHqGqfnCQScWQ+vPCOKNW/GwhxzEH3b4zotze/ADBHt+9jhiWbaLIujosXvOVCV3
         ZSH1Ek3ElT/3u+1qpBgi0eSJIr0N0UXX+qCiy6hbyX0qGQqktU32R0O+aMgXKZ49Ew7O
         jgyQZB01WwRZ+8VNwCnwLrD/uUkM2aK0G2ygs767MNC576+rhlMId9kp815WaqDCTwjG
         7WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747860197; x=1748464997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/DjaVjylUwkku9SaRveOg/Gwyx+o4sa3Ygm6F3w6CM=;
        b=TO+qm+ugeLsW/gZlmj+T71ueyLwdL7a8xRZw1yeToCjdFIdt8huewiJTSH5NT8i+H2
         tc6biUUv4zFRY6HzFeXhy2EHHgh3Mj7CSTB01ROQSjA+XY3sxeB235eg7tUJoh3hUV5n
         L47hNllq7MO2Uj9z7E+CR5rZQMciDq5ndpSvrUK7SUoi7eICxc6EEqzHkPvyA7CH5jWm
         c5MgAeWMMOv+/N/MvE6G1VXVy81NL14r/GuH8/zaXwiaUAC/us0AAFOFAiHCYUT1vqsC
         AcGnYNTIX4LZNmsBCvWUankfglmeH3xg/IUMafUBwePL6YvK4VZics2qmcb8l0zxGcll
         Lh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPQpF/iDDaGj7UNhaEw64RYaYRwJoR6MXoLr0ttlY1uMFyqG+2eX2OJXEllNcobpypqlkfW4B7zeZR3FXf@vger.kernel.org, AJvYcCWsuXoJ2l4R0mgHb1+Bjel3mnqZRrQgafi61QrFba7fBEgMmRcivDRW6oR3M7nicw9v+O20CvuxyejG@vger.kernel.org, AJvYcCXeiFAzfijcqBgdHvJeTyvHZ8fzRqEZlzNLuUqF+86aJxvO2e9RGa/NSXm4R9GlD+yw1h1sO+ZKAW7Uvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEN1txWwaeFF/GERnW9afpEARJKxegM2twIsqY/Vjago+I+tr
	M1Z1+kBpmxexV7Xz+oEU8pTyg2ICoyMFrnQbSfpHWtAW3sXird1g/08LOZkih7VuH+PMuqo4YIJ
	pWdWSDrpgKH2ZBtFeZHHt8wWANUbEbfw=
X-Gm-Gg: ASbGnctUEpW3Hrh3nK8da332GSQkO9dcGn3HvnzNRMUatxCvUvobvhW8vUwiDPzp1u6
	VOKYS+rzPC/2hCbYWjFdEduRkdmBuxS/HNVvSVFcWIG3Gvg+0063gRQSJ9HFY5NMeYJotp2EW6j
	3hZ18we9pp2C6FJrsRxThdu7c50tmaOE2z51ZKYr0fjk9ogg==
X-Google-Smtp-Source: AGHT+IEO6sBgvdCHcR8JGZXZ4dzSUK0Nu5a1MgT/3BhJ0uncUhOOu/EW2B4W5UgPvtgkogJGshbmnl27422KYGnc9cQ=
X-Received: by 2002:a05:690c:8e0b:b0:6fd:97a7:1474 with SMTP id
 00721157ae682-70ca7a30020mr296466807b3.11.1747860197547; Wed, 21 May 2025
 13:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521021557.666611-1-rosenp@gmail.com> <20250521021557.666611-4-rosenp@gmail.com>
 <5de13266-d6d4-4497-8913-e442080702ed@kernel.org>
In-Reply-To: <5de13266-d6d4-4497-8913-e442080702ed@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 21 May 2025 13:43:06 -0700
X-Gm-Features: AX0GCFtCgtQspZEgjiG8yAwSQqWmuBRmHD0YqwzNjsX_MMXlabY3ueL4Vk3cb18
Message-ID: <CAKxU2N9LJcX2AbCipk9nzHQhx=AKT2gUV8-Bk91BLzrUwfkGYw@mail.gmail.com>
Subject: Re: [PATCH 3/4] wifi: ath9k: ahb: replace id_table with of
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 4:08=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 21/05/2025 04:15, Rosen Penev wrote:
> > -             .name =3D "qca955x_wmac",
> > -             .driver_data =3D AR9300_DEVID_QCA955X,
> > -     },
> > -     {
> > -             .name =3D "qca953x_wmac",
> > -             .driver_data =3D AR9300_DEVID_AR953X,
> > -     },
> > -     {
> > -             .name =3D "qca956x_wmac",
> > -             .driver_data =3D AR9300_DEVID_QCA956X,
> > -     },
> > +static const struct of_device_id ath9k_of_match_table[] =3D {
> > +     { .compatible =3D "qca,ar9130-wmac", .data =3D (void *)AR5416_AR9=
100_DEVID },
> > +     { .compatible =3D "qca,ar9330-wmac", .data =3D (void *)AR9300_DEV=
ID_AR9330 },
> > +     { .compatible =3D "qca,ar9340-wmac", .data =3D (void *)AR9300_DEV=
ID_AR9340 },
> > +     { .compatible =3D "qca,qca9530-wmac", .data =3D (void *)AR9300_DE=
VID_AR953X },
> > +     { .compatible =3D "qca,qca9550-wmac", .data =3D (void *)AR9300_DE=
VID_QCA955X },
> > +     { .compatible =3D "qca,qca9560-wmac", .data =3D (void *)AR9300_DE=
VID_QCA956X },
>
> Undocumented ABI.
Hrm wonder where to document.

Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml

sounds like the place but that file looks like it's for pci(e) only.
This patch adds the bindings to ahb, not pci(e).
>
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
>
>
> >       {},
> >  };
> >
> > @@ -72,20 +55,16 @@ static const struct ath_bus_ops ath_ahb_bus_ops  =
=3D {
> >
> >  static int ath_ahb_probe(struct platform_device *pdev)
> >  {
> > -     const struct platform_device_id *id =3D platform_get_device_id(pd=
ev);
> > +     const struct of_device_id *match;
> >       struct ieee80211_hw *hw;
> >       struct ath_softc *sc;
> >       struct ath_hw *ah;
> >       void __iomem *mem;
> >       char hw_name[64];
> > +     u16 dev_id;
> >       int irq;
> >       int ret;
> >
> > -     if (!dev_get_platdata(&pdev->dev)) {
> > -             dev_err(&pdev->dev, "no platform data specified\n");
> > -             return -EINVAL;
> > -     }
> > -
> >       mem =3D devm_platform_ioremap_resource(pdev, 0);
> >       if (IS_ERR(mem)) {
> >               dev_err(&pdev->dev, "ioremap failed\n");
> > @@ -118,7 +97,9 @@ static int ath_ahb_probe(struct platform_device *pde=
v)
> >               goto err_free_hw;
> >       }
> >
> > -     ret =3D ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
> > +     match =3D of_match_device(ath9k_of_match_table, &pdev->dev);
>
> There is a wrapper for getting data, use it.
I assume you mean of_device_get_match_data. Will do.
>
> > +     dev_id =3D (uintptr_t)match->data;
>
> And dev_id is enum? Then you want kernel_ulong_t.
The entries specified in data are macros in the form of 0xYYYY. This
is why I used u16. The ath9k_init_device takes an int here.

Interestingly enough in the newer ath drivers, it looks like these
macros are placed in an enum. ath9k uses a u16 field in the struct.

As for kernel_ulong_t, ath12k uses that, ath10k uintptr_t. I assume
the former is more appropriate.
>
>
>
>
> Best regards,
> Krzysztof

