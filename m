Return-Path: <linux-wireless+bounces-20504-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A275A67B6E
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 18:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7AB77A9566
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC7E21019E;
	Tue, 18 Mar 2025 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXZXw4vl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57F128816
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320561; cv=none; b=gixBdjAxEiRdiDhZLwblOOPmokYtus5F3PkgqkKOO5bG6CRPHyijiLovZFwLIs9FuB1SvKmPj0R/591q9rPhal36ZhonwtndEf6ye2Z17OZKu5a5JSKmOS96qD4W9Bp33CBBfRvt/0SsO/V1hzxqx7onOkg3d466dT1DWM2p8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320561; c=relaxed/simple;
	bh=bVnws3x12+ykG1+kW3kLGujQaQdP727SU3Bb5cuBhDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhctLRbqB6NNY6VM9sskvEz5KFiYa09OkQ/EW8ijxDzungopIdk9m4lyY7MQGcp6vav/G64gjKzrFCGZR0EqIBjVV/+Mg3ymZXG0kSX2OY6nyNhw10ljv2D1T10JupiARQI+R+q00Xvz6Ce4qj7xXZeMjT4QC4AQwI/LpVKmcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GXZXw4vl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IAcpYd027513
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 17:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WYwU73RjEVKjZaZgWeYEmk1TjixaNfci3cjOuf+0t8k=; b=GXZXw4vl9ahAl03S
	iNlo76xpfrnR24EiBGW5dQW3oTW7j7w8lJvhPRs/OhlkN3vYAnXtQ5vjSDvDDtS9
	9UAqXf2tGwYj2TYYWd6JwcGBkVrzwFiGXnqKgA/nbgcBmkN22eSnNdGvfcqiwHk0
	2jdXLArh4/sSI8ZPXoSIQxQ92ShZqmepDg2SvKjFJ0AVbTH5jwCSZR5SzrkN2oko
	UBIl473EognT4n9yernmPfGvG7fKNZzRmb9Xu+uWUPt/7cAyWCKcdqQ+aHfcy5XS
	v3Gx0kllQHE2qZQKBeDk0HDFzWRvkuel7N1DBIuPmLvnrzKE+tmF7QZzi3uTHHf+
	YV7bNg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtjubh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 17:55:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-223a2770b75so110873185ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 10:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320552; x=1742925352;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYwU73RjEVKjZaZgWeYEmk1TjixaNfci3cjOuf+0t8k=;
        b=Go5Y5t3ppdQno5JL10vaLMwX/fy8oqu09oS6dsOYB1mNXJGMBisAJVTXZBGNBncAml
         UgospJIkG753YGB20+3zGs9SVlEtJ5nhqlKxqF/ioe/ufyVJreGiyJDa6kZ+NDQXmDMh
         hmyQXdwwvywFGbin+eivQf9w847PgYFsB0ctm1cgLlKB4dGrP0CdHhWVHFd0e7WmenUX
         3udRTKZTqaXzdhqs8givootOrVTk8hjItWM6DiZR0fGr6FA8aM9DdPl196IiK4YyPQFA
         Yj8+WPViMrtFQoBL16pvlcb6j3BPzxdrNa7fK6uXWWYvJWfhsnC9xj0dP1AWf8dHLctk
         xwxA==
X-Forwarded-Encrypted: i=1; AJvYcCWqbINWTkRPYNb1rg9aMa41IgP3BaDg0/TAu284GWeFHxTIG8DOtg9TMo1HcvqO1kyY0wpwR2s1IbadxAaVHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWUAcVglqJShSgzFf+Z7nVdgzuan+YOhSsZHNravNP2+Mg9uu
	pNNCsa16mnDAhkm0W7r2wfH1fMCbgnldvtnZAmdiEEKf0xek+Nrt1ToQdCTat+x/Kn5rzJJXQ++
	cibt727g+1T98lC3ghKDxFky9mHHz0VEfN5kj8JalCsih04/IJpXcL/iTS4WFbuijXA==
X-Gm-Gg: ASbGnctdu8fIWjp8/S749Zwqelw4bFl4PUjGZNwKaOCF/kSD57hrWe+yiVqsfgjMkOh
	niY5P2OVJrA3WWTNhPhpXvuLnVHBdA80pZNXc+99pgzIvl/p4ZwVUPH90k71llAm09g9tEX6iKs
	njPmQawQ/6wPLfR1XudcdluU1SD1V7wT57kGQ9d9+/AgZxI0897W5hp3SchpwjCjqfmjzG7Ia21
	thnYQtYXqQ0SxOlpRF3UTGa407+49Y410vjeqHhL+y0TGdnV/iTySJ9vLCHnPKx4An8MahR0/Cp
	t+0qVVOxrPgpjC+5GTfxEPHGGzzG0QKK8eHPJqGe3mn0fPK0nwY/9n8mDc8G+z+MQYVeDAw=
X-Received: by 2002:a17:902:f545:b0:223:635d:3e2a with SMTP id d9443c01a7336-225e0a8f4a7mr210952995ad.23.1742320552122;
        Tue, 18 Mar 2025 10:55:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGQnb8IgzE4FIqsuGJu4IQxqgtuk/CstYaDph2XbU45sLrIAtach8WeFzSOU2ydIq8Q1MRIg==
X-Received: by 2002:a17:902:f545:b0:223:635d:3e2a with SMTP id d9443c01a7336-225e0a8f4a7mr210952535ad.23.1742320551638;
        Tue, 18 Mar 2025 10:55:51 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa616sm98018595ad.93.2025.03.18.10.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 10:55:51 -0700 (PDT)
Message-ID: <f35a6080-8dbd-45ca-8fb4-d6b01a5bb007@oss.qualcomm.com>
Date: Tue, 18 Mar 2025 10:55:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v11 08/13] wifi: ath12k: add AHB driver support
 for IPQ5332
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        ath12k@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Balamurugan S <quic_bselvara@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20250317204639.1864742-1-quic_rajkbhag@quicinc.com>
 <20250317204639.1864742-9-quic_rajkbhag@quicinc.com>
 <683b16dd-a3e9-4cc3-836a-95f3747d3c0a@oss.qualcomm.com>
 <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0da16aae-2fa3-49a4-bdd3-f08a7655365f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5NxDwlUDv_tNmu4VpUfgcxfkg64JcLyX
X-Proofpoint-ORIG-GUID: 5NxDwlUDv_tNmu4VpUfgcxfkg64JcLyX
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67d9b3a9 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=PCo5qUFWOPHZosJy6w4A:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180130

On 3/18/2025 8:50 AM, Krzysztof Kozlowski wrote:
> On 18/03/2025 16:44, Jeff Johnson wrote:
>> On 3/17/2025 1:46 PM, Raj Kumar Bhagat wrote:
>>> +	hw_rev = (enum ath12k_hw_rev)of_device_get_match_data(&pdev->dev);
>>
>> kernel test robot warns:
>> cast to smaller integer type 'enum ath12k_hw_rev' from 'const void *'
>>
>> looks like others have fixed this by first casting to (uintptr_t)
>> a few examples:
>>
> Cast via (kernel_ulong_t)
> 
> But another point is that this patch at stage v11 should not have
> compiler warnings and it's not our tools who should point it out. Except
> W=1, all standard static analyzers (sparse, smatch and coccinelle) are
> expected to be run.

I ran what I thought was a reasonable cross-section of builds and did not see
this issue. Seems this issue is only flagged with config: um-allmodconfig ??

Guess I need to add that configuration to my builds...

/jeff

