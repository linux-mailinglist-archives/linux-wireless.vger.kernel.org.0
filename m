Return-Path: <linux-wireless+bounces-20612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44A5A6A17E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 09:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984C37B14C7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 08:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AAA215F49;
	Thu, 20 Mar 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7VOgy6t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CCB20FA90;
	Thu, 20 Mar 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459747; cv=none; b=hLfOPMWXk6UiY8Bu7G3OYX0LxvKpm+Spnl39s8IKXhMqE8fw8a/Al6y8gGbkWeqIIuPnRK2tTFmTZAXVxIQcdQlMH0ikz3I6ljiL2G/VktaQ2OL3Gb6igOpUSkszMh2ODn8j3oqUx5tLgwQ39+6l4VT6gUPxgtzPwVB9PiI2qFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459747; c=relaxed/simple;
	bh=Fi+/sL/HB7rD5Vc5usDgoiW1Oe/Vw1Swp0WgOewHlmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwMIEP08vAPjD1IiaonSdjCQFkoHQBsk654j+tU8A2Y/cACVCPvhCz3Llhj+W+C4ys1+5xrTQx5lu6ytDHodEzmMSDfmWNz7G4oxJW5+sMqvaHkOVOaJVHWVFux+ugLQjrq2majocsB91FZXbtuiMZC4dU+NKMTaiuesSQEeRC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7VOgy6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86DCC4CEEC;
	Thu, 20 Mar 2025 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742459747;
	bh=Fi+/sL/HB7rD5Vc5usDgoiW1Oe/Vw1Swp0WgOewHlmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7VOgy6tfCHbABO0CGULJ8EYynSLFNdNXzP9fKTvU1m8bbJpGSB45IUuELwoiHAI4
	 xano06wJvgouG9j4DOz/n3Ky9fWtqyk5OZhxDLsLQ57SkvKKKtHLdJIORsgn0aq8X/
	 y8fGoAVEgz6Fm/HidSov+MV1J/ayJ/Mu83lIwfreV+QKmq7vicrjsVu1oJXxnxu0J/
	 ZyM/H0tBOkXUANONwi15x+Jkp46/hgn//TEDiYetlfeM/4dhERsBPXDYKOPZEPc4rz
	 0sKXXtevId7M+aiRNJPd/UVEibDBP5C6Qti1+czXqJKJTzvGz0D64CramVwLnUR4g/
	 haA06zXU99XUA==
Date: Thu, 20 Mar 2025 09:35:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
	=?utf-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>, 
	Mailing List <devicetree-spec@vger.kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v4 1/5] dt-bindings: net: Add network-class schema for
 mac-address properties
Message-ID: <20250320-cocky-proficient-alligator-5da8a2@krzk-bin>
References: <20250319-dt-bindings-network-class-v4-0-2329336802b4@ixit.cz>
 <20250319-dt-bindings-network-class-v4-1-2329336802b4@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319-dt-bindings-network-class-v4-1-2329336802b4@ixit.cz>

On Wed, Mar 19, 2025 at 08:42:46AM +0100, David Heidelberg wrote:
> From: Janne Grunau <j@jannau.net>
> 
> The ethernet-controller schema specifies "mac-address" and
> "local-mac-address" but other network devices such as wireless network
> adapters use mac addresses as well.
> The Devicetree Specification, Release v0.3 specifies in section 4.3.1
> a generic "Network Class Binding" with "address-bits", "mac-address",
> "local-mac-address" and "max-frame-size". This schema specifies the
> "address-bits" property and moves the remaining properties over from
> the ethernet-controller.yaml schema.
> 
> The "max-frame-size" property is used to describe the maximal payload
> size despite its name. Keep the description from ethernet-controller
> specifying this property as MTU. The contradictory description in the
> Devicetree Specification is ignored.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Incorrect DCO chain, missing SoB.

...

> +  - Devicetree Specification Mailing List <devicetree-spec@vger.kernel.org>
> +
> +properties:
> +  address-bits:
> +    description:
> +      Specifies number of address bits required to address the device described

"Specifies number of address bits required to address the device
described by this node, e.g. size of the MAC address."

And drop the second sentence.

> +      by this node. This property specifies number of bits in MAC address.
> +    default: 48
> +    const: 48
> +

...

> +  mac-address:
> +    description:
> +      Specifies the MAC address that was last used by the boot program. This
> +      property should be used in cases where the MAC address assigned to the
> +      device by the boot program is different from the
> +      local-mac-address property. This property shall be used only if the value
> +      differs from local-mac-address property value.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 6
> +    maxItems: 6
> +
> +  max-frame-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Maximum transfer unit (IEEE defined MTU), rather than the
> +      maximum frame size (there\'s contradiction in the Devicetree
> +      Specification).
> +
> +

Just one blank line

> +additionalProperties: true
> 

Best regards,
Krzysztof


