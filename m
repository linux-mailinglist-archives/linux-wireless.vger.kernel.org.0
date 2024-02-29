Return-Path: <linux-wireless+bounces-4262-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3C286D27B
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0661F231A9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 18:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037E27E572;
	Thu, 29 Feb 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vg2Fz+I5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C957828D;
	Thu, 29 Feb 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232062; cv=none; b=fzupSgJsIwjUTcc7M0mpfzMrYNl4/fOVUPUYXUc4UBDu40ibUku1MufSMz3bB3oTycGDAvvUwg+s+p1DCSgzr1sIbVqCJvui8iJ1dH2pU1Inboyh/r0bHo79cDMAsvKLT/h+vfABqv1otN0cClMn5LyKsdQDx71zwQynO3gGbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232062; c=relaxed/simple;
	bh=LARb1VnKollaflu2liRF7rfiohyzuPezMY1NfHktn9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNjcP7KcW+YWO7toHKP7BEL2YBxA/PD3cmViRrQnX5Bd9TPAdlulLxa+x/pbOIvBZysOcqmQrpy/VPaC1D/sn3kAAYwTAYjB+Nd8Z6z9bEQ12zjci2ZmN5Clx6LelFZmT1AHLrfdSw80mO0afidXER0tVns5uFH8erKNyydlI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vg2Fz+I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AACC43399;
	Thu, 29 Feb 2024 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709232062;
	bh=LARb1VnKollaflu2liRF7rfiohyzuPezMY1NfHktn9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vg2Fz+I5TerXTTbwh614asxfjIwLDnuMiI//Pf81lDHGE6i0k+kBn81rPpBVMhZWe
	 8KvlrkmG7pARys1jzfNZOL7TT/tRbIrtgoCns+X8gB+C3bdDuejTqop08XdG+w9crs
	 1BrHXWnwxc2404cM2ly43GVEksMY+T2BG8PPeIa21Wl4X6KrOnHWHH/lC3xc3+TMQF
	 YAnuNG/fU6ow+e83kikS4F4c6OyQr72bM10jOucmLUZ1+TUhmikHAmQTqdu+b1HvW6
	 CmYww/qlo9sm6ZQtWtbWIChNXSWaa5p9PKQU46/ad9pMLL806rlINmxVu0PWN59+/T
	 6esQmqFi2sGPA==
Date: Thu, 29 Feb 2024 18:40:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>,
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
Message-ID: <20240229-ageless-primal-7a0544420949@spud>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
 <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
 <87wmqoilzf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cEg17b20MxyCi/dL"
Content-Disposition: inline
In-Reply-To: <87wmqoilzf.fsf@kernel.org>


--cEg17b20MxyCi/dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
> Marc Gonzalez <mgonzalez@freebox.fr> writes:

> > As mentioned in my other reply, there are several msm8998-based
> > devices affected by this issue. Is it not appropriate to consider
> > a kernel-based work-around?
>=20
> Sorry, not following you here. But I'll try to answer anyway:
>=20
> I have understood that Device Tree is supposed to describe hardware, not
> software. This is why having this property in DT does not look right
> place for this. For example, if the ath10k firmware is fixed then DT
> would have to be changed even though nothing changed in hardware. But of
> course DT maintainers have the final say.

I dunno, if the firmware affects the functionality of the hardware in a
way that cannot be detected from the operating system at runtime how
else is it supposed to deal with that?
The devicetree is supposed to describe hardware, yes, but at a certain
point the line between firmware and hardware is invisible :)
Not describing software is mostly about not using it to determine
software policy in the operating system.

--cEg17b20MxyCi/dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeDPuQAKCRB4tDGHoIJi
0oklAQCb9liXgCtU0yqoCxGYrPtfMDdWh7iUxPWsScbIPS343AD/c6Wr2hVOtmtB
qj/WEDA/Sdh/5pt/pXxfhjnLYJ4shA4=
=+qJ3
-----END PGP SIGNATURE-----

--cEg17b20MxyCi/dL--

