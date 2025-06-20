Return-Path: <linux-wireless+bounces-24281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C5AE16CA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 10:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67B97A323F
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60A262FF0;
	Fri, 20 Jun 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="kmlBszZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02942594BD;
	Fri, 20 Jun 2025 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409760; cv=none; b=DkmanP7U2+T6mTxITy4Sh6vGUWfjAKCVAPvBNPi7RvzOejy4uoY3xzPtoFum9dOXV1LTTAhQV8E9Yp5n3QTfW0XxfihfUi1Wcr6YGC36iLL/sgXTD/Oib4DZ2R8iniQ2O68AxaxTWMUCmjFti4GsEEwSXj0nNWoSJRHiUPcL7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409760; c=relaxed/simple;
	bh=mTuYhO+8RYrHvkIFsdv7f3E34qKo7UjC2oN1lSvcei4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gv29deHNAE7JKbBnfF0mWl2ov3BZOBSDz+tb3JGzBP/4fnn7jMY+vUCm4tWdJWEff9uceJJwpW6X7ruj2517ufRoV0FoY9gdyeYpZn0J9un7BKqk2/wAcRyaTh0UHeD2bUGkCu4Lz95b2mgNGH8rFAzsVeFTlAjBsBwg2PgvLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=kmlBszZP; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1750409410; bh=mTuYhO+8RYrHvkIFsdv7f3E34qKo7UjC2oN1lSvcei4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kmlBszZPJ0o9V5Gu5t531smG/U2NhuVXp2DOw4P4UoCzukGlFTZGbpAvDGGD79BKp
	 9Smdaj+H5cJAHLgnOG9x1aYqn/OkdEXaNqbRSTMn/H+2kAX30uW41GmkkGgGfIpPXJ
	 hixfOE8eWzbyq/X+xzCwLtUiNOe1x/FP4JGChL4lcNmfG88WCabTXMelyU5ieIILPq
	 CACG6hU0Qtz3T6mVnzRgyENzHDI5yIK7rff5xlp6LzaD5vIqv1MQiKWUXj6/+d+3v5
	 ha7faJSnHHVaf3fNTY17gUBuMwoK4NWt0ZUnjlqRwBWxkbTdQCOOoI9aIFJKwzKnue
	 iViuNtYwZvRpQ==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, Johannes Berg <johannes@sipsolutions.net>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCHv5 0/5] wifi: ath9k: add ahb OF support
In-Reply-To: <20250609030851.17739-1-rosenp@gmail.com>
References: <20250609030851.17739-1-rosenp@gmail.com>
Date: Fri, 20 Jun 2025 10:50:10 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87bjqiztj1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> First two commits are small cleanups to make the changes of the third
> simpler. The fourth actually adds dts definitions to use ahb.
>
> v2: Add documentation, use kernel_ulong_t, and of_device_get_match_data
> v3: Use qcom prefix and wifi suffix as in other ath drivers.
> v4: fix up dts example in Documentation
> v5: move back to using qca prefix. It makes no sense to diverge between
> all the other drivers for MIPS based qualcomm devices. qcom as a prefix
> is used for Quallcomm's ARM(64) stuff.
>
> Rosen Penev (5):
>   wifi: ath9k: ahb: reorder declarations
>   wifi: ath9k: ahb: reorder includes
>   wifi: ath9k: ahb: replace id_table with of
>   dt-bindings: net: wireless: ath9k: add OF bindings
>   mips: dts: qca: add wmac support
>
>  .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++-
>  arch/mips/boot/dts/qca/ar9132.dtsi            |  9 +++
>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  4 ++
>  arch/mips/boot/dts/qca/ar9331.dtsi            |  9 +++
>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 ++
>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  4 ++
>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 ++
>  .../qca/ar9331_openembed_som9331_board.dts    |  4 ++
>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  4 ++
>  drivers/net/wireless/ath/ath9k/ahb.c          | 60 +++++++------------
>  10 files changed, 84 insertions(+), 41 deletions(-)
>
> --=20
> 2.49.0


For the ath9k bits:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

