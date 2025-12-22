Return-Path: <linux-wireless+bounces-30043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58061CD574E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 11:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E573630019FC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7742DCF6E;
	Mon, 22 Dec 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nDAeELZt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B69l7zwk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2571E2745E
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766398020; cv=none; b=JrwK1T6hczBxcnA26CIJ2HHOch0xFRrfptGQlooObmpwU1QkbG1nKU9rLW1yoXyNAm3yXLtVxd2nETXlhV9aillKnON9BTh6iFSEFm133BiusmacBI/SKzBSYW8QlnQS/mO1Wm0ujNkHogz7Cr3b/4Fu8xmp410knXyKwdMraN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766398020; c=relaxed/simple;
	bh=EzElnwwlQS7F2c/aWf2Rrdw+O1vMlFn4Ie35PoFgcPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3IQ2H2JiSoK0u734hRd5RTwGQRGYnxT2J51BCYsVYuWwm6Axej0Fet2aJokBZeh1Jn3CN/vg19KjJeiweuwGGan/4Vri31JkCBqWlZnnlq/nda6p+WFXv9TPS0efyKvVeyh6uO1NyVXPyGsGdqCf39B9trLIc+PupqaMRh8S68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nDAeELZt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B69l7zwk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM807gC3864031
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 10:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eLH0Cwx0fLQzNEAsVMMYq1in/gcvYRl8pE9l3eEnT3k=; b=nDAeELZt/Xho53gA
	oIpCz+T9h+MsDfXtR2O7C2UwnwBKegBOQRhvJ4aFlI3eAt4Q1cp5WjhVkAa4V1DB
	QFRETDtzI+hT2RHRMgQdzHvv4G+lV4qP3isBmC66w6xHjiKIZW+DA5YzdibERNdr
	18DPzHxLnZPWGHqw/KW7Sm8y12sY7Qqu+WZEbjJIwmz/hRPAgTV1zRky9dYHNjVn
	fs8ZW79ESAxWRzVxi9/ePjm/cBUQh3P7ZbML5KykucXwaWtcFLWk8GISlVc8BVvr
	nqHvitFh0XCS051cfEQpxH1JYqiV1PfzxC6bK2tqBbtBwwb1IAAAIDEak1i7THgJ
	VPnNxw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mru4krm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 10:06:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f357ab5757so15946571cf.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 02:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766398017; x=1767002817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLH0Cwx0fLQzNEAsVMMYq1in/gcvYRl8pE9l3eEnT3k=;
        b=B69l7zwkSctyjf8Hu3ed9ik+sKFn7y1XA5Vb74rZMk9TbzeEivfRlU+Q7c8XtMLEGF
         SK/iEjcIvjk4MAQVk7QBAZ3FI4BDRKTkb/D5APdX+tAfJAcpU4cjj0G2Mpg+2CX194nm
         sYxyiXiCr2W1kEbjtoOe8P3rTI+RKEDAkiRUCX7ygCbDO6ZZ4/8bjQxCfGf3DdfACGDq
         mdpl9wZCg9mOpJ720jVnOJ6KRNUYQo8paZsljkadnkF6RfiRaInIKDHiZB4ThUhOhTPk
         NH1O3l0HSH3AJCHxkobG7c3r/Ajs9SbDv1xFBzJ+OJif442wz+G5cPRLAtAD+CR9zFDh
         NFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766398017; x=1767002817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLH0Cwx0fLQzNEAsVMMYq1in/gcvYRl8pE9l3eEnT3k=;
        b=bFuCG/Xoq9o3LcWds9EXTpQzDs+Q9MwpYzjTCViPukTeqgH1L1QKPJPTmWaV4hZCw/
         q49xjIfrZbdSbQHn8kanwl5J2W7Z9FzFRcDLGCSwGmSh+P8kTz5ZnZCFsFrcJSEu/rPU
         ggKFTn8CI3xjZHiWjc/r6gGWdOgThKDI75F49Ch/yjI5JqUQ9mY+hT/ciwHD9usfa6dO
         jGrhMfpkFiCzqBaxBdE6JKA10C13k4rvTmxaB7FC/eoj3DC3pv5FHGu3GxHofX6C907e
         14DcmDhoSWDrUBivfNemO2vcybfrJHpjKbkqZMdE4V/3PUcTYUUKGYWcPUQKPJQ61Vhp
         UJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZt2hnGbrCXlSMwIhHXi4SNPqcqjxU+IxO1k3qd1hbOqZh+MjGILq43L+UilvnQ9SPm4Ts54jZ04CQXYBUpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnrP3lNJkSY8FKyFhnUtK5zEm8y9hdjV3WlCA3eLOeeDBxkob
	nLMkVjaLdWu4U6u3sw+kijQK65r7sSAmhb+F0LF6A38hKsQJeXi4iaVDOkAQaN3DTmXB/ugyQCy
	pYsYil4Nslkst/7pGodmjhDHGagUhDHIcFXDuSvwfcgvH5CJUrTA0J5bXQAyiVXYPGep07A==
