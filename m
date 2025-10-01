Return-Path: <linux-wireless+bounces-27766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB973BB1417
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Oct 2025 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A515B3BCDB5
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Oct 2025 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7442202C48;
	Wed,  1 Oct 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HlxQBG1x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1274F48CFC
	for <linux-wireless@vger.kernel.org>; Wed,  1 Oct 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336353; cv=none; b=jmP3cDEmdtF1oVxhap4MUQ5bhSWt+b1xB6KXzRp10u1kJc1ZBNEjmtA+mVnU1GudUw/PJIZv4/YjfVPDE62sSnv7JhmUwGbVohGXh5zNSpG2JvKEUjYmL8cVHPJOwQ8pN2eLZsL/B2bxQCDXeA8rI1DXLWlft0WmqyMvJk+PypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336353; c=relaxed/simple;
	bh=RcWt0X17By87dhkKTUvzGaJNmiW07LzTqhvJbSvKb4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIy3H6xRIF5oOP3bLUb0YgD47t5Vg8wJpIHMACISCrlrX17NquFLjxekNqmgDxukSklx/7m9B93kG/zc3IiN3QDQngnQuwZPw/t8amWWjNMZWYYv3dTVh7i9xlgbNQoywwhfX4TN+716xvdFuRiJQlunNDHU9dKoEU+Oe+zjRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HlxQBG1x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918ibl9012677
	for <linux-wireless@vger.kernel.org>; Wed, 1 Oct 2025 16:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sq3bI3bnAI0F0KcNdtZCeKselMxl0pas0NBl//93cBU=; b=HlxQBG1xWoGfSarH
	c6C0yVT0cjMyIhzg3HmcGjPrN0gAMlKfnh6B3p5LsUTH5c19E+FewaYpKoLmBLZz
	ADwcnQEg12gLcXV0w7FVGA3ANDRCJMfoE5nAqI1+ytOfVC/T/pESE2NKBRkgOH5t
	SWUOLVSywweasnaFqJOo2GB3CxAks9LUCdJs9ghxiiAMlogEgabv2WytD8PcM4xM
	qxtRtimROkc+X/t7oBOlwhuDyGwvFqhcBO0UwcObNbU+JOZu5UmrOiXW/6HKYjFP
	nxLB003I0igNvFAUM2Cqg+gWb9t7JJkEZSNtvG1PXYf6VSlRFrVRQrNdfQl8nO0a
	VxDI1A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a658um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Oct 2025 16:32:30 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7811e063dceso84224b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 01 Oct 2025 09:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759336349; x=1759941149;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq3bI3bnAI0F0KcNdtZCeKselMxl0pas0NBl//93cBU=;
        b=p+3cuanyKvlIlLHa6onBeecyVQ0TlNEe0Goi17MMOBp4mQlk2XQlvgzu5EUOY4AIT3
         LrEGBhHeHuDt3mCmi2Ym0owlH44N3oJ1NkrxFmy6VblJUYKZCy2AMG41tc59dxdITMhO
         +nJoGXXujTR6O104ZOkhkKuapLseh0AtWSiG7DRLW4JaoC5/fw1XWN1r9CjEdqywqMGD
         ZD7lNncbJPJ4DG/yrUwoa0WNjUjU8bxgBTv2top+Jb8y7lKVAz67UfJ+HFp3XCeK9jF3
         c/noiZoqSsugg8AIquWAefKZ9QrmLdLJSD16x5FkRrVU1t/DGEgdgIqKNwa+ymFUQNjE
         ZwNg==
X-Gm-Message-State: AOJu0Yz1FZtRvYYvdQb/0id3ogw4kJM3n2bbxZ/JQTwDcF7s+3LqTDD9
	Au6tK3Vldn69vzChj4KA5R5HUnrFYbLsff5dEr9dv29jUDh0Q3ZHtwf5NHWJj6T2ozRq4PHytnn
	FrM4kjbRrRWOnrQFi0T+I3i/VJaBFVdeG6mM8djI+T0LZ6ckB5jvFZyuCFzpnJ87f8TszSa4IOb
	twjQ==
