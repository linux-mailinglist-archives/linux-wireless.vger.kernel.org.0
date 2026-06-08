Return-Path: <linux-wireless+bounces-37538-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WDxAFm4HJ2rWqQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37538-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 20:18:22 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C62659A0B
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 20:18:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=V+yRhuKT;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=I7rI0RwT;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37538-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37538-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69C53080FB3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 17:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D7381AF;
	Mon,  8 Jun 2026 17:48:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01531F990
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 17:48:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940907; cv=none; b=Xfk1uIP5A1VNdf2ik2OF2WUuq6GCNcGOTm5UmfSw/ey6yXpVgWHcgxBA9W+cjymu9tN4o4tQzB2ovcU90PCDn7XBjullhIM8F4WQotBG7A1YGgp4ZLKkpYOSbdQXUQqfaJbfEUkIz7FUkkREmHnR8qQ5/RT55nG7ozAtoO9R4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940907; c=relaxed/simple;
	bh=nBufdwqdXIkX89jK6L7AxyQ82Xg5bWKE/TXTG4MADBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKE+oQSe55RNkOP6NwegUGNxrdEKKjxkAaoCXQri1DF6JCd2Vypc5vU9ZC0IHFYoZaRXHVw4GY5aint7pC0NaBYHrrmcyJl1/GBUtHNoa2s2APFakivxHFBesLqUt7E/r94zpZL6NSGRaX+E9kIWb0VX+WX8q+8PrXNeTcNaCLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V+yRhuKT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I7rI0RwT; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFSNW4008455
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 17:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d/9g7+8oC3yBt2suG9dk3CdbNFRbx6wAs2lmTlHEx+E=; b=V+yRhuKT5R9WKJxp
	/4XxY7Kaa5CEQKU6oq21a7PmTwhzGDdnm/sPGZNQ5Pe+ZZlIpA8Z8zsm30pZ+sLk
	0b6OOGlRmTZxxoMlJM3qdrgMpbPIw8AVhVe8/ia/fq990OdNu9UIFzR4cvecClPi
	rF9YCsmTBhGOUYRd1HZUflX8Yju1bGe30ueC6io3Pom11Boxnq1oR9Zy/eiBsojB
	aTh6SSq8ncArbC2u+k9DuMS+BKHcM3OXi+eYzNkl1dpitHBjYBz/QyvOCE0F1xrC
	k3058kr8exNNsqxiw1GQlB1nMLNOfVgLsxsjdTnaGkbu6iZaVxdWsFgCu4daTQj/
	b99SRQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entr0jfrg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 17:48:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304dd917645so4454559eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780940904; x=1781545704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/9g7+8oC3yBt2suG9dk3CdbNFRbx6wAs2lmTlHEx+E=;
        b=I7rI0RwTh8/P1QNqHCOD2IdyTJ+HAuCf4LwtbcxhX1udOr8F4p9C0MpmOlJLHb9m3/
         GMGv/MSGrW3iH87mMlddWtFvP02PdGwfX1Sk3vPJ5Y/BRRvvVk9GwhiFFYtvhJacDlVW
         DCHH3FyDf9XZE0ygXu3aWHcgiwjrSUnHZx6puXwSYQPHjh/SwbwBdErwt0yjWrmMgdOm
         pypDErFffGQNRov9ZjaF04rb+oATOXvxD9RaV6rq3DkaVRkjITCpqcKO4GRE3Bi9zCNo
         8LyL4iVi2ugwAvFQYRmEoelDHDL1/7/DYDXiz/7Ar6D3RqQkUDOpJDTYepiH1oU/R5Pb
         tuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780940904; x=1781545704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/9g7+8oC3yBt2suG9dk3CdbNFRbx6wAs2lmTlHEx+E=;
        b=XZHi/zdr1GVRu+hy2u2/LzHNs5JAzN7hiSzaTch6SLcA8TqVSqFk0vrmhDjZ2/d1gk
         xZdgGGakzU8QrI5DR414v6/Wa3cah1qdwp1HumUR+4xXbvZVuwJ6S7ftoapTzZsFOk3V
         69m9/Ingc+64lPUeweyof9lKC8PIApAPxMdV5VcJVcMSV52zt0CPzgC4jvCtwbwIbb7H
         ossWd9513UZ/6sVkmLoZXWtqFskITqY4GSb+fkTGZnI0E6kQIpsJQWvNb5N0iXW7tcWJ
         AnTdQW/ZrR8/op3ycQVw8RdNcZ5ubal4vBeWvDvVzUT20kqGwVmTs3fTSG0FsMl+OjqS
         vhyA==