X-Gm-Gg: AY/fxX6CJ+vrN/+Z10P0dJKEimKQwp7h1au8H3hzMncx7CxotoqidRnPKWzRRsHFFf8
	dX/btkDCCveu9XvZmR5PvKP8pYdY89mFywruxw3eHSUumi+qsjWu4hO9joY+yX61H9SYfP7cWcp
	DRYvsfnsrBwcV0jMrbpuh5af+GmsrjPeUW3kis6KqgcNbaNPHXb/Gkr3CR6UbrT9/xbiJGuNukX
	JeDSCeqwKmvZIbRbCFXE3+gT2CoWjYW8/8mDEbAIQQQ+oaQvLcc8BDxSZgxv4HDo85u49VYM2ez
	Xsni5V1M6Hn4ZHiL2TeWeBuy27NPzltGs0Z1vCLwQtKd0XMXw8fqgU9LoycVhiS58Y5gF0c1/gw
	YhQiwfoRnAwSWo7McmT6ufLBvCQ5Z3ZaX1fU8G8fYzLIi7/NDBchSb+Cc0y6Kk6MkFw==
X-Received: by 2002:ac8:7c49:0:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4f4abde36bemr116063541cf.10.1766398017318;
        Mon, 22 Dec 2025 02:06:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxyQvKYEBEol+TNPmvXLeYZ8IGLq/Sg/PaYqaFgenlhw+GvGDmoHr1J4MKdbJ/Lxw9/oImXw==
X-Received: by 2002:ac8:7c49:0:b0:4ed:b409:ca27 with SMTP id d75a77b69052e-4f4abde36bemr116063321cf.10.1766398016797;
        Mon, 22 Dec 2025 02:06:56 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f7bsm1037902666b.18.2025.12.22.02.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 02:06:56 -0800 (PST)
