Return-Path: <linux-wireless+bounces-30414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD36CFB818
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 01:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09BF930124E9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 00:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A0314A4F9;
	Wed,  7 Jan 2026 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+Y0523Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g54rYbQC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9107E168BD
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767746639; cv=none; b=V/9gQuD/h15DJJ3mGQM6taMjl4BPSOxQU+ZD44dzbfoMbSuG+et98jztlnQ9QCvCfNVpsE4dhGiO5pl4b+SNBt7TYf6u7nf6fXyQ9m44EyYT5DsYq1R7S6l2yFYntDsGvE9iDtBhKsWOEPg28irwjKJfCH11Zce0+88nSpcFRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767746639; c=relaxed/simple;
	bh=nntVmnnLJPM7xnbDiNYtgGUI5xAZPgIUDh2Y/Qk68IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1zLKz/5ddAjbMYTUrXwllKMiyGDs3dd7tss492RS+Z9xukme8UOJTmcphjN4By7UlvuYthK7/3FxrRwt/LG/TfErZcr+jQ4n8Ng/RqPrrb0yUTNUH5cLeoHBqEswZulG5CVhGr68MfvH+NwNcbr00bdXWb1uQW70mknooppeHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+Y0523Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g54rYbQC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606Gi0im364946
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 00:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9qA72KT28VgOjg8B7p0XTrqTLPCU/NziYWWjXvjQdh4=; b=M+Y0523ZTG0BucHj
	TRgOryj+OiLI4ed93m+kANhC+oyyVuKObWkfmcVTNKhcCnhhRy4jqt4f5oz5kf4I
	N90jm3FfUqZ3tZqr2Ne9uf+BayidKrEbLS8grWhq10ddGKzMKKYC/cLqCnw3UlX4
	thX6KjLqeiQTV+83nb2norpfa6kriacaoQOdJBZr6++kcVCej1t48H9qm0j7pzj8
	D1v8QmnV5hgUpAXzV5WjmIUMmxUf0W5ZIQLHnbiU1q6RRUgB8eTysm/vmGUSOnEa
	knWQUVeV13cGaCEg2pENYY/pT9oBEm8ITXbJrLCZc/1idFcCdMO34oOCCOZojksU
	sVSvLw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh660s72a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 00:43:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2b0531e07e3so750450eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 16:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767746636; x=1768351436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qA72KT28VgOjg8B7p0XTrqTLPCU/NziYWWjXvjQdh4=;
        b=g54rYbQC2pPW0XLi6cOaA2bK90mhbiFWgWfNrK/2n6JZqUd/l9KCQSxROLwOlN4TGR
         kGt/wRI8nd6tjVa0hYxqLzPpWywOGvsKFMbwvAnRCI+3GKfSX3GhQlCBfdcVXpVH0haA
         9mdTUbfmhe/JL59E5E28VUMQ8fME9uCGRcdaP0eEJBBmw9fMLtKKLbEqddTHOlrlZhzX
         0WsIHuuz2Kr6JdIvJHPNuXiYm8dFT1g+wf+2fxNpB+E+SrGMq6xzW5jlyvNjMACLOgIA
         EpYLi0Qacr/T/E3Dilkg74CBFjJguq7abeaghgD64MHQk7RCNnruAA47RDBzYp/wISIS
         lBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767746636; x=1768351436;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qA72KT28VgOjg8B7p0XTrqTLPCU/NziYWWjXvjQdh4=;
        b=Yh8eVsjsPeP2YEy56OuZNbh2ChUpB5NOuvR61thHWbNwOxoBL/n7r/KmPk/ahI4Chy
         2oFMga7goae5ZlmAeiN2t4PP/AxFlTvsMyf/XT4xmtpnw3qFtEo5A6bfRMiW3p2eBihf
         B8XxSRTx4jZ/whJNZF0XC4+b0bQWucFosrq4R2VGtXB228greHY9cfLowxBZtKgY0I8u
         vsIRTuY8uCV84vE5lUBARu/V/d5KV0lcvH3gV1u6XsVzY/Z7f6R8OfodNiVqxTCHTnS3
         QbQqKRt/ykx1ksUW/q9jIaIvVBthdVpl7EdPOAUrGTbYAUkW2HwUnhG4WYAyHQawhBHU
         qVIA==
X-Gm-Message-State: AOJu0YxxlwZ5dzcnHufTOoZgPjexqKc8AJ/k89WRBChv0QsFSD5fTwge
	Y9okDaUj4WAxjFu8UpoVNIN0+8h32IGiKRY+myVUNctQlzCtlmtF9xhMQRCMGvTOSaf6tCSZVvP
	2RCeKbol+TtxKs2ER1l+ZpxQdkrVq8wutl5fVs+eCQh6gOW2LKg21Wcd6NFaT9FnqPnJOig==
