Return-Path: <linux-wireless+bounces-32292-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG3cJSh5oWkJtgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32292-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:59:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F91B64CD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A784E3038178
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4443E8C56;
	Fri, 27 Feb 2026 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9tdEDET"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869230DEB6;
	Fri, 27 Feb 2026 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189989; cv=none; b=F0CSR4d7h/fBWDesS8YJ7fsZbcH31BK1R1e14LxSycveXSALPQRhytOZ4bVhxEf4L2uhZ8w/Q8fu/eiTWb9a7XeS2GJqgfuvbrb6SAcNvA3u4XDHEA0t3kavcBkoYkGLNl78oXjs/ZEDMFuxIl+fPGwWXvqPnds7vyYpg0z+kBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189989; c=relaxed/simple;
	bh=wkJ5RuzZH0+Wm4aElEWFBfNrf7P5f8EnVB3C/GucRVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4xAlpdiN4VS66CUcgfFjzM0L/UEEtMzCc4yFBWvLQlEi5/bmMW8gdIPGkh+hilQF4Cwp2UPXxb3URg9OaK84l2U2yuzOt8d8NmQpFbiS+Gme4wG9jMN5WtaKNC9y8Ui1DSEOwhCjjU8HNc49gjzBlK+PXEGrLM8KGBLZ0Op6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9tdEDET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54FAC116C6;
	Fri, 27 Feb 2026 10:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772189989;
	bh=wkJ5RuzZH0+Wm4aElEWFBfNrf7P5f8EnVB3C/GucRVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9tdEDETLvc41sO7tHmzTRpFmIhjfQ7tT88YNcF1JpwqDeSmZT7/K8XZaC/bgKp8z
	 Th2D0V1v/2sot3wYVNBLTHLoVzc0+cYMl6cr1AaQ7f9/orKqWvvB4R6CFRgxEh0lfi
	 Qsu59wnCdNCrTWeOFWh4RlfGuU/i1KMhVv2l+hZUvZeVLOc9x7Np4dos/Q+3Ke+aFp
	 19QmuQczmSY83vM0Kfc9ynlQm4K7TLIQaUX7YcbrkVi3YUX+AzheAYd0TZXYYJn7EW
	 UvJ/wex6Vgb+cI0ZauaG4buyaqKeHJokhy4mmae2t1N0oeUIYxTq9fyqqJ76HhSy/t
	 vWdi3F8J7Dh0Q==
Date: Fri, 27 Feb 2026 11:59:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, 
	Dan Callaghan <dan.callaghan@morsemicro.com>, Arien Judge <arien.judge@morsemicro.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 32/35] dt-bindings: net: wireless:
 morsemicro: add mm81x family
Message-ID: <20260227-notorious-naughty-condor-8a7b5f@quoll>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
 <20260227041108.66508-33-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227041108.66508-33-lachlan.hodges@morsemicro.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32292-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,morsemicro.com:email,devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: EE2F91B64CD
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 03:10:42PM +1100, Lachlan Hodges wrote:
> Add dt-bindings describing the Morse Micro mm81x family of
> chips.

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

> 
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> ---
>  .../net/wireless/morsemicro,mm81x.yaml        | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml b/Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml
> new file mode 100644
> index 000000000000..653a7476cf8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/morsemicro,mm81x.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/morsemicro,mm81x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Morse Micro MM81x
> +
> +maintainers:
> +  - Lachlan Hodges <lachlan.hodges@morsemicro.com>
> +  - Arien Judge <arien.judge@morsemicro.com>
> +
> +description: >
> +  This node provides properties for configuring a Morse Micro MM81x device
> +  connected via SDIO. The node shall be specified as a child node of an SDIO
> +  controller.

Drop sentences, redunadnt. Explain the device/hardware, not the DT. We
all know how to construct DT.

> +
> +  It is recommended to declare a mmc-pwrseq on SDIO host above MM81x. Without

No. It is not. Drop,.

> +  it, you may encounter issues during reboot. The mmc-pwrseq should be
> +  compatible with mmc-pwrseq-simple. Please consult
> +  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml for more
> +  information.

Nothing here is relevant. You must explain the hardware, not quirks
specific to kernel.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: morsemicro,mm81x

What is 'x'? Wild-cards are not allowed, see numerous talks and writing
bindings.

> +
> +  reg:
> +    description:
> +      <reg> must be set to 2.

Why? No, drop description.

> +    maxItems: 1
> +
> +  wake-gpios:
> +    description: Phandle of gpio that will be used to wake up the chip. Powersave
> +      features disabled if property not present.
> +    maxItems: 1
> +
> +  busy-gpios:
> +    description: Phandle of a gpio that is used to indicate the chip has data
> +      ready.

Drop redundant "PHandle of a gpio that is". It cannot be anything else.
Same in the oter place.

OTOH, missing constraints/maxItems.

> +
> +required:
> +  - compatible
> +  - reg

You need $ref to wireless-controller.yaml.

> +
> +additionalProperties: false

and this becomes unevaluatedProperties

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    mm81x_pwrseq: mm81x_pwrseq {

Drop entire node, not really correct and not needed.

> +        compatible = "mmc-pwrseq-simple";
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&mm81x_reset>;
> +        reset-gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
> +    };
> +
> +    mmc {
> +        mmc-pwrseq = <&mm81x_pwrseq>;

Drop property irrelevant.

> +        #address-cells = <1>;
> +        #size-cells = <0>;


> +
> +        wifi@0 {

Not tested. You said before it has to be 2, not 0.

> +            compatible = "morsemicro,mm81x";
> +            pinctrl-names = "default";
> +            pinctrl-0 = <&mm81x_busy>, <&mm81x_wake>;
> +            reg = <2>;

Follow DTS coding style.

> +            wake-gpios = <&gpio 12 GPIO_ACTIVE_HIGH>;
> +            busy-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
> +        };
> +    };
> +...
> -- 
> 2.43.0
> 

