Return-Path: <linux-wireless+bounces-2849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64041842B6E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02F81F2641F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B214E2D8;
	Tue, 30 Jan 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhjOEXNN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3E151CE2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 18:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637861; cv=none; b=hKAvYjMKHGlGlwy/ORcqTRsjXSOlhD8CXpg0usENS012Yf4b/gR2Q6G+gqaMz2fEh8k4kH8redITIySfSAStpwD3ecqx56SmWYFtsGyTu/PdzU0XAKZoUSGJHoRjstVm8O1KYcUF4bA71o7o4ERw1uWkUZc3fbS5tSOlFRT/K8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637861; c=relaxed/simple;
	bh=V78DnBYedopWK85p/TXru3XCznMVJAsqjvqz3X/y8yA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB/yxwS/OqunjCPER9BYRnKNjNitWnK4QfoLjtl9AqqxnPG6xWPJPV8EatFBDr8KwLzcTMqUs6Iurjslq0QzopkiCOj4ZT50+C6W7T8etOc87QQroPUa2dnAsMC7mTQ6Bdqiv2ROcdp4txD0gKIQ9qyqQG6S7wWcr3qgO1EUMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OhjOEXNN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d835c7956bso2379695a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706637859; x=1707242659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F5rCUPWRVnCWABaRNN1h1y1plAtstVCj5fDa010mMEE=;
        b=OhjOEXNNMmRhdpzU10k1evuZieN30HUJym81I+PIWKd46mITo71hQD+zQoSrYsgPGv
         v4U8QNsMFBgEf6iQLpDpKNoyGMbJ8A5Sxh9lXNI82XV+9np7+WeEoGXu2aK8/1+DHTF2
         Qr5OoK4y+gOM39SbLnCimYVP2iWh5Ce9sfYeT6CnBB1wUjLRISlE5KeeqEyEkAfhfjsk
         H0EIU35IylJoPlbMnwjO3/IXTpDLXnSZymGwvdvBK69xJBMUfd6lTlI1FfoP2dz6VcLI
         uAgd/tMHfN9l/vC9ZUoMAuRmIkhnsscBNaFkxAzbpC192IQ/mLx6RjriCxT7hdlqhjhW
         MUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706637859; x=1707242659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F5rCUPWRVnCWABaRNN1h1y1plAtstVCj5fDa010mMEE=;
        b=Mm12Zs/aN92zQONBX+jFtpWGjt/mreCkDu2Xtr70T1BKdw9FhxJrOHxpDWhVuEEoz6
         hfA6ljlYl0oBYaElqmya2TS7GBX0ItBQbFEMbgT5biqc6T1oqIcZiRC566kyZ6irqzKt
         ILQAr4rwIk4wMbIr4gY/ZlkoGnBT12I3jPXtSrqjIqUtnBM7kmOqS9CfZfXKXLT8vpu+
         fOs53k4vQqqPMCFXCcyQpnh03n6j5knK7EfJiWX0tT9CDq2cruRU6+gn71t6fwscANcW
         yJ0Ycf9Wa15jEMhlJAKgTPR8vATem/X4TiN5LNZF6yAyKw/UEv/yGToSyQ5mWsEM0r4O
         L3Iw==
X-Gm-Message-State: AOJu0Yy8Zh+WfpYiJgQ7JjfLFXle1/6PA75QWtkyacjwSQY1vlhiwDml
	wQ4M3Aj7GPT25iy+n9v3YzVKaaTze7ExeWmbPpEbTjHIYBDHDchaDfY5baLLNg==
X-Google-Smtp-Source: AGHT+IE24Ukg4bkh+RCYauvJd0iOfN2NlWT2ru38iOlXAK6Nun7jw7rCxMFXPNnCOVxpNigZ9/ANMQ==
X-Received: by 2002:a05:6a21:3502:b0:19c:841a:99e4 with SMTP id zc2-20020a056a21350200b0019c841a99e4mr4623182pzb.6.1706637859071;
        Tue, 30 Jan 2024 10:04:19 -0800 (PST)
Received: from thinkpad ([103.28.246.123])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006ddc2cf3662sm8115605pfu.184.2024.01.30.10.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:04:18 -0800 (PST)
Date: Tue, 30 Jan 2024 23:34:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: mhi@lists.linux.dev, ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/8] bus: mhi: host: add
 mhi_power_down_no_destroy()
Message-ID: <20240130180411.GA4218@thinkpad>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-2-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127162022.518834-2-kvalo@kernel.org>

On Mon, Nov 27, 2023 at 06:20:15PM +0200, Kalle Valo wrote:
> From: Baochen Qiang <quic_bqiang@quicinc.com>
> 
> If ath11k tries to call mhi_power_up() during resume it fails:
> 

This is confusing! Maybe this is what confused me initially. mhi_sync_power_up()
never fails, but ath11k timesout waiting for QMI. You also confirmed the same
[1].

