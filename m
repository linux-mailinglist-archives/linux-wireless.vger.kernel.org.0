Return-Path: <linux-wireless+bounces-30724-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F40CD16983
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 05:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F25030191AB
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 04:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3B3093C8;
	Tue, 13 Jan 2026 04:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ohrrup91";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BkAlD956"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F51302779
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 04:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768277264; cv=none; b=KUjvwYhK2YJ14DdKCe4YUrYUttnfmKM14SsHJiqWQBml77kmLVC2S21tnoqQ+EKIhhkgCtysfvxX4qfhGUnRwEQ8aT7jAOjBDkJ+l4lk56GztYoD4f8spQaurUsQMcOYBFHFmFIDjtzb3L/ac59AGzq1X+7TY7Y38FmnSHpgWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768277264; c=relaxed/simple;
	bh=ws5eVQwcw9yHL+j6c75y2I4TE12vOwLb1jSX+yJu5tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+l4Yf0ftuCDR0YMTi81OOv6KOWDPwetFFCU7a8SvCg29+2aNIH4abfPYwWQKBKjYbeg9Oe/bRpa9f4ohhFcwFpEih3vQTqTNBBxCf4Ck+HL3b3/SyHSOyE6PWXpfyMr9xXMCSBV1h/WDtwvA3vVrO8/34xWoncwU20I3rts9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ohrrup91; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BkAlD956; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60CN528T2965337
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 04:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3rBuiiRGgkg+AggiUHY29UPHBE8LJBhVWcKyamRUq0=; b=ohrrup91drXEOU4W
	w82DvFhddqqhw9NVIe4wD82vD3KvngZGNTCs7mLJ1nEKg8kKNKyJ++jcxT5MNNyH
	p/gM0giBvWIzydLXGXtxk8UafYgBg6o8fWlgfAiDXFkOMx9nBQYts3c2tCdPBX33
	dKGxX8CMBzI9xbejpgheat/wzOCNPr4PsJTVh7e3Tg65f8bdqAQHstksquhQWBXP
	aK28B1icJQ5z8aae2og/SQpP+cznjkFncdP6qmATL89szFnfU2k++j79KFFJX+2H
	XD9mXVN3W5hRf1qlGpxTXaXnWKh/5r1LVWCZcMR2BwL8TluorFZxv5b8ls7iMTNd
	SZ/kLA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmy1hk06d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 04:07:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34aa1d06456so8565973a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 20:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768277261; x=1768882061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3rBuiiRGgkg+AggiUHY29UPHBE8LJBhVWcKyamRUq0=;
        b=BkAlD956lTFL2YGwN8Mv3kU1wTSk2FmlIHy7oW9p4lBLDOyI5hUy30wTeRnPXxfVyy
         6v+IFqazMJC0qAFO4+Fmzk0Arp2cB82wjw+d7mUX2l3lKD2sK9hgd76w2+vl8VeLIYY+
         NC1g+ExIr91NoYPOjSRtyeLP3T5+tAiGzY2gIjj8cZD6sjN3YGdQxTyNdGDGIq9QJK9I
         hY6rcld6cKLeEfLLXJ7UG6qQEuLQTresec4oCMHf5TE3p6UEFfT47i3Fqpb2iqa2Cusv
         2wXQVB//BXkjYk94lALlb0LHntgl2AGlcsoEs068FdXLbtsABvwDv75MwAB/iYgGaNx3
         YPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768277261; x=1768882061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3rBuiiRGgkg+AggiUHY29UPHBE8LJBhVWcKyamRUq0=;
        b=t94+Jvq5vPN8yJkUsDQBLD2pPETNQE3tK8Tmx2Gc2slPvEfaPtcARpGad39Ziomwm6
         FFJUh+8d/uISxG/JoPyWVNcrTaX56Px1pq6BrF5HsfxOXKP/J75CyUgCEo74LQLE7y7t
         mUo86czITo922tJdzHKcsQaj3CAYJ8EdfVXCaRubt7rEdPj+cbVUHmkLHfw+GjC1Y+EI
         2ppk7ulza1C5/DVqsfOpp199p3kxPbeWVNT61jNSMZZwiGCP6KROHlWAjVYkvqbLwnox
         PM3iuniqPyGT1kz7MNPMscFHjqlNuYiltFri/7Qhl3BNcdMlD3nMvI34fhkh5lNckWri
         8vAg==
