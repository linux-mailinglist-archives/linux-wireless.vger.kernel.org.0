Return-Path: <linux-wireless+bounces-4184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5B686ADD7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 12:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B75293A5D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B912F589;
	Wed, 28 Feb 2024 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MTsccQI2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DA135A6A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120219; cv=none; b=gOGNuY42BWtXD38dpVU7uhaNfa65LoxbO4AGltZKmoAZfWuuAkrOSXiXGUca7ijKqSO8l13y8qd+9LsKxaUXaBSasBvqShIDvdfaoVTjes0W6KmdtCwXnKaVT05Sh4iINoyFR/la1qOi2Z3BVJMm6h0d+JgJyCjQrGtqheyhVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120219; c=relaxed/simple;
	bh=dT3n0J/Pztktpo0iHV52qSgwS+Fw1jsRuLGf/KWHjHo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gHZn90OSQ3Hz9B39WfuswTbyt5PmzmukmZRGENuuZgnVCBV45+Adlfb5dSlISLWV/J34163UMB8IhNF/Tg3C9GEH0huAUVOs3gUHs/G17xryd+7HhJi7377etGPV9j2iwfLmgFIPs1yMxZn9b6L0LLKdVjRi2XE8D6Oh+681EbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MTsccQI2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dT3n0J/Pztktpo0iHV52qSgwS+Fw1jsRuLGf/KWHjHo=;
	t=1709120217; x=1710329817; b=MTsccQI2AI8VlqpOk7Xdi/g1gmdhx4sTqcKtqjD2Urnh5TB
	N2N9CYJ03I4oxVem1qO0BmaO+0J3xjOGRN8Wc0b+IYTwqv5l54Z87GSrd5v0PUXM1/iQh+YXVnOD5
	FG3rc0d9TQXyPPuC4DIThGb7wC49F5n7mKF6P7mN0IOzZSQ6f/GZkUOsC2lhyq6jSAaYwxr3CEz1k
	PtPQl9CbkcQW3wr1k3rv4y44g1xN7HA85+MRwTrdB3oIl8SHuEHt1T3CWyg9QslmYq6gSgD7CXB0+
	q+tut2Xj9pgWgEPZfl7VnGMdg0C4kN+fgfDhxvUBQ0HOkwEId6LKAEl6Wbzlvliw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfIF4-0000000C6gU-3gUA;
	Wed, 28 Feb 2024 12:36:55 +0100
Message-ID: <58ba855b78507a949244034262ba806bb6dfd0a1.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: rsi: fix endian conversions
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Siva Rebbagondla <siva8118@gmail.com>
Date: Wed, 28 Feb 2024 12:36:53 +0100
In-Reply-To: <170912015833.3742961.13610436136127981895.kvalo@kernel.org>
References: 
	<20240223115214.682fb94159fa.I576bbf9fe7ca2948dbe3e00c0fa0f37594e85046@changeid>
	 <170912015833.3742961.13610436136127981895.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-02-28 at 11:36 +0000, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> wrote:
>=20
> > From: Johannes Berg <johannes.berg@intel.com>
> >=20
> > This really seems like a bug, endian conversions now happen
> > twice in this code.
> >=20
> > Note also that prior to the commit mentioned below, the code
> > was putting 16-bit values 0xBBAA as bytes "AA BB 00 00", and
> > the commit mentions making it work for 32-bit values and
> > makes no mention of fixing endian conversion; however, after
> > it, the bytes for 0xBBAA would now be "00 00 BB AA" on big
> > endian platforms.
> >=20
> > Remove one conversion to make sparse no longer warn.
> >=20
> > Not sure anyone can, has, or ever will use this on big endian
> > platforms though.
> >=20
> > Fixes: 0a60014b76f5 ("rsi: miscallaneous changes for 9116 and common")
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>=20
> Fails to apply, I guess because I had a patch for this warning earlier.
>=20

You did pretty much the same thing anyway, no need to do anything else.

johannes

