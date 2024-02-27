Return-Path: <linux-wireless+bounces-4066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BFC868CBE
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 10:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B7DE1F24D53
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A82137C20;
	Tue, 27 Feb 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiFV8mT3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F51369B8
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 09:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709027770; cv=none; b=uvxjwgv7xUOW6iAoOpkg9kj4F/rQj/lkkjz3123NHb1Sv7sGm+QRUnwPz8cO1HfPGqbcvqhKTewMlZjy0XHzZBaGQ5NGWetpC0NncnR22ss2zoWcfk/5pRwZl1uZTZV4VAhdwTd1/s2JhEyQ/VfEMy1UqcgqrDoodG76IBVcjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709027770; c=relaxed/simple;
	bh=0vkry09dbrjmRYGjaxCJORMsWZUMZhqHrh0ALLXIcFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o55CiFfhXvV78qFcggHwBFNlgN2PTQQjnclQfbjNtKQCQMRhGLq+h9vFr/VM8/w/cvtyV6557tZ5wtaFnSLChzXm6NRnvjXPGFsFKNmkne19W3nce6n0DQ4TwcEIPn73PmXSnQxim6RAMmCMLlVoIAGiYZclrfBYH6hUGjTlW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiFV8mT3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcab44747bso13212145ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 01:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709027768; x=1709632568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q0zvhbCPiCFCYCeFD7LK8Y8h9az5jZBUIzn1XEZBm2A=;
        b=OiFV8mT3qKOTMLwplZf0jPvlGIJrNuRVbPB0JvoL/1d0m5oXNhDw5nN8h4R5SeO2fh
         3rnT+XIjjtHJ1GR3vJHgPISW9/V2cQspAiMoced/KbQsu+YhU53gb7JKcagnBlELQ3d3
         gob6beO/NlWY6nnFZDYU1OAR7RiEOBqGs6QYd5YMgtPRexNi45yTn5Wkfqf8WygZ122p
         Cpyre+sLicOwCMl8GXunuft3epN53k0LTO/+JXZ1xXHEeR/9vW6+sHz6fTZZvNGTjY0R
         qXN4R6zlIRScRyie7Uqs/bx7KKy+NHd6zkvJw2EC9xTVC23Z/smWsHllKOfftxwy+rA6
         Gx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709027768; x=1709632568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0zvhbCPiCFCYCeFD7LK8Y8h9az5jZBUIzn1XEZBm2A=;
        b=vzuX09G4IMQQjiunXjTlE1uII9yX96yMvZ5s0AMnMPHB9rWWUI9xNbcYDYObzc5DSt
         WPuiGG+/qokpv1MGUui4cWz8sc+GpOkgonpYUiCgceWohttN+w1D8SbpRacozRmns7S+
         qvnGxYHXVeuj0muuiROP79bOhzhvD2zpqyHL7dy7AEo8JZrNPLP35OUYbRXL1Bg11ErX
         KZyrdqwU/pOVKp7enFpAlyZ59eZK73AwtFC68Ux/CnA2YugR5sJK65K0b47GmwTiqKq1
         VA+KSWc0PvQgscetsjqsGbhXIdlhXSUvO69/ybofpZBu5zIdQzzOicZwDEy/NpOr/Xtn
         mOdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK176enjtZxRsKfTqQdK+dDe37vnUnfxhzcWMPnfFA/b2HwQE0xtKDxaSN1JAWDGPHj/2plwIJ8txhIRziux777KJJGlz2eMJB98Fd/SM=
X-Gm-Message-State: AOJu0YwdRxDWLlWlDw+eRE7YX+nism9jQRUwzo5ltQAibD6Bh89CX8h4
	Yc3KvetOlEX/ckfAdKM+TIAx8aPO8HR2HuHYl3l0pBKNT3KM39m4M3yhxgZe1tOqOadGV7IpUbo
	=
X-Google-Smtp-Source: AGHT+IE9YTOwwA5pib+X9K66GLYALzgiY71GH4bQuMmT3p83XMqAy3UfA9W4xlkOJqFp3BKOBu0+Xw==
X-Received: by 2002:a17:903:24e:b0:1dc:7890:72d6 with SMTP id j14-20020a170903024e00b001dc789072d6mr10534336plh.22.1709027768485;
        Tue, 27 Feb 2024 01:56:08 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id jz12-20020a170903430c00b001dca68b97d3sm1149704plb.44.2024.02.27.01.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 01:56:08 -0800 (PST)
Date: Tue, 27 Feb 2024 15:26:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] net: qrtr: support suspend/hibernation
Message-ID: <20240227095602.GK2587@thinkpad>
References: <20240227063613.4478-1-quic_bqiang@quicinc.com>
 <20240227063613.4478-3-quic_bqiang@quicinc.com>
 <20240227071531.GD2587@thinkpad>
 <7b743820-850a-4871-a0d8-aded36e11aba@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b743820-850a-4871-a0d8-aded36e11aba@quicinc.com>

On Tue, Feb 27, 2024 at 04:39:41PM +0800, Baochen Qiang wrote:
> 
> 
> On 2/27/2024 3:15 PM, Manivannan Sadhasivam wrote:
> > On Tue, Feb 27, 2024 at 02:36:12PM +0800, Baochen Qiang wrote:
> > > MHI devices may not be destroyed during suspend/hibernation, so need
> > > to unprepare/prepare MHI channels throughout the transition, this is
> > > done by adding suspend/resume callbacks.
> > > 
> > > The suspend callback is called in the late suspend stage, this means
> > > MHI channels are still alive at suspend stage, and that makes it
> > > possible for an MHI controller driver to communicate with others over
> > > those channels at suspend stage. While the resume callback is called
> > > in the early resume stage, for a similar reason.
> > > 
> > > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> > > 
> > > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Could you please confirm if this patch can be applied separately and won't cause
> > regression?
> Just searched the kernel and found another two drivers using IPCR channels,
> one is pci_epf_mhi_driver in drivers/pci/endpoint/functions/pci-epf-mhi.c
> and the other is mhi_pci_driver in drivers/bus/mhi/host/pci_generic.c.
> 
> For pci_epf_mhi_driver, this is not impacted because the devices for those
> channels are attached to mhi_ep_bus_type while QRTR MHI driver attached to
> mhi_bus_type.
> 
> For mhi_pci_driver, I am afraid there would be regressions caused by this
> patch. The regression is because when system suspends, mhi_pci_suspend() is
> called and then qcom_mhi_qrtr_pm_suspend_late() called, however the latter
> would fail because MHI is moved to M3 state by call mhi_pm_suspend() in
> mhi_pci_suspend(). To address this, there might be two options: the first is
> to move mhi_pci_suspend() to a late suspend stage which would be called
> after qcom_mhi_qrtr_pm_suspend_late(). and the second is to avoid whole QRTR
> suspend operation in such cases. I prefer the second one, because if MHI is
> going to suspend, instead of power down, it is pointless to unprepare MHI
> channels and re-prepare them after resume back. We can achieve this purpose
> by adding a status_cb() to QRTR MHI driver which would be called when MHI
> goes to low power mode. And then QRTR MHI driver could decide not to
> suspend/resume if low power mode is notified.
> 
> Your thoughts?
> 

I'd rather query the MHI state of the device in suspend/resume callback using
mhi_get_mhi_state(mhi_dev->mhi_cntrl) and if the device is found to be in M3
(suspend) state, then I'd skip prepare/unprepare part.

Because this makes it clear that, if the device is in suspend state, then no
need for the client drivers to unprepare/prepare the channels.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

