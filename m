Return-Path: <linux-wireless+bounces-17735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63688A1684A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D1161DA8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B7192B71;
	Mon, 20 Jan 2025 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nB20fUGf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C9F149DF0;
	Mon, 20 Jan 2025 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737362325; cv=none; b=fI4OLLDQuuOtzeLtGaMJtREHHXnPrDqD9Egc9ppylR80iCBZOhN+6T8Mo+AMCftWMAlxGPHQGnMGV1heBjS3cWdJ7McHMjmlzg20yr46pYvrNtXqBSIMUaRS4ZBZN3ShVvvL3XqpbT5FUCSb5nHZcnjrybIQE0254zrS8RxBCTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737362325; c=relaxed/simple;
	bh=vh9UVxnG62gNCNBdsJiS0g9hnVXJyVBS8JBFlh0mzhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qG+bG3C64HOXoWTQ+lB2wh6YKd7tJ+89NqEbjn1LWB/IUUMKt2fMO0HQDI1uu1ueNaVfN04f2GlW4pwS02Naz9QNY+8HI2Stym11TEBtWaa/ZmTW0yhyGJVgEIs0xMfoaRvX64kmC59BCyVDZCD00umSb5YDuWKXyJjKlCXSTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nB20fUGf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K4sqqd007382;
	Mon, 20 Jan 2025 08:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ey6PskYUd2im3bJ0UAn9xxNTl6O6OydZp86J8GorTpM=; b=nB20fUGfijkBHuOS
	UMve+pq3KSdL3jomGVgStZFieT2mbn5CL8hEVL4ZHBvsvF4G9ZMstdSXXBNNG2d6
	QNmjRVerj035KCSDb5DOVdNzxGbRWQxY2p39bsSMTqDZdgbkTxltWRnaxKnLOPB6
	UJBmgweXn6y1mK/mzUgUx+9L5ikVUquyy+wbr39RFtqecMuIjz68btF2L5nURfbu
	LN5tYxlFqvrFytC4Adqx2DZJkczhwD4dI7vGPxWS/KT/hQz9lBt6CfzjyaJFTbch
	Kjs2Ui+3so8PR9Q2VjknxyElEY3f8shK0traNorzc25VSi1fDtRdNRhwa9a3SGaR
	6i8Kzg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449fvj0ja3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 08:38:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K8ccbt017017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 08:38:38 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 20 Jan
 2025 00:38:35 -0800
Message-ID: <086df6fc-c601-4e06-8433-f87e2bd01ec5@quicinc.com>
Date: Mon, 20 Jan 2025 14:08:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] wifi: ath12k: fix SLUB BUG - Object already free in
 ath12k_reg_free()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        "Karthikeyan
 Periyasamy" <quic_periyasa@quicinc.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>
CC: Kalle Valo <quic_kvalo@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-5-fb39ec03451e@quicinc.com>
 <22fdc80a-7ad9-4305-8435-0422d201b1ce@oss.qualcomm.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <22fdc80a-7ad9-4305-8435-0422d201b1ce@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bMtLEp0tqgMdjyMmg47Asdki387G_m9H
X-Proofpoint-GUID: bMtLEp0tqgMdjyMmg47Asdki387G_m9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=873 suspectscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200071

On 1/14/25 00:51, Jeff Johnson wrote:
>> diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
>> index 439d61f284d89222e79c05d6cff8e85d0d315aad..b4d7fa1a04ca0e72728e8989c29b82d089171fc2 100644
>> --- a/drivers/net/wireless/ath/ath12k/reg.c
>> +++ b/drivers/net/wireless/ath/ath12k/reg.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>>   /*
>>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>>    */
>>   #include <linux/rtnetlink.h>
>>   #include "core.h"
>> @@ -777,8 +777,14 @@ void ath12k_reg_free(struct ath12k_base *ab)
>>   {
>>   	int i;
>>   
>> +	if (ab->regd_freed)
>> +		return;
>> +
>>   	for (i = 0; i < ab->hw_params->max_radios; i++) {
>>   		kfree(ab->default_regd[i]);
>>   		kfree(ab->new_regd[i]);
>> +		ab->default_regd[i] = NULL;
>> +		ab->new_regd[i] = NULL;
>> +		ab->regd_freed = true;
> since it is loop invariant, should this last assignment be outside the loop,
> either before or after the loop?
> 
> but then again, why is a flag needed since setting the pointers to NULL should
> already show they are freed, and any race conditions with those pointers would
> also exist with the new flag (which you have addressed with the locking change).

Well, looks like, this flag is not needed. I will remove this in next 
version. Thanks for pointing it out!

-- 
Aditya

