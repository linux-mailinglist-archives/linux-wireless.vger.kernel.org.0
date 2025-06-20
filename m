Return-Path: <linux-wireless+bounces-24289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02BAAE1ECD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 17:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F741C246C2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813072D322B;
	Fri, 20 Jun 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nx+GB/iM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9885F2D3214
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433257; cv=none; b=uzgSBpPK8Qxb3kyhx+NBWQiDo7bRmBBWjhWrcneqUh/goNhBm+MA7FkEhZFDITyRpQIMZ/kV2ttk6UhADEn6f/+eDU0DS5jCbULn1qf7+W1/PxPDBiuYZVnywcwE0ssIvpueDsoPK33xajT7lu9oqnS4HyvFQi7wXCjg3jOw6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433257; c=relaxed/simple;
	bh=P8Wo7fcybEshzotVDeA10midjInAL0LN6QVzD5tO3/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rn9wu9hWTRPTQJohNhy8Po5k2iANpcSl9y6tS4NqToBXC/0lEzu0HDmYchAQoCr3ymP2pnAIF3u7YubVu7fzhQrvM7E0GkxGFMebcwn1ssjrYi7fsmbYjH75KBawhJleA59eG8Fij5XFNKuX8OQbHssuLU9D6btfjB18ngRbrto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nx+GB/iM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K76nWP025769
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 15:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z+rs8T4bgG+Rya1KkHRCXup+WnUD3pd+Ch7crhjLsi0=; b=nx+GB/iMPdkNPH/N
	D/YXGKSvHi2+F9e0KKpQvDrof8o7ce+Brwcn3tKoOfNuC56xLPlYMpy2KnBnKjDb
	78U6+NIe9C0+Z+duh0Vw1Nvz/IVDJa4+/KN8KbSp8TzfH62aVuFdlHrcIsR6W2gG
	a6e91uOs18qe9hQQOATMVBCG2fnjmyVItf70ZYip7BWCffFB2goCrc3S346OQE1j
	pocHC2EP551PSWC3mz1AkeO+I1y2/SgL5Q+wPw+SRZXozqq7thil4fbGhUUHbOH9
	9sb9JXod6AbtKd6ZEwiRaUKX5OfWm5ecx1fDFoQ7l2fjlwI1IGDbXSvFyMws2zF4
	CeswfQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791cs3g1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 15:27:34 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748f30d56d1so1039133b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 08:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750433253; x=1751038053;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+rs8T4bgG+Rya1KkHRCXup+WnUD3pd+Ch7crhjLsi0=;
        b=mTPZQYyohO1kQetHwCKfaAYiFCWx8PVNTGvcO6vFbBEkb/Rq/BkMp6tBVHatCeTo2S
         4XA8KqNtATz1l4N4wAJcCCW/3xQUHL4GaMSQClxcOS/eLXU/jl3myS5+1qGcJ+YfZlzL
         s52J1UuP0p/3ldrR07TOPLQnrFeq5/NH9FNSfSkbA6dMbDWryt/aVv+CZYQrbzPo0EG+
         ykXHAOxrwGVPGkGwY+7jP/3XPQ/oHMQXzIDx3VNlg3FJQffH4/6gDS6BgXqCWRdP7ivs
         0EFGya9ASrM76I4vqR4fdAYY1NL8Urv7TWrfWEIMkh99CMwifOc5Xkfe8L6BGk0jlnad
         NVfg==
X-Forwarded-Encrypted: i=1; AJvYcCXg8/GmKbsNar3+3QMIg8fROrZvrSTJUSlclx86xcqUA/Bdfv7kSRKruhxk47EDA4bcva93h7JX9y88Ztbz6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dvZHrxkr7kSdFProuIMczEVTcMuil+qhFUPoW0dlXtBhy6Ob
	RsesdGo+Ff8raAZ/uQniG0Bp+6NwsSGvEWfSCNOPbvZmgujPpkLciqAQ8rm42RYCgWVcuqmgu0u
	I1nUn10nDDAXGhdPieeEx7+zZ7O1YD4e29ddymVw3uJRNzYILkzh/B1BVexHq68rOfAKW4w==
X-Gm-Gg: ASbGncshpGkthRIW+AWfDaAAt7RumPZ1OgH4jhWO0/R4aFS0VrnYBv4XbAeZpeCb4UK
	NkNLRpqRl8QdbwCzt+DKrPseBj9Xh54SP8BXG1kyYTf8vBizOWLCHDMpU6hBATaDmKNuFO48DfR
	QiEbg9hSb6upFURmTYdfnXkVKKXfr8gi04rbTDcS2R0LrjcusP0GVaR0SZt3t0U9jZeBcekZYtv
	CVIKQ0czCfEEQekNoV3Eb4bHN8go1PM/cj0x+DFFAAjNjkC9b2h3zxbvW7OhagB+gycWjHEA0Fk
	vtenKsKeGA866MR5+bRCqHA0avCWTmkYqdYTedtFP30m1nE1493GhQqI4cIrH1qsf8ULmCFXAGX
	Vd297kvG40h1VBeI=
X-Received: by 2002:aa7:88c9:0:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-7490d4e764bmr4526848b3a.2.1750433252923;
        Fri, 20 Jun 2025 08:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX4ccPDFY5JvWE0aspZHNF7mwAxGry6wkBg5v00B/SdhZn5+MXU1O26M27rXpg1M2JouYaeA==
