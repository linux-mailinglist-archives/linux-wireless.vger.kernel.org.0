Return-Path: <linux-wireless+bounces-27832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796F1BBF3A8
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Oct 2025 22:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5C5189B486
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Oct 2025 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BB4182D2;
	Mon,  6 Oct 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY8ueBp4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF14A08;
	Mon,  6 Oct 2025 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759783531; cv=none; b=dDCDSLmNI/yO/aUQENHFan14de4N1XeLsT4Qm1kB8kw3DuKIjngWGzzPhTphE6EEdHVnrQvVM3/mb6b3MULjmubkD+XJn+2V4ab6trLGiNOFJwh5IQdG2ShfRebNcbRH7CRVf/dfkYbNTLjzA4uKIMyY8xpYQEcgzHDczScV60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759783531; c=relaxed/simple;
	bh=Msplel+2vngn0wszovGQc3AienJz2287rwZ/jQ5RlKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hs4JbLwVxbiB3iVC7HTf39CuzXtTI1gKKm8A7sNEO4TRkSo+/kd0kgKE6yCOoE1jrseZGNOZ2UPMNs+/BYc4K6RZhr7DuWqeJprpxgb8jk66RlQ2DD2JMRO/RfSn79YM9KNzyTapvniIHWTjz7ScsxgN34urMqSIJrNyxH/PXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY8ueBp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05CEC4CEF5;
	Mon,  6 Oct 2025 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759783530;
	bh=Msplel+2vngn0wszovGQc3AienJz2287rwZ/jQ5RlKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sY8ueBp4USjv/gu/UnTqZMG68tY83xRGMo/6KwFUFSiB7ZHymiqy6+FGbDlOosqd/
	 jUf6llB99AsWoXliaizf7WLEnpJV7/8nDASOPfyjfzWgznS+cJepG1T7AflpjDGxVE
	 iH0fRjGfBAEetLI4RmqCzLUxK4K7OlcG2Vlu10NgJEEFocL1zUdYEr5yBsYIrn3bVR
	 Mw0tXM5mzGlVDwX3NcGbRgQOKEf4EmAMb71RYnH9sPUKPiDRH9edifCvqVOTCIAoyr
	 B5cJmodEifygc6Hk7cYt3zIrjUyc2d6mkKjN97cupcmbIbJQjJdaZkWDXS5Po3W+Eo
	 SXRNrDIkUgnkQ==
Date: Mon, 6 Oct 2025 15:45:29 -0500
From: Rob Herring <robh@kernel.org>
To: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH mt76 v2 1/3] dt-bindings: net: wireless: mt76: Document
 power-limits country property
Message-ID: <20251006204529.GA549972-robh@kernel.org>
References: <20250926-backoff-table-support-v2-0-16d3726646c4@simonwunderlich.de>
 <20250926-backoff-table-support-v2-1-16d3726646c4@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926-backoff-table-support-v2-1-16d3726646c4@simonwunderlich.de>

On Fri, Sep 26, 2025 at 12:04:52PM +0200, Sven Eckelmann (Plasma Cloud) wrote:
> The commit 22b980badc0f ("mt76: add functions for parsing rate power limits
> from DT") added filtering of the power limits based on two properties:
> 
> * regdomain
> * country
> 
> If either the country or the regdomain matches, the power limits are
> applied and the search is aborted. If none of the two is defined for the
> power limit, it is a global (or "fallback") power limit. The last
> "fallback" power limit in the list will be returned when not matching
> regdomain or country was found.
> 
> The idea is here to allow to specify "overwriting" country limits in front
> of the list - just in case a regdomain is shared but a country has
> additional limitations.
> 
> But this property was forgotten to be defined in commit 2de6ccebe0e7
> ("dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node").
> 
> Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>
> ---
>  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index eabceb849537c418650697da86682ef04c979193..f8f72f3f1b1dd185b4797be38b87c621ef3eac08 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -151,6 +151,11 @@ properties:
>                - ETSI
>                - JP
>  
> +          country:
> +            $ref: /schemas/types.yaml#/definitions/string
> +            description:
> +              ISO 3166-1 alpha-2 country code for power limits

This would be constrained to something like this?:

pattern: '^[A-Z]{2}$'

> +
>          patternProperties:
>            "^txpower-[256]g$":
>              type: object
> 
> -- 
> 2.47.3
> 

