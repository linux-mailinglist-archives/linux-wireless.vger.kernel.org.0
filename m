Return-Path: <linux-wireless+bounces-21019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE89A77387
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 06:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CCA161F2F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 04:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2534CA4B;
	Tue,  1 Apr 2025 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H/yGP0ju"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2D01A3150
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 04:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743481786; cv=none; b=gEfQ6l4AKl6AOkTUhjv6wgqnVpLmEPpnXIlqmGxQ02DqA4HNfeIOQdQnFA2DKYM2E9H3VMriTXLgW9kBtPTMeFiMHnY/lOeEubZtBgvOqPWre+Uq9t20+8buYhgcq6up+17BN2dyPkRBF6SCiP1XJ3YqYt+2umzrO0cz5aRzFPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743481786; c=relaxed/simple;
	bh=S0+kecUKwqWU3SI4s/ELLtveCwcGWowRzP/RUtNrs1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V9kyaq4z3mA99osfApJ81rL6VDgG5SlRmY7aGKwVnxLMcAzLMlcJf0X5FXhCrHMYotCZEiGms3OeVj906j5v5XgY1+VtFUsVnrqLY0JuXDUKR8GzEMoCC+hlToqzq5juBrR2jnhdNxvL78fDfIJq31BPk5sEK0KISxoGhDAThoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H/yGP0ju; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFCx6C000595;
	Tue, 1 Apr 2025 04:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VB4Weyi+0FzMGfQETvxXzBowEm4f4z3ZdDARGEsdCRg=; b=H/yGP0juScU+GZ7P
	1AyWqUsQ1xW9aNaOLOF6dUlNJSI1uB7jpNOv9IyZBpkZJhidKz/qC8skyNXcn9yQ
	RpmLgFiV6tg2GsOyzNV2Uh7J2B5YiFdYMAG23aB8PrEtYBZUi/KmPQ+toL/azH8m
	bw5xhoNBoBUyUC9W5P1vtErE52OJcjvoEpmB3lLMPUzn+Gp4jACDwb7OPi3hMOrn
	MG1mHPlfsJThfY+n8nOatIvzBcOhjeB4fxyEPocP8gQ4XszUHRXCXpxy+Q2T9w/J
	RBOgRBuVa8BrAPJ2G3FIZ2caG2tU/3nNGmoxoSltcWn2cQPaT5Ar7JowCIdj3LDR
	hqbu8A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p67qeqbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 04:29:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5314Tc6U003403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Apr 2025 04:29:38 GMT
Received: from [10.152.202.85] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 31 Mar
 2025 21:29:36 -0700
Message-ID: <04a67234-ee2b-4914-8062-75751f982a64@quicinc.com>
Date: Tue, 1 Apr 2025 09:59:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix memory leak due to multiple
 rx_stats allocation
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sidhanta Sahu
	<sidhanta.sahu@oss.qualcomm.com>
References: <20250326213538.2214194-1-muna.sinada@oss.qualcomm.com>
From: Mahendran P <quic_mahep@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250326213538.2214194-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=fMI53Yae c=1 sm=1 tr=0 ts=67eb6bb3 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=Ejmhv89HWJ9YnE1SCj4A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wv1Uiq1zDPIJOpwFm5O_b9eQ_WHCrcEl
X-Proofpoint-GUID: wv1Uiq1zDPIJOpwFm5O_b9eQ_WHCrcEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010028

On 3/27/2025 3:05 AM, Muna Sinada wrote:
> From: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
> 
> rx_stats for each arsta is allocated when adding a station.
> arsta->rx_stats will be freed when a station is removed.
> 
> Redundant allocations are occurring when the same station is added
> multiple times. This causes ath12k_mac_station_add() to be called
> multiple times, and rx_stats is allocated each time. As a result there
> is memory leaks.
> 
> Prevent multiple allocations of rx_stats when ath12k_mac_station_add()
> is called repeatedly by checking if rx_stats is already allocated
> before allocating again. Allocate arsta->rx_stats if arsta->rx_stats
> is NULL respectively.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 842eda56c8b1..f157a85111d9 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5663,10 +5663,13 @@ static int ath12k_mac_station_add(struct ath12k *ar,
>  			    ar->max_num_stations);
>  		goto exit;
>  	}
> -	arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
> +
>  	if (!arsta->rx_stats) {
> -		ret = -ENOMEM;
> -		goto dec_num_station;
> +		arsta->rx_stats = kzalloc(sizeof(*arsta->rx_stats), GFP_KERNEL);
> +		if (!arsta->rx_stats) {
> +			ret = -ENOMEM;
> +			goto dec_num_station;
> +		}
>  	}
>  
>  	peer_param.vdev_id = arvif->vdev_id;
> 
> base-commit: c0dd3f4f70918cbcdd8da611811036a91b7dce33

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>

