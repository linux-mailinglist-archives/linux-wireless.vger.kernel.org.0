Return-Path: <linux-wireless+bounces-33045-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKBjBN9TsmlJLwAAu9opvQ
	(envelope-from <linux-wireless+bounces-33045-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:49:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1D926D6F4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7884F306FCC6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 05:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53A23ED6A;
	Thu, 12 Mar 2026 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4/Piyqr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AWt/PZuN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C0A23EAB0
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773294550; cv=none; b=bYRnJzpxEm2AJij0/lDjws6XrMCeM38O/UorDEKskWkJhee9H0i0OBLKVMWguoLPQpvMjILz0/FIISKkW5u8Fd0Hw4mzavC6U0e4noI6F9r6opTL47Crj9lRTn36fcdfoovw7/YusVjvIajsfcnkgOzvX231wAE9b9eCi34ihsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773294550; c=relaxed/simple;
	bh=DnonuwOVC+nVItmRRIKMA/fDz8X/XZM1ByjAlEjc3GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTTpGBlpUmC0OfUb0pUvQBYNBd9XXVcIUL/KwQ3otR12Hbs10BQVTMqj5ujamkCGjTww0Lwibd3oyPIOYPD2KGwPvNHDmIGFOFEHhwPRP/EKtyyVpAoEPAue7vi0D8TlbWrwMVzAGKgatU4hUfb2NqvF25kBoqP0/5i+AMaEYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a4/Piyqr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AWt/PZuN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BMPYqd3666461
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ZoyLCKbfmAWXPj7Ja8hrtYbKxwcdYf3vbaiNIY6ts0=; b=a4/Piyqr5Vz99KIw
	0lHcopj5xnanhwUsF1NsDCXFbVyppccvjYvYaSj+q8qGv3BJxgVorGjKNPMIO4xo
	GM0BtezRton/en5lyqQilmvtGUmGur5Zfzn6A4XyXcZ694UD3wlZIPQNaOWwPryE
	Vs+0DKgba4mk3+X5MNW2ev9sNxiwozlNeJ1OkXEwp83Pa89S1EgRxwY2BmNewneY
	jHQ32dmZ08v5sKjj6hX8iYKEGIkl4lrhEvmOIRS4T0I3sIP16+ba4xvzuQBl0Ob/
	/eGF1jXK9CuPJLklCc1iVhsp1GBpuYCly8C+xb/GGoax5oliwwU9H/xmvQ73iJLH
	O0Bd9A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh60h2bj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 05:49:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7387c70046so349206a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773294547; x=1773899347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZoyLCKbfmAWXPj7Ja8hrtYbKxwcdYf3vbaiNIY6ts0=;
        b=AWt/PZuNaRnKdUc46ACVgfdPtLLZhg6upIlobrD6fylfAlzKXdZH7b0FmKBLcr1fWJ
         FWI2We4Z8g2iuyijUxBIlGUo4hwTWNXg0wJxMSqMGtUCFciziZGeqP0PxwUSMX5qH8Nn
         KBgE5VnU11ieQnkTMr2booPMA+a2Gtf+LDt0wBgfxelJsXXX+k1kuIx7N4otvk4yP4qb
         F+j+RAWvvkYYP4K419ESoMQ3P4w41IOMntX0C+2yOQrUQ3MXckfKIlDy6ALxAFvPpBVO
         mTbjwB4y2XIl1X0U5PiAOGzqXaTIWCfeuZBKcRBJrYUedAYh6BYyNhXMqe1wDwlnsTRY
         TfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773294547; x=1773899347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZoyLCKbfmAWXPj7Ja8hrtYbKxwcdYf3vbaiNIY6ts0=;
        b=GEmnzzH3e78HJWm97vRZ8xJ1IFIW6GaO61k9L5g9t74QMQuyYKCzcw2NHIbBtVAXdi
         XR9fS8CHMqLTlFCBGEez3lqXRPOr5Q2KQE6NRAX/guKhCFqmWlfDC1yqa2qFLo9AbHdT
         jE+fnLr9lGzgrCWBEmkX5ab/JK7yXWIh4sPvy/7RkDmR7kR/ZTOT1aIRWuIaK5Iw8r2j
         n7WqnlYdfnYz3Fr7JoqtbUizpghn+FGGvpH4Q4eYJmZgukcbtLHD9WpgljXdNGWoE0t2
         Y/CM4PELgsJP2NcSg5veYthU1EyRsyGlLXN5u9e+iwqpGA9GTZ12mbqOetzbkZhYcbvZ
         ysow==
X-Forwarded-Encrypted: i=1; AJvYcCV8MS+6V6dgk+Uxobwn424nBhNyKX7GEGeXU5n3UL38djFglBoQMvfyy4fsQ/sb61koN0wNov7HkhwiUqnfdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOip+gTkLQMaxI11BRxQxXPvbMSpFcubPaJjr0fUmQD2rBTQ8
	tv8jcGhFpRNR/qf20cuDZb2AZEcdSXA99hw3KNFiShge2o4Y15A2UXv+peaCCwrbgd7ilEuHNtU
	bzuxC+UnRzh6bHpDFh6K18Yv6EiLKu2D4Cn85Xz+qqOTF1rRDHnzPV19XyX2tHneUBg+pTZNRrG
	mwj9xP
X-Gm-Gg: ATEYQzymUFSeHqkgdCM6EgDA2Lt84WYyysxkfStdhr7OugUpGNl+eMSOEMfUoF46GOD
	3UWtPMo+0Pa/7dPXL6HA+nPsluzI2pCh/2lPbL+Yt2pjYcg1F0qWddncab2I+kKzSEl4yuGEMKq
	FG2axYgxfJsopKWRmUbKdz/IURHGp2gkm9U7OLEx1lT+3u/0M5BON8uNHLwAV9l2TNNiN0NkeI3
	r01nfSDrHTZ2uXLEhs29Gen1OtcZwUBBwFz3Cg0LvsOT7bgKUKCngSfaeMyGCVIhOhbWJR8WjTF
	G/Fc2z9eCzQPxMy1WSOSeic+9AeaybvMgP+GlMguOnqmh8BKJv/M7n1QaT9vQuG6dG5B9ZNx/Re
	KY3BGEaXJLfJ1Fm43vxgk48zog1W92xFC5E8FFExV06UVjYpt4g==
X-Received: by 2002:a05:6a20:3d83:b0:398:80dd:5705 with SMTP id adf61e73a8af0-398c60e42f8mr4950309637.46.1773294546352;
        Wed, 11 Mar 2026 22:49:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d83:b0:398:80dd:5705 with SMTP id adf61e73a8af0-398c60e42f8mr4950275637.46.1773294545758;
        Wed, 11 Mar 2026 22:49:05 -0700 (PDT)
Received: from [192.168.1.4] ([27.5.116.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf9303csm4090926a12.18.2026.03.11.22.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 22:49:04 -0700 (PDT)
Message-ID: <416d08f1-6b8d-4bf7-9a63-c3c68497d990@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 11:19:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
        vasanthakumar.thiagarajan@oss.qualcomm.com,
        Lorenzo Bianconi <lorenzo@kernel.org>, ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
References: <20260130154259.265130-5-johannes@sipsolutions.net>
 <20260130164259.54cc12fbb307.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
 <f96125eeda23451c19067359eb9d10b4047bcdd3.camel@sipsolutions.net>
 <5d54feea-d0cd-4bd7-b0d2-02e42f0fe5e1@oss.qualcomm.com>
 <be9ab3c7f05b0f56f19aee0ffc7c2f96138b9a05.camel@sipsolutions.net>
 <156d6d48-d135-4acf-a5d7-c9ae80523864@oss.qualcomm.com>
 <0f4b34f0b529fd93fc608d8bbac0e98516b7a3d2.camel@sipsolutions.net>
 <f3282007-a11a-4f68-86d8-0945e4979d65@oss.qualcomm.com>
 <d3ecf6e5580cbe50eee807b1e63109e42e3b956c.camel@sipsolutions.net>
Content-Language: en-US
From: Harshitha Prem <harshitha.prem@oss.qualcomm.com>
In-Reply-To: <d3ecf6e5580cbe50eee807b1e63109e42e3b956c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zmxTgkEPN6YcMBBcBsosUdotGrMfB5KJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA0NCBTYWx0ZWRfX8izBijGETw91
 IDY3Cmzs2mILpOUn0YdGSwFGwrvTTs9WmKg/sqLZNrerleg6QWqk4Caqe+PC35KhvvGbVuBxyj8
 SYKQMtHR4bSJY4C4XyWn06KsyrzQFVVZL9yNa/O6GCzbpakrS1DdPVCiBe0pnSF/h6szchzgZyd
 Sh7l9gbJVkayDNljGKDeloqPaE6itfGKDTsFCcr5JoZbdaedaL2UJ0h1V+qhC51CY7owo3Mr8vg
 xpWJ4dCtlbGQW3S51Jk74miOHx1TJlhIRB8LBtCKoua5B5hAhnM9xdFfdhShTc83HvUElzJSfj9
 5Je89RKtggkrNNqrGkEpdQDfKZDl9vtugF2uFGo21JQG5eWfIJC92aGoGSX+XjZIXGUXa1kEGJM
 I255DjhyMBtUywYCD5QFu17+Idb6JyPQGrrECJmUJg8KjYnudASu3PhVm1h4VCezUYRbclv/zDm
 w66rAMgRQMgnJQAE9Kw==
X-Authority-Analysis: v=2.4 cv=DsRbOW/+ c=1 sm=1 tr=0 ts=69b253d3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=2nr1+02xqZAyC3l0ZA5/6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=E38heQHmJUpkbQq-XYUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: zmxTgkEPN6YcMBBcBsosUdotGrMfB5KJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120044
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33045-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[harshitha.prem@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A1D926D6F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/6/2026 6:13 PM, Johannes Berg wrote:
> Hi,
> 
>> Thank you very much for your patience, and apologies for the delayed
>> response. We spent some time discussing this internally and wanted to
>> follow up thoughtfully.
> 
> Hey, no worries, I'm clearly also not always able to respond quickly, a
> lot of things are going on at any given time ...
> 

Thanks for understanding! :)

>>> This could get trickier than I imagined - you now have three periods of
>>> time:
>>>
>>>  - now
>>>  - after CSA but before UHR update
>>>  - after UHR update
>>>
>>> and actually all three might need different UHR operation, since the CSA
>>> can change the bandwidth and therefore e.g. DBE/NPCA. The intermediate
>>> period ("after CSA but before UHR update") can be captured by the CSA
>>> operation (given a template/UHR operation for after) easily.
>>>
>>> But I was imagining we capture all this in the operations already, so I
>>> guess to do that we would need a "NL80211_CMD_MODIFY_MLD_BSS_UPDATE"
>>> command that takes the cookie and updates the post-operation values, so
>>> that the changes due to the CSA could be taken into account in the
>>> previously started UHR update.
>>
>> The idea of introducing an NL80211_CMD_MODIFY_MLD_BSS_UPDATE command
>> makes a lot of sense to us. In cases where
>> NL80211_CMD_START_MLD_BSS_UPDATE is already in progress, having a modify
>> path to update the current beacon seems easier to reason about and
>> manage. From that perspective, a pairing such as
>> NL80211_CMD_START_MLD_BSS_UPDATE together with
>> NL80211_CMD_MODIFY_MLD_BSS_UPDATE feels quite natural.
> 
> Yeah, maybe, then it wouldn't ever really go to a normal SET_BEACON any
> more, maybe?
> 
> I was thinking more for not having to change all the code in hostapd at
> a given time, it might be more plausible to still allow SET_BEACON and
> just keep giving the counter offsets etc., in case e.g. something "old"
> like short-preamble changes.
> 
> But clearly hostapd would have to manage those offsets etc. anyway, so
> perhaps there's really not going to be any reason to support SET_BEACON
> while updates are in progress. But in that case I'd probably argue it
> (SET_BEACON) should be disallowed by the kernel, to catch errors.

Yes, that's the idea when any MLD_BSS_UPDATE is in progress, instead of
sending SET_BEACON rather use MODIFY_MLD_BSS_UPDATE.

> 
>> Please find below the envisioned design flow for the UHR CU and CSA
>> intersection.
>>
>> Hostapd (User)          mac80211 (Kernel)           Air / Station
>>    |                           |                           |
>>  1 | CMD_START_AP [Adv Notif,  |                           |
>>    |  Post Notif, Upd Int]     |                           |
>>    |-------------------------->|                           |
>>    |                           |                           |
>>  2 | CMD_START_MLD_BSS_UPDATE  |                           |
>>    | [Link:0, CurTmpl+Offset   |                           |
>>    |  (All), Timer, PostTmpl   |                           |
>>    |  (All), Type:UHR_CU,      |                           |
>>    |  Post UHR Op element]     |                           |
>>    |-------------------------->|                           |
>>    |                           |                           |
>>  3 |                           | [Set Tmpl, Timer: Adv=10, |
>>    |                           |  Post=10, TIM Update]     |
>>    |                           |                           |
>>  4 |         Cookie X          |                           |
>>    |<--------------------------|                           |
>>    |                           |                           |
>>  5 | EVENT_UHR_CU (CU_START)   |                           |
>>    |<--------------------------|                           |
> 
> Not sure what the event does really, at this point? It kind of starts
> immediately anyway, no? But it also doesn't matter for this high-level
> discussion.

Yeah, it would kind of immediate, this is just an indication to user
space applications if someone is interested.

> 
>>    |                           |                           |
>>  6 |                           | Beacons: 10, 9, 8...      |
>>    |                           |-------------------------->|
>>    |                           |                           |
>>  7 | [CSA Triggered: Link0,    |                           |
>>    |  Count 10. Sees Cookie X] |                           |
>>    |                           |                           |
>>  8 | CMD_START_MLD_BSS_UPDATE  |                           |
>>    | [Type:CSA, Link:0, Tmpls, |                           |
>>    |  Cookie X + Offset,       |                           |
>>    |  Post Tmpl (No UHR ele)]  |                           |
>>    |-------------------------->|                           |
> 
> Not sure I understand the "No UHR ele" part - surely the post template
> still has UHR? Or did you mean "UHR parameter update"?
> 

At this point, the CSA post-beacon template would not include the
updated UHR operation element, since hostapd needs a way to determine
whether that element should be added. The updated UHR operation element
is expected to be reflected only after the advance timer expires.
In a scenario where the CSA completes before the advance timer expires,
the CSA post-beacon may not actually require the updated UHR operation
element.

Because of this, an event-driven approach was considered. For example,
if the UHR advance timer expires before the CSA completes, it could
notify hostapd, which could then update the CSA post-beacon template
with the updated UHR operation element via MODIFY_MLD_BSS_UPDATE.

> Not that there's a race here - "Sees Cookie X", but who knows the cookie
> X is even still valid?
> 
> But I think we can pretty much solve that racy by marking a cookie X
> invalid in the kernel (or even FW?) and rejecting the new
> CMD_START_MLD_BSS_UPDATE operation that still refers to Cookie X -
> hostapd would just have to know about that specific rejection reason (I
> guess netlink extended status would point to the wrong cookie attr or
> so) and then rebuild the templates without taking the update with cookie
> X into account.

In this case, cookie X would still need to remain valid for a UHR
critical update, since the countdown associated with cookie X would have
to continue alongside the cookie Y (CSA) countdown. Given that, it’s not
clear whether cookie X can be invalidated at that stage without
impacting the ongoing UHR flow.

> 
> But with that race aside, yeah, seems reasonable.
> 
>>    |                           |                           |
>>  9 |         Cookie Y          |                           |
>>    |<--------------------------|                           |
>>    |                           |                           |
>> 10 | CMD_CH_SWITCH_STARTED_    |                           |
>>    | NOTIFY                    |                           |
>>    |<--------------------------|                           |
> 
> I don't know - this was started by CMD_START_MLD_BSS_UPDATE too, so
> probably should be some generic notification about it, or like I said
> above, maybe isn't even needed at all?

It might be possible to rely on a generic notification when this is
started via CMD_START_MLD_BSS_UPDATE. That said, since CSA has existed
for a long time, I was wondering whether also sending CH_SWITCH_NOTIFY
for backward compatibility could be considered, at least initially.

> 
> (I think a good chunk of the channel switch notification is code
> unification between client and AP, does the AP even use the start
> notification?)
> 
>>    |                           |                           |
>> 11 |                           | Beacons: X=7, Y=10        |
>>    |                           |-------------------------->|
>>    |                           |                           |
>> 12 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
>>    | (Cookie X Post Tmpl w/    |                           |
>>    |  Chan Info, 3 Links)      |                           |
>>    |-------------------------->|                           |
>>    |                           |                           |
>> 13 |                           | Beacons: X=1, Y=4         |
>>    |                           |-------------------------->|
>>    |                           |                           |
>> 14 |                           | [X=0: Modify Cur Tmpl     |
>>    |                           |  w/ Post UHR Op element]  |
>>    |                           |                           |
>> 15 | EVENT_UHR_CU              |                           |
>>    | (CU_ADVANCE_COMPLETE)     |                           |
>>    |<--------------------------|                           |
> 
> That should have Cookie X somehow as an attribute, of course :)
> 
> Really all the events should have, but here clearly you meant X since
> the other operation isn't done yet.

Indeed, all the events should have the cookie X.

> 
>>    |                           |                           |
>> 16 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
>>    | (Cookie Y Post Tmpl w/    |                           |
>>    |  UHR Op + Param elements) |                           |
>>    |-------------------------->|                           |
> 
> What's this doing? Didn't we have post-Y templates already in the prior
> command? Otherwise isn't this quite a bit racy? Though I guess we have a
> whole beacon interval for hostapd to update everything, which really
> ought to be sufficient (though hostapd may need to stop being single-
> threaded ...)

This is mainly to allow updating the CSA post‑beacon template with the
updated UHR operation element. As you mentioned, yeah, While a full
beacon interval is available, it seemed possible that under heavier
event processing in hostapd, there could still be some short‑lived races
or inconsistencies.

> 
>>    |                           |                           |
>> 17 |                           | Beacons: X=127, Y=3       |
>>    |                           |-------------------------->|
>>    |                           |                           |
>> 18 |                           | Beacons: X=128/129,       |
>>    |                           |          Y=2/1 (CSA done) |
>>    |                           |-------------------------->|
>>    |                           |                           |
>> 19 |                           | [Y=0: Set Post Tmpl       |
>>    |                           |  cookie Y, UHR Param      |
>>    |                           |  Off, X=130]              |
>>    |                           |                           |
>> 20 | CMD_CH_SWITCH_NOTIFY      |                           |
>>    |<--------------------------|                           |
> 
> (similar comment as above wrt. what notifications are needed)
> 
>>    |                           |                           |
>> 21 | CMD_MLD_BSS_UPDATE_NOTIFY |                           |
>>    | (Complete Cookie Y)       |                           |
>>    |<--------------------------|                           |
> 
> Right.
> 
>>    |                           |                           |
>> 22 | CMD_MODIFY_MLD_BSS_UPDATE |                           |
>>    | (Cookie X Post Tmpl w/    |                           |
>>    |  UpdatedChan Info)        |                           |
>>    |-------------------------->|                           |
> 
> "X post" is a bit misleading ... it's still ongoing, because it's
> changed now but not really _after_ the update X, it's still advertising
> the update X has happened. So in some way the flow is still there.
> 
> But it does point out that we need basically three (additional)
> templates for a UHR update:
> 
>  - announcing the upcoming update
>  - announcing the update happened
>  - back to normal state afterwards
> 
> Which, perhaps, is indeed a bit too much to offload all to the kernel
> even in terms of the API, because if you mix another operation in (here
> in your example the channel switch Y), you end up with even more
> templates ...

That’s a fair point. With multiple operations potentially occurring in
parallel, it does seem possible that this could gradually result in an
increasing number of templates being involved.

> 
> So I'm coming around to the idea that you have a notification and
> hostapd has to update the templates at that point.

Yes, that does seem to align with the direction here. This approach
would still partially rely on event‑driven updates (for example,
reacting to a UHR event) to modify the BSS via CMD_MODIFY_MLD_BSS_UPDATE
for csa. At the same time, since such notifications would likely require
the beacon templates to be updated fairly promptly, it does raise some
open questions around prioritization and handling on the hostapd side,
particularly given its single‑threaded nature.

> 
>>    |                           |                           |
>> 23 |                           | Beacons Continue...       |
>>    |                           |-------------------------->|
>>    |                           |                           |
>> 24 |                           | Probe Request             |
>>    |                           |<--------------------------|
>>    |                           | [Fetch TBTT]              |
>>    |     send_mgmt (TBTT)      |                           |
>>    |<--------------------------|                           |
>>    |                           |                           |
>> 25 | send_mgmt (Probe Resp     |                           |
>>    |  w/ TBTT in UHR Param)    |                           |
>>    |-------------------------->|                           |
>>    |                           |                           |
> 
> Not sure I follow this part regarding the "TBTT" thing. Are you saying
> the RX of the probe request would have a TBTT attached to it? But does
> it matter, what matters is the TX? And that's probably impossible to get
> right?

What I was trying to describe is the handling of probe and association
responses during an ongoing UHR CU / EHT CU.

In such cases, when a probe request or association request is received,
the corresponding response may need to reflect the current countdown
state. For example, in the case of UHR, a probe response might need to
include an UHR parameters update element with the appropriate countdown
value.

The idea was that, at the time the response is being constructed, the
current countdown could be obtained from the relevant cookie and made
available to user space. This would allow hostapd to build the probe or
association response accordingly.

> 
>> The diagram uses a number of abbreviations, so an explanation is
>> provided below for clarity.
> 
> Oops, sorry, didn't see that before starting to reply, so maybe I missed
> something above. I'd go back and check, but I'll have to pick up my kids
> soon.
> 
>> Step 14
>> 	The driver/firmware can update the current beacon template with
>> the post‑UHR operation element. Until the advance notification interval
>> completes, the UHR operation element would not yet be updated.
> 
> Not sure I follow, are you envisioning the driver/firmware changing the
> beacon contents? I was envisioning it basically always getting the right
> template at the right time, and only filling the counters per their
> offsets.
> 
>> A few potential concerns to consider:
>>
>> 1. Carrying both the current and post‑beacon templates for all
>> affiliated links of an MLD might make the NL message fairly large. we
>> are not sure how well that fits with existing practice, since multipart
>> handling seems to be used mostly for dump commands. As an alternate, can
>> we have multiple commands with message id and reassemble it?
> 
> It's input into the kernel, so the size doesn't matter, I think? For
> notifications that might be an issue, and dumpit is used for data going
> _out_ of the kernel so userspace doesn't have to have arbitrarily large
> buffers ready before it knows the data, but on input I don't see how it
> matters.

Based on the earlier discussion in the below thread, I had wondered
whether there might be a potential bottleneck here.

https://lore.kernel.org/all/c7e383a9-c291-426b-a7f1-7845fabbaeeb@oss.qualcomm.com/

We will re‑check this internally to confirm whether that concern is
still applicable.

> 
>> 2. There may be a small sequencing aspect worth thinking through. For
>> example, if a UHR_CU operation is close to completion and we are about
>> to apply its post‑beacon template, but before hostapd processes
>> EVENT_UHR_CU with CU_POST_NOTIF_COMPLETE it issues a
>> START_MLD_BSS_UPDATE for CSA, we could potentially end up using an
>> unexpected version of the current beacon template. This may already be
>> handled by the existing flow, but it seemed worth calling out for
>> completeness.
> 
> Yes, I agree, it's something we need to think about. I mentioned that a
> bit above, perhaps one way to solve the race is to have a reject built
> in based on the cookie(s) being used, that could technically even be
> pushed all the way down to the firmware if you really wanted to.
> 
> johannes


Thanks,
Harshitha

