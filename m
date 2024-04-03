Return-Path: <linux-wireless+bounces-5851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B60897933
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C472D1F244ED
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 19:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72439155310;
	Wed,  3 Apr 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bZ6BTSBk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D56154BE8
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712173884; cv=none; b=NqcxxGRPdgBx/8E6kHpe7AEtx0Et1PyoPkbFKftMUhW3mEM4+QDcuxkcvFE1g3cTcN84sLK8eGGrLAfG0UcEXJwBAUxGXO5CHa7l18KeByn+IADekgw5BYLDNBirNbO4pzW11raFhqWqV1vqysJyM+q9zsJlhciL9xcKLx8zc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712173884; c=relaxed/simple;
	bh=RrFf8tgMvkUuSER+/9/+RNfKhDPNUFoP352FLbE8Eps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lvx0alpHX4KVNlYIsA6GRg8UWlnD4UpuDDWYhTSqmxs1sHQo/s0w3/7tg9053ka0jsEWn6DM/rz8IC1+43QXgZ1xceyRF11cIM7WEWzHDykTpncVpI3s4UwCuGCd9BI5MkMRr88F+hfzUo8n90KoPw/YZmEqtHxMq1Pinc6EuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bZ6BTSBk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433JKxmv027920;
	Wed, 3 Apr 2024 19:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1phUTDbfylHa3sQ5MHcHfed+HSDjIxNRONsghxGdFbM=; b=bZ
	6BTSBk89i86ekec8U7ZPtut8rJsxxDp1OSdHQivtiy4y4d7TI5TyTCCf9ikzFh2O
	3tSSAVbqeQn0sm5LCYpHB87n2vaDh+rGkQ2z5wGaO49d/e5hGOEbnna/hKBe2UHN
	lbvqHy1NGccb/KM+d1HeENgD6UH4meSz/vfWukk/yBdD3dnlmTKBLA6HzV4dCuqy
	ddEDD71mxn3S3vOOCC7hbJJpm7r9XyBVTyD8t3XdOOfAh/0mAlSLdoC4tAXQGXrS
	uw/2rJWXmLp7BZWUpdwUIhFgptjobv5TIx/Sj7M1OH2GeQupH8+kBUDo6dW0eNEc
	XwkUQyVY6vgRPlSMPVPA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x993u0q8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 19:51:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433JpI2w004799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 19:51:18 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 12:51:17 -0700
Message-ID: <335bba80-addd-4443-b67e-d3de114b91ba@quicinc.com>
Date: Wed, 3 Apr 2024 12:51:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] wifi: mt76: mt7915: add fallback in case of missing
 precal data
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
References: <20240403103032.54823-1-nbd@nbd.name>
 <20240403103032.54823-11-nbd@nbd.name>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240403103032.54823-11-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wx5Ptr_US_K-9Zb4ed3fpljSmz65W4Cx
X-Proofpoint-ORIG-GUID: wx5Ptr_US_K-9Zb4ed3fpljSmz65W4Cx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_21,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030134

On 4/3/2024 3:30 AM, Felix Fietkau wrote:
> When pre-calibration data is missing, do not fail the driver probe.
> Instead, just print a warning and fall back to regular calibration.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/eeprom.c    | 15 ++++++++++-----
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c  |  2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c  |  2 +-
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> index 5fdcbb521ff7..bfdbc15abaa9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> @@ -28,7 +28,15 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
>  	if (!ret)
>  		return ret;
>  
> -	return mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", size);
> +	ret = mt76_get_of_data_from_nvmem(mdev, dev->cal, "precal", size);
> +	if (!ret)
> +		return ret;
> +
> +	dev_warn(mdev->dev, "missing precal data, size=%d\n", size);
> +	devm_kfree(mdev->dev, dev->cal);

if you are going to devm_kfree the memory for this case, why not also for the
mt76_get_of_data_from_mtd() failure case?

> +	dev->cal = NULL;
> +
> +	return ret;
>  }
>  
>  static int mt7915_check_eeprom(struct mt7915_dev *dev)
> @@ -254,10 +262,7 @@ int mt7915_eeprom_init(struct mt7915_dev *dev)
>  			return ret;
>  	}
>  
> -	ret = mt7915_eeprom_load_precal(dev);
> -	if (ret)
> -		return ret;
> -
> +	mt7915_eeprom_load_precal(dev);

if you're not going to check the status, why not make it a void function?


