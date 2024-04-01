Return-Path: <linux-wireless+bounces-5711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 502BA893A50
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 12:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95AE8B20A84
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27D1CD22;
	Mon,  1 Apr 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q60fcdFE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387AB23BF
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968556; cv=none; b=CGBc9zmqeAfycQIbhBVSw6Nd9yHD+mAthkPSc55IfaQPzyWCVuOH5ZjkKT2fuqAE3FS9o8aTYxXeDwEQnAwVTh7UeODDBSN3SqH0E0CnDZZ88fxHzlJsau/qol3Xppqrg2ecPTy6FuMkhzwrjqRep9W8QmdYMDdkXbcvDHoW5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968556; c=relaxed/simple;
	bh=QJMJfCdLEuJ+FfMXIfDmDR+++PbMg13/naaZeMO3ZkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm/S1bZicN3582AhOHM8+VIX/GJXhIGkBdAEMCnLhYyrDQlwsM7mNa9Dz60ZSz3lI0/b/Qe6wJKe70hfWVd7ZnPY872QmufeKSePFUM91B6YQsTnOc1tF0aoaYzPeC7pHLKABvU2rvHLNqK8Hfcewg+FnP1CZx4DNJMpWodP1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q60fcdFE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e0b889901bso29895425ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Apr 2024 03:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711968553; x=1712573353; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tKCS9QdnAwWbuZtYBI4sT1iLB4Tt93btjF36mrIzaXY=;
        b=q60fcdFEN4aNls9TEmF7ITGr2b9XQR2XAyKsqz4xSEAhGn6afQws0uCalOxuCQm20Q
         BOuO+rD79N8bosPS0H1mekcXxAlJE5gRKc5ShT9Qo2UZXzn5Fcjn0vj9psT2yn+1ooyH
         n+nVSUy7u6A47xsRykHLDj+fBxRQn74JEBHSTk7qHDVey/00vvEqcY67FptMghTpATFv
         AiLBPDs5LcZU7qCq0q9V1Xb/eMfPjIGJu4HKMTeqx1zQu+FXiJ+2Xdve94lS+KeESGar
         kAwZQ3P8ElobJG5x14x4MMwQcUPI54/RwlPtI82y49cYqGYm0TxCtoH6/cM66R9r1/TR
         rDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711968553; x=1712573353;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKCS9QdnAwWbuZtYBI4sT1iLB4Tt93btjF36mrIzaXY=;
        b=ePXySgxk0PaLUijd7jfhN4hCneE+6ZoLn3wubCR0CnygvF/8Srds8990KryhMPSwSM
         CivbxjQnIjwhg85TV8zgpevN1EVkqxPF+gjcYDBrwfppSUaEzNKIdRrAyOdwgbYxeYWt
         z4XpzrFqj/wzKXne8LnJFPJBIkmTAb5xMrlheaEjyXMRc3okV9dSPjDzMwzPWEhzZnpK
         cC3xOJs1O3IMmeF388rHZndRRzmpEVeRHljP6PlIjEdtF/cbISjWSazuyCyX+bOs1i3U
         GJLZZqwbbbqvv5YoaWBHisty5h9sUxEfzR8JN912Wd5x1eHXzIx6sluXK0ij1CqhftYK
         4MuA==
X-Forwarded-Encrypted: i=1; AJvYcCW7tyQPR9Ii6sdyoX4RG6J4fksLF3IlTe0dn++ITsAwQoy2F3K36jHZSH2Rk7n4t0KPhmWGhDMCxRpHKBqf8/EGpT8gOaf5poKsDtL5yRs=
X-Gm-Message-State: AOJu0YyDdxRGuy7Xzti06B5k6knjlcYZmfNAk0SiK537otXu/pkbHB75
	pEuKQvKEOq9XWs5eqJaawrvDWdhnq/Qr0uO8cGQ3hIKPRJiwoNELln/55wTQmg==
