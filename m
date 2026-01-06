Return-Path: <linux-wireless+bounces-30399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD87CF8804
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 14:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0285F30205CA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217043314D1;
	Tue,  6 Jan 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckf4SgKa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B3D3314B7;
	Tue,  6 Jan 2026 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706041; cv=none; b=n1U0LNG4AeoPZAtk1MAUrgNlBQMUuUByS66m7wsCzGc82foVrB3ggxwuem/PhGxGrxD9eEbWy4SQE3IfROu4j5K5yazVcl6oFQvQWeg3nmxOKBrXBiE/X4rKl0GtGkUbqFt8HOoyojOk7Lb6FII14gjTm3+VL5YeEKnbdHK8hW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706041; c=relaxed/simple;
	bh=P5GBjzPKN0+BwzaSKcOsnRgIWAdGRqYK34S053ES/sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vnr/4YkQ1s27xkm5dFv2MSWJxhwXxImQkyv2MdUABNwS7VDH8n0yTRM7aT0ORtpAuZZ3FlUs0+oQKQg9PVUiDpJrgjlpMBmrNlgyEF7KC1F9gi7FddQLZhdRRLq+mU8h7FmrUYN1PMUF7n5VZTF8Z5dieJ2OUSkEGIkMluvAXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckf4SgKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A45C116C6;
	Tue,  6 Jan 2026 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767706040;
	bh=P5GBjzPKN0+BwzaSKcOsnRgIWAdGRqYK34S053ES/sM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ckf4SgKa1ru14R7kxRE1uOsG3FPfR3xJCFWZ9f+InvnJ+wh57pS0GcldaMwskVhY2
	 +Qxow6CDs4fsww/jMHuQMjC48qJlxvUMXrCA0o/FHGJ4CiPEMZv4n7Qwwxb2VjRBGU
	 VVHDhe2bHwkhHfvLIMdS9+HGqkxel5jB45DjAdaKd8HUUqKy2r1RC/GWo5sZAoFe+P
	 wOewdJphgODxZm4DwSEpAOM5ij573EevnOSL5UR+21r8mNl+9Tq8tnNeSVbbM9qIWR
	 BSct1JqmRlDuUuzixOuR9CpC5KiANiDi4W21s4P6HdKQgHRug0Vq6HKe76zm1f+xqg
	 WcvGAklpkNO6A==
Date: Tue, 6 Jan 2026 13:27:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 01/14] regulator: dt-bindings: qcom,wcn3990-pmu:
 describe PMUs on WCN39xx
Message-ID: <e5c70879-dcea-40ea-98ab-454a774e3543@sirena.org.uk>
References: <20260106-wcn3990-pwrctl-v2-0-0386204328be@oss.qualcomm.com>
 <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SNU7rx7CNqi3LNfR"
Content-Disposition: inline
In-Reply-To: <20260106-wcn3990-pwrctl-v2-1-0386204328be@oss.qualcomm.com>
X-Cookie: People respond to people who respond.


--SNU7rx7CNqi3LNfR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2026 at 03:01:11AM +0200, Dmitry Baryshkov wrote:
> WCN3990 and other similar WiFi/BT chips incorporate a simple on-chip PMU
> (clearly described as such in the documentation). Provide DT schema
> covering other Qualcomm WiFi/BT chips to cover these devices too.

Acked-by: Mark Brown <broonie@kernel.org>

--SNU7rx7CNqi3LNfR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmldDbAACgkQJNaLcl1U
h9AZAgf/XiipI3+F+QTxwrwQRzlh0LdMCBZcR45yuHFhsU41dnP8c8jxSyBi4jha
zisYjRUaX/If0siDIbV8OcUmr3IZGW8heg5lQ9+pKZSqDLSqHik9RbaR04VV3r6N
urE8Y6dC0cfFvwQdxZxkRegQvagVL553Xq+kGNpRUGJEB6iX/8C9ulJwb4BiswHp
v8U8MxtFyxfDSNWWJ93VpoasUNKyUex+Pztdflr5sPM0yLqK0bDXWqHtOc5ymacL
zQ0tLxLeKBZaTAeSXQkvvzyYEFux+y6HaGOoz7MbJOkuxZjz10a6kRBcRwPHAci2
czf2UsuEVlaLh3bDn6IYpJ9kaukVtw==
=KbP6
-----END PGP SIGNATURE-----

--SNU7rx7CNqi3LNfR--

