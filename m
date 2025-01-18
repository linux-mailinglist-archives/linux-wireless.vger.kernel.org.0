Return-Path: <linux-wireless+bounces-17677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F41A15C65
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8314A1667CF
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jan 2025 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AC318859A;
	Sat, 18 Jan 2025 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e7adf74/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1380D12EBEA
	for <linux-wireless@vger.kernel.org>; Sat, 18 Jan 2025 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737196795; cv=none; b=P5j8rKDQLGaUx50dNXMn67pkIwm6H7mczLfbMB5kNfCp+a1ibVKZulNXyl4skc6ooYJQKLJUNKzuVJ26lzxf0O3SvNOp5jryirl04qMFyQntU+jREJUs7wZMF9cMD3y7ZtvneTXtnxQHh7QtPTmNsi56Js47bRFMWlIzVVGxPS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737196795; c=relaxed/simple;
	bh=oKW5k8Y8CabBK/M4DubJsmmUNvJ077IxZaZEsyITdfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EQM01A1kkhMaRjIJd1cqbxGbQMH8vdymNLP+8Ub+50bwQbJgyY/LoJN4TNDbH6xTNT4nKLGo2XSgp3AzWF4ZM3dYe2429DNZaUgHzZ8R6UCXQGbr5SSTg791LZ8cfgmovDuuyMLl3qifJ6l0th3riYsTQRQFx9mN6QaxnUx+Nzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e7adf74/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50I2Cl5s031296;
	Sat, 18 Jan 2025 10:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y511yARXHA1OunlF4jSA59rutRHPVpZ8LgrG7J919Uk=; b=e7adf74/yf8tzuaA
	xHxCTeZ+jfuRBlpSa4WNE9zfvl0d0viRKp092lttzZfH1SPzgMC3KF4uDlF0g7+y
	rX+CeGFFe6dYyfVlB31l1I9jhQYYZaK+UsG05OCkkmkluxNu5UE7WY37Eib2R+da
	tWrllFJRe4NydoTwEJEPulU4dWYPwlwRlStpFpryIMD2akr2ziMUi0ozealOT5v5
	m4gzsUceFYtElod1gLuMVq6JG/b88Wf8phZIvE8OS/8gkOU7ZjHnHsRkM8FSuNSE
	SQF9bVFuL9+syq78cm9XFNyUJXVz2pBpNgPtxFdeN/4QqbnTd1Y0VfHyL+tJ3TUr
	8AwNHA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4483a60jv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 10:39:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50IAdnCJ003731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Jan 2025 10:39:49 GMT
Received: from [10.216.41.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 18 Jan
 2025 02:39:46 -0800
Message-ID: <0e382f90-129b-e5d7-43fe-b57e19096ad6@quicinc.com>
Date: Sat, 18 Jan 2025 16:09:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath11k: remove peer extra rssi update
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250117181953.3375273-1-nico.escande@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250117181953.3375273-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R2smVgrAZZFel7GkaoF-Ibo65708sLIl
X-Proofpoint-ORIG-GUID: R2smVgrAZZFel7GkaoF-Ibo65708sLIl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-18_03,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501180084



On 1/17/2025 11:49 PM, Nicolas Escande wrote:
> Commit b205ce4c266c (ath11k: support avg signal in station dump) added an
> extra assignment of arsta->rssi_comb in ath11k_dp_rx_update_peer_stats
> when it added the average rssi support. So lets keeps only one by removing
> the legacy assignment so the two statements about rssi stay next to each
> other. Compile tested only.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_rx.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 029ecf51c9efd..24774cba9823b 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2831,8 +2831,6 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
>   	rx_stats->dcm_count += ppdu_info->dcm;
>   	rx_stats->ru_alloc_cnt[ppdu_info->ru_alloc] += num_msdu;
>   
> -	arsta->rssi_comb = ppdu_info->rssi_comb;
> -
>   	BUILD_BUG_ON(ARRAY_SIZE(arsta->chain_signal) >
>   			     ARRAY_SIZE(ppdu_info->rssi_chain_pri20));
>   

Good catch!

Reviewed-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