X-Google-Smtp-Source: AGHT+IFF770fgs+yMHKwTIlLL3P039OFnIkWdfZJY4CvGxJUM7y7krgfn19E1tYKv8Gdk6uxTqFDKA==
X-Received: by 2002:a17:902:e802:b0:1e0:b862:5330 with SMTP id u2-20020a170902e80200b001e0b8625330mr10121788plg.54.1711968553329;
        Mon, 01 Apr 2024 03:49:13 -0700 (PDT)
Received: from thinkpad ([103.28.246.102])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001e0b5eee802sm8552693plf.123.2024.04.01.03.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 03:49:12 -0700 (PDT)
Date: Mon, 1 Apr 2024 16:19:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/3] bus: mhi: host: add mhi_power_down_keep_dev()
Message-ID: <20240401104908.GA234427@thinkpad>
References: <20240305021320.3367-1-quic_bqiang@quicinc.com>
 <20240305021320.3367-2-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305021320.3367-2-quic_bqiang@quicinc.com>

On Tue, Mar 05, 2024 at 10:13:18AM +0800, Baochen Qiang wrote:
> ath11k fails to resume:
> 
> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
> 
> This happens because when calling mhi_sync_power_up() the MHI subsystem
> eventually calls device_add() from mhi_create_devices() but the device
> creation is deferred:
> 
> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
> 
> The reason for deferring device creation is explained in dpm_prepare():
> 
>         /*
>          * It is unsafe if probing of devices will happen during suspend or
>          * hibernation and system behavior will be unpredictable in this case.
>          * So, let's prohibit device's probing here and defer their probes
>          * instead. The normal behavior will be restored in dpm_complete().
>          */
> 
> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not
> called and thus MHI channels are not prepared:
> 
> So what this means that QRTR is not delivering messages and the QMI connection
> is not working between ath11k and the firmware, resulting a failure in firmware
> initialization.
> 
> To fix this add new function mhi_power_down_keep_dev() which doesn't destroy
> the devices for channels during power down. This way we avoid probe defer issue
> and finally can get ath11k hibernation working with the following patches.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Applied to mhi-next! Note that this patch is also available in mhi-immutable
branch for ath11k maintainers to pull into their tree.

https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/log/?h=mhi-immutable

