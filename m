Return-Path: <linux-wireless+bounces-14146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026379A22BC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 14:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6E81F21008
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C981DB92E;
	Thu, 17 Oct 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwd8T6kW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026EB1D8E01
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169365; cv=none; b=WAODgHQLmAMmFlbdq8vcqYhIzcfK8syYUvoemSgMPKA4BFW+hIcJELka6wVZK0UdVKfA2uNjSPDJXJvqVF/lg3wFO626XPYKLap7+JGpm4/zJTtlKcupPX7d/9hcT5ZFGckJ4RPNz0US8qQa5nb0C2EFqgBtfWp4uaz5/+1LFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169365; c=relaxed/simple;
	bh=POGnb0H0VGq5Z926vXAAUZ+cAPAV8dTicvqoLV2d0gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGo8hJSimdJksWKoxLHYdjZm/zlAdC07CFBTzlCS+XU2taPs2SEry4U5RfDA0f6G+8fQHP2AbGUkaP94hwoOGEGt/r4VsHb+jNm9Ac1mNCRjBsVwdCtVsdJunDhzH+C6qgCnBczwTQLNBMl6EuHKfYHm6jxvpryVSbziimFpX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwd8T6kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61919C4CEC5
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 12:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729169364;
	bh=POGnb0H0VGq5Z926vXAAUZ+cAPAV8dTicvqoLV2d0gk=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=kwd8T6kWeThp2WOLvXx/zQj6fMsJD9iiY/s2oR/mKghsRnKW8Ny//iPPAitMLIaEr
	 5il/ptjxqPvG8/Tq6z2/na++vc+hPFH9FUOH9ux++YaoxhxV13VodwCVE52lB5bxfi
	 7kz500bGsjqsBsefxo1JM7OuHqxCgxmT5CZei8U+Ur4l9B2z4PPRpMK479UaHXtL2F
	 lnEPE5CH43N02+IQ/ydcGhWqJsU7vqTKHVFEPU09tGnjtW3oRd4D9PaPy/ftR1PLkz
	 FMPX6Bkr75oBR8MiiZZQyoYebaihtih7QPOVHfE99KpFjrI3vflJmeoq1Nm/D0xoi9
	 XTZphpn3ARTyw==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e314136467so8238337b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 05:49:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlOi8eUjWNG8vBbVjnXR4279iQcZwCWKpXQvei4kHZEfcfJGOzvuTS90qiVON6Typ/1Jmb+lkfPFbzjU2wCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRqs3O9cy9aBVxKNcQVLrG44/uUMftB6Iydx7nIi4mmQzsYCV
	+DOyT5t+jnZJXieKyq7ZBQkqjClso6gQ0hBxyB39nlGEx08BJqBfRP+ej90Rl2NEzQWZM+O695x
	evbk1g2gmf0kQRq+FGStbwfQmdsM=
X-Google-Smtp-Source: AGHT+IEIsRINLrjCJSwg0aiCuQ99rkRpN72S9FT+zkS2Ic8v2O56g7Z/Z2WysHWhbFGWNfdr8j1qgSTSJ8pbCz2RCNw=
X-Received: by 2002:a05:690c:c19:b0:6bf:1ca2:f6ce with SMTP id
 00721157ae682-6e5a3d9bb1bmr27598037b3.11.1729169363653; Thu, 17 Oct 2024
 05:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016121544.5557-1-zenmchen@gmail.com> <CA+5PVA6gOcu611LcLzv47ZPwe-AtUb+GN2K-zK_84eMfk7Yc6A@mail.gmail.com>
 <8f3ebe73a46e4bf3b1b9eeb74bbc305a@realtek.com>
In-Reply-To: <8f3ebe73a46e4bf3b1b9eeb74bbc305a@realtek.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Thu, 17 Oct 2024 08:49:12 -0400
X-Gmail-Original-Message-ID: <CA+5PVA4c+5oow0qhXe9wkbkQtzaDW2y8raQYnPP0G_wUesSicQ@mail.gmail.com>
Message-ID: <CA+5PVA4c+5oow0qhXe9wkbkQtzaDW2y8raQYnPP0G_wUesSicQ@mail.gmail.com>
Subject: Re: [PATCH] rtlwifi: Update firmware for RTL8192FU to v7.3
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Zenm Chen <zenmchen@gmail.com>, 
	"linux-firmware@kernel.org" <linux-firmware@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:36=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Josh Boyer <jwboyer@kernel.org> wrote:
> >
> > Ping-Ke, can we get an Acked-by for this?
> >
>
> Confirmed with released package, so
>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/333

>
> By the way, it seems you missed a pull-request [1] days ago.
> If not, sorry for the ping.
>
> [1] https://lore.kernel.org/linux-firmware/2e2e7eac86db45e8a1980021c7a398=
3d@realtek.com/T/#u

I replied on that thread.

josh

