Return-Path: <linux-wireless+bounces-19723-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF25A4CB78
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 19:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D7918970EB
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130422DFB5;
	Mon,  3 Mar 2025 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WreSL/YT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB11E285A
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028286; cv=none; b=TTMmEqLp1KIYYUJV2YlYahv8kVmKOaTklreDZIUZeZ6QJ9pNmXmn0PRiAqyL726HKYBxyjI7BCgvuEi1j9nU5r5YeF+4XySDKqheGCEkHRRMFqf7UH49xPR/WX4R53BnPY/OZSkJzFwGcDx8ayBmBo06bgQ8gZP+9kKfJH4oqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028286; c=relaxed/simple;
	bh=F7/J1lYM6kjT4iz9iYchuF8pBS6zBMP3fO7RXSp1dXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TMURTvtyrQu2aNMUTY8WASWOxwQoQqcNYqukWxWlEvBcUESIDw7GY+VHouEmqx1wIoPuCKzROG+5vwG1kOG0+s0cwzDsalmE8s9lNbBwZke7WpUqPknRXqQxb+fS1uL9rta5OIZUn7GO/+ZuUGegEoXpJxJDh6wPlFHZAUMcbcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WreSL/YT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523BF1pd025951
	for <linux-wireless@vger.kernel.org>; Mon, 3 Mar 2025 18:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YsKHwPyakFDRtES+T+7/Q0gwDO/LMXT6KYV55aqeyaw=; b=WreSL/YTco6Yth3N
	1PaARfUGv3SRN0b5i+PFGVu1qFL2ld4AUMDbfscADxapdjw3M8Lw6qx7S+zLbxhf
	64QbsI3vkyaRE3vRpX+ovRjLM5PhSwR2WSQbJb9TpMj2ELpGGUOiiYywllQDGrLb
	bmBYQ/RtqLOVyWoEQzuOHGNJAMhUOd+TuWfTN5lJDOWA83FoifwWhOXlVvtempTQ
	qOMmdzN8jzpOmHRgUp/ZjkF6Xp66xGNowMdqUYtwWoKItpFkPHjRs5Y3Ygxmc+/A
	yfn5xJXDxfAh1lcuVaTYyIVJoZAjgMGeUpxzCdaQ4VsipzwWBAYUwJ98/1BLtIm5
	36eG7Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t6k5nr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 18:58:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22349ce68a9so7619815ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 10:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028283; x=1741633083;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsKHwPyakFDRtES+T+7/Q0gwDO/LMXT6KYV55aqeyaw=;
        b=oyzeump8t2/wuD1DNjGns4xx1Jc0Ih9TbjEL9j+4+VY/SxlX9c/MlHqnxEu3ZUk5uk
         zA4bw+EBZtjwlR5A967miabm7Ux4lVurpmPif/hEEo4EFf20+vsDEYIokPn1N9EWXfil
         qrXq70P2030QPy2ZpOmAGw5CNa3w5W8d1ZqAiHYkGUPrQ7phR2NXvd1TVx96XR43NHfA
         wAGwEyz6aQxNFD3q9fno5zgBsEjAHU/vQ+9ZPoONXRzOs80Z9T2zrI+DLjGr29I3G+WY
         UtD6HsaiN6S4BcD5tzbE+xlpZ78hj49McbBWpNKuC+OYAvBCbw5JI/aX2+DxVZxvq1/S
         MckA==
X-Gm-Message-State: AOJu0YwbMBJ3iiG0xqRlB18nWxabIqbFsv44o79kwgCTZq1BpPfGW+Wa
	F+uFOsUw8d24b1r4YN9Lt+TwvPRNmOOK1VPgyA4BNPGsqlfIh70vcrnBhnyb76x0JV1gh47KpBl
	0pRSfBeG9f8GalTYQtiba37zcU3c9Y6zFjA74yP8tMQiGPKZIT7yCDhxo52olXYzaYA==
