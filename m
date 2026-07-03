Return-Path: <linux-wireless+bounces-38553-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ucSEC840R2r8UAAAu9opvQ
	(envelope-from <linux-wireless+bounces-38553-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 06:04:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B76FE495
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 06:04:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mYXqgeJW;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=giJ2Ge1f;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38553-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38553-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 419FF3036EEC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 04:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489CB313535;
	Fri,  3 Jul 2026 04:04:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D513D539
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 04:04:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051465; cv=none; b=Tp2fSZ0e40JCHetjtfN4QhT8vFr36NcR0hjeiDlUH4XmIDxEQ9mngHPBtUqOaNue9TVxUJ4OIphF4LKknvq8oSK2xfuzat750EhPwPH4JcnTt2drwUMVmHkVwnktsuBBJCEdJpYRhdD89kJdnAhNjUg/v9FSi05Cov8wJCp4ubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051465; c=relaxed/simple;
	bh=kf/yeeVf4WxfhkoYyJbFFPpZX0wBWrQCx5re/O82vFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7SFbU00ES0sz71672JohVGq1O7Qb6spOyHKfydOIKMO7P8FwrcHqyEgT6H9zZQdjG6XLIfwcSZ8kp0c6f0EA+cdSt4MInENV1Bcv7M0hwuwzXlT5fmzE3KPaqIbojS/KFhmeQ6P8aJhBQ/eMtsmzd3TY2sPEcI5GiTntC1bkbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mYXqgeJW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=giJ2Ge1f; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66342fVO2701382
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 04:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cuaojvJeCpfd+fb1L4y3F4PQXD2n4Bkmi4X904ZQT9E=; b=mYXqgeJWrZw+iqp1
	EfP+MdjWkSf+bp9Zygv4U5szLfKHGC0FopoICZ8F/Q1YAluTEkCrLx7LJSBkQT3f
	MyC58oM673XpXDfBNxW372e1z/aDdaokwtnxwBV3eTLZS7plvr+SuPmIHLN5B0IF
	NX/nvNwyOCU2CdpYOAsMWSOp5UHar6Lh1JOBwMtpLeiSLYOgHClauFBFFjkA68wK
	4TvwOHXr7DwDByeZdC/6B0x3tVC/pLsXRr2V8sZxIthsc6ZH8iym6qDy/+ggCyd1
	HdCP+wGYmaEm5Sjj7KjnJQX9o8WUskxEMMJgtThHssAPrrGusWPIk4iQpAyQ3ecU
	VO118w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bm1qm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 04:04:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8620ee0971so252678a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 21:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783051455; x=1783656255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cuaojvJeCpfd+fb1L4y3F4PQXD2n4Bkmi4X904ZQT9E=;
        b=giJ2Ge1fw+3g1L8gYozz+4tSH9r8K27vIJA6PkuagUB+sEDCs5yi5ujMmhTSkoJ/U0
         xT73pUyVlPqfep6zIPHGqLuE7V/0pJf2QNuGBMODp8kQxc6Zv9rZcsyIpjhXnF7ezRdq
         mIhv2/YHOLEJEQZecGH0lJ/f34n59wjVw58gCHltO196d7HXKTkAoYyZT7sz/gCViKaB
         om4rIM2TqdoDNohA8nBbLk9kUsM4Z9VBpj1Ry+OBRaWyHJlG/0FMfi03k8zlI02n72po
         eo+QA6rEPfdBaDpXSaoV5uXexHUU/mQssF6PgbZWKL1J0FVtpBwRpKPZo/JLDPQjrNgS
         5kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783051455; x=1783656255;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cuaojvJeCpfd+fb1L4y3F4PQXD2n4Bkmi4X904ZQT9E=;
        b=bM8piyaMYx7KXlUk1CLto+t2xoqXWENYLL16xiz5oD4I9uSmItF91t09/MJ7Vb04xs
         PYMOtU6tNNwvLxqrzlFbmT//xXgJeMus12U7BervysW2aXtG/tMSkOxFVvZNSnLzf+Xv
         s3xuzc1ucyhNBAp7mXXwnErt1re38F4kEkVswoyGdubo+MV2R5Vu8HF9YjufGc9TtJ6B
         F/CPR/WSmbCdSfkb9f3gdSSQPBv24lxCAuKup9EtlHnGki/cNHGq+f0dhwVF4kqXQdb4
         LH4e/GbOnmd0HBJPzDeBmE4rOp+I4uyhcygAwJal9h8HKkxUUDqLbpVOLhHxVFSkiLXR
         wjpw==
X-Forwarded-Encrypted: i=1; AHgh+RribjJtcKbiSZtsSpYbdheR3JNWsp6GBgiEFkrMNLaKc9SW0FMEVP/UtY86U9lbV2lz7ulDGzD6hinQl6ARhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1dugjt/JfYUUR1/WcZk+8Gno9sr9ID9S7ExBD3AnwbyRVKMK
	3+wxDYjXszb/pZHh/uOEX87YIIndl4wK1d28uUAOuBGcW5bxS3Kh+hmj1WFcQIb83a05mtnX/xT
	wsE5zWQdZpr3qkva1Y8e95eypWKEnXswdB9HmvCNpPk7/7As+hpqOhXCIN12V88+sgxgIPQ==
X-Gm-Gg: AfdE7cnAi6NafSM0tfryQllwB6uwvNx5JF6Iu5sPZ2uhojSlBwbLUpuz+hwqbJ5nn1X
	XMr+SBMhX3N73D77ox2LBLr/vkLhVn9tA0OtKcKeoAODGnBc5CrwkL80OwughR8ATCNXuSOVAyI
	RY2kRVcaY56oxqAysg4zXblY5RUdKMx5U2tfTmEEuh7YHAO5Yu2aKiC8+29ZNCJ/P3RJLe7kTHI
	vc5RxVsG+mLtKyqH4/hKj+NXn8hQorbqoB/8ZeETIQx9i6pVJcIV+k+pdEaLTS81WXFqwbCB4Mf
	eK4T1NE+UKl8ea16RKQn22s77SwQ5Yyv9Jy2Pd3KrGPXwfwzGMA59ArX//lprh5PPM222eaioDm
	qUBwOnNBavOCurHJKkRLhfJm9I4sXrYwI4UzVf+olI+RB1/Qy2wegJr7A7gjiSg+YtAlyfylxWQ
	1wgMHLTjmQ
X-Received: by 2002:a17:90b:2f05:b0:36b:a2cc:485b with SMTP id 98e67ed59e1d1-380aa18d19dmr9189797a91.21.1783051455196;
        Thu, 02 Jul 2026 21:04:15 -0700 (PDT)
X-Received: by 2002:a17:90b:2f05:b0:36b:a2cc:485b with SMTP id 98e67ed59e1d1-380aa18d19dmr9189762a91.21.1783051454538;
        Thu, 02 Jul 2026 21:04:14 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127ccd661sm320299a91.15.2026.07.02.21.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 21:04:14 -0700 (PDT)
Message-ID: <980e1f5c-a845-4180-970d-02f6496f2956@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 12:04:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] wifi: ath12k: fix MAC address copy on big endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260629-fix-mac-addr-copy-on-big-endian-v1-1-3de40f74c13e@westermo.com>
 <f4d0c9c0-6d21-4426-8403-209f77ab1387@oss.qualcomm.com>
 <akYkNQTB5DPwzYXZ@FUE-ALEWI-WINX> <akYsszdtJfrvIRSr@FUE-ALEWI-WINX>
 <cdd85c7d-976d-4bc2-8792-bef7e98afbd4@oss.qualcomm.com>
 <akZUUhopfdxb3VTX@FUE-ALEWI-WINX>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <akZUUhopfdxb3VTX@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pcgzFyUiXivQlllsuZqtYNOKRtLBOlRd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzNSBTYWx0ZWRfXwT+4yD4mzcLq
 tc5VIYQt+lk1btaZvzZElf4O/iSGKRTbC5Og62jPqIdYwTtbt1KcWlNCeZDl1WBLwiYuoeIbIc6
 6zDzDr7a6qvFP0zpatYSQnB0S0LL314=
