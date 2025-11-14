Return-Path: <linux-wireless+bounces-28974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E29C5CB37
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BACE44F376B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14AB313282;
	Fri, 14 Nov 2025 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbPe/J8t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842AB22258C;
	Fri, 14 Nov 2025 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117135; cv=none; b=Jt8qwdCCnKjDFTvBdh/BhF+Ldr6wKS/jFHmk8aUXM/KsvPkwUQtEEQMHvbKIp+XGG85azhPARboh+pEKONG50J+eBDyxyFWL5ki9XPnhV0+Tuz7r6ijQURAohCJMVa+xPlNNw8L2zHse5+otK5ro4ISG7KwSi0YscWJhyvTDf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117135; c=relaxed/simple;
	bh=4F5PAHalrEVrOe3q+txro3OlvhjyxJ0rxo1kmjSN9uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aiq42+tI1dmMCOFw8qcK7mSvs5aLFqcCjkK1PtkzokXV+lY+ohajeDIeolX/xVSHUZqJQnvhF34NdkPK5gGtZ8OR6KKAbE7zaRSqsKmdGGppSStAsBJfqXSi/cPOKyIgnDtFWmEZJGPPz9uKV/F6CcNmL6Znjy17sFLXC/UB42I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbPe/J8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE70C4CEF8;
	Fri, 14 Nov 2025 10:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763117135;
	bh=4F5PAHalrEVrOe3q+txro3OlvhjyxJ0rxo1kmjSN9uI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RbPe/J8tJjBa5nk5LniU18FGGaGRbGXCUAdsaPIrakqv5qQkGgfnJEOKwujVzhRDR
	 O2f2DMR6NEd105A0C+IG8CbudhgKiToaNIHw96+VW/zkwpxCquWsmib7FQyjq80R1b
	 NtdMIJzWLCzmII4vVAgSg6J9E4Pr2mv96eTStaHMPLhTbSuMWEPvCY1cuyZDtyKsFU
	 wOVmzs73jIhQ/y/W3vjy9Y17YVxJWCIVIOGFXbpaCsh1AJIOmrxe/eumCBdCxoOpyn
	 RQLOFgNtsZOvsTPfF0j2z52LuqHzT/utqTpaqdovj7PPtK3xj/9RZNfc5m63j6ilUe
	 rHlutoplmIhSg==
Message-ID: <3a951821-14b1-464e-b1da-05a95f4164af@kernel.org>
Date: Fri, 14 Nov 2025 11:45:30 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 devicetree@vger.kernel.org, ath12k@lists.infradead.org,
 Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
 <20251114-ath-variant-tbl-v1-1-a9adfc49e3f3@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251114-ath-variant-tbl-v1-1-a9adfc49e3f3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2025 11:22, Manivannan Sadhasivam wrote:
> On devicetree platforms, ath{10k/11k} drivers rely on the presence of the
> 'qcom,*calibration-variant' property to select the correct calibration data
> for device variants with colliding IDs.
> 
> But this property based selection has its own downside that it needs to be
> added to the devicetree node of the WLAN device, especially for PCI based
> devices. Currently, the users/vendors are forced to hardcode this property
> in the PCI device node. If a different device need to be attached to the
> slot, then the devicetree node also has to be changed. This approach is not
> scalable and creates a bad user experience.
> 
> To get rid of this requirement, this commit introduces a static calibration
> variant table ath_calib_variant_table[], consisting of the platform model
> and the calibration variant for all upstream supported devices. The entries
> of this table are derived from the upstream DTS files.
> 
> The newly introduced helper, ath_get_calib_variant() will parse the model
> name from devicetree and use it to do the variant lookup during runtime. If
> the platform model name doesn't match, it will fallback to the devicetree
> property based lookup.
> 
> Going forward, the devicetree based lookup will be deprecated and this
> table will be used exclusively for devices connected to the devicetree
> based host platforms.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.2.0.c2-00204-QCAMSLSWPLZ-1
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath.h         | 98 ++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath10k/core.c |  5 ++
>  drivers/net/wireless/ath/ath11k/core.c |  7 +++
>  3 files changed, 110 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath.h b/drivers/net/wireless/ath/ath.h
> index 34654f710d8a1e63f65a47d4602e2035262a4d9e..d0a12151b7fc13355161c48ba1fb200e4617ed11 100644
> --- a/drivers/net/wireless/ath/ath.h
> +++ b/drivers/net/wireless/ath/ath.h
> @@ -21,6 +21,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/if_ether.h>
>  #include <linux/spinlock.h>
> +#include <linux/of.h>
>  #include <net/mac80211.h>
>  
>  /*
> @@ -336,4 +337,101 @@ static inline const char *ath_bus_type_to_string(enum ath_bus_type bustype)
>  	return ath_bus_type_strings[bustype];
>  }
>  
> +static const struct __ath_calib_variant_table {
> +	const char *machine;
> +	const char *variant;
> +} ath_calib_variant_table[] = {
> +	{ "ALFA Network AP120C-AC", "ALFA-Network-AP120C-AC" },
> +	{ "8devices Jalapeno", "8devices-Jalapeno" },
> +	{ "Google cozmo board", "GO_COZMO" },
> +	{ "Google damu board", "GO_DAMU" },
> +	{ "Google fennel sku1 board", "GO_FENNEL" },
> +	{ "Google fennel sku6 board", "GO_FENNEL" },
> +	{ "Google fennel sku7 board", "GO_FENNEL" },

Are these top-machine models? If so, you cannot use them. The value is
user-informative, not ABI. If you wanted to use them, you would need to
document the ABI.

Just use compatible, that's the entire point of compatible.

Best regards,
Krzysztof

