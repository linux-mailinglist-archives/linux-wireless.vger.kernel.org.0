Return-Path: <linux-wireless+bounces-16428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19579F3A59
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 20:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB401653E8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723EB20CCD0;
	Mon, 16 Dec 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFO8e9lS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468A9205AA8;
	Mon, 16 Dec 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379013; cv=none; b=gI2eiwt+CJZkcicSFPAcrpLwdZhu74c+F5K8tYiK/y2T9c1zhXN0up9rF488U5DoLnAhqDCs9Ar930Kye8k22N1nOMQE7qMytRAQxl9QJREjqI25nmmwPzxF5xTu28F8EGb8jUP4/qXMynHihHbDLfMYkpWfilECFFtPtcbaZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379013; c=relaxed/simple;
	bh=mfQ+UvS9zCNDDMgy2pSAaJ5A6FtaL/xqQkyF0asjCys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSE7j3K9mG4XlS+13N6q3fq6BTZ/A+Jus79qUDvwyt+sINvP8u5N1NWIGVaxEf/YNkthX2rkjqo+2O3qtRX1aSi/C0Xq+aSowEjkXDUSvLxYPiswkEm8vK+4TfelsjiT2zSfU9P9a5nXzpcVtVFTrny8q7Mifa51zZ6YilVadv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFO8e9lS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14CCC4CED0;
	Mon, 16 Dec 2024 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379013;
	bh=mfQ+UvS9zCNDDMgy2pSAaJ5A6FtaL/xqQkyF0asjCys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFO8e9lS7ftXOKI+ufABMtvFzYaO48rUzAhicggP7Toly8vWQD+u0j0TTVIBW338P
	 EBgSeyHWzW5KfeBpf1SQXrwqNKtbbQxkCd3tdM2x69ue5JP50DiDlox99vEIteHyjJ
	 rSrjnt+1OfCaJYARZi1mnmG8Kosr65ovqzGkk5pZQCHfPJbV66kv2BmZxLQqIkqUoZ
	 lLMuJ+4JV6nia/MP4/gaAwdiQqLU0xLmfeoddi8kS5QjsRcZpIT+AJ741qpfKV3Gg6
	 6Ygror5DsnhIkuwgZVrgtPwO5wX+35nIe1pJfRGOIFHExja3I/dcY/cSPmOO0yFfkH
	 dyLP1DOolb7xw==
Date: Mon, 16 Dec 2024 19:56:49 +0000
From: Conor Dooley <conor@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] wifi: ath12k: MLO support part 7
Message-ID: <20241216-moonlight-perpetual-d49029337c17@spud>
References: <20241211153432.775335-1-kvalo@kernel.org>
 <173436785894.3413746.14923997859754791913.b4-ty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4t8WLMfWCtEr09Pn"
Content-Disposition: inline
In-Reply-To: <173436785894.3413746.14923997859754791913.b4-ty@oss.qualcomm.com>


--4t8WLMfWCtEr09Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 08:50:58AM -0800, Jeff Johnson wrote:
>=20
> On Wed, 11 Dec 2024 17:34:24 +0200, Kalle Valo wrote:
> > Implementing Multi-Link Operation (MLO) continues. Bindings document is=
 added
> > to get WSI information from DT (patch 1) with the code parsing the info=
rmation
> > (patch 2). Rest of the patches are about configuring MLO in firmware.
> >=20
> > Device Tree bindings were reviewed as RFC earlier:
> >=20
> > [RFC PATCH v3 1/5] dt-bindings: net: wireless: Describe ath12k PCI modu=
le with WSI
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/8] dt-bindings: net: wireless: Describe ath12k PCI module with WSI
>       commit: 30e36fa89d8266d9221ee992d4f43553a59a3431

Delayed through being unexpectedly afk last week, I left an r-b on v2 a
few mins ago. I don't give a shit about getting credit for tags, but
figured it was worth mentioning it on the applied version of the series.

--4t8WLMfWCtEr09Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2CGAQAKCRB4tDGHoIJi
0vsYAQDkoxDUoc1/fj7CS11vgTGaiWCoFhMoPF5TgURTVSzXsgEA0A9T++taG4dc
SpaXgaEwIquY2rZrISfeuuUmHJ4RoQw=
=wprf
-----END PGP SIGNATURE-----

--4t8WLMfWCtEr09Pn--

