Return-Path: <linux-wireless+bounces-34031-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP6zCVpLxmmgIAUAu9opvQ
	(envelope-from <linux-wireless+bounces-34031-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:18:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A39341999
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5134C3059F1D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158811E868;
	Fri, 27 Mar 2026 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DbO2qDvd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TQoa5nXu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823803DA7D2
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602699; cv=none; b=sOhY1Qoxy2NQPxwzwaEPTGrm7tltyEl873aOI+ItPct22ix3+1ZoKdKJ0vvFoHRUxTwmzu0PfzUWYNlrkrDM5G5fmyuxKBeORmGF+WGnjuZeKKUMILuh1ye6PqSqoPfhFsZqBLS+1rBYiuus2XAjJi0Opqp33QjXezd8TLroDiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602699; c=relaxed/simple;
	bh=SsSuYJBUW1B2zJrKatRsoKYVlhhBCFYOsypFHdGXHao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rL14Gz7i3XA6U/SPEaL9nIHBLbZQWoj6rJQieebWMt2psF02ADekgJ66PgqBzqHbkGWw+YJ3AciQjovcJqnjH5fIEXUimkxdiUwwJvuxc0L9G7CZhBj/b6PqK5Fcf0/DC2QGyggW96R15IvFbMxwh6MBkW/MCz09SlBMt2xCfYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DbO2qDvd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TQoa5nXu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R6w3M33714190
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NzoqoXYuQZaBqV4FD+jiduVh3IufY7bkrQbuM50HkeE=; b=DbO2qDvd7gwlYS/D
	St0Cwy5JmAxHk+BDotz4ZwZAEyiIZJZqQ803NItnERBl19mJvFh74ndAkoMgDqsb
	DzNQSY7Yz08crafp3EN50041qVg48RlrYDfXzR4vYjR3s5Vphg9EVtQhpZI3mptk
	ROduYZ+A8EENAe/uMPtNDvk2czv+lPerHlhjhq/JJG8uZsiQghOLCm66yklbcnay
	vDjYKEYfFHBxzcU1iK0CRtlPNxucZmTJpg113NR6X9REQ4RHnMyrrNNqcLU0HGUl
	B4k3AL9/5mxBf+R5875YGn3fWB1pnLkeLpFKQdUKZNAsUUEeXbIY9y4OaYJe7rhl
	vieJJw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5hapsdax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:11:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35c1107da15so305297a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 02:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774602697; x=1775207497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NzoqoXYuQZaBqV4FD+jiduVh3IufY7bkrQbuM50HkeE=;
        b=TQoa5nXuJzNkxyMGqs1N5hjU0EG2wTiHbc7JWBVUMDlOk9sqJ++UQAZpcinqOwxfHn
         0a2AyBKQafXvnpi4UnXPhrLjC8n+XifbbD4fXFLnAlKakIT5a5LjtTu1FRLWX93bbpNq
         fYkXLF54arKjdeZ4JriwQAC7Kmq3aei+mf2LBkBSZlxsHLW9LLSyhCK+RmltYYpt+u9q
         whyGMs8bJn6vO7wmNjPA4HOEqd0pzFFYdXlTb+Owj7/REwXEUKSld/cN0x7m+DWqNvnt
         KtMADPRt652sznAdnwVKzPZTXKszTtVyZIA/HT6ELn93uoElmN5x9aaX3r7h0GYSiqxW
         SA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774602697; x=1775207497;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NzoqoXYuQZaBqV4FD+jiduVh3IufY7bkrQbuM50HkeE=;
        b=aLd33fMqNJzWum6h0Hh0wRaWYle+bC7whhimUlyq0DQHaDvaLPgL7r4/oAvoSjbJlF
         z+4t9Z59/W0NKz1EQvOwip/+EaqdYeioJqi7kuizohhSAvO4CZ2Pj+Fzz+IvP3EDB0vP
         UTK9oSH2YB/JdT/wqw1I/wgXdg/ZP6Fr8Yl6/89lH0TNCBR27LlUZRQaon2HXZQql7w2
         kkclvbOzLvpfRyLn37/Cp3uSqgtMq6rVDRipv6roypSwbme8K2SeRUcODj9dVVxpI2+0
         br4OVvscZ800n0UY7qW86eoTbH/N0B/ND6WSeL1rBto8xhP9MjvSP7sxg/Z3Rux9K8Fn
         NZkQ==
X-Gm-Message-State: AOJu0YzUBbPPiSrhFnj2XLG2KYsuGJBU6Uylrj8YRGhUlfVNWAPlf9L4
	5gFBieeIwHzaG3RyydIv0SqN+p7Hl7NzXl33ORqXxZB2JEAS8604CbRhhvQCBZmATaPp63Bbfp5
	dFYtUhp8+Q8G5JuvYQUE55IlvLQe0HH+VYyqkZvWWlnBCnPSKjg03Q9IFWR2qbtz2iWLQ3Q==
X-Gm-Gg: ATEYQzx++S3IbfnP2H5Oyzep3n9g/6XhZz59UngIPUM6voq7RxOqEOsnWbmzOTUxZk7
	EyOTLcnwOfcYZwWIPpyU79Mi3zAlN+Dbyt4jpO9kfH353WaIe1BxSgOiX08HntPeZo5Ex8dfk5s
	0kRnHaTEZaFKBMK4QupEqLniz6S7mrqvksryZhUdUVurEnByoyRdgTcWJgbaT67ikvKjkFSwC5t
	tZ43QlrPRo+mjfHnhU1VwFJcMXY8CNvZbjh/a+QAoYWkOo/WW+a4SoD6n2TF4MFByn5avWiFAr4
	qW7/z+YvZPf7g5B3K3g3Rkj304aKk2vgqBChY31/vc6HFm5ImwGFYMMFz92Tjrhn4tRgtOgusOg
	v3H5x6QgCXB8KbFsGtGclJREpSHSN/Lv/pldafBCqE1CUt3ByEbmeZha8w/wlAyxiAnjperGvDh
	1D0F8VFai0xPxJRhMcxKc=
X-Received: by 2002:a17:90b:2f87:b0:35c:d98:d685 with SMTP id 98e67ed59e1d1-35c2fd94735mr1977208a91.0.1774602696702;
        Fri, 27 Mar 2026 02:11:36 -0700 (PDT)
X-Received: by 2002:a17:90b:2f87:b0:35c:d98:d685 with SMTP id 98e67ed59e1d1-35c2fd94735mr1977188a91.0.1774602696171;
        Fri, 27 Mar 2026 02:11:36 -0700 (PDT)
Received: from [10.133.33.186] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2d9165b3sm675000a91.1.2026.03.27.02.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 02:11:35 -0700 (PDT)
Message-ID: <3faa1fbb-afd8-4631-b3d1-ca81aaac8817@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 17:11:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath10k: fix station lookup failure
 during disconnect
To: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20260325-ath10k-station-lookup-failure-v1-1-2e0c970f25d5@oss.qualcomm.com>
 <7af13762-3e98-4d77-bde2-c14cdb3b1e3c@molgen.mpg.de>
 <5033b613-3514-4686-895f-75bb8f523303@oss.qualcomm.com>
 <4c8c17c1-424c-4a7b-af68-81c099497bd7@molgen.mpg.de>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <4c8c17c1-424c-4a7b-af68-81c099497bd7@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TqnrRTXh c=1 sm=1 tr=0 ts=69c649c9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bp-t3GDuXYEVE0SjF1UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDA2NyBTYWx0ZWRfX3/qK6dfJq9Er
 t0YHEiSSkD7c7MYWM2XMzJrLzmcSdHvPT1HIjQEr+0VZydASIY7xIu/b8pBlWnT2p9QwFitjesZ
 7hSV9WBAFZgJ24c6XMAESwd39ux8qfZI5FOqYdHWeyzd6ikMEJfEVwrpspWadseywKouPzmicAK
 9ks4sy60tJNpXgIs84beOcaL5LjUZzzyszQPp9/MxiE66QiGGqtTUtzxZUdnP8bIlTq+1nx93bW
 aCx+c/B6+gU39SIQdUFm5L54ruHeDbl20aXHhooTAHTQ5LaOIrzXyGGmhs9HB+mom7pFFBsJ9aQ
 VP0iYvEWLNlsWw6/7IQGr+W79oSZ8wmoeUfEA42b3ws8vd/U57nbgouCXuNmRlKxqYxZcsv1fQN
 c7zbe2Uvjngj/nYraw62o+GnTOohf+c3QYtHGGVGPpKz9ovpGL7LhfGs6pykG+854F1e5Ul6hIj
 T50Jc72Pny3O39VjZhQ==
X-Proofpoint-GUID: UzI_MOy-6yMcs6nstSAc84nLwVQjGJ6v
X-Proofpoint-ORIG-GUID: UzI_MOy-6yMcs6nstSAc84nLwVQjGJ6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270067
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34031-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 78A39341999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/27/2026 4:43 PM, Paul Menzel wrote:
> Dear Baochen,
> 
> 
> Am 27.03.26 um 03:54 schrieb Baochen Qiang:
> 
>> On 3/27/2026 7:31 AM, Paul Menzel wrote:
> 
> […]
> 
>>> Am 25.03.26 um 04:05 schrieb Baochen Qiang:
>>>> Recent commit [1] moved station statistics collection to an earlier stage
>>>> of the disconnect flow. With this change in place, ath10k fails to resolve
>>>> the station entry when handling a peer stats event triggered during
>>>> disconnect, resulting in log messages such as:
>>>>
>>>> wlp58s0: deauthenticating from 74:1a:e0:e7:b4:c8 by local choice (Reason:
>>>> 3=DEAUTH_LEAVING)
>>>> ath10k_pci 0000:3a:00.0: not found station for peer stats
>>>> ath10k_pci 0000:3a:00.0: failed to parse stats info tlv: -22
>>>>
>>>> The failure occurs because ath10k relies on ieee80211_find_sta_by_ifaddr()
>>>> for station lookup. That function uses local->sta_hash, but by the time
>>>> the peer stats request is triggered during disconnect, mac80211 has
>>>> already removed the station from that hash table, leading to lookup
>>>> failure.
>>>>
>>>> Before commit [1], this issue was not visible because the transition from
>>>> IEEE80211_STA_NONE to IEEE80211_STA_NOTEXIST prevented ath10k from sending
>>>> a peer stats request at all: ath10k_mac_sta_get_peer_stats_info() would
>>>> fail early to find the peer and skip requesting statistics.
>>>>
>>>> Fix this by switching the lookup path to ath10k_peer_find(), which queries
>>>> ath10k's internal peer table. At the point where the firmware emits the
>>>> peer stats event, the peer entry is still present in the driver's list,
>>>> ensuring lookup succeeds.
>>>
>>> Out of curiosity, how can the statistics be printed?
>>
>> not quite understand your question, can you be more detailed?
> 
> The commit message starts with:
> 
> “… moved station statistics collection to an earlier stage …”
> 
> I was wondering how to print/dump these statistics.

still not quite understand, but let me try to answer:

mac80211 collects stats and send it to userspace over nl80211, userpsace tools like iw can
print it out.


> 
> 
> Kind regards,
> 
> Paul
> 
> 
>>>> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00309-QCARMSWPZ-1
>>>>
>>>> Fixes: a203dbeeca15 ("wifi: mac80211: collect station statistics earlier when
>>>> disconnect") # [1]
>>>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>>> Closes: https://lore.kernel.org/ath10k/57671b89-ec9f-4e6c-992c-45eb8e75929c@molgen.mpg.de
>>>> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>>> ---
>>>>    drivers/net/wireless/ath/ath10k/wmi-tlv.c | 26 +++++++++++++++-----------
>>>>    1 file changed, 15 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/
>>>> ath10k/wmi-tlv.c
>>>> index ec8e91707f84..01f2d1fa9d7d 100644
>>>> --- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>>>> +++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
>>>> @@ -3,7 +3,7 @@
>>>>     * Copyright (c) 2005-2011 Atheros Communications Inc.
>>>>     * Copyright (c) 2011-2017 Qualcomm Atheros, Inc.
>>>>     * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>>>> - * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>>     */
>>>>    #include "core.h"
>>>>    #include "debug.h"
>>>> @@ -14,6 +14,7 @@
>>>>    #include "wmi-tlv.h"
>>>>    #include "p2p.h"
>>>>    #include "testmode.h"
>>>> +#include "txrx.h"
>>>>    #include <linux/bitfield.h>
>>>>      /***************/
>>>> @@ -224,8 +225,9 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k *ar,
>>>> u16 tag, u16
>>>>                            const void *ptr, void *data)
>>>>    {
>>>>        const struct wmi_tlv_peer_stats_info *stat = ptr;
>>>> -    struct ieee80211_sta *sta;
>>>> +    u32 vdev_id = *(u32 *)data;
>>>>        struct ath10k_sta *arsta;
>>>> +    struct ath10k_peer *peer;
>>>>          if (tag != WMI_TLV_TAG_STRUCT_PEER_STATS_INFO)
>>>>            return -EPROTO;
>>>> @@ -241,20 +243,20 @@ static int ath10k_wmi_tlv_parse_peer_stats_info(struct ath10k
>>>> *ar, u16 tag, u16
>>>>               __le32_to_cpu(stat->last_tx_rate_code),
>>>>               __le32_to_cpu(stat->last_tx_bitrate_kbps));
>>>> -    rcu_read_lock();
>>>> -    sta = ieee80211_find_sta_by_ifaddr(ar->hw, stat->peer_macaddr.addr, NULL);
>>>> -    if (!sta) {
>>>> -        rcu_read_unlock();
>>>> -        ath10k_warn(ar, "not found station for peer stats\n");
>>>> +    guard(spinlock_bh)(&ar->data_lock);
>>>> +
>>>> +    peer = ath10k_peer_find(ar, vdev_id, stat->peer_macaddr.addr);
>>>> +    if (!peer || !peer->sta) {
>>>> +        ath10k_warn(ar, "not found %s with vdev id %u mac addr %pM for peer stats\n",
>>>> +                peer ? "sta" : "peer", vdev_id, stat->peer_macaddr.addr);
>>>>            return -EINVAL;
>>>>        }
>>>> -    arsta = (struct ath10k_sta *)sta->drv_priv;
>>>> +    arsta = (struct ath10k_sta *)peer->sta->drv_priv;
>>>>        arsta->rx_rate_code = __le32_to_cpu(stat->last_rx_rate_code);
>>>>        arsta->rx_bitrate_kbps = __le32_to_cpu(stat->last_rx_bitrate_kbps);
>>>>        arsta->tx_rate_code = __le32_to_cpu(stat->last_tx_rate_code);
>>>>        arsta->tx_bitrate_kbps = __le32_to_cpu(stat->last_tx_bitrate_kbps);
>>>> -      rcu_read_unlock();
>>>>          return 0;
>>>>    }
>>>> @@ -266,6 +268,7 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k *ar,
>>>>        const struct wmi_tlv_peer_stats_info_ev *ev;
>>>>        const void *data;
>>>>        u32 num_peer_stats;
>>>> +      u32 vdev_id;
>>>>        int ret;
>>>>          tb = ath10k_wmi_tlv_parse_alloc(ar, skb->data, skb->len, GFP_ATOMIC);
>>>> @@ -284,15 +287,16 @@ static int ath10k_wmi_tlv_op_pull_peer_stats_info(struct ath10k
>>>> *ar,
>>>>        }
>>>>          num_peer_stats = __le32_to_cpu(ev->num_peers);
>>>> +        vdev_id = __le32_to_cpu(ev->vdev_id);
>>>>          ath10k_dbg(ar, ATH10K_DBG_WMI,
>>>>               "wmi tlv peer stats info update peer vdev id %d peers %i more data %d\n",
>>>> -           __le32_to_cpu(ev->vdev_id),
>>>> +           vdev_id,
>>>>               num_peer_stats,
>>>>               __le32_to_cpu(ev->more_data));
>>>>          ret = ath10k_wmi_tlv_iter(ar, data, ath10k_wmi_tlv_len(data),
>>>> -                  ath10k_wmi_tlv_parse_peer_stats_info, NULL);
>>>> +                  ath10k_wmi_tlv_parse_peer_stats_info, &vdev_id);
>>>>        if (ret)
>>>>            ath10k_warn(ar, "failed to parse stats info tlv: %d\n", ret);
>>>
>>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>>
>>>
>>> Kind regards,
>>>
>>> Paul


