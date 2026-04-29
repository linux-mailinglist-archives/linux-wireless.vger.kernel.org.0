Return-Path: <linux-wireless+bounces-35579-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C59ADS/8WkbkQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35579-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:20:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA34911BD
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 10:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C3FC302497D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E53ACA71;
	Wed, 29 Apr 2026 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebkt1+a0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32122342CB4;
	Wed, 29 Apr 2026 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450757; cv=none; b=FaXJWZPi5LmQFtwEIp+Cc+/rQymLbyoHVJCv7Wv72OhH1/pEymXGFs1I9ZMKUiRifvh7cOlV00Dcs1ORrnIlZReA7fMpYGVQjrd0uutGsMvcDx9zRheT+lf2uWYaW3uDTeoSXWDIaornbQxalNnqkj+cqOhhLG5yDLoa2vzpOzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450757; c=relaxed/simple;
	bh=IDu8gLXSNTp3NrOI27W68qJX6hYnnDVK6G1TVmyYnW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iN2zRs0snu3seuaDUUYc8QjiIirawnbxGvofp1odZEKiQ1YMdSBui5NhCUbY+jxnjmZ/solGr5xvglYue5Etb8MeGGWGgZScbgikNhHV21Fhir8Z+Z+gkXb6BR6ScTsxz0hv/T9yIkmm1gMkcNIQVOZNwyYg5NWPkwgrUL63x5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebkt1+a0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088A9C19425;
	Wed, 29 Apr 2026 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777450756;
	bh=IDu8gLXSNTp3NrOI27W68qJX6hYnnDVK6G1TVmyYnW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ebkt1+a0YcUGTorkmsmxt3mJ9QJm2/Jn1TxixTGWMuS5BspBsorquoLHJMacbqc6s
	 fCL/I7K+eZLQrKSdQbi9Ort9jQd5aI9Ccb4IwhQKlO9CesR5KWt4mt1KJ6n9mgO5dj
	 +IkeNbRP2IfcBnzVqXsLN+SXnfYMYUJplL1mSIdlB9MNXWau7feByOb/tNOY6+AJyo
	 vVDlzTthubcUmZjG6nFjP/jaiqYYOAhfMG4iMaXUdMKjnYB2BeJTZqb17Y3b2/XWf9
	 OHWPlUM9cGMbPLQE1UIte5q3kFoYO9KVr43aMGVmVJ0GY3qikgw55RxZHkFD6FJGZ7
	 wmddZc6CCgRAw==
Message-ID: <4fda911e-df77-43bd-9248-e55ed587d040@kernel.org>
Date: Wed, 29 Apr 2026 10:19:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: net: wireless: intel,iwlwifi: add
 binding
To: Avinash Bhatt <avinash.bhatt@intel.com>, devicetree@vger.kernel.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 johannes@sipsolutions.net, miriam.rachel.korenblit@intel.com,
 kobi.guetta@intel.com, emmanuel.grumbach@intel.com
References: <20260429081403.46087-1-avinash.bhatt@intel.com>
 <20260429081403.46087-2-avinash.bhatt@intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20260429081403.46087-2-avinash.bhatt@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7CBA34911BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35579-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

On 29/04/2026 10:14, Avinash Bhatt wrote:
> Add a devicetree schema binding for Intel discrete Wi-Fi 7 BE200 PCIe
> adapters.

Why? Where is any user of that?

> 
> The binding documents OEM platform configuration properties for
> platforms that use Device Tree instead of platform firmware
> methods. All properties mirror the existing equivalents in
> structure and semantics, covering SAR power limits (intel,wrds),
> 6 GHz AP type support (intel,uats), static power limit
> (intel,splc), channel puncturing (intel,wcpe), 320 MHz per-MCC
> enablement (intel,wbem), ETSI SRD channel configuration
> (intel,srd), 6-7 GHz UHB country enable bitmask (intel,6e-uhb),
> and additional regulatory override properties.
> 
> Signed-off-by: Avinash Bhatt <avinash.bhatt@intel.com>
> ---
>  .../bindings/net/wireless/intel,iwlwifi.yaml  | 445 ++++++++++++++++++
>  1 file changed, 445 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
> new file mode 100644
> index 000000000000..d97be6cc35d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/intel,iwlwifi.yaml
> @@ -0,0 +1,445 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2026 Intel Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/intel,iwlwifi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel iwlwifi PCIe Wi-Fi devices
> +
> +maintainers:
> +  - Avinash Bhatt <avinash.bhatt@intel.com>
> +  - linux-wireless@vger.kernel.org

Drop this one.

> +
> +description:
> +  Intel iwlwifi IEEE 802.11be discrete Wi-Fi adapters connected over PCIe.

Please wrap code according to the preferred limit expressed in Kernel
coding style (checkpatch is not a coding style description, but only a
tool).  However don't wrap blindly (see Kernel coding style).

> +  These bindings provide OEM platform configuration for platforms that use Device Tree.

Drop. Describe hardware.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - pci8086,272b
> +

...

> +
> +  intel,activate-channel:
> +    description: |
> +      Indoor channel activation bitmask. Sets specific frequency bands to
> +      active (rather than passive or disabled) when the platform is
> +      confirmed to be operating indoors.
> +
> +      Layout (2 cells):
> +        [0] revision - structure revision, must be 0x00
> +        [1] bitmap   - per-region indoor activation flags:
> +                       bit 0 = enable EU U-NII-1 (5.2 GHz) for indoors only
> +                       bit 1 = enable Japan U-NII-1 (5.2 GHz) for indoors only
> +                       bit 2 = enable China Mainland U-NII-1 (5.2 GHz) for indoors only
> +                       bit 3 = enable USA U-NII-4 (5.9 GHz) for indoors only
> +                       bit 4 = enable WW U-NII-1 (5.2 GHz) for indoors in any
> +                               country where the band is permitted
> +                       bit 5 = enable Canada U-NII-4 (5.9 GHz) for indoors only
> +                       bit 6 = enable USA + Canada + WW U-NII-4 (5.9 GHz) for
> +                               indoors only
> +                       bits 7-31: reserved, must be 0
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 2
> +        maxItems: 2
> +        items:
> +          - const: 0
> +
> +  intel,force-disable-channels:

I don't see how this is a DT property. Actually most of the properties
do not look either. Do you want to say, that if I go with my device from
EU to US on a business trip, I will need to recompile DTB? Obviously no...

Best regards,
Krzysztof

