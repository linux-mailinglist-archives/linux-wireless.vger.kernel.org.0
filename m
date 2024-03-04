Return-Path: <linux-wireless+bounces-4350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60E870AE5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 20:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0D0B214FB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF179957;
	Mon,  4 Mar 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOz4Lfo2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9214653A;
	Mon,  4 Mar 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709581563; cv=none; b=WUVBmlz8mXz5D7MR4CC6EZEMTLC2IkBfw9lpCmioE1Ij5IuPReu0NCjfkfyPUiJakLNZBXFhsOb8ETKjwWCJoR+3Wq5OMW6Vcwbphe0pAWmCng2uUQuz5MOxIK2NuKRtidSPcmN5jld/l5K131qyIZAhXrVpn8tgG9ZUCLGXH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709581563; c=relaxed/simple;
	bh=/na7WEDTqbrrPLUSeebOS56+PR8+1l0yqJy14F4XQB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmx78zBfwMKvyaEpSIhT+/N//7ldQ17pBLnRc+RjH/5Z6o+BvW/OOTBkTVx2GOcPVJRZ+nsrM81dT+gX5la82Pwh30SLHWTe85chv5ypZAU5lMqv7ytOuw+KEX3MF8kgkDLctQZAIXA8GYENeRmV3YNVrKJSlsDw4PC8YiuBEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOz4Lfo2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F8EC433C7;
	Mon,  4 Mar 2024 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709581562;
	bh=/na7WEDTqbrrPLUSeebOS56+PR8+1l0yqJy14F4XQB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOz4Lfo2GqFYe4VT6KfpdU8Ptl34mhm3G/feNyyc3raVGdIACu/37hz7dNKedSv2V
	 7uGDcYwHEYKvYYrtNI4YUi8rKXZMntCegrcAdsMvz1XD99sztroSckd/H9EX0CwkXZ
	 xjTd39t2zfjefzf0GXn2lq6JCa1VIuFY742G/sipfZ3MBFBzMpf6J/ZuKMulGoPOk7
	 7JPq7dkzFa/NHiXy+pb+q9jbb69T7TdCCnpoQB94wFFImYACE5F1ub2QxafltZGjlr
	 2qoLlIS8YQhih1MH7LgXVV3WkqA08SD0VsKBUetxROqWm8XyyHINaW0/ohLsxtZvMy
	 Gy0vyQfiQCvxg==
Date: Mon, 4 Mar 2024 19:45:57 +0000
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
Message-ID: <20240304-superior-vicinity-3dc6ca88141a@spud>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
 <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
 <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
 <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr>
 <20240304-component-animator-e2ee0ab7574a@spud>
 <CAA8EJpq5HQaO2E2Pd7yqUTsWyQ_pLDdyoWng8QmWTzYn5fv3PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wojNABL86L/ImB3a"
Content-Disposition: inline
In-Reply-To: <CAA8EJpq5HQaO2E2Pd7yqUTsWyQ_pLDdyoWng8QmWTzYn5fv3PQ@mail.gmail.com>


--wojNABL86L/ImB3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:37:00PM +0200, Dmitry Baryshkov wrote:
> On Mon, 4 Mar 2024 at 21:34, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Mon, Mar 04, 2024 at 05:21:37PM +0100, Marc Gonzalez wrote:
> > > On 29/02/2024 19:40, Conor Dooley wrote:
> > >
> > > > On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
> > > >
> > > >> Marc Gonzalez wrote:
> > > >>
> > > >>> As mentioned in my other reply, there are several msm8998-based
> > > >>> devices affected by this issue. Is it not appropriate to consider
> > > >>> a kernel-based work-around?
> > > >>
> > > >> Sorry, not following you here. But I'll try to answer anyway:
> > > >>
> > > >> I have understood that Device Tree is supposed to describe hardwar=
e, not
> > > >> software. This is why having this property in DT does not look rig=
ht
> > > >> place for this. For example, if the ath10k firmware is fixed then =
DT
> > > >> would have to be changed even though nothing changed in hardware. =
But of
> > > >> course DT maintainers have the final say.
> > > >
> > > > I dunno, if the firmware affects the functionality of the hardware =
in a
> > > > way that cannot be detected from the operating system at runtime how
> > > > else is it supposed to deal with that?
> > > > The devicetree is supposed to describe hardware, yes, but at a cert=
ain
> > > > point the line between firmware and hardware is invisible :)
> > > > Not describing software is mostly about not using it to determine
> > > > software policy in the operating system.
> > >
> > > Recording here what was discussed a few days ago on IRC:
> > >
> > > If all msm8998 boards are affected, then it /might/ make sense
> > > to work around the issue for ALL msm8998 boards:
> > >
> > > diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wire=
less/ath/ath10k/qmi.c
> > > index 0776e79b25f3a..9da06da518fb6 100644
> > > --- a/drivers/net/wireless/ath/ath10k/qmi.c
> > > +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> > > @@ -1076,6 +1076,9 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_=
size)
> > >       qmi->ar =3D ar;
> > >       ar_snoc->qmi =3D qmi;
> > >
> > > +     if (of_device_is_compatible(of_root, "qcom,msm8998")
> > > +             qmi->no_point_in_waiting_for_msa_ready_indicator =3D tr=
ue;
> > > +
> > >       if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
> > >               qmi->msa_fixed_perm =3D true;
> > >
> > >
> > > Thus, anyone porting an msm8998 board to mainline would automatically
> > > get the work-around, without having to hunt down the feature bit,
> > > and tweak the FW files.
> >
> > How come the root node comes into this, don't you have a soc-specific
> > compatible for the integration on this SoC?
>=20
> No. Ath10k uses WiFi SoC as an SoC designator rather than the main SoC.

Suitability of either fix aside, can you explain this to me? Is the "WiFi
SoC" accessible from the "main SoC" at a regular MMIO address? The
"ath10k" compatible says it is SDIO-based & the other two compatibles
seem to be MMIO.

--wojNABL86L/ImB3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYk9QAKCRB4tDGHoIJi
0kaaAQDnE4MEozONllZ+Q/SJg4H13bE1VgsWK3RoMjw0F+WHYQEAvEapGyAe9GIz
HA9NkpMj89CoBgLGj94SaMDYp4oFfgo=
=fxeV
-----END PGP SIGNATURE-----

--wojNABL86L/ImB3a--

