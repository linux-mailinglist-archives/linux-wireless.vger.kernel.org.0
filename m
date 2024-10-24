Return-Path: <linux-wireless+bounces-14480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D969AF2AF
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF38B21477
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17E71FE0F6;
	Thu, 24 Oct 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+/zXdSi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFC22B663
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729798794; cv=none; b=sJkgv15C+EA/uhV3rgWx7N/n6c5ET7N2E0xYjWbjvhgwsejKUbJq6D4iYNTwPolr/AcKfvYJZv1bpnJWCyBM+0ZyZTCYAe0nljRAb8EHm69Fj9ST4i1M06LRa4N/w/VqHdbnl6G3fep+q/w96YY+JiK4B+d+Il4ZWh4sXzfZpbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729798794; c=relaxed/simple;
	bh=F/Ze67nW0IFUKBtGoiTQlpJha5hQGjN9SKG/CdavfAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tbjiuej94+qNtcoCMcaEUEA6+MrHUmwIq3c3JdGeXVGV22gYWzP3C0cGi/I0DPTrqogqyGYnfCxe/bAHAOqXKqb/Mm7G9fgjoQL+5FIoDzgLmgUfQ9a7yrtQnzaYnB9JYo5qWc5qxXHS3E7XZJCLbQ/RsPJRnQID/NCQGT+rPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+/zXdSi; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb587d0436so14311221fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729798789; x=1730403589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odUCZ6i3Z9JVAJZgtcokijO9ujjlw7b3NCqdho3UKJk=;
        b=E+/zXdSiOe3uzIvSTPTRLaSGcyCsNvL7XX5Bk3Jpht3uA9HNhxwB1aFSi/HIOEsfoj
         LxGKiM8M5C49eqPRUuoOmB9QEe+GVFAmAO8+Gz/fQxu6y1w3g447189AOCjrzmNL/sSL
         m/zHnTVuP4iMayekYk5PaH5w2AI8p+xnNG56tqUMH+GHGgDh8LufBbOSTus98UOm+bg4
         wwJwdPlYn3jKWIS79YbeSsclYgH2bHklr5QnjLFTftmJatqvutX5vQS6XcsK7fenfgqC
         BSC8bthQkYbCMm3GXIMhZlB2UUIT6tQAx04QRH7/EzfsgEAzKe9YWC61wEG5PklZvuC4
         3brA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729798789; x=1730403589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odUCZ6i3Z9JVAJZgtcokijO9ujjlw7b3NCqdho3UKJk=;
        b=l8nQVihdoV+Ni6xDDuSWDVpJGAE952x0YoV/jr6WRK3VZNAIBAepOTzQVnprnrEIJU
         NQGvxtzNiAjxYoxdWMqwu6/L0jSA56d1P+8NqW1QO1184j0YsBd6EqstCJizge41+IAn
         MfSnF7lS4fJ5isM2iDJa5+EUFkQp2L0fJ6KeUDFa6qpXis3Yh60AnU3eFa2+akZUt6k4
         Ay0tO3k1BuxcPY54FL66EgYRa+CWd2BUDfP2DnRnQPY6zv7NOVmgb3DMft7Vxd98Movp
         SXxJDfnixCzGzCoUnW8170iEScW0aRu0YX3H+CLbWbLC6HtIPX/jCmqp7bLSTJIlTEip
         u20Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCdn2EA17kdIwD8pkirNi0B9DrY+NRd7nwNrWy8n7Iw7DJPs0O8RAjlrSeBk6NQzX7MsS7uJKLQ9y+EznIvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9571qMgxzqsxZp4s+bv/H9SzxsCiJ/IpbPX1LVTbVfwIfPorM
	OPkeMwELu18kkvnn0Kh6GS30wuNqCbRwLO7XnB5JkSZq9sqx3xoaNWJ2XZ+jMFk=
X-Google-Smtp-Source: AGHT+IHIulvo8rdeRwX4wcEo4Hy4+qR8jVUvlgiU74rNHovMaurcP6k/nUFgntCcOTVditUUe1/7GA==
X-Received: by 2002:a2e:4a12:0:b0:2fb:7f9f:7f50 with SMTP id 38308e7fff4ca-2fc9d330671mr32005781fa.13.1729798788920;
        Thu, 24 Oct 2024 12:39:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb9ad608e2sm15086261fa.32.2024.10.24.12.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:39:47 -0700 (PDT)
