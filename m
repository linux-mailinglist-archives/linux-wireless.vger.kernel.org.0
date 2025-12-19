Return-Path: <linux-wireless+bounces-29925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E87CCF9B0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 12:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96EDE3042821
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 11:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AA923505E;
	Fri, 19 Dec 2025 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fUZDRAx6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SSwsHgK/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00122DC770
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144024; cv=none; b=U+FgnoeJvRsMJeM8O2c/ECOanloVM6V9OLK/LvKyKFTnTJF5hKOu8mYn8ma7EXZVP0p0+q8JqQBgyVSIqDn2qnyPAmMU317jH00gcRJFRh9UFl8tEqSQxE9Iah8v9/NV/nR4r0lA6hOQmbpJLmwenIUP66EiXPx7YAzPnTkHm9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144024; c=relaxed/simple;
	bh=x3zhgf9Q0sOp4+j8ZJkL0IUjt5z5dlm6FUtLNilAkDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cB8fN7GBW5viAuddR1N9sVNobshySP8vdPEmYtkFapxhyxTmg9YoaWaH4tHUKKeQPJH86Sx67cEtEaQfNUuFKm6YqyB/m5LGMtjMN17k1u8Akvtho2oB3vOYHQf+12k8l6DHrp3bQzZHley/n7mFDSQYJv6OWOS2gpU0PKh6eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fUZDRAx6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SSwsHgK/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBPBRw3939202
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 11:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fMdx0pQw++OdmVRdKAe5y5wrvzemap1JR50aCfUHmCw=; b=fUZDRAx6yVvWka15
	K+Uc8YxCFiSuV3wtdByC0G7h4K2/0IFH7uwYhL9Wi8L98WrNwXEuwMLFp3YJ7DEQ
	vDIYPLb5ajcrHChN2wx5eVjP62eVzFsSb43ge/IVBqv5hN/L8EFzddicwUug0ZYs
	6Aqk/l4MSAPpTehblYmqu34znUJLK0AS6/uPRQkAnR1qgS0sDYzbkdc71BYMdEnM
	UYDjeoO7VKSTU+xyRkp9ftJd/ya/FzBtynmy+pKXdsvRySWcKBKN+fwamzwrG3cb
	xx+scurk0kLu02MCNMMwa7C8qdpoglOPpydzjRvUl5xkT/pS81Z616nFe0+KoUuj
	mO4OQg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c2gc8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 11:33:42 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ee07f794fcso3872451cf.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 03:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766144021; x=1766748821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMdx0pQw++OdmVRdKAe5y5wrvzemap1JR50aCfUHmCw=;
        b=SSwsHgK/GSH+RrfxNZL72mqiHKV1TMFfHZrGhvLrlv25UZAgWk9tHdkm7dpEuQNrxs
         98Fc4xk+x8SCV0pUlX2Zvz2xT9DRNpeBrIKDkWzhvkAzRCWNHmXNzFCWYTJ0TuBZRgDu
         IhAVsW8dmAnYS5KpytOTlSSNMAHlWfDDbdJ5JH1liQyvC+Sot/UUPc6c6wGPEYgSbLh4
         sTbXr0F9xuN/swelA+YL5xb2Zlo3zjE588KOuMBSVgTQj3xjfnWwkW9EIKWkNPkgLwHw
         oZz0AGowzhF8CASv3lx1X/kK97pLnIRWuwrsR8stCMiWmTaSUfBOjqvE/uLTYlihmevE
         oUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766144021; x=1766748821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMdx0pQw++OdmVRdKAe5y5wrvzemap1JR50aCfUHmCw=;
        b=GwTvn4jPyh/JKlGKAbLgIPAgfD2O195TeU79hjJf8yvfrRZQmBStSaMNNk6g4Cdp/5
         KqQmtHdNSh747P4/Fthy9IpnEPqzfQXESBNkKsxEljd37kjX61Hk973TPJDFKbo5F7Ir
         FBdCmcSJDJ81WPdqMBUdf5Drv12LLLYHxwbA1g+6Y79ydXj0oQzd6ETit08OMgGBI55Z
         LsQGCvkzdttF2l/LDTKYdcArdSi7rbchP+rXBqDpc4ut11qEH7C8ZliHC2D2d5fb+OGB
         BF0hjoSRAx3qPsDpn+KkOMOxs8MyQLa/0+IBlYiqO8dFNrDGPLOTRJY7W7VtkgrVZexb
         KT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/fqLuQ7EU8bzoN99Tx1RKLpdbAZM3HluJVA+lR8xtFzyzPUPg2kEcFJe5xBisCAj5ToK69Z1e83Dqm2Ryeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6VH4u8/pTNU6Gn8hOpP2xDmadc3MpyKi5SWK6kzq1ff2/+1S
	o9mELR6m1jZ8vuiloDQ/KfnzAp0AJmRUWhGCmnNpgkJKs19SDlbCmNA7/JDFyk1U5EC6auky3cy
	Ec+YlYAD7Cy3SP5Nua6O3jc5s8ah6cacHWlrAQa1T9qUfUWJgXC44ZKBYcIOEx37AO8YRFQ==
