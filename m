Return-Path: <linux-wireless+bounces-27846-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CECBC0885
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 09:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 066E74EECF2
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 07:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC42561AB;
	Tue,  7 Oct 2025 07:57:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0913B7A8;
	Tue,  7 Oct 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759823836; cv=none; b=c6Qea7NbShmETyW1CK+5MTBKynVbnM9su/r1wd4WcnSVYpAdKLxlPwyuOeuuPp28XMOxuUZiszob1Iit2TQkA3JoBeR/F19CnFzKVoAEbL2Ihff4rtPtiwDTq6htVDh3M5X+l7W61kHvw/GNkeAfHj/hLjpaavBSwZqqlrr5EM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759823836; c=relaxed/simple;
	bh=eueMaZ1ri+Vb2tspf/000Tqi4rwNtAegiV17jxC05rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bqfjh/fZv3iNiKqZzvV6fBdLDO1Moe13CR5h+sN1y0eg7d1xd5x3DvwH8oCdINF4lg6Xg0K/OMQNPUWwiaBUIkYLtk2G11/vKoubWn8qAdl/jwjKv/ZpSvZHCvVn1z8IzSvdG49Tk/4XEJ/Atf0GttSZPwO8vVNQv01P489pVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from ripper.localnet (p200300c597021AE00000000000000C00.dip0.t-ipconnect.de [IPv6:2003:c5:9702:1ae0::c00])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 0692EFA12C;
	Tue,  7 Oct 2025 09:57:03 +0200 (CEST)
From: Sven Eckelmann <se@simonwunderlich.de>
To: Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org
Subject:
 Re: [PATCH mt76 v2 1/3] dt-bindings: net: wireless: mt76: Document
 power-limits country property
Date: Tue, 07 Oct 2025 09:56:58 +0200
Message-ID: <1839711.VLH7GnMWUR@ripper>
In-Reply-To: <1697b64e2b64682dbf83186f17f42c50ecf88fa8.camel@sipsolutions.net>
References:
 <20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
 <20251006204529.GA549972-robh@kernel.org>
 <1697b64e2b64682dbf83186f17f42c50ecf88fa8.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8631237.NyiUUSuA9g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart8631237.NyiUUSuA9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <se@simonwunderlich.de>
Date: Tue, 07 Oct 2025 09:56:58 +0200
Message-ID: <1839711.VLH7GnMWUR@ripper>
MIME-Version: 1.0

On Monday, 6 October 2025 22:48:15 CEST Johannes Berg wrote:
> On Mon, 2025-10-06 at 15:45 -0500, Rob Herring wrote:
> > 
> > > +          country:
> > > +            $ref: /schemas/types.yaml#/definitions/string
> > > +            description:
> > > +              ISO 3166-1 alpha-2 country code for power limits
> > 
> > This would be constrained to something like this?:
> > 
> > pattern: '^[A-Z]{2}$'
> 
> There's a "00" special case for "world roaming", so maybe that would
> have to be '^([A-Z]{2}|00)$'? Not sure you'd ever want to specify that
> though. We also use '99' internally for even more special cases, but I'm
> pretty sure that shouldn't be specified externally.

Good point. I would say that 00 is already handled by the "fallback" limit 
code. If it finds neither a country nor a regdomain, it just marks this entry 
as "fallback".

Regards,
	Sven
--nextPart8631237.NyiUUSuA9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCaOTHygAKCRBND3cr0xT1
ywhZAP4s8bEDQwSmJy8BeB8DNxkjVbJ4TMzkk1jlnOud1CgbZQEAsezHw+N0eJXn
R256VuIFrw6VaIWcPQe0BI7De6ceaAM=
=jlgT
-----END PGP SIGNATURE-----

--nextPart8631237.NyiUUSuA9g--




