Return-Path: <linux-wireless+bounces-8511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B88FC3B6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 08:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828AF1F2696C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 06:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDC190466;
	Wed,  5 Jun 2024 06:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ss2owffJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DE119047E
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 06:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569127; cv=none; b=t2qUF+IpVkLfkhQfvGoUY1eAD4lnaJDXokr+YvbiaHHp8iOhofyW8fKfTR/F1KJiAdfcQqll7mrdWIejBsQ+NrQn2tAydJrx0VWDbB5DeYJVNBpdUJC7xDntPUP/AQyKJHUFSZykXintocsaz3ue8HNWNYHKufgUGmYbC13uxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569127; c=relaxed/simple;
	bh=07oGwpk6gUJzQnqzpdSNjWPzQFfnhXmG+TGKg4/4dEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F/7ceaab2fTxMSS/52i8KTCAMziaoNbxQT54lGzkFlaT6J2VwFKoLd9rh1os3XegrtI4cVdGyBb80miFKxW7HQmr6ixLbOAu6Dnuq0hENYrO0AKgYdIE3mBOzLjlvjsu1iMJB6wQOTxhirs3VxQ62czjHCY+Uc2djgawEppH/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ss2owffJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45506PX0021521;
	Wed, 5 Jun 2024 06:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YegnvcHPKiUXxCBaWXUkOZrxWCuc3GNdaBCAVJPvomo=; b=Ss2owffJSJP9yVjt
	4CoE6+ikTOK1Y8jj2BzMpaOKWnSsYKyuB2tksJ9Iz0lsOjZ5JuVTSZYkzlGS1p7J
	dAJOoIKN3OrdDrj0Z1Hn91iVFBUXeRb4t95Iesi0xPnQLvrwL2QeL+bvSE3cV4NQ
	ue5QUtOIlXCoD74Vs6rNsdlkubxRZ/6cwa4+Jjfcu3nfvx1WrlHSWF6YfDjwaQPs
	QLuvW5/np3R0oKYkPoBkqUH/78PIdZMmKi3GUWiYQvzX18OVxfNGmTn2TvR/mzM0
	CKEYudz+VTu0vr6vuIH/kJgGcEI2tuPr3YISkWh30D1HJTIXmF6b9sTU7aohxw+m
	V/nMbQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj13xjb5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 06:31:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4556VaPT017732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 06:31:36 GMT
Received: from [10.111.167.179] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 23:31:34 -0700
Message-ID: <4fdfdb34-7892-4bf9-8da1-e09cf6ff7731@quicinc.com>
Date: Wed, 5 Jun 2024 14:31:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] wifi: ath12k: report station mode transmit rate
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
 <20240419032122.7009-2-quic_lingbok@quicinc.com> <87bk5xs7qj.fsf@kernel.org>
 <050ae0d4-c879-40c2-b2ac-1766aaa2c789@quicinc.com>
 <87v844qsih.fsf@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87v844qsih.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N3FyGgkTWHJeM6gpA6ZJNo4CHfODFim-
X-Proofpoint-GUID: N3FyGgkTWHJeM6gpA6ZJNo4CHfODFim-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=947 spamscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406050047



On 2024/4/26 19:21, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> writes:
> 
>> On 2024/4/26 0:54, Kalle Valo wrote:
>>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>>
>>>> +static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct
>>>> hal_tx_status *ts)
>>>> +{
>>>> +	struct ath12k_base *ab = ar->ab;
>>>> +	struct ath12k_peer *peer;
>>>> +	struct ath12k_sta *arsta;
>>>> +	struct ieee80211_sta *sta;
>>>> +	u16 rate;
>>>> +	u8 rate_idx = 0;
>>>> +	int ret;
>>>> +
>>>> +	spin_lock_bh(&ab->base_lock);
>>>
>>> Did you analyse how this function, and especially taking the
>>> base_lock,
>>> affects performance?
>>
>> The base_lock is used here because of the need to look for peers based
>> on the ts->peer_id when calling ath12k_peer_find_by_id() function,
>> which i think might affect performance.
>>
>> Do i need to run a throughput test?
> 
> Ok, so to answer my question: no, you didn't do any performance
> analysis. Throughput test might not be enough, for example the driver
> can be used on slower systems and running the test on a fast CPU might
> not reveal any problem. A proper analysis would be much better.
> 

Hi, kalle,
I did a simple performance analysis of the ath12k_dp_tx_update_txcompl() 
function on slower systems.

Firstly, i use perf tool to set dynamic tracepoints in 
ath12k_dp_tx_complete_msdu() function, and then used the command of 
"iperf -c ip address -w 4M -n 1G -i 1" to do traffic test.

During this process, use ./perf record -a -g to detect the performace of 
the system.

Finally, compare the results with and without this patch.

without this patch
./perf report output
children    self	command		symbol
7.28%	   0.08%      ksoftirqd/0 ath12k_dp_tx_complete_msdu
5.96%      0.03%      swapper     ath12k_dp_tx_complete_msdu   		

iperf output
[  1] 0.0000-62.6712 sec  1.00 GBytes   137 Mbits/sec

with this patch
children    self       command         symbol
7.42%	   0.08%      ksoftirqd/0  ath12k_dp_tx_complete_msdu
6.32%      0.03%      swapper      ath12k_dp_tx_complete_msdu

iperf output
[  1] 0.0000-62.6732 sec  1.00 GBytes   137 Mbits/sec

As can be seen from the table above, with this patch, the CPU time 
percentage will increase by 0.5%.

So, i think applying this patch will definitely have an impact on system 
performance, but the impact is not that big and i think it can be ignored:)

Best regards
Lingbo Kong

