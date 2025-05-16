Return-Path: <linux-wireless+bounces-23052-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD4FAB9505
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 05:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0414E8153
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 03:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1C41FF1B4;
	Fri, 16 May 2025 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X96b3wRB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD61FBC94
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747367529; cv=none; b=NjmJgnursJr+CZZa/jh33cy4MTGi/NELesG6QwPjundWY0tNpmUzTfMU+yqOcuVw3NjO3d0WC8N2VOzJ0jVEoZJkhFp09Oqd4ih+O3tcaKWuJLy0ekW77Kpuv0X2T3e7ttdi35SFMFmx2PssMl2x28Y90JXR3OKAibikrCiH0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747367529; c=relaxed/simple;
	bh=xSiSAXJdHwj34rgiqd0/Lhc/cc3/kbKTmkO0aOHg8F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpPmtt8Lramwz0zxlUVO0S6hJoY2Mnwk9KjcUnc5jO9AHHRT0oOEDjq9P6PyPKf1wCu9wYcfEQO+ZSXU4wqHSDRWW//tvMPHHsupjYZ0SyH24o2YZei6s3ZPYMVK7ks5yzlVbaeUQTnkg7UKQhaYs/aaGbLLcqvmClTUsiWeyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X96b3wRB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFLDr002029
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 03:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e9CUjuI5toNO/CwE9P7BAHwcm5bf++miBkuAeuRBtL4=; b=X96b3wRBcf0WRTJg
	dsLx3ec0XQPLO88LulB7qoNoi8DeuWQBCTHJHZJ13rs6zhDTRaQJ2PsiyounkY4x
	0K7xpeFdChjthCISlBcPkf9SnMNKGNku3ObH44DBlj4TL3GMRxdYVHDtI9dKjmww
	kCaw9J95OdEVvVwk7U9gn0qwjm2yKtyFfNyYt24ofXSwAu2frmq3krokMSA8fdYR
	V92yRjmoRrsY3t23WTqFdYmG0tltUzn/sVbh5XljZU8PxwWkIAg7KqWoqsY4cXl8
	L1Xl9F7+QEpQdOGACSUGmk97FxvIeKOyrWztxYE303AhyfFPwMzAoJUeZy/kHFVy
	ZIHQdg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcrgb5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 03:51:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742951722b3so1388579b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 20:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747367518; x=1747972318;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9CUjuI5toNO/CwE9P7BAHwcm5bf++miBkuAeuRBtL4=;
        b=khLeRFUWCigIqxUy+Bz18q6BK9RqyX5S+3a9WtOWKo0gvb9RXKx5b1FLIrP2D9PTaU
         xRglKKZ3/6Ie5XyK/fuvgrcMV2qKYf4+WqeTGXEOd6wigdlZCOax5C7IKJampOowd/Ky
         lxmsJ5pt84RHG/a1vVNC1knQGs1MX47tXjPcSgJu8q+wHIu/Aw0+8B5lDFRwjYtP7JwN
         LgHruA2zAWTcLa2tL1tOznrHZq417Icn1k+Dh/UOd1BntVd3I94lxg9B6irZqhP5dAYW
         ISgp6b0FPHGT6cPMBK4mKESekybrGm5ZgE0gpXv/BD9U44g1XOlVFSHngYtKi1OH1L3R
         50ug==
X-Forwarded-Encrypted: i=1; AJvYcCVNUJF4NoAYktPkLaknGrDBgCxBzeMtXcwJ5LH89GriijQdjuDHaL2R/wRsirggqZvBiZQSfYYtvHpmd/ef3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUbjS0zGq6TJ806RxL/JHL0CooE56OaEOfeY3P0rqmmZ1svs6
	X0Gf/PuZ2OyaUMKMAkpV98oLKCrqAHS+MIUh0flmStegNGXMf7Gk+HRKQ++6KMCVQtxquLu3GDo
	UavN9xCDYzGVWxeefZNQpS9++KjXDZeU+V2mJHogpVYMoaETMPOrsVcs+0jNv4ohgG2JOHw==
