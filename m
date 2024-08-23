Return-Path: <linux-wireless+bounces-11857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B1595D236
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4756B21E3C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4F188A3E;
	Fri, 23 Aug 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="geEc4Zc/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B5188903
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428749; cv=none; b=dQ1TJqu8cKApwntfHIVj05jYphRniqpUkDvB4vm13PNBw3HxGJ2VPB3l8Io0EnvhYK7EGnAQXZwF5MuMXnEms4PKxGhnsQEgcH//pXxXzc1FdWpQZHeHChDCZ1JlwSFZUpayl6viYbpesrHuJUnb1Awngsq9RK6b/dEp7qXaGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428749; c=relaxed/simple;
	bh=/RB4+DUzcecCj6IUIH7XJGwYAxA5ZOCcrqRxptpdQeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXkyMQXOcoB25VSp2XWCXszoO7ZoxPSgztONiyv4YC0T2DmYTK/cwnSpbQmWqxtY99Ji7Al1fpnN0tNW5M7f03tXs4pu07Qird5iBM1766BQ5f/FWIaf1oGlSGoDaKa1Kr1p3r5KuCXg+11T0fvgV5eUighZu6gJfokv5emU250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=geEc4Zc/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1493722a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724428747; x=1725033547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UIGDnb5A+GtrVAQeuej4pnC1dpMb2EWNsJHPeGHtTlI=;
        b=geEc4Zc/pUh/poRV7WU+JxhSFgwNQxCe1d2cmOJfGRtPP/+cZbI/17D2V6He98ZNZ7
         iheKHTiOsq/arjVyfEZGbDolLPEd8yKcBmMTh7K189m102Pj6TTx34BI7j8PyYN0XRUu
         sdAwqz5UXI0CJoSCl/XYZ4wiwUvVhd018E3XCToJwoDmUaC4aoWzmlmoLKaxUKpe0zIO
         1AQoPitWC6iFAi5VsBWzhQ84/rPAwQKf8NAl9X1Eq22EHh3mtWhQAQvmmMAjN+n5jFA3
         set6LJw3ptZ1ZMQy0OR9qBMhhek9g1oGXS6Bt06+BH5k2lZiXFv3smRV+oEyTERn5bwE
         Ewtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724428747; x=1725033547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIGDnb5A+GtrVAQeuej4pnC1dpMb2EWNsJHPeGHtTlI=;
        b=snLfKF1h9RaNLxGM8a+iq7cozrLAmLpjjpJxqS9tyAqSI3ca7ayaq2QoslgORu0aU/
         pOvQBpd4PfD0vwksMLt+L6dkMkI1iA1536svkX5Rz0Dgvz1STwdRmzZShrAkGg9XP13Y
         tCsnccRZuS2gQtkCpYLzct3HlRf/uyRYnaSZTEX7na2aWU+UjW255NbWDOX2qTIaE6qr
         XQ39BNI/uRTdkeAuPimPGwZy7NMzrr+JW60ppECfr5Z8O+dIXVec3eudY8chsLUYQe0u
         wIrm0Pgfy9rln+HirFJcaYkDlSpkXTWL6Kr3jtbp0ZxXptLDWQyArQbWl7wKtZ/9J8Ny
         aXSw==
X-Gm-Message-State: AOJu0Yz6RD5hW4FsGBL2c9fGYMn1mBFMGSCRAhjYfU2Ba9vP7iY+PHn5
	XtZrwiI9NBQ6wi0fcNBzpWl1e9ICVrSdr4L1ZRkRbgzVpJyXiJG9defa7z/x8v1nwej+HO6WwSI
	=
X-Google-Smtp-Source: AGHT+IH+oOTSFwrhIWkuhR20LUl8VdF/2I2KKHEVR/Ox6j4FQ8Mp23CMn5lXfDqRfKQW0VyKmRnOvQ==
X-Received: by 2002:a05:6a21:4603:b0:1c4:a1f4:3490 with SMTP id adf61e73a8af0-1cc8b5d8f90mr2850586637.39.1724428747347;
        Fri, 23 Aug 2024 08:59:07 -0700 (PDT)
