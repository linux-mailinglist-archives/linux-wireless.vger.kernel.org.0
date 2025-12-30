Return-Path: <linux-wireless+bounces-30180-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37587CE990B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 12:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8263019BE3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB0276050;
	Tue, 30 Dec 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+O18XVj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91465C8CE;
	Tue, 30 Dec 2025 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095191; cv=none; b=N+sKDjCq/fit6wy3FGPfT/nqTBTGIlWXP6Z0Rldlse0jUA9whhh5h03wrqon2J0Y8mmBF0rJNb1nmHWphL9nZrXdzkpHPNjvWBHSSWE2kaPp5Qnu0AZsZCGz0AjZAOOY4+zDI1x4QOFLZZbliRF5KI4EtMM2tqbEl1KiNntWKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095191; c=relaxed/simple;
	bh=H2S4xFFDMmwEe5AURbERbGY52mGbCOue6vEC0fGALhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8C5E4/eY6uhAqy9MMd+fV5B4VuYLbpw1Z6n4jzL+m+cZkCuszyfPbsgCYFDCAJcn6RscWYQdtxwcB8VqRsxFUMVayRdtQScPJ2ItmWoNFyrTWNQ+8zobSq975AJJYNxDq8x3lGnbaMQjy1/2ytW7hZPNuFJKconxPFiD2WqcmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+O18XVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965EDC4CEFB;
	Tue, 30 Dec 2025 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767095191;
	bh=H2S4xFFDMmwEe5AURbERbGY52mGbCOue6vEC0fGALhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+O18XVji3qLM8P3PpeX3wCoADHltBsx4eEkn1XUG+P7bQM6LBGi9olQewerhd9OG
	 A6EUXqlnv3IHj+hnqvpyXM2gpdgTYO2yMF9Lu0aEIvyO3V3o6qOgngT2p2cejYuGTp
	 LNGab6MMzyunAKO4erhmv31Cm3yGJUiKN7492YfI9svsjY1LKsgRO3BqKf+MLk5CGi
	 MHXKiPYZeeadYMeH6FvKxbKGP7+JxGrQ27KC14dZwX4+hrLs+cDtvjp7zk+kNVaVrf
	 pW8nKLwNxl62VTGuTAvbL8h8ITx2K1zOOZzybTxyznLnMF1LZR9CUCiR+kXL7cJ1jI
	 920GSFdYmhlIQ==
Date: Tue, 30 Dec 2025 12:46:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jjohnson@kernel.org, ath11k@lists.infradead.org, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: net: ath11k: add IPQ9574 compatible
Message-ID: <20251230-meteoric-singing-kudu-cbfbd9@quoll>
References: <20251228155855.2118792-1-mr.nuke.me@gmail.com>
 <20251228155855.2118792-2-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251228155855.2118792-2-mr.nuke.me@gmail.com>

On Sun, Dec 28, 2025 at 09:58:51AM -0600, Alexandru Gagniuc wrote:
> Add IPQ9574 device support for ath11k. The schema is identical to
> ipq6018, so add the compatible string where needed.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml          | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index c089677702cf1..8293ea29b723e 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -17,6 +17,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - qcom,ipq9574-wifi
>        - qcom,ipq8074-wifi
>        - qcom,ipq6018-wifi

Although it looks like reverse-sorted, but Qualcomm bindings use always
alphabetical sorting (non-reverse), so please place it after
qcom,ipq8074-wifi.

Same in further places.

Best regards,
Krzysztof