> ath11k_pci 0000:06:00.0: timeout while waiting for restart complete
> 
> This happens because when calling mhi_power_up() the MHI subsystem eventually
> calls device_add() from mhi_create_devices() but the device creation is
> deferred:
> 
> mhi mhi0_IPCR: Driver qcom_mhi_qrtr force probe deferral
> 
> The reason for deferring device creation is explained in dpm_prepare():
> 
> 	/*
> 	 * It is unsafe if probing of devices will happen during suspend or
> 	 * hibernation and system behavior will be unpredictable in this case.
> 	 * So, let's prohibit device's probing here and defer their probes
> 	 * instead. The normal behavior will be restored in dpm_complete().
> 	 */
> 
> Because the device probe is deferred, the qcom_mhi_qrtr_probe() is not called and
> qcom_mhi_qrtr_dl_callback() fails silently as qdev is zero:
> 
> static void qcom_mhi_qrtr_dl_callback(struct mhi_device *mhi_dev,
> 				      struct mhi_result *mhi_res)
> {
> 	struct qrtr_mhi_dev *qdev = dev_get_drvdata(&mhi_dev->dev);
> 	int rc;
> 
> 	if (!qdev || mhi_res->transaction_status)
> 		return;
> 
> So what this means that QRTR is not delivering messages and the QMI connection
> is not working between ath11k and the firmware, resulting a failure in firmware
> initialisation.
> 
> To fix this add new function mhi_power_down_no_destroy() which does not destroy
> the devices during power down. This way mhi_power_up() can be called during
> resume and we can get ath11k hibernation working with the following patches.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/bus/mhi/host/init.c     |  1 +
>  drivers/bus/mhi/host/internal.h |  1 +
>  drivers/bus/mhi/host/pm.c       | 26 +++++++++++++++++++-------
>  include/linux/mhi.h             | 29 +++++++++++++++++++++++++++--
>  4 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index 65ceac1837f9..e626b03ffafa 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -43,6 +43,7 @@ const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX] = {
>  	[DEV_ST_TRANSITION_FP] = "FLASH PROGRAMMER",
>  	[DEV_ST_TRANSITION_SYS_ERR] = "SYS ERROR",
>  	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
> +	[DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE] = "DISABLE (DESTROY DEVICE)",
>  };
>  
>  const char * const mhi_ch_state_type_str[MHI_CH_STATE_TYPE_MAX] = {
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 30ac415a3000..3f45c9c447bd 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -69,6 +69,7 @@ enum dev_st_transition {
>  	DEV_ST_TRANSITION_FP,
>  	DEV_ST_TRANSITION_SYS_ERR,
>  	DEV_ST_TRANSITION_DISABLE,
> +	DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE,
>  	DEV_ST_TRANSITION_MAX,
>  };
>  
> diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
> index a2f2feef1476..8833b0248393 100644
> --- a/drivers/bus/mhi/host/pm.c
> +++ b/drivers/bus/mhi/host/pm.c
> @@ -458,7 +458,8 @@ static int mhi_pm_mission_mode_transition(struct mhi_controller *mhi_cntrl)
>  }
>  
>  /* Handle shutdown transitions */
> -static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
> +static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
> +				      bool destroy_device)
>  {
>  	enum mhi_pm_state cur_state;
>  	struct mhi_event *mhi_event;
> @@ -520,8 +521,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  	dev_dbg(dev, "Waiting for all pending threads to complete\n");
>  	wake_up_all(&mhi_cntrl->state_event);
>  
> -	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
> -	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
> +	if (destroy_device) {
> +		dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
> +		device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
> +	}
>  
>  	mutex_lock(&mhi_cntrl->pm_mutex);
>  
> @@ -806,7 +809,10 @@ void mhi_pm_st_worker(struct work_struct *work)
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
> @@ -1160,7 +1166,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  }
>  EXPORT_SYMBOL_GPL(mhi_async_power_up);
>  
> -void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
> +void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
> +		      bool destroy_device)
>  {
>  	enum mhi_pm_state cur_state, transition_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -1196,14 +1203,19 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
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
> -EXPORT_SYMBOL_GPL(mhi_power_down);
> +EXPORT_SYMBOL_GPL(__mhi_power_down);

This is a helper, so should not be exported. You should export the API instead.

>  
>  int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
>  {
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index d0f9b522f328..ae092bc8b97e 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -648,12 +648,37 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
>   */
>  int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
>  
> +void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
> +		    bool destroy_device);

This is a helper, so make it static.

> +
>  /**
> - * mhi_power_down - Start MHI power down sequence
> + * mhi_power_down - Start MHI power down sequence. See also
> + * mhi_power_down_no_destroy() which is a variant of this for suspend.

suspend/hibernation

> + *
>   * @mhi_cntrl: MHI controller
>   * @graceful: Link is still accessible, so do a graceful shutdown process
>   */
> -void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful);
> +static inline void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)

No, API cannot be static inline. Make it global.

> +{
> +	__mhi_power_down(mhi_cntrl, graceful, true);
> +}
> +
> +/**
> + * mhi_power_down_no_destroy - Start MHI power down sequence but don't
> + * destroy struct devices. This is a variant for mhi_power_down() and is a

"struct devices for channels"

> + * workaround to make it possible to use mhi_power_up() in a resume

You should mention that the devices are not destroyed and this would be useful
in suspend/hibernation.

> + * handler. When using this variant the caller must also call
> + * mhi_prepare_all_for_transfer_autoqueue() and

mhi_prepare_all_for_transfer*()

> + * mhi_unprepare_all_from_transfer().
> + *
> + * @mhi_cntrl: MHI controller
> + * @graceful: Link is still accessible, so do a graceful shutdown process
> + */
> +static inline void mhi_power_down_no_destroy(struct mhi_controller *mhi_cntrl,
> +					     bool graceful)

Same as above, make it global.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

