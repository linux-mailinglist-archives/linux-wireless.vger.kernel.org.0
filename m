Return-Path: <linux-wireless+bounces-4006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0F86748F
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 13:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9251F268BA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFBD604A7;
	Mon, 26 Feb 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymWKJzS5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABA604AE
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949749; cv=none; b=j/yY+lxPq7bsC3zDSpd8eU2Erfrj7Zud+z9UjCElcAUB46IXGxdwc5T8SwV+1HgjhoMbUa6yLluK/bPaODYrBegN+0nUzEwX2ZYJqXHeqvpXE8Pc3+KHPidLymTGBDQnTcU8ld5sJhvMBJIwTWytMij68G1aMU6zuCkC8nb2WFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949749; c=relaxed/simple;
	bh=yCr1cL0g49Fc+3NlFvIIDf1tArV8B3nCuYxeBbV2Qss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmAC3j4NVy7WdNawK1Ak27dectNFmvrQMtBnNBTa4FCv0TY5IGfvbW0AKZ59Nzb/rIzUal8uxBulJneGVfWqAo9M9Xe73oqXe1YqIv9f7ENCSAfkL/qSjtF2u+gHcz+vspugjb/3vZyilA2A/jkFptqde39/Jvror4i/CbPStRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymWKJzS5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso2181814a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708949746; x=1709554546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k6zd1PEyLITWZm9KL/dK4q9knEoV+TXO6CvpPczfz6M=;
        b=ymWKJzS5bJt0VA37jYc2epz8yBQPw32Pa+57aXiOGJ8t13SK7eqDXgverxxEnbxvRE
         qhkvW+TmtlY9s7QNZlq8MVCsZjkbkZiZfSh5PQdWNgbcRD3YUZiDp5Hd/FIxwvlYgniA
         XVRt6EPeJq8WfheZgZdbJSIebRjNmC5o3zhDQS7rgrQuivTU5QktXYj9z71vdhIOVfSF
         cK+sr/VFoJjrgxsKMELq4bns8EId0bIfZRNBWwuqbzSkP2WW96ug3j+1LVQm+diNCaU/
         71aNMkjDm1xLXPe10ZpmA/cm3edqDPY86RQ5vsA9JxVwuad+7ptRXExMVL0/dnCfEQYe
         Z1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708949746; x=1709554546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6zd1PEyLITWZm9KL/dK4q9knEoV+TXO6CvpPczfz6M=;
        b=GI4lbI2NBLWf+xn5ci/KSdhp2PsCy7xvHVBHXc5Lp5/Yj29epp36H1NVm3waPM7cbM
         np3+ulCXOQHEkSfCCAyO+PhiR+dnEZmuQYD6/RBsiHhGOU0XISDbFRbt4TTcxQbfAANz
         4vFMOetzjZlq+hZrV/I0SqwF5b+kTo0UexW9cmPE51NvPP7EbDn2g1GbcabOSCwEmDIn
         0xI7ULbpvq7jWyAuQyxyNird+rl51INMv4yeBdfvuBQdaZ9+C4R1vJXF6IbIwEP2Otwc
         kKOD3BoE2YkHhAafp5PMh4EfHQfOOuI0i39NooKqACJvw65fgcMyHkXcWYwEbyoiBvii
         +Gag==
X-Forwarded-Encrypted: i=1; AJvYcCVvz7GdDDMCsfSc4sUhhrsEA0xk98m56Lm8O8cBzmGmAkue5sOMqHKJrdydvDsVHYH9PDC3QQx8JPw08wQtLTDlLoRMo87fKadQ4umnVZE=
X-Gm-Message-State: AOJu0YwKrkj32rWPwjboI13Hyn4pa+kb2+brtgAlTg/W3rHO6U64WLZ2
	imnbj3C3F+DyEUYglyocwa8QzfU6Dn1JkudnTtI/imf+3g+LkhM2l0opu+JRbw==
X-Google-Smtp-Source: AGHT+IFDKTAEwU7H2ub/fu0Zunzeq97i1ADGULrYokdFChSWx4DN0La9rIhOTdH6MyK96EtToENjlA==
X-Received: by 2002:a05:6a21:31c7:b0:1a0:adbc:7a96 with SMTP id zb7-20020a056a2131c700b001a0adbc7a96mr5643823pzb.36.1708949746498;
        Mon, 26 Feb 2024 04:15:46 -0800 (PST)
Received: from thinkpad ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id p18-20020a056a0026d200b006e45b910a98sm3912974pfw.6.2024.02.26.04.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:15:46 -0800 (PST)
Date: Mon, 26 Feb 2024 17:45:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, mhi@lists.linux.dev,
	linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] bus: mhi: host: add mhi_power_down_no_destroy()
Message-ID: <20240226121542.GD8422@thinkpad>
References: <20240221030026.10553-1-quic_bqiang@quicinc.com>
 <20240221030026.10553-2-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221030026.10553-2-quic_bqiang@quicinc.com>

