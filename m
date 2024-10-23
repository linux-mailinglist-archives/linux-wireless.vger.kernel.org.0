Return-Path: <linux-wireless+bounces-14393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9239ACBDB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9F01C203B7
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C621A2C27;
	Wed, 23 Oct 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ViuqvDoU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E161D554
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692180; cv=none; b=ei9QTvOaRb1aWlq/5xILp0tKckku3iuhpBZ7AHNhAemGBf9XUFvPUQeEtapcpO08MFFl76OD5tGiexEPkRIf9r/vBCOXXE8tz5vcvJLYhuNltT/PfdZ3jykHZwqjUTEWE4n8/eONsucioeiugcNJfJt0AO7MzRTsmlvmlvMwr+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692180; c=relaxed/simple;
	bh=7O2gn8GW0YsSw3NMN6arLfIokKiJpeEDN/V/hNATPyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C8S4wWso19vyUmYCDwksP1NE9UTIzCdzgb9eblEqs8N8E5ARhVrydvxOYHOu7lE64E0jl99SeT/fWPoFISOrOraurVV9mDdSSZh5HHRTlotWve2+xlt8KzCY7Rx8yFmca2kggI8lHswW8Q7HmfvXofTM+ny+7ZEeVS3AjQIGgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ViuqvDoU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9dBq8029637;
	Wed, 23 Oct 2024 14:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rfgOaPeA5MpppB/MxMW5onXIJT+Q9xb/umUkV0JAO4k=; b=ViuqvDoUxrV26saV
	/RAFEXb2pfpZbisLniRtv3gJD+DQiUWXpBZkRvo2CCqI2dCkED90Jmfg+slP0QYa
	WV9O0rthTqTYXcMuLRrhJE24Kt4OxDs6l/i3Og/IKDqQFT2o1vNsCOf1rQUoGRbV
	iEBaABhO8Na/Nm7X5ldkrmApe+Jo7kBOxJyNF6sinQh97YMkr4Qo6J7Ds+w9kGGj
	prFSKHn1gCXB1GsKQrP04IDxJO+/OHcY4Ot9mi7KW/hbASTD8YtpkSVvS72oSbgS
	lguIPPx6Wqt/WR5vrNoaQwGHFmqvRQlz2mkYKmzpMLLbevNe+e9aYyWc3n4fTLaW
	vyWzsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3w2ejn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 14:02:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NE2hx4019122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 14:02:43 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 07:02:42 -0700
Message-ID: <f8e6901a-0f68-44e1-81e6-729539693fa4@quicinc.com>
Date: Wed, 23 Oct 2024 07:02:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ath11k: fix return value check in
 ath11k_spectral_debug_register()
To: Zhen Lei <thunder.leizhen@huawei.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff
 Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <20241023074051.309-1-thunder.leizhen@huawei.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241023074051.309-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: s2kbZA6Vu7Z0vNtTOG4IJzF3cW8ObMjj
X-Proofpoint-GUID: s2kbZA6Vu7Z0vNtTOG4IJzF3cW8ObMjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=969
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230085

On 10/23/2024 12:40 AM, Zhen Lei wrote:
> Fix the incorrect return value check for debugfs_create_file(), which
> returns ERR_PTR(-ERROR) instead of NULL when it fails.

Based upon the commit text this change is incorrect.

 * NOTE: it's expected that most callers should _ignore_ the errors returned
 * by this function. Other debugfs functions handle the fact that the "dentry"
 * passed to them could be an error and they don't crash in that case.
 * Drivers should generally work fine even if debugfs fails to init anyway.

So ath11k should not be checking the return value at all, and definitely
should not be returning -EINVAL since the driver should still operate even if
creating a debugfs file fails.

> 
> Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/net/wireless/ath/ath11k/spectral.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
> index 79e091134515b43..4c545231292142a 100644
> --- a/drivers/net/wireless/ath/ath11k/spectral.c
> +++ b/drivers/net/wireless/ath/ath11k/spectral.c
> @@ -942,7 +942,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>  						    0600,
>  						    ar->debug.debugfs_pdev, ar,
>  						    &fops_scan_ctl);
> -	if (!ar->spectral.scan_ctl) {
> +	if (IS_ERR(ar->spectral.scan_ctl)) {
>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>  			    ar->pdev_idx);
>  		ret = -EINVAL;
> @@ -953,7 +953,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>  						      0600,
>  						      ar->debug.debugfs_pdev, ar,
>  						      &fops_scan_count);
> -	if (!ar->spectral.scan_count) {
> +	if (IS_ERR(ar->spectral.scan_count)) {
>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>  			    ar->pdev_idx);
>  		ret = -EINVAL;
> @@ -964,7 +964,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>  						     0600,
>  						     ar->debug.debugfs_pdev, ar,
>  						     &fops_scan_bins);
> -	if (!ar->spectral.scan_bins) {
> +	if (IS_ERR(ar->spectral.scan_bins)) {
>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>  			    ar->pdev_idx);
>  		ret = -EINVAL;


