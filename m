Return-Path: <linux-wireless+bounces-19603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E7BA4A0B7
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C9B18854D0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842AD26B0A1;
	Fri, 28 Feb 2025 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fk9sbzBJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D154E192D7E
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764686; cv=none; b=ca8I+JglY7m7N5XQZpnLHQKCAkjPe7LSP3obHZdSHshZduM6TSVHZH3FOd1a4l2CFGxnD3JqJlSfbLROhGMxgAWbiGXXRBXuSjjZs6C46RZFzm9/cQcpvITIXJ49V8pZ1Cv++xxwCL58+4C8RgWAV56G6Cfyb1Z+Kd0aEo5ml9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764686; c=relaxed/simple;
	bh=ZRCj/8TAJAuJJJ0i17Nh93VZ/UIjIMRuizn2fdB09cA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATvvpWcPNEBUrc4l0Xeuj/eh5x2S7IDbotXWyOjGAecXzS//1k4nexlt9CcJee850NrXjn0/22QrAtTERmqeQlbHLS47yQO+SbifK0Tg4APwyL3kPR+wlpH8lrkc4X2CGR0NlcXwxLzY21PKTt3NR3ScGehmxa5ngBG9DX7fADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=fk9sbzBJ; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740764682; x=1741023882;
	bh=ZRCj/8TAJAuJJJ0i17Nh93VZ/UIjIMRuizn2fdB09cA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fk9sbzBJMBVZrv7z3GCpRvHpsWTvPCNjq+XIfPVndaeg1kWMHvmDQL3CYq+tX3i0q
	 T9tHtYfm1uvQqnoHlWSPR5XNRIIgppZI+KXKCblrafxV+OmOSGTT1Ufo/pWAtwj1VT
	 I7S6DnOkDMieOkOxQTMGa0sFEp05wlJqyg1PWl/N5MX2SRPPFMP36zvlMauBKWKQc0
	 15yXL3S/xqbl1bR++2sc8rhrqKkaRdi0h0JI7Jp2bJst58tF8Z/bZsUwNM1/Pkv8Qx
	 MfsW4p+rDi8F/jhkO13BcMiabRZsjTkQuYw2VtI+G7Rw/4B9fR8WIJmUU5clFIfD/b
	 RJNf6S4oJQnDg==
Date: Fri, 28 Feb 2025 17:44:38 +0000
To: Peter Seiderer <ps.report@gmx.net>
From: fossben@pm.me
Cc: Christian Heusel <christian@heusel.eu>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, regressions@lists.linux.dev, linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED][STABLE] MT7925 wifi throughput halved with 6.13.2
Message-ID: <JZIl1iVcv9U3s8KnXJqR-ZKFBUzbVvbqR3NN0LO4as5_yXxPPS4yIfzGK22Z6rNZOyOysBzWPZGQgL-8eychueJtr7TvC3A0I-s3CVHHDUo=@pm.me>
In-Reply-To: <20250228161420.11ac4696@gmx.net>
References: <b994a256-ee2f-4831-ad61-288ae7bc864b@heusel.eu> <20250228161420.11ac4696@gmx.net>
Feedback-ID: 134317997:user:proton
X-Pm-Message-ID: a944d88e39b523d475fe769a680d961766ce4442
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello all!

Christian provided me with a linux-mainline-6.14rc4-1-x86_64 package to tes=
t with today and I am still experiencing the issue, so I am assuming that r=
evert did not happen yet.

To give some additional context for the performance regression, I have an A=
T&T 500/500 fiber line. As of this morning on kernel 6.13.1, I get 550 down=
 / 470 up over Wifi 6 on speedtest.net. Testing immediately afterwards with=
 Christian's mainline package, I got a result of 170 down / 75 up, which is=
 similar to the results that I got for all the other bisection kernels Chri=
stian gave me to test.

Thanks!
Ben


On Friday, February 28th, 2025 at 9:14 AM, Peter Seiderer <ps.report@gmx.ne=
t> wrote:

>=20
>=20
> Hello Christian,
>=20
> On Fri, 28 Feb 2025 11:19:52 +0100, Christian Heusel christian@heusel.eu =
wrote:
>=20
> > Hello everyone,
> >=20
> > on the Arch Linux Bugtracker1 Benjamin (also added in CC) reported
> > that his MT7925 wifi card has halved it's throughput when updating from
> > the v6.13.1 to the v6.13.2 stable kernel. The problem is still present
> > in the 6.13.5 stable kernel.
> >=20
> > We have bisected this issue together and found the backporting of the
> > following commit responsible for this issue:
> >=20
> > 4cf9f08632c0 ("wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for=
 MLO")
>=20
>=20
> Seems there is already a suggested revert of the mentioned commit, see
>=20
> [PATCH v4 1/6] Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_=
ba for MLO"
> https://lore.kernel.org/linux-wireless/20250226025647.102904-1-sean.wang@=
kernel.org/#r
>=20
> Regards,
> Peter
>=20
> > We unfortunately didn't have a chance to test the mainline releases as
> > the reporter uses the (out of tree) nvidia modules that were not
> > compatible with mainline release at the time of testing. We will soon
> > test against Mainline aswell.
> >=20
> > I have attached dmesg outputs of a good and a bad boot aswell as his
> > other hardware specs and will be available to debug this further.
> >=20
> > Cheers,
> > Christian

