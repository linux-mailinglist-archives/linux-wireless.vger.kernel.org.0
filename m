Return-Path: <linux-wireless+bounces-1632-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDE82873E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 246892864B7
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 13:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C0239843;
	Tue,  9 Jan 2024 13:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ozf+4nuU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756F39842
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 13:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409D8mOv002965;
	Tue, 9 Jan 2024 13:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=akBXQjXKMd/5A7VnbHOMalI5Y+eil6OUztLsE98QZ5E=; b=oz
	f+4nuUEm3SplgYystBSsFlzGFmDhzGASxpr+ySe6tGmka91lk6uA9yE0RE914eaj
	FXrQRmDXN6XKC22OiRJEN+g1lY0h9Jb9UnI+IDgpDmE7IgYHEcjpmYUFjJtEiTTp
	mUROgcvHz7ldriWh1bNjBtVZquw7hcMcP5R8+rCCsBYuaQ7ibMP0ojBjH1OO9Jjm
	EMKepJf0Z71z2kSwxkLmz/GNpOvxdL5e0mc57QgLMdHf3Jd9ffwc/LBgrHHEQcNi
	Eox/AZmeONr5uGNmKlKSf6NcmoLyUlavB09aoxLkuO3fGh/Fr/88HBwTNMmKFQah
	PsMPXy1Qjt7Mq0s56VbA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgq2ysu2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 13:41:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409DfikF018782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 13:41:44 GMT
Received: from [10.50.53.157] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 05:41:43 -0800
Message-ID: <269ea05b-d665-eceb-d7a1-d0ac20d341a7@quicinc.com>
Date: Tue, 9 Jan 2024 19:11:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] wifi: ath12k: Refactor MAC un/register helper
 function
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20231206034920.1037449-1-quic_periyasa@quicinc.com>
 <20231206034920.1037449-5-quic_periyasa@quicinc.com>
 <87bk9uej0b.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87bk9uej0b.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6K6FnMBr2F3sxkAgQZf0za25q5lCT8Id
X-Proofpoint-ORIG-GUID: 6K6FnMBr2F3sxkAgQZf0za25q5lCT8Id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=908 clxscore=1011 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090113


On 1/9/2024 6:55 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>
>> Currently, the mac80211 hw registration procedure is tightly coupled with
>> the handling of link/radio (ar). Define a new helper function to separate
>> the link/radio handling from the mac80211 hw registration procedure for
>> improved code readability. Also, it can be easy to scale these
>> functionality to support single/multi link operation in the future.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/core.c |  61 +++++++++++-
>>   drivers/net/wireless/ath/ath12k/mac.c  | 132 ++++++++++---------------
>>   drivers/net/wireless/ath/ath12k/mac.h  |   4 +-
>>   3 files changed, 109 insertions(+), 88 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>> index e10c5f2cd8eb..d1ac00c59b8c 100644
>> --- a/drivers/net/wireless/ath/ath12k/core.c
>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>> @@ -498,11 +498,62 @@ static void ath12k_core_soc_destroy(struct ath12k_base *ab)
>>   	ath12k_qmi_deinit_service(ab);
>>   }
>>   
>> +static int ath12k_core_mac_register(struct ath12k_base *ab)
>> +{
>> +	struct ath12k *ar;
>> +	struct ath12k_pdev *pdev;
>> +	int i;
>> +	int ret;
>> +
>> +	if (test_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags))
>> +		return 0;
>> +
>> +	/* Initialize channel counters frequency value in hertz */
>> +	ab->cc_freq_hz = 320000;
>> +	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS)) - 1;
>> +
>> +	for (i = 0; i < ab->num_radios; i++) {
>> +		pdev = &ab->pdevs[i];
>> +		ar = pdev->ar;
>> +
>> +		ret = ath12k_mac_hw_register(ar);
>> +		if (ret)
>> +			goto err_cleanup;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_cleanup:
>> +	for (i = i - 1; i >= 0; i--) {
>> +		pdev = &ab->pdevs[i];
>> +		ar = pdev->ar;
>> +		ath12k_mac_hw_unregister(ar);
>> +	}
>> +
>> +	return ret;
>> +}
> Is there a reason why you moved these two functions from mac.c to
> core.c? This is mac level code anyway, right?


This is not fully mac level code, some parts of SoC/chip level code 
bindup in the mac level.
So i segregated the SoC level code like ab related param initialization 
handling from the mac level procedure.

Now, mac/radio should take care only radio level handling procedure.


In future for MLO, SoC level can be extend easily.


Thanks,

Karthikeyan P.


