Return-Path: <linux-wireless+bounces-22076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80E4A9CDEB
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4901796CF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 16:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D9F19E98A;
	Fri, 25 Apr 2025 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXP+EO+i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA8192D87
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597901; cv=none; b=RpswTVNVzVEqQbYGlW5SmvAYBsAZNyQDaROGmULFldIFNjW/WjORaEQSpA4cfkH1OnUvG45Y/8QK0niN29OhyNIjx55v0ms+tFjH2JPCBIQf6KdwE7adGjZgeoGEdBoiWx3ZiXjDCeLLD70tyEqgMysntnenL+xrdjXldDJnxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597901; c=relaxed/simple;
	bh=3dcytkIIOKjYNTYbCvwxv8RLp8Sf8wMdUwsN320D9Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLdA3U+wZHPk3/S+06yYRe8+pSdUxIj9jWkEN4//s/T4yVMgEbKenhRdTrGGlbaQuStbdhvszUo81I2gYAiE0zlxNHoFYt/aYNUJlftFj1Gmvcn/HMhtMCKPk/C9zrrxTlom71RpEq8tfu/3IOOFwOtsodyOpQ41+6tkt/acfho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXP+EO+i; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736c277331eso3531554b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745597897; x=1746202697; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zZbqNinw0GvgPs1iizzcZ6AlHQrRMk2Lrby4q0n+fcU=;
        b=zXP+EO+iI9Xt5G+2oQdKqI5po+MYKrnBD+f3ZY1hpIYJt4xM53Odpwc197d9kUAY9O
         B0WhScuLvjfkL4/n6lwPfHoLf3VitdmMENBemKsf5n6mZA6fE3ccTl4l+bEpZoYNt9IN
         OGCm3LYmCmFK+X7WdR8n3SZq0Acoilfa1DS6ys/ieTR1AWEZlprcieEvXkS0ZmORh/G7
         VuAW7iw2SdplqVLs9fDNpJ8s5Pift2U4eXKYu5xsc4K07BOUXWfGHWd1ylrxwUlStdvr
         RUw5RQ0VHgJ76Bl2GsKxpzoURqGNtWtzLROZlFYrUTowAnYEtQqzXCYJWSPw9y8oG1oI
         DtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597897; x=1746202697;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZbqNinw0GvgPs1iizzcZ6AlHQrRMk2Lrby4q0n+fcU=;
        b=Jb72epve4HsGRwwDzH9yC7g4nI60vIbkNB92Jrq92F5FprMvpEcvdBZQfuKkLRKcZ5
         JuRbRgGaKsvLLbpKpV99IJzubJjZsJEHO9XtrE9v/RpygaXdgJHkX5hV+kKVya4uo2sK
         1iARMdO+CvBd/NvSNF+E3sVlO46BQm+Ly6tUuDX2UcyoeQqXaAcc4km9CkrQvh3b5DPe
         NzsKVSxqdm0F8H9v9qejfKmJfyQyHlgLwANSWzc5nxz5jPmf9O6n/txiNAQwk+s9NB9D
         SWngMtcIAfYYNJo5zzsMDgweEpZgZhO74eYMvdpoUM1QXDKAIRFOvxJQ8W7aTwoxWwqP
         c0Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW1HjfS47I4rqlc/rHK2WiKTJgd1RLIaOlxTkYmB71jA800bauUxyObUtg0cTDNErO7x+vrjSQgoyH+AKnn3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPrazleWllBeey6xxUjqfWPKsZChQ6wjpbGgpvCguReFyVJ+FE
	szIakkAuCfumEYkFN89RqoCggO7CUHzRBKTkE63lMUFby+XlAD4xRTIZk1/6cA==
