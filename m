Return-Path: <linux-wireless+bounces-17868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D156FA1A942
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 18:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FFA3AE5B7
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D9B187553;
	Thu, 23 Jan 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GyBydaRe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277F17085C
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654637; cv=none; b=EUdwIBHFxLnRe+4K5wDP183r2zWpuagKonCaAm6YMY9pmVjZMaxvz4kmMFj8Qv1GCF5dMbDVFPAugFsMNwFQnind0gFYl1hPRpB0Tpys6fhw/b+3LRdLWtrVIGxh9ZCOjs/Weiid8496+oMMY7swUsdqNS2NZw5rUOD1PYbCUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654637; c=relaxed/simple;
	bh=0wPGI8lWNlIJcfMhRRvQdzOsT0mESW60zaNo47lMc6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbY0cHJhoauG0iMVL2w3jIBOc9NYb1tJVvKKuddaDOKgAKzTXkDZTJy8otPQHBVczWYsg+gpHv0amPcKOF32Xy2zW+1FQKiXMG6/BsudSGLrT1yVX0UL0xb1hQQc/XPmy0DWNtpkyZqhh03dOW9LeSYOQ9rJRvScnGudClgDLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GyBydaRe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NHUdKb001562
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g/igeLISpBDQb4F0p7vtfCh9x3La1i5T622uQk0rbUE=; b=GyBydaRe71b6TAB6
	b7tEIxn5KkjARv+DP8d0GKNA5ePwT95K4sIEVLtqmOPf3clojUFIEsMp/A6H3S1L
	SZC6to8iMVkLg9N6p3cfIV8rkm/SKizj3YPQWJxLUclSSHG9bhL7J+phlEdnTTmE
	dlH+siDfJP1lz+rsjlqGRvwYnmRndQ65QSqmbpim6V9ji+jlwr+BW0yGColdoEX9
	ng/E/r2ES6uLSZCOOv+s6rRcaVal4Rt8QT31LFZpYQrNi/OOFS04Z3DO5bOfeOa6
	QL9g8htpC4V5WWWi9BujIjZpKV3AcDqv6JT7Y/1c3rQ16fYLXlHWI5hM0n54a33d
	64p6Gg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bt7x81ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:50:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso2523889a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 09:50:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654632; x=1738259432;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/igeLISpBDQb4F0p7vtfCh9x3La1i5T622uQk0rbUE=;
        b=DuBUkSPVW2Djjh6uY3Ba02bdbQSIPLyQx1TWOjh2uX7z/paHNTAPgCZoWnsqx3orLO
         +DTnY+zt3r5eBSw+Q+MFesEHgE+6OIvK2tDQRq/2kiLGWD2lx9iAvaphIdMQS8+KYSy/
         +yTwDC3TqZEJqD1Biwf2S8MipICqU1ApVyqBRGMFk/+S+RvxueI3ZwZUmoyiEnz3ucnn
         PcwZpK99eebEBokFPjST4Thla+96le8gig7hH2JcFpygK3/5jK4F1YW0T5eGM4QRPvp0
         t6nqs2dfIgj6GmHYTuYTQbxJiEoWc+TNWLUqZUHzQqHl/cUh36ujCJ+SP+I8FVu0Fll0
         ad5Q==
X-Gm-Message-State: AOJu0Ywma7fIjO4mEr9hh1bJUqXc8o1wUFpDClVwFAAp+h5vASXdnh72
	RDLj1lIAKvfdVlm5euKo5yDCjfapq7n95wFJgYY2VMZ/7Z7T9TZKDTn3O+nUsPy4m7kPCnxTexc
	gLJjirjYyVeNGO4fH3E6rvvDj+s6is+NWaG/J4EhCE+Cglgv+WCe40BZMPp+QfB8iUA==