X-Received: by 2002:aa7:88c9:0:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-7490d4e764bmr4526806b3a.2.1750433252434;
        Fri, 20 Jun 2025 08:27:32 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a64b1c9sm2239011b3a.115.2025.06.20.08.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 08:27:32 -0700 (PDT)
Message-ID: <4a3ad8a6-90a9-45c5-bbdf-7b91d3c18e51@oss.qualcomm.com>
Date: Fri, 20 Jun 2025 08:27:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/5] wifi: ath9k: add ahb OF support
To: Krzysztof Kozlowski <krzk@kernel.org>, Rosen Penev <rosenp@gmail.com>,
        linux-wireless@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, nbd@nbd.name,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
References: <20250609030851.17739-1-rosenp@gmail.com>
 <37561ac8-ac0f-4744-9495-c7589544d4bb@oss.qualcomm.com>
 <ef0db40a-14d1-4670-82ca-f724a0eeee0d@kernel.org>
 <ddc48fa7-3fca-46a3-9224-11c0c3fce4a4@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <ddc48fa7-3fca-46a3-9224-11c0c3fce4a4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FTBt9PlEZufcSlNpTFRJdz1EG0U8-b5L
X-Authority-Analysis: v=2.4 cv=BoedwZX5 c=1 sm=1 tr=0 ts=68557de6 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gBfMadwGajE8Mk97sbMA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: FTBt9PlEZufcSlNpTFRJdz1EG0U8-b5L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDExMCBTYWx0ZWRfXztV5axfuxYl5
 ekEHKiW36eCdLaBlk79sXucLSqxoLmm5m+1y0ob5cYpqNdlvh3Vpm0VCnwD4rfieHgCI9qYtO31
 ulTvjWx8eucqY01CdmfJlPqsyQNt5SsKcrRCLn6PoPuaatxPxKj4QrUbiSUn5I4utFFnaROHFmn
 zLs1dwyVoc0BN6Tls4HrvRGhpq3atdmyXNegV+SfdA2UNm/b4rEGga6+Yegw1CY4UeAxmm0OpuL
 M0Aol5eq/O4gI+J8+TPmqqpcDsQnCxCM+G+JuHJu+m/RgeNtG3oVwU4SFlWWkJpKZ9KhOzON6G4
 W6vU7Uu7zWxjJTFddfx9xirwTGLzR+Eb1mLLSMcTBAfjr7iwShJW+XcP/d0AFUxCyX8t62+c9Uv
 yN1csXolP4Iw3r+hnHl0K+4TMeiErkydJe6jWp1iQdholiylvA3WsmbW7m8vGreE46UMlv0X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_06,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=899 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200110

On 6/19/2025 10:39 PM, Krzysztof Kozlowski wrote:
> On 20/06/2025 07:32, Krzysztof Kozlowski wrote:
>> On 20/06/2025 02:33, Jeff Johnson wrote:
>>> On 6/8/2025 8:08 PM, Rosen Penev wrote:
>>>> First two commits are small cleanups to make the changes of the third
>>>> simpler. The fourth actually adds dts definitions to use ahb.
>>>>
>>>> v2: Add documentation, use kernel_ulong_t, and of_device_get_match_data
>>>> v3: Use qcom prefix and wifi suffix as in other ath drivers.
>>>> v4: fix up dts example in Documentation
>>>> v5: move back to using qca prefix. It makes no sense to diverge between
>>>> all the other drivers for MIPS based qualcomm devices. qcom as a prefix
>>>> is used for Quallcomm's ARM(64) stuff.
>>>>
>>>> Rosen Penev (5):
>>>>   wifi: ath9k: ahb: reorder declarations
>>>>   wifi: ath9k: ahb: reorder includes
>>>>   wifi: ath9k: ahb: replace id_table with of
>>>>   dt-bindings: net: wireless: ath9k: add OF bindings
>>>>   mips: dts: qca: add wmac support
>>>>
>>>>  .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++-
>>>>  arch/mips/boot/dts/qca/ar9132.dtsi            |  9 +++
>>>>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  4 ++
>>>>  arch/mips/boot/dts/qca/ar9331.dtsi            |  9 +++
>>>>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 ++
>>>>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  4 ++
>>>>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 ++
>>>>  .../qca/ar9331_openembed_som9331_board.dts    |  4 ++
>>>>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  4 ++
>>>>  drivers/net/wireless/ath/ath9k/ahb.c          | 60 +++++++------------
>>>>  10 files changed, 84 insertions(+), 41 deletions(-)
>>>>
>>>
>>> DT team, should I take this series through my tree?
>>> Toke, Ack?
>> No, of course not. The same as you asked some time ago: DTS never, NEVER
>> goes via driver subsystem tree.
>>
> 
> Heh, you do not have any subsystem maintainers acks or reviews on DTS,
> so this should not be considered. It's like me taking wireless patches
> without your acks.

That is why I was looking for clarification.
All the DT stuff had your R-B and hence why I asked Toke for his Ack.
Will DT team take the entire series (I'm ok with that)?
Or just the DTS and I should take the rest?

/jeff