X-Gm-Message-State: AOJu0YxkTQAx69tCJIKnM31f/ZvGc4Ui0JPbEJ8zgW35JroD2Vh0aRcG
	XZrhWVvgZ7ANn893EDMJxnUZjimUy100WldKlDKq4jmv++jH/6vXpiL6Agi2WUu9nq0chAb23eq
	IGryTfHJ+1l3HCdr9TMnRoQFJl33o2cuSZolyoVMLfS34s8sIIHH5Xh0kvbF45BY1vNZsMQ==
X-Gm-Gg: AY/fxX68ZfxE7TLLZc4088aXMxFv6ZTPvW/fvnJklDD8zok3DtMavne2bpkiI/2V0Uf
	Rsolkoe2VgrWnrADWCFu7B73NsCv+y1oe3HP1rTYh4Vkca+ib+l+7iJDGdar6ry3uTKBBNxrzWC
	j+/06FJMJRbt1SPYKcxDV2/Bty3OhaOsrRCdH6v/Fd8a2Ug+BMxDWCOcPU37uheVLPFK3VHUgXN
	e35dDEcbiUkGcuKJonaNtOcspAHVWFBWSgc6aB68PhdOc6xh7+UxlYYY4pfDpedGkLwQM+FNVJq
	/Mn5JdxZVRzum5wnGDbzK7Evq0JiArlPyLZAryT5TT5SXDjIFO6xhqwk5kKwqEzGlNOzGiFKQ5U
	dytoiFfEIz1cW4pD3hVEoAp7wJfKuJ0PVrA==
X-Received: by 2002:a05:6a20:7486:b0:35d:bb66:5ce3 with SMTP id adf61e73a8af0-3898f8f54f0mr21641604637.12.1768277261366;
        Mon, 12 Jan 2026 20:07:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWvPKlqqghMEOTWzh23AfldM6ERCnZL8+D9gRrokyIJSIscgZvxLTaNTBoL1SpMZB3CUXFYw==
X-Received: by 2002:a05:6a20:7486:b0:35d:bb66:5ce3 with SMTP id adf61e73a8af0-3898f8f54f0mr21641575637.12.1768277260820;
        Mon, 12 Jan 2026 20:07:40 -0800 (PST)
Received: from [10.151.41.62] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc794asm187410395ad.70.2026.01.12.20.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 20:07:40 -0800 (PST)
Message-ID: <036322aa-0c90-4735-88cf-76fa831a9ec3@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 09:37:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 4/9] wifi: nl80211: Add new NL attributes
 to support (Re)Association frame encryption
To: Johannes Berg <johannes@sipsolutions.net>,
        Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ainy.kumari@oss.qualcomm.com,
        quic_drohan@quicinc.com
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
 <20260106152503.223216-5-kavita.kavita@oss.qualcomm.com>
 <16099966d1cbdccc5160c6aa7a2615dcfd0060d6.camel@sipsolutions.net>
Content-Language: en-US
From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
In-Reply-To: <16099966d1cbdccc5160c6aa7a2615dcfd0060d6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 0DwMaoMDryY-C5s4OLouuPiixlqE92AP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDAzMSBTYWx0ZWRfX2m3RR2Yc/PQN
 YiQW5Vd1VWPlaP5N7igp2+hdkhyrYyx9kiJQWzxOzjuqcjo2EEcFJWQUD8AWNpeA0ABGXfPv8b8
 T9zWHMCoDwJ37KNNSZjIAMRR+uyZEfQZkEhyGIlcc6x68IuKB9TV3QZ6hvJKmSDgKpx9Wqh9fYV
 lzLnLENGiaItSKdzCnSz+0h1dJeubAtLJMl0Bzl6UV75T4POxF6fdbMIeZTG1MokTRBYr/tJKg3
 BclmPoXjD/RtRV5r9Y2Qw4avlahq0ZlLddzB/HK+JFRAG2R+QFgkv+5CevJHxz9a76CCe+O9FYf
 l1kdLWI7LI1ktVoiA4xSTYJpSTKEMZxf6PTYaULPrcHV3SEV1mH5932RdLox+p53Ts6MshwN5kk
 cP7hmaTsv5UDb1/x4IXH0I+J+mI064tcOPppHh+uGs8MiBuMgnW98yrO17OUSjqC8UevlbywypR
 f5bJNKl4RKqwmrynzvQ==
X-Proofpoint-ORIG-GUID: 0DwMaoMDryY-C5s4OLouuPiixlqE92AP
X-Authority-Analysis: v=2.4 cv=EovfbCcA c=1 sm=1 tr=0 ts=6965c50e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UhqzNUQlgaDtkgeahTkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130031



