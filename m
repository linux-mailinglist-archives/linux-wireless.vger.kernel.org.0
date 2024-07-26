Return-Path: <linux-wireless+bounces-10539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F28B93CC06
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 02:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7BB1C2150C
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2024 00:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D271A3D;
	Fri, 26 Jul 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JVGxOIgY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E66AAD
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jul 2024 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953087; cv=none; b=BS0uCelMx3GctxtnVYZcB4yFiQ0fQp7OQssWZYqRmmAX2fcEBiQKv/R0tJcJeffwPO0aBUQY3/LuyssPbw1f2HdLvsqsPbIEC37u2LfWbPAPrdPxWDRG02DrgAPm344MvqpYk4mCME0c0zotU57eFzRkdCu2QR07CNQGQ8hY0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953087; c=relaxed/simple;
	bh=OclD6yymCb8yJsjXk1m6Lud4y6HlUbqSAsgSRfN6byA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vCwwbSWy9pgnP6zxjZEh+dQWnOA/qsp5oPII2wq91gilo8UIeqD9r/auC4MlMrzv3qNFc6yqMyId51ih/2IqgCPaaL0yftolhP7a8a2FVk6g+47dyOjENu3Sd4bKqTZT0WN8Pqcyoqgz6hFJSNy1fzPT+WRqeoBxhaSrOyhbUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JVGxOIgY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PNUYV7031523;
	Fri, 26 Jul 2024 00:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1fN8SHihm27y1/SQOsRD6lqRNmPd8YJizkOqvQugAfM=; b=JVGxOIgYY/lNiQKp
	tEJn+pRqNW4rSFNzvz0DlEMIoLuHJ4FGu5tkatFjkLsp9RiWefe5PuIKobHvSwLp
	4nqZMUejqsYy2X31e61lwo4V2+rKh4dz+qnDEquDXuh4ERl0QFdnjtbXEwAG9JKW
	JL0cgWonvirvU1uoTWTvXTc92zBAIsqxnIHg8+mu4RI2dLJiKQRRvRCH57Lvpa/3
	Q9+TKWSxSNVgV8jrbz5YPeis+lN148ZrA0mbEQF/Zw2E9eW/Hf87dTmu80Wtb2wj
	a1Hxlu4rnyzqptDWDlOU2hIdaHPVB+2qgYKNhG7ZqeRalConPz+jm6O7UiYP0f8x
	r4vQog==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40jxxbmxg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:18:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46Q0I2OY004143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jul 2024 00:18:02 GMT
Received: from [10.111.176.158] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 17:18:02 -0700
Message-ID: <2a44b24b-f122-44de-a053-fee07753eb7e@quicinc.com>
Date: Thu, 25 Jul 2024 17:18:02 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] wifi: ath12k: delete mon reap timer
Content-Language: en-US
To: kangyang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
 <20240725120035.493-12-quic_kangyang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240725120035.493-12-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: An4BC6sdUtOYyepNGPPQ1Kcx7Bbsv1ol
X-Proofpoint-GUID: An4BC6sdUtOYyepNGPPQ1Kcx7Bbsv1ol
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_26,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=846 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407260000

On 7/25/2024 5:00 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> Currently mon reap timer is not used, and it is not needed anymore.
> 
> So remove related code.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  2 --
>  drivers/net/wireless/ath/ath12k/dp.c   | 25 -------------------------
>  2 files changed, 27 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index daf7c04bb728..83ef92ecdc39 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -888,8 +888,6 @@ struct ath12k_base {
>  	struct ath12k_dbring_cap *db_caps;
>  	u32 num_db_cap;
>  
> -	struct timer_list mon_reap_timer;
> -
>  	struct completion htc_suspend;
>  
>  	u64 fw_soc_drop_count;
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index 61aa78d8bd8c..547ecb419809 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -974,8 +974,6 @@ void ath12k_dp_pdev_free(struct ath12k_base *ab)
>  {
>  	int i;
>  
> -	del_timer_sync(&ab->mon_reap_timer);
> -
>  	for (i = 0; i < ab->num_radios; i++)
>  		ath12k_dp_rx_pdev_free(ab, i);
>  }
> @@ -1020,27 +1018,6 @@ void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
>  		ab->hal_rx_ops->rx_desc_get_desc_size();
>  }
>  
> -static void ath12k_dp_service_mon_ring(struct timer_list *t)
> -{
> -	struct ath12k_base *ab = from_timer(ab, t, mon_reap_timer);
> -	int i;
> -
> -	for (i = 0; i < ab->hw_params->num_rxdma_per_pdev; i++)
> -		ath12k_dp_mon_process_ring(ab, i, NULL, DP_MON_SERVICE_BUDGET,
> -					   ATH12K_DP_RX_MONITOR_MODE);
> -
> -	mod_timer(&ab->mon_reap_timer, jiffies +
> -		  msecs_to_jiffies(ATH12K_MON_TIMER_INTERVAL));
> -}
> -
> -static void ath12k_dp_mon_reap_timer_init(struct ath12k_base *ab)
> -{
> -	if (ab->hw_params->rxdma1_enable)
> -		return;
> -
> -	timer_setup(&ab->mon_reap_timer, ath12k_dp_service_mon_ring, 0);
> -}
> -
>  int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
>  {
>  	struct ath12k *ar;
> @@ -1051,8 +1028,6 @@ int ath12k_dp_pdev_alloc(struct ath12k_base *ab)
>  	if (ret)
>  		goto out;
>  
> -	ath12k_dp_mon_reap_timer_init(ab);
> -
>  	/* TODO: Per-pdev rx ring unlike tx ring which is mapped to different AC's */
>  	for (i = 0; i < ab->num_radios; i++) {
>  		ar = ab->pdevs[i].ar;


