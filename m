Return-Path: <linux-wireless+bounces-11437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522F951FE0
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 18:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6D4F1C217FB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Aug 2024 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D131BD00F;
	Wed, 14 Aug 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsVBxI9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29851B8EA8;
	Wed, 14 Aug 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652707; cv=none; b=AAw0lCN37w8NZdlgFkjR7glKPGYHCUhLhztfhDFl3D1Nf7u4HKUsEE9IFw9nQa/ki0xuPReKPuPvo+eughlmGSn3vB/fkZNHmg7bU5yq2yFvhyW02nF6uthsqNzcWgn+nsMNqkd3YZTcKQNWUsL/ZBXjOEeLv6L68uFEMG+VLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652707; c=relaxed/simple;
	bh=cJRSwFOqxuezEsGgy/e+FJqSCUB8W3xhzbVyDljETsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv1qGqAbCCfB75bOMnvLi9qK+dFgdV+8c5aNzoSRmRWyWf7TTVB7CBnNVItYOchysdZT3stbdpX3g6rDI34eZFOSQ0S750qO1YwXHfb46oqIQamAG0/Re8luvrwhfEQmqtsP6yVLaJIBIEgq9qI+fkk3+BlJg2Z4BfyJkG+lJRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsVBxI9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0464C116B1;
	Wed, 14 Aug 2024 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723652707;
	bh=cJRSwFOqxuezEsGgy/e+FJqSCUB8W3xhzbVyDljETsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XsVBxI9k899Lz7daCQj/WDuzJPncBsIxIYVJ75K/L3bPwx6rPKuwCEtZZYsN4QPRk
	 he8sk+mZ8JXvTNM0yDpL8joxIgHMQfsSmgqmz9CMHq5f61NWjXWyYXuqeI6ao6tA6h
	 v+XZ4gdYZf8J3UT5mqDaYdT5lkzif+w6AIrja85Rgt1Wx8aNpwdlUAlUJzmv4x4/UO
	 34If6PFWBusN6td85lAfZSZTWcmZ4iDCofs2Kp/etzZo8Bv9vnJRUKqdz6ErYPotyH
	 OnuSDhSrL6ARgoXVfkg2mD2t3hkdC4DerR1aAiDVLCRQD1czvmiNQ77CWd2l4QGfA3
	 BWm0SkvqSBbfw==
Date: Wed, 14 Aug 2024 17:25:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2] dt-bindings: net: ath11k: document the
 inputs of the ath11k on WCN6855
Message-ID: <20240814-neatness-moistness-c485bcf5007e@spud>
References: <20240814082301.8091-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NyEsTL8PAnfJICw4"
Content-Disposition: inline
In-Reply-To: <20240814082301.8091-1-brgl@bgdev.pl>


--NyEsTL8PAnfJICw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:23:01AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> Describe the inputs from the PMU of the ath11k module on WCN6855.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--NyEsTL8PAnfJICw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZrzaXQAKCRB4tDGHoIJi
0uxLAP9ONAVs6RzQfb19qS9fjD0Ee7V/e4+Btft57Kub8WDz6gD/UxYNZ+FvuY7A
TESI7gZAQkpCakphaJmyrhwMx+PSLwY=
=/aW6
-----END PGP SIGNATURE-----

--NyEsTL8PAnfJICw4--

