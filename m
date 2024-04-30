Return-Path: <linux-wireless+bounces-7012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F078B6798
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 03:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55E5B226DE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 01:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7A4205E3C;
	Tue, 30 Apr 2024 01:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oL+rd9du"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14717F5
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714441310; cv=none; b=TUAQb7ncNfq8ucxSQ7C1Idwk4MZpsVuDvTNwty9ytR8BWP/Jgzp5ROmD9YsDdsKP+CrU7d9l9JilqFF1v/GQ3VJ537Kw62WGoOU1C8azNVAlT8HXAHww6FMIu6TyPkbWzIm+xYYgkQ1P1YGTdM3VfS8C90VHy2avSsXkW4j0DEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714441310; c=relaxed/simple;
	bh=PF3eZ6u/w3VCzcGXyhfAnvRo/uF7uMPpR1/mw8jtRlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ulXzefoNbyS2LqYFL0hDqVRvZq4vG6cs6DUS3gT/w+Q8bnqo30TdtDmxFBFzubDHQ/Cfw2Kbph7KdBoqAxiEJph+PX0oj69uLfxCHc/39G4S9wi0mHXh5zdSCr8y0+zeeF4BgUP65g4U6c7j7p622XY3L9C1+aTubymC7aZDBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oL+rd9du; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TNjIMY026547;
	Tue, 30 Apr 2024 01:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tcCXDywC3c1qZF8dKwGwyKT1EkvjlULky2P4Vkl6isk=; b=oL
	+rd9duy4o76QHwInb6PpJ5TWHbhfhASIs3TAeVZ9d1yuJi5NTfg0Ec32WTuBon06
	w1nFvBmFyPumeX4fhi2g+c3BxJ4tmQ8UxZxNw96jXGXWiIJkePeDSh+51EK94bgj
	2gR3RcGzaW3Ejj1aQ/H6BnQ/6oURuCxFHA7FdmgsQX40pvjk41MwKPWdTMtptRZ7
	gztDZNJEIzVUEEk8bQ8dcAgQKTf/U8XG0u60VjPIFO8nQDlWn451MV2qwfHUbIc4
	AJgfqQKfoL2zqTqV5LSl5onJdiNnBGpazSD0c+P8LFMQyfIWg2S9JaCWoIKcnOrl
	efJ8vfYObhyl9fkdcyIQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xthgvs9u6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 01:41:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U1fc0o005996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 01:41:38 GMT
Received: from [10.227.91.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 18:41:37 -0700
Message-ID: <51073e2c-2138-4957-a78c-2708c7742451@quicinc.com>
Date: Mon, 29 Apr 2024 18:41:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] wifi: ath12k: add support for setting fixed HE
 rate/GI/LTF
To: Kalle Valo <kvalo@kernel.org>
CC: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Muna Sinada <quic_msinada@quicinc.com>
References: <20240424201959.935-1-quic_pradeepc@quicinc.com>
 <20240424201959.935-8-quic_pradeepc@quicinc.com>
 <72bc6772-8bf7-427d-8f03-01e8dbf30d0c@quicinc.com>
 <87y190fulv.fsf@kernel.org>
 <198e317f-a849-4fe2-8080-3d1834d07481@quicinc.com>
 <87sez4fk1o.fsf@kernel.org>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <87sez4fk1o.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iSnhAWoY6DA89NCMPachyUv9HCG1Hc3w
X-Proofpoint-GUID: iSnhAWoY6DA89NCMPachyUv9HCG1Hc3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_22,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300011



