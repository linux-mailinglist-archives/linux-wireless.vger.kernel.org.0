Return-Path: <linux-wireless+bounces-8743-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE53901CB7
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 10:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE391C21B8C
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2024 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585455E53;
	Mon, 10 Jun 2024 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/xA20+5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0742056;
	Mon, 10 Jun 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007388; cv=none; b=AFBOAWIjNZLYBcojrlXun9CtK5Eix1zRM9YiElZj6w4lAusgKLQuw8VmkQadUKzs7w+jQfij0nwOSRC4nRnDafddshj6u7jpe7f1H6AKIeGlmYdGPyiAAONglW0XNwN+s1TNimE/uaW7VBSY+FGuVbrW73t1CnHU25Sh8qyQjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007388; c=relaxed/simple;
	bh=iJG9paNBMZPt8l4VAY32K2nphAQ0d4kuAbkyrwYCr9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkOw5UG+3DqAQ3/PqtEZd5o5nuRGViVTw2Fa/JqlyckuhBcSAj4ErkzjOgQfq21/XVebCnxQ+M/WZmKpKebw3Uu2F0+AfEZlR/Y3V/N5carWjjQY4pFVRuBTMStDh6gtUVOQQAFPCrk8x/WdJREh0ZoBx4pjoAAFiBM2DlqNQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/xA20+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDCCC2BBFC;
	Mon, 10 Jun 2024 08:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718007387;
	bh=iJG9paNBMZPt8l4VAY32K2nphAQ0d4kuAbkyrwYCr9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B/xA20+58yhxvsOmW9D633bQNjuuMJhKBIBlVyDng4GirPctaFHwZYn4uWtG68luw
	 8cnXsgtdLr0QH16nNKBp77hwAThJTddPhYEhVxFWTKylQNApQ1pPM4VjIlZZzQilm+
	 WfiGK2gK4hSvchHwC6slsOV2ur9PZN0oFdjXV7OoxC0JkT3xOX1VbTjZMajkpMo6UR
	 TSi8DpqQWFtr8zSqDW7ndqS6GtKqCgH2ccmSAJRvfxCt4i6kKOSGFAflPHDnn+s8x+
	 ow0+bivGhfvaQePpGSzhtzTbsIANtV7ngSnDlRdouMlaqU+kczPjFoUqTM4wxKHjgD
	 9Dvafjsae40gg==
Message-ID: <e7444ff4-763a-44c6-9a73-0c5f590ceaad@kernel.org>
Date: Mon, 10 Jun 2024 10:16:20 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/17] dt-bindings: net: wireless: cc33xx: Add
 ti,cc33xx.yaml
To: michael.nemanov@ti.com, Sabeeh Khan <sabeeh-khan@ti.com>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
 <20240609182102.2950457-18-michael.nemanov@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240609182102.2950457-18-michael.nemanov@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/06/2024 20:21, michael.nemanov@ti.com wrote:
> From: Michael Nemanov <michael.nemanov@ti.com>
> 

Missing commit msg (explain the hardware), missing SoB.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

> ---
>  .../bindings/net/wireless/ti,cc33xx.yaml      | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
> new file mode 100644
> index 000000000000..08ab2ed93dba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/ti,cc33xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments CC33xx Wireless LAN Controller
> +
> +maintainers:
> +  - Michael Nemanov <michael.nemanov@ti.com>
> +
> +description:
> +  These are dt entries for the IEEE 802.11ax chips CC33xx from Texas Instruments.

Describe hardware not "dt entries, regardless of what "dt entries" are.

> +  Currently, these chips must be connected via SDIO.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,cc3300
> +      - ti,cc3301
> +      - ti,cc3350
> +      - ti,cc3351
> +
> +  reg:
> +    description:
> +      For WLAN communication, <reg> must be set to 2.

And for other cases it can be something else? What else could it be if
not a WLAN controller (description says WLAN)

> +    maxItems: 1
> +
> +  interrupts:
> +    description: The interrupt line. Can be IRQ_TYPE_EDGE_RISING or IRQ_TYPE_LEVEL_HIGH.
> +      When SDIO is used, the "in-band" interrupt provided by the SDIO bus is used
> +      unless an interrupt is defined in the Device Tree.

Does not look wrapped at 80 (see coding style).

I don't understand the comment. You describe SDIO interface here, so how
it could be conditional "when SDIO is used"? What is the other case?
This binding has so many weird statements.

Describe *fully* hardware, not your drivers.

> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

additionalProperties instead... or this is somehow incomplete
(properties, $ref?).

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    // SDIO example:
> +    mmc3 {

mmc

> +        vmmc-supply = <&wlan_en_reg>;
> +        bus-width = <4>;
> +        cap-power-off-card;
> +        keep-power-in-suspend;

Drop all these, not relevant.

> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cc33xx: cc33xx@0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Drop unused label

> +            compatible = "ti,cc3300";
> +            reg = <2>;
> +            interrupts = <19 IRQ_TYPE_EDGE_RISING>;
> +        };
> +    };

Best regards,
Krzysztof


