Return-Path: <linux-wireless+bounces-27492-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5653EB86B50
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070D5467999
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173F2D9EF8;
	Thu, 18 Sep 2025 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xtkp4Uxp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267172D9EF4
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224114; cv=none; b=nHzskk1Ph8uB0tM3lT/ZRr+CbINYX++4WL3esosE1/pBqo2qLbvv8UfUoPipIoOvL6tdujqRGW+mX88W1bKg1p0aT6cbouKH3h93XIFsI4yrmYkFvrm+58qUF3n9EUabGog9eR/4XFgC7S+7gTy0xh29Oc8fT5zrKKV4dAxtxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224114; c=relaxed/simple;
	bh=UaXvHS26IwDnH8wrFoWwa3f3iOMn9rhhgCGFpZk94oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQIb9ARTqE1lp61xRA81DZfn5eiZS/kXs0wFosC+bs8Z//Mj0lLZ64M8yhiITBuxCgyLmj7zpw3oTjzhFqI3UOePavECIVDab7zMsRKzNJOj2coiiLDe3ll2xW7BDlRSH7oouXc7fWspKODpe84dC7tA/Vn4x1LQVwdhcoqPa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xtkp4Uxp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIgP9U017785
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 19:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lXAg7ojCyxBCDClCOw8hFL48+P4B5I4oGQpykRIfRcs=; b=Xtkp4UxpjlRktOka
	jqZWRYl6lSN6eBIMOk4s/wbGhSvw2lIWoj6cu6WlGj6xj3iGFo2eB3QqIeTDMT/0
	uraaCxyVsyAAgfijWWXphxW2hlWGDySWfEhFPiGXgho/D2NZIa1nF+FB6h0q+3Up
	G2W4FhUNU8oPycgRTNshqheGYYz4phi5FHc8Qv9Wph5QRvqH71EGyUlbE/Q5vQvT
	4I8kk0U05HFSM6tVz0KFXgOnzAeKryj3v6pUTUkjzc3p0bgxMN9259j0QXxW92m3
	+sDsp4FptxgRepegnCZPjdn4a2oRtDiQWkmhE4G8a6/k71rAysZOCuKBghjDkR1l
	jGREzA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4982decdky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 19:35:11 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-75075d3d06eso1674080a34.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 12:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224111; x=1758828911;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXAg7ojCyxBCDClCOw8hFL48+P4B5I4oGQpykRIfRcs=;
        b=R8baTrNF1mU3pFHRi6jHhaGuydvx28VpqZdtn0fCtBdD1/I5MrRZePnQDwa98N6/tS
         YHdp85JE8zJu7WJDa2vtHbZGMyQ8NabK+5tDOJJ5w4dYJ47ZUx3S0NLsVyY6Jl3ToCN9
         D0sxYelvIqvqTzijNGcq/eK+nmrzizp3+Z+ozfxBW2LNJ3mHgW2GrQAayXn0cG7DvDBf
         21u2ZdMRu5/lCzQNLVF4jH2BB14YScUvvvwaWyihEY+9jid9fziDgLBkvg4Jj+Om+WTv
         8LP4KcwJ/cVdwdGDggbPPP/886CuFfImvGr1fo0VUbhvi3LnrPuSXd5hj96XsctKuLBF
         Q66Q==
X-Gm-Message-State: AOJu0YytmsOuFQBk0NWbArBmDaUZMUBs/o2+TBsuea+5Tg9xaAMdlGkm
	iIrkN1uUn5vCdrjkXd8IgZOJh3BRojJB8H94zS5fRbTlzEQO8xfDsKFGDl//3FSayX+GM04JH5M
	7BmIBUroA76t9imo+f9gs8EKkbsjjRMOA90zCvMT9w0rVfOOv8XocVDUPPi2kfWfidOLpzg==