Received: from thinkpad ([120.60.50.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e2194sm3188056b3a.126.2024.08.23.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:59:07 -0700 (PDT)
Date: Fri, 23 Aug 2024 21:29:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: kvalo@kernel.org, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] wifi: ath12k: Set IRQ affinity hint after requesting
 all shared IRQs
Message-ID: <20240823155903.eqswl5ds4h2eynhp@thinkpad>
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
 <20240823155502.57333-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823155502.57333-3-manivannan.sadhasivam@linaro.org>

On Fri, Aug 23, 2024 at 09:25:01PM +0530, Manivannan Sadhasivam wrote:
> If a shared IRQ is used by the driver due to platform limitation, then the
> IRQ affinity hint is set right after the allocation of IRQ vectors in
> ath11k_pci_alloc_msi(). This does no harm unless one of the functions
> requesting the IRQ fails and attempt to free the IRQ.
> 
> This may end up with a warning from the IRQ core that is expecting the
> affinity hint to be cleared before freeing the IRQ:
> 
> kernel/irq/manage.c:
> 
> 	/* make sure affinity_hint is cleaned up */
> 	if (WARN_ON_ONCE(desc->affinity_hint))
> 		desc->affinity_hint = NULL;
> 
> So to fix this, let's set the IRQ affinity hint after requesting all the
> shared IRQ. This will make sure that the affinity hint gets cleared in the
> error path before freeing the IRQ.
> 

Apparently, I missed adding the fixes tag:

Fixes: a3012f206d07 ("wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector")

- Mani

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 9e0b9e329bda..f265c1b8ce4e 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1446,16 +1446,10 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_pci_msi_free;
>  
> -	ret = ath12k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
> -	if (ret) {
> -		ath12k_err(ab, "failed to set irq affinity %d\n", ret);
> -		goto err_pci_msi_free;
> -	}
> -
>  	ret = ath12k_mhi_register(ab_pci);
>  	if (ret) {
>  		ath12k_err(ab, "failed to register mhi: %d\n", ret);
> -		goto err_irq_affinity_cleanup;
> +		goto err_pci_msi_free;
>  	}
>  
>  	ret = ath12k_hal_srng_init(ab);
> @@ -1476,6 +1470,12 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
>  		goto err_ce_free;
>  	}
>  
> +	ret = ath12k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
> +	if (ret) {
> +		ath12k_err(ab, "failed to set irq affinity %d\n", ret);
> +		goto err_free_irq;
> +	}
> +
>  	/* kernel may allocate a dummy vector before request_irq and
>  	 * then allocate a real vector when request_irq is called.
>  	 * So get msi_data here again to avoid spurious interrupt
> @@ -1484,16 +1484,19 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
>  	ret = ath12k_pci_config_msi_data(ab_pci);
>  	if (ret) {
>  		ath12k_err(ab, "failed to config msi_data: %d\n", ret);
> -		goto err_free_irq;
> +		goto err_irq_affinity_cleanup;
>  	}
>  
>  	ret = ath12k_core_init(ab);
>  	if (ret) {
>  		ath12k_err(ab, "failed to init core: %d\n", ret);
> -		goto err_free_irq;
> +		goto err_irq_affinity_cleanup;
>  	}
>  	return 0;
>  
> +err_irq_affinity_cleanup:
> +	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
> +
>  err_free_irq:
>  	ath12k_pci_free_irq(ab);
>  
> @@ -1509,9 +1512,6 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
>  err_pci_msi_free:
>  	ath12k_pci_msi_free(ab_pci);
>  
> -err_irq_affinity_cleanup:
> -	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
> -
>  err_pci_free_region:
>  	ath12k_pci_free_region(ab_pci);
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

