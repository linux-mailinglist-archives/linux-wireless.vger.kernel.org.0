Return-Path: <linux-wireless+bounces-29917-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9248DCCE900
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 06:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0497430573AA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 05:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9330A275AF5;
	Fri, 19 Dec 2025 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IOb6IjT2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bP8mTEDX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C092D12EC
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122945; cv=none; b=r1r7mwhRZst5topZlf1XNOiK8rOhAMSpQnqTGTYVrdrCS2/oogR+5rgWRF6CfdlyRDtIIPP8Hk3rJQ+PfZ72joZ8kF4jJ6rd+qUR5M9pPzbRj0uI/6+v1ayCULnFyOpoO6o59GfX5y8O2pzmCq1kgP23jHlGw+YsL7A4iOt4JYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122945; c=relaxed/simple;
	bh=gzvBQaQE04aWx7Tv8hc+MsWpJrIp26psxmc1jwDn7E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAd1ZXWOpyr5EEiMWkalgYYTb4EL1TB7V6R7Ez6dRNE24EhwjFPC/lg4C1PByfUnLzDb6PzFsqCsEvLbIZztlTxtRj3J5Qz6OmejD96//5yiFHN8pv/J3aWje3ui8HljKBULqIstOVMr4HZDZFmlEulgtxrYO3Vo2flrAbSGnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IOb6IjT2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bP8mTEDX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ4c8ne3559014
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 05:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V5m5tAGlkGiYi81yuxiUUxECa/gsyO0V5obb+kA+4XI=; b=IOb6IjT2KCeaFFPC
	qbitY9mejvNfAxdKwcHxSJbGLgBr8OIIyVT11AEGgsmrICPi9htrwSU+Bf85Dc8f
	03Sbs23Bx0da+FJIYI0mA/Me5t7IHYnNwMC5Rf0SOnKnNmHAUCwEdfYrAAXguM76
	zuZHnrzzBaSrhrHbpmFbmr/fdiM/g5OI4sobhw5mZ/RPVtxyQpgr6uk4EtUyALuD
	cqa1hChjSuVRnGpciftph0et4RaS0Bw76toj58e/2OIFpb/YUD+UHkMZGSL3VLlU
	M3EZq0WIHG8xcpBWzXTz4zp84djn7TKy5FiJU/vSsRw/0BJcSHqMB5uw3S+bsXk6
	hBVKvw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2c9c9w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 05:42:22 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1532856a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 21:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766122941; x=1766727741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5m5tAGlkGiYi81yuxiUUxECa/gsyO0V5obb+kA+4XI=;
        b=bP8mTEDXgyNIGwM4I/cmnI0speWD7RwG2Pp/ktvFFEtLjcNKmvhDVPYjWgSc1oZi2b
         6TDtHND182r2D5PbKO6ti+svPlakAl0BKZZVFT8fLYEVrHRNVirJRbegaJtbgtUCd7dx
         iEeK08HWLimxzJS8BGgHHHKoUC0XyyWxwsjnKU4DRjHDcYzrKStJtMzbXHeF3MxfNXYo
         rb73/XrS7aC2w8mAPBJNd1/nQgRdHfOXgG/Zt75xvTYrWJN3PmGJu1BHy+NmlqGRRibJ
         UmmUmPZaqLwysQRbv1MNAvLFybrg0765ZkImnC4DtpEwaIDlww38iNq42qFbr18e4N1f
         ZZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122941; x=1766727741;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5m5tAGlkGiYi81yuxiUUxECa/gsyO0V5obb+kA+4XI=;
        b=whrfoVYu0ALcovgPzIZN30sDm9k3g8Mcfg58Su19yOpej5TRbS6krSf5EIMnoB0XXE
         7zXymklElcvAbbGzFNyLZt9HqVF0QEFchVATUuyC1fMnc8IJUjaN0iMoHK8EKRy8dOK5
         mlLzNorQRZOYRZZfi9rcv18vefX+cLc8DhYJm212m2HFxKJthHEhn/npTQiZIEOkDqKh
         NQkzmB3hUd2mKYMD6WmJ6GysvGdaTgme6zIwM2n+xKRq6/3JTxpPn3tLQuqLibsv9N7J
         HCnasKawio4XxyaXbl56MYjnF59dZvzU1u9chzi/Uh0Rrw9sx8MpeBHMtVR/G9x3n+J/
         wqOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVKscE8keDAHnmRtTsUGGPrfh/VZHNt4+QAxO93CoALEYwZxuc5W6wgnNgsoI/ppslGsve+MEzFYXpfUMhpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDGFn0pYRRC4leuZQ52aF3SVR2+nvh9/gDRXhnKecnF/WwO8+
	rQbEugfzAutq7UnRqtuMqOLOfTqh8TyJN9ESBcK9kz6aLXTFoyxTQpDefs8RxTQUJxVDyP5JRFs
	beWUv80RXknTlfmsPEFr+Gn5RdSAKSLAYgMBv2/TLb2DME06JevJlYfEZrdmkOQjwiJmGtw==
