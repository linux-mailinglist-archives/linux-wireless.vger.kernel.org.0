Return-Path: <linux-wireless+bounces-22070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E3EA9CBFB
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 16:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF3B9E2FF6
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5319E252909;
	Fri, 25 Apr 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z79926m5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C2502B1
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592444; cv=none; b=Il0SnjEI/Ce2/SaaKCq5xOLnr+l1kymgcgsHW4l7j0KPcFpEftokWWPmgvdSxRzqSFQA8KEZan7UdIfQHSdrXWZ2LaU6dfjH56pY8R/U1xFe4xxPw1W52MVWJGcEj/lNo7pskoUcmDm5M00mJfoWb8BXjo6UmbTuI6qd+hYmfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592444; c=relaxed/simple;
	bh=fPAudd0pNdvSq70SAtg2Ygg2O9zP1xgrVtnfFsN3fh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBRCZ0mvRa1k1ytjBVldijKeSczp+PZRN7Hf4sIr2FEvhjrimYaoZeDVVbg9A5Ibhh0YtXoVdl1GVjCCqRpxN0GkepggDkRWi1tUN5qTyU53Apj2KMuuY9HFcovJExgT1dV4nWVABPd+mPKOrNktrArIMbJxIQBDR6nP+vnuSjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z79926m5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2295d78b433so27144455ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745592442; x=1746197242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tMds6CmcdH779xJQucw6BprWPQmeQRUV0l1L2HM0TV4=;
        b=z79926m52YRywzSBxfcdXJ1kijC9lg3l4zWjYj9kuoguWruPIbvxz/h/oV0azWjgSt
         prZMO2VkKjmKNWz3a8F8SegNkdWtFM6/+/zphXyds/jpIr60vasdyAP0ERwPvQv+foT9
         Xg3gDXQpgK9W9MHw4fsYjySCMoFJD/Mhw0YYwiAC6gjyRbgErqbJ4sLW/owpNtIB0mop
         VlKDQqUdIFtnc1JShaROE2sBJfzr1kpvB+VOuQTGvU3q/TWHOxXzUktlKuAwD/DfK7Uu
         2hoiF405FR551wBJPZJbBLCb0YcqNcqq6DtLcUcdBXK+eq6q+4LN49S4RfOtr6tkixdY
         hn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745592442; x=1746197242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMds6CmcdH779xJQucw6BprWPQmeQRUV0l1L2HM0TV4=;
        b=dJQ8Hof4v6GbTropinm6NivCuYfxqDuSL3Zhtr3L06B4AUvOt9hO3JFBBG23hEpSjy
         TYkkHuTdNtKWQLqXsgF8gt2/aKE0k0zzilO44MHHmReiy1SpMZUVUBi46HrDqHBes5D5
         ZbORKoPdWy/WdCcyjMdP2keM70Ol2Gc3m3R+agNvU06Alv0zPKS9eJpNrMcwg3iYvS5d
         L0ErdCerKTRc6Y+1LtpN/XuQGb7xQeas57Fuqao5YkIvghkar20cQv2lIiq1+T663jla
         +9OTyYSaN+E4Udk8Xc5V3gFgdwmGjfevEZAxelAn6IKkc9FYo7YSIAMGDnJGDhvGTmpO
         st4g==
X-Forwarded-Encrypted: i=1; AJvYcCXRB0lTRMrspAjCYYf9yOSP1LJjc5IovG0CxunFQIe0L+UA+b1f6kHblVBTnWvoexEc8xL1mBqdzvJqPBjxZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ARqsyJd9rJWAQbu/NVgpif3NC0qQbaB09TDN6Gr/pHJE3YCM
	DGcK3tOaAWDuXzlmDNPiEDsfd0iAQx3LbpIwA7cldWzYspv5epvB8tQOLj5gWA==
X-Gm-Gg: ASbGncv37fdRao6Kg53GES6ZQUv5GRm7PZMXZLWxlKCEXX8SiL8+J6F5xOg0SiFX1Hg
	jM/nbmC9vBl62TTb7xwRVgQfoR7giQx7TZoXCW9RY3cEnbOyTkxbMsLMfqgDXy2+vMG10224Is7
	Ur9hCh5LmdPsPn3B9LMk8AvlsMPkYQz4tk0jwLdWZAMxAJ4aGV7lG7OvegQWmKgHkruBO1NGF0x
	wUHfzmbKOk5F2IskrT3QImJN6ol9GVyTikiMlDVwBi7Dj9+zEDaRsuVcznmmwAMEBox3Y39HoR3
	31eAyP4bvQ9VDUJjsHs059tE32CPkoqOY+UVQfhY1qMEmMb8CdOz
X-Google-Smtp-Source: AGHT+IGlccZ19AfD3jdnufZp8LMe8Yz57J7vptNmjyBiI0lLh+m+16U65auA9epwL1IrRm+aNvHWgg==
X-Received: by 2002:a17:902:e805:b0:223:5de7:6c81 with SMTP id d9443c01a7336-22dbf5f34f9mr38226475ad.27.1745592441695;
        Fri, 25 Apr 2025 07:47:21 -0700 (PDT)
