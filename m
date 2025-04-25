Return-Path: <linux-wireless+bounces-22038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDCA9BFCC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 09:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F6E1B658F0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F422E415;
	Fri, 25 Apr 2025 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhg3DFdw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320E217727
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566379; cv=none; b=dwr5L+ni/P9DoD8aTtHACkI4TjD3o/5eJEfNXVsNXKZvma24yF5zptpmfbx/JmEMbeqc9xGUi4mnlNesdTEqnQ6L07KkReKHjjneegwYJp+FaWGlfdGME9I7+PTJxWJvKo6lkHCJLPboIigwrWTuU3yCAvH4ditmu0yvtY9TPfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566379; c=relaxed/simple;
	bh=aA0ZrtbPTCPf+u7y5/pHP9XzFYTNwoufRKaVyQtLdHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFlILqu4F99Kpd2Q+kVJAoedGMjPNolt23cuXWNKLPreN7eqx3/8Px++sakOFYOXcKAp5iHmV/+mvhUPyIb3PBJf2vkhdCsJHZm+daaZ5zWNOng2IpCgBzs1FJ5ZsNADblh43Rw0Kk1pxpOG6h8yx5RQe4L9w/iPgnUSx/ZWjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jhg3DFdw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22409077c06so29798725ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 00:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745566377; x=1746171177; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xJc0VC1OPnf8MGBGBVEvJ1rm1gHV5SYp4RtZ7UBjMoI=;
        b=jhg3DFdwEqMEyeM3RCxINZyz6q6OOIM7TBH3nU8PKLA0BBroqLxM+iolUHfd3ArqLF
         oZPZdeGRBatlvCDxRaAKvcqR8nKDpmpUW6sUVQXij0gVFsh9zdYY0qXnO5zjnPobw/no
         VNKN+w6fhAyzwndKFGelgK3efiAjdNowAmvUZZ/4GLlyACdZ1xfB4iAVSnDbcs+aQXf4
         SezvyP1mh99FBVNbBX8hG3BNjLqsGw1rTBQr/Kom1/MUCqeQ61qII/Yv6js7kU0q2Mab
         XuBsA5nh8PIzz9Pg7+Z/SYNK7oDYU3HN3vuJ5AOcUN56qU7Jl4oIFktbvfp2Jl2Eyz7T
         L5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566377; x=1746171177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJc0VC1OPnf8MGBGBVEvJ1rm1gHV5SYp4RtZ7UBjMoI=;
        b=SToIPxYTzQDqmiJfW6Sv4B88le26G53WC6AxCzAfmju4okx+4lGV0d5UjTpFtnQWyz
         47a6ozEsvSnI9dazzt3fwAkl/8ywndk+RqqNvPh6GzCMUqwOCyqwwjfCN74ofUS/CK4n
         IBnRRLUZHPGMWJTULKpMvsbTp0n2gyum1MzV9imZYA2owd336JqzoQ81wwTIDFqeCuhv
         aZrhoHBJOqjyiq2krmIyOIAx2nJY6JKX730Bp2Bt2DRMQksCJWfncP62mdn6KTl6C5I1
         t88QwqGgjt8kqy3jC2EL97eDSzciAiQtlO/HvPD1L9vua1qcxDDoEhrzXYyCGCfzqSKN
         IxRw==
X-Forwarded-Encrypted: i=1; AJvYcCVU+LspxPG8rTSoGDAFofcsl2740y71dwYIgNb5iYO3Qg4uD9IkHFW/42I9EmYu6YCsZ4zfcbg5sG1CS5Kacw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDBwzwxhqUrqYHNAV5RNUz2VP5fZNU36loz+6fB7odb1hnSAvJ
	xh60JLRIjP7wmb12vWsadWCDKZUok9LIUAEL94IQQWbWREbxziI9w/sdxVi+FA==