X-Gm-Message-State: AOJu0YyOu5aSqa9UGOBu6Wn0o/vq2lPMmfugQFRVbU6S/sz4uw9HT6ht
	c/YDYSrk7XmJUW7mIo2EOlrTcbz8AjR+wr3/h3V2eNT94x7h47qs8O81EJNiKkAuIW8Yn/XnxR+
	+cuOx2Kzpz94nyAi3g4QdnphhoxLH4YXfJxWBWvLs/NNil/R4MFGTaeqm9tkB4Rpd16013w==
X-Gm-Gg: Acq92OFMbHjgZUnu6jIvugyhg6KSjo96APitu//eBtYjCHlP7zjF67ujX2lp2RhRwba
	X4xf/OQyjMQwTXIo/Vs53XaJugcKXYbeCwmt2E4DMthbQa/Q0XV0bcmR8HQNPFQhi1B82zg/sOk
	mrl3+6f0sUWK78gkhiYLvgeewEWcuItHRspCEg6xgWVj1yypwlFy15GbWw4lKWclZOyKFlLUBjS
	4C35uo3vPYcfPJwriaDqXPbLDTmuNW2cWYViipj4LJohHYaVyr9GcdseM3O5yZMYjs8tbnSsRBX
	9S+NyVH3JQ2qNU1gsSI5BxHsBs7lVXIAlqyTCt5+EgVfwihqev81uLn6RsApO42pXrpceQPpg0E
	9JoPu/W0QVMt7cv0Xukvo/xW7QlLjK8xIV6CKDKswnUDFb6EA8ef11xsXClE=
X-Received: by 2002:a05:7300:8190:b0:2ef:8b72:1b9 with SMTP id 5a478bee46e88-3077abcee73mr9540527eec.0.1780940903826;
        Mon, 08 Jun 2026 10:48:23 -0700 (PDT)
X-Received: by 2002:a05:7300:8190:b0:2ef:8b72:1b9 with SMTP id 5a478bee46e88-3077abcee73mr9540498eec.0.1780940903154;
        Mon, 08 Jun 2026 10:48:23 -0700 (PDT)
Received: from [192.168.1.8] ([116.73.159.142])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30791f6381fsm9238976eec.0.2026.06.08.10.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 10:48:22 -0700 (PDT)
Message-ID: <1a584e78-1039-40ba-a6d6-d1af2516c3d8@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 23:18:18 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 0/5] wifi: cfg80211: Add fragmented per-link
 station stats in MLO
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
 <7d251045171a4146604b8788479efc0e99224ff8.camel@sipsolutions.net>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <7d251045171a4146604b8788479efc0e99224ff8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2NyBTYWx0ZWRfX2nVYPyiY6cb6
 oIj14Ke5dxocoUgXKm1PPDae+nVPSuOlF7qQ/kprzmn0yiMkM3lV7JkYY1GhBoboHIU70izAg1B
 a0TrOPgtKiJqK3IGJPMx9hUtbnFgYDhKIn9SBR30AYftVLUrJ9SjmxE+4ituZxpOcaNMPA8dfNX
 bSQ+uji638TR1MJIO23HFN40dEWcEwOYJwJ7gV9GVbQ7XDp2FTYAcMWQyiVbK8mTaXKiSI3G/yc
 wcWRlALignSu2CsIhkXdtseZ9cVjbqxB5rnvApg/cqhFc+jph87TvaRdHXxQ1RzFSTIDD7AmRVV
 HrYNQp9IP+EsIfKP8zC1KkNwBXhm1zFrE6fglZt/kzyAzGyHfkaZcd2xNCfLK4uWNID5vUQjDw+
 HPaUC1EQg4i45LfC57TvrBFHlOvG+zPXrdKNENz2kTrQH8fpWY/fGzcvEWzOYClPaK8SbCop6ek
 XtdM5bl++85ICZw9qmg==
