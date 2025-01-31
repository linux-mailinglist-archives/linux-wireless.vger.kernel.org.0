Return-Path: <linux-wireless+bounces-18255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F784A244E1
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 22:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF0C16045B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F216E863;
	Fri, 31 Jan 2025 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N8Yz4maY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2FE7081F
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738359573; cv=none; b=h94Z+iqcxakzmtQdzjjNigFe3y0CUkqbqs0JMF+595GZezNMK5X4OGwNjhWgSShF0RbwKxK74tovUImKRnV8iNbOfyFxVSFc0zEJHrXDtBFRhxoCu8lw76Km5+LYs6fo551MOEFBZY5vCpUErWL9VjItmTShJJodWbc02e027u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738359573; c=relaxed/simple;
	bh=eIMMqebP/IWDMP8z8l5hUKMQCUX8Cq9kAHLI29fLtFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHs63NMhvYAjHK+GdsZZTIznr+GvIGjwAzyRmBwyD62VDG5TFWy8ZGqut9EFSrlzLEEn/zk1mub0uM+H61GOkZCnF0HO0jgJtxb6paHKyZIobvcAcn253ZoKqGhBCMcygL1Xt9wIX1LxpmM/NQaft/7p+iJq8Zjv+hFg++GgVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N8Yz4maY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VEWdPV022713
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 21:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TsBELOAzAmi91oOTDqCPwhUTrs/cBmvIh9U2AqPhsV4=; b=N8Yz4maYutS92ld4
	oiImLuhDQI+ZTUR0L7NHBMHW8Mk989Dq6TTp+NgYnSzu1Q63v8VpB3QCAMgwU14b
	GqiD23DPjG9QmjKmW3ilxeSIVyevRUCzDd9L5HaPFOxJ7UVagkdRAg30DV2C0d2F
	BuWD6GOurRuNIKSZQTxaHVSEsinqa8H67Zl6b3fF3L2u02VL3bGBzMC1bMQUxGKh
	bq9aiXj/Nrx+Rje7IUgCrXvIiB2+G4DnMoDZF5LW1bS/y7MkF7rpfx2flQLqUyD4
	4T4UcmL68Vu50OcH2etH1HBngcalPxb5tHLiWg9s4Rwnudc8idLosfVjvtjvZ6xS
	0+iH5A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44h0cgry46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 21:39:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2167141e00eso58061445ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 13:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738359568; x=1738964368;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TsBELOAzAmi91oOTDqCPwhUTrs/cBmvIh9U2AqPhsV4=;
        b=qQVBdL4SZCtZcp9gjBtt4uWKKpUK5ETHkYomkJcUfIUcEvNLR86J0ru1nY5qKmmxHl
         XgAdjXWflanrweoS2Gmtqgu90gXDapEgPjJPTn1paow4KINIwpEzENWpWG56pP41clun
         esvQoSQtWNrqhiZKAcgEKmoJ9I9zNXyFS5GGwUvh1ZwlxiYOYo9DdkQCMBZxFaYSkFkv
         0OdHm1+F/RfiudDZHD9wnUiNwK8PdQLeRNd5ebywca14FHDwXjYOsXMrMvj0L4ZICCzw
         btOVEQUlmQW66+vfqeHAnmT+Q43R/FsMPLYwsVWsh6JPsr8CJlb+UsToOo9s3SzBLMxQ
         NhEA==
X-Gm-Message-State: AOJu0YwY7V2r2lCcNtGRegyZ2Nm7an6PAarEgIIP1k6IIzq16PpVN0Dr
	mvSz0med7QGSuv2uI/vYY56b642K2smRV8SDkD1NM3Aw+HDQcMYAVQMwie2BKO5MOMYDUX+TgjX
	MhXXDGYdvzi/QVvejMfKxr3Ii2phzF/UpOb4qjffDRVvt7DcZRGFenn5ozW/Rh21+Bvi3qqUwGg
	==
X-Gm-Gg: ASbGncvuEmQ7R7eXOy4mnUJsZBhoXlDe3JfFN+lXDCiYAdXME7IDLEkyWdXSEHXUhrU
	uYv0C/p/ogDrqQL3qZqLpgtIZecHyq1jLCT3pSjyoSpZZiB6s8NAugR5YpgFLoJItaAU9jk0yy/
	vssDcqMzKnZpoYt94k0HPaDyiqppfCvHBTWY5GqIBuu58Pd2B9m5pNqfnBJuB4cu/Vr7PosBkHk
	6m+oB4lMtq7NEGeDsynOxBpG1BBTafgbs0fnXd/sBgzgEVnTmfHXrjyYRBqL405tMXp7qdTzWi6
	XaW1NKw5Ze1IMDpY1MRw5yCq5VqcCUVKJDj2Ft1p8HLFhX2mzpmCxkOf8VHKLZjlS1zCObq0zw=
	=
X-Received: by 2002:a05:6a21:4c11:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1ed7a5f8e53mr19300020637.17.1738359568565;
        Fri, 31 Jan 2025 13:39:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwpggz2ICAr8nYuwVwTHu1Ml+iC4KmwaetLS/6mEBQsZid9/Fn+yvA4EcSaeP0IQqDC6OlPQ==
X-Received: by 2002:a05:6a21:4c11:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1ed7a5f8e53mr19299992637.17.1738359568135;
        Fri, 31 Jan 2025 13:39:28 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cd801sm3759463b3a.123.2025.01.31.13.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 13:39:27 -0800 (PST)
Message-ID: <7d1ea897-6d8c-455d-a6ed-d8f0b52b6c1f@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 13:39:26 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: add support of station average signal
 strength
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org,
        Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20250121093834.25132-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250121093834.25132-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Izt4p7L_mMyA1YPyXj4C4Y9w1kSXoS4M
X-Proofpoint-ORIG-GUID: Izt4p7L_mMyA1YPyXj4C4Y9w1kSXoS4M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=929 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2501310164

On 1/21/2025 1:38 AM, Nicolas Escande wrote:
...
> @@ -10054,6 +10055,10 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  	/* TODO: Use real NF instead of default one. */
>  	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +
> +	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi) +
> +		ATH12K_DEFAULT_NOISE_FLOOR;
> +	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
>  }

This conflicts with new logic that came from Lingbo Kong:
79e7b04b5388 ("wifi: ath12k: report station mode signal strength")

Can you please rebase?

/jeff


