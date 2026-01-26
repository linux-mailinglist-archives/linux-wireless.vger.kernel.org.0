Return-Path: <linux-wireless+bounces-31163-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OKdJBkPd2lDbgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31163-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 07:52:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED9A84A19
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 07:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3A313004267
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 06:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A00721ABC9;
	Mon, 26 Jan 2026 06:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jk8ppHvA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MvjAoAQh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8200E2701B8
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 06:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769410326; cv=none; b=PcZ/jLJcARbKuKgAhaCDb9LvF3W82FWSLdBa56So2aU49aXO5/T3ZXS6fcUPUQ7RyI6hFxNd2Z4v9ql5gCIiJin6N79tiNU865gvPWH7IfAqD8jCrfqJNsVMxW4n/IuT7GkZjThh1kBhUy57sEaXFLETR4yR9yoyRy1hhBRqoFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769410326; c=relaxed/simple;
	bh=pVaQTdXT1Xch0IiPQ7NP8UVmYcCMk/A6tG5dQ1S+/28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnIWEc5a/oT6lB/1ztlhXpO3q5txctd+qX8nhV//jJRslhFNnmLu9H+k+6HqnMWU08vaIvjPFNf6zfibvKOlFzGP0ApLzLMNrfLImhS+V6Wc+XeCaGkj+zCMCVC5R22ExLpRdUrFIb4WbCf+4YoKiNiXVSeHNETOf+sE9DbAn5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jk8ppHvA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MvjAoAQh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PLKXPj762743
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 06:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1G1dpPgF7h2aF/XlD/npUdP88EeQ2KdGO18icjINGr0=; b=jk8ppHvAMHv9iBcM
	47dX78nGa8z7m+FJjEYn6uoBiG7WYZZy25rX4W5I61mT85UQ1GuCQwNLzoH2jon+
	MziSN//LKXPQkEkclHl79UDGfmUyqQwMkyUoODemlRRG5r0hc+d5DjQHTCKDthKR
	h7oDnrIuWc6i43Jh4krOJfjAteFSdWM2Xf0tPVkOjmyLZ5vgK/9HAT4Gz30nnWWB
	fA9VlPNFdLR7Zwkt8BjtwCQyp7umMTTOJTJlZqWp+gAMpWXZkxdP2yM1h7CE0Zn3
	te47RAf4IoH2a0wkZXImgNahyJnXnRTZCpdqDmG1lSFDZgZ8fRGCf+m+Kelfulz2
	oQzgnA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq9f3msf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 06:52:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c52d37d346dso2130300a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 22:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769410324; x=1770015124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G1dpPgF7h2aF/XlD/npUdP88EeQ2KdGO18icjINGr0=;
        b=MvjAoAQh5jdO/vpiXY/d/vn5V4HBfZ95yOsgE96AgpOtcU049ciMl7LUQ8opH0TYAS
         lgCmH2UTIuASsEmp/SZOzzx2FESnIrB6bsd3Lxhu03xn0MitQutlb9PIlh6ZLfkGYTNZ
         wVsKpt3vW65OBVGlBCJjw8KMRYjHf60fgyCYFe7dKW0kmXwyDH3oTWPrRhPeaDOdxmyy
         R93WKwZuIwM8h8LNDPpX4vpaT957FMmzwS1XmavHvaui3QptzIRyu1/ys4TTK4V6NT8X
         Xu56/L4BPddRzqrVvDD7F1TXkExMHfFuF88htIPE5KbJFVDv29jiJ9tOy41lZTqL4kvC
         7LDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769410324; x=1770015124;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1G1dpPgF7h2aF/XlD/npUdP88EeQ2KdGO18icjINGr0=;
        b=baAJbFuiUhPKeNtFTMf07+khkyK5PYIbgx4zREBD+3BB+gqtbe/NjBCDfZfqdLZzEt
         83k/top5buX+OsZvEA2pdi5ZupRqq/RrCx+9iQjJ1ZmPpfsBfgltSnKYFnMzQqoqztk8
         hz7vgxQU1KU4+GDeCh9JE4tx2dfxFnHtMprBhceCKHzdvgiEaBusPE+7iEPlNEmh1HyJ
         xXYnDXx/KUnuAu/tbOwAe3e/fpsrIUKPukmv9NcLUrigUEnDtuH2vIeuqtUNUYDHnlSW
         9MN6rwv92LFdsJlvPdvXbH6RGkbukvTxNP9nnsP0BvkhlDuARYUI3ggnSXISvHqeuauj
         duVA==
