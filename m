Return-Path: <linux-wireless+bounces-24731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3F3AEFD10
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7914B7AAACB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41224277C94;
	Tue,  1 Jul 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kUEXXjWR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B1275111
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381376; cv=none; b=obMLM2QA6jPdDL/F6Y6bZ22UV4yeMmDJ1FYstAovORhsYYjnULWFldBroKTdkCIRSnL6uyzVjBeBi6GLN5y1Zscho+vEinXvYVxxqJHwpKu1yBr4T7NUScZnqzxS0T0X/YFGaNg/kwvNPTM+hnDRhMVzk4zpv3vmU5Mshed9mcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381376; c=relaxed/simple;
	bh=e8cofJFzf1imC1xcaAYUYmQi7KXDT/mVIdcDBWP3M8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0oxjy7+Z+fOJk90v6mN0NLKgOa9i7Ii48TbVAbzjms43O9Hvg+SsdMiHIVViSrD98GWZNRPzvOdwaicQnd90iL0AB8vBNkrqpHqxwYIh2NqA2thoNs8NQuOMblOev18FbD6XGZPzrdJwRPLWVZ18IRdTDX62PENHapGuHEsngI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kUEXXjWR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56193RYQ018883
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 14:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rGmB+YfykJEgHd/lXi7FY+QDtnoGkDNaBJlLAV3kCVQ=; b=kUEXXjWRWGbQa9Qr
	r003MGh6bnCm/U9M6kQDeZMtgTiFPgdiyzAxD/uqG0MkynGqevwcoXh6SnT5nM4O
	TJRcpGDH6GCbbUN/R3l4ReqRfSmbecTz3FyiaUCYkA42H+vqZR7IdkCSEdgp2eme
	QSm2NMRKJjpj2S7RL3m10Xrw42NuUrb0E3zW8lbv3bVztyRNgT9ERSexM9AEfQel
	pUgezVzsK5OirGkybTbMz6flVssAKmep+jmdCn48johrd2u26d0aW4GK0Zq7qS4J
	2cZ2Yoojq1GoG8wGU8yZHFk1Pzs19Aeg1hXXnG9qjDIGzP7XxiT2rflPjRGwLWtR
	festrw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxhbtm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 14:49:33 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-234f1acc707so26202065ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 07:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381372; x=1751986172;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGmB+YfykJEgHd/lXi7FY+QDtnoGkDNaBJlLAV3kCVQ=;
        b=tkAnvHcPIF7Q1OB79+6oHowkhnP51Xx7dSXGrU0Nz0YILWh1g1iFFK8bQ9wRZgqWiI
         6Oxe7zBJgvMqigy2KdgbqeONnw1Ou17nZgAHPGRGYUSahQNiYFa+UYtNOMPom/Hyw/TD
         jNVfWcopLovcKkwDBuBEvsOW4ZbgVZ50XAzIacT4ZAWVWohOJVZX2lMOlomeftonFiZN
         7xy+1Q0yZSUQfgldjQeEuJe0sadaN/hvmMGSHV8aC0j7x+nPJ9pSstKt0+JI0N5PzQNH
         TYT92VbPUjp26JK8eCeDyigck5Y0F4A6/wltaVsjh8iLMyJL4b4HcpnoxUgETikfhXat
         GXkw==
X-Forwarded-Encrypted: i=1; AJvYcCVV8MkqgLc7bq35+wSMtWAPZ3U8c+n50ZPXQKhBU/BL2Ck775oT0LsgffbQB1c77Yi4uvY/pWwGb0aA60YAlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBmCr8t5u9C6M7lYIkPV+JMfa+smcT6L4BoqQG43UeX7zcCb/8
	JAh6gyrcWKohVHzN52FWDMBP6CwK89thO+nqmKuFfuiZHMPWRMeOnvSCk+vfDnrFnK/rEVNQdca
	iM6hPB1ViUn+NTnFSiFa+wRAaxRXLcdUVkynaxP5G+zFV3HuFhNOGP+eXSIndBZ87fafjvg37mM
	R+YQ==
