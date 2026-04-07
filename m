Return-Path: <linux-wireless+bounces-34408-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENE2Fe5q1GletwcAu9opvQ
	(envelope-from <linux-wireless+bounces-34408-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 04:24:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A013A9022
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E25813040189
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 02:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371FF34F462;
	Tue,  7 Apr 2026 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wkp5wzwf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YqSvaH4h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9FB211A09
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528639; cv=none; b=cchi64fghQgVdUJntCEbb5W4vktHz1ksXjSP2BZMCFmRWFX8XKX9ttpPxiWCTcF1Y7ULtrlOjGDc5eNhmlp23tFOuzm9kMIT2qtjloPNiwaHg8mSVPprF6GY2KBd8aunMGUgGlQf9WP2edk/FQlyFMLOinAXNul8PKqi6Fq41G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528639; c=relaxed/simple;
	bh=OPzVQ8wK7oRE94NWpDt3lDoeRCxcICiSYHbJxWI2KLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqIhFYo9yQRrIkpb2YusoFpTCV0xbPGoyl43F268Bm7XKuFHixyFxVlvVshC6PeH9SWzAvNH4PhoEoC2AoqcoL8t8WxQTZX1pn/Dwn8R4Fa1tK3CEN+apZ4srCub1hqZ4lsnPbKegOKU8w0qN+X9HnKzTWOd8g8tizl+1DDsTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wkp5wzwf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YqSvaH4h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQH291405987
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 02:23:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8+T64C2shkeuX9nGP7xkHlGtnZEAVo6YT0+MuiSjWM4=; b=Wkp5wzwfsLYeTN/S
	OYG9JfM9mtWQwaHUdX4Vb7bX45ku4I6lztTxJQxAnEkmSHxWnuvMtTDE3mYR8CX0
	dl3GdC1AMlYfjkil6mVniB2VBY1elYgGesRLobLjMb8o11MyVdWUbxNSFovRzIR8
	MEaUgWdxZx7al4YKNb+EapD+UyNWvzTUzPjR1x3mHyAbFbEgYot2wLFdXOc+PqHx
	rnpVdPKhayoCb2PuTLflBw+4fe/70GAj7UM9LwSniSaa3hFFXVEXk76vOeI8c1cl
	ZE9CD8vxEPcnJ6G4xsH08JOEwTBqmVpVTwLWf6PZF+/gGj29dLlKZAugKAGQhs7W
	4PEwWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrarn3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 02:23:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2454fc131so81635225ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775528635; x=1776133435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+T64C2shkeuX9nGP7xkHlGtnZEAVo6YT0+MuiSjWM4=;
        b=YqSvaH4hD3KfQmgzJaHA3teYfIV6Y1f4RnupHetP1Zbjq1+Z7sLwu2dyK0ndV3VC+j
         le6XoWHPFxJrpPdYrPOoQ02B2PKVU0bM9zjFzvsRPZXNzlOoniCJ5ROz52dSxFidTU3t
         5w7PHjR/ep4aDLlNuTevIo4hDW73HGqXz8Bu+E64B1ULfwm1Aon1WnCPfVytheTxzYxM
         9HMAYHzGNWu+L+KbFBuLAX93Vr8WaeizJD4x4YvljvmtZ6J2NmnUhxYs4o7sT04fEbda
         vvU0UBzZbJw6zvo/02AnpVk/hffxEM5duhvWWwmgZG3pM8IxHXydUZEl+uzADCS1TeNB
         xdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775528635; x=1776133435;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+T64C2shkeuX9nGP7xkHlGtnZEAVo6YT0+MuiSjWM4=;
        b=R4ql6+RrzGztdzoRmrwlpWeuA2LZlhmiEkhdk67yqpPPR1d38MyaloUxXdHqldFZnw
         2d+nmv4NK7TdnC05+XmA50tbLOsQ2xFSTVYHDImh2Flg0z2HdpDx/6lZvidofJW7zOou
         91u4G4SkaQ17JWqPEcyhiUFLWtLJjuVUEvYDwlhR8GwqB5k7/psUZSwFryEu/ABzLTN+
         thPfBNIGe38hhGr50POkL22gEmwIMZWRvnBcwfKi/GNrUbjvtknYNx/AmPHaphZJjlpr
         Z+HuxsEtNKfIqEO7wHSViJdbj0U6G+tx17vWD3rUG1TsvvFUtF3pVHexIp7w5RcoosJl
         HiIw==
X-Gm-Message-State: AOJu0YzXyO2llihZo8azPI3cVTZX72nEOkzpFdlgQ5W8s4kvhQwpBZI8
	QtNXc10/nVDLfKuUNA68wsQG4T2VByHpQLQs5UHZgyE2rIdxhInr0CsZO51a04P8iff4rGRD5kH
	iyLdB/97P2Mz/64nbHZgIFJFzzV0f8skWyx/zymXhqr0yCk/Foce8ULtMz8dxND4WpXrUFQ==
X-Gm-Gg: AeBDieutysgYEA9lBKr19swwvg9TegOGS3UAQLwTvLRUBbQtzJOzDv8yoNaVgPXbr8Y
	6byZg/xQgIGVds2kCVZAcDp/7MPslBXHgq87beDi+dq5KqsY7JOWPMAqcMEKOCuyFjI3jS7h3qz
	aQlswj2uh8ZAvNvfCXkhCZQfIjsoMmcB024MlYT1ArS4SX7RVili8PQwpJh5J7Seogr8g9Hutus
	wfPr95fFadJZGiODYneg4UABXB+BfyXnXQKvUZ5zSk4sB3+wOpMJ14Z6DcyFRrWbPSKbNDYF7gU
	1vQCApP4sD/eL+oryY0UYts6DUsxZpiI4DzcEy6V6LySdgApZzac7h/XtLE7Ap9BhpYnbSO3Sgh
	BsKTjfZc+Nij28jxLdAYk8Gjuu+rVCdOWSzqC6Ve857FFM8IgZFIk
X-Received: by 2002:a17:902:e845:b0:2b2:6df1:1108 with SMTP id d9443c01a7336-2b281867961mr157965685ad.15.1775528635549;
        Mon, 06 Apr 2026 19:23:55 -0700 (PDT)
X-Received: by 2002:a17:902:e845:b0:2b2:6df1:1108 with SMTP id d9443c01a7336-2b281867961mr157965345ad.15.1775528635108;
        Mon, 06 Apr 2026 19:23:55 -0700 (PDT)
Received: from [10.231.195.112] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27473583dsm153140155ad.9.2026.04.06.19.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 19:23:54 -0700 (PDT)
Message-ID: <09fb6efd-646b-4d0d-a0f3-9f6ce4b38442@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 10:23:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4 0/6] wifi: ath12k: Enable IPQ5424 AHB WiFi
 device
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>
References: <20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com>
 <5a606f7d-6665-4b0c-bbbe-32538b2315b6@oss.qualcomm.com>
 <95face24-deaf-47c4-935d-0b48b5141371@kernel.org>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <95face24-deaf-47c4-935d-0b48b5141371@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4RlDj5OKkMtxGqO7zyMWVMHCbEppSl0_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAyMSBTYWx0ZWRfXzxpP4o6LYmvc
 qqPUtrnM8+nsEOTE3pIVfrehcmml2WkVITD5cgA00CkZySZ8UxHVMXggFOgXVsMcndtZPs5+C/Z
 4wGNBI7JFe7pELLGVIonkqCRt5EdtXaXdTGS12dcdR60zXC2LUPQh5seyq6kyM/UIcoEIIpkT0N
 CZeyzxOl62dK0y4zdFo/pJorDfYC8Lj1BB1sSSlrOIDJlN3J5K3/Yyxqzf5MOcuhOYD9+/Er5G4
 P9zte2b0YllQZP/UL3tGakzoRMdKDdoKpHhwWwyTqEjsJbP7QOAmnHyx0lBUfII3NIdtv5LBQXk
 RyIH6/NLftD6xWleRQtT2DlmBRnVLsZ3eQH+onTcltV/bpBZRZ6bnhBi4uu0eJpp9lsiIN/UYpc
 b6PnAQJcOnQmEqqi6101ezj4yd4wXJeOtbOew33ODJK+CL5Y3XK3r9zham3Vhwl4VEoaWiFK6ZM
 1zPh4v4gKbisBukdl5A==