X-Forwarded-Encrypted: i=1; AJvYcCWys3o5Vj8E1cGMdtG6rOkaJLRsGUpyesW4plyiNW1e4JbNlF/WXVOVsw72JbSGokjtFaTqre/h9balOPLkDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXkaBSmcY6lzXCXadsX7hmH2X9AVUCrSXQqeFyXOZRkFGb63jK
	bYZ/Y/3QN0OLd2MEanuuK1Zcg3Z/NYL02OFdJmtiLAKxYMaov2G8lnrifFub4BQvA2pb/UBV85p
	2CWRjLSmgcbbDIuvxo4scD4BA2AMUUV+JJmmnp1LwZ5d2T8QSPFthbXmSv40WBg2/inQJwjbXKy
	l+gA==
X-Gm-Gg: AZuq6aKx7TLS164wj78iILLHNyAFrEgxmFRm7bkomk8Mu3aJOoRwqEB8/Slr4Rpl28/
	MyBf1hZlUIY6iwxCUMWAhr95QmAfXuP9CVxXAnnChNSOE5vQO0blwQc/8O7qhUUERS5hTzEv0vL
	3N2k6Go8hr+wLaN9X9IEAYDe7DGK6xFd9AXDDOAJgBn4o+w2JZfu7ERWe+FV2d+QBvbpcdqchR3
	TFYC4j2Dsy1biFbnrMdBitY0jkUknBj8t/I06Ydl6kIO/PcmQguuUR7LpSB9BBF5xmXjqB3ugjC
	U2pt0O4dz0L4eEd+2PEdRuDJF3fSz5Ad2cl/OLwS7Uzvd42DYFi2su56OAD+3jUr3PaDogF/8T7
	fpFN8tnub5K1Hlywa/BDZ234J9MyVnfdu7Aei1BMrIQBr11wUienFwO/prz3s41WeYB5AWZA=
X-Received: by 2002:a05:6a21:32a4:b0:38d:e87c:48b0 with SMTP id adf61e73a8af0-38e9f0e9ca5mr3246887637.13.1769410323514;
        Sun, 25 Jan 2026 22:52:03 -0800 (PST)
X-Received: by 2002:a05:6a21:32a4:b0:38d:e87c:48b0 with SMTP id adf61e73a8af0-38e9f0e9ca5mr3246876637.13.1769410323010;
        Sun, 25 Jan 2026 22:52:03 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm8515934b3a.69.2026.01.25.22.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 22:52:02 -0800 (PST)
Message-ID: <ad7a2168-58d8-4afa-8744-84a34a63cd09@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 14:51:59 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Remove broken frequency range filtering
To: Saikiran B <bjsaikiran@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        kvalo@kernel.org
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
 <20260123155750.6007-5-bjsaikiran@gmail.com>
 <ec1a3721-a17c-47dc-85d3-0e0b97004c2c@oss.qualcomm.com>
 <CAAFDt1syi0jLvrho4mnvwsv8HtraT78wP8tCLFHRw3oiTq2E5w@mail.gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAAFDt1syi0jLvrho4mnvwsv8HtraT78wP8tCLFHRw3oiTq2E5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YLGSCBGx c=1 sm=1 tr=0 ts=69770f14 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=-oiKkipkm7vCZl0rOUcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: dke_PRZxIEtG9Twdt0vQzUDiKa0z47po
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA1NyBTYWx0ZWRfX2XQGmOmpMi6B
 cqvnRFuFKgYr+oI1ppgx3bwxQE+oWxxv3AjjpYdAZLfat/4NiNPGCU85DWbarZWrCxLjtBrU48R
 ySEieVx8h95JgrPHtV9HhK8ugypUZ4Hwp9kF8oF0Q/QiK7/MxEmqcZWZIUihmeP3kz5PONdqr/Q
 B5kSryEK9qeQ3W6ybgzKxC8WAfGfcJfYjXpOUHgC2kDfWlKParsOKrmwu/lE+UMg6glPNMnAdXu
 ty5JKt7t64nqgC0/TvDpGjUH8B1peZB6EPH3pATSlcuRBr9B/gyu+NuTuUHtlAR8KEOmIuLZf62
 /4KvHrkvcwMPezfKAj0jrkh6BjcVN6DtH0oi1McVk//s3KMGNUfU7YdTIAkagVFzWL/3xc94OFN
 yTjslPtmDlyUGLpxncLiaI0CL8i8UgklNsfsABLp1tXifOp7uIj+kTTlV74ddlTI9CUNd9ckxiZ
 0MrEsoQ1vL7Nd/PWMfQ==
