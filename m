Return-Path: <linux-wireless+bounces-3871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDAC85E44A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 18:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF74C1F234C5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A483CA5;
	Wed, 21 Feb 2024 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gpyKoVep"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFC81737
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535748; cv=none; b=tgRtovhp/9fykP9UYPMskttiEDxy/iXi9pUNxVCrwTVYSrXk7Ky6o3201ttDUAwMpAV2wU0/A4pVdp4LeZTZXE/RK0zNvJM5Qn8DPbByXiNzOK/cHgpbB9jWtIlbahbkq/+upJedtqQV44t+ocINkhdfbAajPldTawb+niQAHzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535748; c=relaxed/simple;
	bh=cGWK8PhlL5QHrqLls+AqISkWrpennN2EucBv7npLBFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mkD2kfeYsxL8z2ZRqR6oKUAJe6wdhGBT572qDlkxnwo4tKbFiY8w5kK01S9OgKNy2JUh1iZE+pL6IOAHsaYKX4POkoaa+NqPWBE7ITnzI+Bx2LL1/4T9w4KFuUwPZsH7BhqpYGutzYXsTHTU5jnIdnVAcIT/jairvfHBGPy/RlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gpyKoVep; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LAkMgA012320;
	Wed, 21 Feb 2024 17:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tsOvlPAUo0XfljCTLtSz5JL0bPSChABZUyJuSiEqFqA=; b=gp
	yKoVep/nva/6IrGn7d73DMZHTkFv8QGW0MNKvGhdZL835f3WBZ9GZf3EKgJ/khNi
	FLiHnBYNUlpv1w/dvdvWELJ8KyHJpP7qtf0313rw90bo7DIx75cO28fmHrlIET08
	xtFnlZ74P57QMIpD22bw2kT8FHluFOHu/duSE4IKtsVTd+XsVO3UKENiFUUkglgH
	uipTtlfdZ8dED17x5s+A3CTrSvlVKMDx+YHMB12p5wrL//i47bJdplwDQHTqkYyA
	HzUM4/mft/aGes9vHpSh3YcYKHPz3+oWkUtYb08+RzRbbMzKsdVdpnWP+r2KYo2m
	5fHAoU18J1Ar/YbwL4Gw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfqa0x4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:15:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LHFX37008439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 17:15:33 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 09:15:32 -0800
Message-ID: <df08dfd4-189c-407b-8a2e-6fd2bbf3b22f@quicinc.com>
Date: Wed, 21 Feb 2024 09:15:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] wifi: ath11k: thermal: don't try to register multiple
 times
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
 <20240221024725.10057-6-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240221024725.10057-6-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1M2zobVpWLyD4TQsriClUV6y8j8luoqX
X-Proofpoint-ORIG-GUID: 1M2zobVpWLyD4TQsriClUV6y8j8luoqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_04,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=930
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210133

On 2/20/2024 6:47 PM, Baochen Qiang wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Every time the firmware boots we call ath11k_core_qmi_firmware_ready() which
> ends up calling ath11k_thermal_register(). So we try to register thermal
> devices multiple times. And when we power off the firmware during
> suspend/hibernation (implemented in the next patch) we get a warning in resume:
> 
> hwmon hwmon4: PM: parent phy0 should not be sleeping
> 
> Workaround this similarly like ath11k_mac_register() does by testing
> ATH11K_FLAG_REGISTERED.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

you need to add your own S-O-B

> ---
>  drivers/net/wireless/ath/ath11k/thermal.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
> index c29b11ab5bfa..41e7499f075f 100644
> --- a/drivers/net/wireless/ath/ath11k/thermal.c
> +++ b/drivers/net/wireless/ath/ath11k/thermal.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2020 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/device.h>
> @@ -163,6 +163,9 @@ int ath11k_thermal_register(struct ath11k_base *ab)
>  	struct ath11k_pdev *pdev;
>  	int i, ret;
>  
> +	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
> +		return 0;
> +
>  	for (i = 0; i < ab->num_radios; i++) {
>  		pdev = &ab->pdevs[i];
>  		ar = pdev->ar;