X-Gm-Gg: ASbGncvsWBFrMzAbJBUZKsRzyzs11BIsLT3sA5l/tE9Nbhq5Ceh6jO59p/WLHCQMUVS
	45s2hBRyQhzWcOXQoeDOjy5z8wOLutWEheE8Ro32VIgdvS5tZcyl6iZ+CsIGAlTJolGAqXD6YqM
	RkJ3DGJ8k8jySnJm0+QkH8grlZqO0WMsn8RYf5vjm2/ZBuwCV8tGhuRm+3+Cl4Et07AoCsjkNFz
	hAel6wDjUT7cbftnp9gT1YjDgZD4agazagDfRo0rtKrvaJ8T2jgyORvnoTByVkstX5LBgQKQKmd
	mXsLB02FlAT8uGIE8I565AoBjrTEBYT8uPpR038vJ6glzI1otgVaeZVClNozhQdXQKiKwWPFTRf
	F4uTOmoNJknrwZMM=
X-Received: by 2002:a17:903:2ece:b0:236:9dd9:b75d with SMTP id d9443c01a7336-23ac4606753mr303424265ad.40.1751381371761;
        Tue, 01 Jul 2025 07:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp1Ad/hhib51T+HK2hWQlQ5i/UENf7EU+ytKDeILLwtSvTV3KWZcptdDryg6BFVQuicGgoIA==
X-Received: by 2002:a17:903:2ece:b0:236:9dd9:b75d with SMTP id d9443c01a7336-23ac4606753mr303423845ad.40.1751381371312;
        Tue, 01 Jul 2025 07:49:31 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b001csm106117515ad.154.2025.07.01.07.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 07:49:30 -0700 (PDT)
Message-ID: <855ae20a-3675-4cce-b87d-6f25fb69e0a8@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 07:49:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>, John Crispin <john@phrozen.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-3-usama.anjum@collabora.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250630074330.253867-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA5NyBTYWx0ZWRfXzYrp/28BJOE3
 HOFIuWgExG64hH6/M7TR55vkE9XYxpdvCzfc4OkEFGH2nE+VWfng/cEHkm7Q1xmPHdZKtErDDcO
 DTfC+0U2sZt50OY8W9nzyGZi0HaWfUmsJGSitxHxLHwaf8AzItXJFVvcaLL/yA4a+m/wsInOPad
 mfqJv21YhFomSbOAzitnbTVGDpHsRV2bvacWaJA/sVwg1c249fQ8ppG2HEz0oCNERNzMRn+DYkN
 9CAIVZio9o4WzGlj9PIInlpLcWTDvsD3GWG8H5rxQTfiRpVk8XUj8rDWugxgMz5JkZT+iV/qpIk
 x0iluAGqYy13odbeA2ikduJw83myrXZyFFAK/VHEHBolOLXaDuUydV6DXU4XeGVI6VveMKIFwKY
 XtugwUI6NFuU85y3OOggQ/gpHg7hVdxwR2yzMWRHL2+Yte+/M1ygjikZVoY0a+qb277LHszj
X-Proofpoint-GUID: peZEQ2fBK9Lq4h7Uf773pwN_gYD-a3mx
X-Proofpoint-ORIG-GUID: peZEQ2fBK9Lq4h7Uf773pwN_gYD-a3mx
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=6863f57d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QX4gbG5DAAAA:8 a=IWbF6JPFI0dN2yP9E1IA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010097

On 6/30/2025 12:43 AM, Muhammad Usama Anjum wrote:

Subject has incorrect prefix, should be "wifi: ath11k: "

And ideally it should mention HAL SRNG since it is specific to that allocation

> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

not quite the right format since it is missing hw version and bus

> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 4488e4cdc5e9e..bc4930fe6a367 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>  	mutex_unlock(&ab->core_lock);
>  
>  	ath11k_dp_free(ab);
> -	ath11k_hal_srng_deinit(ab);
>  
>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>  
> -	ret = ath11k_hal_srng_init(ab);
> -	if (ret)
> -		return ret;
> -
>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>  
>  	ret = ath11k_core_qmi_firmware_ready(ab);

does this patch have any dependency upon the 1/3 patch?
if not, then it should be sent separately since it should go through the ath
tree instead of through the mhi tree.

/jeff

