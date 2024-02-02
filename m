Return-Path: <linux-wireless+bounces-2996-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588E846908
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 08:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D61C23EBB
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 07:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4916217743;
	Fri,  2 Feb 2024 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZg0BKei"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2317590
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857819; cv=none; b=szGC78j848QMPkoKFEtYk7ZPPVq4/wKiH3nD93JXHB+iglkOPNqWPBQ5BA2C9re/YPI8rJ8ZLY1OqFw5XMgVR6rpSjkSOSpMKw2n1ePch3dspxN0ceeigg3LIL7AK+blq/U5cWX/2KROKiVXqsR951uLP6i5aulq8HKUMo+Ml+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857819; c=relaxed/simple;
	bh=p8Zz/nrDlMdhFtBA9h+DUa3pTVexBXWNccPecncnKek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWu8jE9W6LeRZGpRGDyqKlfPNkK8MJoNW9etyhPZt1ES4+e0RbPixw/5xXSp0sEtjZEUGFwFFajVWNwfBgod4lT3tfSiGKMt3D+gAxfEnQU0Zfv/Pa3QCI97rGYXvxVyZYx2uWFzEusgmB+c0oUMztE+YYeBkrBCRyKLuErO7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZg0BKei; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so1415619a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 01 Feb 2024 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706857816; x=1707462616; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mBR0j7fmXigHlcMcX5Zi87sEcWbb3gR8lyC8bmdnJPs=;
        b=dZg0BKeiSyYwiPhr3PWWm659HXcnZejVlHCRNSWHi+UMVRZSVsa1rP3fG45leJngqh
         ETEyuJauK8tyMzeZprNl2ZA49Z6MbeerBXLljU4x99eIqJeYKMoDlhNSpKx0FtTfRCV3
         pIEGMiUpZ7Sd1YouoEWjjhRlZhSyru4JVTMuUM50rqTBSUZJ3JIz7KiEmq4px4EO8f+Y
         tCtjG4bvIhR3O818CqZDWUUi/vwEMocQqaoGUKpYjkKwMLfL4IIAc6ELOKVLxMqvaiA8
         s6fg43KBd3VbuWRxIjgI0zn4L2djbAywR0Qm+iStyNFzHfMt7boIY9VnACE2l7GDfuU0
         q5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706857816; x=1707462616;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBR0j7fmXigHlcMcX5Zi87sEcWbb3gR8lyC8bmdnJPs=;
        b=sUZ9oCRSTeLPleDs6++CsVc5WEXxZn8iMC7xHAedr9apV3CNqSwM+l/mbKR+SnOtBg
         LkEBd+0Xq9xpI8XPShzoOxuugc6KaZFxow9R65XW2YvypRS4QJv1tETZCnGetzzUPvHH
         +3u61eTg/mSElvGRoNS1QSkbXC+P6DiXAk5JxchQzJOZ+eJ887byHFvOPiy/sNA4R5ek
         OIfaK2roh/u7JePnJKF7OJFPAx0u8nKZA9ArI7wDSMAOcEIq4eMG209SmzT3jvY/a5BF
         Dn9ym4tiLdyHRjFQpWlbubvyeww57Fwy18xX/gwKBnXC3Cb6oYvgvtMldqKkdjsG3PHg
         JZwg==
X-Gm-Message-State: AOJu0Yxt77VZFdQmP5SxqJ0M38b/wdzDSmqa63Covi+zJr8+IxKuw5gx
	wJWy+Ap1sRUyPIR56ywYSAAPVk8iVPXPG1JGzI8b/UJvmngvql/3zlflI9Wqkg==
