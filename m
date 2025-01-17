Return-Path: <linux-wireless+bounces-17633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76871A14B87
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 09:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A42169009
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF081F91DA;
	Fri, 17 Jan 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcCaU9Nm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDB1F754C;
	Fri, 17 Jan 2025 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737104194; cv=none; b=qpCCwADHNiPicxCMUOu71bTJANA3xx0gegDFRb2w8nlz/LbcYPp0ADxS2e5RHTuU97ZcaOq0orqxY3ibjnLONHkAI+al0NF79lGeCzODGmh3aUdb2lV5vb1ZIXsnzg+9KGiErmMOKycxR9uMt3BqOAEUID0P9m9iH5l+yM/ZmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737104194; c=relaxed/simple;
	bh=AGecMXknwWlOL9Fox1ctaYE4gI/yBsQgeqsHWg2+DSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDBC/+GQwuOMJF2Ladm76IoVBxF6U9B/fUCpQ9CBGMRvdKl6zv74zfpePydYJ1TdhDxcPjJeb1An8qpl4yoqdXwJlqPXO3c9r5utUXnlvfeeyzekn7SyGTMydnYMFfKVypf8nT80hKjST7mFNJ44u+SFu8oqZ2ABOhcUW3wT4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcCaU9Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B97AC4CEDD;
	Fri, 17 Jan 2025 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737104193;
	bh=AGecMXknwWlOL9Fox1ctaYE4gI/yBsQgeqsHWg2+DSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcCaU9Nmz4y5WH7lpnIvowjmu7oCMjtxBlat7dk/JvMGcs600tqqVY/k/ZHhSeLXJ
	 VtqieNWVdwh6gDxSVHu6SyRCE08GStGeVbsy52i9rqWgKw9qzdN/NUlQasatf+3pww
	 rDXlePwqtFDbgNiyfX6FGlajRPlybQjQ5Y8WmnDj8gz97R/29KNeVkEIKgkQZj1YMo
	 I/qszuDnBTihO2kjjZKFbzqWlZ6BksjP4POnno1dBFLU3ekv6ZU4wAV8tihlui9Etf
	 Xg7RymFER80RGn+G+1zdMkvfh2kFP1wm56gobVaNcMfTtOD2bXobdt8tRgo3wTP8En
	 Kj1QvaLdI6iBQ==
Date: Fri, 17 Jan 2025 09:56:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, johannes@sipsolutions.net, p.zabel@pengutronix.de, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, m.felsch@pengutronix.de, 
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: rfkill-gpio: enable
 booting in blocked state
Message-ID: <20250117-truthful-reindeer-of-perception-496bd4@krzk-bin>
References: <20250116084702.3473176-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116084702.3473176-1-catalin.popescu@leica-geosystems.com>

On Thu, Jan 16, 2025 at 09:47:01AM +0100, Catalin Popescu wrote:
> By default, rfkill state is set to unblocked. Sometimes, we want to boot
> in blocked state and let the application unblock the rfkill.
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
> ---
> Changes in v2:
>  - change "default-blocked" type from boolean to flag
> ---
>  Documentation/devicetree/bindings/net/rfkill-gpio.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
> index 9630c8466fac..4a706a41ab38 100644
> --- a/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
> +++ b/Documentation/devicetree/bindings/net/rfkill-gpio.yaml
> @@ -32,6 +32,10 @@ properties:
>    shutdown-gpios:
>      maxItems: 1
>  
> +  default-blocked:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: configure rfkill state as blocked at boot

I am assuming rfkill does not have third state possible, so it is only
off or on.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


