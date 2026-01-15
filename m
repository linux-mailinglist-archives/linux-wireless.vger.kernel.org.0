Return-Path: <linux-wireless+bounces-30854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA115D2955A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 00:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591A330A99A2
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 23:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651C333120B;
	Thu, 15 Jan 2026 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X3WVWNP2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XbGMG0VA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E83090E6
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520887; cv=none; b=L5lwwikL6kvuF1IxQNCpPdREEhLDOLchylPcFCdginL+V0lUnxRyzbFSda1JLpvJH1dQttkvbFjgsrNFDE9EDPxbLq8pWol8r/o0KLDmplVcP64eHAEiGfNO8k/lLQVtW33+Ij+BLOgQPM25sA2EETecdom+iWtuEKSvkKH8uH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520887; c=relaxed/simple;
	bh=nJ3p6mC/wzPvxadeDm3fHiQidrwfAMDEvfM92VICd4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXAgYOmXK7NdTLgUrMByyrGOZGdDykw6PktTDY/zGSLsifkinBh50CN/Ntk4ZW280jo8btnsaEMO3QfqIpqnY9rF8n6h7MREDOlWtgGGwwxhNr1PejE72WBFCbIfjALg+HuKDaLXYcaYP050XhGHb0w3xtseByoaq3lttpnUA38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X3WVWNP2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XbGMG0VA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMl3mw3582947
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 23:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GyBSAugGuEeuvYZ4IecENAE/B7++Wdg8K0nB6NRo6ao=; b=X3WVWNP26YCG74if
	CAiNmyDgBOtzcy9WXiEZ/eFxHOikDSfe6FjNSvr3DIN4IXzQQeFNAtMx3wYdSO/B
	G5dzGgtGfvsdxV+RM+ydZPArFIhnv7NUCYAixf4Zi/EC24oEtQQDkERnQ4tr28D0
	srB8eDhL5Fi811iKEG6/xQDAGHm0D9OGZE8xKjZEmdr9Jo9q6MMJSq8iTKnaiWcu
	nI+M8xprfC2fj2tyoc3QykCEX0bAQn4padS7KvA9TrPeMPd+VWDwZQsrcDluPrjd
	HYgIgyrt72iiANJSFEUSxcZ9UzznpP8eahaN9mTFiJJzREqGadZecMxRL9146ezn
	CdDDHA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9ayr3qs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 23:48:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c3501d784so1127324a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 15:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768520882; x=1769125682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GyBSAugGuEeuvYZ4IecENAE/B7++Wdg8K0nB6NRo6ao=;
        b=XbGMG0VAz+o9R9DWDBf3ORsqjvzMl5ajHPXFEUl1+fFncuhJPE+bvYsVHmzdCT1k5+
         a7M9Sua18VCrhBJinzyJTbCtS4ZBjLAy/LpUz84/1InDjbrUXd0rWWwCf0tHwKGrD+L6
         TCjmFrfBy07gUO2EHaV3s0tGqit//oDrAG/umS9SrVif1eEhzKOk4BedNbOsXeHZK8kZ
         o4tGuxPCuLmriT+yO6LySUDsvYljpIxTVd9HiPKMVU4hPXjZGj2GTl50vtitGRj0uoaj
         EJBupHPDTOScGiMZSLt/FLOOEPLbg72HwkSrRGce9p8cAvkPnsbeNLbqxbAW5skue2Og
         cC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768520882; x=1769125682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GyBSAugGuEeuvYZ4IecENAE/B7++Wdg8K0nB6NRo6ao=;
        b=rZlXWN1xy3YsvjDNLwscq18qurbFb522nh1BsHUShnVa/rnbINNWG2qkdPdN2yosC7
         6AksD5S2B8QbJVpWhneMgYZn/lo5VIV7BURK1Oo2VkW5JZMZThejLJMccNW6ZqhmnNaB
         0FPt+2LU9UBEo5GZ+rDbtQO4Q2oRU25w+cnDmVtAd3kh9OelndysiHHCU2i0iAyoncAu
         lTvhH4kJIf2PQHxT4gARAJZnbpJRC5Afu7HORr/bRG8+mDktFNhP/Y56jV3LQpLL82rQ
         VkFxLHsEbVTMN1YO4CT7VaRGWWxo3oG62/kXMjxnilqWe366pQuiw9PA7V80vbuBFfwZ
         fnDA==
X-Gm-Message-State: AOJu0YwY7ATlyMBZliGmcb+PZEFK9dFOqXy5u0T7tWyTsainR4y+yTny
	eO2bgllxN9deS4oYsMKhKu1eKQlJsDqDGzc/zNelLHWu84rZZwQNZ5ReL0rsmGzGJgyYeGwGrPb
	QCcgY4ZcXLBzok+koZtWTFRHl8IM+0tBJWGc44XBGmJ7pFT3CVGAQfTdXNXS9Ufx1aUrYcg==
