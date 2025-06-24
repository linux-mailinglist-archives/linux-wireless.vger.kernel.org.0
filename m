Return-Path: <linux-wireless+bounces-24438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90389AE6BD5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 17:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6141884D25
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC2226CE38;
	Tue, 24 Jun 2025 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xjRtACEv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C533074AB;
	Tue, 24 Jun 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750780164; cv=none; b=MC0Hq0lP5pgiv38HVnRvyO9EdW7aCuHjMNcUMxYKZ4QbxbmgrcCs++noTznGL+Gnk8Ec+AwF6P2kca4Gk74kMbqsuUV358nB0kjVhwUxp7ylT/PrgETCW+sXM8aYbLhizHboPfIhHZVMI1nxSE0sGaCbVf8UhGW7gCos5k5cqqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750780164; c=relaxed/simple;
	bh=pyxJ7ud+kjbdNvW2uXFRaAIrAf9EGxpqJXKFFji+p3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESNynOO7rw+/pkIdvkXgpyvOzDwiDvA5X7Em/r8XKrCD2LlIoOT8C6Af9AUf15OAwGag92FZ4DKphgIrAsb5pS+hA5Y133Y+5jT7yoYFBm3hQhKol1/y0ujzcMOpO4RjuqacgFNWCxTmt3OjSjUBk8O7KDGFu8M4g71g4V3zTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xjRtACEv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NC+Z+vtbqTE2wdY8oV+vDfRJsWQwJyP1Pyl6O0epnbE=; b=xjRtACEvl6eV5FI1xUgMckMQpo
	9Fc5LBJ9cgBrsFS1dsmgUoYw2EVzvzLwmtlUDvuxHBarguhAvPuPghRXpc2KQSqe3TftMKsYpEAdH
	5wzPHGN8lrZKA1CSj9MDpA1AuWKbvMH7XhmxQlxJf+94/QheSfIM4DRo6IKdHsV/BLm0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uU5tY-00GoYg-R2; Tue, 24 Jun 2025 17:49:12 +0200
Date: Tue, 24 Jun 2025 17:49:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: mgreer@animalcreek.com, krzk@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, conor+dt@kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	martijn.de.gouw@prodrive-technologies.com
Subject: Re: [PATCH v2 1/2] dt-bindings: net/nfc: ti,trf7970a: Add
 ti,rx-gain-reduction option
Message-ID: <cf871c23-963a-4d50-a13b-97e84ee0ddb7@lunn.ch>
References: <20250624124247.2763864-1-paul.geurts@prodrive-technologies.com>
 <20250624124247.2763864-2-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624124247.2763864-2-paul.geurts@prodrive-technologies.com>

On Tue, Jun 24, 2025 at 02:42:46PM +0200, Paul Geurts wrote:
> Add option to reduce the RX antenna gain to be able to reduce the
> sensitivity.
> 
> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> ---
>  Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> index d0332eb76ad2..066a7abc41e0 100644
> --- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> +++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
> @@ -55,6 +55,12 @@ properties:
>      description: |
>        Regulator for supply voltage to VIN pin
>  
> +  ti,rx-gain-reduction:

You should include the units, "ti,rx-gain-reduction-db"

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Specify a RX gain reduction to reduce antenna sensitivity with 5dB per
> +      increment, with a maximum of 15dB.

Given that description i think you can provide a list of values, [0,
5, 10, 15] and the tools will validate values in .dts files.

> +
>  required:
>    - compatible
>    - interrupts
> @@ -95,5 +101,6 @@ examples:
>              irq-status-read-quirk;
>              en2-rf-quirk;
>              clock-frequency = <27120000>;
> +            ti,rx-gain-reduction = <3>;

Err, how does 3 fit into 5dB increments?

	Andrew

