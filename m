Return-Path: <linux-wireless+bounces-7647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E48C582E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 16:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7151F216B0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549917BB28;
	Tue, 14 May 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cqv5U9MX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D2158213;
	Tue, 14 May 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697817; cv=none; b=ayAf2V6Ih7wk42e/gwH8uPBuwmZ8N3fIlYA7fZFGGs3et2GySm5siHLRANR12T4TLZ8N/YXIpi52czui7NBj5OIzkbuLlPTewjRk6UTMEg8l4jq1gHFKJGMxW8er5Hh8ozhr/yW9cpS3aNqApOMMaktgHXd/qP1M4Px3NIQiLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697817; c=relaxed/simple;
	bh=yjz8BI8fWaQQVWoDkSf+/J9WJUV/N1nI3QgP6yJ6s4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z0/QTc+F8yX9HZiK3M3JhGvsjdOLsIU/Y0vmGAm4i6McUu7IIqqbjRtwRrmmOhCCkTMGmMDdjbFN2sMA8QTP8sIkwiICSqylnACzEGp+QRj4LxnLgcppe2N1CCH1nBN3TxEXRc/1fMWTwpfBDbkCzmCBhw7WIAbAVwtaZSwGmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cqv5U9MX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44EA3WtS004117;
	Tue, 14 May 2024 14:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=aAjjICOleHXNnITLx80ygde13/wbWjLWPL4FqboldaM=; b=Cq
	v5U9MXDpZxIXRfktQIkC5+6NX5gBJZEWYaN5HlzMFm8Go3vSkUpQiI8IAkJ1xJ0o
	RJtXDawnU03/u3fu8NbndpnELudbmBcbiezI09M4Bt23J4aWjFzHwnxgg2lE2kBc
	dhuClwcWbi9iy1lvM7lSmMtxfxZzA+s8a5l3Mu1f8hEyZTl5ZzVE8RiPHZjnMijk
	70/51pM6Mug9mPSHMDpfFLcHXj/J8BVAi1Fqt6h7/ZF8alRZhY541G5P7qOmLvpZ
	qTfsKp9WXfko6YvfFs9Kxmt+jifhFeAivhxYr2Unbl1orl8Y4vSDEaVp3wXzgvAV
	mJhWSTgs0E4zWHMtqpFw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y45vb8n82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:43:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44EEhRtK019301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 14:43:27 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 May
 2024 07:43:26 -0700
Message-ID: <12a208d7-f36b-4953-abff-323a15452b3c@quicinc.com>
Date: Tue, 14 May 2024 07:43:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Stephen Boyd
	<swboyd@chromium.org>,
        Rakesh Pillai <quic_pillair@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <linux-kbuild@vger.kernel.org>
References: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4OmYH8MLtWgkn02V-bn8b6U1_Y2cZtnJ
X-Proofpoint-ORIG-GUID: 4OmYH8MLtWgkn02V-bn8b6U1_Y2cZtnJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_08,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 mlxlogscore=911 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405140104

On 5/11/2024 3:49 AM, Dmitry Baryshkov wrote:
> If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
> modules, compilation fails with:
> 
> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_init':
> drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qcom_register_ssr_notifier'
> /usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_deinit':
> drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qcom_unregister_ssr_notifier'
> 
> Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
> built as module if QCOM_RPROC_COMMON is built as module too.
> 
> Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as crashes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/net/wireless/ath/ath10k/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
> index e6ea884cafc1..4f385f4a8cef 100644
> --- a/drivers/net/wireless/ath/ath10k/Kconfig
> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
> @@ -45,6 +45,7 @@ config ATH10K_SNOC
>  	depends on ATH10K
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on QCOM_SMEM
> +	depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=n
>  	select QCOM_SCM
>  	select QCOM_QMI_HELPERS
>  	help
> 
> ---
> base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
> change-id: 20240511-ath10k-snoc-dep-862a9da2e6bb

I see how this fixes the problem, but this doesn't seem like an ideal
solution. The fact that the *_ssr_notifier() functions are correctly protected
by conditional compilation ideally should mean that clients don't need to call
call out this as a dependency. Otherwise, it would mean we'd need to do this
for all feature flags.

+linux-kbuild just to make sure there isn't a better approach.

/jeff


