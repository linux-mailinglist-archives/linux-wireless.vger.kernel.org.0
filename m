Return-Path: <linux-wireless+bounces-30106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69076CDD9FA
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Dec 2025 10:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1F6F3015E00
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Dec 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4127314B71;
	Thu, 25 Dec 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TE2v60XH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZUpqWAU+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA6219C54E
	for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766656436; cv=none; b=hStZnT7jhqK4kGF92qwhijfe7hngKAQHeZgxYcH9lLAcVXWpvM1fJBzJD44I9ZO3zIE5o1es5voghv83GGrwwv+C6bb0X45vob8YTR6myC03KJc8AWNKvU6YE3Ehxpt8FVohTj05Sz1g/AR75j3FJP/otW39gQmZD5H4ipXnMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766656436; c=relaxed/simple;
	bh=Hu6JmXaFBBhngoQGu0uCotbTjGGxHGrYRZUtuF79D7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAqn8InLAwB/vkNpvDJ6yb6KeHpY2iq+cY4PlJwRdlO+LeNND76j1hNxWQjolPzvaRKlt65FtQImaT3eRqeQodgr8cxQj4K0IcowxxFsPj4mu9uOIHhwPGOS03UKoVGQ45fvyfFsIMOrRhmAx+XJlOLm1+NsavzSrqMd650PNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TE2v60XH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZUpqWAU+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BP8bRnE2064237
	for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 09:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zPoJzn5MnVIeCWCGvk2Bfp5U8ncISIr0hUiVXJGS/dE=; b=TE2v60XH1FUKvUz3
	ds+7IcAvHSq65cJ0C35k87Gp8aDp48NolclJFd/lBbOiq9iGHNOrssSL2LqItN5L
	Ugk0+q9nPkW7+E/N8d9WqFJZs4C7z1aZh+xgTpoCARlr9sBFjS31NGHFnjwDcabF
	77V7B0bTDGroLypC63r+t5r12ll80ftsTLkfl+3RbfXxdfCS3uG3tljs0NsEwrkA
	O+3OrFOdnOXBU1YjeSyulD0sqUNC7UWiQapwc7XLECC4r6BIna8o4zMrFPFrrIAf
	qCV+LvmYBExL6+dTk9vRceXcRS2ghVWra9M0XQnJtB5vNytpAFql96vYEhjWT5iN
	jL5vEw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b8p49156c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 09:53:53 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7d24bbb9278so12940500b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Dec 2025 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766656433; x=1767261233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPoJzn5MnVIeCWCGvk2Bfp5U8ncISIr0hUiVXJGS/dE=;
        b=ZUpqWAU+iFKqOjm5fyEPWLtz59ja0tQlqHjc9iHPiVQLC+LFeZdDVp7aiRDEIsmQFd
         iSCn1+C9pLMEJn7k9f/6VlRrt7hjOajpFRPgLobFZcNZinPIOfC8FB4c4xCMXgcXdid+
         zcZAfkg6i+xhX3yHjDCAc1IgUMXKv8SerGmk5KUTqeNEaUhHZuTtOe3Inz7arYYl4jgC
         ok3AZgeLkr53QNa7F1dxOTNYdfmZYdkye2GorK8y/a7AC1lx/YSkYWcN0wMKLrQHEVG7
         lsjRrZoF1lS3GdVTvN2zG/ZMZPT0ATx713Fnt4dLrSg33gBi/LMTrw3LODMnK6HM4Qem
         vBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766656433; x=1767261233;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPoJzn5MnVIeCWCGvk2Bfp5U8ncISIr0hUiVXJGS/dE=;
        b=bpGBF8FOY7WLd03zmrRJwfmDDb6/9ImAI2DxedfYZcvxLkssbijsLUxgID7ykf9U3/
         hUNeGv+/mOzPlrroE7Ey44zOJsSQ1ykPu46o6B22qa4CKcahs+tfLcDv5Gi3PxdJPlUm
         QEVVUAao4xECOXGvI9QupWLxplhMZ3sKC7+3RVOyU1fHwUKI2C2NNZu/1zH74eqcPMQq
         QQeldrSqgE8GsR8fegYTI1U+13dforPpuSYFT0kB8RqOkG+Wnl5w/Psvw1c2HIiGVz/i
         VeaAaUwPVCZJGZ4Q1pSpYbBU8QW0mBeNl7BED8Iry+5RsbwPCkudfDNBXVk+bnAzk3DC
         KQVg==
X-Gm-Message-State: AOJu0YzuOc7ZtHXbwt75jjBZA34XdstsGfqtI7tsQ3pN9WoonIvnbgod
	tYmYhFlmMuTEBCvCP0HitRY3kEJree+ZEmSBd4T42S4RIDtqDBcZYYS9KLU95r909t+G3SDuHA4
	7LgKJYlQqAV32KEjOcm+C38HrujX4z7N5MGg3eLWG/HRhvBIp6bPzE/atktr9c9azQ9KHKw==
