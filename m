Return-Path: <linux-wireless+bounces-2929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D6E8454B2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 11:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC5B1F2B3D2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 10:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6734DA0B;
	Thu,  1 Feb 2024 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQfF4uE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557664DA09
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781648; cv=none; b=LEvMKfT6C8UoEKf3CZFrT8zFfZUCOQC69ZE77YFWuE8LvasNTfI92nc/fv6RE0uJS/KTFYF66JEPPc8pzOse/YRQulCq8H2kL0u6D8JFs/oo50yOII3RJvYIXjwFbzzT7nH8isVt7CKibu/pv6gDiZc51UCW10v5Qhf9zMxscGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781648; c=relaxed/simple;
	bh=YNlN8yDk5aO/yvRInRO8XtX+T7e4+hdzdwTE1pq56bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9M8AD3Shov0ift3Z2XcS53U//jLfHUtclhBCAQ7t1oZ/Y7jEn84wOgSzyK0v8coIWj99b4x+1pZTv8F5x7A6KN5noaJQFKkusLTqYdtdH2meJDk5m5LwY5/5v7a1RsjhtXr5njl42OnD8aWKP40BRZAmEqExdwYosfH7gThLIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQfF4uE+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da202aa138so449727b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 01 Feb 2024 02:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706781646; x=1707386446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MtEt022kkPXVXmIT70xulNhz204nKO73T0HIbZTpt3c=;
        b=cQfF4uE+3UOHpArhb7eH7UwaBVMzvXaPZyLoE+GiO98EAWART+sEfbJLUtkSMK5Hvk
         9SwUZ8H/5MQ4dowOylcdLBZqUczuEeebXx+ApLNxEc2cZAsSOjLvwI6Bfk3yDcX8GoqJ
         v4ZXghT+EWkOFCnJImaiyi1Zu8xxBOHpBWNGMhEruyJ1dGCQoxlJfXOm4jIstoUnb4F1
         l2cKDbYPQR2poc0dVZ1j5rrMhcf1eOju3214I7g3k/jn8iCEZnQmQFuLQWxk6cDT3ns7
         8Nb8NniC/HfgW9PAJziRWLFfdneSCmq2trIMPEZ+/GiSLovIN+3HOGvakiLlv8ECfheM
         01CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706781646; x=1707386446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtEt022kkPXVXmIT70xulNhz204nKO73T0HIbZTpt3c=;
        b=su11Y6p6E7BrGpZmzFak53zWCjDdqwv+fZ5yP/EMRK7C/rrlRBXMPqcVLXKRJs0Tkt
         XcgdZKT6P0YjmjZdu6H3BUkpCH+ZjZ2HkB07U/we8rsZxgYhfP7NlNxEonHVBxueiDjQ
         rWO5G3rMgcJ1s8hwx4sQhQ4/HaVnuljaag60SDfFGgTH9hCvbIx4A7ExngOSpPhCSGvj
         iLKS4bM8Eb30jRCzY7Q/ujQoXLOTs6pn/wdwB5ZErFxtRXwzkLnseKsob8jqRXh60ABj
         tBTt6K8UDJb2y7iWaaNoBMTNnp3LYWaJQO5NODSuXLyVbL4C2Mxjh3FfhkeJXIPbWpNv
         Hayg==
X-Gm-Message-State: AOJu0YwZzk/hpPoi4D6vg9W4tVG35mOz02IOYKnVpf2xAPy7WsaqlMRQ
	D8ROrTbD0unDyPuHTWX5W5mh+wt9HuqhtEhfM/rY2vq6G7uKaCcVEgRDS8z2lQ==
X-Google-Smtp-Source: AGHT+IF+MGpP/C7cfZjCjiG2aRdHkdHtz96E7vnVzdz00IberE36RJU8ufLm/3ynoxUiAbLUZ2NUiw==
X-Received: by 2002:a05:6a00:830d:b0:6dd:a0a5:141f with SMTP id gd13-20020a056a00830d00b006dda0a5141fmr3943855pfb.28.1706781645551;
        Thu, 01 Feb 2024 02:00:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXVWK7ZNbXwm8vo/FW2JCaF4MCdQw3rEaFqlzDa/y5YlePi0w/NMK0AEl0x8jlw0AbXA9MhulRZ+/8PwRsfzInBnqlY1r3hro1Tt8zcjhBxn5KeDzZrmq98Ak8CZC517clv5wEvyNOvk0H/BttdCSmlwXbr97Wxfaoa2qNX26Ew
