Return-Path: <linux-wireless+bounces-28427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C52C230BA
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 03:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE80134C80C
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Oct 2025 02:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCE81D6188;
	Fri, 31 Oct 2025 02:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZdHArAHm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mehmaipe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B73081B5
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878607; cv=none; b=Bd9TS8oAlcZSmeSX3HBL+VRrzGKgcALRqjNnKotOxwYRO33f7tWXYRv0QZBCeVpHKml4BSmMInk8jIgc8HioOqyq+GJGqotWhOA3YElQhbMfCsaQnS8bIPyP22G+oJZdsZy/2ET2iDaStaeYSRWbZWL80Jh3FCK29+W90iV/L4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878607; c=relaxed/simple;
	bh=rmr+Ve2aWs/gB/s7MAe6Pw22HxmqWxH5KSfU27VzoIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QB1HdGd8S/gNfNGJ/AJALDHS8O7iBv+AJN8ksfPCs/iXac+RsyAj/TT97uURMG/8veuysa5DvduvtjyGU6/Gv3NcJmIlPRpO33MdZZ8qaVb2QylrfDlQOupO5bNVqEO/J/mOfzPy8yHBASW2nyKEyrSna4JUcn4ml+J1M3LMCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZdHArAHm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mehmaipe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V1mwFm1571961
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	68Z9VSXVW6Q2ijW2mYpOsvswNsQdYdo/t5Hc9YHcyqg=; b=ZdHArAHmdokDpyAI
	BcUnFzOVnocHZ0l6iFFgt20WVf7euk4DQCYj73ah66fPxLM2r9fusut+bu0jk6Va
	QJW9sYbPNdInzCgjjZbsFucqlCJZbRFvNugfETZQWi83ivkazzKUAkRdyRJn8f4Z
	efaqkpo5EGWZ2fN8rsxkFke37nHM3HQH7IR/GN+mj73l9wp28y1hxKI6A2JsP/6X
	OEbbx5VjW5+9nSs7LarRxK8x74sBBws1+rV8a8f5I/9Wff81q/YcqSpfzRcleGZd
	IBDq1XbZjHAAMOwX2iRwk+FCGSoFrEJcXVHwItXDXn9CvTUVz976f1EHLllFuBur
	WNZTRA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc03yw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Oct 2025 02:43:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3405c46a22eso1492971a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 19:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761878603; x=1762483403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68Z9VSXVW6Q2ijW2mYpOsvswNsQdYdo/t5Hc9YHcyqg=;
        b=MehmaipeYUVgiuhpXARPfIRmVCwIG7Ljiw6P3Lp4rCgmderoyZdOUpcTBmICG+Osjm
         S5j6LyTPlEfoX3GIp867A/DnqMKhMexvPImsyZQMoKKxM9wPUb29px0fjQ/hEaNr02oi
         BxpER4iaDA9MDNMWIZ1gAWE0TzsNjpAOxw1l6kJ1ypXv7Td1iWxliMDhYS3T8ePvOtag
         aOI1DPNBLOyjtxIZsudS72MKccXQhS/+oY0m0szLsf/VvfsLdAhh4b1b36Vy30Ucd6df
         c0DcABmeKRZr1JVZ1qXP5uZ43HugZ1At+/I0Yu+k5kr8fIbwr0ttr8OGPh/eZ4C6F9QI
         ysNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878603; x=1762483403;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68Z9VSXVW6Q2ijW2mYpOsvswNsQdYdo/t5Hc9YHcyqg=;
        b=HDuw1G2vyjjN0XVCEP/vMxrjm6yGEpE4V09BUmdRVbbyZ2IQ2XjEUCvMo9CAXjVrGv
         48gfffUoT37ze64P0ogJ0gPsFBuFRY3EuGZ9La5SW8E2Iij4IJ1RwAH3cTcdYTg07JYn
         lfbODqPzacLoyz8SfzzIWUNsqiitVYlBUt/qof+YntK6qed2oSvSV+cX83F6Uwi/U8ss
         Zy5WOd+iymmuf9W3VD4h1PHecDKlJn175h/YM9PHS7EaERY6gtln8APwBsw5U2NoETWO
         G2AiziR2UKiCQqYBXWX2WSOLNqtzPpyswJe2H/lWUCyyJrQ2l8oz6rKghUFfEzlLT5My
         R/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUnNoSPDhsldu9CF3EgMK0RRzBOno2ERUkWp9QNQQOlmVrUHmaL2t6kHxkBSkEjg9SF9NCzmmGLXvZLigELpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YynmlXGjwKp9Yj2jkwrXiUmRHhW93Hk/uHmyR5aSEymkAXOjAQe
	LTboGd1w1HZ9d5/mLMUlayDYoX1QyGw+ySfsgmU4K/sQuIH6JlLD92zacKtNy6+Qi8FUlOALLVT
	j2z0QhuhvlQjFQ/HtwtfDl6/ZFeVtL4kX1/xm39MHy0HpTAdxR73l2JwYmL2UPIXyYJ49lg==
