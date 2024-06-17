Return-Path: <linux-wireless+bounces-9062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38FE90AD56
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 13:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A89284292
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C791193065;
	Mon, 17 Jun 2024 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H6j8ayxf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BDA186E56
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625056; cv=none; b=o0gZb6/K6LOuufg3q6AuO+rr4NGyE/qTREfDfS5r2lndqtUPwjJCx5gm3wAyCGcY8kILNmoJjigXmmsSntGkIrZZrYICDYMujcPP41gP1YhEb7c7YcylVNuv7PZyuWK66HdZrTMmzFDE7D0hP/spak/qwlMjCZXmWUs9dBocxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625056; c=relaxed/simple;
	bh=X1fihKyXUdom3w7PwLpPjYGIYrZbzdjJZp0XuZUzw7Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=Nt2PnCZ64kWs6NaoQUysxcJtLvbNTIUt2fq/C0FJ8wCVpqv72DWcYnQdcuxfopjxT83s89UJ9AUqvcD2RBeSEz6gEZhEFTU0rX46YBrPiKlpA7uM8CjyJUpMc3g83FVd5IZOsy6JJWFHQp56smFgU57P5Bz0dFwWErBuV+zTZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H6j8ayxf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAefGf024860;
	Mon, 17 Jun 2024 11:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1AR55VlvyvZwB5yxAZ1a9slI5M6W51ohX3f5Ul0Vt/U=; b=H6j8ayxfWmKpeqCr
	BeHwugbwwC5JPyrpcG6QH3HAw+z2ZYXXcdcQILKJq38LxlsjhL9vMe0j+JQjcbCi
	cwN/diFjqP+vc8VtjmuNwlbKO8dkBA3fRL2FUwhZo+q5Xq9V9iS2WtpIc/Xz2wSp
	dvqTQKbG5ZV8EZFW3OKDuVPcs1TxNXek37hPJLpoP52EEaiC8D24HmMiLYK0KL0u
	OW9VpotK4KHJQa4veaLahUFfb6b6oFoZHGm5AfavplF10TJbXnpyESubj61dSx1m
	l+tg6z3he/vSXlvWsnCrfQoU5Ov4g/xB8n7gE5ZNaHp8FI8f23BGRJqM+6bLy/iL
	by30KQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3qf3jy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 11:50:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HBoJun026815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 11:50:19 GMT
Received: from [10.110.108.3] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 04:50:18 -0700
Message-ID: <e28947fe-c0a7-4445-9e02-7224f733553b@quicinc.com>
Date: Mon, 17 Jun 2024 19:50:15 +0800
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
Content-Language: en-US
In-Reply-To: <4fdfdb34-7892-4bf9-8da1-e09cf6ff7731@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Wj0NSy-bOxRF7a-8bSP4YVA669vZaccu
X-Proofpoint-ORIG-GUID: Wj0NSy-bOxRF7a-8bSP4YVA669vZaccu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_10,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=995 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170092



On 2024/6/5 14:31, Lingbo Kong wrote:
> 
> 
> On 2024/4/26 19:21, Kalle Valo wrote:
>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>
>>> On 2024/4/26 0:54, Kalle Valo wrote:
>>>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>>>
>>>>> +static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct
>>>>> hal_tx_status *ts)
>>>>> +{
>>>>> +    struct ath12k_base *ab = ar->ab;
>>>>> +    struct ath12k_peer *peer;
>>>>> +    struct ath12k_sta *arsta;
>>>>> +    struct ieee80211_sta *sta;
>>>>> +    u16 rate;
>>>>> +    u8 rate_idx = 0;
>>>>> +    int ret;
>>>>> +
>>>>> +    spin_lock_bh(&ab->base_lock);
>>>>
>>>> Did you analyse how this function, and especially taking the
>>>> base_lock,
>>>> affects performance?
>>>
>>> The base_lock is used here because of the need to look for peers based
>>> on the ts->peer_id when calling ath12k_peer_find_by_id() function,
>>> which i think might affect performance.
>>>
>>> Do i need to run a throughput test?
>>
>> Ok, so to answer my question: no, you didn't do any performance
>> analysis. Throughput test might not be enough, for example the driver
>> can be used on slower systems and running the test on a fast CPU might
>> not reveal any problem. A proper analysis would be much better.
>>
> 
> Hi, kalle,
> I did a simple performance analysis of the ath12k_dp_tx_update_txcompl() 
> function on slower systems.
> 
> Firstly, i use perf tool to set dynamic tracepoints in 
> ath12k_dp_tx_complete_msdu() function, and then used the command of 
> "iperf -c ip address -w 4M -n 1G -i 1" to do traffic test.
> 
> During this process, use ./perf record -a -g to detect the performace of 
> the system.
> 
> Finally, compare the results with and without this patch.
> 
> without this patch
> ./perf report output
> children    self    command        symbol
> 7.28%       0.08%      ksoftirqd/0 ath12k_dp_tx_complete_msdu
> 5.96%      0.03%      swapper     ath12k_dp_tx_complete_msdu
> 
> iperf output
> [  1] 0.0000-62.6712 sec  1.00 GBytes   137 Mbits/sec
> 
> with this patch
> children    self       command         symbol
> 7.42%       0.08%      ksoftirqd/0  ath12k_dp_tx_complete_msdu
> 6.32%      0.03%      swapper      ath12k_dp_tx_complete_msdu
> 
> iperf output
> [  1] 0.0000-62.6732 sec  1.00 GBytes   137 Mbits/sec
> 
> As can be seen from the table above, with this patch, the CPU time 
> percentage will increase by 0.5%.
> 
> So, i think applying this patch will definitely have an impact on system 
> performance, but the impact is not that big and i think it can be ignored:)
> 
> Best regards
> Lingbo Kong

Hi, kalle
do you have any comments regarding the above content?:)

best regards
Lingbo Kong

