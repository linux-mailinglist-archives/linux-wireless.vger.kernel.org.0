Return-Path: <linux-wireless+bounces-28161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A8BF9D03
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 05:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 568DE4EE0F9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 03:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3623221F39;
	Wed, 22 Oct 2025 03:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c9icrxW8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D222264AB
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103154; cv=none; b=cNyutO5lLOJR5kKwYcARe/a5Abo1JU8JNEphBi025NDcPUNcxWcL0I4g4G5SuwdYJkPdKXeVXsPaSKe7dH0w83Mww8eVeIV1GBoSKBdArS5O/WlF01BgMiWS57gXH7EKHQnFI+aL3o9NwkMSEZErjW1mJUke+XXoMOSOks0RTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103154; c=relaxed/simple;
	bh=qawn6Q0wxb2iROcuJMRcEgiyZvXFW2q3ri80dFgcrrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5QSl/G7T3vV2oqHUG9VZJ0jjHbC8yiZ36lljy3LyB03xsGSdJSxYPPV+AI95COg0mljTsgeUqEWHY3QbKO10H46BBKqBPqWkv1A9w0yxmZxVykwUDAoHemykAUPi6x7ldGuX2+7vLViHQxeCkqW2gEXTzo/dDS0YNzzYildOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c9icrxW8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LF3tj6005724
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sUxHszA84SpDbswEiJAWHOm21jvb/4ghMJWmQTldBGI=; b=c9icrxW8IQTU0QKz
	Lx0Wynl6QYT2x7FEgoNRYLlpy0iHwuAKG6uCiPqP1BgJMg42E8kt684X7xr4FdhQ
	pvL8LbWXKQ/b2WoP7bIzlI14AF3Vb5M4csl5enhL36ngQaslwbyPphr6WeW6TYte
	6pijrCvHgGEcfqFm3uQIyfsquMsVe3cVsmHE+jG8PMKsJmbeSdR+lkVKtB7hFpRU
	r1lgPYHQPn93W3PVbYMDgz2AtiEnFsuqHjxny7Pmau7e6mSYKJ9khSk8386ssLD8
	Fc2rRFWTC7hDmlz+zLKGHBcQjkacMRoB1/nMBIpDNLHTgK98huBZ7cZcCdv8cPNw
	enAJ5g==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfjysp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:19:12 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-782063922ceso5756239b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761103151; x=1761707951;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUxHszA84SpDbswEiJAWHOm21jvb/4ghMJWmQTldBGI=;
        b=aq/H52PqBpmAIcVuWIwCulIoQpgpkOdsd8ShmMy8Brzy0gP0VKPPvhMStTCNqu/gVr
         KxzkkuJGzewckTKZSqN6EbawAqazx1uOdoEAyz0x1tXNp+dDfJ7E9X2rY4Fsvl4WGqEB
         aC70s56woh0dsluvYprh83fjMnIBGjp3i5coodDi+Xn8R3XIYrCc6NtKd1X+t7zmHeXj
         IRrgGCCHLMZ0Lmw9glNpXUDEQgy9o8JXbQxeFrOouDMInyTVdbKJQstGHGUoaEYWQ8TI
         Ob+2L+QyvGn2Aza0OBL4X9KdN8uKaLnVfrm4RnwtFVWmucoRmEmLx3FWCFtpvUcguZC1
         s9yw==
X-Gm-Message-State: AOJu0YzTbGKIj6/NYBd9dQkNN9Vym4BbhqibHTXg/oiWGNQIenuvdHDZ
	kA7CNat8oPfbhhQfLwfrAaWr1hegmiLOarxow1xwu722u1LnBO3hL1aJQ0t/7X3leB6+XEooH7X
	YR6eOkjT9Foic22qILqLuuKv+CQk2HknzCP3Yz3VuDoO6uN8ek5obosU0yBjPCqAEDfQRVsouAY
	lLvA==
