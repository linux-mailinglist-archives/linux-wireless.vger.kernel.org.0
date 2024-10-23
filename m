Return-Path: <linux-wireless+bounces-14424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D539ACEFD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 17:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B51F2131C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA21BD004;
	Wed, 23 Oct 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WcAR4o6Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC693A1DA
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 15:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697919; cv=none; b=fRdFd5W1v2ed+coijnfwC3/GO/NuxMKRCVL+Jfb9Ztu3r6Wb8oA5Oa5HQ7/Cj5FrkEU5YzbHKNgaSQ6+uE16uO3a06d4cXAFifu+8vpgf1oZPXW3RdpJc1wgft3j894OOdzMPJdtaKjjfVnCXcF53sEOm0Ta9a8dUXfs2d/LZ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697919; c=relaxed/simple;
	bh=40wzNRTFYJTQECt/5OHgK8NNVo4tKBEUQYIXsqi63h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iVFNh0yMQAfuHWicVKUDvLEkLIkEedyEAB6dZWr/4ODf1kepEnrLuRWHyFT3ptZzGdYlXkayTl0BHGc3E0UNQDA+RMfJ3+VTQY5eUj8hsm++dM6koTFKPweHUrI4eTS1Cx1qnZsBwUpyJ2G7NjCSXU/+0/+UNRlL04IvdFcOKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WcAR4o6Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N9k8ZX025445;
	Wed, 23 Oct 2024 15:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QSgiKCqlVzFV8sXcx6hw5LFFjJAWoVBYu8gEsbHn6aQ=; b=WcAR4o6ZczVoxE+a
	C/4hR8g/rbFPy6Bf3KazWrbpl1lIdTNHqACoHgR9NUQo0bGL9rZ19hkccfmUhRRH
	BEWs1MdB2LW7mAwqLQq2ZhArEWPs8iObWCaNaFhkXvx0YnpS/uK9OmhK7IpnlswJ
	fK2eeIJ/ZxbbGd6BavTePkRcEHnwQE9smxN72G+5jC9+A9EIhIwqE1rqOdxzewQz
	Gd/1ciVZFc6wzIntjILxk5whaz5MVEl3WCv5YPOyyMnZsfyjJ2VpdSLBI0I4rlsz
	9243jyI9w1ghBQS1V4wRaep9B71F6a9/q/c38ondglDbiiwrWRnBjbov90oTGmIa
	zcYeLQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em40aq75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:38:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49NFcXeR031607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 15:38:33 GMT
Received: from [10.48.242.6] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Oct
 2024 08:38:32 -0700
Message-ID: <b989b83c-f911-4d67-b703-1ac3ee219559@quicinc.com>
Date: Wed, 23 Oct 2024 08:38:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] wifi: ath12k: introduce ath12k_hw_warn()
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241023133004.2253830-1-kvalo@kernel.org>
 <20241023133004.2253830-5-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241023133004.2253830-5-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hfqgwRpWNka-6thcBbDiiFVg4qqMHYT_
X-Proofpoint-GUID: hfqgwRpWNka-6thcBbDiiFVg4qqMHYT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=980
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230096

On 10/23/2024 6:30 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> In the following patch we need to use ath12k_warn() but don't easily have
> access to struct ath12k_base (ab) but do have access to struct ath12k_hw (ah).
> So add a new warning helper ath12_hw_warn() which takes the latter but the log
> output is still identical but uses the struct device pointer stored to struct
> ath12k_hw.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h  | 2 ++
>  drivers/net/wireless/ath/ath12k/debug.c | 4 ++--

Qualcomm Innovation Center copyright missing 2024

>  drivers/net/wireless/ath/ath12k/debug.h | 5 ++++-
>  drivers/net/wireless/ath/ath12k/mac.c   | 2 ++
>  4 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 6faa46b9adc9..9c4e5fae8930 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -684,6 +684,8 @@ struct ath12k {
>  
>  struct ath12k_hw {
>  	struct ieee80211_hw *hw;
> +	struct device *dev;
> +
>  	/* Protect the write operation of the hardware state ath12k_hw::state
>  	 * between hardware start<=>reconfigure<=>stop transitions.
>  	 */
> diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
> index fe5a732ba9ec..c5c8c7624cdb 100644
> --- a/drivers/net/wireless/ath/ath12k/debug.c
> +++ b/drivers/net/wireless/ath/ath12k/debug.c
> @@ -36,7 +36,7 @@ void ath12k_err(struct ath12k_base *ab, const char *fmt, ...)
>  	va_end(args);
>  }
>  
> -void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...)
> +void __ath12k_warn(struct device *dev, const char *fmt, ...)
>  {
>  	struct va_format vaf = {
>  		.fmt = fmt,
> @@ -45,7 +45,7 @@ void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...)
>  
>  	va_start(args, fmt);
>  	vaf.va = &args;
> -	dev_warn_ratelimited(ab->dev, "%pV", &vaf);
> +	dev_warn_ratelimited(dev, "%pV", &vaf);
>  	/* TODO: Trace the log */
>  	va_end(args);
>  }
> diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
> index f7005917362c..90e801136bc6 100644
> --- a/drivers/net/wireless/ath/ath12k/debug.h
> +++ b/drivers/net/wireless/ath/ath12k/debug.h
> @@ -31,7 +31,10 @@ enum ath12k_debug_mask {
>  
>  __printf(2, 3) void ath12k_info(struct ath12k_base *ab, const char *fmt, ...);
>  __printf(2, 3) void ath12k_err(struct ath12k_base *ab, const char *fmt, ...);
> -__printf(2, 3) void ath12k_warn(struct ath12k_base *ab, const char *fmt, ...);
> +__printf(2, 3) void __ath12k_warn(struct device *dev, const char *fmt, ...);
> +
> +#define ath12k_warn(ab, fmt, ...) __ath12k_warn((ab)->dev, fmt, ##__VA_ARGS__)
> +#define ath12k_hw_warn(ah, fmt, ...) __ath12k_warn((ah)->dev, fmt, ##__VA_ARGS__)

for consistency should we do this for the other log levels as well?

are there places where we currently retrieve ab just for logging where we
already have ah, and hence could avoid the extra dereference?

>  
>  extern unsigned int ath12k_debug_mask;
>  
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 3de6d605cd74..19c445cf52f1 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -10193,6 +10193,8 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
>  			goto err;
>  		}
>  
> +		ah->dev = ab->dev;
> +
>  		ab->ah[i] = ah;
>  	}
>  