X-Gm-Gg: ASbGncsxXsNCHakttqHsr7xCwheBowu1mb0K57fVfNkJ3Iaded4u3NOMp8dnx9PzIVK
	a0StBgLubCWQICZlATAXq1G3+cPXOZA0gCi76Eo9Oa6PzEXhFH5Bfap3Ns5rxew3EHN1t6H+hrw
	eokyVrrhxRCkf2uJePVd/AtF5EfWYb4LXyFZK0YIB2yABfCahloEEWUAStMgEDTUZjK3kiu5MYx
	8vtsgvvtlpU6LA6/iWZ0tQYBqibkU7Y4i1k8BOx7oATJ3wmKehDXqBC6wgnl9Z6FKBPKXPDP8Ek
	4UjgeelTBHlhW2FVLuBUAaGHRwQHsph3ujVxWkBE9ubFmjFLZch0hvHMj9vcUECiNxBMgh290rF
	0oYhd7+2csp4TxQoj40q0t57LmG55L9Pn/6v1C3SJPUXq5fb+AdkWg1yq3b0s0/oqZm0uUag=
X-Received: by 2002:a17:90b:3c05:b0:340:5c57:d00b with SMTP id 98e67ed59e1d1-34082fc3dc1mr2586373a91.5.1761878603597;
        Thu, 30 Oct 2025 19:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuvmyhPreqEqyhgrmhj2nI1Gs4vA99T3cAVTW6zl/IO9uqi9s1AbPjZp+LJPV24OQB1Vh95g==
X-Received: by 2002:a17:90b:3c05:b0:340:5c57:d00b with SMTP id 98e67ed59e1d1-34082fc3dc1mr2586350a91.5.1761878603119;
        Thu, 30 Oct 2025 19:43:23 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bda59f56sm360095a12.21.2025.10.30.19.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 19:43:22 -0700 (PDT)
Message-ID: <0b4ce00d-78eb-4b5d-88b5-7d5b8de663a0@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 10:43:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/6] wifi: ath11k: Register debugfs for CFR
 configuration
To: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
 <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251030043150.3905086-3-yu.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyMiBTYWx0ZWRfXy2XP5x+Ude64
 0C1dqpUicrQyJ2ZkWPUCUujdIRnPehUYERWs0KXpijOjxashQ+lj0g0V+Np+sAgkT9H3KlrfxKk
 egDrRTzgx2OOC3SjTVCh/qhf+xlS+avZAQJ0DimFXw0b45pSi0TcXdI6LHxkwtpoePu2T70Ej0d
 XXok6+f8Q2/168VAsFLV2CXRYkYNGLzO6MKZ1IjJ0w0X0oS3lLFXrd3Z+oswZrjHeieMBfil8rU
 Yqp/pqDYS+q+DUz1V1MHNmOGhxl0j4dINKG23k02Keh3zw1MYeuSOQWSHvqeVR6G3pc6tcb8lBK
 2boEycatGIbFBe6M694Gg7NMuHrTXlcUbMB8MY9oNkaeqB9B1HtlwjcmJTqWY4euip0as7ZUXMs
 09Z//FuXj3D7IRZ8ndjTXJNFsQYo1g==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=6904224c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Xa9_aeIGFnoHwIuu90YA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: EQ6jXEaZq70VMbGD2zzPUlCw5h_4HLGm
X-Proofpoint-GUID: EQ6jXEaZq70VMbGD2zzPUlCw5h_4HLGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310022



On 10/30/2025 12:31 PM, Yu Zhang(Yuriy) wrote:

> @@ -88,6 +275,7 @@ void ath11k_cfr_deinit(struct ath11k_base *ab)
>  			ar = ab->pdevs[i].ar;
>  			cfr = &ar->cfr;
>  
> +			ath11k_cfr_debug_unregister(ar);
>  			ath11k_cfr_ring_free(ar);
>  
>  			spin_lock_bh(&cfr->lut_lock);
> @@ -140,6 +328,8 @@ int ath11k_cfr_init(struct ath11k_base *ab)
>  		}
>  
>  		cfr->lut_num = num_lut_entries;
> +
> +		ath11k_cfr_debug_register(ar);
>  	}
>  
>  	return 0;

miss _debug_unregister() in the error handling?



