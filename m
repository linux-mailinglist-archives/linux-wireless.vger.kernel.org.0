Return-Path: <linux-wireless+bounces-19095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25A3A393DF
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 08:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2D43A6EE4
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2025 07:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85961B87CF;
	Tue, 18 Feb 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VATh4IjY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1CD1ADC81
	for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864435; cv=none; b=WvpZ1mLqmYjc7CFu+xqo6d0UbWFBVBgJQqWU0I4l5yc5kZ8BzXoIIXMPip/KFqM/GokNy+k3zlgVgGCMpgpNSyViJjXw5/y691P7oni1k8djHb4OXjymWti2cTg4J20yqlgxZ5cPb+/5L90DFWqtB6f/9JWttdQBMgtnWtV/DFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864435; c=relaxed/simple;
	bh=Zbq+iFyGrqY1DGMya38wMUj5eUk2k7cBqw92Q1rUOgk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lFGfG9zPKg/Y14OdVRAymCHEfUkj0eHTxADO8G1mN4OuLwJVyREm1Q4YJJzQrn8xiS5SOBuwSzs3gBAee9yTat9SH3zcIqEPU5GfzwP7SQDdVdHEaV8VLnYqG81swOavIOVwg01gwOSu7hkEWc4S8BlZfNf/NI/aSHstldZeq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VATh4IjY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Zbq+iFyGrqY1DGMya38wMUj5eUk2k7cBqw92Q1rUOgk=;
	t=1739864434; x=1741074034; b=VATh4IjYUuVM4vyUiFbEIXs9euEDRKQeLnAOR2dnGHPYwHe
	PkqQ/FIEXSrAUM0l0eDgvBvB/XOC4xtzBt5h03GuUMXRj2EELsj3e+cUGqoa7VnhW/1b5kXvUywBe
	2u9hM0dNdRik5cgTfJ4VVxbP18Mi8ofCv4MdlDrJNaJxG4rhus3EU8AMD4Vp2WMIK2XpLSN1VtZIy
	X/WoOtbOJXWYOmNCQHE1+lFxZlNiCbMUebGTOai79uIGh2B1TqRXX7nG3XcuFU62ZSzAGlP7UIeJE
	PvGpC1wGmIQEZm3ZOZP8FQmOGTZblXZoitYTTh1aUveta0s6AV7un6aUEmzvZeHA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tkIDS-00000001Gs7-3jtM;
	Tue, 18 Feb 2025 08:40:27 +0100
Message-ID: <5e433cd8d070682cb6ed31de3a2dd337e6f48b50.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Iran (IR)
 on both 2.4 and 5Ghz for 2019
From: Johannes Berg <johannes@sipsolutions.net>
To: wens@kernel.org, Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	mobin@mobintestserver.ir
Date: Tue, 18 Feb 2025 08:40:23 +0100
In-Reply-To: <CAGb2v66Qev8nQvt54dKDC+Q+rJ5m6+erWO2L4_vSMVqrTe_DRQ@mail.gmail.com>
References: <20250218025957.13818-1-pkshih@gmail.com>
	 <CAGb2v66Qev8nQvt54dKDC+Q+rJ5m6+erWO2L4_vSMVqrTe_DRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-02-18 at 13:29 +0800, Chen-Yu Tsai wrote:
> There are NO-INDOOR and NO-OUTDOOR flags for the database. The kernel
> doesn't have a matching IEEE80211_CHAN_OUTDOOR_ONLY flag though.
> Maybe that should be added?
>=20
> Johannes, what do you think?

Good question. I guess we could have it, though I'm not sure we'd have
any mechanics to actually _use_ such a thing right now? Something, say
hostapd (?) would have to promise it's actually outdoors?

More information doesn't hurt and I don't mind adding it at all, but I
do think we'd probably not be able to use it at this time.

Or we could add it to the db.txt file but ignore it in parsing now and
skip the band for the binary for now?

The thing is I don't think we have a good way to say "older kernel skips
this range" - or perhaps we set the NO_IR flag so older kernel cannot
use it but then allow OUTDOOR_ONLY to override that given some
conditions?

johannes

