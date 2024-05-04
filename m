Return-Path: <linux-wireless+bounces-7168-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38CB8BBC8C
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 16:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842B21F218B9
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500D93BBF1;
	Sat,  4 May 2024 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRba7BbG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7A3BBC9;
	Sat,  4 May 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834528; cv=none; b=ay8yZ0fZ0bNmSInxgbaNl7+a9Ei6mtIILKVa0M5uItP8BzzXkYxoTtbkoRz0FAN/LtXgyck6iZEHGPYDDtCeT1krXL0kSGU5+gK7xLw98J+4ot1Ed22eMCujm0i717fzV0RPrQaa7I7dv9pOvFPYhV/7HAH5Pw/xgf7GLqCqa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834528; c=relaxed/simple;
	bh=QUcRQ6mxQ61MfWGrSxLhyngIDwmEnF8y4sF93JkujGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFAf1XxFgjZkj3Ou+H/Zh2/Y+kxcar/FHBFV3TRsXixSeORlWduRYRT0UHY7u9cuq7/vRKthkIUguesHwqmzVx2qaK4OXunHLxdqogGScMs60Knj+8Fm2ckppKIteN0WcbwLhUSzsb+wDurgpO2Khql26C2iVw4LOozi9dcwJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRba7BbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22B1C072AA;
	Sat,  4 May 2024 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714834527;
	bh=QUcRQ6mxQ61MfWGrSxLhyngIDwmEnF8y4sF93JkujGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IRba7BbG3moknVhtkmaeLijB90ehLrcZG82jPnBVZxBXaaJuX4SwbHf+oZVD03weN
	 yCtLVTdcgMmOUNVBUeuI+QzU/umYHJijEK5eOU3AMVYCPUBucWSgQwLsJ7lvNzbasz
	 1i48TW33XAPMlcvLBtK+p9r5tuL/AiKzmOHqvU0Y6CCevkaaL6RaxkLj9gBJBUXmQr
	 6TAatLMCJVn4OfTivmMEfKff1ChEuePmQgTlvLnPnoskSqzpBz+5AkE7iVU9nsPaXv
	 QoA9+TOpIP5t5kfuOcGdyIe8Kxl9opH1CW4ZPonqELk6JwqDnlJiqzLBQ3XyIAsbG8
	 sZZKN0dZjlWfg==
Date: Sat, 4 May 2024 15:55:23 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next] wifi: ath12k: allocate dummy net_device
 dynamically
Message-ID: <20240504145523.GC2279@kernel.org>
References: <20240503100440.6066-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503100440.6066-1-leitao@debian.org>

On Fri, May 03, 2024 at 03:04:39AM -0700, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct ath12k_ext_irq_grp by converting it
> into a pointer. Then use the leverage alloc_netdev_dummy() to allocate
> the net_device object at ath12k_pci_ext_irq_config().
> 
> The free of the device occurs at ath12k_pci_free_ext_irq().
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> This is *very* similar to the same changes in ath11k commit
> bca592ead82528b ("wifi: ath11k: allocate dummy net_device dynamically")
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

...

> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c

...

> @@ -577,8 +578,11 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
>  
>  		irq_grp->ab = ab;
>  		irq_grp->grp_id = i;
> -		init_dummy_netdev(&irq_grp->napi_ndev);
> -		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
> +		irq_grp->napi_ndev = alloc_netdev_dummy(0);
> +		if (!irq_grp->napi_ndev)
> +			return -ENOMEM;

Hi Breno,

Will returning on error here leak resources allocated by
alloc_netdev_dummy() in previous iterations of this loop?

If so, I suggest jumping to unwind handling which
can be shared with the error path in the hunk below.

> +
> +		netif_napi_add(irq_grp->napi_ndev, &irq_grp->napi,
>  			       ath12k_pci_ext_grp_napi_poll);
>  
>  		if (ab->hw_params->ring_mask->tx[i] ||
> @@ -611,6 +615,10 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
>  			if (ret) {
>  				ath12k_err(ab, "failed request irq %d: %d\n",
>  					   vector, ret);
> +				for (n = 0; n <= i; n++) {
> +					irq_grp = &ab->ext_irq_grp[n];
> +					free_netdev(irq_grp->napi_ndev);
> +				}
>  				return ret;
>  			}
>  		}

-- 
pw-client: under-review

