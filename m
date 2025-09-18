Return-Path: <linux-wireless+bounces-27467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D75FB83415
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 09:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E987A9033
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 07:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3172586E8;
	Thu, 18 Sep 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CzwXGlfP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB01E87B
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179155; cv=none; b=lwzKUiSAzeZync69pHVcXy6kFXFZZiuBqzmHcLO041RwMUUsTu4yHdIHI/yeheK5ZDjWu5NoZ3EbaKU+jS1mAe79cOCkAAoGQS3yNt5Z+9DqYmlY05bczxb4WxbP5aE6moiZL3Ukzz28oHfqpnK5e5KPfEMW18NRc6yDNZqs7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179155; c=relaxed/simple;
	bh=kHO8ThBf+XrP06ta5enGZu9Czqp7x1xx4kmAtv3FwkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xpxj9seNGjKx+PEZjcRr65Nuzq7lll719aSoQYBHuENdTNMeQBf1ytAaKaL/mdj4edXUKS66kbYzPzIpVarNTrIwnLuwuvqlv4iYaH3Xe81qTVKf0l9S1gFDYRf2maMWgbxsXmGAN48Rr6422W8HgEh86dbuHsaXKRL0Gp4hjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CzwXGlfP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I4PXmp029750
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Y9SMRbrA8EfTA12V370ZjzmDEQEjVLQldlUuJJBEUk=; b=CzwXGlfPIZZ8Rm9v
	ih1v27tHolXYHI+S6bcDnGZrFBIabu+6GzYStzGhtFffoTTYVJMiWSc1x5PhnGlI
	V+mwX8F/oRysHinaf6sY+esqb1XW+lHqRDchiaJtubCm1Xx3EL1uQpYnGzxNWlov
	YiQu3tzSPJ6HobXwzYay6FxJ99/8/6fOGHMOrvisvDpAysCPO/rU8rhSzuIVLWaK
	4nV73y7n7A2dlaL5Uutsvqh+PFU/tGVYv0ikHAOC5nL+jYyCxE4ZUCGHcNlxe3Xb
	d+ck9o66yUc6kz3McIGX2sY4GYdENz2+dYmD5gLlhk3h8Gx9KbICcxgGcCO8Amt1
	6C3Axg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0w8v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 07:05:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b54c46337c9so892723a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 00:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758179152; x=1758783952;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y9SMRbrA8EfTA12V370ZjzmDEQEjVLQldlUuJJBEUk=;
        b=e68gCDhnGFIba822eV8dcbOnKzBcPTivl6csX5nZF7zgvo0260Hdp9YS6VPm5yvAKE
         EGZ7wVEHWL7tht7K7c8TXmlx8sP6xf+2+RHdBuQxsmKc536GV6pAIkEVBKc5qcoy/txq
         Du2KorGIGwaOvqm/hmJXFVfpj+XFxA6zWwgCebW8S9y6BNbFofA1XWHbqywJyAZEbNEi
         dSJBb0zlZwk3C7cVYi8MFAJ1IMl1KPP9HOF0AuEPp9KixmSdLi3tXWXcnz//mEOhmMID
         T/LQLe27URL1UJPqJ3I2Un6zqJuCMeK4fCK7/aKIaP0QN4r69QwoDtunE/wkp33+Jf9R
         VTHw==
X-Gm-Message-State: AOJu0YxzrTu/GAxx32JO4GeA5q1FLDgbrUNeIXauRwMNZv7cQPmCVt2X
	cFyNPNKvSvK/Nht95+35VuwtG1lwptqgY5eHQzQr90UKSPW5R+D4VMKVklh7TJA8unjrl+nHc9Y
	oP0EP3G+kbYKkzNhdceWjfIumv8KaZeb7oj9pKHpLYIH0+MTs8YU2sG+B8GXsS91yGxq93w==
X-Gm-Gg: ASbGnctimWj5vqdoj55rBFfbO/lZmpnRpP8jrBsZPn2scwsjP16HpDVjscRFGfQgdE4
	Sq9Rfu6ifhr4hXnbP5Un1CUfWWbdHyQ60VRHzuMT1xRO/meDCfpgVEQnM32HP3ycb0uZ6t718aq
	Zo8qPjUCbQ6W1uswj0/C6vvMnx9UyCjSg0VLgkZOmuiSjmQy8oqaOj1/o6JwTB0wcZKLn2okHK0
	G94F7YmlUKPuVTsKsx+prJdhFa7N0+MGE8SUl/VU3IyvZuco11GLjF9wIS5F524acsT8ksBLWbc
	swqhIqXfoMOat1HOiFovZQ7vkYbYSxj1fzOwRYaIuDfTH+fRc69fan3FzqomjA99XbICex35Tti
	hZG6HGw12H45xeh8uj5mjiAvdZJfR+VntpHN7
X-Received: by 2002:a17:903:41ce:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-26813ef9e7dmr70240745ad.58.1758179152490;
        Thu, 18 Sep 2025 00:05:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7dkYXHMRO6tV4bI3uZ2zCxGvRmSsCJrG/bAY29MaksfKUnV6mW/CITxSJyjLu2qyBOVYXhQ==
X-Received: by 2002:a17:903:41ce:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-26813ef9e7dmr70240425ad.58.1758179152014;
        Thu, 18 Sep 2025 00:05:52 -0700 (PDT)
Received: from [10.133.33.30] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26989844036sm11100095ad.31.2025.09.18.00.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 00:05:51 -0700 (PDT)
Message-ID: <88ce11d8-52c9-4170-84c0-d364367646a9@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 15:05:47 +0800
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
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g7lsixgWvuBUHU483rpY3Vb5jZqvgsYs
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cbaf51 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8
 a=xjQjg--fAAAA:8 a=EUspDBNiAAAA:8 a=CFS23snBG6XJB5ISPFYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-GUID: g7lsixgWvuBUHU483rpY3Vb5jZqvgsYs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXwQaO4AXZ8zxV
 ZxPhVvVQXFJNBO79wAc8nP+by4fdp5hVTxtyORMZgy5ZDyVTC3HeM88lqxsGEPHqtNCfkv0g5w1
 EXwf/40wq8BKshMfoZI7LUGi4YrV9+Vw9RhMSHPhYoc8Cxzk2BnJKEpWJhyMyf+Mph5CYJVUin4
 s8V6Ex+ipVvc5pxg9GoLfzTw6bVt7KZbjvgxQHCbc+EZuqbpkV7IRMrG5uVOpSiCy1DeF4nz8Co
 uGfC+L0D5A4qeeCF7v7CVWvaGl0rfGH5FBpG9sTuhy7PuYOgMgzWj3XPi6LVqc4PFS0H99ImlA5
 F3qcsM6GnfLBmQhsBwqs/kxDZqTMEUUTABbeGGj+All2bcj0MKrgLxNoeM0dopcm/e4N14hZzo5
 jY1tprPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202



On 9/18/2025 3:20 AM, Matvey Kovalev wrote:
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

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

