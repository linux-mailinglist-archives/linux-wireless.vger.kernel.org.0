Return-Path: <linux-wireless+bounces-4348-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427B4870AC6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 20:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D73287070
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4149D79950;
	Mon,  4 Mar 2024 19:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/6bN++K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DE79941;
	Mon,  4 Mar 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580870; cv=none; b=MHP28EQB3sjpmpRL5AWt79GF7chSc+p1eEasf68XI+Pas+8b4BjOTfpfJkFrQkM4To+p9coe1cH9u2PwX1HZihb8DbfgGlbVC2D+EVbJ8ciGtmyk1f0T41ky876L0xMS+dFsK1T4lk25bEiKACRTFopmeKFjf0lWMuhXPQ87d4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580870; c=relaxed/simple;
	bh=hfPu6EysdEbjriYSDjgUpEYkvags1PNmUGb2z5pWclw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2qn2gTl05NqeXoUoUMYW7MkclSj0ygzWMaMqKH/q95QGIA9OoxvKJkKpPxtCElu69PdYL/TPC+x3OIP69YZtCPIF9JJYjBo2riZx9JThXWj7NcV9i9XGUOB87f/b34k3x2eYhR+uXqXWPq4/UYiYH8ikzqIJCTZ0Zt6B5HkR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/6bN++K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06443C433F1;
	Mon,  4 Mar 2024 19:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709580869;
	bh=hfPu6EysdEbjriYSDjgUpEYkvags1PNmUGb2z5pWclw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/6bN++KlvhxwGzW8fk9o6qDNjmeFkSZIuwI+dSb0H8FKkH/2Gk+XknF5dHn8clxI
	 v9Vo2AdMK9uu5/Juq87GzpxCFlUhTLjJvn6Ql9HY3YhQ6/xclXTPPSKhHR6yhCR/bV
	 kSN4tD5uWhSqqLJhs2+GwF+IoVavhPYOafTiVFMPxH7W7Um7TZNH3e01UWVbdH5Q4T
	 GkLwoIybbltYihMGQa7Gmfqap08PwBWJlgGyQuOUe4+ppvPzUjfjDjzShTDXVMz4E4
	 p2Zco/h4/LTDXalQ1nnrAiQ0FQ9fDqk8UuBPpZ6ak74mLYUxnTaTF/N99GXYUKZpmp
	 rcV/h1uJQ9Pmw==
Date: Mon, 4 Mar 2024 19:34:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Marc Gonzalez <mgonzalez@freebox.fr>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k <ath10k@lists.infradead.org>,
	wireless <linux-wireless@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	Jami Kettunen <jamipkettunen@gmail.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath10k: add
 qcom,no-msa-ready-indicator prop
Message-ID: <20240304-component-animator-e2ee0ab7574a@spud>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
 <b8de96c7-cbb6-4a09-a4d4-2c11b3ab3e01@freebox.fr>
 <871q8wk7o3.fsf@kernel.org>
 <3392f356-7b19-483d-b9f8-3bd84068fa52@freebox.fr>
 <87wmqoilzf.fsf@kernel.org>
 <20240229-ageless-primal-7a0544420949@spud>
 <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bhDdbVFfGqGZqHQo"
Content-Disposition: inline
In-Reply-To: <68a49964-7c05-4575-a4f3-35848c08fefc@freebox.fr>


--bhDdbVFfGqGZqHQo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 05:21:37PM +0100, Marc Gonzalez wrote:
> On 29/02/2024 19:40, Conor Dooley wrote:
>=20
> > On Wed, Feb 28, 2024 at 06:37:08PM +0200, Kalle Valo wrote:
> >
> >> Marc Gonzalez wrote:
> >>=20
> >>> As mentioned in my other reply, there are several msm8998-based
> >>> devices affected by this issue. Is it not appropriate to consider
> >>> a kernel-based work-around?
> >>
> >> Sorry, not following you here. But I'll try to answer anyway:
> >>
> >> I have understood that Device Tree is supposed to describe hardware, n=
ot
> >> software. This is why having this property in DT does not look right
> >> place for this. For example, if the ath10k firmware is fixed then DT
> >> would have to be changed even though nothing changed in hardware. But =
of
> >> course DT maintainers have the final say.
> >=20
> > I dunno, if the firmware affects the functionality of the hardware in a
> > way that cannot be detected from the operating system at runtime how
> > else is it supposed to deal with that?
> > The devicetree is supposed to describe hardware, yes, but at a certain
> > point the line between firmware and hardware is invisible :)
> > Not describing software is mostly about not using it to determine
> > software policy in the operating system.
>=20
> Recording here what was discussed a few days ago on IRC:
>=20
> If all msm8998 boards are affected, then it /might/ make sense
> to work around the issue for ALL msm8998 boards:
>=20
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless=
/ath/ath10k/qmi.c
> index 0776e79b25f3a..9da06da518fb6 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -1076,6 +1076,9 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
>  	qmi->ar =3D ar;
>  	ar_snoc->qmi =3D qmi;
> =20
> +	if (of_device_is_compatible(of_root, "qcom,msm8998")
> +		qmi->no_point_in_waiting_for_msa_ready_indicator =3D true;
> +
>  	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
>  		qmi->msa_fixed_perm =3D true;
> =20
>=20
> Thus, anyone porting an msm8998 board to mainline would automatically
> get the work-around, without having to hunt down the feature bit,
> and tweak the FW files.

How come the root node comes into this, don't you have a soc-specific
compatible for the integration on this SoC?
(I am assuming that this is not the SDIO variant, given then it'd not be
fixed to this particular implementation)

--bhDdbVFfGqGZqHQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZeYiQAAKCRB4tDGHoIJi
0gLiAP9ae+USWPlOTK3qJiAXdwckG5buGi5gBreOCjcOL9NtDQD/Uvk0cIeTq05/
61GvL37kjGGBqpiFoPi5PQwgR+EUHAE=
=rob9
-----END PGP SIGNATURE-----

--bhDdbVFfGqGZqHQo--

