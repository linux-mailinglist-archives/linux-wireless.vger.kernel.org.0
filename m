Return-Path: <linux-wireless+bounces-9975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9696F926F4F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 08:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89681C217EA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 06:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB631A270;
	Thu,  4 Jul 2024 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b9m1TK0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E3FC0A
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 06:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720073173; cv=none; b=MqLzqBIFOAsjscYV/9DGxaYcMKL37L6jSnBouQ6j0DVha/f5znGcV69KmmHbCjqYlLgyLVKjKFB/Vn+wk9MREG8nMKMElyRIrazXXqpHEQeLApG1b4PPUvWQKf73mNuF7o6cQ5kLoUqSwfiiZki4NdO3of7EjRam3T632dgcEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720073173; c=relaxed/simple;
	bh=8hK9BhWn7CAoyYFQ3gRohfR+GjJj8iFDUJ9e8KjpenY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=th2Q0qce9Q6FzKJezYS9FDax67/21BLrZ48Hd1pnJlyx3BSy3N0DE26SO7Umxoin3AnSPqGcm4FKA+1l0X7fvs0oKHqOsrMl8lkTF/iE9KYv+cfzN/8f0ChaUkiPDgitR6M5hdhpif1Drm5dCrnCva9gYkXSg87S43mH+uZ/6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b9m1TK0f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46462sZX011027;
	Thu, 4 Jul 2024 06:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KMWuoFQwbU1BG74aga67MsrRmSrjD0PN9R9Fz1l3bhc=; b=b9m1TK0f4crqjh6T
	8uc4pN9O82rslEAUyutdgCafEHbTG+S927VUkNY2H2BDSlE0s2ehKa8wfO7p9n5r
	DdTsJTZ9+v9K/1KLteGKVfCTCB3F7fp4+ehB8Bi5JaNM0HsoubfB5hyCJh057pzJ
	kKf8rc/EzYfizEbcYBJBkn/tbwgcGxqdQhRxxQ93goxYcwGim10ohpgIK9Ea7Q0y
	Bk2oj8a7aMZZ2iYsJZs+nKQ2cSjvTOoePRTunA2SRQt9cAD7EU9JnwwBjr/QXWhE
	w18k2rR6fkkMN6gq6vCbdJxvAp/xDnvxWd2G/PFy9uv7A4jr4SAJcUR9o6J4oDwX
	QE/GMA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 404yr9aufb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jul 2024 06:06:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 464662X3028115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jul 2024 06:06:02 GMT
Received: from [10.38.245.141] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 3 Jul 2024
 23:06:00 -0700
Message-ID: <3085cd30-cc71-4eed-ae68-07ce64e45405@quicinc.com>
Date: Thu, 4 Jul 2024 14:05:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] wifi: ath12k: report station mode transmit rate
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
 <20240419032122.7009-2-quic_lingbok@quicinc.com> <87bk5xs7qj.fsf@kernel.org>
 <050ae0d4-c879-40c2-b2ac-1766aaa2c789@quicinc.com>
 <87v844qsih.fsf@kernel.org>
 <4fdfdb34-7892-4bf9-8da1-e09cf6ff7731@quicinc.com>
 <e28947fe-c0a7-4445-9e02-7224f733553b@quicinc.com>
Content-Language: en-US
In-Reply-To: <e28947fe-c0a7-4445-9e02-7224f733553b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pl0JoMPxEhMT8v4Tas9GQshqLhykfa0a
X-Proofpoint-ORIG-GUID: Pl0JoMPxEhMT8v4Tas9GQshqLhykfa0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_18,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=760 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407040043



On 2024/6/17 19:50, Lingbo Kong wrote:
> 
> 
> On 2024/6/5 14:31, Lingbo Kong wrote:
>>
>>
>> On 2024/4/26 19:21, Kalle Valo wrote:
>>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>>
>>>> On 2024/4/26 0:54, Kalle Valo wrote:
>>>>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>>>>
>>>>>> +static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct
>>>>>> hal_tx_status *ts)
>>>>>> +{
>>>>>> +    struct ath12k_base *ab = ar->ab;
>>>>>> +    struct ath12k_peer *peer;
>>>>>> +    struct ath12k_sta *arsta;
>>>>>> +    struct ieee80211_sta *sta;
>>>>>> +    u16 rate;
>>>>>> +    u8 rate_idx = 0;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    spin_lock_bh(&ab->base_lock);
>>>>>
>>>>> Did you analyse how this function, and especially taking the
>>>>> base_lock,
>>>>> affects performance?
>>>>
>>>> The base_lock is used here because of the need to look for peers based
>>>> on the ts->peer_id when calling ath12k_peer_find_by_id() function,
>>>> which i think might affect performance.
>>>>
>>>> Do i need to run a throughput test?
>>>
>>> Ok, so to answer my question: no, you didn't do any performance
>>> analysis. Throughput test might not be enough, for example the driver
>>> can be used on slower systems and running the test on a fast CPU might
>>> not reveal any problem. A proper analysis would be much better.
>>>
>>
>> Hi, kalle,
>> I did a simple performance analysis of the 
>> ath12k_dp_tx_update_txcompl() function on slower systems.
>>
>> Firstly, i use perf tool to set dynamic tracepoints in 
>> ath12k_dp_tx_complete_msdu() function, and then used the command of 
>> "iperf -c ip address -w 4M -n 1G -i 1" to do traffic test.
>>
>> During this process, use ./perf record -a -g to detect the performace 
>> of the system.
>>
>> Finally, compare the results with and without this patch.
>>
>> without this patch
>> ./perf report output
>> children    self    command        symbol
>> 7.28%       0.08%      ksoftirqd/0 ath12k_dp_tx_complete_msdu
>> 5.96%      0.03%      swapper     ath12k_dp_tx_complete_msdu
>>
>> iperf output
>> [  1] 0.0000-62.6712 sec  1.00 GBytes   137 Mbits/sec
>>
>> with this patch
>> children    self       command         symbol
>> 7.42%       0.08%      ksoftirqd/0  ath12k_dp_tx_complete_msdu
>> 6.32%      0.03%      swapper      ath12k_dp_tx_complete_msdu
>>
>> iperf output
>> [  1] 0.0000-62.6732 sec  1.00 GBytes   137 Mbits/sec
>>
>> As can be seen from the table above, with this patch, the CPU time 
>> percentage will increase by 0.5%.
>>
>> So, i think applying this patch will definitely have an impact on 
>> system performance, but the impact is not that big and i think it can 
>> be ignored:)
>>
>> Best regards
>> Lingbo Kong
> 
> Hi, kalle
> do you have any comments regarding the above content?:)
> 
> best regards
> Lingbo Kong

hi，kalle，

In this patch, ath12k utilizes base_lock because it needs to invoke the 
ath12k_peer_find_by_id() function to find the peer using peer_id, and 
subsequently access ieee80211_sta through the peer. The base_lock is 
used to protect data like peers.

I've contemplated an alternative approach that can avoid the use of 
base_lock. we could consider using the ieee80211_find_sta_by_ifaddr() 
function to directly locate ieee80211_sta based on hdr->addr1, thus 
potentially eliminating the need for base_lock.

It's important to note that the ieee80211_find_sta_by_ifaddr() function 
call must be placed under an RCU lock. Fortunately, the 
ath12k_dp_tx_complete_msdu() function already incorporates rcu_read_lock().

I can rebase on the latest code and post v5:)

Best regards
Lingbo Kong



