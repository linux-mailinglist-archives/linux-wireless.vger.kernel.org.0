Return-Path: <linux-wireless+bounces-20561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FCFA68D44
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 13:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6FA1891991
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776A212B02;
	Wed, 19 Mar 2025 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLtUt1Um"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED5250F8
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 12:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388908; cv=none; b=TCzAgFlFs4MaWOTv3HX/eS5/2P7oHmRcr7ODMWVZKKbk3d7PcGo1clXoBaZDr/I0QH7/iNBAaPuLTHukwQa0bGXfcnvog2Xx2KEi/XGdIHN14eStmQqWZcS0SWxxMLjR0nIQ8GM9AJyz8dvrPNks5w7tSktRebDI/vNtXMzMeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388908; c=relaxed/simple;
	bh=rSIL0khIm0ebl5amFqGxWLHn3SbAi8HYR2BZhgG9c4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P7RQUgHBcriPCYTETKIp3hafoL9C69W9CNpwXpS86urT73HAxGYBlCIkirNwr9bn67cnAlAXddLu+fFw0xWa5l2L2t6oe0ZoyK2qW70faA7wuHHEYAGxzs0qBI9M9aoWc/D01IeHwlwkuY3g/zUXJ4UtUFPamL1kxmSk0VzM9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLtUt1Um; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lkim026883
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 12:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IeEVDtRTtfm/mIgiKRKIxsL5mdTxcvp8WT7XXvQZHCo=; b=gLtUt1Um0VqJKelt
	rKcZrQxH/YA2N2VTrhRxeULs6eF7KgF39nBpBnY9iJF82u0XRJ0T1XskJ6l9/QYt
	qNPRxszawW6nDtPwrifjTwxcpocKbp3KrmhBRn93YnHbIjtIU2JbJ7uJkD1u4uzU
	Cxi9AFl/7gAmwpoul8V5Bc1BKVjA1xEDjNc+ukRGmkRoURNIJ7ROocCj3ijz9Pvg
	WZNQkVyi01NDqGDCWtC7Z+6bVVbdyZG3uvz0QtkhlU8UXSWuTUuuHf9X5DgbL6NF
	AyTkx/VJ8XNFo3jqHA7PSDryIEPSWpUcCxeoyj54ODFMzT45ADA/VVUD68qVYOli
	EcpmIA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45f91t3h41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 12:55:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso10949315a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Mar 2025 05:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742388904; x=1742993704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeEVDtRTtfm/mIgiKRKIxsL5mdTxcvp8WT7XXvQZHCo=;
        b=e9BvhlMvnZdtWWRSTZ/zFpLUFlZlGoz4WKpEjcHBW8xxuQj7R1p/p3cUb/WoH2B+tU
         uO/CQFzqKKxehHYR4eX23gOm//c6Iq1glIbOU5F48QudrH270obvhMGckFqBJW2Bd2D7
         gF5+i6idIR6kkUfWHOLbdzkpgjq2jewyACtXCgvd4x7MmfvPWEnwnLQxNvXB9ON17V+/
         oyjyquiBK2ptKJt/QN/iHrPw3+RqAnyAg8UvaSB2f5XZOM0DcByAYCYVwuxaz25hWE9P
         p/zvdOViiYuQD4rRR+iTK0URI8684dWMve5aU0Sg3TKdY+q62EWpLk2fc5LB01/vUgl2
         67ow==
X-Forwarded-Encrypted: i=1; AJvYcCXSbBW4Z6pJ8vBWdKCLZLwJIkVDA6wpGKPfWcz/Zg7Br0uthastiY54SvcHyaQzj9tx8bf2suO1Oqh0irA1lA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiROoI+ohQUtTRTOo+frfZOTrpZLc/UTDXdX3wrxArh/Z6lfas
	v1npuKS/XdXv5RpvaWxEGUiqEQRwiOjse/6XRZq91Er7+KupdEpO4XI3KYI8zWb2lnpupNkVr5+
	p1mgZ7hvW5l+0sdeZxUlwmuTAfMG89T2gjJR0sNvXtCpRydx97+98rGg6hdpvUOn9kQ==
X-Gm-Gg: ASbGncsLP5vi7MXkq3yLXXVj2fJeTRC/wtYtvoXIhARdNxziIEIheNL/OCvvFboqdGa
	1pgBxnjpp0iP/mfD2bXjBiwtTcWJm2w3WyPcxNMj2XUR7BbYI7WCX0Pj7HLdWSY5p13/MKF7j93
	0pB2Eiw69RSgDThl3sWkBV+4vb00UrOry/2uz1BVO7UAFVyqirpJwZGHlTSbf6KmjwrxBsPpTp9
	njJgi7NUdLN5tsDSWr6eom7VsVybpZFFyzXXF3d6WTa+ko4gVizuAQKeDQY4HsqDGL6AirbDiP1
	ILSgCqeGffmdaL/XzOVWZr4OBMbY7HtaMdohrl8fS8JEykrZyRguD3ZEnA==
