Return-Path: <linux-wireless+bounces-37173-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BWjHGnPGmo59AgAu9opvQ
	(envelope-from <linux-wireless+bounces-37173-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 13:52:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F16E60CA55
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 13:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF323037EC5
	for <lists+linux-wireless@lfdr.de>; Sat, 30 May 2026 11:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDA83ACEFE;
	Sat, 30 May 2026 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BomKkdOS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50863955D3;
	Sat, 30 May 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141804; cv=none; b=s6tpCrAcZSjwLQsZFZKuDGgJmlEaroaSkiQi+wW83do7iNQjDxBTpucU8n90IRikAI5TwEafkJcww1jSUa/FJPfklHLIggTnf/MiITv7p63e+15oknpCVM+ptYzsGCoMct3TTaklHG2/QQaEEW4+A7CIyyqrRD3178BgyLt3u5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141804; c=relaxed/simple;
	bh=1GPghIQVAUeI8K2DXi3bxs3ZioulkywxwVAgcohx/34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ4ka9MINn7Hl8uitB8zY+MLTQgJ5IrH62XING408C+zCkAgW2n6mV/4xT96PJ04gEw1PNWe4j0pmlxrlHKbzPbWUOWrGTEeGJ3HbZnPvpZmaN11+ZkGS4RkhZr574w2pUIPjGzwiDCC4zgsrjc/jnJm/m3wllyXfbVOL4D6nl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BomKkdOS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CC61F00893;
	Sat, 30 May 2026 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141803;
	bh=7vDykY6wQIKMdW6dV3P8fQxfFzf8xBVMvGruxgzJYjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BomKkdOS8U8MIU8eMNBY7sVB3hoVc9VJdkUjmVI3Ac/HBqLwxMkwxJfQKMT7I0GhG
	 PP/RJvxlbgg+ZksCjj7KIoerTnJSyEi8/NeczDaF/9waIol9F9+HfxDHFMIyJLVbhE
	 EudTXcRQHdwkVp8Ci/ssK3UqLKiDDwrkqOIC9wfbmr+iTuoMKAanuYAamAI+CGbWc2
	 QzLxk4Z9/2Mzrgav4rnMLX3xNdtSh5C5yUERXBfv/+7VkG6nl5248DpaP33yLTTCnY
	 +MRHeO4CrdNqahhc6KqEeXa3t3lO9L1+eGChXEx3vZBAkbzqU6x5Fw1P6/6Zqc48y9
	 jPHMIL4cG3xNw==
Date: Sat, 30 May 2026 13:50:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alessio Ferri <alessio.ferri@mythread.it>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: bus: add brcm,bcm6362-wlan
Message-ID: <20260530-psychedelic-cyber-seagull-140adf@quoll>
References: <20260529-add-bcm6362-wlan-v1-0-722242777f58@gmail.com>
 <20260529-add-bcm6362-wlan-v1-3-722242777f58@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529-add-bcm6362-wlan-v1-3-722242777f58@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37173-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,pengutronix.de,broadcom.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mythread.it:email]
X-Rspamd-Queue-Id: 1F16E60CA55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 02:06:01AM +0200, Alessio Ferri wrote:
> Document the binding for the SHIM bridge that gates the on-chip
> 2.4 GHz WLAN block of the Broadcom BCM6362 SoC. The bridge owns the
> SHIM peephole, a single clock for the macro, and two resets (the
> SHIM macro itself and its ubus side). It is also a bus: it carries
> one brcm,bus-axi child describing the bcma backplane behind the
> SHIM, with a standard interrupt-map routing the d11 core's IRQ to
> the SoC interrupt controller.
> 
> Assisted-by: Claude:claude-4.8-opus
> Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
> ---
>  .../devicetree/bindings/bus/brcm,bcm6362-wlan.yaml | 106 +++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/bus/brcm,bcm6362-wlan.yaml b/Documentation/devicetree/bindings/bus/brcm,bcm6362-wlan.yaml
> new file mode 100644
> index 000000000000..c8d49ccdd2c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/brcm,bcm6362-wlan.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/brcm,bcm6362-wlan.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM6362 on-chip WLAN SHIM bridge
> +
> +maintainers:
> +  - Alessio Ferri <alessio.ferri@mythread.it>
> +
> +description: |
> +  The BCM6362 SoC integrates a 2.4 GHz Broadcom WLAN block whose
> +  register backplane uses the Broadcom AMBA (bcma) architecture. The
> +  backplane is gated by a small SHIM bridge that holds the WLAN macro
> +  in reset and disables its clocks until released by software. CFE
> +  does not release this block, so software bring-up is required
> +  before bcma can enumerate the backplane.
> +
> +  This binding describes the SHIM bridge node. The SHIM driver brings

Do not describe binding. Do not describe driver.
Describe hardware.

> +  the macro up and then populates the brcm,bus-axi child node, which
> +  describes the bcma backplane behind the SHIM and is bound by the
> +  bcma-host-soc driver. The SoC-specific configuration (big-endian
> +  accessors, SHIM-attached topology, SHIM Control register peephole
> +  pointer) is delivered to bcma via platform_data injected at
> +  populate time, so the brcm,bus-axi child stays SoC-agnostic.

How is it relevant?

> +
> +properties:
> +  compatible:
> +    const: brcm,bcm6362-wlan
> +
> +  reg:
> +    maxItems: 1
> +    description: SHIM peephole registers.

What is SHIM?

> +
> +  reg-names:
> +    items:
> +      - const: shim
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: SHIM macro reset
> +      - description: SHIM ubus reset
> +
> +  reset-names:
> +    items:
> +      - const: shim
> +      - const: shim-ubus
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^axi@[0-9a-f]+$":

Use consistent quotes.

> +    type: object
> +    description: The bcma AXI backplane behind the SHIM.
> +    $ref: /schemas/types.yaml#

Need proper ref. You could easily check instead of sending Claude slop -
is there any binding with above syntax?

You don't get subnodes for buses for devices not being the actual
buses.

Best regards,
Krzysztof


