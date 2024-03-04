Return-Path: <linux-wireless+bounces-4353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853CB870B58
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 21:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B757B1C21D9F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 20:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201867A14B;
	Mon,  4 Mar 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX8BTR4D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1257BAE3;
	Mon,  4 Mar 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583443; cv=none; b=Jpr5j9yobvmWg/cMxJnSym8M31dMO6wpSU8rW/Y1M/OrhdnNO6Lxqjl3b3eH7g1bFiAOf59c7mB+A0YEAUDuaa+FozojVqpmmOMeka+H8K38Mqj8lv5XRUDHGJfLTfDyb883b9rkzT87Wtq7CC/8Jthu2NGishFzfGEmThz8LRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583443; c=relaxed/simple;
	bh=fdQuLhIT4gZ28jBk89LIuL/6A6yLLiL4IFmPPmPPgy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fACqBh8z75BB5RUzSrebLYl3CjUmkp3bdnmR6q++qoO984Rk8OopARdKHfYVtG3YlsmUhvYumOR2cMFbRtb/zZD4Dly0Awg3SQ0d17KI+YKJBPa/G4IsjfyCLar5ylcuV87SK7aJXCYjfJzcudbEu08Ywon2D1Cc1/wOgnE7qnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX8BTR4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EBCC43142;
	Mon,  4 Mar 2024 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709583442;
	bh=fdQuLhIT4gZ28jBk89LIuL/6A6yLLiL4IFmPPmPPgy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BX8BTR4DTDsIT9JEqzQ3a8nVPh9qHEAtk9n88T6ONvZp2rL3oR3SP+bZfgZ+wXC5J
	 AJX9ROfocBSqp1GQHXXjVq017arP5uRHkI9eQbouzmUWzms+0qVWEGhJbJgmca3n7S
	 Hgls2ricKb7Dk2B/GsREoeW9vuNJ30xUY6kUQR5FrVErvuHSqO6Of60nFAVZP8fL8t
	 C6tOLtGPXrPgogYREoW+2ACsXRRpKfKuITRe2my24xAs2lihTXGf1ciaeGTgYHtr5H
	 qBaPxPh5cuKimX2xb5gcFAlBFrmiWHxAWK7yJuwTdyMRfAH4yqG9p1Sd3UjexfOtM3
	 PKNietLUb60bQ==
Date: Mon, 4 Mar 2024 20:17:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k <ath10k@lists.infradead.org>,
	wireless <linux-wireless@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	Jami Kettunen <jamipkettunen@gmail.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Message-ID: <20240304-privacy-registrar-93c48ab1b9c5@spud>
References: <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
 <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
 <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
 <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr>
 <20240304-component-animator-e2ee0ab7574a@spud>
 <CAA8EJpq5HQaO2E2Pd7yqUTsWyQ_pLDdyoWng8QmWTzYn5fv3PQ@mail.gmail.com>
 <20240304-superior-vicinity-3dc6ca88141a@spud>
 <CAA8EJprMG=fY-G-X03bm7MMhcua9axjw5ULZz0efgHxwzgrdVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j2/bmFVB0jn7K/1X"
Content-Disposition: inline
In-Reply-To: <CAA8EJprMG=fY-G-X03bm7MMhcua9axjw5ULZz0efgHxwzgrdVg@mail.gmail.com>


--j2/bmFVB0jn7K/1X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:59:13PM +0200, Dmitry Baryshkov wrote:
> On Mon, 4 Mar 2024 at 21:46, Conor Dooley <conor@kernel.org> wrote:
> > On Mon, Mar 04, 2024 at 09:37:00PM +0200, Dmitry Baryshkov wrote:
> > > On Mon, 4 Mar 2024 at 21:34, Conor Dooley <conor@kernel.org> wrote:
> > > > On Mon, Mar 04, 2024 at 05:21:37PM +0100, Marc Gonzalez wrote:

> > > > > Thus, anyone porting an msm8998 board to mainline would automatic=
ally
> > > > > get the work-around, without having to hunt down the feature bit,
> > > > > and tweak the FW files.
> > > >
> > > > How come the root node comes into this, don't you have a soc-specif=
ic
> > > > compatible for the integration on this SoC?
> > >
> > > No. Ath10k uses WiFi SoC as an SoC designator rather than the main So=
C.
> >
> > Suitability of either fix aside, can you explain this to me? Is the "Wi=
Fi
> > SoC" accessible from the "main SoC" at a regular MMIO address? The
> > "ath10k" compatible says it is SDIO-based & the other two compatibles
> > seem to be MMIO.
>=20
> Yes, this is correct. MSM8996 uses PCI to access WiFi chip, MSM8998 uses =
MMIO.

Thanks.

A SoC-specific compatible sounds like it would be suitable in that case
then, to deal with integration quirks for that specific SoC? I usually
leave the ins and outs of these qcom SoCs to Krzysztof, but I can't help
but wanna know what the justification is here for not using one.

--j2/bmFVB0jn7K/1X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYsTQAKCRB4tDGHoIJi
0iDsAQD8SiNyQlk9LJ1lpYenpBT32QnTIsXZ1iSWp5Vcc3GxugEAsv/DhNE2Uf80
4McH9vMHXRTxAwf9McX9vAtmpyNc1QM=
=c99j
-----END PGP SIGNATURE-----

--j2/bmFVB0jn7K/1X--