X-Gm-Gg: AY/fxX4HGz9aZPoiNd4jzIOOncf9Mn1vz8T+Ak+Jq4Vn66NK8sgtt5ZYEdovMVO8XTJ
	3hSNL/uaBOJ293Dk2YNna00fJ4H6xWfMuBLGnfBDzeHvZpi2RitF775tVW9wqiijdE9eux6rFGj
	mEmFHJdBPCqiB/6/6+3H60hR3TyMixYFKi9ciET6oUdP1YD/lvisT5ijr2qkHZVnwQ0++MEeCTg
	ApDbQ+5yq2nzUdPOIBYTHJEb9vIVS/1zgnBm8BjQyglvXTmW56dnWzcPFttm+PSSwaDS0Vzjz3J
	9GOvXqSDgTQ+CA/PMCDo/CjmDKTNygUjDyV6+Hjf4Dp/+x09VfMaBr2fXAbACinHiCfVWjv8gzS
	p2Ms9qzsW9Wp9/gcYS55OzmBfUq2SDWla87ztDs5a0xipl5duN+/HDsUFpI0yMTHU/HiJhqYxbf
	T+
X-Received: by 2002:a05:7300:f0ce:b0:2b0:4c33:8e41 with SMTP id 5a478bee46e88-2b17d2e398cmr523645eec.20.1767746635989;
        Tue, 06 Jan 2026 16:43:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMCPnwGPhz4Um6DtH+IfffVW8x9Wl02+mlryASKUK8ZLYmKWr12GfGVyDo3rYjyph6+Es55g==
X-Received: by 2002:a05:7300:f0ce:b0:2b0:4c33:8e41 with SMTP id 5a478bee46e88-2b17d2e398cmr523618eec.20.1767746635377;
        Tue, 06 Jan 2026 16:43:55 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078d9b1sm6006944eec.18.2026.01.06.16.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 16:43:55 -0800 (PST)
Message-ID: <9ba229f8-917a-4c58-ab63-fd34d2a66a9f@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 16:43:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4 1/6] wifi: ath11k: Add initialization and
 deinitialization sequence for CFR module
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Qian Zhang <qian.zhang@oss.qualcomm.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
 <20251223092728.1950017-2-qian.zhang@oss.qualcomm.com>
 <19b7303bb18.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <19b7303bb18.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNptWcZl c=1 sm=1 tr=0 ts=695dac4c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Yn4z64EjlknjKxJ9QlgA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: HckIyNLc24ySVe9uFRjMssodkFwm6JIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAwNCBTYWx0ZWRfX6JFnXstF9RtQ
 jNCq+SCwfIn+ppP7pbuJsRdKuBwZpPxQ8xn4D6NiEUVMAQykrrAkQUlC/4WlBApOHf0wrv7sxQh
 MTz6nB/a76B3uU4Sdi7fDcbr/5kgElGHPw3lWOSC23ShLGYYDvPQ/AdZaiZL9m/lLolsQkQYf7I
 e9HsFm3jTJFmVAQ++FpkY2dfQa8ujQuzbbzFalqX1EkqQSVdpTLKyhchXG//gqsTplQgGDJ6Sit
 u4bpQM9aQSAEmSkWdMSUGj3k3PBulWz/eil6b6HiMDPDfvDXXhtcGUm5cp9kb+CLpx5AOdkSc1o
 NdBmTpP3uZvuOhXuXMKluqfklbB49vrbmX2SAxqNs2ylGYShxrVtvy76iZ/9ywfNRvcXobKNxGN
 0rb/o0ZQUxP7KJeuEypXLOb5dCv6jVeLTChg1Ar8Lhl9ghtT/o8VRxrssSd/v9N6tnNiojpdle7
 Ex/JYj10Gwq1lz6uZbg==
X-Proofpoint-GUID: HckIyNLc24ySVe9uFRjMssodkFwm6JIX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070004

On 12/30/2025 10:06 PM, Arend van Spriel wrote:
> Op 23 december 2025 10:27:46 schreef Qian Zhang <qian.zhang@oss.qualcomm.com>:
> 
>> Channel Frequency Response (CFR) module will be initialized only when
>> the following criteria passes:
>> * Enabled CFR support for the hardware through the hardware param
>>   'cfr_support'
>> * WMI service enabled for the CFR support
>>   'WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT'
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c 
>> b/drivers/net/wireless/ath/ath11k/core.c
>> index 812686173ac8..6a6bf6316ac9 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -1,7 +1,6 @@
>> // SPDX-License-Identifier: BSD-3-Clause-Clear
>> /*
>>  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
> 
> Hi Qiang Zhang,
> 
> Some explanation on this would have been nice. Doing this in a separate 
> patch would be even better.

Are you just referring to the copyright change?

The guidance from Qualcomm legal changed in 2025, and that was already
discussed in a few places. The best reference is here:

https://lore.kernel.org/linux-wireless/bce51392-d5f1-40a2-ae22-58df01b993e7@oss.qualcomm.com/

Note the guidance is to change copyright when the file changes, so changing
copyright alone would not be an appropriate change.

/jeff

