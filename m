Return-Path: <linux-wireless+bounces-3892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11AA85EF27
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 03:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CEB1C21BDE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 02:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384958F77;
	Thu, 22 Feb 2024 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FgyQFe6W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6DC10A05
	for <linux-wireless@vger.kernel.org>; Thu, 22 Feb 2024 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708569266; cv=none; b=gv6Q4BbdM2xwXQidyOKX7XyouSIyMHpcGF1J79T2NHpYunzxBj/yhb+iYCkM8V2dR2QIZBuhBWxyU2f+FyyFZzReoUioJWqJMIV1/j5q/pRUPmqTbGShmCGPs3wvsNkj21EcimE5NGoNKPPRFaOY/o56mvnH6pY9m2QuEMwtM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708569266; c=relaxed/simple;
	bh=LOG8a9b4RTdKh25JGUxjoxnHfqLazFLczG42mm5pCpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l+okCclTb5NhuRQjLFJIZ5yFpGTaGBSCimMhVmQ27b/gg+HU+p+XiGoul7T9mqwNyGcwL4uX9MGNJkcsFgeAviFy5xz1Yu4gOkGFCSoALQOEBvAThYzvxP/a9etbmE+YzgI/md6cVfyq1YapYVhtj6TGSm6UtANP4kRUHFo9uuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FgyQFe6W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LNoOqp020539;
	Thu, 22 Feb 2024 02:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Pfot7sAKRzjoMPJH/FBh9iX8mxb5jR44xgnyvxe9w3A=; b=Fg
	yQFe6W6y9waBMoTqk66EaY+ha0J9286yY7SL99sBp28YKTsbyiMHRoxxVUvqClcr
	2oZ5uYug19eHIxhVGH7sn5RBs0qonxzkqPhyz6bCd0RuXyUouC0ZjQd6IVjSQAqE
	y77Bf+U1GtJcB2rXCXk/+iI8lOiWus8PCa4piRReTJyaTSTu0vUhuqpm70O2euIP
	l+LkQYygJmAg9alUppQdVlnC019x3P7/OWv4PupnI03qUyq8Gaa4RCzN+16MpuVT
	epvT5nETRKgCotsoHIqvOMXrAg4NTNP041cQbcHL6zgi1dibWWMLtQ9uDfvZUbbC
	W8Yfv0FY0ujQBRTdIllg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdpjn8uhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:34:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M2YLVw030842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 02:34:21 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 18:34:19 -0800
Message-ID: <5828b835-6b4d-4245-991a-7f6b54ee8b51@quicinc.com>
Date: Thu, 22 Feb 2024 10:34:16 +0800
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
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        "Kalle Valo (QUIC)" <quic_kvalo@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20240221024725.10057-1-quic_bqiang@quicinc.com>
 <20240221024725.10057-6-quic_bqiang@quicinc.com>
 <df08dfd4-189c-407b-8a2e-6fd2bbf3b22f@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <df08dfd4-189c-407b-8a2e-6fd2bbf3b22f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uV9foEl_WsDLbFi93Q31RYrhryUItgOF
X-Proofpoint-GUID: uV9foEl_WsDLbFi93Q31RYrhryUItgOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_01,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=984 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220018



On 2/22/2024 1:15 AM, Jeff Johnson wrote:
> On 2/20/2024 6:47 PM, Baochen Qiang wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> Every time the firmware boots we call ath11k_core_qmi_firmware_ready() which
>> ends up calling ath11k_thermal_register(). So we try to register thermal
>> devices multiple times. And when we power off the firmware during
>> suspend/hibernation (implemented in the next patch) we get a warning in resume:
>>
>> hwmon hwmon4: PM: parent phy0 should not be sleeping
>>
>> Workaround this similarly like ath11k_mac_register() does by testing
>> ATH11K_FLAG_REGISTERED.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> you need to add your own S-O-B
Oh, sorry for missing that.

Hi Kalle, I see you have put this series in pending branch. I am 
wondering if I need to send a v2 to add my S-O-B tag, or you have any 
other plan?

> 
>> ---
>>   drivers/net/wireless/ath/ath11k/thermal.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/thermal.c b/drivers/net/wireless/ath/ath11k/thermal.c
>> index c29b11ab5bfa..41e7499f075f 100644
>> --- a/drivers/net/wireless/ath/ath11k/thermal.c
>> +++ b/drivers/net/wireless/ath/ath11k/thermal.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>>   /*
>>    * Copyright (c) 2020 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   
>>   #include <linux/device.h>
>> @@ -163,6 +163,9 @@ int ath11k_thermal_register(struct ath11k_base *ab)
>>   	struct ath11k_pdev *pdev;
>>   	int i, ret;
>>   
>> +	if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags))
>> +		return 0;
>> +
>>   	for (i = 0; i < ab->num_radios; i++) {
>>   		pdev = &ab->pdevs[i];
>>   		ar = pdev->ar;
> 