X-Gm-Gg: ASbGnctAFzUuaNxMBPDQmoBJ/U2zKBAya8wSqo3yIcWJvBhX2X1SP/qB+80bo4JIBBY
	gd3wb+363r6LxGHjAvmmMHb4mPEmYueygwpwtHSH0lsbrOOaUn4skWDuZkbmV9zQpe5D/sjoNAP
	1zo9e4xMKd8LAKz+ZwIakX092Bcyz4Bj7DQdNRBPnPFa2Knpj51bS6k5nIIMEwPZgicC/1oedjO
	jkYgUgGb/ozapSDkl2TnmdphxN0Ia5B3DCvA87bPqC2yCjvDJ3y6iDtC18g70pgdtRPWrNWG2GA
	y4IZ4CnDqNEQ1gipJSBOAp2SNtSNJZoid6toNMgrnlVLzGdp8cwp
X-Google-Smtp-Source: AGHT+IFJ8f+Ljs0TwETyk/DKUrALYADuqKxZ4P01us48D6R3+0qlUDjyPo+P1Thcb08Psu0HHHpIew==
X-Received: by 2002:a05:6a20:c702:b0:1f5:9cdc:54bb with SMTP id adf61e73a8af0-20445ee29a1mr8972811637.11.1745597896910;
        Fri, 25 Apr 2025 09:18:16 -0700 (PDT)
Received: from thinkpad ([120.56.201.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f76f45d2sm3080986a12.11.2025.04.25.09.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 09:18:16 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:48:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v2 06/10] bus: mhi: host: Add support to read MHI
 capabilities
Message-ID: <ywqbhivo7k7jmuptueeqhirlkpk5inbfaucuvmvnpj6ppcpzd4@whdsaymdvtaf>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
 <20250313-mhi_bw_up-v2-6-869ca32170bf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313-mhi_bw_up-v2-6-869ca32170bf@oss.qualcomm.com>

On Thu, Mar 13, 2025 at 05:10:13PM +0530, Krishna Chaitanya Chundru wrote:
> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> As per MHI spec sec 6.6, MHI has capability registers which are located

Add spec version also since these capability registers are present in newer
versions only.

- Mani

> after the ERDB array. The location of this group of registers is
> indicated by the MISCOFF register. Each capability has a capability ID to
> determine which functionality is supported and each capability will point
> to the next capability supported.
> 
> Add a basic function to read those capabilities offsets.
> 
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/bus/mhi/common.h    |  4 ++++
>  drivers/bus/mhi/host/init.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
> index dda340aaed95..eedac801b800 100644
> --- a/drivers/bus/mhi/common.h
> +++ b/drivers/bus/mhi/common.h
> @@ -16,6 +16,7 @@
>  #define MHICFG				0x10
>  #define CHDBOFF				0x18
>  #define ERDBOFF				0x20
> +#define MISCOFF				0x24
>  #define BHIOFF				0x28
>  #define BHIEOFF				0x2c
>  #define DEBUGOFF			0x30
> @@ -113,6 +114,9 @@
>  #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
>  #define MHISTATUS_SYSERR_MASK		BIT(2)
>  #define MHISTATUS_READY_MASK		BIT(0)
> +#define MISC_CAP_MASK			GENMASK(31, 0)
> +#define CAP_CAPID_MASK			GENMASK(31, 24)
> +#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
>  
>  /* Command Ring Element macros */
>  /* No operation command */
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index a9b1f8beee7b..0b14b665ed15 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -467,6 +467,35 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>  	return ret;
>  }
>  
> +static int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
> +{
> +	u32 val, cur_cap, next_offset;
> +	int ret;
> +
> +	/* get the 1st supported capability offset */
> +	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF,
> +				 MISC_CAP_MASK, offset);
> +	if (ret)
> +		return ret;
> +	do {
> +		if (*offset >= mhi_cntrl->reg_len)
> +			return -ENXIO;
> +
> +		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
> +		if (ret)
> +			return ret;
> +
> +		cur_cap = FIELD_PREP(CAP_CAPID_MASK, val);
> +		next_offset = FIELD_PREP(CAP_NEXT_CAP_MASK, val);
> +		if (cur_cap == capability)
> +			return 0;
> +
> +		*offset = next_offset;
> +	} while (next_offset);
> +
> +	return -ENXIO;
> +}
> +
>  int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  {
>  	u32 val;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

