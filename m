Return-Path: <linux-wireless+bounces-25888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8AFB0E9AA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D368D6C6A0B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 04:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CD0188CC9;
	Wed, 23 Jul 2025 04:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCYX4uXq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CCE2AE72
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245305; cv=none; b=Etrg/cRSQ2JZSb0KzR8S1LVO5YkynrjpdwuOYSJpDylV0DYO+7u5ryaFCW8ukQNR/0SzAMwu2vglCxJKJw4FxgUKaG+rb8Hjpzm5EE2tAJu3JcJYVY8sDIvCewgOPqq7j7lhtz9HEZJNkV8+HRtpIrAXbFyhxpbpVc5mR8J0/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245305; c=relaxed/simple;
	bh=OwG03qZCu9KPKPJZFT+pn7Huyz552CNUDpWIQfA9f1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGGmqpNUwDkVtLxGzvJYnBN+GsZM83NjxQ/2hYCZLSfSyyYobsVQ5tzxdciiEM9a3kJAbW66aGeYw+k8ZaGHhquOCXWY7KqmUE59Qb+5ISksYfl6I4rRsK5BMyPlY4O+Q+FctxjN1xstmmeqXaeB9k/S50qk8d8yHGi/x0mLvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jCYX4uXq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MNMvML029007
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 04:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KrSbaN29GdT/vLbAs7S1kiitGLBjKqOnVWh7YJiKZGA=; b=jCYX4uXqYI1rRScD
	5ZxnJibox8x68FVX2kMN/hXUHn87CDpI06bY18E55aswcKxM+dhJ1bgT1WGnsrlH
	t+Gy/mr9uJF29gIf65Tg0LMn2EJSqrvV4ciQbRomJq3RdecF5ZkH9q+lUDwEmTgH
	nAUOQOsrT+2D2edV4VjjqkKfTkXaSZWlrpPhBMNn0t6V2ZVhexEFMk4XOiHY6sgA
	BmR2OyJxyQyAMq6mXUz3Xx9xT9GSuN7WxUtOb0lsneLtROQ4ganMygzSVmYePBo4
	hXO6MdOqszPvF5Zyxl/S4n3LQst0g/JlU1nxuutH5tIHk5aHkvTp3aERj2KKwrf4
	Hz7zLg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6p15m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 04:35:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235f77f86f6so60854435ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 21:35:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753245300; x=1753850100;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrSbaN29GdT/vLbAs7S1kiitGLBjKqOnVWh7YJiKZGA=;
        b=j7GZnUxvMolud+g8n/NNYq5Y+/6ABMcN3eI2nZQ36S7nFjpyr97c5BVGN1osYA/otW
         3FBJHydTaf7vQP3a6XaRvGRjuAuoxogv9cXMMaR3oCkrfyBjIe1KQ0oLar9mZgudjSBi
         y9Hr5NAMIDtHUZ6EdyFyFUhcdQQCGSJ22yV3FZFBWS/QTHL9SMps+tzeGJ1LeGgQFp8x
         MoSZbZaRc14Asq6ofiYwdITaeERJ6lyE+o/C925W0WSQlhxjTa9/OhciRF86VOGlj3/t
         KLr9xpscyF8TBLGS1MlioUp2ELXnnLO4jxe7L3LAfI8PnjRFPgBqR5hW1IGF7nk3A5DY
         y0lQ==
X-Gm-Message-State: AOJu0Yx29/KPEGZ3TJeXn6d4ww0CTUK9ktc72rovFsLHuZKzfWWUP+kC
	kQouAlzhOAc3g+9RmCqHuksUzzNpF9mVr62PfJ7Vd1ytyNuNZMSW0GBoD7QcyLUrT8VuWuSivE9
	hBYdFeSYvyHhZWIEqRSFF0Gy4RmHSuG2RfSvReuvt8G7KHEp2hbubxRWq1TF9etpocTPJnw==
