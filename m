Return-Path: <linux-wireless+bounces-8403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421348D7BA7
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 08:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731281C20BEA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 06:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3111364A1;
	Mon,  3 Jun 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSHZBU/4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECF3364A0
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 06:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396633; cv=none; b=BVeYYF8VI30sh5IcnVfY3KHNlLHrG/QfvUPexECEjrXlvJ2E11qlRCHWk8DsDeBZYhsskJLj6xJjEDRS+mjBhz592pcajZvFKQ/2rk9AErRYhuevfAecsyr2KJlw5NzBHgTlqLvVFSHp7SziYofD/sX1lqntKzk4d2W7HxvJY9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396633; c=relaxed/simple;
	bh=r+ScYlwDpVsm4Opul/nINoPjqHOfc5m6DtAEqUh7eNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCBZ+xXhFIT7s5KZoVu2q6mhZ6VsKa9+hDQ3Sg34qkDQyyTXG+fRnTqCXgFx+ARK9VjkP4eKOASmgn1DGhgeJhjlCFQ+b8B4jzlXTrU0R60MdCaChp23VbO1ukEakUJ9KeoO5aw+lF8uisNfzCm1MGEDniWgds0go0nuHXev3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSHZBU/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52309C32786
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 06:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717396633;
	bh=r+ScYlwDpVsm4Opul/nINoPjqHOfc5m6DtAEqUh7eNY=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=JSHZBU/4s5ofoo+MvNOqg25gYfuklZtREN5RNG2o+N2QfYA3Idyr7xrESSWGs6rux
	 RWhjCuwlwJ36YN5pMxK9JkAzU8/OqDMVvWiZbQG/bOp8JorIfXeUq0PmccHgXe9AbB
	 Io+FyNCQoCW4pBMon9r0FaiyDPFvcCisrJE1sEnHbBuhL2jKyINpyJwByURrxlkjso
	 5sYkYNkhqOVn8ptuanu0AEXOarRD1NxQaG5O6DgfMAakVWH6Gs40jAGZJ3BuOJ3bqL
	 cMHCcDn9jnpSlUeEhALy6ABzITmqN7iCMQ27hqXypiFzXHhZelCjN/2snnB1EXWJWT
	 zyn0/0b6Bsplg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso55333081fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jun 2024 23:37:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOtxVNrSbN5lr5lpTa77tc4OXwlsdaqHNbEqEMkbjbskKCwjnNrmazSBsOM1dI2MmQmJqqAvHVQmQuRVq/H4l1bMw5lw88CPWUak0QAdE=
X-Gm-Message-State: AOJu0YwYN5r8McKSaiYHkhc+xHcN5zoJuZWGzHTilPwaw+l2QIdfT+hF
	kHn4wlzKAAtx/DmjC96s2FBtns15QCsrQ6UZ3m4kQMvD8nh4RmXZRqsSW7P6DsUGZGUvywzAsaU
	gYPxoTaeCiHRlElFpKZorOs/8vW4=
X-Google-Smtp-Source: AGHT+IGQktrXSWjXahA6IMRVEaRDRIzaUgn7zNH0yLGjsW1RvBo2Y6UxQG6+MyhUmfxmziIrRVT1cPbGmsCuPGCMs4A=
X-Received: by 2002:a2e:9256:0:b0:2e4:a21a:bf7d with SMTP id
 38308e7fff4ca-2ea9513c80cmr66794561fa.21.1717396631687; Sun, 02 Jun 2024
 23:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfTr+pXU_=ORh2w3GE+YiU9igh61uWZS-zdG1GyKFb5Qs6fTg@mail.gmail.com>
In-Reply-To: <CALfTr+pXU_=ORh2w3GE+YiU9igh61uWZS-zdG1GyKFb5Qs6fTg@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 3 Jun 2024 14:36:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v67-9Gyxwpy8w9X=Gz7wXuVO0DncwXoRPV6_zrpF7MdEsg@mail.gmail.com>
Message-ID: <CAGb2v67-9Gyxwpy8w9X=Gz7wXuVO0DncwXoRPV6_zrpF7MdEsg@mail.gmail.com>
Subject: Re: S1G and 6GHz channels in Estonia (and EU)
To: =?UTF-8?B?VGFhdmkgRW9tw6Rl?= <taavieomae@gmail.com>
Cc: wireless-regdb@lists.infradead.org, 
	linux-wireless <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@codeaurora.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Adding linux-wireless ML, Kalle and Johannes)

On Mon, Jun 3, 2024 at 1:13=E2=80=AFAM Taavi Eom=C3=A4e <taavieomae@gmail.c=
om> wrote:
>
> Hi!
>
> I have a few questions about the current regdb values for Estonia/EE and =
EU:
>
> 1) There are no allowed S1G/HaLow/802.11ah EE (or EU) bands:
>
> Based on resources online and Estonian law
> (https://www.riigiteataja.ee/akt/117052024018?leiaKehtiv - Extra 6)
> these two additions should be correct:
>
> + (863 - 868 @ 1), (25 mW)
> + (915.8 - 919.4 @ 1), (25 mW)
>
> (Note: I don't see a way to define duty-cycle limitations, but that
> should be okay?)

I'm not sure if there are plans to support S1G in Linux. If not then
the information would go unused and untested. If it is supported, then
patches are more than welcome.

> 2) There's seems to be a missing 160MHz channel (50):
>
> This combines the restrictions of the two existing defined bands it
> overlaps with (https://ttja.ee/eraklient/side-ja-meediateenused/raadiosid=
e/wifi-seadmete-kasutus):
>
> + (5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=3DETSI

The AUTO-BW flag lets the kernel know that it can combine neighboring
rules for wider bandwidth at the lowest power limit within the rules.

Thus merging the rules is not needed. Indeed we would prefer rules not
be merged, as the database should convey information closest to the
regulations.

> 3) The 6GHz band should also have an outdoor limit and probably also
> allow 320MHz channels (at least in EE):
>
> - (5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=3DETSI
> + (5945 - 6425 @ 320), (25 mW), wmmrule=3DETSI
> + (5945 - 6425 @ 320), (200 mW), NO-OUTDOOR, wmmrule=3DETSI

The kernel currently can't deal with duplicate rules for the same
channel. Thus we have to make a decision on whether to have a rule
with higher power but indoor use only, or the opposite.

Within our database, we have the former for some jurisdictions
and the latter for others. It really depends on the submitter.

> Would a patch for these be accepted? Should I update all EU countries
> (considering it seems harmonized within the EU)?

I would expect patches to be per country referencing local regulations,
not just the EU one. IIUC the EU sets one harmonized regulation but then
it's up to each member country to implement / incorporate them?

Whether you would like to update other EU countries is up to you.


Thanks
ChenYu