X-Proofpoint-GUID: pcgzFyUiXivQlllsuZqtYNOKRtLBOlRd
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a4734bf cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=Iwk81yimAAAA:8 a=0cw6PLzwVsJPIFfh21UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=PqBb7rsBcpu_OT3Qf5tX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzNSBTYWx0ZWRfX4yXovRD2ulyn
 b9RMD99ypAsL6KC+jxvXJCtNA0tp5dnHJ95TC7fSIsNWgq8tThDEqJ1ZefXG4yL3dlnfXrQY3ZE
 8ZUVstyzE81urviVwa4+9nGunFHVSiUyeXFGmhy34DNnP20jjSKd5i4T/fqD33ecflR2sx1rZtv
 CxivLjO7tFALE+oT7rfLekS/xaRxUwVjHw6eAdxxfZoc3adv8/WE6sux8Hmx3jtiTYs7tKoTkIl
 HvwJwOOS1yS/lP11l34IOxIo5axHOejFO1/1hEBAUxwP4PGiwW2RGVTsREzfWdJFH/8rWZ61Dn7
 4FDhlz4NWhzDqPCmQbZzxn3LBgJp2ogPJCExPbmteRH0C8iBsfs5WrES6r0PasqlTQyuWyFbM9S
 fOcZxb1vvze7JYGPJ9oA/fZnX6YvavkoOg1C6bH4HNb7QUjW8ahFxafec0ch0Rm731tUFZTj68l
 KRRTdsy0C/B9qHCuQog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030035
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38553-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 734B76FE495