X-Proofpoint-ORIG-GUID: dke_PRZxIEtG9Twdt0vQzUDiKa0z47po
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260057
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-31163-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DED9A84A19
X-Rspamd-Action: no action



On 1/26/2026 2:35 PM, Saikiran B wrote:
> Hi Baochen,
> 
> Thanks for the review.
> 
> regarding ath12k_mac_update_freq_range(): You are correct that this
> function eventually updates the frequency range.
> 
> However, on the WCN7850 (Lenovo Yoga Slim 7x), there is a race condition
> during boot/resume. ath12k_reg_update_chan_list() is being executed *before*
> ath12k_regd_update() has finished populating ar->freq_range.

could you please elaborate on the race?

> 
> At that specific moment, ar->freq_range.end_freq is still 0. The check: if
> (center_freq > KHZ_TO_MHZ(ar->freq_range.end_freq)) evaluates to true for
> all channels, causing the driver to silently drop every 5GHz channel from
> the scan list.
> 
> If I cannot remove this filter entirely, would you accept a V2 that skips
> the filtering if the range is uninitialized?
> 
> Example:
> 
> /* Skip check if regulatory range hasn't been populated yet */if
> (ar->freq_range.end_freq != 0 &&
>     (center_freq < KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>      center_freq > KHZ_TO_MHZ(ar->freq_range.end_freq)))
>         continue;
> 
> Without this change (or something similar), 5GHz is completely unusable on
> this platform.
> 
> Thanks & Regards,
> Jaya saikiran
> 
> On Mon, Jan 26, 2026 at 11:15 AM Baochen Qiang <
> baochen.qiang@oss.qualcomm.com> wrote:
> 
>>
>>
>> On 1/23/2026 11:57 PM, Saikiran wrote:
>>> Between kernel 6.16 and 6.17, ath12k added frequency range filtering in
>>> ath12k_reg_update_chan_list() that filters channels based on
>>> ar->freq_range.start_freq and ar->freq_range.end_freq.
>>>
>>> However, these values are reset to 0 in ath12k_regd_update(), causing
>>
>> Yes, it is reset at the first, but it get re-calculated later. See
>> ath12k_mac_update_freq_range() called in ath12k_regd_update().
>>
>>> the filter to skip ALL channels:
>>>     if (channel_freq < 0 || channel_freq > 0)  // Always true when
>> end_freq=0
>>>         continue;  // All channels skipped
>>>
>>> This results in no channel list sent to firmware, causing 5 GHz Wi-Fi
>>> to stop working.
>>>
>>> Fix by removing the broken frequency range filtering. The firmware
>>> itself handles frequency range restrictions based on hardware
>> capabilities.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
>>>
>>> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
>>> ---
>>>  drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
>>>  1 file changed, 13 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/reg.c
>> b/drivers/net/wireless/ath/ath12k/reg.c
>>> index 2dfcef013277..2d9adc74ac6e 100644
>>> --- a/drivers/net/wireless/ath/ath12k/reg.c
>>> +++ b/drivers/net/wireless/ath/ath12k/reg.c
>>> @@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar,
>> bool wait)
>>>                       if (bands[band]->channels[i].flags &
>>>                           IEEE80211_CHAN_DISABLED)
>>>                               continue;
>>> -                     /* Skip Channels that are not in current radio's
>> range */
>>> -                     if (bands[band]->channels[i].center_freq <
>>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>>> -                         bands[band]->channels[i].center_freq >
>>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
>>> -                             continue;
>>>
>>>                       num_channels++;
>>>               }
>>> @@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar,
>> bool wait)
>>>                       if (channel->flags & IEEE80211_CHAN_DISABLED)
>>>                               continue;
>>>
>>> -                     /* Skip Channels that are not in current radio's
>> range */
>>> -                     if (bands[band]->channels[i].center_freq <
>>> -                         KHZ_TO_MHZ(ar->freq_range.start_freq) ||
>>> -                         bands[band]->channels[i].center_freq >
>>> -                         KHZ_TO_MHZ(ar->freq_range.end_freq))
>>> -                             continue;
>>> -
>>>                       /* TODO: Set to true/false based on some
>> condition? */
>>>                       ch->allow_ht = true;
>>>                       ch->allow_vht = true;
>>
>>
> 