X-Received: by 2002:a17:90b:4e8f:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-301bde51fc9mr4540477a91.7.1742388904516;
        Wed, 19 Mar 2025 05:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/2CAuo/R2eq5BzbQLNQBq0yPs22kdCE3hs/7Vq2U563faJ6/8KWodBXAfiVexNfvldQlfDA==
X-Received: by 2002:a17:90b:4e8f:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-301bde51fc9mr4540440a91.7.1742388904132;
        Wed, 19 Mar 2025 05:55:04 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576be5sm1463455a91.6.2025.03.19.05.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 05:55:03 -0700 (PDT)
Message-ID: <c6e3b0c1-18fe-a9fa-0e72-d955809144e3@oss.qualcomm.com>
Date: Wed, 19 Mar 2025 18:24:57 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, neil.armstrong@linaro.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
 <db232678-fa85-d75f-de72-d2b5e1ec611f@quicinc.com>
 <2a5hvicenftfiktviiofvknanyz756cbryu35gkfczdvbcdd5j@fktlzfieotgl>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <2a5hvicenftfiktviiofvknanyz756cbryu35gkfczdvbcdd5j@fktlzfieotgl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: l6NFN23qeCcydE9UKs1rh-PEhcopeYYf
X-Authority-Analysis: v=2.4 cv=Xrz6OUF9 c=1 sm=1 tr=0 ts=67dabea9 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=cXwcXxlD48ZRgq5pOxwA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: l6NFN23qeCcydE9UKs1rh-PEhcopeYYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190088



On 3/19/2025 5:21 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 19, 2025 at 05:02:39PM +0530, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 3/19/2025 3:57 PM, Krzysztof Kozlowski wrote:
>>> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
>>>>>>> ---
>>>>>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>>>>>> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
>>>>>>>
>>>>>>> Best regards,
>>>>>>
>>>>>> NAK since this will break QCN
>>>>>> There is a series under internal review to address MLO issues for WCN chipsets
>>>>>
>>>>> ???
>>>>>
>>>>> The original commit is wrong, this fixes the conversion, nothing else.
>>>>
>>>> Nope. Driver changes to enable MLO with WCN chipset are not there yet.
>>>> Setting the mlo capability flag without having required driver changes
>>>> for WCN chipset will likely result in firmware crash. So the recommendation
>>>> is to enable MLO (in WCN) only when all the necessary driver changes
>>>> (in development, public posting in near future) are in place.
>>> Really, these are your answers? There is regression and first reply is
>>> upstream should wait for whatever you do internally. Second answer is
>>> the same - public posting in near future?
>>>
>>
>> May be I was not clear in my response. I was not telling MLO bug fixes were
>> in the development. Actually the MLO feature itself is not enabled
>> yet with WCN chip sets. Any code changes enabling it without full feature
>> support would result in firmware crashes with the existing firmware binaries
>> available in upstream.
> 
> Is there an undocumented change of the behaviour in the commit
> 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
> single_chip_mlo_supp")?
> 

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c

-       if (resp.single_chip_mlo_support_valid) {
-               if (resp.single_chip_mlo_support)
-                       ab->mlo_capable_flags |= ATH12K_INTRA_DEVICE_MLO_SUPPORT;
-               else
-                       ab->mlo_capable_flags &= ~ATH12K_INTRA_DEVICE_MLO_SUPPORT;
-       }

The above logic seems to keep the initialized intra MLO support even when
single_chip_mlo_support_valid is not set. The above code removal is correct as
MLO support can not be enabled in host when firmware does not advertise it.

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c

+       ab->single_chip_mlo_supp = false;


diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c

+       if (resp.single_chip_mlo_support_valid &&
+           resp.single_chip_mlo_support)
+               ab->single_chip_mlo_supp = true;

The above code does it in right way. Overriding firmware MLO capability as done
in the submitted patch under review is obviously wrong. The firmware used to report
the issue seems to have an odd behavior: 1. it does not seem to advertise MLO
capability in single_chip_mlo_support bit and 2. expects configurations to enable
MLO from host. None of the WCN firmware available in upstream either advertises
MLO capability or expects configurations to enable MLO from host.

Vasanth

