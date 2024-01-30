Return-Path: <linux-wireless+bounces-2753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226AF8419B5
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 03:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20ADB24CAD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594536AFD;
	Tue, 30 Jan 2024 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g0wq+vjn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282936AE9
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583444; cv=none; b=nVcE4wCfiGV37qtbQu1PWbOg5+NxKMd66FPXJdP5AbBKnHZ7dcGxkFfCWY5OJWxM5V0qzJH5SYY8QpUA341nBf6PRPhH/j3strMRC/xqzFimfkOxTetv2Bkgp/HXHGl7f0CfW2VtAu7NcPLV19nmzcjPQXEhCYGUHE+rYx6iHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583444; c=relaxed/simple;
	bh=7JReeC0bPiFDOd7+qnpuR+kBa9imTY0cdcx/u3X0t3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VaUQGKxTGyIbnThOSabVK0mFp/pu9+9b1a6I2bzDHKS6Kiyq5QAxgDuPJoLlZNiuNZqEcrTjC/NZzXV8fUXEbfbo0yShPLjy7be9immRay4uHhT/WVVWSEWtrFlgw8kOmgH9TT5tt4dw57pgGQwvpXcK3a2agfNjd6YEgC7LEfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g0wq+vjn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U1NP3k007692;
	Tue, 30 Jan 2024 02:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RAw8B6jVf2iGsoPqiGaHEJHyjCd9av1iF+By0ej4D3w=; b=g0
	wq+vjnGU0siQV+0wNxBJd9JJ61il5FQ5uLjM0wrWXaJA+ko01Yw+PbEgmZzYnPTo
	+ZzO0T55tkne6+lEXh8Ptckf0jm8DPoECEfwRT1pSBnj/fgCKRBwbxt52HZTD1Bk
	0czl39TS8jyKUWlQKPypIwXZ2Cf6BoNLwv+zzXQ7HRpE0CgPurQj8fc0PsNGzp3D
	qSCQAld8VqwFb1ZKV6w8zDKQsr9aIHuHPdnMGssX4LoQfep6gSp9bSdJEqWqCAPP
	rRpUw9z1R2pffX0uvbU+YCbHcbzDVudwz0XTbcWHLVPe3tSb0tRYMnu5zs2sGws4
	kEPiIKugGRugM8hK2dRw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxexr97nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 02:57:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U2vJEx006112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 02:57:19 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 18:57:17 -0800
Message-ID: <2fde6ec0-7149-4a31-b9c1-cba9121ceea3@quicinc.com>
Date: Tue, 30 Jan 2024 08:27:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] wifi: mac80211: add support to call csa_finish on
 a link
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
 <20240129052832.905113-6-quic_adisi@quicinc.com>
 <a20310f8-bf6a-4823-8302-e45944f06f74@quicinc.com>
 <f03b0e3d-c4fe-442d-a8b6-d84deeed4337@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <f03b0e3d-c4fe-442d-a8b6-d84deeed4337@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2-Em8zlaRykj9l7uppsbPLRNgciUQ2MS
X-Proofpoint-ORIG-GUID: 2-Em8zlaRykj9l7uppsbPLRNgciUQ2MS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300020

On 1/30/24 07:24, Jeff Johnson wrote:
> On 1/29/2024 5:31 PM, Jeff Johnson wrote:
>> On 1/28/2024 9:28 PM, Aditya Kumar Singh wrote:
>>> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
>>> index 4427259154e2..a1a4f100d128 100644
>>> --- a/net/mac80211/cfg.c
>>> +++ b/net/mac80211/cfg.c
>>> @@ -3543,13 +3543,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
>>>   	return new_beacon;
>>>   }
>>>   
>>> -void ieee80211_csa_finish(struct ieee80211_vif *vif)
>>> +void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
>>>   {
>>>   	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>>>   	struct ieee80211_local *local = sdata->local;
>>> +	struct ieee80211_link_data *link_data;
>>> +
>>> +	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
> 
> let's try that again, shouldn't the test be > = ??
> 

Yes it should be. I will fix this in next version.

>>> +		return;
>>>   
>>>   	rcu_read_lock();
>>>   
>>> +	link_data = rcu_dereference(sdata->link[link_id]);
>>> +	if (WARN_ON(!link_data)) {
>>> +		rcu_read_unlock();
>>> +		return;
>>> +	}
>>> +
>>> +	/* TODO: MBSSID with MLO changes */
>>>   	if (vif->mbssid_tx_vif == vif) {
>>>   		/* Trigger ieee80211_csa_finish() on the non-transmitting
>>>   		 * interfaces when channel switch is received on
>>
>>
> 