X-Gm-Gg: AY/fxX53GUracwkT30pztIGG3ga6w+LKu8gJKm9sXI5J/eMOLhFhyktFG2kehyRI2ZU
	UzYMxj/0U0SyAMb69s+3YP+4xR0540Y7zNBtoB0Q2znWwbwZrm3BlH1yjq3Reetl3DrEjhRqQLN
	lti4kmvk3QttI8z3CQORXqD7dALB8m8tadtsdJNZKkV1CXhfd94UDKF4T18UaISl/CP+bPGhaay
	cgfXpemw2LAGJouK4XYRsRhUOXA7Fv+mItF0gNxe9DHJQixkoDct1tmp65MwKIBGXOzhhR4tZt8
	e5Jd8tNMDFHfOsremXawX3NZg3UuWFG45Sr9LEmIxg03YKZfM+Aixa6aDrNfPVdhgIZVqDldSlD
	DyfGDwSxRrKDyqjsWpG+hPpzPCl+9GtF/rXQ0nYIoWQLtpj7OBQH4sMO/+7tVOjgZsvUK
X-Received: by 2002:a05:7022:f693:b0:11b:803c:2cf5 with SMTP id a92af1059eb24-121722eb259mr2094565c88.33.1766122941352;
        Thu, 18 Dec 2025 21:42:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhk+4V4h85Zxgq/94CKGljiu1MRE42gFAPuVqCapM99qVbrJgOcmpXpxMamCypOIwWFCgFNw==
X-Received: by 2002:a05:7022:f693:b0:11b:803c:2cf5 with SMTP id a92af1059eb24-121722eb259mr2094530c88.33.1766122940751;
        Thu, 18 Dec 2025 21:42:20 -0800 (PST)
Received: from [10.110.90.237] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de25dsm3836422c88.7.2025.12.18.21.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 21:42:20 -0800 (PST)
Message-ID: <f113b35e-b84f-40b6-89a7-284018e93853@oss.qualcomm.com>
Date: Fri, 19 Dec 2025 13:42:15 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] wifi: ath12k: clean up on error in ath12k_dp_setup()
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Ripan Deuri
 <quic_rdeuri@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aUOw1J0TU4VgeXj6@stanley.mountain>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aUOw1J0TU4VgeXj6@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cpSWUl4i c=1 sm=1 tr=0 ts=6944e5be cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=S47APn7KmZlrf8u2960A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDA0NSBTYWx0ZWRfX6vOJuAsjvcJM
 b+zlwKLaBm0sdfIV+/84ONFgJUkWkWG8f2Do9X+SUgW1U+3NHnoCGXEmUbywmXcBth3MaQGEtQv
 Q4v7jn+tz8GTf33SQiEZxbtZq967kUjhCOFiBn0wL5PAKfYU8D1wOi3pyKenZow39TgBNxLRDad
 JzYZ9j33cj8scnnjUJlszkrzrRxAb7pw7WxS0CrN+w0V3dIG6OHf6g22nOccM5FJbTmv44MMjiY
 Pg6MtWrH8Z+yeVxH/Kj9y2FXODmNqgUCX+4oh5Hue0uwflne6kAI91SiFon1Nr3G6o0xbp/UrZX
 eMxB8kBQT1Qm7uCAjsKnByb2wwv1YG1vk2wB9xlQEFob1XrisQAlzluN/c5paz4xMmb3/oCZtWb
 Epz93pRokJzyEkGX5wGpuyafrbMOYbhmNOW3AGJKcHJa5ItKL8402bikiQ3ghZpYYTDNt8i/53q
 BP93vT3hO2FATO7/hew==
X-Proofpoint-GUID: dgOLj85oCLVMX53wkbs4i1wPe4Jj8D62
X-Proofpoint-ORIG-GUID: dgOLj85oCLVMX53wkbs4i1wPe4Jj8D62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190045



On 12/18/2025 3:44 PM, Dan Carpenter wrote:
> Destroy the rhash_tbl before returning the error code.

Would be better if the actual problem can be described first.

> 
> Fixes: a88cf5f71adf ("wifi: ath12k: Add hash table for ath12k_dp_link_peer")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/wireless/ath/ath12k/dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index 9f05eea6695a..ab54c8a84d3e 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -1513,7 +1513,7 @@ static int ath12k_dp_setup(struct ath12k_base *ab)
>  					HAL_WBM_IDLE_LINK, srng, n_link_desc);
>  	if (ret) {
>  		ath12k_warn(ab, "failed to setup link desc: %d\n", ret);
> -		return ret;
> +		goto rhash_destroy;
>  	}
>  
>  	ret = ath12k_dp_cc_init(ab);
However since this is trivial ...

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