On 1/8/2026 6:12 PM, Johannes Berg wrote:
> On Tue, 2026-01-06 at 20:54 +0530, Kavita Kavita wrote:
>>
>>   include/net/cfg80211.h       |  5 +++++
>>   include/net/mac80211.h       |  5 +++++
>>   include/uapi/linux/nl80211.h | 26 ++++++++++++++++++++++++++
>>   net/mac80211/cfg.c           |  6 ++++++
>>   net/wireless/nl80211.c       | 10 ++++++++++
> 
> You should split this patchset differently so you don't have this mix of
> cfg80211/mac80211 here. Perhaps this patch becomes two, or perhaps it
> all goes into two other patches, dunno.
Thanks, I will move the mac80211.h change to one of the existing patch

> 
> The subject also seems confused - why is this about the encryption of
> certain frames? It doesn't seem to be doing any such thing at all?
Thanks, will modify the commit message

> 
>> + * @epp_flags: Negotiated EPP capabilities
>> + *	(bitmask of BIT(%NL80211_EPP_FLAG_...))
> 
> All of this along with the nl80211 API isn't used, and the small commit
> log blurb about it:

It is right that mac80211 is just storing the the epp_flags received 
from user space. They were added as placeholders to hold the bitmap of 
the Extended RSN capabilities that are negotiated with an EPP non-AP 
STA. The main purpose of storing these flags in the station object
is for them to be read by the driver and use them.

> 
>> The Extended RSN capabilities for EPP that an EPP AP and an EPP
>> non-AP STA can negotiate are as per "IEEE P802.11bi/D3.0, 9.4.2.240"
>> (RSNXE), few of which are driver dependent, hence need them to be
>> communicated from userspace for later use.
> 
> really doesn't make it clear why that should be maintained. Sure support
> is driver dependent, but obviously you already have the extended feature
> bits from patches 1 and 2.
Patch2 is the device self capability, i.e whether the device supports
(Re)Association frame encryption or not. epp_flags is to maintain the
negotiated capabilities

> 
>> +++ b/include/uapi/linux/nl80211.h
>> @@ -2973,6 +2973,13 @@ enum nl80211_commands {
>>    *	primary channel is 2 MHz wide, and the control channel designates
>>    *	the 1 MHz primary subchannel within that 2 MHz primary.
>>    *
>> + * @NL80211_ATTR_EPP_PEER: A flag attribute to indicate if the peer is an EPP
>> + *	STA. Used with %NL80211_CMD_NEW_STA and %NL80211_CMD_ADD_LINK_STA
>> + *
>> + * @NL80211_ATTR_EPP_FLAGS: A (u32) bitmap attribute to indicate the negotiated
>> + *	EPP capabilities of an EPP AP and an EPP non-AP STA. See
>> + *	&enum nl80211_epp_flags for details. Used with %NL80211_CMD_SET_STATION
> 
> My preference would be to remove the FLAGS, but if you can convince me
> that it's needed (and as you know I care very little about non-upstream
> drivers) then still this really ought to just have a single attribute
> and the mere presence indicates EPP support with the flags inside (or
> non-zero flags indicate such, though I prefer to not allow zero flags
> since then it's not EPP?)
EPP flags contain the negotiated per peer Extended RSN capabilities.
11bi Specification has introduced many of them as per IEEE 
P802.11bi/D3.0, 9.4.2.240. Since few of these Extended RSN capabilities 
are driver dependent and hence need to be communicated to the driver for 
future use, which would subsequently be implemented. In case your 
guidance is
to remove the epp flags since only one is used((Re)Association 
Req/Response frame encryption) currently, I will do the required 
cleanup. Just wanted to give a background on why this was maintained as 
a bitmap.

> 
>> @@ -8416,6 +8418,10 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
>>   			nla_len(info->attrs[NL80211_ATTR_STA_EXT_CAPABILITY]);
>>   	}
>>   
>> +	if (info->attrs[NL80211_ATTR_EPP_FLAGS])
>> +		params.epp_flags =
>> +			nla_get_u32(info->attrs[NL80211_ATTR_EPP_FLAGS]);
>> +
>>   	if (parse_station_flags(info, dev->ieee80211_ptr->iftype, &params))
>>   		return -EINVAL;
>>   
> 
> Are you sure it needs to be _changed_? Since EPPKE is an authentication
> algorithm hostapd should know early?
> 
> But I'm not even sure how the assoc frame encryption flag makes any
> sense at all, seems that ought to just depend on whether or not keys
> exist.
> 
> johannes


