Return-Path: <linux-wireless+bounces-13355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2DF98B548
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 09:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FC11F22602
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ADB1A2875;
	Tue,  1 Oct 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AhBNNx7U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C93307B
	for <linux-wireless@vger.kernel.org>; Tue,  1 Oct 2024 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767084; cv=none; b=KSXhgXQgManXlWtu8+fW3df7jDp2S/fBH+Z9n9rA4y/evGkfOZN4ZAoFVvKRW1lGYc1j/nd1f27+KiU8ADnnxxDuWBWCPfVVK+gkfOKPnndrYUfIrY3aePHCnxdyeq8NqDji7tL6VRnMNU0M0/ya/nITsiBBMM/zECasFp9/l5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767084; c=relaxed/simple;
	bh=64rXMhf8mfev+EOmy6SXJuyNps6N2katv4lk9xK3b/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BQ8fjlnkoJ8sRYp4xFklImEhJI4ZtE8FZNichCDvwyly50sOYkjwJpfZSTzFWVpD9B9tRiZHZ6Ol3U/Cyp8CYi8psbPHDDnxaylWPZYgAflRjq4DgKKh4k1RMWKfGbqa/WQezXbZPIXlMAqkUjdsHNAM/Eq+L2gEEoFyHs1VXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AhBNNx7U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911J8P1028034;
	Tue, 1 Oct 2024 07:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dfXsIX7bDiQM0vDoEE1WYLH9iUJupMZDWe5xAN3clH4=; b=AhBNNx7Utb3XNFmA
	9kik8xNKd+bWjyWoBcvDDmYGtQtAjOoQQTGsvd2+71ajQ/3q9sbVNbAe1Fh0JCyr
	07UXYJ4oLEEfCKHX96tGYxMw2gCx+VpOEWUpQAh72WlGTDhRVcRRucqWfL8VFeWN
	veaRt6MhBZCyg8nn8/3Rbl/Epo60XeZbGA8s0oMKd0IxQeR56vWn/RWF7xSzcTHB
	kIZ6RNb10Zl+SZrupKVRoC1vCdAikeqkr0o3Czby6fQKJgoWROsIdcDQkGO/M1/K
	DJvOJQgLTKLFmNTOMzKguFzL05DLj061ujw5LXN351ZNaldWhM15EQ4E96aEd+Ur
	2hn3cw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xajff9c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 07:17:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4917Hrd9030654
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 07:17:53 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 00:17:51 -0700
Message-ID: <fd731cac-7182-4de3-afd4-0fc5892a9440@quicinc.com>
Date: Tue, 1 Oct 2024 12:47:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: fix assigning channel in activate links
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20241001041518.2236297-1-quic_adisi@quicinc.com>
 <0353d31db76afbd5d9bb2e7d42246ae3c8e14044.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <0353d31db76afbd5d9bb2e7d42246ae3c8e14044.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v52bT58tpK4tvN7O4Wok37kzR34qzI28
X-Proofpoint-ORIG-GUID: v52bT58tpK4tvN7O4Wok37kzR34qzI28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010048

On 10/1/24 12:01, Johannes Berg wrote:
> 
>> +		/*
>> +		 * inform about the link info changed parameters after all
>> +		 * stations are also added
>> +		 */
> 
> I don't understand that comment - you're not doing anything with the
> stations here? And per the commit log it's explicitly _not_ after doing
> the AP station. I'm not sure we should set up everything before the AP
> station?
> 

Okay let me try to explain the situation here -

In the *if (add)* block, drivers are informed about the new links added 
via drv_change_vif_links(). For drivers like ath12k, we know which link 
is changing, but since the channel contexts for the new links aren’t 
available yet, the driver can’t determine which link the firmware should 
create the interface for. This is because we have more than one firmware 
operating under this interface (grouped multiple hardware under single 
wiphy). Therefore, this notification isn’t very helpful in creating the 
link interface now.

Next, in the loop list_for_each_entry(sta, &local->sta_list, list), 
drv_change_sta_links() is called to notify drivers that the links for a 
given station (STA) have changed. Drivers use this callback to create 
the link stations after the STA has moved to the authorized state.
At this point, the driver knows which ML STA and which link STA to 
create. However, to create a link STA, the corresponding link interface 
must exist first.

Currently, it doesn’t, so the driver can’t add the link STA.

Later, in the loop for_each_set_bit(link_id, &add, 
IEEE80211_MLD_MAX_NUM_LINKS), channels are added. At this stage, the 
driver will actually create the link on the interface at its own level. 
Since here using the channel information, appropriate firmware can be 
picked. For example 2 GHz or 5 GHz or 6 GHz firmware.



>> +						  BSS_CHANGED_HE_BSS_COLOR);
>> +
>> +	}
> 
> You make it look like you just moved code but also snuck in a new blank
> line :)
> 

:) sorry about that. Will fix in next version.

> 
>> +
>>   	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
>>   		struct ieee80211_link_data *link;
> 
> I also think you put this code too early now - you're now first using
> more channel contexts by way of _ieee80211_link_use_channel() before you
> even release the ones from deactivated ("rem" bitmap in this code)
> links. That doesn't seem like it could work correctly in general.
> 

hmm... yeah true that. May be I will move this once the old links are 
removed?

-- 
Aditya