X-Gm-Gg: ASbGncvkndyG6h7jxv1rHQK6dAuBMioKzf7jeDEhLqsdLWIyFtNej7G6XNi40luDcbx
	y+yNWjiCblayw2c5BfqWvbk391InnRBaX6gu5X86JBdElsCOrrQS4+8Zfzez9hi/v4aQO/ZFyiH
	Dro4evYiFXzRadZyXYkDLVuFCnifgLYFLUcvsTDLg8Fe8b7xh1fX7snJN+XF6zTYBZXIUGR+rHt
	/cgNLaup9Ze1JjYPx6ozbAVMg1kJCwBAge6818Oj9zAsqLjbWVFj4MQlwaODbdHeRU9r5DBemWl
	gnWCvxEeC+3gXBdUIyGYRNovcVdQZQSwVKYpPgKUNmgvYBvWu0jSzvO4zxGZot4=
X-Received: by 2002:a17:90b:1348:b0:2ef:2980:4411 with SMTP id 98e67ed59e1d1-2f7ff2f065bmr358729a91.9.1737654632216;
        Thu, 23 Jan 2025 09:50:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAtq08VwqGBJlI3fCc7ZACmqGbCst4C9o8cd6GJLIYjhGxqHzv9xlw9sqKsjcOfoIkjRCNQw==
X-Received: by 2002:a17:90b:1348:b0:2ef:2980:4411 with SMTP id 98e67ed59e1d1-2f7ff2f065bmr358703a91.9.1737654631844;
        Thu, 23 Jan 2025 09:50:31 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a7e039sm4665568a91.17.2025.01.23.09.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 09:50:31 -0800 (PST)
Message-ID: <4629864f-010f-4524-8861-1381f4b18614@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 09:50:30 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] wifi: ath12k: add MLO CSA support
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20241223-ath12k_mlo_csa-v1-0-78b6d7515568@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241223-ath12k_mlo_csa-v1-0-78b6d7515568@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ztfrN4jnb0H33HAiKYvSOMFRWysi_AQ_
X-Proofpoint-GUID: ztfrN4jnb0H33HAiKYvSOMFRWysi_AQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501230130

On 12/23/2024 8:21 AM, Aditya Kumar Singh wrote:
> Patch 1 and 2 are pre-req fixes (applies to non-MLO as well)
> 
> Patch 3 basically uses arvif->link_id to enable MLO for CSA while adding
> support to update counters throughout the CSA time.
> 
> Patch 4 fixes a potential problem seen when medium is busy. Again this
> applies to both MLO and non-MLO. But this is exposed only when Patch 3 is
> there.
> 
> ---
> Aditya Kumar Singh (4):
>       wifi: ath12k: update beacon template function to use arvif structure
>       wifi: ath12k: fix handling of CSA offsets in beacon template command
>       wifi: ath12k: update the latest CSA counter
>       wifi: ath12k: prevent CSA counter to reach 0 and hit WARN_ON_ONCE
> 
>  drivers/net/wireless/ath/ath12k/core.h |  2 ++
>  drivers/net/wireless/ath/ath12k/mac.c  |  7 ++--
>  drivers/net/wireless/ath/ath12k/mac.h  |  1 +
>  drivers/net/wireless/ath/ath12k/wmi.c  | 61 +++++++++++++++++++++++++++-------
>  drivers/net/wireless/ath/ath12k/wmi.h  |  2 +-
>  5 files changed, 56 insertions(+), 17 deletions(-)
> ---
> base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
> change-id: 20241217-ath12k_mlo_csa-35bd512a05ae

fails to apply to current ath/main

* Applying 20241223_quic_adisi_wifi_ath12k_add_mlo_csa_support.mbx 
Applying: wifi: ath12k: update beacon template function to use arvif structure
Applying: wifi: ath12k: fix handling of CSA offsets in beacon template command
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/mac.h
M       drivers/net/wireless/ath/ath12k/wmi.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
Auto-merging drivers/net/wireless/ath/ath12k/mac.h
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.h
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.h'
error: Failed to merge in the changes.
Patch failed at 0002 wifi: ath12k: fix handling of CSA offsets in beacon template command


