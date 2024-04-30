Return-Path: <linux-wireless+bounces-7041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 304458B74BB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF189281FD8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F67113CF98;
	Tue, 30 Apr 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cMS8frod"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0796132808
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477334; cv=none; b=Ok71I8jlZ2CZty3SF7cEgoShh68sWnAKoBpAIn3zjMpswMn70WCCKYn8HBsJeAS3jJevfxZDPr9l+SPmY2UY2FIO3zosYj4mbg4yELfUJpOqF0B7bG/Zm9FDWbmsnAEBQhX7SR0iK+gwaeSoNKMlpJnPv5WrrgoRDu2w76aiPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477334; c=relaxed/simple;
	bh=7vD7rcl05rEXPtPKRKs4IjWimbVkyKQm6RMr1LjZUhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BGXZrXyX0ZbvlpzVxeItIUmSY7PqKlzKdLK+HhtleEFIz/SoQ2Wfw+8FkkDdIM40RjNabnzJ4COqBZMv7KyvUYRjrYmExflsl6+VLRCbCXBxiSD6aAFMHlTI9Y2J14nIv3ZER8+9QBJqqnf23/EbKoDoKboYIbTImpWnsXb7zPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cMS8frod; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UBMD2A008109;
	Tue, 30 Apr 2024 11:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WPdUtBS3JiyNceoEgE5avHeOVi0sOkqNqMNCE3yRl0s=; b=cM
	S8frodLKW7QWrGyqTZ0REE4bxnW92fbC8ubN8hqNkh4g5Lx1ufVhQ+YvbxOpWPyz
	Stcylbgu3pCd/lEss1xVnJdOfHhmN45aCwGrGt4UtMCLWS8YJU0bT2Tn8zlLtSYX
	d/FQIfbHHBLh+P1mBHc4xVVu5r3H3iuPgcvOSgGjKr04BPeSvG7BisgSJKlDjjMp
	+Qif4brscm7/qc5tTJBtlnI9tMMcoUl+ayQik4Fj5zrHEWFyXBZGHGRH1HFf1EF4
	PFqKSRoSZVXL1p+9/XOJixuswU/3t4hQfSwj2WwuK+4ASsiSroiyxXLSHckrw95E
	qyKHMNn1EsOIrCcJvPfw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtyptg1wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:42:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UBg2CL003435
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:42:02 GMT
Received: from [10.111.170.145] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 04:42:00 -0700
Message-ID: <9108c1fc-8528-4c79-a401-a0526e7ebea6@quicinc.com>
Date: Tue, 30 Apr 2024 19:41:56 +0800
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
X-Proofpoint-GUID: ChjxlM9MfJqEZR2SGopFes0uP8vVa3LB
X-Proofpoint-ORIG-GUID: ChjxlM9MfJqEZR2SGopFes0uP8vVa3LB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300082



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

hi, kalle,
i found that ab->base_lock is used in a lot of places in ath12k, so it's 
complicated to do performance analysis in here.

Do you have any suggestions? I would appreciate your suggestions:)

/lingbo kong

>>>> +enum nl80211_he_ru_alloc
>>>> ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
>>>> +{
>>>> +	enum nl80211_he_ru_alloc ret;
>>>> +
>>>> +	switch (ru_tones) {
>>>> +	case 26:
>>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
>>>> +		break;
>>>> +	case 52:
>>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
>>>> +		break;
>>>> +	case 106:
>>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
>>>> +		break;
>>>> +	case 242:
>>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
>>>> +		break;
>>>> +	case 484:
>>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
>>>> +		break;
>>>> +	case 996:
>>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
>>>> +		break;
>>>> +	case (996 * 2):
>>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
>>>> +		break;
>>>> +	default:
>>>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
>>>> +		break;
>>>> +	}
>>>> +
>>>> +	return ret;
>>>> +}
>>> How does this function compare to
>>> ath12k_he_ru_tones_to_nl80211_he_ru_alloc()?
>>>
>>
>> ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc() is different from
>> ath12k_he_ru_tones_to_nl80211_he_ru_alloc().
>>
>> the logic of ath12k_he_ru_tones_to_nl80211_he_ru_alloc() is
> 
> Sure, I can read C. But _why_ do we have two very similar but still
> different functions. That looks fishy to me.
> 

