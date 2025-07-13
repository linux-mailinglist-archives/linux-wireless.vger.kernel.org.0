Return-Path: <linux-wireless+bounces-25337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1395B030C4
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A8A7AE8BB
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Jul 2025 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D922253944;
	Sun, 13 Jul 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="wxodjXPC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC71E3787;
	Sun, 13 Jul 2025 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752404815; cv=none; b=TMzpPzbl1cVZTIMNDom/qSgMwODS5bPuYmZCYopi1AI43KfSiT47+QRHTc3tLabZpj+sY127P0NVljjoQVO/Le1/0kFNzWM6p6Hn32GbivHOEBfOOxD/Rhrj7lOmFSbCyCbM+3CrGKJxwoUYReW/f5Vop6oUFYtjk9UBk+WUhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752404815; c=relaxed/simple;
	bh=e+xummqgYb2Lq6yLMj4NF5pLE9s1eEAYV29V7m0JwKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DfF9WCiHZ2fP/AijNvnbg7vdURqHpNQMBVhwueIZwnB2OxVifQpn+0xbN+ocldauufTQDaO0Ob93RU9BatwWKXxEPZG4ALS2Vz6Di5+rct30X6i0uVIJDEmgsIWfkmVOD5fMrA5KMb3rTLRdaPELnTJSxdTa4Ets8zylCt8L0y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=wxodjXPC; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=e+xummqgYb2Lq6yLMj4NF5pLE9s1eEAYV29V7m0JwKI=;
	t=1752404813; x=1753614413; b=wxodjXPC1YbKy3bI/oUj47xWMP6J38LYWetSykbdotSCQGH
	MK+9VSXSXRMhMntDlTframyCTN6X61sRvSyXTfEFByfbDIcM1IrtX8YQpodqUymt3DROkYsu8bZt7
	SPZm+tuFD6F/AhfEwoWZoBV2DoiidUsXh8mfhr22AMtORFyo2xKmnKwdjfz6yjzJQom1fg5h7oRLR
	I2tYZJhbonj6moBZF03G6EcGc10BGAlWRNjzJFqV3n+d6Ewux2KTWp7dY3rkK4iturT7DGSUpnrwP
	E8zAV/s9e1aZRDgwvbOnCP2c4sJ93xCV4pXeBy7DvmW8geMT7oY6L1D4UdjI1DIw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uauXh-000000020HW-1ovy;
	Sun, 13 Jul 2025 13:06:49 +0200
Message-ID: <1f78de8ee5fde6e3e652148c4f75878573957e50.camel@sipsolutions.net>
Subject: Re: [PATCHv3 wireless-next 3/7] wifi: rt2800soc: allow loading from
 OF
From: Johannes Berg <johannes@sipsolutions.net>
To: Stanislaw Gruszka <stf_xl@wp.pl>, Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Bogendoerfer	 <tsbogend@alpha.franken.de>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS"	 <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>,  "open list:MIPS"
 <linux-mips@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support"	
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>
Date: Sun, 13 Jul 2025 13:06:48 +0200
In-Reply-To: <36c4cd5f263e4bae22a1779a9befd24dacd5d3bf.camel@sipsolutions.net> (sfid-20250713_105038_510459_ADA2EA39)
References: <20250710200820.262295-1-rosenp@gmail.com>
		 <20250710200820.262295-4-rosenp@gmail.com> <20250712101418.GD9845@wp.pl>
		 <CAKxU2N-RXgFKYPAqEu3iZDMAisj_K-b+ZZTGFsabWz7pMK+02A@mail.gmail.com>
		 <20250713071532.GA18469@wp.pl>
	 <36c4cd5f263e4bae22a1779a9befd24dacd5d3bf.camel@sipsolutions.net>
	 (sfid-20250713_105038_510459_ADA2EA39)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-07-13 at 10:49 +0200, Johannes Berg wrote:
> On Sun, 2025-07-13 at 09:15 +0200, Stanislaw Gruszka wrote:
> >=20
> > Can be done as separate patch since you already
> > posed v4.
>=20
> Maybe I should point out that I've simply been dropping the patches
> unseen because they don't even apply.

Ah, that's because of Felix's fix, so looks it will apply now that I've
fast-forwarded wireless and wireless-next.

I'd prefer a resend though (perhaps with the small thing Stanislaw
thought might be fixed, your call) so the bot can pick it up.

johannes

