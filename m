Return-Path: <linux-wireless+bounces-20519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931FA67F42
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CEE189E854
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F9B206F05;
	Tue, 18 Mar 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBwDRNxy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B182066DE;
	Tue, 18 Mar 2025 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335623; cv=none; b=C5/bld6yutpeJT4YVjZIE5MtX7uYzesVzBooZ2gv3rgFOh4SPfeMqQCAepKZx0k7r1mgJZGjg1gLs/DBSHqEsOq/rxJx667159/CPzUaTxdacMJS/GHU2TIDT9rZWi6ClQ6J/L2ozywxuy3Yp4z22klwrH9FbTubPPQF/P4wLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335623; c=relaxed/simple;
	bh=/F+eMjf09bz3lPIlV/WM3Lmoavh7yN9o2aVbStuR26w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIS7YC39hvx7+8Qwnwd/I1Tu6BfTb2dTfuREvspcqdoAO4zeZCnjspJOfmLOMj6d7ba+0tVD/CP6Icz5wUtnaaGgv1SD7Ts2OLBEW5JunJtxGvIycTbfDM0q98UxKKYbpmconCUojEsbPqk8MAGYhA8PotXEjYbSA/2ewUh/gF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBwDRNxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A3BC4CEDD;
	Tue, 18 Mar 2025 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335622;
	bh=/F+eMjf09bz3lPIlV/WM3Lmoavh7yN9o2aVbStuR26w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBwDRNxyZ7N0LFxdtECH8fvhZ3Etd/uF13wwbH0mLDIqmP3BY+Jz1hmoMPmEIWsGs
	 v989msItBTP3aKm9XfwXaw8bgvVNP4YuwIjAtwzqhsGo4kw2AqTyt9vjq8XTEIDbOJ
	 AxG8VJEfrP3bDQtlvGB/FwpaNDuR0IxKYqB9DvSEBKmpUJESgbNZP+ICCpN15IjgxZ
	 /KWoDEYmgioC/8s0oIuExFJDDaekOv8mmuFJAwS9my+xUFr3F22CZ9drz1j8xoqlnz
	 KzMcCOXqSKJD4lFJTT5/cdqbWAQuWp8M0t2dQywreamAzKxpIXer+/3lHMlMwcftM2
	 reFyFWoyL4bhA==
Date: Tue, 18 Mar 2025 17:07:00 -0500
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	van Spriel <arend@broadcom.com>,
	=?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v3 1/5] dt-bindings: net: Add network-class schema for
 mac-address properties
Message-ID: <20250318220700.GA4018133-robh@kernel.org>
References: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
 <20250318-dt-bindings-network-class-v3-1-4d8d04ddfb61@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-dt-bindings-network-class-v3-1-4d8d04ddfb61@ixit.cz>

On Tue, Mar 18, 2025 at 08:56:44PM +0100, David Heidelberg wrote:
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
> ---
>  .../bindings/net/ethernet-controller.yaml          | 25 +-----------
>  .../devicetree/bindings/net/network-class.yaml     | 44 ++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> index 45819b2358002bc75e876eddb4b2ca18017c04bd..c91b41b83d1dc1294e99ec72c7cdcc16550cb33e 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> @@ -16,30 +16,6 @@ properties:
>    label:
>      description: Human readable label on a port of a box.
>  
> -  local-mac-address:
> -    description:
> -      Specifies the MAC address that was assigned to the network device.
> -    $ref: /schemas/types.yaml#/definitions/uint8-array
> -    minItems: 6
> -    maxItems: 6
> -
> -  mac-address:
> -    description:
> -      Specifies the MAC address that was last used by the boot
> -      program; should be used in cases where the MAC address assigned
> -      to the device by the boot program is different from the
> -      local-mac-address property.
> -    $ref: /schemas/types.yaml#/definitions/uint8-array
> -    minItems: 6
> -    maxItems: 6
> -
> -  max-frame-size:
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -    description:
> -      Maximum transfer unit (IEEE defined MTU), rather than the
> -      maximum frame size (there\'s contradiction in the Devicetree
> -      Specification).
> -
>    max-speed:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> @@ -262,6 +238,7 @@ dependencies:
>    pcs-handle-names: [pcs-handle]
>  
>  allOf:
> +  - $ref: /schemas/net/network-class.yaml#
>    - if:
>        properties:
>          phy-mode:
> diff --git a/Documentation/devicetree/bindings/net/network-class.yaml b/Documentation/devicetree/bindings/net/network-class.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e126a02193e8cfba24215d3c850fde1e1b26480e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/network-class.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/network-class.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Network Class Common Properties
> +
> +maintainers:
> +  - Devicetree Specification Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Just 'devicetree-spec@vger.kernel.org'

> +
> +properties:
> +  address-bits:
> +    description:
> +      Specifies number of address bits required to address the device described
> +      by this node. This property specifies number of bits in MAC address.
> +    default: 48
> +    const: 48
> +
> +  local-mac-address:
> +    description:
> +      Specifies MAC address that was assigned to the network device described by
> +      the node containing this property.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 6
> +    maxItems: 6
> +
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
> +      Maximum transfer unit (IEEE defined MTU).

Can we keep the rest of the description about the contradiction?

> +
> +additionalProperties: true
> 
> -- 
> 2.49.0
> 