X-Gm-Gg: AY/fxX67ZEoxS6tE/ljxTAwqCdxH9GpLiY98T6kIf4xqJwLCn/d5zPqBZW5mMQWEJFL
	28nQZa0XG3ZC4nkRTNEGKXhmQDidXjq+zuuWxHKefRVN07OVW8bx5qcsUCb25EKh1UvfCKjphUP
	u14IabL4wRz1AurcwU0I8HF33/sgtroScuaPuDUHXv8UV+RGNgG/G6NGbnJ2QC0ABEgVZFQbgcf
	Kiim/YsHNATxcHbfKpyJyKaUVZ45Wr1RuStIuamivlpD/ZljgqHcbLRV6X/Mkh1lQnfZ8ImJG5n
	xVwj0Rwc6AQl3S+poG6Stg0ABy7it8W7Rxxx6E3EDS7TQODP92bjw5ppkGMstnkT2ik7K+0EJtm
	W5bOhCs/sm250ocBEN1tXjCg9yh3qRuIGUK0=
X-Received: by 2002:a17:90b:568e:b0:340:7b2e:64cc with SMTP id 98e67ed59e1d1-35272edc45cmr952774a91.15.1768520881685;
        Thu, 15 Jan 2026 15:48:01 -0800 (PST)
X-Received: by 2002:a17:90b:568e:b0:340:7b2e:64cc with SMTP id 98e67ed59e1d1-35272edc45cmr952760a91.15.1768520881171;
        Thu, 15 Jan 2026 15:48:01 -0800 (PST)
Received: from [10.253.11.195] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527310210esm427320a91.9.2026.01.15.15.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 15:48:00 -0800 (PST)
Message-ID: <0f4fa27e-d9b4-4a23-8c8d-53f4a7014167@oss.qualcomm.com>
Date: Fri, 16 Jan 2026 07:47:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v5 0/6] wifi: ath11k: Add single shot/periodic
 CFR capture support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Yu Zhang <yu.zhang@oss.qualcomm.com>
References: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
 <717658b7-91da-4073-a746-a389319aac2d@oss.qualcomm.com>
 <a7a73ad1-0761-4abc-acc9-fc94a4e77348@oss.qualcomm.com>
 <f0e98751-8fed-4cb8-9cc6-59a691f172b5@oss.qualcomm.com>
Content-Language: en-US
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
In-Reply-To: <f0e98751-8fed-4cb8-9cc6-59a691f172b5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fUR7Ln3yk_K3a1igsCPUKbwgskgjOd4G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE4OCBTYWx0ZWRfX13lTvL1R48UU
 7Wn1q7gFN8G7oRhynSZUOZCjWGtSLT1IEWmQriHhnzd/OkvGjwZOLCfEJ2WXJf76ojeEvgUdMQ9
 YO31s7bmBhYFlpU8nWQCCac6cU0P3YpF0Jcrn5Czoa7XWECbFpfyFuveGhYa2/F4W2MK2eXFwGe
 iX1rVmBpkU2825gUh126TbHR1stXYdUZfuEJav4Jy33R+2mjZpCL8CT3U8nqyOwXiUSBelnRlTB
 4FECPRh+JpMvgSnoIaeAcLiggFVIe+aLdDB5FhT7yyg5sljK+RegC+o04bCPunXf2lvscAQ+CtG
 kVhjAw6U86bobKoOMkNdeAlgFq42UQnqaOG6xk4b/PMrm8qilKQZe9yuFhPYKi2tYyMxe5r2ZR4
 2lLUdDGK6EQKoIILA2374C9/HoZVa0t15AxrVjprCZFKhF9RkY8S0a/xe7pGOOj2OzgE5AtZ463
 xIb5seaonZcRdkb6IVQ==
X-Proofpoint-GUID: fUR7Ln3yk_K3a1igsCPUKbwgskgjOd4G
X-Authority-Analysis: v=2.4 cv=NfDrFmD4 c=1 sm=1 tr=0 ts=69697cb2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=TqcbJbPLsSPoifzPepEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601150188



On 1/15/2026 12:55 AM, Jeff Johnson wrote:
> On 1/5/2026 3:51 AM, Qian Zhang wrote:
>> On 1/5/2026 10:22 AM, Baochen Qiang wrote:
>>> On 12/30/2025 4:25 PM, Qian Zhang wrote:
>>> what are these dependencies? They are not present in old revisions.
>>>
>>> BTW, if you indeed has dependencies, in addition to these prerequisite-patch-id's, please
>>> also list them explicitly in the cover letter above.
>>>
>>
>> These dependency details were added by mistake, and I will remove them.
> 
> Was that the only known problem with the v5 series?
> 
> My automation flagged a checkpatch issue in the 6/6 patch:
> WARNING:LINE_SPACING: Missing a blank line after declarations
> 
> If there are no other issues with v5 then I can fix this in my pending branch.
> Or you can submit a v6. Just let me know.
> 
> /jeff

This feature is under LX test now.
Patchset V6 will be submitted when testing is finished.
Fixes for new issues (if any new issue are found) as well
as all previous reviewer comments will be included in
the v6 patchset.

Qian

