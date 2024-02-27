Return-Path: <linux-wireless+bounces-4081-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45774869037
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935F5B287CE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 12:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4413AA2B;
	Tue, 27 Feb 2024 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRgOlaoI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73E13A27D
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036170; cv=none; b=YIQ8SC4n6RAicK9r3z4WzMIGg2u+jeFk1AZZesAhBq49C5uH7s48vpbSi03p8cfw5T1TiRrlF/DO89f1PvAFCVCbhk/f+AfD2itVTXopyZaZhtY+r1wRvhn/TSAq1Jf9115M4niPKn21SLasaVsaBaBp2L9bxS9gmzZenTgd5Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036170; c=relaxed/simple;
	bh=tzPFWddcLinFLpylocZ1/c9Pw+LLiJOMXtoyrSnUv84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA0qaRW4ofnHhlHKDxossjKtbmnX4kKXztWSst+7/tWTgb4iluLNnw6ux3jRIK3u1Afg0Jh3yxZUJF0GXevge3/nSch6hFodvN0qsdRT3SgEejHG4wRbJePvGV7Nd1ALKOdVkbWfpHCIVMQUBEgcNjS0QE5Av3yxkcSumruHd0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DRgOlaoI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so33664795ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 04:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709036168; x=1709640968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uSLLi43HACJeFnFP6SO2dnx7por0WBtfnRzS4Kl+dFE=;
        b=DRgOlaoILplzROniUBC00Aej3FSvb+NdI89fFCAljYVCjVExYNnDbSFmmnvwMf01GI
         tgyl3FntVeTJxIELL1ebFD7+eHxIMW9KVO1siN+sc/0SRFDWUvsZxgboRtryCAre2MpV
         bUzeFsSIvmmV4I9uTdCAaTB4D/MWgBvQkMKkVZtnersQ2yeQjdK8jz/Qzz3lMc6xQPVJ
         YN44PI/Rfb2NiSIxgLAHqWICcy/KbM1SGAsSlAHfsy7CeDNEC+bRPmlAyCrE61bq0pT1
         eUHoBJHFMgTlAlaW//20UQkQ5mVXbVfDRZ44g00rmtyIL6riTiqcN/er60l8tTgIU3yG
         K5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709036168; x=1709640968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSLLi43HACJeFnFP6SO2dnx7por0WBtfnRzS4Kl+dFE=;
        b=n6bwXGk2YloDn4QR9eGgCxxeIRZjFX6v3CuBrCBuQrn7+Z62IrCTUjacuLKsCB0jZ/
         mPXElML64HrO5aIPNBzGqo3MltOARaGdL18UzRo5jjs7w/csfT09OSFzuibnTh4e5sUA
         bvEvKvETVpii/IPDMYp0Tk+mCvYP91C35F78XE9gq5ysjhH4ejp67ryUYFt3KZ1zT+s/
         nQwxwnLoPNyAljgwNXKuImIpPtlSgWs36WDa4eYS+lQ3RnfPcOVt/go3+YvSkJBlYFET
         jQN1OesqYDfBhEii5vl9G/eq0p6Y/gczW75KCCJs59zw+qlrBKRarnXhF+zG5IE02k7D
         Y7tw==
X-Forwarded-Encrypted: i=1; AJvYcCWLU8R8hd2gmG+zIYIbFjWzskBp0EtfACUxnUzUmzBu8ZgbfCgd9gPC8mae2s6m1eEGbFAuK09KCy3mAK5EYFkPTV2HEao+GVBFUfswaUY=
X-Gm-Message-State: AOJu0YyY3zhHzAHqCOPK81zmyZ8IkkdbFghg2jDmyldhAz4GAECkXC3v
	GW7zK/gkNlopPDRroFX6nT1L0Y2QYkVxOSuwikNVFU7+F3LDBLsOUU+MAuagPt+zj5YnJdRMN/w
	=
X-Google-Smtp-Source: AGHT+IH3s4jVwUk0+mZ0PnkQjYfLsEztotgFamFw6AI38DUq7t0+HX+BXSCN6Z/P0Ih71C7CE+4/+g==
X-Received: by 2002:a17:902:7c92:b0:1db:c3cb:b088 with SMTP id y18-20020a1709027c9200b001dbc3cbb088mr9769914pll.35.1709036168326;
        Tue, 27 Feb 2024 04:16:08 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id o9-20020a1709026b0900b001db693d89fdsm1405598plk.179.2024.02.27.04.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:16:08 -0800 (PST)
Date: Tue, 27 Feb 2024 17:46:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v3 2/3] net: qrtr: support suspend/hibernation
Message-ID: <20240227121602.GM2587@thinkpad>
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

Btw, you forgot to CC netdev folks. Here is the list that get_maintainer.pl
returns:

"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])

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

