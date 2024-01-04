Return-Path: <linux-wireless+bounces-1466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D8823AF7
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 04:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8AD1F230CC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 03:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7511190;
	Thu,  4 Jan 2024 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aovqY7Ev"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C25611192
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4041nfTI003528;
	Thu, 4 Jan 2024 03:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GO1gd7Yuo8ZHteydzdNhiAeb9+APPsknpyteqWmjRXc=; b=ao
	vqY7Ev8VjGcts4VQw7IPOgRp2votAPT7Y4GIAZwmyJZfCfnLlkCVmbHCp7AQPnyj
	2KAkC6LnF8XQOPYKxU6PacdN2byy49LvKP77C0QY9cjMQvBxeq8/DihcVbq6p/7v
	5GMCV60bjbHS5is375Rv3hYxmH86n4IAeaAIIS8UL7uRvjO3IHdXr9mgXvZd2WZB
	xe30DwzRr2GvTyD2y8aMK31uPXbHqumvqPdb4Lr1zeJ4qi76PJTWsUctuIkOSguR
	k6pxRwSpFZDjZTGAN6ClJFil6EkoSolyEemOffjAiw6VPQhmUr13NsaZhxcUIGuE
	4UfjIVb4qXW2xlFsBatQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vd2tmag2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 03:03:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40433wV1030917
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 03:03:58 GMT
Received: from [10.201.208.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 3 Jan
 2024 19:03:56 -0800
Message-ID: <9636aec8-8fa3-6129-294a-69dec53276fa@quicinc.com>
Date: Thu, 4 Jan 2024 08:33:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
        <ath11k@lists.infradead.org>, <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240103041220.3082014-1-quic_periyasa@quicinc.com>
 <20240103041220.3082014-4-quic_periyasa@quicinc.com>
 <2269025d-d1ef-4940-a438-c67d3d94baf9@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <2269025d-d1ef-4940-a438-c67d3d94baf9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MsvdMyNwrjESe4sH4UaNniDN3aKC4ndV
X-Proofpoint-ORIG-GUID: MsvdMyNwrjESe4sH4UaNniDN3aKC4ndV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=527 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401040019


On 1/3/2024 10:06 PM, Jeff Johnson wrote:
> On 1/2/2024 8:12 PM, Karthikeyan Periyasamy wrote:
>> ENOTSUPP is not a standard error code, don't use it. Replace with
>> EOPNOTSUPP instead.
>>
>> No functional changes, compile tested only.
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>> diff --git a/drivers/net/wireless/ath/ath10k/htt.c b/drivers/net/wireless/ath/ath10k/htt.c
>> index 907e1e13871a..3835c5cc07f9 100644
>> --- a/drivers/net/wireless/ath/ath10k/htt.c
>> +++ b/drivers/net/wireless/ath/ath10k/htt.c
>> @@ -2,6 +2,8 @@
>>   /*
>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>> + * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
> You are not working on behalf of The Linux Foundation so you should not
> be adding or modifying Linux Foundation copyrights

Sure


>> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> And this should only have 2024 since there were not any Qualcomm changes
> in 2021-2023

Sure


>> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> index 0ce08e9a0a3d..9a1889599729 100644
>> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>> @@ -3,6 +3,7 @@
>>    * Copyright (c) 2005-2011 Atheros Communications Inc.
>>    * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>    * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> Again this should only have 2024


Will address in the next version of the patch


Thanks,

Karthikeyan


