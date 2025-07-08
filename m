Return-Path: <linux-wireless+bounces-24967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128ABAFD54F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95897B3432
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E662E6133;
	Tue,  8 Jul 2025 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFw/wHdf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A721F91C8;
	Tue,  8 Jul 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995579; cv=none; b=bGzPJh+D4dWqrvM4qRgj1hCdB5chNjC9Qb1gtwGeOT7uP0Hx8pBHz3P137dmoudjvPh5FPgHTUZujwV5nx0uPhYl+kp2V6OPDkBXnkWvE/OH5gQjHcFCWOUNonDdIy9F+QvI+vp1OOuksUrB7wJaHcUnqa0KI58hkifmc66jR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995579; c=relaxed/simple;
	bh=fJILDueUEjK1dWENyz4SRN/UW44yJYaq1wT+gnm6WdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmXnhDWgAOi36rvlo8PM6aag/ZOOkZ1O9/8kzQtymnJZEDuILMUOGWx6zwD7efl9zhZ/As/cDvhEZRCn2HT2QjAuHCUg6MHEQlWN7NlqAM/hruWdvaADRL9fKFu3eRofk4qXKnPIJy6LW/OYA+MPjGAJK506Llw6VkJqSsdlT24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFw/wHdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A413C4CEED;
	Tue,  8 Jul 2025 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751995578;
	bh=fJILDueUEjK1dWENyz4SRN/UW44yJYaq1wT+gnm6WdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFw/wHdfocNj2jY7Eezz11+Mf/77AW6CzOIt/Y5cmBzWodd3YGEq7u0MkEWd/iHHj
	 YQEmGKAeRUXOfaQFP33sab2o4Jazc3Ji0DitL2pCmMYxSQwIRnPQcOTebV5gbppSCh
	 Ff88ewVUXliBYHqTR8cQ6t1QEDMhTvOlCa2zq8xWdCuoym5O+YmsCEPsaDNoxXhkEo
	 XUbBLq47pRPNPCeL5/gKnAcqcTDRVjFtrf5lNeJtzX1BhoW2BtA5cfIKvG5xtnX2tn
	 2klL4mWQ10SN7MFlMq8c+IEoONIUM9v2exJXnD6FZT50LB1lcGJxXmYY+fOLwrEY8M
	 BGY1+cyUHS+zw==
Date: Tue, 8 Jul 2025 12:26:17 -0500
From: Rob Herring <robh@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	nbd@nbd.name, jeff.johnson@oss.qualcomm.com,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: net: wireless: ath9k: add led bindings
Message-ID: <20250708172617.GA652174-robh@kernel.org>
References: <20250704214219.18796-1-rosenp@gmail.com>
 <20250704214219.18796-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704214219.18796-2-rosenp@gmail.com>

On Fri, Jul 04, 2025 at 02:42:17PM -0700, Rosen Penev wrote:
> This is used to override the various defaults the ath9k driver has for
> LED pin values.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> index d16ca8e0a25d..58c7b873cecb 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> @@ -50,6 +50,19 @@ properties:
>  
>    ieee80211-freq-limit: true
>  
> +  led:
> +    type: object
> +    $ref: /schemas/leds/common.yaml#
> +    additionalProperties: false

You really don't want any other common properties? Like defining the 
function?

> +    properties:
> +      led-active-low:
> +        description:
> +          LED is enabled with ground signal.
> +        type: boolean
> +
> +      led-sources:
> +        maxItems: 1

This property is really for cases where the LED source is configurable 
from the LED instance. If that's not the case here just use 'reg' for 
each instance (assuming there's more than 1). I shouldn't be wondering 
what the h/w looks like though. Please describe it in the commit msg 
rather than what some driver does.

If you do need led-sources, you should define some constraints on the 
values, not just the length.

Rob


