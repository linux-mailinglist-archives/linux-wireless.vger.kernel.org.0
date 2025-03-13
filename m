Return-Path: <linux-wireless+bounces-20347-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FACA5FDCA
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 18:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013491884E7F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 17:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F22912CD88;
	Thu, 13 Mar 2025 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fs2aRRl5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD10153801
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887001; cv=none; b=C/oKYkLduAo2ZAP6cONrPzNcph7kH++25oIj6tIP2bFjDwIKeyqVSHL4Hhwdr2xkMTGJ07lap6LVXGXrreroogl0KSsjm5hVjrhiminX/kcROhIMF6qsysdKaESwTRe3zQxlC8pcox0lxzsVj2kD57jMdGt1YRTy2DzmyYgws60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887001; c=relaxed/simple;
	bh=HmRa1m3tXTPbBXhjbC00+GsyFNYue27NTEWKBIJHeaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eVpDLZ7YmwtFGiIdrY7nPYzSq4t5YQ+b144jKLoPUWcgPq3075zqYEMREtH4XGJbYu84I6/zYA2p1Og/5WQxunx8PLUl4Y6NZQTEqTxsGkf13giz4LJOedMW0803V7Kt30Nsorqyb7rs5RbIOwKgC8yirjjIh4PAWmZX8ocitvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fs2aRRl5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DC2hmm007381
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 17:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	awOPnnsbd+ZITDDV/+JLRdAlqUsZWoQ4R77EaysafPU=; b=Fs2aRRl5KVkinpOp
	HDdew9bXb3MLMqoaPfl1Yg8hIq22hLlUFwd5DMitu/g4zIwo5Rk7IsNDNq2FIK7P
	jt3WQT+tvfhKkI/tD978Fb6V0Y8ezSlqS6enzQw51MDarjjRHOKY0Na/yuT/yDFt
	YJrAD6P2OD7bLWOVx6NsOt9g8qNO6VV6PooGCm7gEvEs5JrAY2kjbQtMfrWfX+bZ
	s2ij7Ircmlup0VIQ3q/1VsrgM3X6veip0gXKCstyyOVpD9z5Mu+soI3bIhvs/9OD
	LnDI+NDlEc/VS3EqZba5Xwc4pWfkGbfsY790lXktLDxhmrPbQLFQJEgDwO1G48Xz
	2txrHA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bpg8acx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 17:29:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225107fbdc7so21500225ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 10:29:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741886997; x=1742491797;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awOPnnsbd+ZITDDV/+JLRdAlqUsZWoQ4R77EaysafPU=;
        b=P5lRZ+/3N9lMU011kTVh55CXk+WAy7DjafquxFs0PeNVyQRtHM0hr7vCQUwOLUH5E0
         qzphF/zhsbuT00e/1LjQHe/HmrVRV6xagfVOuBfU6acyRY0Oe3bmjzA1sUTbqT7EdFM2
         3phfj34YQo5VPmR1vek6bmMpfyeozc5XeOtO9Sr0IEq5kcTyUHDY+cl6PZ0Z2oaVgEJj
         PJtuca0eXzGKSOJ4Eg1vb03aJG/KUexV5fOk7C56TeHE4BbsJCjDrqDi3NVaoS485Kxm
         hZzIrovzgC6E3uppgl0zlh2yzd4JaLL6Waj4paE/BD42TGiqVrQfCHlwuTaaxSNuH9eM
         gYJg==
X-Gm-Message-State: AOJu0Yyv6X9BjzwVNVC/4UFaiP6K/rrPnFNhxGZ3S65Yz/+HgcWfoZcr
	Kp4IaBEAgpFp4SH5eWzBQ2vDVsFm3CeI8hS3eVvSE3LgQcLOoy07K2oS8k5U0gxkLnnfaFgQDSt
	jhD/ov5N6kZ81uEOYBFJwWiZz7sUO+P+51S6DqgKmJmKbcgiJXirk/+m4GCbA/pKD+A==
