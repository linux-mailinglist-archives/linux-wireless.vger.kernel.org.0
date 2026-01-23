Return-Path: <linux-wireless+bounces-31138-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AD+xAFTtc2nfzgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31138-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 22:51:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F057AFA3
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 22:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97889301A718
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC2C33985;
	Fri, 23 Jan 2026 21:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nl50ZMWE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RcsmrPIx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97507262A
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205072; cv=none; b=dj8sOSJbeSvEs0G6gzxsYTcpMXDiLAkM1Di2j3tedm8cf1BcTOlFwnZnpvMAGnT2Ua1p3mxKtYNeuFemaoobEU7F3CVOznNW2/NmatJeZRu92+bN7Q0rZVX03jizV+ahSABiPAd5HvMtVPrUaShvOViTCky57pZAjVp/9twAriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205072; c=relaxed/simple;
	bh=dJzuhAmKIgVK42Q/V900Y8f5MAdQf9SRhsRsj/cELNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TVwDrxsaCI22ju+eNc5qtvPfEVq7zK6y9lbL/9g75XUewIIgjv1RqRyEadAa82Q6XShLlUrvVN/geTEWbxkvsa93541w8Hr5p9u5jlHyKnMY/Q+nDqU9MJrHd+hhlSyWbUwsHCA6vtVSjekcI9PL3qRcXrwYieBcoGK1Oqkxawc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nl50ZMWE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcsmrPIx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NH3mwW076735
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 21:51:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hY8Efosat1aF84msrnz5L45GHzzW1npYB6w63ZdIWlQ=; b=nl50ZMWEShtqWWGs
	auzW5jimVAU82yN8tLsDYCZGeFFjPsdKiggD/RNN1LMXnT1fe9BKJatdoBuRR9yZ
	s3JbP3SPjWNzL6DeXPM34VUFyC55i+ZmBdDjekR4NAhm6chjhiR5GWFNa6Q1tKV3
	qhPwPZBcOcruhB6IdEciT0aWlsM7eOAZ+WDfZztV3yyYzNeah9hfgIrb6bk4NaXs
	qfJg9VvtXl+ZZxqq4kBDpH5fCByzU6PWPSeFf1cgXPz7FRSWWGSPK6778GlveZkN
	S2zhdaSZZsAHSuZ3ajqNN84rRGxZwRJp5uObXEDGexbQP3r/KdY2gnaDxCx1LPiU
	n2RXtQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvd2cgs90-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 21:51:10 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b6f0b345e3so4196335eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 13:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769205069; x=1769809869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hY8Efosat1aF84msrnz5L45GHzzW1npYB6w63ZdIWlQ=;
        b=RcsmrPIxdHhVj/iCBRroR3B4qLJFBz29kykL0vII7ibZGQD08dy2nMm15y2ceZVCW7
         9hFDgYY2Ot1jhZkfKtGbi5qPA8KAk/KNPwV1CAQxsYOFGBQxIYrTHp6H+pbmiaP1qZ8X
         S9xrGYUwXpswaUMdTtnndn/zNX7T1piZuxTltcbiVtcYTER9QaMcPUrSpMBh3ndmcMdP
         Ro+1H4XELsRYg8ZChnKPv5MZaLEPLADEbX2udL6AWY0bWSt+4cRsbMeIr5wF9VyDectV
         NgvbY4POBTeK9aU6kVfE9m/62cJdhDjYi9X30ND1aDGORXuXKx+rY7jF54bI65R1l68J
         4O5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769205069; x=1769809869;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hY8Efosat1aF84msrnz5L45GHzzW1npYB6w63ZdIWlQ=;
        b=MsnM3xjJwsNTiqFY3tgtFI2MLW5HV6izJO5oKb0YHG5qIuaauZKc5kML7zG+hel+5f
         YPq960eIfT+81+AuUg1f3MT8QyVTHRa4ENQ8DfCxe95xgggmThrjXzhomx6+udpQPDAh
         R+mkvCDYaw1g82jiwxOVF4xvOQBqXTmUlVDFtOXs7erhJsD85YCCLJKeVVr28Yd4gh18
         E/S/fCeRZ5Nb3YVfNEuxvzGAUVISUEXWq7WhYHuygtMBk8t1eBFgUSkzFF1/8kIiJ8i6
         w3qzJKBkNmUxeymNsLAbSVlFFaZc3GxzkyfVmhbLnVaeFQ5vuCX9aNiAdgImVLI8o/jn
         Z9Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWrtX9WDv2aojGb/DlTGZdvaf+U8XUANhmDkLtOQrgwRaDiuqiiZlOhp32kFrLbXO2C4HgDMf+9qdJeeeCXoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9/esZEoJOKeaSfNE0ATmO7inS7mgZ6jq5tBJChM+CPJ2nwRn
	kXLQX/PlJmJexi0jbaQxtMj8CENTJgirnvGrBQzbSzR0Y7291WaTxcwDCY8fxUtoyWTD13vUGSv
	1sfN+ewD/0LGnL9q/Xi27mAWECTE9G+FP3G6q6JCGn5kuzPyUSVkg3noWGmSS15rOxhzCdc+V7y
	DTAQ==
