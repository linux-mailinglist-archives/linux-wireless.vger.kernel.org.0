Return-Path: <linux-wireless+bounces-33983-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIdgG9xhxWlM9wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33983-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:42:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4963389AA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 17:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFBB93126AF1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2383C7DFA;
	Thu, 26 Mar 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGfYBEHA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VX+WtbP8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03056381C4
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542600; cv=none; b=pLiblO/0RSEvXBKFYYOV1C8/VNVTiXmSFA/NlkH29cxSQGJdYx1F1mnvlg+my7ePnE8RTVuZJaIjtUiD5wfF2MGHBm/a1NV7Cbhyyf2aHyq5BcIqljr3gkVv54ygDXggWF+d9oYbZFoxv+wHJkeQCWaFe1UUoGtBzM95//DmNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542600; c=relaxed/simple;
	bh=NCwuDLI9IeUQFTBSbLICqEYq/Jjo5lCb+m6TObde1ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9/A+L8TmSw79U+QXgMSDxhhmWPsnc7uPbeKFN69t4uCBlR0QSZje04hd6PscIacgcJfmpVMUboBzUbocNw9dPVwdV3vaStvfLne4c7F5kcX2C7oGTAGsjfgpaY9SBOxtJ+BSQwyBvOS5qH1q4FuZEp916biZQgfDw+hJDBg2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGfYBEHA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VX+WtbP8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9fkV3849938
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 16:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ivRwSoYNsF3FOsOUvHG4NMGM1jycxkCZy1o6iP0ba/8=; b=MGfYBEHAf4todcyZ
	WzR2Cb2Mn9b8ichcoYEy6thoXQ2nvRDeH57/oWi3RoFp92lJc9zxHChZuPe4m+GG
	/l8nJFL1peXnu6+thRctV29R8bPUrzXxR3wmQsfd6ycKRiYmZwX+NWx0Uq51XDPn
	fzXHHGQ3Vpu8fuPrcmGXcOGOS3qqfMdK98sHcK4jnQr55ypQnVdvkaroxFV1XnDE
	L0lKBDOaMVcvN/roiVoQEXFPeX+EsgsRHOvmAEFEdQZ6c30cjTjHpBKQxhVxUiL+
	3mUvJqv5U5tggWk7l78Bu7yKHy0N4qX7HZQSGOzgkoUvaKK6IJMmtmf9/paWgWNN
	wWHh8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q76umt9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 16:29:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso980227eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 09:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774542597; x=1775147397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivRwSoYNsF3FOsOUvHG4NMGM1jycxkCZy1o6iP0ba/8=;
        b=VX+WtbP8gIogfM6Rmmyf8ws8Mi/dUYFFQbJSwCHOq7xUhAWEj/09su8UK1tlyV953o
         V0vK8EDfxD7rn3lhnp/lCo4MNrtosT6gYeZaMXAIfai+GLrhb4deJ7Z6dwOY/Q/6X8gu
         Ic4gPBB44vGbBkSUzGs8X4UIbm7iMaCQJOAJ58fI+B9s1MHKYPiuG59BnG/1BEXSNMWL
         bELIphIWhKqnvTGjC9Ou1D0G2touR97hgbYcYECZE1nd3tlrRRqr7dneYWGiMZKI9viT
         NxGB4eVVjn8ZxLc+z7Qn8G0zYGrKJHFX63kIXrATXL/5XV+yQH2j+PKcaGuU5QTgrhVt
         EvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542597; x=1775147397;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivRwSoYNsF3FOsOUvHG4NMGM1jycxkCZy1o6iP0ba/8=;
        b=dYIHzuzPQIhW1btN5VECiR65yCYqJrBWVjhy4n8vTYb0se0iRkyYEgUMNjWihz07LU
         MRwffVmZRN2LE/fItqhuatvdaBkXLCN4t06fEj83W/P7kTH/MhGd6fM2YKA0A+tCaJzQ
         Vdxu5GetUmEqJ3A3hqKtCjw3BfW0Ow25KvBCKIGeABc8SOXTtABbsdo1/wyMyMfLfCAj
         P5dFtAoFRoxvM9lcVQ/q9yNY/qk2baKScyxZfYPsNPz8k5jNLOndmW1i4tNxvwxqGniC
         vjokTAbuuG/IL1CqCXJd9zTSxzHjVDEEraeGtCUSrtg7iMNG93nVAmyoDOfhQPnG9lMf
         W9Vw==
X-Gm-Message-State: AOJu0YzMdjJVGwqoDizEMGjvhSH24W8V1LEvICDCrS6uqP7ExBJythY6
	u8zpSyPjVw2iILLsV9pB0DaXb2xeKSjo0E5hspapMhmr6QV10XAhzIveyijZtqoRK2qZtoOrD7+
	Vc4G13aswK+XRcUSNkHv68ByGV9h91qYhfZnqZ/XZ7VMflqdT8zLSXOVyTOW3Cb8Z1QxkoA==
X-Gm-Gg: ATEYQzzS0rLXow5DePwawkFTOEZyMSuK5/KaFjIELDqkkZClMDM7KO6kDbN4eeX7l3u
	GkuMR5wcbMXoY2YvCK2XX5KjY++ZhQ7FCzSB/TTSgSxS5ptXxDRCgLBWJUWK6OG27riup+hucPT
	4w0o4huU8LXR+mWW/wwSCJ0Ve3EzKl1zrPaR7TagVrgzC6SkiWv1zpu4C6x3VeFCkxyQRnBvXgY
	SoGNsNmcXU8o7qIHL+dCsePaObft//lpxqdVJCFGtYL5p6EoKvrmsZzGQ+yq4bhvsJbS60m6D0E
	cYDrM1ES0UnjRfBCRp3abDNxm2UWENnW+XkSW3wmODj8YzBz79QGpte2tcD83aILR6foG1S9afe
	5RUKczEgYi2//bOshUwLpuWwt2QQQ9j+aBKJh3t22yjFxQODaoOOMD5kVDrfCCs6x4sn0+3kXpN
	8cxLKQgTtBTIFgZQ==
