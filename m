Return-Path: <linux-wireless+bounces-22937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F5AB6A7D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 13:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911147A0740
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 11:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3525D8F0;
	Wed, 14 May 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pvHvIXbE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2420C492
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223353; cv=none; b=CzxnHh/aXpfI8F26VNuJoax8d78gkQbsgB2qcDDKCLJ3S+lbRAz5n+stWE3id6DidT2+9yCVkWB20KzWsK63JOjjV0cCvLcNDx5KyB7p8aayLU/N2n3+mETFW3Zor4GvBPvNap2En/97YlecTIHAlLZ1moYkfWg+U/e4d/AwfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223353; c=relaxed/simple;
	bh=kLn8xXCjx4+1HcJj9JCJEJlXv+RhEmA7VGpWe/PXCWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZXectFluAH1VTxG3lyuvWuygmQ6rw7eK/gjMzlOcVEYgzlqZtgTcNF0X6e32JIsZ1KDcC8QRbfwr6uuiKCldVSSob2r5hLDKN5SRi+vpWTb8VVZvgSJumWLiLM5jTP65DdQC5fW1yne53RA4pzdt8hSZtrEE2YSlcE3XYWwymz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pvHvIXbE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EAufsa002700;
	Wed, 14 May 2025 11:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C9zuyVqgxas5hl4Hfepg/Hqvqwq4B7ZPZK8zXWI9ziQ=; b=pvHvIXbERLT8kDch
	BByYtNSoU5WgsPLTtSgF2GYFbL7FH+LYJjpQM/b1YBzRI8GQ3496aKWTsIqnaIC1
	TuffyUH/kbP3ELwD+x5Cze9a4kY7JO5B5cdQLQgahNUhDHW8cMTmjEt6G3LSYXTW
	/FDjl1S9bZ4DYT4u0CZlzJHlsi434xBgF9gWccepXHyAXsarFJCNiFYUFE+ZIPnQ
	c10+Eziv9IT0DW5txXUz3ZUd5GRtFmalRmg2x4kNO7NPAs8IWwn9hK0KaRhqinaK
	7sQ/DQ3RWqG90Yjo1D28gqKA/qUGDPcyd7Klm0gfqFj8m8XYFe1qUyv4k1I18hgG
	Q5rJug==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcpah8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:49:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54EBn8Ne024855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 11:49:08 GMT
Received: from [10.216.10.156] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 May
 2025 04:49:06 -0700
Message-ID: <f0c8009a-829a-43f3-be03-c6b2a0b67883@quicinc.com>
Date: Wed, 14 May 2025 17:18:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix scan initiation failure
 handling
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250512065849.2833232-1-quic_vignc@quicinc.com>
 <52ff43fc-160c-4efe-ba9e-42a0c838fb3d@oss.qualcomm.com>
Content-Language: en-US
From: Vignesh C <quic_vignc@quicinc.com>
In-Reply-To: <52ff43fc-160c-4efe-ba9e-42a0c838fb3d@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9ouehtgX1rlTe1STevfGn6tSBTGJDjar
X-Proofpoint-ORIG-GUID: 9ouehtgX1rlTe1STevfGn6tSBTGJDjar
X-Authority-Analysis: v=2.4 cv=cO7gskeN c=1 sm=1 tr=0 ts=68248334 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=lxI7rM9-fu8l8QvitgwA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEwNCBTYWx0ZWRfX4hplnQVmszKD
 RUvqqsgCxrJt50qyzpYfJzM0ruWtGMBm198oivtCf7MmDs2OUdIJZe+zjIPPWCPrqr0xyRZbeuV
 2e1C2Bv0SN8rTB3zc2rnAybtsrR9ui895zWxPkeU9CZxtnq2Y3fsmdTlqK8hChB/ZLf+ELUUXap
 xeRMIAlKnmNWN9B3jyG26QsF5JsyGO5EZx1zr7/48juho+48vm4CCjoXkRVzF0Z2DHXXw32jRQl
 E3txgp4wOfOmNcc7jD0NM+yftjeK6WM/uWMKKMuIdj732Wxb7sMlIXHWpS9JB21dc8LQ1B1W3Dr
 SQxBXQnP142wFCnyNoq2oontR6dfQ4naC0fkdVznIZJeIBJu83Xq3PXmEi1p/eGsNrPBBx3ZCXd
 EdN8YTvu2clUs4X2LYWMj3ZSStarlKo2trjt1mjPT6ArshOyBe4EuvbdjJGI0jzX091ozKMs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140104



On 5/13/2025 3:25 AM, Jeff Johnson wrote:
> On 5/11/2025 11:58 PM, Vignesh C wrote:
>> During a code review, it is observed that in the scenario
>> where scan initiation fails, the current code schedules the
>> ar->scan.timeout workqueue which is not necessary.
> 
> Are there any user-visible effects?
> 

When MAC debug is enabled, the message 'mac scan started' is displayed, which is misleading in scan start failure scenario. Additionally, a scan timeout work-queue is scheduled to attempt aborting the scan, which is unnecessary in such cases.

>>
>> In the scan initiation failure scenario, exit the code instead
>> of scheduling the ar->scan.timeout workqueue.
>>
>> Compile tested only.
>>
>> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> 
> If there are no user-visible effects then I'll drop the Fixes tag since there
> is no reason to backport this to stable kernel versions.
> 

Kindly refer the above comment and please let me know the next steps.

>> Signed-off-by: Vignesh C <quic_vignc@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/mac.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index 4dae941c9615..0cf2b3d06c3b 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -4647,6 +4647,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>>  		spin_lock_bh(&ar->data_lock);
>>  		ar->scan.state = ATH12K_SCAN_IDLE;
>>  		spin_unlock_bh(&ar->data_lock);
>> +		goto exit;
>>  	}
>>  
>>  	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac scan started");
>>
>> base-commit: 3a64d6def8733e75909abcfab983efae92dc4102
> 