X-Google-Smtp-Source: AGHT+IHv9nfHQPIK/Umkj/43iLoO5DsE5953wyaKPRoPQVmEnc6CxErNbfFnGQAn3Y3Ypx7SqVwPkQ==
X-Received: by 2002:a05:6a20:1206:b0:19c:6b59:b9fc with SMTP id v6-20020a056a20120600b0019c6b59b9fcmr6517991pzf.24.1706857816500;
        Thu, 01 Feb 2024 23:10:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1mNOgImmvw2VPE8ohWgrmBAh0MMkosJmf36+loUPnIPEJEWCdlfgajlf/yjJHFHQHadj5P6IXolR5z9XpznwEfqiXqUNXG9VX2BSn38qbg8Y7deLKo4yRuxL7aegZVGhyevwaMepObh+PnwWmuto7GE6WZz5xymaufyaFrcSC
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id sz12-20020a17090b2d4c00b0028ffea988a2sm1006037pjb.37.2024.02.01.23.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:10:16 -0800 (PST)
Date: Fri, 2 Feb 2024 12:40:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, mhi@lists.linux.dev,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/8] bus: mhi: host: add new interfaces to handle
 MHI channels directly
Message-ID: <20240202071011.GA2961@thinkpad>
References: <20231127162022.518834-1-kvalo@kernel.org>
 <20231127162022.518834-3-kvalo@kernel.org>
 <20240130181938.GB4218@thinkpad>
 <d002afe9-3c01-413c-82d2-353db0356802@quicinc.com>
 <20240201100040.GB17027@thinkpad>
 <07668be1-8366-43b5-83ca-bf66d0d8087b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07668be1-8366-43b5-83ca-bf66d0d8087b@quicinc.com>

On Fri, Feb 02, 2024 at 02:42:58PM +0800, Baochen Qiang wrote:
> 
> 
> On 2/1/2024 6:00 PM, Manivannan Sadhasivam wrote:
> > On Wed, Jan 31, 2024 at 03:39:26PM +0800, Baochen Qiang wrote:
> > > 
> > > 
> > > On 1/31/2024 2:19 AM, Manivannan Sadhasivam wrote:
> > > > On Mon, Nov 27, 2023 at 06:20:16PM +0200, Kalle Valo wrote:
> > > > > From: Baochen Qiang <quic_bqiang@quicinc.com>
> > > > > 
> > > > > When using mhi_power_down_no_destroy() MHI hosts need to unprepare MHI channels
> > > > > by themselves.  Similarly, MHI stack will also not create new MHI device since
> > > > > old devices were not destroyed, so MHI hosts need to prepare channels as well.
> > > > > Hence add these two interfaces to make that possible.
> > > > > 
> > > > > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> > > > > 
> > > > > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> > > > > Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> > > > > ---
> > > > >    drivers/bus/mhi/host/main.c | 107 ++++++++++++++++++++++++++++++++++++
> > > > >    include/linux/mhi.h         |  20 ++++++-
> > > > >    2 files changed, 126 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> > > > > index d80975f4bba8..3f677fc628ad 100644
> > > > > --- a/drivers/bus/mhi/host/main.c
> > > > > +++ b/drivers/bus/mhi/host/main.c
> > > > > @@ -1669,6 +1669,58 @@ int mhi_prepare_for_transfer_autoqueue(struct mhi_device *mhi_dev)
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(mhi_prepare_for_transfer_autoqueue);
> > > > > +static int ____mhi_prepare_for_transfer(struct device *dev, void *data)
> > > > 
> > > > "__mhi_prepare_all_for_transfer"
> > > 
> > > This is to prepare one single child device, I don't think a name like
> > > __mhi_prepare_all_for_transfer (with 'all' inside) make sense, right?
> > > How about changing to "mhi_prepare_dev_for_transfer" or
> > > "mhi_prepare_single_for_transfer"?
> > > 
> > 
> > I think most of the checks in this function can be moved inside
> > mhi_prepare_for_transfer() API. With that you can just reuse the API without
> > adding a new helper.
> > 
> > For autoqueue channels, you can add another API
> > mhi_prepare_all_for_transfer_autoqueue() just like
> > mhi_prepare_for_transfer_autoqueue() to maintain uniformity.
> > 
> > - Mani
> If we do that, we need to call two APIs together, does it make sense? From
> the view of an MHI user, what we want is an API to prepare all channels, no
> matter whether a channel is configured as autoqueue or non-autoqueue, we
> don't care about it.
> 