X-Gm-Gg: ASbGncuR/uRV5JHPjZPQFspq9W1CxeBfnCicuKO7klPSu3YdevpomwXwTYABbyd0M8P
	F9CXU9zFJxBC9tXUt6foFMNOLouJ7fAA8NxApTdIBsXtBB0ZeX3Sz7UzwABlzhAlq2jFV6gqvxA
	Chp6oL+mgBUKbXKtxfHIcMlkFnd+DGlQu9CO/XK5W2Rndfwu9TbehcBFjvSPU0ENLPTxK4mbf4k
	Wwo0W51lFVze9ANpfyqJ1hd7tqQ9obt8HKvSZP5oscNDOYdN60ZSm0h+31DRzw96tDScErLQ+Ms
	EAzg3IQQXbcfH4XSwiY1Hf4c2zkY9QPVdpE98fJ942UIDVdGJQIkrh2DM9as/DtTtvfwtjKArZq
	hUXI=
X-Received: by 2002:a17:902:dac8:b0:235:eb71:a386 with SMTP id d9443c01a7336-23f981e6ceamr21602755ad.50.1753245299710;
        Tue, 22 Jul 2025 21:34:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBaUb5dKijoq3eiJkmmkk93Jyuz5zC9IV4x4rqdZ3/Sftt/K3CPGM+Po0qc8lK+xKsLtrUqw==
X-Received: by 2002:a17:902:dac8:b0:235:eb71:a386 with SMTP id d9443c01a7336-23f981e6ceamr21602445ad.50.1753245299035;
        Tue, 22 Jul 2025 21:34:59 -0700 (PDT)
Received: from [10.152.194.206] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2d6fsm87135655ad.20.2025.07.22.21.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 21:34:58 -0700 (PDT)
Message-ID: <4a94fa66-8140-4cc8-996c-0ed097b4004a@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 10:04:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DESIGN RFC] Critical Update handling in the kernel
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Ping-Ke Shih <pkshih@realtek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
References: <20250717045540.27208-1-aditya.kumar.singh@oss.qualcomm.com>
 <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <1a77ca6a35ad03f839b7c997de3977b521d88edc.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=68806675 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=WkxSdC04kqPbBLiDnJoA:9
 a=nM91SIqpUZvjnRJH:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: RNA5pJKsh6wq0-KGqKwyAt1mMUybGKGF
X-Proofpoint-GUID: RNA5pJKsh6wq0-KGqKwyAt1mMUybGKGF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNSBTYWx0ZWRfX5j5BAFqlz8Lf
 lxbMHLIl7grE0bOOrYuqig3jrELHvfYoXd0WllyAK3AKKXe/mJQ8/CdBskAfj2F+gBY25XtK2n4
 3/32tW1gFcZ7pZYHdByb2U7000G2v7QUfdg5InlkCn/qludAWaIPiOPcR6NrDCEvBjfXgvtnOoE
 xxHYd4ta1UYg2Yx9BcsE3kEU8gdKSTylHWNRibK4wAoMRIzl3X+82zH2GgG1zgAWL6sJA5ZNnku
 t4r3iS4hgeEKMZT9pq51CemO9OVlGdO6daGDIJ3CdbWakqObcfrHu51ef+R9APIl6ugkQ9wM15h
 LEAO7ypENn5p11g/N+l6Mu9KFZ3PsNafl0gSsd27W4Wir6xP8qcfiooRz9QwMTw0MMdlUEjntb4
 jcBXWp/Zfd1IKcUq2y/2xoRVThp8kB9zo/VD2YgL1B7HusI9/9/hrFyZJDEvRtbzAjYX0vK+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230035

On 7/22/2025 8:12 PM, Johannes Berg wrote:
> Hi,
> 
> Thanks for writing this up! I really think Realtek and Mediatek should
> comment - CC'ing some folks.
> 
>> "What about vendors whose firmware does not support this functionality?"
>> "What about mac80211_hwsim? How this is supposed to work with
>>   mac80211_hwsim?"
> 
> I really like the hwsim part because we really can't even test the
> client side right now ...
> 
>> ===========================================================================
>>                              OPEN QUESTIONS
>> ===========================================================================
>> Before we move forward with implementation, we'd like to confirm whether
>> the proposed design looks sound. Are there any concerns or potential issues
>> we should be aware of?
>>
>> Out of curiosity, we're also interested in understanding how other vendors
>> are currently handling this feature in their downstream drivers. Is it
>> typically offloaded to firmware, or is the logic implemented in the kernel?
>> Just want to confirm whether all this will be used only by mac80211_hwsim
>> or will there be any actual users?
> 
> I think Ping-Ke previously indicated that they were planning to do
> things host side? I'm not super familiar with the timing constraints
> though, so I'm not sure what that might imply.
> 
>> Critical Update is a mechanism where, if a BSS parameter changes on one of
>> the links within a Multi-Link Device (MLD), that change is also signaled in
>> the beacons/probe response of its partner links. This allows the multi-link
>> client to be proactively informed of the update through any of the partner
>> links, rather than waiting to receive the updated beacon/probe responses
>> from the affected link itself.
> 
> FWIW we also have some client side code for it already. It's probably
> broken ;-)