X-Proofpoint-ORIG-GUID: o2ovHvRFDbnyw2bqhMb9JFiQugSJNkp7
X-Proofpoint-GUID: o2ovHvRFDbnyw2bqhMb9JFiQugSJNkp7
X-Authority-Analysis: v=2.4 cv=VowTxe2n c=1 sm=1 tr=0 ts=6a270068 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=0XKIscjZuezYqwSxLmfFhQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=Kw0TDqbp-FwB6xDATtQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080167
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37538-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8C62659A0B


On 6/8/2026 12:46 PM, Johannes Berg wrote:
> On Sun, 2026-06-07 at 23:29 +0530, P Praneesh wrote:
>> This series introduces fragmentation support for Multi-Link Operation
>> (MLO) station statistics in nl80211.
>>
>> The current nl80211_dump_station() implementation works well for legacy
>> (single-link) stations, but it does not scale for MLO peers. With
>> multiple links per station, dumping all per-link information in a single
>> netlink message can exceed size limits, resulting in -EMSGSIZE errors
>> and incomplete dumps.
>>
>> With 802.11be (Wi‑Fi 7), a single station may have multiple links, each
>> with its own statistics. To address this, this series introduces a
>> stateful dump mechanism that splits station information into multiple
>> messages when required.
>>
>> The dump is performed in two phases:
>>    - Phase 0: Aggregated (station-level) statistics
>>    - Phase 1: Per-link statistics sent in separate messages
> [snip]
>
> Overall, this approach seems (mostly?) right. I have a couple of
> comments reading the code itself, but also:
Thanks a lot for your quick and detailed review on this series.
>
>> Aggregated Stats (Phase 0)
>>
>> NL80211_CMD_NEW_STATION
>>   ├─ NL80211_ATTR_IFINDEX
>>   ├─ NL80211_ATTR_MAC
>>   ├─ NL80211_ATTR_GENERATION
>>   └─ NL80211_ATTR_STA_INFO
>>        ├─ <aggregated station attributes>
>>        └─ ...
>>
>> Note: No NL80211_ATTR_MLO_LINKS is included in this phase.
>> Per‑link stats are sent in Phase 1.
>>
>> Per-Link Stats (Phase 1)
>>
>> NL80211_CMD_NEW_STATION
>>    ├─ NL80211_ATTR_IFINDEX
>>    ├─ NL80211_ATTR_MAC                 (MLO MAC)
>>    ├─ NL80211_ATTR_GENERATION
>>    └─ NL80211_ATTR_STA_INFO
>>         └─ NL80211_ATTR_MLO_LINKS
>>              ├─ [link0]
>>              │    ├─ NL80211_ATTR_MLO_LINK_ID = 0
>>              │    ├─ NL80211_ATTR_MAC = <link0 MAC>
>>              │    ├─ NL80211_STA_INFO_RX_BYTES
>>              │    ├─ NL80211_STA_INFO_TX_BYTES
>>              │    └─ ... more link0 stats ...
> This description is missing another nesting level as
> NL80211_ATTR_STA_INFO no?
>
> johannes
Yes, you are right. The per-link stat attributes are wrapped in a nested
NL80211_ATTR_STA_INFO inside each link entry. The diagram incorrectly
placed them directly under [linkN]. The correct layout is:

NL80211_CMD_NEW_STATION
├─ NL80211_ATTR_IFINDEX
├─ NL80211_ATTR_MAC = (MLO MAC)
├─ NL80211_ATTR_GENERATION
└─ NL80211_ATTR_STA_INFO
      └─ NL80211_ATTR_MLO_LINKS
           └─ [linkN]
                ├─ NL80211_ATTR_MLO_LINK_ID = N
                ├─ NL80211_ATTR_MAC = <linkN MAC>
                └─ NL80211_ATTR_STA_INFO
                     ├─ NL80211_STA_INFO_RX_BYTES
                     ├─ NL80211_STA_INFO_TX_BYTES

                     └─ ...

I will correct it in the next version.

Praneesh.



