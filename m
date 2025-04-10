Return-Path: <linux-wireless+bounces-21400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9918DA84AA9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 19:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A16707B38C8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 17:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5198C1EE7B7;
	Thu, 10 Apr 2025 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UGSnJkR5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B121E832A;
	Thu, 10 Apr 2025 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304800; cv=none; b=WHneoeoLBmEqDj0AwC206KevGtyoGJeWoLBmWwFaLe4FqvOE+C9f5QEfQ1kL7CIvH2hDVsGz9ag6/+HSu9NvMmXcXf9T3lv0nbCSBpcrNmS5KkPA1HBohkAiO/S6bcvpvbmbGtA9iALrJq7cPSMX12jaO6OBTNDWxvpzoK1xSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304800; c=relaxed/simple;
	bh=k4uvIuqJbG7f/BU7bv+4g8ZNeOlmaR1Btja9MgUIDXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aHF6VTlNE3Sc15IT2qj5/tVPpIFDsCSQnMe6qx0lZLbarU88ET2SycCZqpBwEZgwS5nImTMI+JeYUS5Rh17FFur42UkNYKI/e7fPoOqxtrubN25w3tUE2m22lVfkRVzF8D/yoRb8bZHuvFRnWv6LQJX/uo+zFYd7aN2BtvLcrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UGSnJkR5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AD2sVk007171;
	Thu, 10 Apr 2025 17:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BF21VqHILgXSKki3imET/CfbbOUSYsGO44rNBA7fR5A=; b=UGSnJkR5G2/UerdF
	k5ImmnQ009nbU9PufAdxB9FemHaf8cpJlBkveFqDVO+lpGte93GgXNCOqvbST9yQ
	C+O8EVgbRh3N11h1TREcfoZayg3iXtSTrFEkBPTlGNl26Pd5MeS3QQGtnV3tmitk
	UpGLH4rycWm60N8GD1YEQjTwIbSyQ7lJXmQMy0yQBiOfvUZzujdwGAV06Ex2x+GY
	n0lwpsoBX36QIs990RiOKe8rZPRP59HOHLhw0OETv3E1Dbdseoy3JGWpZ6u/VT+i
	+Ry+2m/HKOkXV1+A/zSk3fFgC4qq8YbsifnRYJhUqzc2+1aV2Dvm863IBIDGY2NJ
	0P8QLw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45xeh3gqac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:06:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53AH6TBX017695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 17:06:29 GMT
Received: from [10.216.57.178] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Apr
 2025 10:06:25 -0700
Message-ID: <88ee501b-7c1b-c8d1-9c7d-ad11c87e7530@quicinc.com>
Date: Thu, 10 Apr 2025 22:36:21 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH next] wifi: ath12k: Fix a couple NULL vs IS_ERR() bugs
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
CC: Jeff Johnson <jjohnson@kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>,
        Vasanthakumar Thiagarajan
	<vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Balamurugan S
	<quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <937abc74-9648-4c05-a2c3-8db408b3ed9e@stanley.mountain>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <937abc74-9648-4c05-a2c3-8db408b3ed9e@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=VbH3PEp9 c=1 sm=1 tr=0 ts=67f7fa97 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EnhqhbNNt_GmlLj2XIYA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: yaCjOL8_YHmEsaFV3MxYYQFSOZDw7Db3
X-Proofpoint-ORIG-GUID: yaCjOL8_YHmEsaFV3MxYYQFSOZDw7Db3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100123



On 4/10/2025 9:56 PM, Dan Carpenter wrote:
> The devm_memremap() function returns error pointers on error and the
> ioremap() function returns NULL on error.  The error checking here got
> those flipped around.
> 
> Fixes: c01d5cc9b9fe ("wifi: ath12k: Power up userPD")
> Fixes: 6cee30f0da75 ("wifi: ath12k: add AHB driver support for IPQ5332")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/net/wireless/ath/ath12k/ahb.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ahb.c b/drivers/net/wireless/ath/ath12k/ahb.c
> index a9d9943a73f4..636dfe237a79 100644
> --- a/drivers/net/wireless/ath/ath12k/ahb.c
> +++ b/drivers/net/wireless/ath/ath12k/ahb.c
> @@ -360,10 +360,10 @@ static int ath12k_ahb_power_up(struct ath12k_base *ab)
>   	mem_phys = rmem->base;
>   	mem_size = rmem->size;
>   	mem_region = devm_memremap(dev, mem_phys, mem_size, MEMREMAP_WC);
> -	if (!mem_region) {
> +	if (IS_ERR(mem_region)) {
>   		ath12k_err(ab, "unable to map memory region: %pa+%pa\n",
>   			   &rmem->base, &rmem->size);
> -		return -ENOMEM;
> +		return PTR_ERR(mem_region);
>   	}
>   
>   	snprintf(fw_name, sizeof(fw_name), "%s/%s/%s%d%s", ATH12K_FW_DIR,
> @@ -929,7 +929,7 @@ static int ath12k_ahb_resource_init(struct ath12k_base *ab)
>   		 * for accessing them.
>   		 */
>   		ab->mem_ce = ioremap(ce_remap->base, ce_remap->size);
> -		if (IS_ERR(ab->mem_ce)) {
> +		if (!ab->mem_ce) {
>   			dev_err(&pdev->dev, "ce ioremap error\n");
>   			ret = -ENOMEM;
>   			goto err_mem_unmap;

Thanks for fixing it.

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

