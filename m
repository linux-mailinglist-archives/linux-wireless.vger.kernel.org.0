Return-Path: <linux-wireless+bounces-10184-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073E92E357
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 11:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A979E1F236AB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jul 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3011527AA;
	Thu, 11 Jul 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pvJ+yzww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3EA14F111
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jul 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689675; cv=none; b=U/TDMDLaWfW6t2T2/UaSdo8V1+PW8yAj256yvtOGeJ4tHV/seT2svkduNRe3M9KntH7nr0AHb7brmIFzCzUYkjZlqFVvxNCke8gmpMqqSNG2+hLrfogW4eaJwjs1LrO7yzM3LaWVwvCeL4kQtoRAgzXHsNLLMpf1ji0+ypFhMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689675; c=relaxed/simple;
	bh=O404L0wpDIJz1wjPySd5rIfC8dmbpJ3JQq1eHyfoEes=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d/2hp2eT4AI70z38T/AnPtokVZIcGgK2PE72wGOVU1ESsLavpmz2NIpd0VrwneMsR83KJbxtNc2HPArPpM8WADCK+tM1PrA6ujkVZgNsNpqDElLdaSoz9EgPPnVGKBEWtQ/+HGxh286DN5ep9TzSZRD80KRfnA2mKTVqkGPbr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pvJ+yzww; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4nNlM025894;
	Thu, 11 Jul 2024 09:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNieUMqN0snAT6hrFY7YK5lWcSaIFK4uNYwla/Sy8S4=; b=pvJ+yzwwZLLVgvoF
	PLeV2dPv1KupFq/frFUdm/6HtYI2mNEZ3exjdFt3PODzAnQ26NZ2mUgkex58jXkF
	J8uBJP8Shokarxm+6x9yqZSH+xnIyuzwzAMc4nthiPN0b+OXaFb17U28gaYX41pG
	x8yPTOyHDUUKHQW6KolnNjmFf/jjv5FQ6kqrUpJEvweoGv8vlBu6hULY6J3Q6I3u
	9W/0TRMDDYHHqcTTpNuWbQXLJh4n9kJMxNhAIB7fitEYB63X3B+9Y4Lv5n6+vlTB
	1t/7QPCNe90TElKtnewptLKRJUP2iwrgfgOI7rVTeCf3FQzALsM03KQNES3Kd1+e
	nS6IIA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x0tc45g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 09:21:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B9L58b002583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 09:21:05 GMT
Received: from [10.216.36.217] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 02:21:03 -0700
Message-ID: <76a05021-c5aa-400e-a8d1-517fbce9e314@quicinc.com>
Date: Thu, 11 Jul 2024 14:50:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240709120659.1564434-1-quic_ramess@quicinc.com>
 <20240709120659.1564434-2-quic_ramess@quicinc.com>
 <a04ecf46-39d9-4785-824c-c53c17362abf@quicinc.com>
Content-Language: en-US
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <a04ecf46-39d9-4785-824c-c53c17362abf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kv-eYxZhEAumTK5rAZ2xgUJ9L1qh2agD
X-Proofpoint-ORIG-GUID: Kv-eYxZhEAumTK5rAZ2xgUJ9L1qh2agD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110066



On 7/11/2024 10:56 AM, Jeff Johnson wrote:
> On 7/9/2024 5:06 AM, Rameshkumar Sundaram wrote:
> ...
>> @@ -4569,12 +4685,17 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>>   				   enum ieee80211_sta_state old_state,
>>   				   enum ieee80211_sta_state new_state)
>>   {
>> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>> +	struct ath12k_vif *ahvif = ath12k_vif_to_ahvif(vif);
>>   	struct ath12k *ar;
>> -	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>>   	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
>> +	struct ath12k_link_vif *arvif;
>>   	struct ath12k_peer *peer;
>>   	int ret = 0;
>>   
>> +	mutex_lock(&ah->conf_mutex);
>> +	arvif = &ahvif->deflink;
>> +
>>   	/* cancel must be done outside the mutex to avoid deadlock */
> 
> this is now inside the ah->conf_mutex -- is that ok?
> seems this comment should be updated to explain *which* mutex(es) the cancel
> must be done outside of?
> 
ah->conf_mutex is not acquired in ath12k_sta_rc_update_wk() so cancel 
work will not result is lockup here.
Will update the comment with lock specifics.
>>   	if ((old_state == IEEE80211_STA_NONE &&
>>   	     new_state == IEEE80211_STA_NOTEXIST))
>> @@ -4583,9 +4704,9 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>>   	ar = ath12k_get_ar_by_vif(hw, vif);
>>   	if (!ar) {
>>   		WARN_ON_ONCE(1);
>> +		mutex_unlock(&ah->conf_mutex);
> 
> unlock before the WARN -- the WARN is not part of the critical section
> 
Sure, will change this in next version.
>>   		return -EINVAL;
>>   	}
>> -
>>   	mutex_lock(&ar->conf_mutex);
>>   
>>   	if (old_state == IEEE80211_STA_NOTEXIST &&
> 