Received: from thinkpad ([120.56.201.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db521614dsm32962505ad.215.2025.04.25.07.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:47:21 -0700 (PDT)
Date: Fri, 25 Apr 2025 20:17:14 +0530
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
Message-ID: <eypd4xigl3yydfj47usazm7ca3kplz5w7bkk7qf6piks4vtaa4@rmecjnlfix66>
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <h2wv7drxntokziiwbzjw5xjzbctbomp6cfcba7ppfbih6o7so7@p6dazv32xfx4>
 <1136c7cb-1c7b-410b-93d2-c74aec939196@collabora.com>
 <cfb3sntvqhupyhm2m5tevpsl77r6mzl2aqzr3wtxvr22bezmp3@qjh7ftr2kdjy>
 <4d87ef88-3533-4255-adc6-6c268818fe25@collabora.com>
 <y5odcxzms6mwpz5bdxhbjxo7p6whsdgwm772usmmzqobhf6nam@p4ul7vn7d3an>
 <a403eb91-c90d-444c-b508-c428a8ef1447@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a403eb91-c90d-444c-b508-c428a8ef1447@collabora.com>

On Fri, Apr 25, 2025 at 04:41:43PM +0500, Muhammad Usama Anjum wrote:
> On 4/25/25 1:59 PM, Manivannan Sadhasivam wrote:
> > On Fri, Apr 25, 2025 at 12:42:38PM +0500, Muhammad Usama Anjum wrote:
> >> On 4/25/25 12:32 PM, Manivannan Sadhasivam wrote:
> >>> On Fri, Apr 25, 2025 at 12:14:39PM +0500, Muhammad Usama Anjum wrote:
> >>>> On 4/25/25 12:04 PM, Manivannan Sadhasivam wrote:
> >>>>> On Thu, Apr 10, 2025 at 07:56:54PM +0500, Muhammad Usama Anjum wrote:
> >>>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
> >>>>>> allocation. There is a crash report where at resume time, the memory
> >>>>>> from the dma doesn't get allocated and MHI fails to re-initialize.
> >>>>>> There may be fragmentation of some kind which fails the allocation
> >>>>>> call.
> >>>>>>
> >>>>>
> >>>>> If dma_direct_alloc() fails, then it is a platform limitation/issue. We cannot
> >>>>> workaround that in the device drivers. What is the guarantee that other drivers
> >>>>> will also continue to work? Will you go ahead and patch all of them which
> >>>>> release memory during suspend?
> >>>>>
> >>>>> Please investigate why the allocation fails. Even this is not a device issue, so
> >>>>> we cannot add quirks :/
> >>>> This isn't a platform specific quirk. We are only hitting it because
> >>>> there is high memory pressure during suspend/resume. This dma allocation
> >>>> failure can happen with memory pressure on any device.
> >>>>
> >>>
> >>> Yes.
> >> Thanks for understanding.
> >>
> >>>
> >>>> The purpose of this patch is just to make driver more robust to memory
> >>>> pressure during resume.
> >>>>
> >>>> I'm not sure about MHI. But other drivers already have such patches as
> >>>> dma_direct_alloc() is susceptible to failures when memory pressure is
> >>>> high. This patch was motivated from ath12k [1] and ath11k [2].
> >>>>
> >>>
> >>> Even if we patch the MHI driver, the issue is going to trip some other driver.
> >>> How does the DMA memory goes low during resume? So some other driver is
> >>> consuming more than it did during probe()?
> >> Think it like this. The first probe happens just after boot. Most of the
> >> RAM was empty. Then let's say user launches applications which not only
> >> consume entire RAM but also the Swap. The DMA memory area is the first
> >> ~4GB on x86_64 (if I'm not mistaken). Now at resume time when we want to
> >> allocate memory from dma, it may not be available entirely or because of
> >> fragmentation we cannot allocate that much contiguous memory.
> >>
> > 
> > Looks like you have a workload that consumes the limited DMA coherent memory.
> > Most likely the GPU applications I think.
> > 
> >> In our testing and real world cases, right now only wifi driver is
> >> misbehaving. Wifi is also very important. So we are hoping to make wifi
> >> driver robust.
> >>
> > 
> > Sounds fair. If you want to move forward, please modify the exisiting
> > mhi_power_down_keep_dev() to include this partial unprepare as well:
> > 
> > mhi_power_down_unprepare_keep_dev()
> > 
> > Since both APIs are anyway going to be used together, I don't see a need to
> > introduce yet another API.
> I've looked at usages of mhi_power_down_keep_dev(). Its getting used by
> ath12k and ath11k both. We would have to look at ath12k as well before
> we can change mhi_power_down_keep_dev(). Unfortunately, I don't have
> device using ath12k at hand.
> 

ath12k conversion looks trivial. So please go ahead with this new API conversion
for that driver as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

