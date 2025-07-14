Return-Path: <linux-wireless+bounces-25354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E07EB037E8
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039433B5408
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 07:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C03223183B;
	Mon, 14 Jul 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngJOi6bp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61A3D76;
	Mon, 14 Jul 2025 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478076; cv=none; b=Ppa1MGDIPkAEpCd5w13YR1NHPCCkYAtOCtf5MAXH/3axI760uuI8/oYKAaebXkIwc0pDQ0esdCmxfAtgNeqlFiEQcbmwH76ItEqEJuwDshYcOanscsxPsE3HFO4LGxOGm2b0YUOhoyxfxHg+EvBU98+m3DM1eVZ2fWfR8yk2ylw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478076; c=relaxed/simple;
	bh=l9FcnN3Nw017Y5jMw/hRFAK60tqYcHmO+80ILEr7bjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpJplDjygGi+/UkI6njceEdotiyTay7H/CetU2M3PsUBOgFrso2fp0m0dPOjyoCKhA9l47msWQyG64QasFPhGXzueVvZt0J2xGjYUoSD2bXBKXqxyOep/Nbu+vd1KhDdfi86pQ7mDPw0B3BTmM9DzGrjXMN8t96KjxckEH4BrcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngJOi6bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09F4C4CEED;
	Mon, 14 Jul 2025 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752478075;
	bh=l9FcnN3Nw017Y5jMw/hRFAK60tqYcHmO+80ILEr7bjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ngJOi6bps7q2MoH8KD+x/OCUoGWmHrKwsJt0uiO0jeK+fTy4I+fZwawX4oEfxak2r
	 3zgZ2BT5ed2pg4NjE7pCCM5ZLAG30XmA0Q+9FrBR8DOOSNyXokxXNL8+yOo99yINCb
	 nPgWFplMQAHiLP/PZ3PaSMdrozNaloMWSbN/vHxBX0ZM/WvyViTkW2waWtfMU3Rs2S
	 aIRCSY6P+xiVnff8WPiJx89Fk3tKbTVvisetP+2dN6De+ba8vTou1irMP+qQB7Eq9M
	 /NkosTtfAoYlwTtIs9h6jfAMJdJLsWknWS6O/pNaCEM4NnhwV+RP009Nf9Q5xC52RM
	 CglfckzaVy5cg==
Date: Mon, 14 Jul 2025 09:27:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCHv4 wireless-next 7/7] dt-bindings: net: wireless: rt2800:
 add
Message-ID: <20250714-subtle-origami-gopher-c9099f@krzk-bin>
References: <20250712210448.429318-1-rosenp@gmail.com>
 <20250712210448.429318-8-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250712210448.429318-8-rosenp@gmail.com>

On Sat, Jul 12, 2025 at 02:04:48PM -0700, Rosen Penev wrote:
> Add device-tree bindings for the RT2800 SOC wifi device found in older
> Ralink/Mediatek devices.

Your subject was cut. Probably you wanted something like add "Realtek foo adapter" etc.


> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/ralink,rt2880.yaml  | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml b/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
> new file mode 100644
> index 000000000000..a92aedf6ba01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wireless/ralink,rt2880.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wireless/ralink,rt2880.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ralink RT2880 wireless device
> +
> +maintainers:
> +  - Stanislaw Gruszka <stf_xl@wp.pl>
> +
> +description: |
> +  This node provides properties for configuring RT2880 SOC wifi devices.
> +  The node is expected to be specified as a root node of the device.
> +
> +allOf:
> +  - $ref: ieee80211.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ralink,rt2880-wifi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg

Why clocks are optional? SoC devices rarely work without a clock.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