X-Gm-Gg: AY/fxX4N32J07UlBVmzB0twhW1qLS+6l8DLKxyicoOyCvMXRnljh7HsSydjkoXcSmUR
	lhpAHbEh7ls5F73NrUL1Da6d/XHkRO0WuDZn5m/YLe1ZbmAZxOt80WdFuC6UPCOZ67fb4YmR7tl
	VNi2K8AEYuxoi1a45oTOoQlGkPKXInzblnk8fq0hAFaBSG/LgSOqbwCzg7QoEhkQ6giIXjuG+1I
	9vbFZh4RXNg3bpBQWsE8ZPdeOgrIZJ9mjWUZBvOeXqF6oA0CgsLC2eQhiPbNN8DpPZI87ey3HHD
	D1FytXx9eyxBnEAXx0R7kSulHfetJjO8SoYcXqLLvHieDlThN17vPHi1+GQEif75riXqmP80fUG
	Kel6tOAdNj7UE2Gw8OlJ17HeQxQK+yUtK4EVfhaVn9NdVuPo2O6ckLr29BFvuhbLsZg==
X-Received: by 2002:ac8:7c49:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-4f4abddcae9mr23007311cf.8.1766144021175;
        Fri, 19 Dec 2025 03:33:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxqo/hY71IEBjcEElYEuPuhI0i/EacL5t30/TgMJPWqpmemlVJCS5TEqzKfvpqnuLoUyc/eg==
X-Received: by 2002:ac8:7c49:0:b0:4ee:1a3:2e79 with SMTP id d75a77b69052e-4f4abddcae9mr23007011cf.8.1766144020662;
        Fri, 19 Dec 2025 03:33:40 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b12dsm207708366b.48.2025.12.19.03.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 03:33:40 -0800 (PST)
Message-ID: <864b2dd7-aaea-418b-baf1-a0d1b452cf95@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 12:33:37 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: arm: qcom: Document Microsoft Surface
 Pro 11