X-Gm-Gg: ASbGncs9RDxJL7Q2z29fmPSiulZtWAXjtlwX7dV/d8POkS+rcbaSMGVbBsBKfCWetYc
	/qalVP8EznIvyMaIYYelZ7nG7xMfItizsYUmemwB7sjHOf9rdV/FTfC4gfpkImuwxWw9A6GaDYi
	f8SVIhOseEyBXqVQLynXBA/Z3UHXpf+whH6c1reSTa+SPdkWE6YU6LAIqbBkQ9JR/rdU+ADnt+u
	ZhIYS3ASuEhs2e60NB9vZeXnWpBaS3HrCHOU+cqarKjj+skeb3ZWQqZdkJ7VbdryNF6Pm59yfQJ
	KjNDTRtzE+PDj1qtxglU2SYOgu0pIz/LnOxUID0PEeMXiYqrVWM=
X-Google-Smtp-Source: AGHT+IEaSjf7mjPyqkb9SLHl28S3KtutHrHtesFq5IWR5am6CHVSmDDpdOQGUAksLd+HiuHc9w/Ahw==
X-Received: by 2002:a17:902:f541:b0:224:a96:e39 with SMTP id d9443c01a7336-22dbf5d89bfmr18972215ad.9.1745566377452;
        Fri, 25 Apr 2025 00:32:57 -0700 (PDT)
Received: from thinkpad ([120.60.77.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4db97b3sm25701435ad.55.2025.04.25.00.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:32:56 -0700 (PDT)
Date: Fri, 25 Apr 2025 13:02:51 +0530
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
Message-ID: <cfb3sntvqhupyhm2m5tevpsl77r6mzl2aqzr3wtxvr22bezmp3@qjh7ftr2kdjy>
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <h2wv7drxntokziiwbzjw5xjzbctbomp6cfcba7ppfbih6o7so7@p6dazv32xfx4>
 <1136c7cb-1c7b-410b-93d2-c74aec939196@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1136c7cb-1c7b-410b-93d2-c74aec939196@collabora.com>

On Fri, Apr 25, 2025 at 12:14:39PM +0500, Muhammad Usama Anjum wrote:
> On 4/25/25 12:04 PM, Manivannan Sadhasivam wrote:
> > On Thu, Apr 10, 2025 at 07:56:54PM +0500, Muhammad Usama Anjum wrote:
> >> Fix dma_direct_alloc() failure at resume time during bhie_table
> >> allocation. There is a crash report where at resume time, the memory
> >> from the dma doesn't get allocated and MHI fails to re-initialize.
> >> There may be fragmentation of some kind which fails the allocation
> >> call.
> >>
> > 
> > If dma_direct_alloc() fails, then it is a platform limitation/issue. We cannot
> > workaround that in the device drivers. What is the guarantee that other drivers
> > will also continue to work? Will you go ahead and patch all of them which
> > release memory during suspend?
> > 
> > Please investigate why the allocation fails. Even this is not a device issue, so
> > we cannot add quirks :/
> This isn't a platform specific quirk. We are only hitting it because
> there is high memory pressure during suspend/resume. This dma allocation
> failure can happen with memory pressure on any device.
> 

Yes.

> The purpose of this patch is just to make driver more robust to memory
> pressure during resume.
> 
> I'm not sure about MHI. But other drivers already have such patches as
> dma_direct_alloc() is susceptible to failures when memory pressure is
> high. This patch was motivated from ath12k [1] and ath11k [2].
> 

Even if we patch the MHI driver, the issue is going to trip some other driver.
How does the DMA memory goes low during resume? So some other driver is
consuming more than it did during probe()?

> [1]
> https://lore.kernel.org/all/20240419034034.2842-1-quic_bqiang@quicinc.com/
> [2]
> https://lore.kernel.org/all/20220506141448.10340-1-quic_akolli@quicinc.com/
> 
> What do you think can be the way forward for this patch?
> 

Let's try first to analyze why the memory pressure happens during suspend. As I
can see, even if we fix the MHI driver, you are likely to hit this issue
somewhere else.

- Mani

> > 

[...]

> > Did you intend to leak this information? If not, please remove it from
> > stacktrace.
> The device isn't private. Its fine.
> 

Okay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