Message-ID: <d67e806a-900a-492e-86e5-661223811e73@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 11:06:52 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc: Bryan O'Donoghue <bod.linux@nxsw.ie>, jerome.debretagne@gmail.com,
        Bjorn Andersson <andersson@kernel.org>,
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
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Dale Whinham <daleyo@gmail.com>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
 <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
 <20251220-fervent-mamba-of-sunshine-f680a8@quoll>
 <elgdbinyzunhgxaqy432qzxb65qb6yuheiimwutxdtf6q6jjpc@dgcnk3bgwqij>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <elgdbinyzunhgxaqy432qzxb65qb6yuheiimwutxdtf6q6jjpc@dgcnk3bgwqij>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5MSBTYWx0ZWRfXxYcl1SGVKO8b
 7/Q4fp3rnaUWYvvcP5/7VWOJn1uFpxAFGbpYNLGzu1VQHknNxI8aqZ7z3JgefUXkhG3ycPFlo9x
 QIXnb6PQ4p+mi7sDQr3z/3FMk/ohxxkqgXMPf3MrzyJY+JAht1VCGdsMWn2Wxn8yhkmkpcMXiuR
 rWSwrJMWxB9B+/BN+dHVuEQUk8b7bU8/qvXVVLWUe3qykh5z+UIuFJymeF6JsA06p1EojRYIVzD
 NHkQ/+9AniV8jccNIlpuWQ+MglUNdv6qAobNvBEJn1kSQdlw0rZ7jXFtTcds1dW0RR8hZE/4NWl
 X4y/l2Q85wPWD4GZnJkdLIb8FhyiGiH4rI6fcqa+t/wkAXhjedlumuluFyPUBZddMdkdGTTzjQ8
 pnNo+njlXz/DjT7DYjpfYA6RT1+e0iQP1cp54Hibd8em6r4isfYACE3AIvFG+6iQx7No6lbG2Dy
 1warzRtvTF804gX9+lQ==
X-Authority-Analysis: v=2.4 cv=VMnQXtPX c=1 sm=1 tr=0 ts=69491842 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=UdmcajEFbZfdtKJosXMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Ihch6wrLyceNLYDo7SmL6nPaOF9LvtQC
X-Proofpoint-GUID: Ihch6wrLyceNLYDo7SmL6nPaOF9LvtQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220091

On 12/20/25 5:05 PM, Dmitry Baryshkov wrote:
> On Sat, Dec 20, 2025 at 10:12:14AM +0100, Krzysztof Kozlowski wrote:
>> On Sat, Dec 20, 2025 at 06:04:00AM +0000, Bryan O'Donoghue wrote:
>>> On 20/12/2025 00:21, Jérôme de Bretagne via B4 Relay wrote:
>>>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>>
>>>> For some devices, Wi-Fi is entirely hard blocked by default making
>>>> the Wi-Fi radio unusable, except if rfkill is disabled as expected
>>>> on those models.
>>>>
>>>> Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
>>>> disabling specific features based on ACPI bitflag") added a way to
>>>> support features set via ACPI, including the DISABLE_RFKILL bit.
>>>>
>>>> Add a disable-rfkill property to expose the DISABLE_RFKILL bit
>>>> equivalent for devices described by a Devicetree instead of ACPI.
>>>>
>>>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>>>> index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5eaec2c7ff367fd93945 100644
>>>> --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>>>> @@ -29,6 +29,12 @@ properties:
>>>>         different 5 GHz subbands. Using them incorrectly could not work or
>>>>         decrease performance noticeably
>>>>
>>>> +  disable-rfkill:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Disable rfkill for some devices on which Wi-Fi would be entirely hard
>>>> +      blocked by default otherwise
>>>> +
>>>>   additionalProperties: true
>>>>
>>>>   examples:
>>>>
>>>> --
>>>> 2.47.3
>>>>
>>>>
>>>>
>>>
>>> Is this really a hardware description though ?
>>>
>>> Its really more of a logical/functional description. It tells the runtime
>>> what todo, not what the hardware is.
>>>
>>> You could also have a list of quirks in ath12k for this or have a user-space
>>> utility look for the appropriate platform device string name and disable
>>> rfkill.
>>>
>>> I think this logic belongs in drivers/net/wireless/ath/ath12k/ triggering on
>>> a compat string.
>>
>> This is good point. Either this could be deducible from the compatible
>> or this should actually describe the hardware and whatever is there
>> wired/configured, not what OS should do.
> 
> One of the examples _might_ be broken-rfkill, e.g. if the chip expects
> to have the actual rfkill control from the EC, but the board doesn't
> provide one.

Hm, I haven't thought about the EC being involved previously. Maybe
+Maximilian would have an idea whether this could be a factor that we
simply haven't implemented yet in the SAM driver..

Konrad

