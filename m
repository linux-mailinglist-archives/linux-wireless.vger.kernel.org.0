Return-Path: <linux-wireless+bounces-22035-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C797A9BF21
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 09:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6589A0138
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7EA22D7A8;
	Fri, 25 Apr 2025 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMCs14US"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299922A4CC
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 07:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564659; cv=none; b=KM7DDsOu7rO63pd0NveuSTYn5WEFfrmGIgxkfoEw0WOn0wBuxMdC5nzbnUxLVRAT2OWqykBunDipnqZBZUM8V7gjReM5JZofhl1xrXm1xcyJEDoGoNbZJunnIxJ7KVsE3Niu5+eBdtriRJEy6ayuIoDBVLzmZexJq0k1XkF3I4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564659; c=relaxed/simple;
	bh=kiVsHOtAUvNtO6KMgCqWAVEF+ip5WZJK6X2lYcCFLyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9Fsk/wVfL9aE405z3nUY0gXIvzfeFZLZ9MYHIPJaTBMWNYe5xKLgnGiBUV6WrZP3D3vES0mZYABAd4Sfbff72nDBtRPqjWHhHgnhnI4Idv8ic2zT3/Av8hZb4MZLxJlIuWKI//sXxXNPcYtrhnSvxxZrJ5Naj4FjuADxTk3JZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uMCs14US; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso2055779a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745564657; x=1746169457; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Te3ksqRJ+7OlpUSNfGlJHaCjELIs2UO0MQxGmKigXE=;
        b=uMCs14USTT/ykuPJrlJcPk5RrOFO9d6IAXDWjjKXrookunBMtI18dxu1a4I/jXsHEF
         sMeqRj9lZksg9UBAnf+BnpVbLfSCi+TFbl3WynIMoJpVCggnNIbDMo3T+lG8aX5QkHM7
         fp47kqr78MCh8GK5gwni8yR4yN3v6drLvncSp36o1LtIs/MfoRP6Kj8/7g2LDwV8dtEO
         nsGri/wJEX/8raVn+mQWR2Tr8gDozwBL+u0UhAXa6irSnePZ0odO+Dl5A7ZqAoIREuEG
         om/QUaWhqMS3p0aiB9o7+OvulxV0nUhVda2rRQsm0TWF9NdznVvcWJTVTM6MPlYg7qtT
         xpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745564657; x=1746169457;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Te3ksqRJ+7OlpUSNfGlJHaCjELIs2UO0MQxGmKigXE=;
        b=EeMY5VpPX00vBuD25anPfSkVGCZOP7NBlRyQPSBFfvflRSZrg9d+i4MA4MuCHZTXQE
         aDMkdfJk+gwIg1IoJlV60lYRxMAKqh6aiFnLulfkmd7xeGOl1uO89bWF83W4vTfvIHcv
         zxitBML5Kc5jBqH/+KGr9vA+aKie0ef16SSGKKoltZmGYrGLFuShs2yL06E+rNXYcetR
         uD4gd6J7GgtbYIt+LAqvx7lE5DUcGugrWZP+xRaSAQioFzBtPnmdQ+lrKtUeSRIRRSXB
         vUK4pkxzA2Dccq6XGr74VbbAekx3h/D52he93yhbQgnPwVRgyKDnZDgqaiopFz1oz47q
         W7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSs3xfMSUgq5kdCrzdz+loZ+Bo2W14VndbemL9eRIAAfCmMwF9/oC8pSvh0TkcoshpBjxK9q8fnEKNn6m/4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPqT0VjIUZfek2AYMqxpUVq5jh/1fI09xUhlAFiGR4Ua11qjAK
	OeDJuAaQLMDM3FSRd5fkV2xLOq7XdSxAW6KVnXn6Hdd/gKdt7K3uKir8z8Y8bK+jJy+d0Wfx0Ww
	=
X-Gm-Gg: ASbGncuppFvoX8/cJpfCDuMonM84JnLvznK+7pB5gnxk/hC2Em/Z8joZBht8cGu6Dug
	Yo0hQpheHpA+R+kis68PzZpT6wUWvo7Jh3WHzzViNpvPQlujSt4cDmyrFtRcxd5s6dOz6ciUqib
	K0fHA2QUR+kTU9yIuaMBUcxdg0MwTAHw/suUswQ3ed+R5LtTUKcC9d00lyLWki2DbIVC4b6ktwi
	qTCeLBu07OUWh2IFym+eFK3LfKBSLc1kDKAMSYB3+fTCZttjMk4rjzqCQlV0x0g7SoLJ7HeFahA
	+891i6J7ozP9XxUAIoatZ3fTwqbzoGRySdii9/WqEDwiJDkM+Sw=
X-Google-Smtp-Source: AGHT+IFprbi4xKoK9kQYGafLrF0iV6P6sf27aP6lhIQIfke7L6VaLDQhys8cFeKJ/FRwTwPktrq5xA==
X-Received: by 2002:a17:90b:2f4c:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-309f7d99200mr2192871a91.5.1745564656964;
        Fri, 25 Apr 2025 00:04:16 -0700 (PDT)
Received: from thinkpad ([120.60.77.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5102ddcsm25163355ad.190.2025.04.25.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:04:16 -0700 (PDT)
Date: Fri, 25 Apr 2025 12:34:10 +0530
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
Message-ID: <h2wv7drxntokziiwbzjw5xjzbctbomp6cfcba7ppfbih6o7so7@p6dazv32xfx4>
References: <20250410145704.207969-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250410145704.207969-1-usama.anjum@collabora.com>

On Thu, Apr 10, 2025 at 07:56:54PM +0500, Muhammad Usama Anjum wrote:
> Fix dma_direct_alloc() failure at resume time during bhie_table
> allocation. There is a crash report where at resume time, the memory
> from the dma doesn't get allocated and MHI fails to re-initialize.
> There may be fragmentation of some kind which fails the allocation
> call.
> 

If dma_direct_alloc() fails, then it is a platform limitation/issue. We cannot
workaround that in the device drivers. What is the guarantee that other drivers
will also continue to work? Will you go ahead and patch all of them which
release memory during suspend?

Please investigate why the allocation fails. Even this is not a device issue, so
we cannot add quirks :/

> To fix it, don't free the memory at power down during suspend /
> hibernation. Instead, use the same allocated memory again after every
> resume / hibernation. This patch has been tested with resume and
> hibernation both.
> 
> The rddm is of constant size for a given hardware. While the fbc_image
> size depends on the firmware. If the firmware changes, we'll free and
> allocate new memory for it.
> 
> Here are the crash logs:
> 
> [ 3029.338587] mhi mhi0: Requested to power ON
> [ 3029.338621] mhi mhi0: Power on setup success
> [ 3029.668654] kworker/u33:8: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
> [ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted 6.11.11-valve10-1-neptune-611-gb69e902b4338 #1ed779c892334112fb968aaa3facf9686b5ff0bd7
> [ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024

Did you intend to leak this information? If not, please remove it from
stacktrace.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