X-Gm-Gg: ASbGncs3ZD6IQdTLmzBufblKI7lMFvtlzmQNjFy+SejDE7fuSQ0xQVjlVhZ89jrvzRa
	K209a8sAb2LMvhNSGt/nRCqx9roysW86tjP07sHzV7aACzuWLCIdeKmGmRaown3vUi+33XdW1Bh
	tqdLCcrehKZpanZxCPOj+K8tjtMbKbB5vfvLG3EW9s8OY9Jdffk9cqycOetlhCwD8LjAfXS2lH4
	PThm+/YoFoBsVKJZxA0m3xVc/lFgdpXdApQspysUDy2SgBC4XREzzj9DCAxSG7qMgLtIoB2SbcR
	3ZgnaoqeXtoAF2QlSEvMnbFxAHTzOMSXdbM4MkH4M2fugSV6Ja8AOeNCELx33v6NeS68yqao0tw
	gTkFQpdj2
X-Received: by 2002:a05:6a00:8d2:b0:736:339b:8296 with SMTP id d2e1a72fcca58-7371f17e455mr494949b3a.18.1741886997436;
        Thu, 13 Mar 2025 10:29:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPhq47TWkIDcRQxoDx44xKFXPM4TKX8MLJNf13Xta2UOYeZHJ1f+/yEahV1YT+F1aEcUgnFQ==
X-Received: by 2002:a05:6a00:8d2:b0:736:339b:8296 with SMTP id d2e1a72fcca58-7371f17e455mr494906b3a.18.1741886996826;
        Thu, 13 Mar 2025 10:29:56 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529531sm1608998b3a.2.2025.03.13.10.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 10:29:56 -0700 (PDT)
Message-ID: <fdaab417-62b7-4151-be35-34fb7a354eae@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 10:29:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Drop of_get_property() call
To: "Rob Herring (Arm)" <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250312234228.1243477-1-robh@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250312234228.1243477-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PtWTbxM3 c=1 sm=1 tr=0 ts=67d31616 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=syD-WeZVJwOIrOENAgcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 3Odu8Efkx_SXfPm7kQogLD4RLFJUXZ9a
X-Proofpoint-ORIG-GUID: 3Odu8Efkx_SXfPm7kQogLD4RLFJUXZ9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 mlxlogscore=966 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130133

On 3/12/2025 4:42 PM, Rob Herring (Arm) wrote:
> There's no need to check the property presence and length before calling
> of_property_read_u8_array() as it will return an error if the property
> is missing or the length is too small. The return errno doesn't matter
> to the caller, so no change in behavior there.
> 
> Change of_property_read_u8_array() to of_property_read_variable_u8_array()
> as the former allows properties to be longer than the requested length.
> Now the property has to be the exact length requested as the removed
> check required.
> 
> This part of a larger effort to remove DT functions like
> of_get_property() and of_find_property() which return raw DT data
> having no reference counting.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 22 ++++++----------------
>  1 file changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index b3294287bce1..db7444af251d 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -1889,7 +1889,7 @@ static int ath10k_download_cal_file(struct ath10k *ar,
>  static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_name)
>  {
>  	struct device_node *node;
> -	int data_len;
> +	int data_len = ar->hw_params.cal_data_len;
>  	void *data;
>  	int ret;
>  
> @@ -1900,28 +1900,18 @@ static int ath10k_download_cal_dt(struct ath10k *ar, const char *dt_name)
>  		 */
>  		return -ENOENT;
>  
> -	if (!of_get_property(node, dt_name, &data_len)) {
> -		/* The calibration data node is optional */
> -		return -ENOENT;
> -	}

note that there is one instance where .cal_data_len = 0

so i suggest that there still needs to be an early return here to avoid
kmalloc(0):

	if (!data_len)
		return -ENOENT;

> -
> -	if (data_len != ar->hw_params.cal_data_len) {
> -		ath10k_warn(ar, "invalid calibration data length in DT: %d\n",
> -			    data_len);
> -		ret = -EMSGSIZE;
> -		goto out;
> -	}
> -
>  	data = kmalloc(data_len, GFP_KERNEL);
>  	if (!data) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	ret = of_property_read_u8_array(node, dt_name, data, data_len);
> +	ret = of_property_read_variable_u8_array(node, dt_name, data, data_len, data_len);
>  	if (ret) {
> -		ath10k_warn(ar, "failed to read calibration data from DT: %d\n",
> -			    ret);
> +		/* Don't warn if optional property not found  */
> +		if (ret != -EINVAL)
> +			ath10k_warn(ar, "failed to read calibration data from DT: %d\n",
> +				    ret);
>  		goto out_free;
>  	}
>  

this could made even cleaner using cleanup.h functionality (all of the gotos
could disappear). perhaps I'll do that as a follow-up patch on top of your patch.

/jeff

