Return-Path: <linux-wireless+bounces-4057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B518689B0
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 08:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CAA1C21185
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA1653E2D;
	Tue, 27 Feb 2024 07:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhry3IRG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664453E36
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709018138; cv=none; b=e2aW5JU99i36cG+Y6X3LG6i31QEZj2xDjiY3bElPeyP7J/ZNGgwk4IgN3n0bfR5bEX4dhc7nwPUHHJphcnXNaIn0uHDORMH9NXwgFeIxDVrw0z3fUd6tZb8oKOTks6TKUjauwHPt097JmRmB7s1Avy8dX81wXgxI9LMPKfFKSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709018138; c=relaxed/simple;
	bh=xdj2tmp5ZSTgv8RxX6+UK1ZIo0D0A5lr94dBSBt32Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATNmfLl8qUlnrEiEjAmhxHynkQElA4luguss7sCIBYBse4J7vErzeLlQZXglqh57hDD3tcdMyQxIGF9doC80rXiSOCu4jgpEUt0qgkKyymGpXfaJ0zo1qL0J+AhAquyThKYiZL/5TkhGRsef4BNkd1N9JnazM4atxBewUGBQKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xhry3IRG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7881b1843so30037065ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 23:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709018136; x=1709622936; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uZsei3QWNYjEWHv4rj1KYROyeU0O84dua5Y6JN0udQc=;
        b=xhry3IRGLRcnxCZPGGfYFpZAKkIrf2Si8O6yF1Z+M20lTHyy5glq+wQ5OiPWkptm6u
         KVhN3uHMOlX8Ae30PZsVtvW6VwU722sgT6kOQ2HHC+VB8CBRB43o3CnQgysr9BLbbzer
         198RcRF8DddvHU30meWrOsJSth0Up13F9VfknSsizNl/XG8FGYKr8IkQxyF4FPbNL3Jw
         8+hxLvMNuml7W6HIj6tDkc8mmihgk6A8zECAHeeO0FpUgBsR0yTEdOyw0nWL/qYKo4Fy
         FAmRH0nrev/18LzvCbcEoI1ePyv3zPC6USYKp17Pw1wwdHSvC1qvIVz+j6oNecC8qBZ5
         PIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709018136; x=1709622936;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZsei3QWNYjEWHv4rj1KYROyeU0O84dua5Y6JN0udQc=;
        b=U43ChqOjhIay0aZADJ54eP6Brr3JmlsqtWyqI8QLDzx2ANzN6zx2dLEQ28ULgw/4a1
         /cpZRB6q9+4rNIgVqTd5BTO9hRHRTehhykH6Jusp5Sw6k7ekfh73kD8cW+X92zvniyZ5
         /XQLHtedFkPutS6p0HzdeYCtt62Gm8asHkiYpjvVJpmFsDmEDQzY4gp+xTxEubMPlPtF
         ko/vGjJPlJW8oy8u/GnP/5FMu+MW3oKyvm5YwZHuDzu+B6y8JmJiPt9T84qzrdXx89YO
         CafUn0GJSs+HJzDDDO83CdHbbzeocWBS2cm64A5tmHWx/x1QFvTNkHvalJ1RD/wYc7HC
         oRsg==
X-Forwarded-Encrypted: i=1; AJvYcCXbBk8dV/ag+cfjeDwNW0ekVOP1Eh3D73s3Sq3qDEpzW+M69vvs8L/1QhF8fPe2MvVFo+UeU//gsap728BbEouVKrdNvD9K8d0/+iftSbw=
X-Gm-Message-State: AOJu0YxHf+vVgXCn4Ua5Fs9tKWzTHV4rSau7gPlHLzV43NmYErwdE1bS
	scg5YX/j9nSFnl1Tye0/Urc5hq+s6vxdi0jLIYoK6UoUZgfgXAJC75z/YtEI+g==
X-Google-Smtp-Source: AGHT+IFibjJl0nFMxkStNH2v97+irfnxX0GXGBgtTqgJL/pFmNgfMwh9TcBG1L8V21fOgN6jL/Y6fQ==
X-Received: by 2002:a17:902:7ec8:b0:1db:cb54:5e77 with SMTP id p8-20020a1709027ec800b001dbcb545e77mr10479462plb.22.1709018136598;
        Mon, 26 Feb 2024 23:15:36 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id k22-20020a170902ba9600b001dcabf123c9sm813379pls.155.2024.02.26.23.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:15:36 -0800 (PST)
Date: Tue, 27 Feb 2024 12:45:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] net: qrtr: support suspend/hibernation
Message-ID: <20240227071531.GD2587@thinkpad>
References: <20240227063613.4478-1-quic_bqiang@quicinc.com>
 <20240227063613.4478-3-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240227063613.4478-3-quic_bqiang@quicinc.com>

On Tue, Feb 27, 2024 at 02:36:12PM +0800, Baochen Qiang wrote:
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
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Could you please confirm if this patch can be applied separately and won't cause
regression?

- Mani

> ---
>  net/qrtr/mhi.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
> index 9ced13c0627a..e96b82a6742c 100644
> --- a/net/qrtr/mhi.c
> +++ b/net/qrtr/mhi.c
> @@ -118,6 +118,32 @@ static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
>  
> +static int __maybe_unused qcom_mhi_qrtr_pm_suspend_late(struct device *dev)
> +{
> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
> +
> +	mhi_unprepare_from_transfer(mhi_dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused qcom_mhi_qrtr_pm_resume_early(struct device *dev)
> +{
> +	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
> +	int rc;
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
> @@ -126,6 +152,7 @@ static struct mhi_driver qcom_mhi_qrtr_driver = {
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

