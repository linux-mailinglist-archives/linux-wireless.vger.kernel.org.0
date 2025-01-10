Return-Path: <linux-wireless+bounces-17285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA12A08715
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 06:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1257216884C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 05:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C03D1C5F2E;
	Fri, 10 Jan 2025 05:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WKOmNy3O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5435C746E
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736488720; cv=none; b=fuwRKAgXWsxBBE1/jA9qcH+2JuriGd4tvjIlSkQ2mBOyDmqZRxyepjRPIrjdOebIMfiimQ225F0mrNVqmefrmSFWCJDi4mC1+nIJo6A4cMC5XJT91So+t8H0n0ImgULJNkCWwbpffTXKIVbuSYyHvu71q50AawdhI3u5t4tTYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736488720; c=relaxed/simple;
	bh=JLIvhK8LmJ4rF99p492e5WaHGusERTScZGa1ayKaBJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VLS/IYB9xxvmM9B6Heu2rLMGBwCpvhb9NfD693IlSo7VFdpzcbn1kJtZFp0Ic8uinT7I9Wq8pA2+Hhm4r2nS2p2ojPy2Oex7dTasFiHXDzl9USM5iq94fgrFFGEVhJLhHLVDlRiwDBEkFYcKJc/0vZWixk1ZZm+6kHLvnGUSzko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WKOmNy3O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A0qwYS004132;
	Fri, 10 Jan 2025 05:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+FohUmCBokbEDlnJcY4WnBpdH9kOFvCR+lNyHv7qoNY=; b=WKOmNy3OjAXQkEP2
	WXzROVFqGYQ1iUN9bz7kVptUd4MEQFKrnmWPClBlOsgXCbvGbmUmoqF9bjK7HBnl
	BZV8MKLbYHRdK3mRjUVpQn34yA90cZvH++3mGto+RM3p1SvZ4OWvViZOeersMrlL
	LZ/2pdddAaROKw3IWHY/JkKd+6ciPCpk2TZWtiqnpuJVzThhZ23p1u19zUq6lKK0
	JqGPrxzWzrejM5OnFk7Lf+a6SINMxAB/Io1bJYW9RU0aMF00hpCRbbONUObjSJOP
	U/c84Nzrx1nNvzu0PAqWePGly2+c/YBA0Zr41NXPVfAg+WQZFXToyWHFs1G38AW3
	3bzfrQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442sd90jfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:58:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A5wWjD018175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 05:58:32 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 Jan 2025
 21:58:30 -0800
Message-ID: <3fcec012-49cc-4408-9f9b-a4eadd253c8d@quicinc.com>
Date: Fri, 10 Jan 2025 11:28:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] wifi: ath: create common testmode_i.h file for ath
 drivers
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250109183551.1028791-1-quic_aarasahu@quicinc.com>
 <20250109183551.1028791-2-quic_aarasahu@quicinc.com>
 <70242ecc-c353-4973-bc04-e85b89a1aabb@oss.qualcomm.com>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <70242ecc-c353-4973-bc04-e85b89a1aabb@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OiPapjZWg2NYNPHH5VXXpLKPywB949FR
X-Proofpoint-ORIG-GUID: OiPapjZWg2NYNPHH5VXXpLKPywB949FR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=700 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100047



On 1/10/2025 2:23 AM, Jeff Johnson wrote:
> On 1/9/2025 10:35 AM, Aaradhana Sahu wrote:
>> User space application requires that the testmode interface
>> is exactly same between ath drivers. Move testmode_i.h file
>> in ath directory to ensure that all ath driver uses same testmode
>> interface instead of duplicating testmode_i.h for each ath drivers.
>>
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/testmode.c    | 80 +++++++++----------
>>  .../wireless/ath/{ath11k => }/testmode_i.h    | 54 ++++++-------
>>  2 files changed, 67 insertions(+), 67 deletions(-)
>>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
>> index 302d66092b97..9d1613723601 100644
>> --- a/drivers/net/wireless/ath/ath11k/testmode.c
>> +++ b/drivers/net/wireless/ath/ath11k/testmode.c
>> @@ -1,7 +1,7 @@
>>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>>  /*
>>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2023, 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> 
> should be 2023-2025 to account for the patches posted but not merged in 2024
> 
Sure, will address in the next version.

>> diff --git a/drivers/net/wireless/ath/ath11k/testmode_i.h b/drivers/net/wireless/ath/testmode_i.h
>> similarity index 50%
>> rename from drivers/net/wireless/ath/ath11k/testmode_i.h
>> rename to drivers/net/wireless/ath/testmode_i.h
>> index 91b83873d660..b8fa5092e6ca 100644
>> --- a/drivers/net/wireless/ath/ath11k/testmode_i.h
>> +++ b/drivers/net/wireless/ath/testmode_i.h
>> @@ -1,59 +1,59 @@
>>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>>  /*
>>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> 
> should be 2023-2025 for the same reason
> 
Sure, will address in the next version.

> 


