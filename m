Return-Path: <linux-wireless+bounces-1960-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF982E91D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 06:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5AD1F237B8
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jan 2024 05:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1379F1;
	Tue, 16 Jan 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gFIfkHf3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4BC79C3
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jan 2024 05:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G3reu2000644;
	Tue, 16 Jan 2024 05:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BPj6Qmum6HRcUm8rlQRyFSpjx0CiJ/Kh9MlB52eqJEg=; b=gF
	IfkHf3Zatgpbws+xd2tnYSYXszKTD0astt2mzG9wOQGrL9itFZ5fD4lgRx2yrQ9f
	/XCVgzT841Bj5jCEsHHO83gHa9aKk++zRV9WpytlWVNtqBPeFQjFohOrbTHJVbDT
	hKZ405rTfb/k4U28fV6NPo4x0lsIaC0VZXKld8p+aIrQwUwm7x0Jw0wnWglPCibh
	YrtI0l5pnnokqJV9WLYvbKwInsybDIuWQmzcC8zxsr18PZ8F9xhJR5WwFA5NEbIT
	bdsVR4mqhxv5/msElbnczWdZOmRD0VaV886c75ADV94YE2cXjr9jJpr2ju4zWB7T
	qgkZBn+NUFHRbMMhbUNA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vngm58bn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:14:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G5EpsJ001230
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 05:14:52 GMT
Received: from [10.50.41.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 21:14:50 -0800
Message-ID: <839b56fa-9ce8-47f3-768d-b4f32a2041f1@quicinc.com>
Date: Tue, 16 Jan 2024 10:44:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Introduce the container for mac80211
 hw
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240112024214.3481840-1-quic_periyasa@quicinc.com>
 <20240112024214.3481840-3-quic_periyasa@quicinc.com>
 <87bk9m7f5g.fsf@kernel.org>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <87bk9m7f5g.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: swiRe-rco6q3X3GvdV3uagto5QPrTuCj
X-Proofpoint-ORIG-GUID: swiRe-rco6q3X3GvdV3uagto5QPrTuCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=708 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160038


On 1/15/2024 9:38 PM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
>
>> To support multi link operation, we need to combine all the link/pdev
>> under a single wiphy. This avoids the overhead of synchronization
>> across multiple hardware instances in both the cfg80211 and mac80211
>> layers. Currently, each link/pdev is registered as separate wiphy,
>> tightly coupled with link/pdev/radio (ar) structure. To enable single
>> wiphy registration within the chip, we decouple the wiphy data entity from
>> the link/pdev/radio (ar) structure and move it under the chip (ab)
>> structure with a new data container (ath12k_hw) structure. This approach
>> improves scalability for future multi link operation support.
> What about struct ath12k_pdev? Do we need it still or should it be removed?


ath12k_pdev still holds the pdev related information within the SoC/chip 
(ab). I dont want it be remove.


>
>>   static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
>>   					 struct ieee80211_vif *vif)
>>   {
>> -	struct ath12k *ar = hw->priv;
>> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>> +	struct ath12k *ar;
>> +
>> +	mutex_lock(&ah->conf_mutex);
>> +
>> +	ar = ath12k_ah_to_ar(ah);
>>   
>>   	mutex_lock(&ar->conf_mutex);
>>   	ath12k_scan_abort(ar);
>>   	mutex_unlock(&ar->conf_mutex);
>>   
>> +	mutex_unlock(&ah->conf_mutex);
>> +
>>   	cancel_delayed_work_sync(&ar->scan.timeout);
>>   }
> Do we really need two mutexes? I don't see any analysis about that. And
> even if we do, I feel that it should be added in a separate patch.


Yes, ah->conf_mutex protect the concurrent mac80211 operation. But there 
is other places like radio/link specific synchronous operation (ie MGMT 
tx wait for the vdev deletion) is needed. To fulfill this need, we also 
need radio/link specific (ar) mutex instead of all link (ah) mutex for 
efficient lock/unlock.


Thanks,

Karthikeyan


