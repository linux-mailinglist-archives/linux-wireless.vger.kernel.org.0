Return-Path: <linux-wireless+bounces-4079-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74B86902D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25B4AB25490
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9B13AA2C;
	Tue, 27 Feb 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BK7t47nZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275513A883
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036018; cv=none; b=Rkk9aF6+lyGQeKCzlk+0wmTyRRMSH89kmlfcVVw9rdaGxIAW4oYmKHpbV7bPZOrhgC/iUbFiT3ONuDqW2WHKUn3ohEOEPZC1MtsMG9eckpbrh5PJmqWzRbQseRHct+vy3LInvexS1PjIHDTypdAuxGBvVry+tcsauhQODjJcZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036018; c=relaxed/simple;
	bh=Zmhzr0x0yS6K+jxQnhGiVyEeNBFj6wt9trNQsaL6DvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeZO26QmswdehoeVSjQmV9l5BQHsKrjnEStZK71rluibJPUaIdI2g0k+Hvkxx9uyOL5tYNw/PUhuvdyHT2IlU/A1Txb5X+BPAAZ03DdFGPkNKqjLuH7VJq/Hrwo9RKFAeKqU/uu90U4AfK9DqyUZK4A8OqjGfZKg/8ZRbxWyDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BK7t47nZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so2484364b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709036016; x=1709640816; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJLDRZfBIvlr7lerWpgs/xrh5kRQFmy2mrKRu1JKvyc=;
        b=BK7t47nZUecAU6k/8Wpot0b48eqQHq2Aau8nTAA/+CN+5qrWL+N1xV+M7uRDWM7SIZ
         cuY8qE4RGGySCbH2SfJsWx/GMz7eiA6SlvcK9OYm6R0rNErQprVwGoitqn66pS8F7uKA
         dVLUz5BESNkh1KdaB4Z1SNW3/70Ki/yrvJvQLoyWTR7XB67rl9grwAhD2izzfgWyYDUf
         BxRQKW/qaRAVXMGWQOj5MtjjQgXgW6nUBa7vVqaRa9146a6r4zqpU4723sbXKqzOl6ri
         pEKhwM//jhRoOzf3yeUx6N770RgmaVDBzlME2rqHx8jsOC/d1bZzdng7zDQRMlph5eq/
         gyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036016; x=1709640816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJLDRZfBIvlr7lerWpgs/xrh5kRQFmy2mrKRu1JKvyc=;
        b=cefSn5FuRtPGIayP4LaS2/0UWbBFJ03RnsXStOYHFVotHy3bjLV8hWb/9B+1+It2QI
         ScxZF5AAv6Y1X8G7/j/u3WAd+7rdOIcQ7yuGA+e++QtwD2yWpU9d6eGi+YtfmeqmR0sk
         FLfObm4jSPA52Wc/C8qHP1PJtliSPTU/jCK5neJcc6p4b6zHHa/sQyxZlBeUUdpK3zgJ
         TQpmuAsD4vy+pReXkNadwX3L//0qtCFav4BbSTzKEL0mcQCP8xlE2jWpNEmcKUzDkGZ8
         DIQGtEtQj1QDhpretGS3FLUJikbOjl8EOCRtZ6/afJ75Scvm/1z13EdSb/CKW9SDnS0E
         XgXg==
X-Forwarded-Encrypted: i=1; AJvYcCXkKRlYP0kg8A3kS5Rt+0Tf7s2eEvyCbCz2ewwlAy762d/zjpYQQqC3BU8hjn0Ve5wt/gLJqEdRM73J/ZGT+SY/Y7oCKnxtZGORsz2Uhic=
X-Gm-Message-State: AOJu0YwqGxfN7bv2zyseT9u1iDYDG/o06kOq71RBL2A/U0aN7dzGJmid
	CVWZHpyCuXCQmHq3MWrXfK0B6dZ11/X3y2uI0OFhKEkVZwYoIsAK6xfbTzf3QQ==