X-Gm-Gg: AY/fxX4mfOkU3dawtCq8pwpOBeOoOHWKZ2tteYt6ZUO8aLPM+ssJRvcxHPwPLq0ejPx
	ZKs2/l+UueaFbVShEWz5HSXVcLeL5cbtsvL2aK+13x2fYIu8cAt2VQT7JBSHozaJecpFsrIKC93
	mFY6cKaO0xNsTKcXcglUcKZAUJ0yEXgWbUuiNdDfx7v7NJ66ezTvKEVphaMdXmH7BjnAcXbpFxE
	jXS8NBOSUooWdZrJU+i+lDnU4fe1EDu/sAlE+Nlx+5Y6u+0Of43A+OUR7bX4nf25i87vQNUawNE
	m3g22ZSj6crZVs0CyG1794zD6VD+lQWEOW0Pf03J/UBn28Yt153Ujpu9b/GD/NyLlQeyF3BJdBv
	dI6mFXIP9MDZiy43h3RPrJ7PxoWIX/Jv1lzPFn8vLpGq+8XLsoyWpTaH7Eu8CTSuKCinN5fWVDw
	3XnFycMg==
X-Received: by 2002:a05:6a00:328a:b0:7f7:27dd:7b1c with SMTP id d2e1a72fcca58-7ff657a3052mr16843307b3a.15.1766656432908;
        Thu, 25 Dec 2025 01:53:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGn1qJlipakub6W2N58VGWbfUbPN3Zr60Q60P+PGYZNJMcFTv/ySGDvrx6wsHfo/9FhATfXyw==
X-Received: by 2002:a05:6a00:328a:b0:7f7:27dd:7b1c with SMTP id d2e1a72fcca58-7ff657a3052mr16843294b3a.15.1766656432497;
        Thu, 25 Dec 2025 01:53:52 -0800 (PST)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e792b65sm19218679b3a.58.2025.12.25.01.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 01:53:52 -0800 (PST)
Message-ID: <566f4d26-8a36-415b-9ec7-3dc5082acb2b@oss.qualcomm.com>
Date: Thu, 25 Dec 2025 17:53:46 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: "Alex G." <mr.nuke.me@gmail.com>, ath11k@lists.infradead.org,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216043555.628296-1-mr.nuke.me@gmail.com>
 <83c5bb41-ac0f-4f01-be38-ba536dc8b977@oss.qualcomm.com>
 <3484871.yKVeVyVuyW@nukework.gtech>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <3484871.yKVeVyVuyW@nukework.gtech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lPjVqUV0DdNuKxBrqU3kzrKoJRwUkgtU
X-Authority-Analysis: v=2.4 cv=esbSD4pX c=1 sm=1 tr=0 ts=694d09b2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z-jVJAX58Zs0z9JWT1YA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI1MDA5MyBTYWx0ZWRfXz7joWScXDDjY
 HCRXYECXqvK+bbg5cyVH/SL6VuiXWr5P9tsr33SwUDCEvT/8JKruS6Xb+sdWP+8RGVJRlmPxPHJ
 Cq3tc5/Y7ZmsEXa7s96t/z7ppP4FrM0/IuxR3Mia3e0jJFp0aF7QUeIICb1Nbs5Vq5bHD11NxeL
 ZRytOB7xsUKaSvHniIoVLxi7m/dIIZYh2JEtxnrWWy6k6JNqGAFhiCDJQ0QOpFufpQJ93sU/wn6
 /l/uikwVOzeBj0+bZqVGXmDngOkWGApUNU4tjDBT61/a/He1d7O+wtaWxl4Dm9gBQzUvHDUezI9
 dOXie4EOzpxKip2Cu2LfLipJeB8NvAbNdCQkD8WOlTUrfG3SIJi8urq6PXEgeq1AxoGZUH/hbCR
 wLX14Im4fpRgFNPFix50jDnliXWSpbKm35u+9sk6Wk+MmqTpSFGUTYgtW6TvCuGmSrwqXyJJO5b
 RbJd+s+9yJrnhFdOnsg==
X-Proofpoint-GUID: lPjVqUV0DdNuKxBrqU3kzrKoJRwUkgtU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512250093



On 12/25/2025 5:53 AM, Alex G. wrote:

> 
> Sure, I will do it this way.
> 
> I am ready to submit the IPQ9574 support, and this patch is a dependency. 
> Should I include v3 of this patch in the IPQ9574 series, or submit v3 
> independently?
> 
> Alex
> 

I would suggest a v3 for track purpose. Another reason is that this patch is more of an
optimization benefiting all chips, rather than being specific to your new chip.


