Return-Path: <linux-wireless+bounces-23338-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C09AC1BB2
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 07:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA3D3B52E7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 05:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C91C1F130E;
	Fri, 23 May 2025 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FjH3CO3W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA82DCBF1;
	Fri, 23 May 2025 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747976744; cv=none; b=TzSiL0Pgdwhk8YJM0f9qFIrtn1u3rTruu3NNMMOP3/zbkGJwfwCHY2xl0Rh1LNyC07BeyprpuYqKqU+ES42dplyI8b29iKzozYGJpcuVy7Kuz44zsB1pINrywlHO/mlcPe5pe698MtAI/l+Fu2ycZj5AeFil6W6dTis7ThRV9Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747976744; c=relaxed/simple;
	bh=42xHNXdwgu64eht7+e+lSnlXqb1XhZ+WWhH4NSTxmjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s1mmFyTUwHSrQT4L1g0LUxRSfgu3A2iPOtpfK0rBQpeiELsNM2oz8BOSodXUIHxp4cVI1W8ajCxdG9WfrYWhNwYr0jlUgrMKb3cgnXZo1Q7RsbXZWKyHj89YmqS+C134TtYTSaQI4keby8MJG4Twj5UOaGxRPX1hZMS55A9Gzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FjH3CO3W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MHfAE9024983;
	Fri, 23 May 2025 05:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M4ejWxL+Uv0vZGfeK4JWFiOcN3Cry4gCwfNvMNB9sTw=; b=FjH3CO3WOiJQSnGZ
	e+ZMRoEHNkTgKOktKPqkWHPMRT4FgfrypwrPcyNjDoZ9oMfNI37fzkPbuW66ZfyB
	+jJlx2TeBctFk/SmPrV+bPh23qWSnZJU94Qz8N55nIqSiMNPXRx9agiYlsyhqSoi
	S5s7Rwmyogwz9J6pUhLIXTgvdTIs8gHUNidl22e5k1oj2Tn9CSQyzIAzEiYW9uHW
	oFkNx2Vz8Ij84GZuVXbxNmQW1zYZMG4QmsEMts9zAdm5AcmtA9pTOl8U9M4hhxdZ
	GiNoPeYp1eML8FL+fF2KuLPHXOcN1fxRuhGIfhyPllcC64pd6HLewNA/Io+X4JDh
	+x86pA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf50hrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 05:05:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54N55UBe011765
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 05:05:30 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 22:05:28 -0700
Message-ID: <36929281-1541-4d03-b192-41e2d756b2a5@quicinc.com>
Date: Fri, 23 May 2025 13:05:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v3] wifi: ath11k: validate ath11k_crypto_mode on
 top of ath11k_core_qmi_firmware_ready
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, <jjohnson@kernel.org>
CC: <~lkcamp/patches@lists.sr.ht>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250522200519.16858-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250522200519.16858-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JRsgdNdmugEc3tRhRUs6upI49547bdZ1
X-Proofpoint-ORIG-GUID: JRsgdNdmugEc3tRhRUs6upI49547bdZ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA0NCBTYWx0ZWRfX6RoqXbNCJRCF
 o1LwJ0Zrul6/HIDRsEKsL+OewluT/7mU0htXkH2AZd1GRU5mnjeWsVA80EbCpXtMfvVsCLYL3nj
 0uPCXimqIT2OtZ57OVtE4FDuByMfwxCNR3fGQoZEkjUN7EqZAP7v+kOUgyKnr84LBePWvfpxjqc
 c4+dsH9RxwU4XqTQFlV36EvLY4sTv1uKthGG21tug5ZHUT9FgjIXHWSv5ZI5jrCIeczzi+gx5HS
 tMG2kLqOatsCD1vNa/7EJB4EOZLBFzj8AKDPfV9JogI8ywz/hH1tsSb5uChA/uYsXHagWs4HBKN
 QL4KNDei4vRVE30qRNMqgjWjm4cqA5UhZ12Fkw6dtTp93jRamlCaA2EpxVMeppRg+7k5YkS8TOA
 Z7WbH4svwCzO1iLwevxAErRqi9SL8Io5+bn8BF71ssNg4ZaJ1j9dTI5DjL6J1P8OWW3kpJ0H
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=6830021b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=COk6AnOGAAAA:8 a=IKtu_ZbJ327sXn2LrhgA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505230044



On 5/23/2025 4:01 AM, Rodrigo Gobbi wrote:
> if ath11k_crypto_mode is invalid (not ATH11K_CRYPT_MODE_SW/ATH11K_CRYPT_MODE_HW),
> ath11k_core_qmi_firmware_ready() will not undo some actions that was previously
> started/configured. Do the validation as soon as possible in order to avoid
> undoing actions in that case and also to fix the following smatch warning:
> 
> drivers/net/wireless/ath/ath11k/core.c:2166 ath11k_core_qmi_firmware_ready()
> warn: missing unwind goto?
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> Changelog:
> v3: move validation to the beginning of the ath11k_core_qmi_firmware_ready(), so
> we do not need to clean-up things. A small change over the commit msg due that change.
> v2: https://lore.kernel.org/linux-wireless/20250515222520.4922-1-rodrigo.gobbi.7@gmail.com/#t
> v1: https://lore.kernel.org/linux-wireless/20250515004258.87234-1-rodrigo.gobbi.7@gmail.com/
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 28 +++++++++++++-------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 2e9f8a5e61e4..b894e27435da 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -2134,6 +2134,20 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
>  {
>  	int ret;
>  
> +	switch (ath11k_crypto_mode) {
> +	case ATH11K_CRYPT_MODE_SW:
> +		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
> +		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
> +		break;
> +	case ATH11K_CRYPT_MODE_HW:
> +		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
> +		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
> +		break;
> +	default:
> +		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
> +		return -EINVAL;
> +	}
> +
>  	ret = ath11k_core_start_firmware(ab, ab->fw_mode);
>  	if (ret) {
>  		ath11k_err(ab, "failed to start firmware: %d\n", ret);
> @@ -2152,20 +2166,6 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
>  		goto err_firmware_stop;
>  	}
>  
> -	switch (ath11k_crypto_mode) {
> -	case ATH11K_CRYPT_MODE_SW:
> -		set_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
> -		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
> -		break;
> -	case ATH11K_CRYPT_MODE_HW:
> -		clear_bit(ATH11K_FLAG_HW_CRYPTO_DISABLED, &ab->dev_flags);
> -		clear_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
> -		break;
> -	default:
> -		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
> -		return -EINVAL;
> -	}
> -
>  	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)
>  		set_bit(ATH11K_FLAG_RAW_MODE, &ab->dev_flags);
>  

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>


