Return-Path: <linux-wireless+bounces-19717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8EBA4C671
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 17:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4007189ABE1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 16:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF461215065;
	Mon,  3 Mar 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VqXVI3nd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC9213E67
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018071; cv=none; b=lD/w/PUhC1ova9s7oeWZv9eNH73uJVnpsg70rOjxXUZb5bmeK67uwZBkpbBMwBd8fowx79ytXP+Lk8Yvhc2PpdEFMRPQmVSj0gYPEe0GoVLKUAZJhCg9+IlmOUFBLenFi4SIdj8JGwc9uhdKJLC2LTvKD6AU4h7dO047negPThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018071; c=relaxed/simple;
	bh=pr8OmdHvv54CYnBx6xwUnrG+HwfXr5zmcgPBpWBNh+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZIl1QKKd0O67V2VbG94DLPubclOD0zOopvR1/BCADs+cN9bu129FrhY+gWhdXLBzf7qjfuZyUbbUzak81Xc5L/R0BcxbUhhk356EkEnJ9nw0vgPoa8CJb5O44um9lmj2vkDZPJA1VIPADy3jo2dJwuyhDC1hoKX4fNND+mTHB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VqXVI3nd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523BCu2u025618;
	Mon, 3 Mar 2025 16:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8aguj+DouiTDz86DITOeENQzEs5tk7VT06PcNWaFf2Q=; b=VqXVI3ndU2KRhL7k
	g2OF+n5KFYOvMdFpj/YNuGyl6EvKY+urmiSydZjTWAEP0/wnRY0mHeUPr0j7sYvy
	0gAdLuWmWMYjCRj1rF2wkSQAeRPdXdYfED+Qtst0M4Sk5NttZZ1aeaPy2akg+CPJ
	vBFmYFUwBL69EQzx6x2awTUqWVoLfpFqlOLfyHMNaFLQyrYTISmFwCvwgySLAsOB
	FZiufiJ7MSmRZG2O78sS0wPfbm5hWOrrApfMEWS9at9KGigP2yNWVVt6O7IXQFH5
	WuJkP+lO4yg9pTBYcqdONw2VP7Q1TUvNw8ovcNObveBoTg1BcjZsWrVzPOe12/ST
	ii/eJQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k586p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 16:07:45 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523G7iWx020757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 16:07:44 GMT
Received: from [10.50.29.230] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 08:07:43 -0800
Message-ID: <e989f3fb-4fa7-4839-9b98-d9a8c7341b1d@quicinc.com>
Date: Mon, 3 Mar 2025 21:37:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] wifi: cfg80211: extend statistics for link level
 in sinfo
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
 <20250213171632.1646538-8-quic_sarishar@quicinc.com>
 <6c6be5e9552d32d0598af6aee55ceae450209f7e.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <6c6be5e9552d32d0598af6aee55ceae450209f7e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EWQFBZPZWcwRcXTNNv9lpzjfSZnp4PJI
X-Proofpoint-ORIG-GUID: EWQFBZPZWcwRcXTNNv9lpzjfSZnp4PJI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030123

On 2/28/2025 6:51 PM, Johannes Berg wrote:
> On Thu, 2025-02-13 at 22:46 +0530, Sarika Sharma wrote:
>> Currently, statistics is supported at deflink( or one of the links)
>> level for station. This has problems when applied to multi-link(ML)
>> connections.
>>
>> Hence, add changes to support link level statistics in sinfo structure.
>> Additionally, remove mlo_params_valid from the sinfo structure and
>> add valid_links to indicate bitmap of valid links for MLO.
>>
>> This will be helpful to check the link related statistics during MLO.
>>
>> The statistics could be embedded into NL message as below:
> 
> "could be"?

Oops, sure will change it to "will look like"

