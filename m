Return-Path: <linux-wireless+bounces-15538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD50B9D4647
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 04:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72986B220D8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 03:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174023098E;
	Thu, 21 Nov 2024 03:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LdptRzoA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093673C0B
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 03:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732160145; cv=none; b=I823xiCJP+HEsapMjaXMwz7u3cltNAR9vq7H7CJ6jjMhPM9qtXmcYef1F69I7EuR8ZWUgjsfyvy5PCA7aPOVxaNnSlC1SUW808yaUb8ixMKdv6ELp5gXpNr/0DFBcCa8eEHf2jBxfBCyh6Xa5/BukOzraGqeXc84iyh85LLsHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732160145; c=relaxed/simple;
	bh=pDom7ERUnZqM+DSI4Rzx0olqcew7A9R1UTRte+4aAX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QPDBbHN+XqdlrBHlrnuzkOW05RPEG3Psa+uc05w9yIenQjX8kOZwjMJZwzmzyzg1u6KOU1jjGv6ZOQbpWXJQQxQcukVsjIt6HoPMHSIcJixGdkqZGi18FpTP1xhmGabg5Jpgbn94vrKrA8E5bxkETUoeJOkSD54i3GxFnp28d44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LdptRzoA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKNtHdI020236;
	Thu, 21 Nov 2024 03:35:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uaYMoYxnGRA6YNHgnvWk2AVoYTu+FEc7aPAWZBWd1Bc=; b=LdptRzoAfDqYDYlu
	hkY1vDOG8/kBt2Jp592H/K1l9/Nb21JwJYcJvOuOeB8c1UAmRnfqdDrvXB8M4pRg
	C5CQsEX9DntuLgVWPahDBYi+74pW7dk5mm3AzIgmFe38to0AquBa8asJqal9MKJ6
	60fCwlKZ2j9vBT1JpcdOq8wZ9xFXUxWDvsvf0EW/vmWVa4D5c8i/5o+ufbOiXhX3
	QKyL80gVp0TjQfYCZ8EyIjxoh6eSPc/sW3wRvuUJyV6WUSr/OPb6CEnV/g5pNMP9
	UL/iOkavM1sUdz8zTwUO0PgqePr29L0afW+kebQDlXavG4PD8LD+s9NKNhggkJql
	6P7EMg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 431sv2gd20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 03:35:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AL3ZYl1013981
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Nov 2024 03:35:34 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 20 Nov
 2024 19:35:33 -0800
Message-ID: <d7a0d62c-4723-4e9f-a362-2ea51aaba3ed@quicinc.com>
Date: Thu, 21 Nov 2024 11:35:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] wifi: ath12k: Add MLO station state change handling
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20241106142617.660901-1-kvalo@kernel.org>
 <20241106142617.660901-2-kvalo@kernel.org>
 <2e706d58-5d83-4867-9963-c62441cdd4da@quicinc.com>
 <87y11o2x9h.fsf@kernel.org>
 <97f3f465-6ebd-4ca1-b672-4c8c7f42220d@quicinc.com>
 <87bjy9zonx.fsf@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <87bjy9zonx.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3xKTtRPcvfTI5lpF338KOlyKuMoSNQPp
X-Proofpoint-ORIG-GUID: 3xKTtRPcvfTI5lpF338KOlyKuMoSNQPp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=771 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411210026



On 11/21/2024 3:32 AM, Kalle Valo wrote:
> Baochen Qiang <quic_bqiang@quicinc.com> writes:
> 
>>>>> +static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
>>>>> +					      struct ath12k_sta *ahsta,
>>>>> +					      u8 link_id)
>>>>> +{
>>>>> +	struct ath12k_link_sta *arsta;
>>>>> +
>>>>> +	lockdep_assert_wiphy(ah->hw->wiphy);
>>>>> +
>>>>> +	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
>>>>> +		return;
>>>>> +
>>>>> +	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
>>>>> +
>>>>> +	if (WARN_ON(!arsta))
>>>>> +		return;
>>>>> +
>>>>> +	ath12k_mac_unassign_link_sta(ah, ahsta, link_id);
>>>>> +
>>>>> +	arsta->link_id = ATH12K_INVALID_LINK_ID;
>>>>> +	arsta->ahsta = NULL;
>>>>> +	arsta->arvif = NULL;
>>>>
>>>> if arsta is not deflink and would be freed, can we avoid these
>>>> cleanup?
>>>
>>> I think that's something we can cleanup later if needed. Sure, it's
>>> extra assignments but it's not really doing any harm.
>> exactly, but ideally we should avoid unnecessary effort if possible.
>>
>>>
>>>>> +	if (arsta != &ahsta->deflink)
>>>>> +		kfree(arsta);
>>>>
>>>> I know the actual free happens here, but why split them?
>>>
>>> You mean why have a separate function ath12k_mac_unassign_link_sta() and
>>> instead just have all code the in
>>> ath12k_mac_free_unassign_link_sta()?
>>
>> yes. such that we can have synchronize_rcu() and kfree() located together.
> 
> Ok, I think I now get what you mean. Does this look better:
> 
> static void ath12k_mac_free_unassign_link_sta(struct ath12k_hw *ah,
> 					      struct ath12k_sta *ahsta,
> 					      u8 link_id)
> {
> 	struct ath12k_link_sta *arsta;
> 
> 	lockdep_assert_wiphy(ah->hw->wiphy);
> 
> 	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
> 		return;
> 
> 	arsta = wiphy_dereference(ah->hw->wiphy, ahsta->link[link_id]);
> 	if (WARN_ON(!arsta))
> 		return;
> 
> 	ahsta->links_map &= ~BIT(link_id);
> 	rcu_assign_pointer(ahsta->link[link_id], NULL);
below synchronize_rcu() should be moved to here, such that any change to arsta can happen only AFTER all existing RCU readers finish accessing it.

> 
> 	if (arsta == &ahsta->deflink) {
> 		arsta->link_id = ATH12K_INVALID_LINK_ID;
> 		arsta->ahsta = NULL;
> 		arsta->arvif = NULL;
> 		return;
> 	}
> 
> 	synchronize_rcu();
> 	kfree(arsta);
> }
other than that this change looks good to me.

> 
> BTW your lines are really long, please check your settings:
sure, will check.

> 
> https://patchwork.kernel.org/project/linux-wireless/patch/20241106142617.660901-2-kvalo@kernel.org/
> 


