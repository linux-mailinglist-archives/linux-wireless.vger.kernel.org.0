Return-Path: <linux-wireless+bounces-22058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6FA9C2AF
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F914C1290
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941472367D2;
	Fri, 25 Apr 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGFA6Ng3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9862367A7
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571600; cv=none; b=bVaTRmQxNPpPE2BLbvfISAqgcg5nREUgPxpU4+xAv9ZVP5xlj7sw+4NY8AaJkU2h9bjRKP5xKUtHmV33d+ZFLyjpjNzjqF408jhR8JKOwMfvNhR8c1MzWqrSd15/PqKw325yufmOpNJ0K19pjS74q6w6T/FScZuCBmqui3SYjiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571600; c=relaxed/simple;
	bh=+xSCE9MB+iXnfupVs0CKDPm7yuZw6BhgZRJ8oAX0TzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nmco/3/W+WI0xbdbgWp5pUqIsgHE282NPEEeu06DakHjdDrCoAlBACDW3zfmYsvxRi7g6Fo2ebBd/vHiwPw03ZJ4q42bqPTGNKvANTlxE/PD85/uugo3rkjc/dLqczwEOHLLHnf46vddNNvdOHdvgIvOvNtSTPJ0aCLviUQOVjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MGFA6Ng3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so1750299b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 01:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745571598; x=1746176398; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QI7dIhq4gpO8qmw+kHNvoSNDB7nG2z7FjzlKM42EHH4=;
        b=MGFA6Ng33aHaiphc4JPoqhxE8pOz8TySAC21Fsun0ihZIWo2F2P/bJErOap+DiRaTy
         bb2YpBQiKVFyOiYxVc2n+eQe9WXuzisDAYpzjnzDLqSeqRcGrtdYYhfOoiRfAYdSh0Rb
         CNSvmA2mu3C26K8Uzn0uVLBjIeCK8dDOHkHC+JyLwnPpoTzbi2NkNOdMYHc+7CJDPWgw
         wYhk8Xw2uaWFA7INh2S+xXMb+9MoRteBbMKfFZZYST+oW4v40CeUkI0HTXBasouPFQzi
         nalkuuwcg13DLewsN9x1q6A0X/oy5qiqKrtZjNQdBQGH9zJ6UAeJcxR/mnU649Cfl+CV
         rcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745571598; x=1746176398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QI7dIhq4gpO8qmw+kHNvoSNDB7nG2z7FjzlKM42EHH4=;
        b=LzAU33XHqziYxtA6hWNw26BrLAIRmqNe/KSZ2/nKiiSed3iTpWwQcayYR7apVy2nr5
         EZJZySAyIDWwnMYfMW2y4N64grMVuBgMYtzApWDytn2OOh1WI+rfOT1La63EHRGbe1fB
         hahNvOLTCKNpukd7sRVRg8RlMjdUKf2ogjWFUExvkZwm53dM7zeY7LfcPzFYGj+c+3dH
         iCnsrDIx4ZLpqMtLgBGur3K4a1dzCiLavar8ryeNj3yfqkG1/938UgctY8aBSx5eLkap
         Wa5GbDtHR7Q6uGqQYPFvl77Rm36bLBbKGFqdNwdrd9+A8MsrS1K1msQp7y+d3z6zQ6ss
         lrcA==
X-Forwarded-Encrypted: i=1; AJvYcCUv5hRMmujH0WyEq747FNFSvH+vCX/e8VYVS8dMnfof2CfoBajFpoqZtfB0qDwIZNRt8+8/5pEv5zQauy6xWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Z8di/WkJlacKToYGXP+CRfuaEE9LPqfwfLo9lQm7m5qp5EI6
	HK576g3F4GU0nDMH263nJMtpNM1DIJG/rZZ2fSJJgwUDv5J7K/IRTuoPitKneg==
X-Gm-Gg: ASbGncvm82f+71Smqm0FKtTvqF/iFw/Fg5He/mOn84nQAToq+fH0xfFRzmpkbQJYsTE
	D9D2AaT4wNHb6noszozzMDAhWEZUZpcVqZB0ZEUmCQHdTN10Tq4jwBU5YnD3FvCU71LQ/0yTXZG
	ZtZgeHqMpvrGNqXimAZCNA/vgnVx5QplmID58C9aTtgTja3Z4qTc8UxICbYCgVsI2zLtPJfnkzZ
	h6WilYpPPpuhBT1xBTC05JZojYmYEKIgfJVYPAlakUcxcyOvdOxSR/hZQ9kuq+ZoKT9YiSAD7J0
	iA3JsI7prVYnksdxb0MNZM6n+wcSbJ4CoyQaVjuO6r66hAvAr8H/GxvBU0dWpw==
X-Google-Smtp-Source: AGHT+IFkKSjUiJTYpCxdE0/nSPU4m+TRaoZshePJKHL8MiFoZ1AglBgvtTwnzJQU1uuNvqEmm4Tfww==
X-Received: by 2002:a05:6a00:21c6:b0:73e:359:acf4 with SMTP id d2e1a72fcca58-73fc7866454mr2183157b3a.0.1745571597887;
        Fri, 25 Apr 2025 01:59:57 -0700 (PDT)