X-Received: by 2002:a05:7301:d87:b0:2ba:85d6:e777 with SMTP id 5a478bee46e88-2c15d28a868mr4148427eec.2.1774542596662;
        Thu, 26 Mar 2026 09:29:56 -0700 (PDT)
X-Received: by 2002:a05:7301:d87:b0:2ba:85d6:e777 with SMTP id 5a478bee46e88-2c15d28a868mr4148413eec.2.1774542596116;
        Thu, 26 Mar 2026 09:29:56 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ee01373sm2698500eec.26.2026.03.26.09.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 09:29:55 -0700 (PDT)
Message-ID: <9657272f-3a61-4880-91e4-e4ab5972896b@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 09:29:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260317084740.3756880-1-nico.escande@gmail.com>
 <36c1cae8-d6c0-4432-bc8e-57216c5ea3fd@oss.qualcomm.com>
 <DH6U1JMUQXVM.287BFERLLK9KK@gmail.com>
 <40756be1-6a9a-4821-8c90-34f37db01e8b@oss.qualcomm.com>
 <ec266bec-c371-4ec8-a60f-21ebb810d38e@oss.qualcomm.com>
 <edf86c6a-fb09-4524-9b47-3061c3d6e68f@oss.qualcomm.com>
 <DHCKSTJAAL99.V5V5D17RLHD@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <DHCKSTJAAL99.V5V5D17RLHD@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NOPYOk6g c=1 sm=1 tr=0 ts=69c55f05 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=_jHX9szh96HkLwC8_6MA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: sR1tMarlXeI1o283Ov7Gs7nAWyzOdBR1
X-Proofpoint-GUID: sR1tMarlXeI1o283Ov7Gs7nAWyzOdBR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExNyBTYWx0ZWRfX9XRtmd9W17Z9
 n1OGVnVymy+qO8iA6mgx1XryniH1Fl50xzYBDADnSHKGeyZZbU2FtUDqVX8wjfyPg0cDdn0xpP9
 k1UTCrEjuiNkBfYXN6VFtTCZL+avKHmCpp2ClEvqRvIhwx4sh0RFiJh388/q9sOEdys0GzSQsrI
 Mz0UGQvP2V0mZqVyatTffThO4KAlBUD32+cG/6Sm+fM9QTaRW/6F9zxPkDOpiPeVloWencZSSG4
 grCnOOOU10Cirsc2Ars9B5ItzcABkYEtcdOifNvUBoWvDSqp2OL2YVKOYdUJGm2+oCt8Wa5Y/kv
 0gOWUzUqRDCOVy4VO1BSzNTCHJNrxDmcCyYcMQkN071mfH56CXTaOsS5orGjTcXLN6ZknWKznhd
 hQ4/sTfe3OeUEbtC4+TSbTSeiq1CQhzX8x8YtjmBgKTx2F6friaK/jkXJd0SO8omrqb1YkaJlns
 zGDn290XUsdYcG7kHpg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260117
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33983-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8C4963389AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/2026 1:37 AM, Nicolas Escande wrote:
> On Tue Mar 24, 2026 at 5:55 PM CET, Jeff Johnson wrote:
>> On 3/23/2026 5:40 AM, Rameshkumar Sundaram wrote:
>>> On 3/19/2026 9:29 PM, Jeff Johnson wrote:
>>>> On 3/19/2026 7:35 AM, Nicolas Escande wrote:
>>>>> On Thu Mar 19, 2026 at 12:08 PM CET, Rameshkumar Sundaram wrote:
>>>>>> Or may be have this allocated on first device probe and free it on last
>>>>>> device deinit ?
>>>>>
>>>>> That seems even more involved. It would be easier to go back to the previous
>>>>> version and simply, alloc it once per ath12k_base
>>>>>
>>>>> What do you guys think ?
>>>>>
>>>>
>>>> Going back to that may be the better solution. It isn't nice that this current
>>>> solution may allocate memory when the driver isn't actually used. But I'll let
>>>> others on the team weigh in as well.
>>>>
>>>
>>> Yeah, allocating once per ath12k_base is definitely the simpler 
>>> ownership model.
>>> I was only wondering whether sharing it across devices might be worth a 
>>> look, since this is per-CPU scratch space and the table itself is fairly 
>>> large.
>>
>> The other alternative is to still have a single global allocation, but also
>> keep a reference count that starts at 0. when each ar starts it calls a single
>> api to alloc the memory and when it stops it calls another api to dealloc the
>> memory
>>
>> when the first ar starts and calls the alloc api, the refcount will be 0 so it
>> will allocate the memory and increment the refcount to 1. when any subsequent
>> ars start and call the alloc api, it will just increment the ref count. on
>> deinit each ar will call the dealloc api. this api will just decrement the
>> refcount until it reaches 0 at which time the memory is freed.
> 
> We can do that, but we'll need a lock to protect this shared ressource:
> 
>   - The clean way would mean adding yet another lock to protect this, but it
>     feels like there are already enough locks in ath12k.
>   - The other way would be to piggy back another existing one.
>      ath12k_hw_group_mutex would be a good candidate to be honest
> 
> What do you prefer ?

i prefer a separate lock for this use case.

leveraging one thing for a completely different use case leads to confusion.

/jeff