X-Gm-Gg: ASbGnctOUocnNrQPdnQXrSDpDpHn6FwaiwWpHV5PxxWKaoGjEqFWeWBk6UfZthwgMds
	vC0E4jX4omW9eHvSwQ2Z6vAzV0nnlSos9lT42S0ywZqq43/NUbF9DoGwvlcDZ16FgyVhQsdFkiJ
	0naUFla3qYkA9Rpggc38jF22YuXYNoe4oJHTPzWZfZQPOy1UAVjxkyEDuEa5FV07uK7+yPHcjvw
	RdBTBffbcDjrGPtvGyNdd4GDMo9ZGVRN07J4PPw8eoF+rHYKOfmuiHo0clf7+wmOwmrclI8UtR/
	4tBuBN4O2XVMwQE2qSnB5EeR4HcEQ4zTMl7EbjY7yG/ZXzoUcRU5KEZx8ezq8xCCEiBtTt9fm21
	UKORvhvp4CRF/IPWH8djdQ6u7FtmlSg==
X-Received: by 2002:a05:6a21:1645:b0:2c6:85b9:1df5 with SMTP id adf61e73a8af0-321d7f8c217mr5569343637.3.1759336349091;
        Wed, 01 Oct 2025 09:32:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8dj5I/wgnCHEUwIrlmavy3IBtxPahhF1d2AkF2je+VmrdEnfr7CMRxr+KnTT3Pfpg9O2pHA==
X-Received: by 2002:a05:6a21:1645:b0:2c6:85b9:1df5 with SMTP id adf61e73a8af0-321d7f8c217mr5569280637.3.1759336348563;
        Wed, 01 Oct 2025 09:32:28 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9cda9sm166699b3a.13.2025.10.01.09.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:32:28 -0700 (PDT)
Message-ID: <b3c4ab9c-317c-4b68-b00a-d91c1d47b0d6@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 09:32:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 1/2] wifi: ath12k: Refactor data path pdev
 struct
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250930181848.3386271-1-quic_rdeuri@quicinc.com>
 <20250930181848.3386271-2-quic_rdeuri@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250930181848.3386271-2-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dd579e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=JQCij2u2zznS4gFo3ywA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: n4ucfXB8hIzLX42v8iXBLzh9rhM3o0IN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX6vxo5+irOybw
 wUmTbba2+gyGX6H1EW+m87G7SPY+xUNe/PZslYufvZPsOf9mPD8rWa6WoAr6N2txrIwbotdXDSw
 mfdHuRGqOEvSDaeueCcRwfMp7Q1aBjtZwyMBDJUPNC8pIAjroPqGJNQXMNTN0l5Qlev8yBYmk5k
 PqJMghmWkb+pKu4dxdDtT1M8Q3xh/39Exs4ei/iolFklv1B2fKZmoWZ+ZJ34oS164/GJ8sBGFbU
 QkgStxDfnt2B7+e89BaRM7oaWKUYf+3JKlk967e3v1qmDQKfQo0wKSdiTprqnDzthEN7zlILxKW
 svcNyOdH6Fi1+uQWrmJezlEWJp1w29Bn7c2f839TpPahQNfZC4DFEUo7/ar6xlsJssKYzMtql8f
 /iZuffzIJx53fiTlNKAZyybiq9El8g==
X-Proofpoint-ORIG-GUID: n4ucfXB8hIzLX42v8iXBLzh9rhM3o0IN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On 9/30/2025 11:18 AM, Ripan Deuri wrote:
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index 1bca998117b7..98af9a17dea2 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
...> +struct ath12k *ath12k_pdev_dp_to_ar(struct ath12k_pdev_dp *dp)
> +{
> +	return container_of(dp, struct ath12k, dp);
> +}

> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index 546f73e46c41..084e0a3c1bbb 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
...> +struct ath12k *ath12k_pdev_dp_to_ar(struct ath12k_pdev_dp *dp);

is there a reason this isn't a static inline?

the implementation is trivial and this seems like an example where inlining
would always produce a "better" executable.

/jeff