To: =?UTF-8?Q?J=C3=A9r=C3=B4me_de_Bretagne?= <jerome.debretagne@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ath12k@lists.infradead.org, Dale Whinham <daleyo@gmail.com>
References: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
 <20251218-surface-sp11-for-next-v3-1-875afc7bd3b7@gmail.com>
 <438a352e-5174-4361-b6e5-6ff5fe1ce0c0@oss.qualcomm.com>
 <CA+kEDGE42HhaWZy1o9DjpwcjPiJcqvq52o-_g+auOkp26ukULg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CA+kEDGE42HhaWZy1o9DjpwcjPiJcqvq52o-_g+auOkp26ukULg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: c-vLrKY6rBsfUvXs6onNTdihW8UmXTfa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA5NSBTYWx0ZWRfX1smh+ZEyLNuY
 rScf9zBnnuk4uKNY8SAcrMO7joln/ci1OrEM9N6NxWkWIbxmOe/r1O4k6cVLIAzo6jvF1ZToYzf
 Eldz1XEjeygvxc4+/n402h8HgftTS3kpezsxF25r3H3Sb2GwEmi1pjqGYryH/cFulylDbXDMcNq
 l6BpjM77TYJvIdlpsr4hGqbix716ZSstY6F5ZyQdrORHjMkh7aQ0PzSc8JbqRnJrCbjrRHOKGCR
 6RErXh/r2rS4h63VDwvjgWoKXpFmYy5F4nFjLriqSJJwosvvo8L3AsL48++nAW3hH9dbbPkVhgc
 QtQlGIpbp44Zcsz5bpd4xOhsdE/Qecg8xu/m8n4LnzWHsqZjrhLQfaKPfLh4Tht2cqJPaVCBOmU
 Zcue0uqpdn1dXT/tbvm0lLIxUwEKqN5ZtjOghNkOIXHnBAJGFV3GG12BHpzLbwtsKMkHcfk4hYu
 cdCWcrFrpksQEShpVBw==
X-Authority-Analysis: v=2.4 cv=feSgCkQF c=1 sm=1 tr=0 ts=69453816 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=F5t3yZrAjdDg94tw__kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: c-vLrKY6rBsfUvXs6onNTdihW8UmXTfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190095

On 12/18/25 5:35 PM, Jérôme de Bretagne wrote:
> Le jeu. 18 déc. 2025 à 15:15, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> a écrit :
>>
>> On 12/18/25 12:56 AM, Jérôme de Bretagne via B4 Relay wrote:
>>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>
>>> Add the compatibles for the Qualcomm-based Microsoft Surface Pro 11,
>>> using its Denali codename.
>>>
>>> The LCD models are using the Qualcomm Snapdragon X1 Plus (X1P64100),
>>> the OLED ones are using the Qualcomm Snapdragon X1 Elite (X1E80100).
>>>
>>> Due to the difference in how the built-in panel is being handled
>>> between the OLED variant and LCD one, it is required to have two
>>> separate DTBs, so document the compatible string for both variants.
>>>
>>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> index d84bd3bca2010508a8225b9549d8c634efa06531..7c99bc0d3aae3dc6e9c08fef0a535e114a3297a8 100644
>>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>>> @@ -1067,6 +1067,14 @@ properties:
>>>            - const: qcom,x1e78100
>>>            - const: qcom,x1e80100
>>>
>>> +      - items:
>>> +          - enum:
>>> +              - microsoft,denali-lcd
>>> +              - microsoft,denali-oled
>>> +          - const: microsoft,denali
>>> +          - const: qcom,x1p64100
>>> +          - const: qcom,x1e80100
>>
>> As the bot pointed out, this is valid, but not what you want:
>>
>> This expects
>>
>> "microsoft,denali-(lcd/oled)", "microsoft,denali", "qcom,x1p64100",
>> "qcom,x1e80100"
>>
>> whereas you're looking for 2 entries:
>>
>> - items:
>>         const: microsoft,denali-lcd
>>         const: microsoft,denali
>>         const: qcom,x1p64100
>>         const: qcom,x1e80100
>>
>> - items:
>>         const: microsoft,denali-oled
>>         const: microsoft,denali
>>         const: qcom,x1e80100
> 
> I was trying to group the 2 variants together, as they are very much
> related. Your description captures the 2 variants way more precisely,
> I will switch to 2 distinct entries in v4.

Unfortunately, in math terms, this is a:

ab + ac + bc

situation, as in you see there's a lot of repetition, but there's no way
to find a common neat factor for every entry

Konrad