X-Gm-Gg: ASbGncuf8Mpkf4tNsvUNdwZ+jHhYgyyln+3Xydfcue9Gzx4T+9aOGCbWAMe7Za4Zqfq
	lBieNYkO5310ydEFQx8FONg28z2ZM7ZAlPBuR4j/0Ya6F1LWDsVAuv9R0pjprw9j9dqA2ZtJORB
	m3effEQ3lcaB0LAhmpyMAiR3dt/HtkhtrZJrBJVFhjAf+9w2lt3vxwMoI+DTlLuxre3FmmMtx73
	6EOhKwAmEwHqkAVGxUkoO84WViRvkEOGbRAGKGAzeE//401k3lObZM1C/7d+NZ0u0/YTyUaJCae
	zqaUEK6l+On721oQ19CiOIy3Q6Vc2VFZ1bP+81vk1HL9U0jSrLDUznS5tcfY1xRwb76caRwxdyi
	4AnTYKYLhUhw9PU5HLog2Ym1kg9ive8rlqkQtHyXYr/DIffpF/Q==
X-Received: by 2002:a05:6a00:848:b0:77e:7302:dbe7 with SMTP id d2e1a72fcca58-7a220b2d9f8mr22614385b3a.27.1761103151599;
        Tue, 21 Oct 2025 20:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9YS+Bi6lS4cwpZ6iiWH1l3zhczUehFls6zq/0FXyPGo2MHNYgkuKEiVb/fW+l0KOvqlVeiA==
X-Received: by 2002:a05:6a00:848:b0:77e:7302:dbe7 with SMTP id d2e1a72fcca58-7a220b2d9f8mr22614359b3a.27.1761103151158;
        Tue, 21 Oct 2025 20:19:11 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.122.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15878sm12923986b3a.10.2025.10.21.20.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 20:19:10 -0700 (PDT)
Message-ID: <92307b97-8c8e-3c91-c233-527c96352ed3@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 08:49:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH ath-next 0/2] wifi: ath11k: fix MCS assignment
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nG5Nz38CO-Jsp9WaVtOmH3gTl-DR3Tzz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX4D9UEHAs8q5O
 D0okjTgWgEumMJwOaePDuaypf2Ok2M/ZFUVWZRFHFSfbFpGMl/Xp9tE0wd5wKGc1M7YHa1VPjod
 o9zZn0HjVLhCtHhcxFluRxaBM8MGVRXpC36a9vsNSbzwf4z53YNjiElOSzOxrb098IQgYqT/2d+
 mMDgUZFx0lGdX2Eo/8/qHgBaVYrd1UzEb2HRACkFQmquZPBOaL0sIoEC1AFUn9JDz/z1wNeI4av
 E6SI4X1Ohct8ux4/Zq5Tc5/XP2YpffNkTiSLzg6LGMlSEHCgphd75/+6NBlxgdjfrLq8CquffSY
 iblAUn68tyU6fo/gGidTRytTRyJ5hOIEe/+cZFUD3aukCpC1zzA2TouFLnUhWzvdY5GrH1+Ouyv
 BZiJCbNfV43m92rr4R4R0CQEPdqKWQ==
X-Proofpoint-GUID: nG5Nz38CO-Jsp9WaVtOmH3gTl-DR3Tzz
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f84d30 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=MVWiM3nRykcdLg9H6cDE8w==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gyaHW-YjZbi6TJeFgK4A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027



On 10/17/2025 7:18 AM, Baochen Qiang wrote:
> VHT and HE MCS handling are wrong, fix them.
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Baochen Qiang (2):
>        wifi: ath11k: fix VHT MCS assignment
>        wifi: ath11k: fix peer HE MCS assignment
> 
>   drivers/net/wireless/ath/ath11k/mac.c |  8 ++++----
>   drivers/net/wireless/ath/ath11k/wmi.c | 20 +++++++++++++-------
>   drivers/net/wireless/ath/ath11k/wmi.h |  2 ++
>   3 files changed, 19 insertions(+), 11 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