X-Google-Smtp-Source: AGHT+IGjxS8z4dBtBJgcXuzY+oK7lfPUpsSn+E9YZ/5dHJibyntUwmW17beAiUBhPM2LR0ImZwFjiA==
X-Received: by 2002:a05:6a00:2d20:b0:6e5:3ec7:c068 with SMTP id fa32-20020a056a002d2000b006e53ec7c068mr3942818pfb.24.1709036015957;
        Tue, 27 Feb 2024 04:13:35 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7845a000000b006e481014bf9sm5717110pfn.200.2024.02.27.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:13:35 -0800 (PST)
Date: Tue, 27 Feb 2024 17:43:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v3 2/3] net: qrtr: support suspend/hibernation
Message-ID: <20240227121329.GL2587@thinkpad>
References: <20240227104427.7505-1-quic_bqiang@quicinc.com>
 <20240227104427.7505-3-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227104427.7505-3-quic_bqiang@quicinc.com>

On Tue, Feb 27, 2024 at 06:44:26PM +0800, Baochen Qiang wrote:
> MHI devices may not be destroyed during suspend/hibernation, so need
> to unprepare/prepare MHI channels throughout the transition, this is
> done by adding suspend/resume callbacks.
> 
> The suspend callback is called in the late suspend stage, this means
> MHI channels are still alive at suspend stage, and that makes it
> possible for an MHI controller driver to communicate with others over
> those channels at suspend stage. While the resume callback is called
> in the early resume stage, for a similar reason.
> 
> Also note that we won't do unprepare/prepare when MHI device is in
> suspend state because it's pointless if MHI is only meant to go through
> a suspend/resume transition, instead of a complete power cycle.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  net/qrtr/mhi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
> index 9ced13c0627a..69f53625a049 100644
> --- a/net/qrtr/mhi.c
> +++ b/net/qrtr/mhi.c
> @@ -118,6 +118,51 @@ static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
>  
> +static int __maybe_unused qcom_mhi_qrtr_pm_suspend_late(struct device *dev)
> +{
> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
> +	enum mhi_state state;
> +
> +	state = mhi_get_mhi_state(mhi_dev->mhi_cntrl);
> +	/*
> +	 * If the device is in suspend state, then no need for the
> +	 * client driver to unprepare the channels.
> +	 */
> +	if (state == MHI_STATE_M3)
> +		return 0;
> +
> +	mhi_unprepare_from_transfer(mhi_dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused qcom_mhi_qrtr_pm_resume_early(struct device *dev)
> +{
> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
> +	enum mhi_state state;
> +	int rc;
> +
> +	state = mhi_get_mhi_state(mhi_dev->mhi_cntrl);
> +	/*
> +	 * If the device is in suspend state, we won't unprepare channels
> +	 * in suspend callback, therefore no need to prepare channels when
> +	 * resume.
> +	 */
> +	if (state == MHI_STATE_M3)
> +		return 0;
> +
> +	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
> +	if (rc)
> +		dev_err(dev, "failed to prepare for autoqueue transfer %d\n", rc);
> +
> +	return rc;
> +}
> +
> +static const struct dev_pm_ops qcom_mhi_qrtr_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mhi_qrtr_pm_suspend_late,
> +				     qcom_mhi_qrtr_pm_resume_early)
> +};
> +
>  static struct mhi_driver qcom_mhi_qrtr_driver = {
>  	.probe = qcom_mhi_qrtr_probe,
>  	.remove = qcom_mhi_qrtr_remove,
> @@ -126,6 +171,7 @@ static struct mhi_driver qcom_mhi_qrtr_driver = {
>  	.id_table = qcom_mhi_qrtr_id_table,
>  	.driver = {
>  		.name = "qcom_mhi_qrtr",
> +		.pm = &qcom_mhi_qrtr_pm_ops,
>  	},
>  };
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