X-Gm-Gg: ASbGncsOaZyPtkz4ta1uA7RMTSV349kqESwLSKK7nY1sA2sl+G/D5he+VmZ++awXV2q
	SjQDpjaezbTic29sA2CUW9mw0JcH2HILAP1ZyxBmEbmFDY4kuxXn3paIdhVw7D84koWal0De4/4
	GkIjQUEloUaJnOup0GJ6b6LHYxczbh6XciwzwjAfwrzkTe6POu5tMeDq83HCM/xnpguWNbwsDtW
	hMd7pmH34rZmw5/BfIvod3rqTtPRl2d3XmcSsOV4gJOzPzvLkekI3DDPqf4iaqii1cXq/dvn30S
	D1sbUDus9TwUe4bOUfamJEyGRcdkEtoqt+eCWUee5hG2iHtUGnR2LA==
X-Received: by 2002:a05:6a00:6f27:b0:740:6630:633f with SMTP id d2e1a72fcca58-742accc555bmr1441407b3a.8.1747367518472;
        Thu, 15 May 2025 20:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuzA/K9vXNzdBZ+rdc/yclBLrXdzfPd516G/U+MHxZQNQqIOscd16rlxENvqnbCHXktqkUrA==
X-Received: by 2002:a05:6a00:6f27:b0:740:6630:633f with SMTP id d2e1a72fcca58-742accc555bmr1441383b3a.8.1747367518056;
        Thu, 15 May 2025 20:51:58 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a3167sm580089b3a.166.2025.05.15.20.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 20:51:57 -0700 (PDT)
Message-ID: <c6ecda76-bfd1-1aa1-ca2b-33a9eea418fa@oss.qualcomm.com>
Date: Fri, 16 May 2025 09:21:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] wifi: ath11k: clean-up during wrong ath11k_crypto_mode
Content-Language: en-US
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, jjohnson@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250515222520.4922-1-rodrigo.gobbi.7@gmail.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250515222520.4922-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TcsyFAVvpNThL_mmIMMCWbJZm2uDj6bx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDAzNCBTYWx0ZWRfX4QM+X+pAkUaR
 fi31NQdvFmx+nUaQfOVl6+SPiXJsZfuPo+iyvMCUpck/8bojx7sGw7Qi9gaU51bUncn0rcjiQZ8
 4O4v+b//9FVJiKTsbyUnqzX78r1TmOJm0sTbQ2tujUS6/p8V9xXHLhIg3ExsFEArOoZJQYYa/dx
 2nTlqFSZBcRzpRpyYHl9i+5NqOrgw5VVM3FtheTIQEM2SZ/w2ij7LYDlrHCcxVx6RDuppvRRa5F
 KhSM43SkXT8kpF0kEKtBbK0KuxzJHriIkRnqhEeMIXQUaPsi+KtgSO2pDKmxBIy1gkkgj39VNc/
 rKjTY9Rr79QMSvILYtK84oo4gvb4M+woBBQeDa5Fy99WlOU9l0krw4JeKfLBff0b9lfrQjmdGL9
 hWrLSDvxEvKUEhd6TBDbOvnVJfLwMPz+Bq9xLMgtTCdkD4GVpZUC+bxCTlGMZaYqz4amxDGB
X-Authority-Analysis: v=2.4 cv=K7UiHzWI c=1 sm=1 tr=0 ts=6826b65f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=l0rt95YCMWEmbhB2sSAA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: TcsyFAVvpNThL_mmIMMCWbJZm2uDj6bx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_01,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160034



On 5/16/2025 3:52 AM, Rodrigo Gobbi wrote:
> if ath11k_crypto_mode is invalid (not ATH11K_CRYPT_MODE_SW/ATH11K_CRYPT_MODE_HW),
> ath11k_core_qmi_firmware_ready() will not undo some actions that was previously
> started/configured. It's reasonable to undo things during this condition, fixing
> the following smatch warning:
> 
> drivers/net/wireless/ath/ath11k/core.c:2166 ath11k_core_qmi_firmware_ready()
> warn: missing unwind goto?
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Changelog:
> v2: add smatch warn at commit msg
> v1: https://lore.kernel.org/linux-wireless/20250515004258.87234-1-rodrigo.gobbi.7@gmail.com/
> ---
>   drivers/net/wireless/ath/ath11k/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Forgot to mention, pls use branch tag (ath-next) in the patch title for automation to 
pickup this patch.