- Mani

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/bus/mhi/host/internal.h |  4 +++-
>  drivers/bus/mhi/host/pm.c       | 42 ++++++++++++++++++++++++++++-----
>  include/linux/mhi.h             | 18 +++++++++++++-
>  3 files changed, 56 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 5fe49311b8eb..aaad40a07f69 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -80,6 +80,7 @@ enum dev_st_transition {
>  	DEV_ST_TRANSITION_FP,
>  	DEV_ST_TRANSITION_SYS_ERR,
>  	DEV_ST_TRANSITION_DISABLE,
> +	DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE,
>  	DEV_ST_TRANSITION_MAX,
>  };
>  
> @@ -90,7 +91,8 @@ enum dev_st_transition {
>  	dev_st_trans(MISSION_MODE,	"MISSION MODE")		\
>  	dev_st_trans(FP,		"FLASH PROGRAMMER")	\
>  	dev_st_trans(SYS_ERR,		"SYS ERROR")		\
> -	dev_st_trans_end(DISABLE,	"DISABLE")
> +	dev_st_trans(DISABLE,		"DISABLE")		\
> +	dev_st_trans_end(DISABLE_DESTROY_DEVICE, "DISABLE (DESTROY DEVICE)")
>  
>  extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
>  #define TO_DEV_STATE_TRANS_STR(state) (((state) >= DEV_ST_TRANSITION_MAX) ? \
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index 8b40d3f01acc..11c0e751f223 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -468,7 +468,8 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
>  }
>  
>  /* Handle shutdown transitions */
> -static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
> +static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
> +				      bool destroy_device)
>  {
>  	enum mhi_pm_state cur_state;
>  	struct mhi_event *mhi_event;
> @@ -530,8 +531,16 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  	dev_dbg(dev, "Waiting for all pending threads to complete\n");
>  	wake_up_all(&mhi_cntrl->state_event);
>  
> -	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
> -	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
> +	/*
> +	 * Only destroy the 'struct device' for channels if indicated by the
> +	 * 'destroy_device' flag. Because, during system suspend or hibernation
> +	 * state, there is no need to destroy the 'struct device' as the endpoint
> +	 * device would still be physically attached to the machine.
> +	 */
> +	if (destroy_device) {
> +		dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
> +		device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
> +	}
>  
>  	mutex_lock(&mhi_cntrl->pm_mutex);
>  
> @@ -821,7 +830,10 @@ void mhi_pm_st_worker(struct work_struct *work)
>  			mhi_pm_sys_error_transition(mhi_cntrl);
>  			break;
>  		case DEV_ST_TRANSITION_DISABLE:
> -			mhi_pm_disable_transition(mhi_cntrl);
> +			mhi_pm_disable_transition(mhi_cntrl, false);
> +			break;
> +		case DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE:
> +			mhi_pm_disable_transition(mhi_cntrl, true);
>  			break;
>  		default:
>  			break;
> @@ -1175,7 +1187,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  }
>  EXPORT_SYMBOL_GPL(mhi_async_power_up);
>  
> -void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
> +static void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
> +			     bool destroy_device)
>  {
>  	enum mhi_pm_state cur_state, transition_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -1211,15 +1224,32 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>  	write_unlock_irq(&mhi_cntrl->pm_lock);
>  	mutex_unlock(&mhi_cntrl->pm_mutex);
>  
> -	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
> +	if (destroy_device)
> +		mhi_queue_state_transition(mhi_cntrl,
> +					   DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE);
> +	else
> +		mhi_queue_state_transition(mhi_cntrl,
> +					   DEV_ST_TRANSITION_DISABLE);
>  
>  	/* Wait for shutdown to complete */
>  	flush_work(&mhi_cntrl->st_worker);
>  
>  	disable_irq(mhi_cntrl->irq[0]);
>  }
> +
> +void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
> +{
> +	__mhi_power_down(mhi_cntrl, graceful, true);
> +}
>  EXPORT_SYMBOL_GPL(mhi_power_down);
>  
> +void mhi_power_down_keep_dev(struct mhi_controller *mhi_cntrl,
> +			       bool graceful)
> +{
> +	__mhi_power_down(mhi_cntrl, graceful, false);
> +}
> +EXPORT_SYMBOL_GPL(mhi_power_down_keep_dev);
> +
>  int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
>  {
>  	int ret = mhi_async_power_up(mhi_cntrl);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 77b8c0a26674..cde01e133a1b 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -630,12 +630,28 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
>  int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
>  
>  /**
> - * mhi_power_down - Start MHI power down sequence
> + * mhi_power_down - Power down the MHI device and also destroy the
> + *                  'struct device' for the channels associated with it.
> + *                  See also mhi_power_down_keep_dev() which is a variant
> + *                  of this API that keeps the 'struct device' for channels
> + *                  (useful during suspend/hibernation).
>   * @mhi_cntrl: MHI controller
>   * @graceful: Link is still accessible, so do a graceful shutdown process
>   */
>  void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful);
>  
> +/**
> + * mhi_power_down_keep_dev - Power down the MHI device but keep the 'struct
> + *                           device' for the channels associated with it.
> + *                           This is a variant of 'mhi_power_down()' and
> + *                           useful in scenarios such as suspend/hibernation
> + *                           where destroying of the 'struct device' is not
> + *                           needed.
> + * @mhi_cntrl: MHI controller
> + * @graceful: Link is still accessible, so do a graceful shutdown process
> + */
> +void mhi_power_down_keep_dev(struct mhi_controller *mhi_cntrl, bool graceful);
> +
>  /**
>   * mhi_unprepare_after_power_down - Free any allocated memory after power down
>   * @mhi_cntrl: MHI controller
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