You are calling this API from a wrong place first up.
mhi_{prepare/unprepare}_transfer* APIs are meant to be used by the client
drivers like QRTR. Controller drivers should not call them.

What you need here is the hibernation support for QRTR itself and call these
APIs from there.

> And besides, I don't think there is a scenario where we need to use them
> separately. So if we always need to use them together, why not merge them in
> a single API?
> 

A single controller driver may expose multiple channels and those will bind to
multiple client drivers. So only the client drivers should manage the channels,
not the controller drivers themselves.

- Mani

> > 
> > > > 
> > > > > +{
> > > > > +	struct mhi_device *mhi_dev;
> > > > > +	struct mhi_chan *ul_chan, *dl_chan;
> > > > > +	enum mhi_ee_type ee = MHI_EE_MAX;
> > > > 
> > > > Reverse Xmas order, please.
> > > > 
> > > > > +
> > > > > +	if (dev->bus != &mhi_bus_type)
> > > > > +		return 0;
> > > > > +
> > > > > +	mhi_dev = to_mhi_device(dev);
> > > > > +
> > > > > +	/* Only prepare virtual devices that are attached to bus */
> > > > 
> > > > "Only prepare virtual devices for the channels". Here and below.
> > > > 
> > > > > +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> > > > > +		return 0;
> > > > > +
> > > > > +	/* There are cases where there is no MHI client driver matches
> > > > > +	 * this device, we are not allowed to do prepare for it.
> > > > > +	 */
> > > > 
> > > > Use the preferred style for comment:
> > > > 
> > > > 	/*
> > > > 	 * ...
> > > > 	 */
> > > > 
> > > > > +	if (!mhi_dev->id)
> > > > > +		return 0;
> > > > > +
> > > > > +	ul_chan = mhi_dev->ul_chan;
> > > > > +	dl_chan = mhi_dev->dl_chan;
> > > > > +
> > > > > +	/*
> > > > > +	 * If execution environment is specified, remove only those devices that
> > > > > +	 * started in them based on ee_mask for the channels as we move on to a
> > > > > +	 * different execution environment
> > > > > +	 */
> > > > > +	if (data)
> > > > > +		ee = *(enum mhi_ee_type *)data;
> > > > > +
> > > > > +	if (ul_chan && ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
> > > > > +		return 0;
> > > > > +
> > > > > +
> > > > 
> > > > Remove extra newline.
> > > > 
> > > > > +	if (dl_chan && ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
> > > > > +		return 0;
> > > > > +
> > > > > +	if (dl_chan->pre_alloc)
> > > > > +		return mhi_prepare_for_transfer_autoqueue(mhi_dev);
> > > > > +	else
> > > > > +		return mhi_prepare_for_transfer(mhi_dev);
> > > > > +}
> > > > > +
> > > > > +int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl)
> > > > > +{
> > > > > +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
> > > > > +				     ____mhi_prepare_for_transfer);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(mhi_prepare_all_for_transfer);
> > > > > +
> > > > >    void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
> > > > >    {
> > > > >    	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
> > > > > @@ -1684,3 +1736,58 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
> > > > >    	}
> > > > >    }
> > > > >    EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
> > > > > +
> > > > > +static int ____mhi_unprepare_from_transfer(struct device *dev, void *data)
> > > > 
> > > > __mhi_unprepare_all_from_transfer
> > > 
> > > same as above.
> > > 
> > > > 
> > > > > +{
> > > > > +	struct mhi_device *mhi_dev;
> > > > > +	struct mhi_chan *ul_chan, *dl_chan;
> > > > > +	enum mhi_ee_type ee = MHI_EE_MAX;
> > > > > +
> > > > > +	if (dev->bus != &mhi_bus_type)
> > > > > +		return 0;
> > > > > +
> > > > > +	mhi_dev = to_mhi_device(dev);
> > > > > +
> > > > > +	/* Only unprepare virtual devices that are attached to bus */
> > > > > +	if (mhi_dev->dev_type == MHI_DEVICE_CONTROLLER)
> > > > > +		return 0;
> > > > > +
> > > > > +	/* There are cases where there is no MHI client driver matches
> > > > > +	 * this device, so it is not probed or prepared, no need to
> > > > > +	 * do unprepare for it.
> > > > > +	 */
> > > > > +	if (!mhi_dev->id)
> > > > > +		return 0;
> > > > > +
> > > > > +	ul_chan = mhi_dev->ul_chan;
> > > > > +	dl_chan = mhi_dev->dl_chan;
> > > > > +
> > > > > +	/*
> > > > > +	 * If execution environment is specified, remove only those devices that
> > > > > +	 * started in them based on ee_mask for the channels as we move on to a
> > > > > +	 * different execution environment
> > > > > +	 */
> > > > > +	if (data)
> > > > > +		ee = *(enum mhi_ee_type *)data;
> > > > > +
> > > > > +	if (ul_chan) {
> > > > > +		if (ee != MHI_EE_MAX && !(ul_chan->ee_mask & BIT(ee)))
> > > > > +			return 0;
> > > > > +	}
> > > > > +
> > > > > +	if (dl_chan) {
> > > > > +		if (ee != MHI_EE_MAX && !(dl_chan->ee_mask & BIT(ee)))
> > > > > +			return 0;
> > > > > +	}
> > > > > +
> > > > > +	mhi_unprepare_from_transfer(mhi_dev);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl)
> > > > > +{
> > > > > +	return device_for_each_child(&mhi_cntrl->mhi_dev->dev, NULL,
> > > > > +				     ____mhi_unprepare_from_transfer);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(mhi_unprepare_all_from_transfer);
> > > > > diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> > > > > index ae092bc8b97e..dcf62a57056a 100644
> > > > > --- a/include/linux/mhi.h
> > > > > +++ b/include/linux/mhi.h
> > > > > @@ -668,7 +668,7 @@ static inline void mhi_power_down(struct mhi_controller *mhi_cntrl, bool gracefu
> > > > >     * destroy struct devices. This is a variant for mhi_power_down() and is a
> > > > >     * workaround to make it possible to use mhi_power_up() in a resume
> > > > >     * handler. When using this variant the caller must also call
> > > > > - * mhi_prepare_all_for_transfer_autoqueue() and
> > > > > + * mhi_prepare_all_for_transfer() and
> > > > 
> > > > This change belongs to previous patch.
> > > > 
> > > > >     * mhi_unprepare_all_from_transfer().
> > > > >     *
> > > > >     * @mhi_cntrl: MHI controller
> > > > > @@ -842,4 +842,22 @@ int mhi_queue_skb(struct mhi_device *mhi_dev, enum dma_data_direction dir,
> > > > >     */
> > > > >    bool mhi_queue_is_full(struct mhi_device *mhi_dev, enum dma_data_direction dir);
> > > > > +/**
> > > > > + * mhi_prepare_all_for_transfer - if you are using
> > > > > + * mhi_power_down_no_destroy() variant this needs to be called after
> > > > > + * calling mhi_power_up().
> > > > 
> > > > Add info about what this API does also.
> > > > 
> > > > > + *
> > > > > + * @mhi_cntrl: MHI controller
> > > > > + */
> > > > > +int mhi_prepare_all_for_transfer(struct mhi_controller *mhi_cntrl);
> > > > > +
> > > > > +/**
> > > > > + * mhi_unprepare_all_from_transfer - if you are using
> > > > > + * mhi_power_down_no_destroy() variant this function needs to be called
> > > > > + * before calling mhi_power_down_no_destroy().
> > > > 
> > > > Same as above.
> > > > 
> > > > - Mani
> > > > 
> > > > > + *
> > > > > + * @mhi_cntrl: MHI controller
> > > > > + */
> > > > > +int mhi_unprepare_all_from_transfer(struct mhi_controller *mhi_cntrl);
> > > > > +
> > > > >    #endif /* _MHI_H_ */
> > > > > -- 
> > > > > 2.39.2
> > > > > 
> > > > > 
> > > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