On 4/29/2024 5:08 AM, Kalle Valo wrote:
> Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> writes:
> 
>> On 4/26/2024 12:31 AM, Kalle Valo wrote:
>>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>>
>>>> On 4/24/2024 1:19 PM, Pradeep Kumar Chitrapu wrote:
>>>>> Add support to set fixed HE rate/GI/LTF values using nl80211.
>>>>> Reuse parts of the existing code path already used for HT/VHT
>>>>> to implement the new helpers symmetrically, similar to how
>>>>> HT/VHT is handled.
>>>>>
>>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>>>>
>>>>> Co-developed-by: Muna Sinada <quic_msinada@quicinc.com>
>>>>> Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
>>>>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> @@ -7753,7 +8034,20 @@ ath12k_mac_bitrate_mask_get_single_nss(struct ath12k *ar,
>>>>>    			return false;
>>>>>    	}
>>>>>    -	if (ht_nss_mask != vht_nss_mask)
>>>>> +	he_mcs_map = le16_to_cpu(ath12k_mac_get_tx_mcs_map(&sband->iftype_data->he_cap));
>>>>
>>>> drivers/net/wireless/ath/ath12k/mac.c:8041:22: warning: incorrect type in argument 1 (different address spaces)
>>>> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    expected struct ieee80211_sta_he_cap const *he_cap
>>>> drivers/net/wireless/ath/ath12k/mac.c:8041:22:    got struct ieee80211_sta_he_cap const [noderef] __iftype_data *
>>> ALWAYS run ath12k-check, we wrote the tool for a reason. Skipping
>>> these
>>> tests is disrespect for maintainers' time and a great way to get your
>>> patches to the bottom of the queue.
>>>
>> Hi Kalle
>>
>> I did run ath12k-check but I don't see these errors. Trying to see if
>> this is due to version differences. will update further once I have
>> more information on this.
>>
>> This is version I ran:
>> qca-swiss-army-knife/tools/scripts/ath12k/ath12k-check --version
>> ath12k-check (md5sum cb8a85242f2ec7343f6f94af9fa5ebb2)
>>
>> python:         3.6.9 (default, Mar 10 2023, 16:46:00)
>> [GCC 8.4.0]
>> host gcc:       gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>> config cc:      gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
>> sparse:         v0.6.4
>> checkpatch.pl:  Version: 0.32 (md5sum 12ea394e9bf27280f30a684ff937cc57)
>> gtags:          gtags (GNU GLOBAL) 6.6.2
> 
> Your sparse is too old, you need to get the latest from git:
> 
> https://docs.kernel.org/dev-tools/sparse.html#getting-sparse

Thanks Kalle and Jeff for sharing the tool versions required..
I am able to see the errors reported now..
will fix and respin the series..

ath12k-check (md5sum cb8a85242f2ec7343f6f94af9fa5ebb2)

python:         3.6.9 (default, Mar 10 2023, 16:46:00)
[GCC 8.4.0]
host gcc:       gcc (GCC) 13.2.0
config cc:      gcc (GCC) 13.2.0
sparse:         v0.6.4-66-g0196afe16a50
checkpatch.pl:  Version: 0.32 (md5sum 12ea394e9bf27280f30a684ff937cc57)
gtags:          gtags (GNU GLOBAL) 6.6.2


Thanks
Pradeep


> 
> Also your GCC is really old, I strongly recommend to use GCC 13.2. You
> can get it here:
> 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> Why on earth are you using Ubuntu 18.04? It's end of life was a year
> ago.
Will get update ubuntu in few days.
> 
> And please also update ath12k-check. This is what I have:
> 
> $ ath12k-check --version
> ath12k-check (md5sum c5567fc8aaede613275e8cafea6ed7cd)
> 
> python:         3.11.2 (main, Mar 13 2023, 12:18:29) [GCC 12.2.0]
> host gcc:       gcc (Debian 12.2.0-14) 12.2.0
> config cc:      x86_64-linux-gcc (GCC) 13.2.0
> sparse:         v0.6.4-39-gce1a6720f69e
> checkpatch.pl:  Version: 0.32 (md5sum 77c655474ed7622c0077caf2f0d7c440)
> gtags:          gtags (Global) 6.6.9
> 
>> I see some notes like below this in all files:
>> drivers/net/wireless/ath/ath12k/mac.c: note: in included file (through
>> include/linux/bitops.h, include/linux/kernel.h,
>> include/net/mac80211.h):
>> drivers/net/wireless/ath/ath12k/mac.c: note: in included file (through
>> include/linux/bitops.h, include/linux/kernel.h,
>> include/net/mac80211.h):
> 
> Jeff and me are extra careful that there are no warnings in ath12k, in
> fact in wireless-next the whole wireless subsystem has no sparse
> warnings. So if you ever see warnings please report them to maintainers
> ASAP.
> 