Yes, I’ve seen that. I’m not entirely sure if it’s broken, but it does 
seem related to CSA parsing from the link—there is code handling that. 
If anything turns out to be broken, we can fix it.

> 
>> This ensures that multi-link clients monitoring Link B can be promptly
>> informed of the change on Link A, without needing to wait for Link A’s next
>> beacon.
> 
> Btw, you make this a lot about "without needing to wait" and the whole
> timing, but another, I'd maybe even argue more important, aspect of this
> is that they don't have to be receiving the beacon at all. For example
> for EMLSR clients, or clients that aren't even active at all on a given
> link, they might not/cannot see the beacons for all links at all, even
> if they're nominally connected on those links.

Yes, that's true as well! I just wanted to keep the context 
straightforward and avoid bringing in another feature that might cause 
confusion. But you're absolutely right.

> 
>> ===========================================================================
>>                              DESIGN PROPOSAL
>> ===========================================================================
>>
>> Assumptions:
>> ------------
>> The critical update procedure is highly timing-sensitive.
> 
> There are two aspects here that I feel maybe you're conflating a bit. On
> the one hand, yes, some of it needs to have the precise information for
> the counters. OTOH, some of it is really not _that_ timing critical,
> e.g. whether or not you actually get the information live at exactly the
> right time. Though of course a frame that's transmitted after a beacon
> that advertised CSA should not suddenly _not_ advertise it even cross-
> link.

Absolutely! We acknowledge that achieving the ideal case may not be 
possible. Keeping the logic in the kernel brings us closer to the 
expected behavior, whereas shifting it to hostapd would likely result in 
a much larger deviation.

> 
>> This design introduces additional computational overhead, which could
>> potentially delay beacon processing. Since not all mac80211 drivers may
>> prefer this behavior, introduce a new extended feature flag -
>> CRITICAL_UPDATE_SELF_MANAGED. mac80211 will NOT perform these extra
>> computations if the driver advertises this feature support.
> 
> Fair.
> 
>> Parsing the beacon update:
>> --------------------------
>> During the ieee80211_assign_beacon() call (where link->u.ap.beacon is
>> updated whenever the beacon content is initially set using
>> ieee80211_start_ap(), modified through ieee80211_change_beacon(), or
>> changed as a result of channel or color switch events) -
>>
>> 1. Store the new beacon data in a new pointer, following the usual flow.
>> 2. Parse the beacon (using the head and tail pointers) and record the
>>     starting offsets of each required Element (earlier referred to as IE i.e
>>     Information element) in an array, indexed by element id or extended
>>     element id. This is done per link object.
>> 3. If a previous beacon exists:
>>      3.1 For each element related to the critical update, perform a memcmp()
>>          to detect changes compared to the previous contents.
>>      3.2 If any such element has changed, set the critical update flag in
>>          some link-level object (e.g., link_conf). (this is for the affected
>>          link)
>>          3.2.1 At the same time, set the critical update flag for all
>>                partner links as well in the same object.
>>      3.3 Increment the BPCC[2] value (modulo 256 excluding 255) for the
> 
> (as an aside, I think this is really funny - it's obviously the same as
> "modulo 255", but I guess I can also see why they worded it that way...)
> 
> 
>>          current link.
> 
> Wouldn't it be far simpler to have hostapd indicate the critical update,
> and even the BPCC value? It also has to include BPCC in RNR and other
> fields, do we really want to _parse_ all of that and update all those
> values?! Seems iffy at best.