Date: Thu, 24 Oct 2024 22:39:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: kvalo@kernel.org, quic_jjohnson@quicinc.com, 
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath11k: support board-specific firmware
 overrides
Message-ID: <pdjhyrjoreiykv2tquvufjw3rkti5sxrjvpmkjhvkfasq7zbo4@xxntxdmhhyg5>
References: <20241024002514.92290-1-quic_miaoqing@quicinc.com>
 <20241024002514.92290-3-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024002514.92290-3-quic_miaoqing@quicinc.com>

On Thu, Oct 24, 2024 at 08:25:14AM +0800, Miaoqing Pan wrote:
> QCA6698AQ IP core is the same as WCN6855 hw2.1, but it has different RF,
> IPA, thermal, RAM size and etc, so new firmware files used. This change
> allows board DT files to override the subdir of the firmware directory
> used to lookup the amss.bin and m3.bin.

I have slight concerns regarding the _board_ DT files overriding the
subdir. This opens a can of worms, allowing per-board firmware sets,
which (as far as I understand) is far from being what driver maintainers
would like to see. This was required for ath10k-snoc devices, since
firmware for those platforms is signed by the vendor keys and it is
limited to a particular SoC or SoC family. For ath11k-pci there is no
such limitation.

Would it be possible to use PCI subvendor / subdev to identify affected
cards? PCI Revision? Any other way to identify the device?  Please
provide lspci -nnvv for the affected device kind. Is there a way to
identify the RF part somehow?

Could you possibly clarify, how this situation is handled in Windows
world?

> 
> For example:
> 
> - ath11k/WCN6855/hw2.1/amss.bin,
>   ath11k/WCN6855/hw2.1/m3.bin: main firmware files, used by default
> 
> - ath11k/WCN6855/hw2.1/qca6698aq/amss.bin,
>   ath11k/WCN6855/hw2.1/qca6698aq/m3.bin

This approach looks good to me, thank you.

> 
> Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04402-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 16 ++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h | 11 +++--------
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index be67382c00f6..775e48551522 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1178,6 +1178,22 @@ static int ath11k_core_create_chip_id_board_name(struct ath11k_base *ab, char *n
>  					       ATH11K_BDF_NAME_CHIP_ID);
>  }
>  
> +void ath11k_core_create_firmware_path(struct ath11k_base *ab,
> +				      const char *filename,
> +				      void *buf, size_t buf_len)
> +{	const char *board_name = NULL;
> +
> +	of_property_read_string(ab->dev->of_node, "firmware-name", &board_name);

soc_name rather than board_name, please. Or just fw_name.

> +
> +	if (board_name)
> +		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,
> +			 ab->hw_params.fw.dir, board_name, filename);
> +	else
> +		snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
> +			 ab->hw_params.fw.dir, filename);
> +}
> +EXPORT_SYMBOL(ath11k_core_create_firmware_path);
> +
>  const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
>  						    const char *file)
>  {
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 09c37e19a168..ce4102cfed4d 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -1249,6 +1249,9 @@ bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
>  
>  const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
>  						    const char *filename);
> +void ath11k_core_create_firmware_path(struct ath11k_base *ab,
> +				      const char *filename,
> +				      void *buf, size_t buf_len);
>  
>  static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
>  {
> @@ -1295,14 +1298,6 @@ static inline struct ath11k *ath11k_ab_to_ar(struct ath11k_base *ab,
>  	return ab->pdevs[ath11k_hw_mac_id_to_pdev_id(&ab->hw_params, mac_id)].ar;
>  }
>  
> -static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
> -						    const char *filename,
> -						    void *buf, size_t buf_len)
> -{
> -	snprintf(buf, buf_len, "%s/%s/%s", ATH11K_FW_DIR,
> -		 ab->hw_params.fw.dir, filename);

It could have perfectly lived here. Is there any reason to move the
function?

> -}
> -
>  static inline const char *ath11k_bus_str(enum ath11k_bus bus)
>  {
>  	switch (bus) {
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

