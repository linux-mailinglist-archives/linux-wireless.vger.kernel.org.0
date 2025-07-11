Return-Path: <linux-wireless+bounces-25295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C856B025CF
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 22:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D448B565466
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78761F8690;
	Fri, 11 Jul 2025 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvPPO867"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523D1E1A3F;
	Fri, 11 Jul 2025 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266021; cv=none; b=WNl/mWeh4Qm4k1bJSJz5Rcik5/ryBY080XrpFRdwmbQ9f1bT0aEnzuZY/vblqChCayTevbAvtf5GiO3fe02g7nAncL5d7NBDdG8TjbiT0ZldPeDndq1wQcmush1MQjNi3wixV6e3PISeQxwLmNv6jUTcV1v7PQs7aFINm20wA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266021; c=relaxed/simple;
	bh=NrMXrrO1fDdf1kb6QY2CgRjqtOqdyEvHplWcXmAzEig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crSQ0KSa0oqJkVJguG+IKONcjD8tWGqK6KhFHLQSHdBTZChnsJvHTuGNQk03kBcFrHnvN+F7FcpuqbVMT3nS7Uy7Upu7eVIMh9RcNkGtu7WhRWbfisdH91VpqwYPRDwh0iBMkSP2mnk2dBG/7YaxITyY13P5yiADS0Jbndj/2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvPPO867; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e819ebc3144so2435707276.0;
        Fri, 11 Jul 2025 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752266019; x=1752870819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68zxtYLTKBpsqGG1ojSx4GWgoXoxkdYc8QUb/iTWC04=;
        b=ZvPPO867vrkXUQzC0xvCMD9jKcOOioi+mYff6gTUkOVmWM428cJJieBmneALxORRhm
         cINxDPcARX8HTOCstblsYWajdnLYO52NQb5b1eQp1KyAcx3Lol1p9/4C36WJfP8WQrzO
         TLEvGJGIJewRzc5jsGXQvOjtUQ9/Idd7mhwXTPN+dAVsMVdZ+dLKs755BZw9YkRpqFu0
         BczunCtcTaNcUMq5plB9cmIj1okjczejak6bFFart4ZYrbE6b/e2FqwYhiCKgCBjm6pa
         3eeLnhtbgBV4zCqPZPTF8onI4ztJCdq22EP/348ZdevuFitqhNhrRHyuzBTXC5OaO55e
         Q1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266019; x=1752870819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68zxtYLTKBpsqGG1ojSx4GWgoXoxkdYc8QUb/iTWC04=;
        b=P0vTZ4CAlmL/6w+7Gr7qU8Rotowt6qZ+shORv/4euWRLamq0o9zkut86cU3ds5tm0p
         qD+yzaBwwVY1VS++b1GdtHDj0kDFNFG4SMAvCmaOBWYgOYa7i4l+3y3FGdRLKHIPn4d5
         dBG+iFnoLyXiV52ywp3eEQYZTkPweMhzT9WxJLs1soKebZQELxOVQ4AZ2W9hxI4/DmSP
         era3wjPv1RSVYfaKSDtTZ6XPw1Gmvqh15muK9YzfIdEoqsR/RXibm/u6TezicyauYkHK
         5ur8uaMTYeSXu0unZqaN7fQfroB5rAXca+vRMbMl4jw5jbjYys+/8DQdFyLESQmPWxl5
         I+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/JMtZTXiGF7+vbSfveVo1Etw16YJvZOmkia+lmzfktrbSxMmZibgw63fG4BWG7SCH7nklOtUVdVKA@vger.kernel.org, AJvYcCVSq3VEpZF64NH5GNGYIjbAuWYx6Ab05BQtSfhFfPCCUc/TPmwDJ4vyYLzdSGrgp05oERfzLk65F88pTEijiMs=@vger.kernel.org, AJvYcCWpWfspHg+QBVOpH/7i3U2VKD2yeJDMq37vtFPctWBZKoMEJg5P2GLPu8RaGBFCQTRB7C4s7jHOMp1PSA==@vger.kernel.org, AJvYcCWqwEtiF8L4fB5Idw/l7gAeIDk3HF1WAJ4q2VNGMG00M/A4DBhNzZy0IZIZz3N/fw6t64lW5eDAsbwhBZjG@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLhTp8GDi3+6L0H3ZqTZTYzkERq1/cA4QKYniztKfbd7k5ovJ
	aAy74efoRzPJEalT/G2sfLFc3oPbx3nUP9kAy72Ocak0Hu5pRVRwCadArRiGTOit1ZdjGTBm0eZ
	x4J+e+uw2vwLFfGUiC4OnLZgyk/s/GMs=