The challenge is that if hostapd takes on this task, it would need to 
send updates for all partner links. Theoretically, this could result in 
up to 15 beacon NLs being transmitted. Processing these NLs and updating 
the beacons would already be time-consuming. On top of that, managing 
the additional offsets required to update the counters adds another 
layer of complexity.

OTOH, the proposed design just takes 1 NL update and rest it does 
automatically what is needed which will be less time consuming than 
multiple NL commands flow.

> 
>> 4. If critical update flag got set in previous step for partner links, call
>>     link_info_changed() with CHANGED_BEACON to notify lower layer that
>>     beacon has changed. This applies only in case when beacon is offloaded
>>     to firmware. In case beacon is given to driver at every TBTT, there is
>>     no need to notify since at next TBTT, driver will fetch the latest
>>     beacon anyways.
> 
> Sure.
> 
> 
>> Forming the new beacon:
>> -----------------------
>> In the __ieee80211_beacon_get() function, where the beacon SKBs are
>> constructed:
>>
>> 1. Allow the existing logic to generate all beacon SKBs (including multiple
>>     SKBs in the case of MBSSID-EMA).
>> 2. For each beacon SKB:
>>      2.1 Parse the RNR (Reduced Neighbor Report) element.
>>          2.1.1 For each TBTT Info entry:
>>              2.1.1.1 Extract the BSSID
>>              2.1.1.2 Retrieve the corresponding link sdata from BSSID
>>              2.1.1.3 fetch the latest BPCC value.
>>              2.1.1.4 Update the frame with this latest BPCC value.
> 
> Yeah, I really don't like that... Do you really do that in firmware
> today? That sounds all really painful.

Not exactly this way, but yeah firmware does all this in offloaded case.

> 
>>      2.2 Parse the MBSSID profile element.
>>          2.2.1 For each non-Tx profile:
>>              2.2.1.1 Extract the BSSID
>>              2.2.1.2 Retrieve the corresponding link sdata from BSSID
>>              2.2.1.3 If the critical update flag is set in link object, set
>>                      the CU (Critical Update) bit in the capability element.
>>              2.2.1.4 Set non_tx_update = true.
>>      2.3 Parse the multi-link element.
>>          2.3.1 For the self link (already known), fetch the latest BPCC
>>                value.
>>          2.3.2 Update the frame with this BPCC value.
>>      2.4 Update the capability element in the SKB:
>>          2.4.1 If the critical update flag is set, set the CU bit.
>>          2.4.2 If non_tx_update == true, also set the non-Tx CU bit.
> 
> How much of that can we let hostapd do?

hostapd forms beacon so it can do all of this. The only bottleneck is 
communicating all link's beacon update sequentially via NL. And if 
another update happens in the meantime - for example link A started CSA 
and then link B also started CSA, these will pile up the NL socket queue 
with beacon updates.

> 
>> This mechanism sufficiently handles critical updates due to modifications
>> of existing elements (elements related to the critical update which are
>> already present in the beacon and just one or more field is/are changing
>> its value). However, in the case of new element inclusion (elements related
>> to the critical update which are not alread present in the beacon, but is
>> getting added from next beacon), additional handling is required.
>> Specifically, the newly included elements related to the critical update
>> must be added to the per-STA profile within the Basic Multi-Link Element
>> (BMLE) [3].
> 
> That seems almost like an over-optimisation? If I'm reading this
> correctly, this is basically describing a situation like this
> 
> (x indicates a beacon TX)
>   
> link 1    x        x        x        x        x        x        x
> link 2         x        x        x        x        x        x        x
> 
>                       ^ link 1 starts channel switching
>                         (after its own bcn, before the next link 2 bcn)
> 
> and saying that really the next link 2 beacon will already indicate the
> link 1 beacon will be switching channel.
> 
> But is that really actually a case worth worrying about? You can always
> consider it as if this had happened:
> 
> link 1    x        x        x        x        x        x        x
> link 2         x        x        x        x        x        x        x
> 
>                           ^ link 1 starts channel switching
> 
> i.e. as if link 1 had decided to do channel switch just _after_ link 2's
> beacon instead.
> 
> Does that really significantly change anything? I'm not so sure?

You're right, but that's not quite what the original text is trying to 
convey.

