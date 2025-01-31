Return-Path: <linux-wireless+bounces-18257-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C5A2452D
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 23:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBAF3A58FB
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5301B415D;
	Fri, 31 Jan 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JufgXu05"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E92A1547E4
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738362111; cv=none; b=vE1eVAGrefNPLKd8YbXu88RH6h5/DM3LexP9Ly85aHJblD8JzNe+/08meoTnr8fWzmFOnW3TmLkpsuBa8CyWqrpuGOyqvmHzftb2NHq5ZaRZSYhtbWri57BVIJjm/hVNaxy0u0xpr4epJ7KGYxDFkCfq3QsNA/3oKEB46gnMYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738362111; c=relaxed/simple;
	bh=KbrFdyD/bpfV8KJgZlshax3DHtdiuG3Af0rvvQwD8Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NI/XdB1IElJ3vd7lzvqOT8Qtk+3+5wR4xS/jHahdwOv6GG3UDcDMY6Mk/y9E33udjgaU3/1u1fLq+hCHWka6nbNY54uHy/s2i4O2yfUHsHjRbzjUe0ulC8MLVnMnKdrmowl1B6d8U3zXmqNMUF+Vn3ndhnh+WWFvsDc85/zbGMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JufgXu05; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VDKhMT009723
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 22:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mUB3hp0A/oyJSzN/kCE+SQcJbrJLtU+PWheTVJA603k=; b=JufgXu05Ime6bmk2
	TZUCUhKh5nugsMRaPyHT3gV4BjCpM7803lYX07ogl4jayuXPkEuOAiinzQ0C1bdY
	YK3wZrMR20j4EqHa2ZLFUOmxaUgMd3QxDhuhNKuBZBdVahjlSkbtBajXEXaT2ZYn
	b68gPJvHM95TweVZlQPW9X3aUZ0y4nwvq/G+jQPun6LIsamU9orU/9FmlGy5XEBj
	Rk52PV7daShTUESHAEZE2NzB5CKtgBfKRwfs1S/gLVFbyzePC1cQynjuFba9/2IJ
	uTg2kvIbCRPh/T8oi+1IAdPHBPg6AUoDlsxzK1PrDC8GvKgciSg8s20hkyvdiIWe
	LlIdzg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gyaph6re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 22:21:48 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21650d4612eso67170025ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 14:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738362107; x=1738966907;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUB3hp0A/oyJSzN/kCE+SQcJbrJLtU+PWheTVJA603k=;
        b=w4qBYRcawzfPDJq2Mhe4ioq4zEL5+6RVwh86KFmgtFYK5Ls4CvGxgtVcHof4LzdQrM
         T3ZO5AsylGMPH0meb9msMcoQXunFmmi8gnVstuDk9om2AsGsqOhkyYT1DxLDqITM9eCe
         sreVvEGl40boCh3EkiDxsxlUt77hNCXk6mxXfqh3UJKb2J4vnJaWzupP0KwrszIhI8rq
         G7CDqXhhPU4pQsWNzAdCbqtRMwMAcLMrQ6qV69Wmhq6VqjlChCvje02Dwkb5xmq/zArb
         5xSgsmsCRCmmsLfeFMPYBfvLDgaZFUU0tl/u6xVVZoQXmkr/RBLrbfbxfHU7O9ahenaL
         SuGQ==
X-Gm-Message-State: AOJu0Yx4vfc7bjUEm8jZL4msGbruQOa2GonnM4+iKlVK5RHQ8nTBBwY1
	khPG1jtiOaXiabZSHbxUvADUe4EpZxGoXuJV/FBxHHLNCGrXIxnnqRKj1CMsusck9mrEG2dYMM5
	ieg3F29hQbIDRBYFMoV9Fwc15sPXqfUmkmxoMtqtRM3EwPb2b3ZDBQI9ZF6PsSEicHQ==
X-Gm-Gg: ASbGncv6MTJPj8u4ImBg+fOwKrdlwWaca3G/03Rf04RNMTjravgQkerXptxAc0r8YZi
	mHoX/upcM4ChcoVYOuyf2Z338iF+59kTJEkBk5U+fZ5loVO3gQvOknJ1XVpwrNe3Fy3m9dcMZEx
	ZsRvWGsBNVc7dnJEvRG4YhC9fgPq8yozuzUwKMARs/fYC3SKll5Covig32WnegyvP9NG9PB2WEm
	tYjNvguytWRwQN6ORCzhwIXD//TafwKme7AwZxxU7l7SgQevaV6Cjm3f+HuQDV5tJEG6v4D7VQ+
	R8wIDYj08AmDh3xpzqosVxFProaa9yn4cgcswM7cDAl4D2Wq8OxZ/WugxfowA4VTpqFU/4ppsw=
	=
X-Received: by 2002:a05:6300:6385:b0:1ed:a812:c3b with SMTP id adf61e73a8af0-1eda8120d25mr1156919637.2.1738362107196;
        Fri, 31 Jan 2025 14:21:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvl97v+gvKvCqFmCOTlaqsxyHfMPlUjGPpurC9VbXfstnDJM7M0Vc2/Ub1uoY8F5xiGAZZ2Q==
X-Received: by 2002:a05:6300:6385:b0:1ed:a812:c3b with SMTP id adf61e73a8af0-1eda8120d25mr1156894637.2.1738362106829;
        Fri, 31 Jan 2025 14:21:46 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe56daeasm3054666a12.32.2025.01.31.14.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 14:21:46 -0800 (PST)
Message-ID: <a8f4f4e7-1c13-44d8-b19e-4ac85b48ee04@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 14:21:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] wifi: ath11k/ath12k: Set IRQ affinity hint after
 requesting all shared IRQs
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, kvalo@kernel.org,
        jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20240823155502.57333-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SW5WZGobue4gzZTQjaHRMzRH8BmJQVJq
X-Proofpoint-GUID: SW5WZGobue4gzZTQjaHRMzRH8BmJQVJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=981 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310170

On 8/23/2024 8:54 AM, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series fixes a warning from kernel IRQ core that gets triggered in the
> error path of QCA6390 probe. While fixing that I also noticed the same issue in
> the ath12k driver, so added an untested patch for the same.
> 
> Finally, I updated the irq_set_affinity_hint() API in both drivers as it was
> depercated.
> 
> - Mani
> 
> Manivannan Sadhasivam (3):
>   wifi: ath11k: Set IRQ affinity hint after requesting all shared IRQs
>   wifi: ath12k: Set IRQ affinity hint after requesting all shared IRQs
>   wifi: ath11k/ath12k: Replace irq_set_affinity_hint() with
>     irq_set_affinity_and_hint()
> 
>  drivers/net/wireless/ath/ath11k/pci.c | 26 +++++++++++++-------------
>  drivers/net/wireless/ath/ath12k/pci.c | 26 +++++++++++++-------------
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 

What is the status of this series. I inherited it in Patchwork from Kalle.

It looks like there was a question if the 1/3 patch was actually applicable.

If we think this series is needed, can you rebase & repost?

/jeff

