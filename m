Return-Path: <linux-wireless+bounces-12588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE396EBC5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E88B20C82
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 07:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553C17C9B;
	Fri,  6 Sep 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D3vI11jn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6F40879;
	Fri,  6 Sep 2024 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607065; cv=none; b=VJCUcKzL3yjn7SzhGoAo0U0sB89YIEL4TgHAjFcRKw3M0ktGJUvUmB6l7aMdZP8gdDSNZ48lVELPFh/Df8oUYHEe5PeR/Kl+SZq5zre2nSiwlxLapmFq2+HgQworY/9VgQolJLpqebMxJQofRvngzDmwBojK06n+uCgXC2H/rt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607065; c=relaxed/simple;
	bh=WgZ7zR8zKn5zumPzuMyTEMOyPSBrys9J6Q+8kLgo2xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=koyrTaNHfGofs2yohcGiEMqiACXQGv2S6uVtlvyQmqJwYeM6hlc43My9xfbm1rtwbVkoYAfc9k2OmSOenn/JKHLqj1dURvsJ4qOgPXVx9K30s+D6TiM3vUoy65QV85kOefsGanJdOFWVArk1vwGjZkY9tm2i6vNqw7nhjoVOCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D3vI11jn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IPpnH019562;
	Fri, 6 Sep 2024 07:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xjBkVuHx5tmNXoe8jTAz2MZ+SIuGr4IBJ4WvYnMmroQ=; b=D3vI11jn+ZiefM4m
	ZvYVo+CRCSF7vmeHAgJDeqrpPuSeDGR2DuwBIzT3jyb64d6Ji8G4zT3mlMUGf9XB
	vVn3Cr1NMb/PJ+omuN7h06EUBqaAeEl5UrhEC6q6jbsOUVpAUxXwZvs19rwi1yeJ
	1sox9fO5AReUyAfAxiiVaUZAOQgz062I+lfQFRyTtpL635uIHJ3yCkLMehtMkfhr
	sjL9rkHBJ0MixNODwDGonUyLFHgx1HtRPeQtbihGf2S9L4PB0325vHk4XhNNve2i
	R8G5Otb2EoAzhn6Kh1pckzrK4Rhi0nhkRRWxbmra5nnyvMyGX3jt0B3848P5q5LQ
	A7JZtA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwu1dek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 07:17:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4867HbVq026270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 07:17:37 GMT
Received: from [10.151.41.25] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Sep 2024
 00:17:34 -0700
Message-ID: <8f64a4ab-abf5-4afe-bc4f-725fc89d27ec@quicinc.com>
Date: Fri, 6 Sep 2024 12:47:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: allow missing memory-regions
To: Caleb Connolly <caleb.connolly@linaro.org>,
        Jeff Johnson
	<jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <20240904095815.1572186-2-caleb.connolly@linaro.org>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20240904095815.1572186-2-caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fkny-sO44lEgSpwv8d--Zod8DZd72V0k
X-Proofpoint-GUID: Fkny-sO44lEgSpwv8d--Zod8DZd72V0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 mlxlogscore=898 phishscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060051

On 9/4/2024 3:27 PM, Caleb Connolly wrote:
> On SC7280 platforms which are running with TrustZone, it is not
> necessary to manually map the memory regions used by the wifi hardware.
> However, ath11k will currently fail to load unless both memory regions
> are specified.
> 
> This breaks wifi on the rb3gen2 which only specifies the firmware memory
> region and does not use the CE region.
> 
> Adjust the order of operations in ath11k_ahb_fw_resources_init() to
> check for the wifi-firmware subnode before attempting to parse the
> memory regions.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Cc: linux-arm-msm@vger.kernel.org
> ---
>  drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 634d385fd9ad..e24f8da565db 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -999,20 +999,20 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
>  	 */
>  	if (!ab->hw_params.fixed_fw_mem)
>  		return 0;
>  
> -	ret = ath11k_ahb_setup_msa_resources(ab);
> -	if (ret) {
> -		ath11k_err(ab, "failed to setup msa resources\n");
> -		return ret;
> -	}
> -
>  	node = of_get_child_by_name(host_dev->of_node, "wifi-firmware");
>  	if (!node) {
>  		ab_ahb->fw.use_tz = true;
>  		return 0;
>  	}
>  
> +	ret = ath11k_ahb_setup_msa_resources(ab);
> +	if (ret) {
> +		ath11k_err(ab, "failed to setup msa resources\n");
> +		return ret;
> +	}
> +
>  	info.fwnode = &node->fwnode;
>  	info.parent = host_dev;
>  	info.name = node->name;
>  	info.dma_mask = DMA_BIT_MASK(32);


ath11k_ahb_setup_msa_resources(ab), will only read the device-tree and
save the memory addresses/size form device-tree to ab_ahb->fw.
These saved address, only used if "wifi-firmware" node is defined.
This the node "wifi-firmware" is not defined it is considered to be
running with TrustZone, and saved addresses are not of use.

This changes looks fine.