There are generally two types of critical updates:
   1. Adding a new element, such as CSA or CCA.
   2. Modifying an existing element, like VHT/HE/EHT Operation IE, TWT, etc.

In the second case, forming the beacon is relatively 
straightforward—only the BPCC and the critical update flag need to be 
set. However, in the first case, it's more complex. You need to insert 
the new elements (e.g., CSA IE) into the per-STA profile of the affected 
link within the reporting link, as shown in the earlier diagram.

-----

Link A started CSA and during CSA, the beaconing would look like -

┌──────────────────────────────┐ ┌──────────────────────────────┐
│       Link A's beacon        │ │       Link B's beacon        │
│                              │ │                              │
│┌────────────────────────────┐│ │┌────────────────────────────┐│
││Capabilities Info:          ││ ││Capabilities Info:          ││
││   BIT 6: CU Bit: True      ││ ││   BIT 6: CU Bit: True      ││
│└────────────────────────────┘│ │└────────────────────────────┘│
│┌────────────────────────────┐│ │ ......                       │
││CSA:                        ││ │┌────────────────────────────┐│
││  CS Count: 5               ││ ││RNR Element:                ││
│└────────────────────────────┘│ ││  TBTT INFO:                ││
│......                        │ ││    MLD INFO:               ││
│┌────────────────────────────┐│ ││       LINK ID: A           ││
││RNR Element:                ││ ││       BPCC: 2              ││
││  TBTT INFO:                ││ │└────────────────────────────┘│
││    MLD INFO:               ││ │......                        │
││       LINK ID: B           ││ │┌────────────────────────────┐│
││       BPCC: 1              ││ ││MULTI LINK Element:         ││
│└────────────────────────────┘│ ││  COMMON INFO:              ││
│......                        │ ││     LINK ID: B             ││
│┌────────────────────────────┐│ ││     BPCC: 1                ││
││MULTI LINK Element:         ││ ││                            ││
││  COMMON INFO:              ││ ││  Basic STA profile count: 1││
││     LINK ID: A             ││ ││  Per STA Profile:          ││
││     BPCC: 2                ││ ││     Link ID: A             ││
││                            ││ ││     ┌─────────────────────┐││
││  Basic STA profile count: 0││ ││     │CSA:  *THIS ONE*     │││
│└────────────────────────────┘│ ││     │  CS Count: 5        │││
└──────────────────────────────┘ ││     └─────────────────────┘││
                                  │└────────────────────────────┘│
                                  │......                        │
                                  └──────────────────────────────┘

(See the CSA element (marked with *THIS ONE* ) in link B's beacon due to 
link A doing CSA).
-------

So to handle this case (additional of new element), the below steps are 
additionally required on top of what was already explained above.

Does this make sense now?


>> To achieve this:
>>
>> 3. Allow the existing logic to form the beacon SKB as previously defined
>>     (this already handles modification updates).
>> 4. Maintain an extra_len variable to track any additional space required
>>     for including additional elements.
>> 5. While parsing:
>>      5.1 If critical update is going on in partner link due to inclusion of
>>          elements, increment extra_len accordingly.
>>      5.2 The required length is determined using the eid/ext eid based
>>          offset  maintained in each beacon data structure.
>>      5.3 Since the element offset is known, and the next byte is the tag
>>          length, the total length is tag_len + 2 (for EID and length
>>          fields).
>>      5.4 Account for any additional fields that may be needed (e.g.,
>>          sub-element ID and length in the Multi-Link IE).
>> 6. Compute the new beacon size:
>>       new_size = current_size + extra_len
>> 7. Allocate a new SKB with the updated size.
>> 8. Copy the existing contents and insert the new or updated elements at the
>>     appropriate offsets.
>> 9. Since IE offsets are cached in the beacon data structure, the entire IE
>>     can be copied directly without re-parsing the full beacon from other
>>     links.
>> 10. Free the original beacon SKB.
>> 11. Return the newly constructed beacon SKB.
> 
> That kind of also seems like hostapd could just update the beacons?

Yes it can. Only thing is multiple NL beacon updates.

