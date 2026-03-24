Return-Path: <linux-wireless+bounces-33785-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFGEOerEwmmIlgQAu9opvQ
	(envelope-from <linux-wireless+bounces-33785-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 18:07:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4A319B85
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 18:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 678A23007230
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537703EB800;
	Tue, 24 Mar 2026 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T1em4mfK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ildasht6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1682B3DCDB0
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371318; cv=none; b=YfjEg26ofXnV5QOUWPfAQXzPxGfG4pvMLvB4TgytL6yfU9F4GTmfXUFVBxOW5AegaKTf3V5A01bcho0OI7h5ocnL7qUlK72Ai1i6FlQ+es1hNxhSlPkrM2ZeBmgviTct6Eo1VnO6WVl7cNQRJFK+ucrAZ0m1+tl1fJMzRhZFkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371318; c=relaxed/simple;
	bh=Fw1OXqXFTDLtwk5lemrafdpa72T08ToNu8WKn4ORd1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtjK+tkYMlHuqLI5tZsV1fbxyLep/La670i+NwGLyZHtDzTFoL3754thrIvQ5wSQFlrVQREbLROqrDKDB+RFn3i1OmfRc524bZWcQHGB0D5Ddp2B5P4drUAyEU9+QKprNl9aFLqEK11s+WO0JEUhXChY8BBX1i5aTS8wabJiG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T1em4mfK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ildasht6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OG2neY3039751
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 16:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oH3p7oqw65C+TvouzT3PZ3SKKvj2KJZ564slVZs5r9c=; b=T1em4mfKhuE2Qi0b
	FuglRXnjshCzV7wMo0wC/IR66y+JCgLdArrODwFpxlBmRUQd/qen+X+84FS09kP9
	KgLvRCZJEv6fddGcXl/kxQphmhi9YoguY1xOOaZtzMbG9HTS1H26gWGSvkc9ec42
	OaqieiLpepzw/Uj0sUjIyo1fM3w4IvMYWuOtu6wk7ar0vFspNAZss61ViaKQ/c1A
	lhGkRiJnK4eu8tMW4HZfHACa4dZIU1TA2aQcR0cGLxYRIqrz9I0dk57Y7SlkZ2kp
	D29fpnrm/wKiPRcVJxz9W09qNt2Uo8CS4f4SRbD84i8oHXulyYMPp1qblGCA5TkN
	GiSysQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3rf0hkpt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 16:55:15 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1279caef718so1733023c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774371315; x=1774976115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oH3p7oqw65C+TvouzT3PZ3SKKvj2KJZ564slVZs5r9c=;
        b=ildasht6jmwo9Yyu/B2ZAv0hL2sN6nENTcHm6X7Qe8Heye/sa6WEmxw0sYVnbmDwL8
         /5L0Otfo0FftFxOxtNzmluj25oymuFsWBYhkF5eX1lbaD+9Ycv/fGuUfkS7XGG8dC7+J
         ylwCYwdTdnig+IogqAFA0o483TqnUptcDKRJ7uKXXrEzdl5Sll/KoTJ5fxE6qoHysRxm
         INw6IE8fA4RCD5nct/N2zVfAJ9GJpPY6u1Iq9eCHK6AL7CHGOmY7Nw4Bwe/9MmSMNsgS
         OqcRyXiPQtEJAwNG2hQ+G39lhyQxUOsFTv9vs8BD7TPZUnirs8et47Wi2++9j7xXQLxI
         3AOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774371315; x=1774976115;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oH3p7oqw65C+TvouzT3PZ3SKKvj2KJZ564slVZs5r9c=;
        b=Tl/z2FRl+D2dzZxuRniWOpv4e4mwIpLQ8U7e6fQaJryM520OXZ2dZuX+HpPHhV/MDC
         Jb4tkx5xIFO6P8//FdFxWLFk9tRDiaqdA3ocpRMGP/422BR+0Y4a9PHqEsPweAlflb/V
         Dr7147D5eCpu22DuImEQPOyGvI1tuEdfS8liE8U/CeOXqaRbWsNPeqj4xLAfUiIhrXvk
         lYx2H/OGVI7FCdH8psSohFq9/glG6u4jqZU3zPtd+nqHURvdJXKWZ0JLl81udTbLHbDo
         j2dN5z1/Qd4EBhM4/HAjZ54Rep7zjc4OUPTT6IXeCKjgc3T3D7urC3QCZsiJlbmxeCaz
         GcHg==
X-Gm-Message-State: AOJu0Yz19yrC+m08HvSVc5TxBxOrUsVgUY5XpKJF2uN2qTm1SEbLsscR
	gVAjG04ZfZpVdgFM4FS0uxeFXfSkzkwwWx8djGuYAvZl2IcQXSbAdJ3l74pxiXzztWWcI+gXJKu
	fEIKH07ye6M0XrAjIBKYq1fkw9kJWGP0jxgg7mZiWM+JnEVSnERcWiPTVIG/9W8MKd8x6RQ==
X-Gm-Gg: ATEYQzyDcrj+al3iX6Zi96KC3oG6PBdmZRoLxplK7u45tXm+az1r9jwl4djrl1aBfZ5
	v1TO0uIy+T8K7sUewohv4C00a7vp91eOG5Ma+2oInBQ0B9pMXa8HMEbhZbFJHkBvkv1pQoGryNw
	R1sHcA2c40JinJjZ0d20sQzH6BG8SgVk/c9T3u5ISGCvttuHXwtKlGP/AQSaddM/FsMma81PtCw
	E3CHItMur0zNIP5Qe608m2GVcH9k8rBd7pJDA8XLH2V4DJbeueHkpFAged2JjURV7e2JPt9G4O0
	j7s2gO9GQROJ9vAq07yeMgRcv9+2SnATmI8ejHvyzBS1jF3W0PqAJ7PCJD1VJ48np/jYpkUzW9O
	vGYbSHDjidqM7VOq3Kfjs4hAmk5hYDmio2Y0fyG5rCS1OyjVBYNrdaOT41p/Fli6xeiBB1BBMjY
	yhYqBSgw==
X-Received: by 2002:a05:7022:6ba0:b0:12a:6c4b:9cf0 with SMTP id a92af1059eb24-12a96e49128mr140452c88.3.1774371314748;
        Tue, 24 Mar 2026 09:55:14 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba0:b0:12a:6c4b:9cf0 with SMTP id a92af1059eb24-12a96e49128mr140434c88.3.1774371314152;
        Tue, 24 Mar 2026 09:55:14 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733fe80esm14392212c88.7.2026.03.24.09.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 09:55:13 -0700 (PDT)
Message-ID: <edf86c6a-fb09-4524-9b47-3061c3d6e68f@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 09:55:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260317084740.3756880-1-nico.escande@gmail.com>
 <36c1cae8-d6c0-4432-bc8e-57216c5ea3fd@oss.qualcomm.com>
 <DH6U1JMUQXVM.287BFERLLK9KK@gmail.com>
 <40756be1-6a9a-4821-8c90-34f37db01e8b@oss.qualcomm.com>
 <ec266bec-c371-4ec8-a60f-21ebb810d38e@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ec266bec-c371-4ec8-a60f-21ebb810d38e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzMSBTYWx0ZWRfX/Opo5jeG5R77
 Q8zHIRgf1BKZoybp3WbJTHV1C3OHVBeaHHexMHJf0mtSzqQNEgXmuZPUoE1dlsUWO/bIGNn2zbh
 fgUZgm+LWJQyJtg/322OH3bTKksIRKN5OR+UkUYt70P4eMN7y82QKepmmXb7R3amZ29dirUKA1+
 RHYb8vJXXKEE9JKhlEFIw+Wybbt131+eT6d+qGmfm9Ix69lsKWudBYOpiRE1qjzPh5oMk1M6ppx
 biP6p+fJq3cJd7JB6YqcKfTS+D6E1S8lvUET3FLjQAdWl/WwYPUrUEH+VjnJst3zKv2g47FAto3
 Pacv21/b2pZAtPLhfQZGPeeT1XZ525NzeWXMBgf7+rnqPijIA97zTeY+Xq26yvxmIZSnGwTOfOS
 7CZQ1+nvfJfF4kVbuw+SJyJy7uX/wWWVkzh0MY6wDohilbVJU6XRXB97T9wU9KmJlMgtE8W4xw1
 RPx8nB7aoWFoJk9u3rg==
X-Authority-Analysis: v=2.4 cv=Ua9ciaSN c=1 sm=1 tr=0 ts=69c2c1f3 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=FbE22GNBz-Vxc7xXROQA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: XC2PyPJDIRerxKxtygLcZ8qIv-o8D6Ob
X-Proofpoint-GUID: XC2PyPJDIRerxKxtygLcZ8qIv-o8D6Ob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240131
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33785-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: E9D4A319B85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/2026 5:40 AM, Rameshkumar Sundaram wrote:
> On 3/19/2026 9:29 PM, Jeff Johnson wrote:
>> On 3/19/2026 7:35 AM, Nicolas Escande wrote:
>>> On Thu Mar 19, 2026 at 12:08 PM CET, Rameshkumar Sundaram wrote:
>>>> Or may be have this allocated on first device probe and free it on last
>>>> device deinit ?
>>>
>>> That seems even more involved. It would be easier to go back to the previous
>>> version and simply, alloc it once per ath12k_base
>>>
>>> What do you guys think ?
>>>
>>
>> Going back to that may be the better solution. It isn't nice that this current
>> solution may allocate memory when the driver isn't actually used. But I'll let
>> others on the team weigh in as well.
>>
> 
> Yeah, allocating once per ath12k_base is definitely the simpler 
> ownership model.
> I was only wondering whether sharing it across devices might be worth a 
> look, since this is per-CPU scratch space and the table itself is fairly 
> large.

The other alternative is to still have a single global allocation, but also
keep a reference count that starts at 0. when each ar starts it calls a single
api to alloc the memory and when it stops it calls another api to dealloc the
memory

when the first ar starts and calls the alloc api, the refcount will be 0 so it
will allocate the memory and increment the refcount to 1. when any subsequent
ars start and call the alloc api, it will just increment the ref count. on
deinit each ar will call the dealloc api. this api will just decrement the
refcount until it reaches 0 at which time the memory is freed.