Received: from thinkpad ([120.60.77.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25962f61sm2688128b3a.74.2025.04.25.01.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:59:57 -0700 (PDT)
Date: Fri, 25 Apr 2025 14:29:50 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
	Yan Zhen <yanzhen@vivo.com>, Youssef Samir <quic_yabdulra@quicinc.com>, 
	Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kunwu Chan <chentao@kylinos.cn>, kernel@collabora.com, 
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
Message-ID: <y5odcxzms6mwpz5bdxhbjxo7p6whsdgwm772usmmzqobhf6nam@p4ul7vn7d3an>
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <h2wv7drxntokziiwbzjw5xjzbctbomp6cfcba7ppfbih6o7so7@p6dazv32xfx4>
 <1136c7cb-1c7b-410b-93d2-c74aec939196@collabora.com>
 <cfb3sntvqhupyhm2m5tevpsl77r6mzl2aqzr3wtxvr22bezmp3@qjh7ftr2kdjy>
 <4d87ef88-3533-4255-adc6-6c268818fe25@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d87ef88-3533-4255-adc6-6c268818fe25@collabora.com>

On Fri, Apr 25, 2025 at 12:42:38PM +0500, Muhammad Usama Anjum wrote:
> On 4/25/25 12:32 PM, Manivannan Sadhasivam wrote:
> > On Fri, Apr 25, 2025 at 12:14:39PM +0500, Muhammad Usama Anjum wrote:
> >> On 4/25/25 12:04 PM, Manivannan Sadhasivam wrote:
> >>> On Thu, Apr 10, 2025 at 07:56:54PM +0500, Muhammad Usama Anjum wrote:
> >>>> Fix dma_direct_alloc() failure at resume time during bhie_table
> >>>> allocation. There is a crash report where at resume time, the memory
> >>>> from the dma doesn't get allocated and MHI fails to re-initialize.
> >>>> There may be fragmentation of some kind which fails the allocation
> >>>> call.
> >>>>
> >>>
> >>> If dma_direct_alloc() fails, then it is a platform limitation/issue. We cannot
> >>> workaround that in the device drivers. What is the guarantee that other drivers
> >>> will also continue to work? Will you go ahead and patch all of them which
> >>> release memory during suspend?
> >>>
> >>> Please investigate why the allocation fails. Even this is not a device issue, so
> >>> we cannot add quirks :/
> >> This isn't a platform specific quirk. We are only hitting it because
> >> there is high memory pressure during suspend/resume. This dma allocation
> >> failure can happen with memory pressure on any device.
> >>
> > 
> > Yes.
> Thanks for understanding.
> 
> > 
> >> The purpose of this patch is just to make driver more robust to memory
> >> pressure during resume.
> >>
> >> I'm not sure about MHI. But other drivers already have such patches as
> >> dma_direct_alloc() is susceptible to failures when memory pressure is
> >> high. This patch was motivated from ath12k [1] and ath11k [2].
> >>
> > 
> > Even if we patch the MHI driver, the issue is going to trip some other driver.
> > How does the DMA memory goes low during resume? So some other driver is
> > consuming more than it did during probe()?
> Think it like this. The first probe happens just after boot. Most of the
> RAM was empty. Then let's say user launches applications which not only
> consume entire RAM but also the Swap. The DMA memory area is the first
> ~4GB on x86_64 (if I'm not mistaken). Now at resume time when we want to
> allocate memory from dma, it may not be available entirely or because of
> fragmentation we cannot allocate that much contiguous memory.
> 

Looks like you have a workload that consumes the limited DMA coherent memory.
Most likely the GPU applications I think.

> In our testing and real world cases, right now only wifi driver is
> misbehaving. Wifi is also very important. So we are hoping to make wifi
> driver robust.
> 

Sounds fair. If you want to move forward, please modify the exisiting
mhi_power_down_keep_dev() to include this partial unprepare as well:

mhi_power_down_unprepare_keep_dev()

Since both APIs are anyway going to be used together, I don't see a need to
introduce yet another API.

- Mani

> > 
> >> [1]
> >> https://lore.kernel.org/all/20240419034034.2842-1-quic_bqiang@quicinc.com/
> >> [2]
> >> https://lore.kernel.org/all/20220506141448.10340-1-quic_akolli@quicinc.com/
> >>
> >> What do you think can be the way forward for this patch?
> >>
> > 
> > Let's try first to analyze why the memory pressure happens during suspend. As I
> > can see, even if we fix the MHI driver, you are likely to hit this issue
> > somewhere else.>
> > - Mani
> > 
> >>>
> > 
> > [...]
> > 
> >>> Did you intend to leak this information? If not, please remove it from
> >>> stacktrace.
> >> The device isn't private. Its fine.
> >>
> > 
> > Okay.
> > 
> > - Mani
> > 
> 
> 
> -- 
> Regards,
> Usama

-- 
மணிவண்ணன் சதாசிவம்