> 
>> DTIM beacon handling:
>> ---------------------
>> As per requirement [4], the Critical Update (CU) bit in the capability
>> field must be cleared in the DTIM beacon.
>>
>> For Non-Offloaded Beacon Handling:
>>      1. The function __ieee80211_beacon_add_tim() is responsible for
>>         updating the DTIM count.
>>      2. When the DTIM count reaches 1 (indicating that the next beacon will
>>         be a DTIM beacon), the critical update flag in the corresponding
>>         link object should be reset.
>>
>> For Offloaded Beacon Handling:
>>      1. If precise control is required:
>>           1.1 Since DTIM updates are managed by the lower layer (typically
>>               the firmware or driver), an API will be provided to explicitly
>>               reset the critical update flag.
>>           1.2 The driver, upon detecting that a DTIM beacon is about to be
>>               transmitted, can invoke this API to perform the reset.
>>      2. If some timing inaccuracy is acceptable:
>>           2.1 mac80211 can maintain a timer to reset the critical update
>>               flag after a DTIM interval.
>>           2.2 However, this approach may lead to synchronization issues, as
>>               mac80211 cannot guarantee the exact timing of beacon
>>               transmission handled by the hardware.
> 
> I guess I can see where this is needed, yeah. I think I'd probably go
> for 1, it's simpler for mac80211 and worst case drivers can have a
> counter or something themselves and do that after pulling the DTIM
> beacon from mac80211.

sure.

> 
>> Update BPCC back to NL:
>> -----------------------
>> After the kernel increments the BPCC value, it can emit a netlink event
>> containing the updated BPCC value. This allows hostapd to receive the
>> latest BPCC and include it in probe/association response frames, as
>> required by the specification.
>>
>> This coordination ensures that all - beacon, probe response, and
>> association response frames reflect consistent BPCC values, maintaining
>> compliance with spec-defined behavior for multi-link and critical update
>> handling.
> 
> Yeah not liking this too much I guess... Why can't hostapd maintain
> BPCC?

It can only when everything is fully handled by hostapd. Otherwise 
kernel should be owner of having the latest value. It can report the 
latest value to hostap upon any change.

> 
>> Counter offset handling of partner links:
>> -----------------------------------------
>> Note: This applies only in case of offloaded beacon case.
>>
>> Since not all links operate with the same beacon interval, the firmware
>> cannot simply decrement the counter on every self-beacon transmission.
>>
>> To handle this correctly:
>> Each BPCC counter will be associated with:
>>      * An offset (location in the frame where the counter resides), and
>>      * A periodicity value, indicating how often the counter should be
>>        decremented.
>>
>> The firmware is expected to:
>>     * Track the number of self-beacon transmissions per link.
>>     * Decrement the counter only after the specified number of
>>       transmissions, as defined by the periodicity value.
>>     * This ensures that counter updates are aligned with each link’s
>>       individual beacon schedule, maintaining spec compliance in multi-link
>>       scenarios.
> 
> True. Although I expect some devices might simply prevent different
> beacon intervals.

True, but in case if not, still it can be handled I guess.

> 
>> Complexities:
>> -------------
>> When adding elements in per STA profile, the element length might exceed
>> hence fragmentation needs to be handled properly.
> 
> We have fragmentation but all this parsing means also we need
> _defragmentation_ first, which is awkward?

I think de-fragmentation is already supported ? If not, we will have to 
add it to support it.

> 
>> memcmp vs hashing
>> =================
>> In the section where memcmp() is used to detect changes in beacon elements
>> (to determine if a critical update is needed), this logic could
>> alternatively be handled at the hostapd level.
> 
> Yeah sounds better to me :P

Okay so only the link which is undergoing a change, hostapd will signal 
to kernel about critical update? Rest kernel will handled parsing and 
updating the partner links as per the need?

> 
>> Since hostapd does not retain the previous beacon frame, it cannot perform
>> a direct memory comparison. However, it can compute and store hashes of the
>> required elements during beacon formation. On subsequent updates, it can
>> compare the new hashes with the previously stored ones to detect changes.
> 
> It doesn't necessarily even have to do that - it could also track
> internally when it made changes. Like when something actually starts a
> channel switch. Or color switch maybe, or something.

True when adding, it can do easily. But when modifying, it has to have 
some older value to compare with.


-- 
Aditya

