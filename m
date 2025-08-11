Return-Path: <linux-wireless+bounces-26272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF918B21192
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60256875D1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51E12C21F4;
	Mon, 11 Aug 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiS1+1t9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F9296BAD;
	Mon, 11 Aug 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928674; cv=none; b=EyT/l/XkWcIOMZ5j6ghhzdWOYOQiW/b7uqpck2UHiLhpZKEdcfIrELO8f5MzPU80ySzdoQLYK3lSPiTTsuy1c3U583wAIyi5rkbscyYWcxcvTmSATQA0p3gH96wcvkd1F/WVZWopWDdGbt4w16wM0aQu+tJiRmUHXaHzlW/PXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928674; c=relaxed/simple;
	bh=xIJ28HxQuqHrb5Mjj7mj7vyWykbmZ8e2tbB/UXJvPZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSzeXI8z/O2jXgvN4GeP3/muQejK1kROrxAfTeB8+Ck1LfEJ0cxrLyX9ugYwrdVlSIrR8kQpytnphPyZwmczQ2xiGx53wCFFK4QobDPr9HYfI5V09Ha5d1+Ggs+LWZqmat/s+VE4issrvgWWKE9Zld9gDi3zdT1IlPxfaHr3lM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiS1+1t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C13FC4CEED;
	Mon, 11 Aug 2025 16:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754928674;
	bh=xIJ28HxQuqHrb5Mjj7mj7vyWykbmZ8e2tbB/UXJvPZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiS1+1t9E8yBQzr/SqB3J6BKht75cAEdwd2rlX32JoEJ5M6W6dLLYKXv8WGcgsBMY
	 PBcyJ0Ve1Jg45AfSNHYtFg8tvewX/MJ6gRSKkrggTMkJjarHRnPkjL9JsVmTghsegK
	 1mBOoK8q35cyk9Gg2JZFCze8fE8wkTM5j3/ZOiq0aXQ80fbHgge++0+atC+/zKfTIH
	 ri64wPqlDGnC97fWghAd+xe2nXy3KIASaXltcT1zY9sHcmt/ehsNf6C0InpxBUolnu
	 LW2K7NATrhmaDAv4wLQCNtHZqFGyJiQppQ0ZQFx256Y/l5mzc0N++GBR7CURm2ka7o
	 nftdqSPzhvK1g==
Date: Mon, 11 Aug 2025 17:11:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Greer <mgreer@animalcreek.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: nfc: ti,trf7970a: Drop 'db' suffix
 duplicating dtschema
Message-ID: <20250811-carnivore-snagged-faac10d63881@spud>
References: <20250811142235.170407-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YKE6XInXu+TRmTNK"
Content-Disposition: inline
In-Reply-To: <20250811142235.170407-2-krzysztof.kozlowski@linaro.org>


--YKE6XInXu+TRmTNK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 04:22:36PM +0200, Krzysztof Kozlowski wrote:
> A common property unit suffix '-db' was added to dtschema, thus
> in-kernel bindings should not reference the type.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--YKE6XInXu+TRmTNK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaJoWHQAKCRB4tDGHoIJi
0o90AP9WzTCj8A3vSjlX1/lwKdCwRPrg2mEWXuz9zrnf0olGoQEA9M50nRmCovm2
qx6tok0s1wbGj2Erz+w9YleIzpSQ2As=
=SD2R
-----END PGP SIGNATURE-----

--YKE6XInXu+TRmTNK--