X-Proofpoint-GUID: 4RlDj5OKkMtxGqO7zyMWVMHCbEppSl0_
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d46abc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=eL9f3Vq-dHuaEv9KJUoA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070021
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34408-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E7A013A9022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/4/2026 1:23 PM, Krzysztof Kozlowski wrote:
> On 03/04/2026 11:13, Baochen Qiang wrote:
>>>
>>>  .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  1 +
>>>  drivers/net/wireless/ath/ath12k/ahb.c              | 36 +++++----
>>>  drivers/net/wireless/ath/ath12k/ahb.h              |  1 +
>>>  drivers/net/wireless/ath/ath12k/ce.h               | 13 ++-
>>>  drivers/net/wireless/ath/ath12k/core.h             |  1 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |  8 ++
>>>  drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  7 ++
>>>  drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 +
>>>  .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 88 ++++++++++++++++++++
>>>  .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |  1 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 93 +++++++++++++++++++++-
>>>  11 files changed, 231 insertions(+), 21 deletions(-)
>>> ---
>>> base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
>>> change-id: 20260331-ath12k-ipq5424-cddb63a46a97
>>>
>>
>> only nit in patch 2/6, so for patches 2-6/6:
>>
>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> 
> It does not work like this. Replying to cover letter causes that all
> patches will get it. Provide detailed review and response to each email
> in such case.

Got it, thank you!

> 
> Best regards,
> Krzysztof