Received: from thinkpad ([117.248.5.99])
        by smtp.gmail.com with ESMTPSA id r6-20020a056a00216600b006dbda1b19f7sm11389533pff.159.2024.02.01.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 02:00:45 -0800 (PST)
Date: Thu, 1 Feb 2024 15:30:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, mhi@lists.linux.dev,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/8] bus: mhi: host: add new interfaces to handle
 MHI channels directly
Message-ID: <20240201100040.GB17027@thinkpad>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-3-kvalo@kernel.org>
 <20240130181938.GB4218@thinkpad>
 <d002afe9-3c01-413c-82d2-353db0356802@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d002afe9-3c01-413c-82d2-353db0356802@quicinc.com>

On Wed, Jan 31, 2024 at 03:39:26PM +0800, Baochen Qiang wrote:
> 
> 
> On 1/31/2024 2:19 AM, Manivannan Sadhasivam wrote:
> > On Mon, Nov 27, 2023 at 06:20:16PM +0200, Kalle Valo wrote:
> > > From: Baochen Qiang <quic_bqiang@quicinc.com>
> > > 
> > > When using mhi_power_down_no_destroy() MHI hosts need to unprepare MHI channels
> > > by themselves.  Similarly, MHI stack will also not create new MHI device since
> > > old devices were not destroyed, so MHI hosts need to prepare channels as well.
> > > Hence add these two interfaces to make that possible.
> > > 
> > > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> > > 
> > > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> > > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> > > ---
> > >   drivers/bus/mhi/host/main.c | 107 ++++++++++++++++++++++++++++++++++++
> > >   include/linux/mhi.h         |  20 ++++++-
> > >   2 files changed, 126 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> > > index d80975f4bba8..3f677fc628ad 100644
> > > --- a/drivers/bus/mhi/host/main.c
> > > +++ b/drivers/bus/mhi/host/main.c
> > > @@ -1669,6 +1669,58 @@ int mhi_prepare_for_transfer_autoqueue(struct mhi_device *mhi_dev)
> > >   }
> > >   EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer_autoqueue);
> > > +static int ____mhi_prepare_for_transfer(struct device *dev, void *data)
> > 
> > "__mhi_prepare_all_for_transfer"
> 
> This is to prepare one single child device, I don't think a name like
> __mhi_prepare_all_for_transfer (with 'all' inside) make sense, right?
> How about changing to "mhi_prepare_dev_for_transfer" or
> "mhi_prepare_single_for_transfer"?
> 

I think most of the checks in this function can be moved inside
mhi_prepare_for_transfer() API. With that you can just reuse the API without
adding a new helper.

For autoqueue channels, you can add another API
mhi_prepare_all_for_transfer_autoqueue() just like
mhi_prepare_for_transfer_autoqueue() to maintain uniformity.

- Mani

