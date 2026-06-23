Return-Path: <linux-wireless+bounces-37994-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z0cKBEApOmpL3AcAu9opvQ
	(envelope-from <linux-wireless+bounces-37994-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:35:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D1D6B491D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:35:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=oiNixrV6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=T06ynyFU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37994-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37994-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1636E3045AB1
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439B314B76;
	Tue, 23 Jun 2026 06:33:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE3397352
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:33:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782196421; cv=none; b=eQYr9mBxPOPr1HcmjrX5612MVK5Hibt1xu9iff+iCkOKeOkHZKjSDWGe4KDbrSUkTmMake6QTHdhpEvLWg0luyg3vsp11voR4zAVWVXLgR5CyLVRlekFNwCJtz0akB0kuLLorXp0qsOx+iydcJ88DFdee8yThzUwk84LcfzSxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782196421; c=relaxed/simple;
	bh=etbJ2oo+uM1CMJV3SVt3i6CLWP3m1olRE2mzZkP/jqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCXaq5uyrla3nQRZXK5clGLFF3zqJqvaEJ3DyhZcTj3XQbVaheBHd4cO8An62ke2yvae1/T10wXIp99XZuu9y23+cUlVJBfJztO3chNUFaqSo2joSHk1L8T74NoNLrfynWAGth1MXq0J580+Aa88yrPZ0JRnKQVWq1GJx1MpR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oiNixrV6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T06ynyFU; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N1Y4n52672617
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:33:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	etC2UpUQyiixtRZefzGaiIsxGOMjL3UeeleogTdY9wI=; b=oiNixrV6RHoi+er1
	NcKPqrwFvYTdeMe8mf78gfX+Xll1kGA2a0RqiXCulksijwMJWuVtDm3qSMegJopJ
	kLjTPZYug6guhQ8N8bEYifDrl9yvqxNfyixAV1qGTPRwp2xO2npmwp4MLmemZeAC
	xC+14HiGQG3cGmxSxhzxlDseZdITnO4ngao2n6y/39pprwKH+rYUMeEb1u5d4vZC
	bd/vqGEEsOwWl4tOPODtumyS8sv++aAjRHMpQXKreSg/zoeV0dwOSPf3P38DrJmb
	q0AfzvPNvZFbqYKDtg6iDhpNkbUH023PwT2KfNkqnv2ZoepnczRpCRyozt8357nd
	6RmpPQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eygkjgw18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:33:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8422382178bso3380251b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 23:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782196418; x=1782801218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etC2UpUQyiixtRZefzGaiIsxGOMjL3UeeleogTdY9wI=;
        b=T06ynyFUWoElTJWYraztrST/XF8kynrYwjbowdTceELJezK1CJ4JeG0XZAdtJ/Buq8
         SVmODEFbYJIboTuW4MHNGeCpMJ1pzP5wvKFcqg2S5AYNqm2YUOL3UjNrqCdEzX/7qWBw
         hgK+zResOaoV2ldhugbIzpcgzITf5UsouXgubNlERS1p0VSiaHKKH7WhuXMjd0QBz8Cx
         cDAqoG5JlLiF5P5CF7dZlLdlsXzWjxo1BDbgnkfGJN7UmSm1oKjl7RsJGKH6l0S1ApCb
         jHirlJ4bnS6CTYc/X+Cl+JjDuNtGt2ef3yn0/ce28Mu8xmaX3S5acbA8PoqPmggDSmvV
         Jc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782196418; x=1782801218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etC2UpUQyiixtRZefzGaiIsxGOMjL3UeeleogTdY9wI=;
        b=mEEf9xdfVP3T5Ps3GLG2kFrwWw7C4sTamlBNh4Zb56Xoelb3+YsiaVHnzbFrnFo4OA
         bT5gpAdGzhipAWUWeKG7Y0nZW5EBXCUrnNyizqTR8N312CRBR0v/ESdgqiCQ2ZHeKnXy
         5adxpFk0Ti3Z8WrIXumQs8pQItSxYdsbch2rqf0ICUUKZwBOeLi114gKWFedwRatN4Fn
         C6k0/FoL8JUp3phdGcvW8RK3NjfB3wR0RPX1I3p1YkqT11T8eSBEVjIFf/WsS/TG9Bcg
         b4Mud8mtuxEdzLXAqdgcnzTyLO3Y7E3ujxMHq9uu2rEuGB+S5DWoyoUJneBFJM8HvClX
         lTdA==
X-Forwarded-Encrypted: i=1; AFNElJ+gprNhNNaCYUw1M2OHdclhM7BO8D8kCfaCSm5j5iqSQa8hJvm8wJJIhGmMHW6COvSKsE9YiQvRZKNasFOceA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IqKzIz7Uy8t6DX8TkFjcWQQmnaojfFcw5vceNZ80raUyAYFi
	EIuTfXAiZssxO10l+WAcNR0W9ZnB4zr/PbkT5AymeiLhaHqabwN1fRYwHG7E6rnY8m9xmBRe7YK
	B49z4CrXCg8ZCww3Kb7rHoPKdrD1wKc7NahMWJuFz0zw/uVBFL/90UTP+OWHtUb5/xbPBQw==
X-Gm-Gg: AfdE7cn90xPaf3uftzh0xlByAH7SU+/GPg4Ps9n7ryao6uCokNT4cbzgaGL7tJQfAJu
	0COPXgYf+igdNs9zdU4xD6ysM58GGD5bdQRHIERCbupZ7KQvL4AS55tg4KOjS5pdMj4EgukkCag
	242lIDtuV+ZINv4UoBweyz9tg2PeVkm1WEcbqMV3XYQPVhIvC1whv5nD8Nn3e3inOMQrksuscZu
	bEVV5vPGBu1/tl3ACLPZFJWfcGCFznmZlOYH3u1VyJQ3DUhH2erSV+VqJEzTJvfqsMEAq8ulsLD
	3Qpj9i3c+vxNphEw4jwqjej9GxwsaxiZN0lpNP4KcxxrPfsLcGjNrAd6JMWNAJCnloPRPUaeHEH
	N4/anrsN4SYzhohqhNHbpWeTo7aCp7HGleMqwzicvnFzaSgR9Mwce0LVUTEh6
X-Received: by 2002:a05:6a00:230c:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-845507864b4mr19402315b3a.9.1782196418158;
        Mon, 22 Jun 2026 23:33:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:230c:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-845507864b4mr19402234b3a.9.1782196416901;
        Mon, 22 Jun 2026 23:33:36 -0700 (PDT)
Received: from [10.137.71.130] ([106.198.36.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ecad79sm10674704b3a.50.2026.06.22.23.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 23:33:36 -0700 (PDT)
Message-ID: <1da2b466-ffbe-4aae-9a31-7c6177bdf525@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 12:03:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath6kl: fix use-after-free in aggr_reset_state()
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Daniel Hodges <git@danielhodges.dev>, linux-wireless@vger.kernel.org
Cc: tglx@kernel.org, mingo@kernel.org, joe@perches.com,
        vthiagar@qca.qualcomm.com, rmani@qca.qualcomm.com,
        jouni@qca.qualcomm.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260206185207.30098-1-git@danielhodges.dev>
 <d5429e89-0eb8-46bd-b143-95fc5adefa2d@oss.qualcomm.com>
 <e46348dc-a95e-496e-8b49-2838b25bf9f8@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <e46348dc-a95e-496e-8b49-2838b25bf9f8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfXxtIsjmKKpf0e
 tkr80SMsYGZCazesIkWeh0L13vQvxKbWWZOFRjs16fHs2P/YQmk149v7kDATTRdZ6t62V6Vk8rf
 ajjxcu6QSUX+ncvSSCvr7CcDenRTjQQrFokBCherYfU5b35DOfyl4YhPu+PM3/yvLWZRTvqzMu5
 ATqoYhEb7UnycJc6jKZQMnzthnO2TqnZhhu+97ml106NRQbtuZ/TuR4DDK9RVwHk537141xgMXU
 FMggyHILvGzlT0bjUJZnbBVD5xb8XTxCBn2PB/c0IyTa3giXmQwi5f9swwLoiIVGX3TUxDPoBg+
 MpECuCcrb690u0kNg80a8RhVbZqnjsb2QJqI1sMBdXgv7DqTcAKBBC15Cu1eR13nOJtzPMelSW6
 ejtHCYFITgHCiiN4uRiUE21Rj3K380GTTSwaamlV2RHw6nc5g0uyymfnR1SKhBnC0xCBNBOYFZ6
 qFPZZ9f8ixa+4+dTRYg==
X-Proofpoint-GUID: ltupkeEruCAUIc4dfU_So1fK05sqbsBo
X-Authority-Analysis: v=2.4 cv=SoKgLvO0 c=1 sm=1 tr=0 ts=6a3a28c3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6/2MXK9rXRWb21GBy9lArw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=-5zR_lsLDLaSFfFJBCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX34t+SYNhLH4a
 QfZpk8e/zwmkm8qGLWt6JxWIYNVdcroSm2HC4cRpQcYcQniVDTbLzPU2Ay5BQrVYIxs2FAXCyXD
 Y+YxgfOrdyTPy9logypNdbmzkfV5fiA=
X-Proofpoint-ORIG-GUID: ltupkeEruCAUIc4dfU_So1fK05sqbsBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37994-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:git@danielhodges.dev,m:linux-wireless@vger.kernel.org,m:tglx@kernel.org,m:mingo@kernel.org,m:joe@perches.com,m:vthiagar@qca.qualcomm.com,m:rmani@qca.qualcomm.com,m:jouni@qca.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,danielhodges.dev:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58D1D6B491D



On 6/18/2026 7:00 AM, Jeff Johnson wrote:
> On 6/17/2026 6:26 PM, Jeff Johnson wrote:
>> On 2/6/2026 10:52 AM, Daniel Hodges wrote:
>>> The aggr_reset_state() function uses timer_delete() (non-synchronous)
>>> for the aggregation timer before proceeding to delete TID state and
>>> before the structure is freed by callers like aggr_module_destroy().
>>>
>>> If the timer callback (aggr_timeout) is executing when aggr_reset_state()
>>> is called, the callback will continue to access aggr_conn fields like
>>> rx_tid[] and stat[] which may be freed immediately after by
>>> kfree(aggr_info->aggr_conn) in aggr_module_destroy().
>>>
>>> Additionally, the timer callback can re-arm itself via mod_timer() while
>>> aggr_reset_state() is running, creating a more complex race condition.
>>>
>>> Use timer_delete_sync() instead to ensure any running timer callback
>>> has completed before returning.
>>>
>>> Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>>> ---
>>>   drivers/net/wireless/ath/ath6kl/txrx.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
>>> index c3b06b515c4f..25ff5dec221c 100644
>>> --- a/drivers/net/wireless/ath/ath6kl/txrx.c
>>> +++ b/drivers/net/wireless/ath/ath6kl/txrx.c
>>> @@ -1828,7 +1828,7 @@ void aggr_reset_state(struct aggr_info_conn *aggr_conn)
>>>   		return;
>>>   
>>>   	if (aggr_conn->timer_scheduled) {
>>> -		timer_delete(&aggr_conn->timer);
>>> +		timer_delete_sync(&aggr_conn->timer);
>>
>> My review agent claims this still doesn't fix the UAF since aggr_timeout() can
>> call mod_timer() to rearm itself and hence the timer can fire again.
>> Instead it suggests timer_shutdown_sync() should be used since that prevents
>> any rearm from taking effect.
>>
>> But I'm not familiar with this driver so I don't know if there are reasons to
>> not use timer_shutdown_sync(), i.e. if the timer will be reused again then
>> timer_setup() will need to be called again.
> 
> Interesting enough, another iteration of the same agent says:
> **The fix is correct.** `timer_delete_sync()` loops until the timer is both
> not-running and not-pending — it handles the re-arm case because after the
> callback calls `mod_timer()`, the sync loop picks that up and cancels it.

Yeah, my understanding is also that timer_delete_sync() will ensure that the
timer will not be pending (including the one armed from the timer callback itself)
or running when it returns with the caller ensuring the timer is not rearmed concurrently.
With that, I think this code change is fine and no need to use timer_shutdown_sync().

Vasanth