X-Gm-Gg: ASbGncsXXnFJkDDjTOGwkHFspgYH9aoOCFcl6beAr/UmUPfW18abXbfdZqanLQnXWMN
	vPpUZJjs3fEj8AlHuESE53gW0LTA+dg/Sn/NQ9Sx0AAVLIrXIhafBq7AQfVtDLI8WrPaiSA0zY+
	b4JKA0BICFcG6AloAD9FXjshudKnKfrdQkCpl8Hkt6yTC24Msm6ErFtqVbJssxv8aVkUf+5ZaWz
	G4yBefQJZs3s4tYwDSGMx3932mdjKmlHYurfOE9xNnzzvR6SGs18oHFqU4IZ++cinWMce6Bf3cA
	me4jwvc+iqTQiC7gZ+4MfoEA/iHxFw4rA2P5SgS2mFy94cT3GuRPetYVy/WtZlw6Q4V4oIOqtGT
	VcuUklGztS2+pJivv6hSaxMgyVpaU+m4vYXkD
X-Received: by 2002:a05:6830:6619:b0:758:4f2f:239c with SMTP id 46e09a7af769-76f7a3a1a45mr571453a34.30.1758224110938;
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwoxCYY5Mc8kGGNdF5NWEJW8KsmKqjizen55hJBywYZk1+LhtDIBl6+ggbcPD21Fo/hCQlzA==
X-Received: by 2002:a05:6830:6619:b0:758:4f2f:239c with SMTP id 46e09a7af769-76f7a3a1a45mr571435a34.30.1758224110392;
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625db7d1200sm1008387eaf.21.2025.09.18.12.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:35:10 -0700 (PDT)
Message-ID: <1e3e936e-595b-40d6-8404-aaeffdeb3df8@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 12:35:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
To: Matvey Kovalev <matvey.kovalev@ispras.ru>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfO95xRf c=1 sm=1 tr=0 ts=68cc5eef cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8
 a=xjQjg--fAAAA:8 a=KkCtspFpTa3j_I0B6KMA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-GUID: i2q2tOK7Pp7xzHT9Ll9OzbsJiXMOXdBr
X-Proofpoint-ORIG-GUID: i2q2tOK7Pp7xzHT9Ll9OzbsJiXMOXdBr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDE4MiBTYWx0ZWRfXwUh7n1H3OC8J
 Uq4NnbD+6Rui7AHgOnRwzkoJLCd6YCRxxkIGX53loHzMlikHaOkCz/cSgrn3IBiy7nDooWlmCbq
 /1r0+U/u2dras1pVIKmaR1M4qU37bXPQ59exof1t1s0zPJMKXO4FtwGLJl++EjMgYkurRcPRD4A
 aO1uSHZREB1a+J6hpyy9t0SseA/LCgxLvGyw/tk07XnIiLk34ycHZaUbKG1COGTdQVxZEbeHUsl
 8UC5VeE7m51J0bLxwr+2zpcTlW/5tAYOhgsBMsH7SSCTHf8LrvfrnAQ0CLEglFQQfB8Bc9lQKbS
 Mee25+jz3aObGTf4zFpY7JpQkWKH3RPi7/bBOWA9PCbWBSYvM1S1Z09eJgCf4JCUC/favjE6Wvw
 SQUcq9zB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509170182

On 9/17/2025 12:20 PM, Matvey Kovalev wrote:
> If ab->fw.m3_data points to data, then fw pointer remains null.
> Further, if m3_mem is not allocated, then fw is dereferenced to be
> passed to ath11k_err function.
> 
> Replace fw->size by m3_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 7db88b962f06 ("wifi: ath11k: add firmware-2.bin support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matvey Kovalev <matvey.kovalev@ispras.ru>
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 378ac96b861b7..1a42b4abe7168 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -2557,7 +2557,7 @@ static int ath11k_qmi_m3_load(struct ath11k_base *ab)
>  					   GFP_KERNEL);
>  	if (!m3_mem->vaddr) {
>  		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
> -			   fw->size);
> +			   m3_len);
>  		ret = -ENOMEM;
>  		goto out;
>  	}

I'll fix this subject misspelling:
WARNING:TYPO_SPELLING: 'derefence' may be misspelled - perhaps 'dereference'?

/jeff

