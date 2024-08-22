Return-Path: <linux-wireless+bounces-11786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C795AFE2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 10:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87CA1F25D22
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1215516DC15;
	Thu, 22 Aug 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5AIQ+I9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D810316D9AE;
	Thu, 22 Aug 2024 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314084; cv=none; b=H2f3OYYvT8irh4q5AWepgeAy+hFVt4pS8kyPAS2mHRtnljrYhIMX0yIDkpngvXTxDJSqZmrJ0flDr73agAcBnmpqNt0tchlE6ndy4Sdw6oKs3JQGQ78zb4nP//pk/sXUwaF3FK4NSyClVxTgtML4CUVVx+0QUCrDzX5UvLZB+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314084; c=relaxed/simple;
	bh=kUFSug2y/B7R89/GzAwgmNS6B3HMdq3CQuLxffNNrcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA0/uCwGUGq50PnKzur9Xc6t4pWonz/RDmrRbwkG61HqdCVqjw3p9BwoOGZAIc5lf57Z1sJFM8z7bTZSr9U+YY677ngU7gHiVCZbrIY0I2REMufoZ0SZuvMWRv50CRQNiDi5CyN3/Jbo6Ba/F8ZCBBID1wp/nAUMROExQ33Wq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5AIQ+I9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0CEC4AF09;
	Thu, 22 Aug 2024 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724314083;
	bh=kUFSug2y/B7R89/GzAwgmNS6B3HMdq3CQuLxffNNrcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5AIQ+I9HtXemXqgPIvcUaXxaBRGHtKJkg+WtVCXrkusvQcR+ezrMBQk73qN3+UeF
	 zPm3V8jdbNnq1a1u6jzGLcpMwaXCrLrcoQhO+YmF6vU0nZQX93P8mZ6wZ10lxwrkdo
	 nZQHCcpBHv9ONQTNhImU/KEdPD8zvrNYZOm9g2xtBuTelx10g6Y05KO6efIC3pC9v9
	 rlzJgzLDxMQCixgmw7nUnbyQc1W8pf0wOPe5SYma/jdlVtQxmWuj5iwNPO7ACoZ6M1
	 kvp9geQ4tj2aTo+YHCI1Q06tmJqW2yuL/N5WCp3AIhy2H7neaKG/TWt5VJPVBqsSkx
	 26Pyf2OmrCkog==
Date: Thu, 22 Aug 2024 10:07:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Adham Abozaeid <adham.abozaeid@microchip.com>, 
	Ajay Singh <ajay.kathat@microchip.com>, Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley <conor+dt@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: wireless: wilc1000: Document WILC3000
 compatible string
Message-ID: <ztc4h7rgsli2jltrdgu5twnma6dbbt3kbbbo3i4eevb3whkqkv@oabtuskiz7km>
References: <20240821184356.163816-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240821184356.163816-1-marex@denx.de>

On Wed, Aug 21, 2024 at 08:42:32PM +0200, Marek Vasut wrote:
> Document compatible string for the WILC3000 chip. The chip is similar
> to WILC1000, except that the register layout is slightly different and
> it does not support WPA3/SAE.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  .../devicetree/bindings/net/wireless/microchip,wilc1000.yaml  | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wil=
c1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1=
000.yaml
> index 2460ccc082371..1bf3496c21e64 100644
> --- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.y=
aml
> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.y=
aml
> @@ -16,7 +16,9 @@ description:
> =20
>  properties:
>    compatible:
> -    const: microchip,wilc1000
> +    enum:
> +      - microchip,wilc1000
> +      - microchip,wilc3000

Your driver change suggests device type is fully auto-detectable, thus
they are compatible.

Best regards,
Krzysztof