> > 
> > > +{
> > > +	struct mhi_device *mhi_dev;
> > > +	struct mhi_chan *ul_chan, *dl_chan;
> > > +	enum mhi_ee_type ee = MHI_EE_MAX;
> > 
> > Reverse Xmas order, please.
> > 
> > > +
> > > +	if (dev->bus != &mhi_bus_type)
> > > +		return 0;
> > > +
> > > +	mhi_dev = to_mhi_device(dev);
> > > +
> > > +	/* Only prepare virtual devices that are attached to bus */
> > 
> > "Only prepare virtual devices for the channels". Here and below.
> > 
> > > +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> > > +		return 0;
> > > +
> > > +	/* There are cases where there is no MHI client driver matches
> > > +	 * this device, we are not allowed to do prepare for it.
> > > +	 */
> > 
> > Use the preferred style for comment:
> > 
> > 	/*
> > 	 * ...
> > 	 */
> > 
> > > +	if (!mhi_dev->id)
> > > +		return 0;
> > > +
> > > +	ul_chan = mhi_dev->ul_chan;
> > > +	dl_chan = mhi_dev->dl_chan;
> > > +
> > > +	/*
> > > +	 * If execution environment is specified, remove only those devices that
> > > +	 * started in them based on ee_mask for the channels as we move on to a
> > > +	 * different execution environment
> > > +	 */
> > > +	if (data)
> > > +		ee = *(enum mhi_ee_type *)data;
> > > +
> > > +	if (ul_chan && ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
> > > +		return 0;
> > > +
> > > +
> > 
> > Remove extra newline.
> > 
> > > +	if (dl_chan && ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
> > > +		return 0;
> > > +
> > > +	if (dl_chan->pre_alloc)
> > > +		return mhi_prepare_for_transfer_autoqueue(mhi_dev);
> > > +	else
> > > +		return mhi_prepare_for_transfer(mhi_dev);
> > > +}
> > > +
> > > +int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl)
> > > +{
> > > +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
> > > +				     ____mhi_prepare_for_transfer);
> > > +}
> > > +EXPORT_SYMBOL_GPL(mhi_prepare_all_for_transfer);
> > > +
> > >   void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
> > >   {
> > >   	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> > > @@ -1684,3 +1736,58 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
> > >   	}
> > >   }
> > >   EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
> > > +
> > > +static int ____mhi_unprepare_from_transfer(struct device *dev, void *data)
> > 
> > __mhi_unprepare_all_from_transfer
> 
> same as above.
> 
> > 
> > > +{
> > > +	struct mhi_device *mhi_dev;
> > > +	struct mhi_chan *ul_chan, *dl_chan;
> > > +	enum mhi_ee_type ee = MHI_EE_MAX;
> > > +
> > > +	if (dev->bus != &mhi_bus_type)
> > > +		return 0;
> > > +
> > > +	mhi_dev = to_mhi_device(dev);
> > > +
> > > +	/* Only unprepare virtual devices that are attached to bus */
> > > +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> > > +		return 0;
> > > +
> > > +	/* There are cases where there is no MHI client driver matches
> > > +	 * this device, so it is not probed or prepared, no need to
> > > +	 * do unprepare for it.
> > > +	 */
> > > +	if (!mhi_dev->id)
> > > +		return 0;
> > > +
> > > +	ul_chan = mhi_dev->ul_chan;
> > > +	dl_chan = mhi_dev->dl_chan;
> > > +
> > > +	/*
> > > +	 * If execution environment is specified, remove only those devices that
> > > +	 * started in them based on ee_mask for the channels as we move on to a
> > > +	 * different execution environment
> > > +	 */
> > > +	if (data)
> > > +		ee = *(enum mhi_ee_type *)data;
> > > +
> > > +	if (ul_chan) {
> > > +		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
> > > +			return 0;
> > > +	}
> > > +
> > > +	if (dl_chan) {
> > > +		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
> > > +			return 0;
> > > +	}
> > > +
> > > +	mhi_unprepare_from_transfer(mhi_dev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl)
> > > +{
> > > +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
> > > +				     ____mhi_unprepare_from_transfer);
> > > +}
> > > +EXPORT_SYMBOL_GPL(mhi_unprepare_all_from_transfer);
> > > diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> > > index ae092bc8b97e..dcf62a57056a 100644
> > > --- a/include/linux/mhi.h
> > > +++ b/include/linux/mhi.h
> > > @@ -668,7 +668,7 @@ static inline void mhi_power_down(struct mhi_controller *mhi_cntrl, bool gracefu
> > >    * destroy struct devices. This is a variant for mhi_power_down() and is a
> > >    * workaround to make it possible to use mhi_power_up() in a resume
> > >    * handler. When using this variant the caller must also call
> > > - * mhi_prepare_all_for_transfer_autoqueue() and
> > > + * mhi_prepare_all_for_transfer() and
> > 
> > This change belongs to previous patch.
> > 
> > >    * mhi_unprepare_all_from_transfer().
> > >    *
> > >    * @mhi_cntrl: MHI controller
> > > @@ -842,4 +842,22 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
> > >    */
> > >   bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
> > > +/**
> > > + * mhi_prepare_all_for_transfer - if you are using
> > > + * mhi_power_down_no_destroy() variant this needs to be called after
> > > + * calling mhi_power_up().
> > 
> > Add info about what this API does also.
> > 
> > > + *
> > > + * @mhi_cntrl: MHI controller
> > > + */
> > > +int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl);
> > > +
> > > +/**
> > > + * mhi_unprepare_all_from_transfer - if you are using
> > > + * mhi_power_down_no_destroy() variant this function needs to be called
> > > + * before calling mhi_power_down_no_destroy().
> > 
> > Same as above.
> > 
> > - Mani
> > 
> > > + *
> > > + * @mhi_cntrl: MHI controller
> > > + */
> > > +int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl);
> > > +
> > >   #endif /* _MHI_H_ */
> > > -- 
> > > 2.39.2
> > > 
> > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