X-Gm-Gg: ASbGnct5wqDcdQ/hMaLCUW3Jby9bmXqpkKQxbazPE0nNWlnsRWUMfvEqcgC+qp4gOa1
	VRX+QTzngEWQ3+58jAcxkSz1qEiIxKYEu84v8FeJlnMiWgd2JcCfPvQBAf8xSdFODgZqW69LhfU
	yfu0w36nrGBVeLkrRhXSZAyXm0twL9XmIDMAR+AybYRe+EDfjvTH9tFFdCxV1feQZe+faBpxgbq
	qPZeErJs9ypyK9YbC0BVHEDWEn6Q5XZnQbWznvb6fv/Cc1mt/lOB+BxzUHB499c0xLYKJJEgB/k
	PdxE84XyS5UIBk90aV1+FwmiWSAqUqslS3exNiZGJpVwNlTctlCDoJtaUHVQqVvcL9c9GdfKqpn
	PSH/vH2sr
X-Received: by 2002:a05:6a21:110:b0:1f1:817:64cf with SMTP id adf61e73a8af0-1f2f4e4e495mr23799816637.37.1741028283229;
        Mon, 03 Mar 2025 10:58:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUykW5x9XbBIshU6ygZB6a+zQ9TtV2CwGQnAIwjD0aEsfN4kQZdY/EyizdJ71iGLwfZjj53Q==
X-Received: by 2002:a05:6a21:110:b0:1f1:817:64cf with SMTP id adf61e73a8af0-1f2f4e4e495mr23799789637.37.1741028282855;
        Mon, 03 Mar 2025 10:58:02 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734af6abc02sm7152633b3a.110.2025.03.03.10.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:58:02 -0800 (PST)
Message-ID: <d926be86-94d2-4c72-b9ad-4686583f8663@oss.qualcomm.com>
Date: Mon, 3 Mar 2025 10:58:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Pass correct values of center freq1 and
 center freq2 for 160 MHz
To: Suraj P Kizhakkethil <quic_surapk@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250204053451.2703834-1-quic_surapk@quicinc.com>
 <20250204053451.2703834-2-quic_surapk@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250204053451.2703834-2-quic_surapk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZholzvvfTj3C9hCJz3R9Mo54YnrWbDYT
X-Proofpoint-ORIG-GUID: ZholzvvfTj3C9hCJz3R9Mo54YnrWbDYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_09,2025-03-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030145

On 2/3/2025 9:34 PM, Suraj P Kizhakkethil wrote:
> Currently, for 160 MHz bandwidth, center frequency1 and
> center frequency2 are not passed correctly to the firmware.
> Set center frequency1 as the center frequency
> of the primary 80 MHz channel segment and center frequency2 as
> the center frequency of the 160 MHz channel and pass the values
> to the firmware.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/wmi.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index f934d49acee6..848a65268194 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -1037,14 +1037,24 @@ int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id)
>  static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
>  				       struct wmi_vdev_start_req_arg *arg)
>  {
> +	u32 center_freq1 = arg->band_center_freq1;
> +
>  	memset(chan, 0, sizeof(*chan));
>  
>  	chan->mhz = cpu_to_le32(arg->freq);
>  	chan->band_center_freq1 = cpu_to_le32(arg->band_center_freq1);

s/arg->band_center_freq1/center_freq1/ here and below

same for the 2/2 patch


> -	if (arg->mode == MODE_11AC_VHT80_80)
> +	if (arg->mode == MODE_11BE_EHT160) {
> +		if (arg->freq > arg->band_center_freq1)
> +			chan->band_center_freq1 = cpu_to_le32(center_freq1 + 40);
> +		else
> +			chan->band_center_freq1 = cpu_to_le32(center_freq1 - 40);
> +
> +		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq1);
> +	} else if (arg->mode == MODE_11BE_EHT80_80) {
>  		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq2);
> -	else
> +	} else {
>  		chan->band_center_freq2 = 0;
> +	}
>  
>  	chan->info |= le32_encode_bits(arg->mode, WMI_CHAN_INFO_MODE);
>  	if (arg->passive)