On Wed, Feb 21, 2024 at 11:00:24AM +0800, Baochen Qiang wrote:
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
> To fix this add new function mhi_power_down_no_destroy() which doesn't destroy
> the devices for channels during power down. This way we avoid probe defer issue
> and finally can get ath11k hibernation working with the following patches.
> 

Upto this line is the actual commit message and below should be moved to the
comments section of the patch.

> Actually there is an RFC version of this change and it gets positive results
> from multiple users. Firstly Mani doesn't like this idea and insists that an
> MHI device should be destroyed when going to suspend/hibernation, see
> 
> https://lore.kernel.org/mhi/20231127162022.518834-1-kvalo@kernel.org/
> 
> Then Mani changed his mind after a further discussion with kernel PM guys,
> see
> 
> https://lore.kernel.org/all/21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com/
> 
> So we come up with the regular version and it is almost identical with that RFC
> version.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/bus/mhi/host/internal.h |  4 +++-
>  drivers/bus/mhi/host/pm.c       | 36 +++++++++++++++++++++++++++------
>  include/linux/mhi.h             | 15 +++++++++++++-
>  3 files changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 091244cf17c6..8ce4aec56425 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -86,6 +86,7 @@ enum dev_st_transition {
>  	DEV_ST_TRANSITION_FP,
>  	DEV_ST_TRANSITION_SYS_ERR,
>  	DEV_ST_TRANSITION_DISABLE,
> +	DEV_ST_TRANSITION_DISABLE_DESTROY_DEVICE,
>  	DEV_ST_TRANSITION_MAX,
>  };
>  
> @@ -96,7 +97,8 @@ enum dev_st_transition {
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
> index 8b40d3f01acc..5686d32f7458 100644
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
> @@ -530,8 +531,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
>  	dev_dbg(dev, "Waiting for all pending threads to complete\n");
>  	wake_up_all(&mhi_cntrl->state_event);
>  
> -	dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
> -	device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);

I'd be nice to add a comment here on why destroying the device is optional.

> +	if (destroy_device) {
> +		dev_dbg(dev, "Reset all active channels and remove MHI devices\n");
> +		device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL, mhi_destroy_device);
> +	}
>  
>  	mutex_lock(&mhi_cntrl->pm_mutex);
>  
> @@ -821,7 +824,10 @@ void mhi_pm_st_worker(struct work_struct *work)
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
> @@ -1175,7 +1181,8 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  }
>  EXPORT_SYMBOL_GPL(mhi_async_power_up);
>  
> -void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
> +static void __mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful,
> +			     bool destroy_device)
>  {
>  	enum mhi_pm_state cur_state, transition_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -1211,15 +1218,32 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
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
> +void mhi_power_down_no_destroy(struct mhi_controller *mhi_cntrl,

How about "mhi_power_down_keep_dev"? Not the best of the API naming suggestion,
but it reflects what the API does.

> +			       bool graceful)
> +{
> +	__mhi_power_down(mhi_cntrl, graceful, false);
> +}
> +EXPORT_SYMBOL_GPL(mhi_power_down_no_destroy);
> +
>  int mhi_sync_power_up(struct mhi_controller *mhi_cntrl)
>  {
>  	int ret = mhi_async_power_up(mhi_cntrl);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 474d32cb0520..39a6a944a52c 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -647,12 +647,25 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl);
>  int mhi_sync_power_up(struct mhi_controller *mhi_cntrl);
>  
>  /**
> - * mhi_power_down - Start MHI power down sequence
> + * mhi_power_down - Start MHI power down sequence. See also

How about?

	/**
	 * mhi_power_down - Power down the MHI device and also destroy the
	 * 		    'struct device' for the channels associated with it.

	 ...

	 * See also mhi_power_down_keep_dev() which is a variant of
	 * this API that keeps the 'struct device' for channels (useful during
	 * suspend/hibernation).
	 */

> + * mhi_power_down_no_destroy() which is a variant of this for
> + * suspend/hibernation.
> + *
>   * @mhi_cntrl: MHI controller
>   * @graceful: Link is still accessible, so do a graceful shutdown process
>   */
>  void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful);
>  
> +/**
> + * mhi_power_down_no_destroy - Start MHI power down sequence but don't destroy
> + * struct devices for channels. This is a variant for mhi_power_down() and
> + * would be useful in suspend/hibernation.
> + *

	/**
	 * mhi_power_down_keep_dev - Power down the MHI device but keep the
	 * 			     'struct device' for the channels
	 *			     associated with it.

	 ...

	 * This is a variant of 'mhi_power_down' and useful in scenarios such as
	 * suspend/hibernation where destroying of the 'struct device' is not
	 * needed.
	 */

- Mani

> + * @mhi_cntrl: MHI controller
> + * @graceful: Link is still accessible, so do a graceful shutdown process
> + */
> +void mhi_power_down_no_destroy(struct mhi_controller *mhi_cntrl, bool graceful);
> +
>  /**
>   * mhi_unprepare_after_power_down - Free any allocated memory after power down
>   * @mhi_cntrl: MHI controller
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

