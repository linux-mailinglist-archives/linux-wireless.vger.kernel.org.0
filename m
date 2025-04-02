Return-Path: <linux-wireless+bounces-21063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF0A78962
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 10:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8050C188CA77
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50B91F1507;
	Wed,  2 Apr 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8KZeGlv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2814F2F5A
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580842; cv=none; b=MOJEsPDt2YdDCeMcISN7hzOZebUxAcVJ3KqJbcP2WqvJfJh5rrc0zoo5VCUn4VljQ/UH8WEmVxy7nwgSgvXCdIKi8BPf6zVlaGEotzU0Vby8S71dp4GpgKLKUSO6fWETOPkMlkySeJ8Tmn+N1K7ZgxHO8JtWBkmCrVoh5g5Jtn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580842; c=relaxed/simple;
	bh=0a4g2AA3yqI2lZl/rLdcxJlvVBoXlDU/3TS7Jxz9usY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxzQuxJvDJF90jRDocYsHOSHB8V94WOQ/BkP/3hx5InJFC5abO6ujJMpx0QxdcUGzIB1PloblJBoyCiXlspuWCEHaEfjVBs1jYUhj7dCo1H8XDtRHiUZmKd+dCMt82u+Ij0uZQ/BxRMmTif5WGnecJyd6O4S2g2Xu1gnTGkb5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E8KZeGlv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3032aa1b764so8266537a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 01:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743580840; x=1744185640; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctkJhtxKsp7SbmROJ/NcWvcFC2gk/L3/qKRnLMhq/34=;
        b=E8KZeGlvhHQ5ZBVIMXgyhFY1Z97wEupWCdkGhGcJnW4mnUxYLPUcrb3IA4sTJsln57
         w8tVtG/OSgh9g1Akc+dNZdsCD7+HEhHOcDDMmbQ0zjtxR54U5xvQCfYz22xHnWN+GkVd
         4isG5cZUZvE4nldLhqIc8C7U09lrtlLCOZry9cpR4BLTrXRj+QndmXZ4ZDexQLiQsK63
         G55FnqbrYoOFjEwo+lCHNdO8RNZu9nTC9qptiplN5GOLloztonZGHTx2084ODG0xC+2G
         OLeqp2lXDqjO0Rp/dFp7Y8PPSNyqFBEydBFmorWUL4HmafopomhOHvOVSywi1fxOrf92
         +QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580840; x=1744185640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctkJhtxKsp7SbmROJ/NcWvcFC2gk/L3/qKRnLMhq/34=;
        b=Fazj05MmHkXC6ihWOby3EDCuP0+GsLNTiUwi3bIQDPL7HJGPPRoPnZ1Lxg2KslXIPz
         euwokju615/AA61Aq53rw/HvJVB2G1ZYHytKuGOVEBkDlgPP2fOugzs/QMPwPumNn0+5
         JisrwMw/OhWWeuAn1bsOQod6lSQRoPOITPfsKt5nVXYQ5kERLx5lUbECI/zbdeCKdWQW
         mjeGHIKAyyQ1x7z77YyMZk/LG7VEPdjPlG2CmE1w8W8lBcyt5bVC6WDPoYgm+8NJinyM
         On7VnULpssfiXit5V2+xqKFGhcotgX6X9JzYpib6Ql+4PUSM0w1nNZWDUrt6506PzPIx
         JUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWCnSegNzVrdlFs/iFeTS3HwMw43S885OjpYqc7/JyajM5erXOvV+xnqba44rd4lzmC92CKp32SUyvS9pFkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIwKI6QAPtKRJic0JT2+XqtbGq2YYN1ATayPForVbcs/2rbeD
	1zHRY2JEwZZNII0CLhNwcIoB+7HUfyfQytn6E0XLa8D4JqZzCINFdUrcF26eQQ==
X-Gm-Gg: ASbGncs5+frmYPFQAnRTOTxpptKXPcrnDJZ8qDdPu9IixGq5VlHA9dmgW8xM53JxHwm
	v84EkGJPnaRsAYa2OdftPlupuKyrtW6m/HebmRpCEM4UuZhSO+3Jw03zptuZ/oYdRcPY5nNTlHG
	47yyvd3rIzB4V07IwU5W4hfRCys+j0+mqjFy2Cisc+oELTuJZnDOgLEOQi7xaQhyQu3syklgBbk
	/oLshEqGLLRVGgEZ39HbDmGCFmpOwIrLowsE3hYcYLFZYK5x5xENUsQalWa8GlODKqL8ROo4+Mh
	lwmFhc4Qal2LMC3nAd/TYR2oJq+l/dG7dFc38YH0Bg7ZWBYyxKk33Egi
X-Google-Smtp-Source: AGHT+IGTopCX2yplsS8GSpqfdGC18AVuR2urMTzElNFnwCLQ4BxN3uKkDEM1puu2xMXe8rc89mguVQ==
X-Received: by 2002:a17:90b:1f92:b0:2fa:15ab:4dff with SMTP id 98e67ed59e1d1-3053215b176mr5797036a91.31.1743580840354;
        Wed, 02 Apr 2025 01:00:40 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3056f979d6fsm1010122a91.45.2025.04.02.01.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:00:39 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:30:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig
 symbols
Message-ID: <bsk4s5tlbpnvds73uxeasqxydcxolxpxvmtladtejhbi65yxob@4h5gy5srxlrr>
References: <20250328143646.27678-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328143646.27678-1-johan+linaro@kernel.org>

On Fri, Mar 28, 2025 at 03:36:42PM +0100, Johan Hovold wrote:
> The PCI pwrctrl framework was renamed after being merged, but the
> Kconfig symbols still reflect the old name ("pwrctl" without an "r").
> 
> This leads to people not knowing how to refer to the framework in
> writing, inconsistencies in module naming, etc.
> 
> Let's rename also the Kconfig symbols before this gets any worse.
> 
> The arm64, ath11k and ath12k changes could go through the corresponding
> subsystem trees once they have the new symbols (e.g. in the next cycle)
> or they could all go in via the PCI tree with an ack from their
> maintainers.
> 
> There are some new pwrctrl drivers and an arm64 defconfig change on the
> lists so we may need to keep deprecated symbols for a release or two.
> 

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Johan
> 
> 
> Johan Hovold (4):
>   PCI/pwrctrl: Rename pwrctrl Kconfig symbols and slot module
>   arm64: Kconfig: switch to HAVE_PWRCTRL
>   wifi: ath11k: switch to PCI_PWRCTRL_PWRSEQ
>   wifi: ath12k: switch to PCI_PWRCTRL_PWRSEQ
> 
>  arch/arm64/Kconfig.platforms            |  2 +-
>  drivers/net/wireless/ath/ath11k/Kconfig |  2 +-
>  drivers/net/wireless/ath/ath12k/Kconfig |  2 +-
>  drivers/pci/pwrctrl/Kconfig             | 27 +++++++++++++++++++------
>  drivers/pci/pwrctrl/Makefile            |  8 ++++----
>  5 files changed, 28 insertions(+), 13 deletions(-)
> 
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