On 7/2/2026 8:06 PM, Alexander Wilhelm wrote:
> On Thu, Jul 02, 2026 at 05:56:01PM +0800, Baochen Qiang wrote:
>>
>>
>> On 7/2/2026 5:17 PM, Alexander Wilhelm wrote:
>>> On Thu, Jul 02, 2026 at 10:41:25AM +0200, Alexander Wilhelm wrote:
>>>> On Thu, Jul 02, 2026 at 04:12:00PM +0800, Baochen Qiang wrote:
>>>>>
>>>>>
>>>>> On 6/29/2026 3:55 PM, Alexander Wilhelm wrote:
>>>>>> The ath12k_dp_get_mac_addr function performs a simple memcpy from a
>>>>>> CPU-native data types into an u8 array. On a big-endian architecture, this
>>>>>> later results in a null‑pointer dereference. Convert the data to
>>>>>
>>>>> Alex, did you find a time to investigate the root cause of the null pointer?
>>>
>>> Hi Baochen,
>>>
>>> I am now running kernel v6.18.26, and it looks like the null-pointer issue is
>>> gone. I only see the following log messages:
>>>
>>>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
>>
>> what is the actual mac addr reported from firmware in the PEER MAP event? My understanding
>> is that, without this patch (if we really need it) we get a wrong mac addr, then in
>> ath12k_dp_link_peer_map_event() we are more likely to fail the peer look up hence would
>> create a new peer and wakeup the waiting thread. But the log here clearly indicates that
>> the wait timeout, which does not make sense to me.

I think I can understand the behavior here: even if wakeup happens, the waiter in
ath12k_wait_for_dp_link_peer_common() checks the map result by calling
ath12k_dp_link_peer_find_by_vdev_and_addr(). Since the mac addr of the newly created peer
does not match, check failed. Finally we get timeout.

> 
> I have now added the following debug output for `peer_map_ev` inside of
> `ath12k_dp_htt_htc_t2h_msg_handler`:
> 
>     /* DEBUG */
>     switch (type) {
>     case HTT_T2H_MSG_TYPE_PEER_MAP:
>     case HTT_T2H_MSG_TYPE_PEER_MAP2:
>     case HTT_T2H_MSG_TYPE_PEER_MAP3:
>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info: %08X\n", le32_to_cpu(resp->peer_map_ev.info));
>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.mac_addr_l32: %08X\n", le32_to_cpu(resp->peer_map_ev.mac_addr_l32));
>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info1: %08X\n", le32_to_cpu(resp->peer_map_ev.info1));
>         ath12k_err(ab, "[DEBUG]: resp->peer_map_ev.info2: %08X\n", le32_to_cpu(resp->peer_map_ev.info2));
>         break;
>     default:
>         break;
>     }
> 
> Here is the result:
> 
>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info: 0002002B
>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.mac_addr_l32: C921F004
>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info1: FFFF0EE0
>     ath12k_pci 0001:01:00.0: [DEBUG]: resp->peer_map_ev.info2: 000502F5
>     ath12k_pci 0001:01:00.0: failed to vdev 0 create peer for AP: -110
>     ath12k_pci 0001:01:00.0: failed to create vdev 04:f0:21:c9:e0:0e ret -110
>     ath12k_pci 0001:01:00.0: failed to assign chanctx for vif 04:f0:21:c9:e0:0e link id 0 link vif is already started
>     ath12k_pci 0001:01:00.0: invalid vdev id in vdev delete resp ev 0
> 
> Let me know if you see anything suspicious or if you need additional debug
> information.

I am not really sure about the final mac addr and vdev id passed to
ath12k_dp_link_peer_map_event(), so can you also add print below?

diff --git a/drivers/net/wireless/ath/ath12k/dp_peer.c
b/drivers/net/wireless/ath/ath12k/dp_peer.c
index 47d009a0d61f..3e8201d536a5 100644
--- a/drivers/net/wireless/ath/ath12k/dp_peer.c
+++ b/drivers/net/wireless/ath/ath12k/dp_peer.c
@@ -162,6 +162,9 @@ void ath12k_dp_link_peer_map_event(struct ath12k_base *ab, u8 vdev_id,
u16 peer_
        struct ath12k_dp *dp = ath12k_ab_to_dp(ab);
        struct ath12k *ar;

+       pr_info("peer map event: vdev_id %u peer_id %u mac_addr %pM ast_hash %u hw_peer_id
%u\n",
+               vdev_id, peer_id, mac_addr, ast_hash, hw_peer_id);
+
        spin_lock_bh(&dp->dp_lock);
        peer = ath12k_dp_link_peer_find_by_vdev_and_addr(dp, vdev_id, mac_addr);
        if (!peer) {


> 
> 
> Best regards
> Alexander Wilhelm