X-Gm-Gg: AZuq6aL/rgTFKQlSRZnGVKm3AP5m72WzDyVh4hI/2kHzGV+aDBdgqz0c1UMzvloSiyP
	ngbqv9qK3ewFLegKWS1c51A1AJko5vwnmyzQcL6lzfVMGA7RlTy1uCejMVBXRA2RNt1eGW0hI2S
	0xV5HlkkrbmYbGS0cEjcGAKLorM4puV0Bu8a9Iq4SkoPakYJUePwnJ+8X0oCWxI59z4h5as5RA0
	eXQziPZ0HUDf7SRqIFa3361QjeneF7+OjgoGeXfm3vsleecURJG7h3quh3olMMOa2cu/+oNPPzB
	/dvzFF9aDR3+V47kzuib/b/SbqZ7hvlS9kAyJk0jVxSEE61ustmDjFLjgg4Ilkzsm6jN3XW47N8
	86AeLuIH1jPsqZiqfMmwKkwzCOBXVG8Ul8CcZt9GyXgCuUZmGv5hsUXlnmQjWoNZaVUzQQnY/20
	9r
X-Received: by 2002:a05:7300:1488:b0:2b7:bd6:a2f with SMTP id 5a478bee46e88-2b739bd5786mr2236221eec.38.1769205068966;
        Fri, 23 Jan 2026 13:51:08 -0800 (PST)
X-Received: by 2002:a05:7300:1488:b0:2b7:bd6:a2f with SMTP id 5a478bee46e88-2b739bd5786mr2236208eec.38.1769205068420;
        Fri, 23 Jan 2026 13:51:08 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa2b656sm4799710eec.33.2026.01.23.13.51.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 13:51:08 -0800 (PST)
Message-ID: <28f1ef2b-318c-4448-84ef-2ff74d93040f@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 13:51:07 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 wireless-next 2/3] wifi: cfg80211: add initial UHR
 support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20251216162421.40066-5-johannes@sipsolutions.net>
 <20251216172421.5f35a099e950.I26126bebd83c7ab17e99827489f946ceabb3521f@changeid>
 <460791be-6a4e-4098-bc74-effd31c8c593@oss.qualcomm.com>
 <802579416827936058d24a5e1ad24084e2d1e8ec.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <802579416827936058d24a5e1ad24084e2d1e8ec.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDE2OSBTYWx0ZWRfX9Pe7oWc4xaLk
 CzGD1wswo1bQa81+CMWG0XL838RP/2L7dpSWFMvVTuFxDvqIetxw3RrT3ikbo4Uyu0I9HkkhMZ8
 dzBwfNk00NAKSiXp7EfXt4Hx9+k42W03tLY536mqR8UAqmETLKAgf2sUh3DxQL9/djM4W68nD62
 Hr/GI4Zja/tgA/E2ByzpO88XqzrmMGDSJz6GH90dlQgyOp5zrpJLZV3X8FLdLsK6r1n74DaGt+s
 k+Qt52o6JA8GJ+DG9SMfHhsopsz8QPzzlDQUkKT14PehEUsrnNmAoLLiMuFerwo+BmguaTUaZjv
 9PzO2Bxnc8UWh8lSK8CMrEwFDjrmDL7xjtL19d0Up9Zs3al497pGztMnBXCt2xoTqupM5meu6B7
 r3GKZ0cykk5PeFsh5vCPMtQvHO8lu1TYNJX/kdeU1UrPeE3xqVFdNxUiZrGu36foulsKym1rWW7
 JZaSfgosooJ1WqBneBA==
X-Proofpoint-GUID: DXPoBuxcKRe4s3-vPgZE4Wox6eW0mLpX
X-Proofpoint-ORIG-GUID: DXPoBuxcKRe4s3-vPgZE4Wox6eW0mLpX
X-Authority-Analysis: v=2.4 cv=bapmkePB c=1 sm=1 tr=0 ts=6973ed4e cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=dbXkPMKo-ueCNyPnHwAA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601230169
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31138-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 57F057AFA3
X-Rspamd-Action: no action

On 1/23/2026 12:11 PM, Johannes Berg wrote:
> On Fri, 2026-01-23 at 12:00 -0800, Jeff Johnson wrote:
>> On 12/16/2025 8:23 AM, Johannes Berg wrote:
>>> +	static const u32 mcs_divisors[] = {
>>> +		[ 0] = 102399, /* 16.666666... */
>>> +		[ 1] =  51201, /*  8.333333... */
>>> +		[ 2] =  34134, /*  5.555555... */
>>> +		[ 3] =  25599, /*  4.166666... */
>>> +		[ 4] =  17067, /*  2.777777... */
>>> +		[ 5] =  12801, /*  2.083333... */
>>> +		[ 6] =  11377, /*  1.851725... */
>>> +		[ 7] =  10239, /*  1.666666... */
>>> +		[ 8] =   8532, /*  1.388888... */
>>> +		[ 9] =   7680, /*  1.250000... */
>>
>> you probably already know this, but checkpatch doesn't like the first 10:
>> ERROR:SPACING: space prohibited after that open square bracket '['
> 
> It probably also doesn't like the leading spaces after the = sign, but
> ... I don't _really_ care. It's way more readable this way IMHO.
> 
>> (yes, I'm running your series through my automation since we are vetting our
>> additional UHR changes on top of yours)
> 
> Do you want to post it all together (and maybe fix the uhr_oper thing
> from your other mail too), or do you prefer I repost this?

It would probably be better for you to repost since there are (trivial)
conflicts with things that have already landed in wireless-next.

Then we can supply support for UHR capability and operation
parsing helpers for DPS/DBE/P-EDCA, and add some hwsim support.

/jeff

