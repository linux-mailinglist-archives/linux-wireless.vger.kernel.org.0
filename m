Return-Path: <linux-wireless+bounces-6852-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634768B25E4
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1778B1F21171
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179C214BF9B;
	Thu, 25 Apr 2024 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLKO3pOk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03ED1494BF;
	Thu, 25 Apr 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714060983; cv=none; b=HGn6tZuLxPa5eaYr/QKvemLQzOF8RIlFRUdgDVD+SlcVQQ1Nk39lZalrejjoLSClG82lDVK0Dpz1P3fRlYC2TvRqjxD7Njj3q6ahWA2HjXRYQqRRDRR5UqBOYORRPe4YqPnnu6ivOYlIWFg2DrrbP6nYY8krE0D1F7vdnRVfLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714060983; c=relaxed/simple;
	bh=F4x4Lmt+cQRG94onurPrKbBq2z3g90UEAceM4vYt2Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6A0ziy9JFU9jJzc5Fy2o5oOjbM1nuavH8EKJOXvXNUKe6Sw4nAWfrBy7YHKlhRvRm13xY10qgu2+lgAudCB0DUfxm2qNXBqApsEP3C8hULPoD/9nLTQKWqQ8tfivEmD+iZ+vHnIzpqAq7fDcf1U0uZY/YytkDMt5J3rCqEoDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLKO3pOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF513C113CC;
	Thu, 25 Apr 2024 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714060982;
	bh=F4x4Lmt+cQRG94onurPrKbBq2z3g90UEAceM4vYt2Vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLKO3pOkjaMo3fAat8eU382biRncn++pQr4l1+5HlIi6MXlTJmnW1AxW6Yg02ox3W
	 HuM4YCE4jQIf+OVbZXvbGqkUaFJg8m43F+6D2Bxe2nvDcRpOZN+346vY1JhyVaOkrk
	 Nbt+nIvILJwR3TzhhD0tnE28iyucWIHJUVF0B6iWgplVHMB51dZnTSrZjujS0nYYYp
	 8Bkzbncn3Ml0uuM78m2ExhGe2rjj2ep4e0z4f01hnA+pSeqT9lSDukD2awhSV75CjF
	 sUBoBM5FHC9TahI+oeFZ6mFXTH9/Rz7p2tQ1NxRj/+XAtbcntfz8ThbFUI3XQB33c5
	 KbPItXBjw46ZQ==
Date: Thu, 25 Apr 2024 17:02:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Marc Gonzalez <mgonzalez@freebox.fr>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	ath10k <ath10k@lists.infradead.org>,
	wireless <linux-wireless@vger.kernel.org>,
	DT <devicetree@vger.kernel.org>,
	MSM <linux-arm-msm@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pierre-Hugues Husson <phhusson@freebox.fr>,
	Arnaud Vrac <avrac@freebox.fr>,
	Bjorn Andersson <andersson@kernel.org>,
	Jami Kettunen <jamipkettunen@gmail.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8998: set
 qcom,no-msa-ready-indicator for wifi
Message-ID: <20240425-monopoly-barn-45608dae0996@spud>
References: <502322f1-4f66-4922-bc4e-46bacac23410@linaro.org>
 <0ca1221b-b707-450f-877d-ca07a601624d@freebox.fr>
 <CAA8EJppeREj-0g9oGCzzKx5ywhg1mgmJR1q8yvXKN7N45do1Xg@mail.gmail.com>
 <87ttkh49xi.fsf@kernel.org>
 <e804b257-4dc0-45f1-a5c5-66bda51cf296@freebox.fr>
 <87h6gh406w.fsf@kernel.org>
 <ad5e178b-cd64-4a87-8994-f917993f3bbb@freebox.fr>
 <871q6tu6bn.fsf@kernel.org>
 <de65290c-0f67-4499-ba28-a460e6d6e419@freebox.fr>
 <87msphsb3b.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tiPZAU7Mew+vAoOh"
Content-Disposition: inline
In-Reply-To: <87msphsb3b.fsf@kernel.org>


--tiPZAU7Mew+vAoOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 06:42:16PM +0300, Kalle Valo wrote:
> Marc Gonzalez <mgonzalez@freebox.fr> writes:
>=20
> > On 25/04/2024 11:42, Kalle Valo wrote:
> >
> >> Marc Gonzalez wrote:
> >>=20
> >>> Do you prefer:
> >>>
> >>> Option A =3D never waiting for the MSA_READY indicator for ANYONE
> >>> Option B =3D not waiting for the MSA_READY indicator when
> >>> qcom,no-msa-ready-indicator is defined
> >>> Option C =3D not waiting for the MSA_READY indicator for certain
> >>> platforms (based on root compatible)
> >>> Option D =3D some other solution not yet discussed
> >>=20
> >> After firmware-N.bin solution didn't work (sorry about that!) my
> >> preference is option B.
> >
> > Actually, Option B is this patch series.
> > Could you formally review it?
>=20
> I'm happy with this series and would take it to ath.git, just need an
> ack from DT maintainers:

As far as I can tell, Krzysztof wanted a commit message update for 1/3.
Usually this dts patch would go via the qcom dts tree, so presumably
there's a need for an Ack from Bjorn or Konrad?

>=20
> https://patchwork.kernel.org/project/linux-wireless/patch/84f20fb5-5d48-4=
19c-8eff-d7044afb81c0@freebox.fr/
>=20
> > Perhaps one thing I could do slightly differently is to NOT call
> > ath10k_qmi_event_msa_ready() a second time if we DO receive the
> > indicator later.
>=20
> Good point. And maybe add an ath10k_warn() message so that we notice if
> there's a mismatch.
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches

--tiPZAU7Mew+vAoOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZip+sAAKCRB4tDGHoIJi
0o+YAQCCZYEZ2U1aVxSGNQuMVNcvcuOmlw4+qtZjc2LH2bDn7wEA0lVi4wIeNh+F
ZbiMp3gzzAKwmfNX3gcOma5h23G0Rgs=
=DCf+
-----END PGP SIGNATURE-----

--tiPZAU7Mew+vAoOh--