> 
>> For MLO:
>> cmd ->
>> 	NL80211_ATTR_IFINDEX
>> 	NL80211_ATTR_MAC
>> 	NL80211_ATTR_GENERATION
>> 	.......etc
>> 	NL80211_ATTR_STA_INFO | nest flag
>> 		NL80211_STA_INFO_CONNECTED_TIME,
>> 		NL80211_STA_INFO_STA_FLAGS,
>> 		........etc
>> 	NL80211_ATTR_MLO_LINK_ID,
>> 	NL80211_ATTR_MLD_ADDR,
>> 	NL80211_ATTR_MLO_LINKS | nested
> 
> you're being inconsistent with "| nested" and "| nest flag" but I'm not
> sure it's necessary anyway?

No, it is not necessary, will make it consistent.

> 
>> 		link_id-1 | nested
>> 		NL80211_ATTR_MLO_LINK_ID,
> 
> And that should be indented further, perhaps? Maybe not use tabs then
> but just 4 spaces or so :)

Sure, will correct it.

>>
>> Station 00:03:7f:04:31:78 (on wlan0)
>> 	authorized:     yes
>> 	authenticated:  yes
>> 	associated:     yes
>> 	preamble:       long
>> 	WMM/WME:        yes
>> 	MFP:            yes
>> 	TDLS peer:      no
>> 	connected time: 383 seconds
>> 	associated at [boottime]:       93.740s
>> 	associated at:  93685 ms
>> 	current time:   340046 ms
>>          MLD address: 00:03:7f:04:31:78
> 
> the indentation seems odd, but maybe that's just a copy/paste thing?

Sure will check this.

> 
>>          Link 0:
>>                  Address: 00:03:7f:04:31:78
>>                  inactive time:  330120 ms
>>                  rx bytes:       116
>>                  rx packets:     3
>>                  tx bytes:       0
>>                  tx packets:     0
>>                  tx retries:     0
>>                  tx failed:      0
>>                  rx drop misc:   0
>>                  signal:         -95 dBm
>>                  tx bitrate:     6.0 MBit/s
>>                  tx duration:    2669 us
>>                  rx duration:    0 us
>> 	        DTIM period:    2
>> 	        beacon interval:100
>>          Link 1:
>>                  Address: 00:03:7f:04:31:79
>>                  inactive time:  81268 ms
>>                  rx bytes:       1323
>>                  rx packets:     12
>>                  tx bytes:       1538
>>                  tx packets:     8
>>                  tx retries:     0
>>                  tx failed:      0
>>                  rx drop misc:   0
>>                  signal:         -95 dBm
>>                  tx bitrate:     6.0 MBit/s
>>                  tx duration:    2669 us
>>                  rx bitrate:     6.0 MBit/s
>>                  rx duration:    0 us
>> 	        DTIM period:    2
>> 	        beacon interval:100
> 
> This looks like it's missing the roll-up to the global counters and
> timestamps? Why would that not break backward compatibility?

For non-MLO it will not effect, for MLO I have added accumulated stats 
for packets, bytes and signal, rates at mld level.

For inactive time, DTIM period, beacon interval can I add least of the 
values among links ? and add as a separate patch?

> 
>>   static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
>>   {
>> -	if (sinfo->links[0]) {
>> -		kfree(sinfo->links[0]->pertid);
>> -		kfree(sinfo->links[0]);
>> +	int link_id;
>> +
>> +	if (sinfo->valid_links) {
>> +		for_each_valid_link(sinfo, link_id) {
>> +			if (sinfo->links[link_id]) {
>> +				kfree(sinfo->links[link_id]->pertid);
>> +				kfree(sinfo->links[link_id]);
>> +			}
>> +		}
>> +	} else {
>> +		if (sinfo->links[0]) {
>> +			kfree(sinfo->links[0]->pertid);
>> +			kfree(sinfo->links[0]);
>> +		}
>>   	}
> 
> Don't be so complicated ... check what "for_each_valid_link()" does if
> valid_links is 0.

Sure, will check and update accordingly.

> 
> johannes