X-Gm-Gg: ASbGncucjP4aOhAzjlcanbyk1w8zOmsT3CVJ+ppgQdWKIQesCox7kHcHdTmOjimnka2
	uYPhDgl3kMZHo8n0DzIFZ4r06ltgAJ9VW1WUfDinMuC8KiW6WaASxCEL0ly+aI98Pd+SlhOBTgB
	nyEOZKGaPFjtIb/AKaDcPGqG5x2XbeEF/okHcg41onmXbSyMoUNdT6XU39edOcoKqiffYkDU9QY
	XeQnJTOnizu/oSS1IV6
X-Google-Smtp-Source: AGHT+IFg+WUq3I+LgojCtWQCG1ohGsNvGS0P6Am8moryAkN0ougdp4dlLradnGh+qIDN3ZBugeMbcm99Mg21Si+jSDc=
X-Received: by 2002:a05:690c:d18:b0:710:e7ad:9d52 with SMTP id
 00721157ae682-717dad97268mr58784337b3.14.1752266019055; Fri, 11 Jul 2025
 13:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710200820.262295-6-rosenp@gmail.com> <20250711140130.378067-1-oleksandr.savchenko.dn@bp.renesas.com>
In-Reply-To: <20250711140130.378067-1-oleksandr.savchenko.dn@bp.renesas.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 11 Jul 2025 13:33:27 -0700
X-Gm-Features: Ac12FXwXTVmcvlOTDwwKq18nH8e2J52S9X6I5huP6K-iIbpG3IV0HKFlWIK1Dro
Message-ID: <CAKxU2N9bjn5ybyTpk9Cc4B_GcLYdbEwPtzoxQkuEKH=MeTi-dQ@mail.gmail.com>
Subject: Re: [PATCHv3 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
To: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Cc: angelogioacchino.delregno@collabora.com, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, johannes@sipsolutions.net, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-wireless@vger.kernel.org, matthias.bgg@gmail.com, robh@kernel.org, 
	stf_xl@wp.pl, tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 7:01=E2=80=AFAM Alexander Savchenko
<oleksandr.savchenko.dn@bp.renesas.com> wrote:
>
> Hi Rosen,
>
> looks like here are memory leaks in the patch, PSB.
>
> > +     eeprom =3D devm_kzalloc(&pdev->dev, ops->eeprom_size, GFP_KERNEL)=
;
> > +     if (!eeprom)
> > +             return -ENOMEM;
> > +
> > +     rf =3D devm_kzalloc(&pdev->dev, ops->rf_size, GFP_KERNEL);
> > +     if (!rf)
> Here driver must freed eeprom memory resource.
> > +             return -ENOMEM;
> > +
> > +     hw =3D ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
> > +     if (!hw)
> Here driver must freed rf and eeprom resources.
> > +             return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allo=
cate hardware");
> > +
> > +     platform_set_drvdata(pdev, hw);
> > +
> > +     rt2x00dev =3D hw->priv;
> > +     rt2x00dev->dev =3D &pdev->dev;
> > +     rt2x00dev->ops =3D ops;
> > +     rt2x00dev->hw =3D hw;
> > +     rt2x00dev->irq =3D irq;
> > +     rt2x00dev->clk =3D clk;
> > +     rt2x00dev->eeprom =3D eeprom;
> > +     rt2x00dev->rf =3D rf;
> > +     rt2x00dev->name =3D pdev->dev.driver->name;
> > +     rt2x00dev->csr.base =3D mem;
> > +
> > +     rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
> > +
> > +     retval =3D rt2x00lib_probe_dev(rt2x00dev);
> > +     if (retval)
> > +             goto exit_free_device;
> > +
> > +     return 0;
> > +
> > +exit_free_device:
> > +     ieee80211_free_hw(hw);
> > +
> Here driver must freed rf and eeprom resources.
> > +     return retval;
> > +}
>
> Also need to check the rest of allocated resources: mem, irq, clk.
The point of devm is to not have to...
>
> BR,
> Alexander

