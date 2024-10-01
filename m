Return-Path: <linux-wireless+bounces-13382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E338098C36A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17EDC1C23E2D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F01CB307;
	Tue,  1 Oct 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzHpNUTc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D9B1C9EB7;
	Tue,  1 Oct 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800223; cv=none; b=kmkAf8oaXVOhJSGvMStBU4vikX1ywMriUTzeSQG/K12TEMaqKrLKISmhvpBau1kNeLkgnDymRlOccYS04E23dLL0K0HhCZVX5FYZ8M7KlZ6LhNAvVn9aP4PIqK+0QulHoEB8N2V+hUVrBUgjL++XAH7dYhEqmTXLHlNJjPUoNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800223; c=relaxed/simple;
	bh=qywIPYHuVPGlOQUUJe1oYrly+X7OJ96HoqCYKutu3Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5I/NHn/Q0CdYik78gcZRBM1kAmPIdHnwYNEVqEEgvxGSw/68q4XH+iXXJLar+JfL/2Ki/XNBb04abZGxbQFmJNVDOSBxUaEbyVA0wg8iAXRpCG1uqHnAzXAlI+kOCPbeNmTaEldkzi+/T5jA6cMcY36zsBGElXVTeLUrrBa+HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzHpNUTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE946C4CEC6;
	Tue,  1 Oct 2024 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727800223;
	bh=qywIPYHuVPGlOQUUJe1oYrly+X7OJ96HoqCYKutu3Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzHpNUTcOCjxUgmmwdf0fAX9FusKgOjcml52YETXn2k/+at7tKtbM7h9dxYUxKdGA
	 WLepTw9R7IHWMiZw7JGLHRLqRTeA3+aseqjtzYgyc7K6N4IzHgUhG+T8bEhNqu+XEy
	 EbeNz3aoNU9I4bsEzjwqdhrVbT8Odh32U8Sd3EWQPH2xLcXqU4v8wCtSfwMmfezxPY
	 nbHYJd0fgVpg5QoQ9mufTLgR/1e/CMsY096oB2ZvaQDLiq2IIRXJlJiKrLNFttYnQ4
	 9Xi+oSS3CDj24RiygnASEqV2p3UkcINU8ozB1+GoJs0KQI37ywG/YTaOCtRsr9l3vV
	 yLe12E96+0mNQ==
Date: Tue, 1 Oct 2024 17:30:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: ath11k: add
 firmware-name property
Message-ID: <20241001-stratus-aerospace-93a8fcc20daf@spud>
References: <20241001033053.2084360-1-quic_miaoqing@quicinc.com>
 <20241001033053.2084360-2-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tf8btgzQbpXwk8UC"
Content-Disposition: inline
In-Reply-To: <20241001033053.2084360-2-quic_miaoqing@quicinc.com>


--Tf8btgzQbpXwk8UC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 11:30:51AM +0800, Miaoqing Pan wrote:
> This is the same optional property that defined in qcom,ath10k.yaml. It's
> useful for the platform / board to specify firmware through device-tree.
>=20
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Tf8btgzQbpXwk8UC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvwjmwAKCRB4tDGHoIJi
0o52AQCaUZULOWA6elXQcLGkgs4ST3BsPJraPCN54wNg+3YamwEAsMgfVrAw86v/
fi6B55JrfAIf+klnNqxLloy/QQQxYwg=
=EUhw
-----END PGP SIGNATURE-----

--Tf8btgzQbpXwk8UC--

