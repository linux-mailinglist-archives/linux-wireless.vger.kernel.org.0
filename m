Return-Path: <linux-wireless+bounces-16427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C79F3A56
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 20:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0480D7A0342
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 19:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1020CCCE;
	Mon, 16 Dec 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnuoTe0B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859320C481;
	Mon, 16 Dec 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378876; cv=none; b=piGEPXQGjyEnAQ2c+fl7pD2fzE3xGyD47lJBW5BbLtP5iqOoKm3WXyV6+fsOxMFXZNEDsSwxYVcIcc7y22dvpnCsfzaHKQZ7eRqYQP2Wqhd9OQ9a03W9CnExhADWge5syoZBwMi2cLBwm5RbDYIr2qMluH1S2Wi+n5Opem2KdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378876; c=relaxed/simple;
	bh=0VFiKC4boAv/+7uBTzQJqCRPDrjkoWJN1WOJILavTrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps7nx98PX8qIKGck0i/IiJM2Z77z6alztxDKEkz6a6aztPC2UEzQ4lgxLHW2K5CsqtXRuayIQRO0BMqp7wTqw5t6/NBZz2LdC3/Vhhg8zJjZwBUtuPkZODBeTy8vIlttzSmG20bTpldTnTBWdmWerrsmhc2J8fgKcnxOB9MxF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnuoTe0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509C8C4CED0;
	Mon, 16 Dec 2024 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734378876;
	bh=0VFiKC4boAv/+7uBTzQJqCRPDrjkoWJN1WOJILavTrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SnuoTe0Bx/1XdHewh5DSy+c7JLqOzvJYtcQwJVIdvG0VDWQz0HXA1G8NH+2GXNtrK
	 SpgWkYblqLtUxSw5MmO3xBsSYGqNrBQgNMGEBWkdAI53VGyioAEVwLwvCMoCZIh8Dl
	 qItmc59oNA63J9nynR5SO6qinuF8kbbvmKWA2Avyjz2PABnXz02HTgwdrzCXADzat5
	 dPTjeXvvj/gGy7UWe4LdE2WvtXygSrqCagVpUmBOfALRSnmgUwi+dHmq9I2ppU8DP9
	 JZJKpNQhyd6wLFA3KE0SDZVyFFLwEGDf52A1TCk2ds4k4Y0rIMq4jRwb3r2w9JJIXB
	 xEr8JcrzHhzKQ==
Date: Mon, 16 Dec 2024 19:54:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: net: wireless: Describe ath12k PCI
 module with WSI
Message-ID: <20241216-croak-outwit-207ea8d3025d@spud>
References: <20241209153034.50558-1-kvalo@kernel.org>
 <20241209153034.50558-2-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aXgPcGwIaTEPwO1U"
Content-Disposition: inline
In-Reply-To: <20241209153034.50558-2-kvalo@kernel.org>


--aXgPcGwIaTEPwO1U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 05:30:27PM +0200, Kalle Valo wrote:
> From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>=20
> The QCN9274 WiFi device supports WSI (WLAN Serial Interface). WSI is used
> to exchange specific control information across radios using a doorbell
> mechanism. This WSI connection is essential for exchanging control
> information among these devices. The WSI interface in the QCN9274 includes
> TX and RX ports, which are used to connect multiple WSI-supported devices
> together, forming a WSI group.
>=20
> Describe QCN9274 PCI wifi device with WSI interface.
>=20
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  .../net/wireless/qcom,ath12k-wsi.yaml         | 205 ++++++++++++++++++
>  1 file changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,a=
th12k-wsi.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-w=
si.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.ya=
ml
> new file mode 100644
> index 000000000000..7fec15e10a94
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml

Usually I'd comment on the mismatch between this and the compatible, but
naming the file after the pcie id would do noone any favours. This seems
fine to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--aXgPcGwIaTEPwO1U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2CFeAAKCRB4tDGHoIJi
0jdbAQCrxn0AOA9faLcR0u5ERNVSe3bZPX9blHiLEHsON0gQgAD/U+OuTurH5kBz
mkIDbiIEEpc/WqcExwcWJPxcwfJuPAo=
=hKTb
-----END PGP SIGNATURE-----

--aXgPcGwIaTEPwO1U--

