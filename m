Return-Path: <linux-wireless+bounces-22063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565FA9C5AF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 12:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA7D188BBE1
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A7B219305;
	Fri, 25 Apr 2025 10:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+rJyAKJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8119D8A7;
	Fri, 25 Apr 2025 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577513; cv=none; b=M3KlUz1Drd31tEtr1GulRhrHE7A8zItrg17ylzoSYDouV4xcBJ0GjObWV2vmnra7zm9iWj+anrKaXpMt4CWHavcNfMSqJIc7/0uCC46CgUyh3ZvV1GSZp+fhqMZmM6gMNfEkk7AOrifMVx2yp+Lf4aa/7LvERFm9TBGr3q/7UzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577513; c=relaxed/simple;
	bh=5BmKuaaK+bDkUvD9xGKp7macz+ok6g4gCHws+01z3U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jH4vhEZgVsDDzZruTkq9pYdivtJaxFvrexIyqDXz2vXFSZgZr4BSmgNYo5ulBlERIqYvXjJLNtsB+ULACPoGi/vLWQj1kbPi3DSkosi+HJqbC2A2grux+sGJ8Erwm4iCbxS6yWZ1NryDhY2RXGV3DY3qU6T7yJGQQuOn5uMcmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+rJyAKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17E2C4CEE4;
	Fri, 25 Apr 2025 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745577512;
	bh=5BmKuaaK+bDkUvD9xGKp7macz+ok6g4gCHws+01z3U0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o+rJyAKJXkOpPpNhZ+W3PYmkDKmOW9bevakn75pjPnLLTV6jvq0U1j2yZJ5VZ7hb7
	 tlZFTGNFv9q9esE7jEvWCvkxSIiRlkPM4BRdRBWxva7yjlaIFm+6CsS9n/n9kIR5ER
	 UDHJxMsfMAErm6sGOyXf8pcBRJkscwmTXcNPKcWYOOjbnfIWQWFAvoeO+Ds1IUP5UX
	 LVXFR2ViZxtU9wl7OMkVlA30CvYggAuL6fQAZlbnYHv8ziDrbcbv4hTfCYBHwH/FsF
	 H/I6CFG0j4fWjY/MuUQjCVb2AvB8aoBgiw0uv36Jo2L5Cwh/alrlsZG2KYZC5f1qSX
	 iY4OpuhTn4U/Q==
Date: Fri, 25 Apr 2025 12:38:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artur Rojek <artur@conclusive.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Klama <jakub@conclusive.pl>, Wojciech Kloska <wojciech@conclusive.pl>, 
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Subject: Re: [RFC PATCH v2 1/2] dt-bindings: wifi: Add support for Nordic
 nRF70
Message-ID: <20250425-capable-tapir-of-energy-a9e03f@kuoka>
References: <20250422175918.585022-1-artur@conclusive.pl>
 <20250422175918.585022-2-artur@conclusive.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422175918.585022-2-artur@conclusive.pl>

On Tue, Apr 22, 2025 at 07:59:17PM GMT, Artur Rojek wrote:
> Add a documentation file to describe the Device Tree bindings for the
> Nordic Semiconductor nRF70 series wireless companion IC.
> 
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
> ---
> 
> v2: - rename the patch subject to comply with DT submission rules 
>     - fix a typo in reg property name and correct its indentation
>     - replace all gpio based properties as follows:
>       - irq-gpios with interrupts/interrupt-names
>       - bucken-gpios/iovdd-gpios with vpwr-supply/vio-supply
>     - clarify usage of said properties in their descriptions
>     - add a reference to spi-peripheral-props.yaml#
>     - specify unevaluatedProperties
>     - drop unused voltage-ranges property
>     - update bindings example accordingly w/ above changes
> 
>  .../bindings/net/wireless/nordic,nrf70.yaml   | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml b/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
> new file mode 100644
> index 000000000000..c9a41b61c624
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/nordic,nrf70.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/nordic,nrf70.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nordic Semiconductor nRF70 series wireless companion IC

What is a wireless companion? You miss description - see example-schema.

> +
> +maintainers:
> +  - Artur Rojek <artur@conclusive.tech>
> +
> +properties:
> +  compatible:
> +    const: nordic,nrf70
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: HOST_IRQ line, used for host processor interrupt requests.

Drop description, obvious.

> +
> +  interrupt-names:
> +    description: Name for the HOST_IRQ line. This must be set to "host-irq".
> +    const: host-irq

Drop interrupt-names, not really useful for one entry.

> +
> +  vpwr-supply:
> +    description: BUCKEN line, used for PWR IP state control.
> +
> +  vio-supply:
> +    description: IOVDD line, used for I/O pins voltage control. Optional.

Drop "Optional". Don't repeat constraints in free form text.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - vpwr-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#

Missing ref to ieee802/wireless devices schema (wireless recently
merged), assuming this is WiFi.

Neither commit msg nor description explains me what this is. Both
or at least one should.

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    reg_nrf70_buck: regulator-nrf70-buck {

Drop this node, not relevant.

> +        compatible = "regulator-fixed";
> +        regulator-name = "nrf70_buck";
> +        gpio = <&gpio2 24 GPIO_ACTIVE_HIGH>;
> +        enable-active-high;
> +    };
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        nrf7002@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

WiFi is usually "wifi".

Best regards,
Krzysztof


