Return-Path: <linux-wireless+bounces-23050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B741AB93CE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 03:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88364A4162
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 01:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164BE221F0A;
	Fri, 16 May 2025 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RFU7aqn2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8523AD;
	Fri, 16 May 2025 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747360322; cv=none; b=gkCBgCsaHuGb05jxC3+K+ScaE+fK5AsojHJC6hremKISYf6bNMmtQ9JQrjyxw0EECVx17j/vxja/WQjy8lCPpCMV5uP2LJYdgAgysgEcZn3hGShGG2piOcLKDXdA2w0zgfLrZYWEBuq7HTwkVJXcOTJJGydBJG/+UltFYpLeJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747360322; c=relaxed/simple;
	bh=u5Z5saGKv/FLbtXJ1oygIX4iaLnFdF9faZRcgpDR8QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VVz/l8DNu2TAwMLdT/xciusG+qik63DNM7w19FXOvj1D7RF4NBoWj6ccLt3SECFKj6FJ+5yAo/y0eUE1aPCEtT/d0wxHOg6wCtM0MwddREXO1LRmcmwV5IgBMohYL/ogfUZZeUC9lRsss8JF31C4P+Ndkev96pEI71x12yagJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RFU7aqn2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFPAx031652;
	Fri, 16 May 2025 01:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CTvwtxAEl/GoW/Fv6LUxyvVqZYvC664HWlTMIoG42sI=; b=RFU7aqn2mSKCi2wX
	ptRaHioNftC9aYL9vxcvOZ0YuUOms8BL1izF4tbQ0IzjGOm5JJKxv/cY7+SxXNf4
	EFjCPLz8lF4DhC5lgFEnvqdPZiyg0lKFolg6V5AEPsYq1CSu6BDbHdmymyGC6rMy
	Et5/nHQJF/kOFrsTlV2SQQhwv3IQP50nAubhFKyy6WumRAtC44oa/nnXGpZzVNRh
	syVh5vmIc4Y36wrLvXUsiPgQJ50lEqaUU+1wndHO/snAsv/EdB7CgeC1ghtqEI9j
	dfPCCvNhTNxG5WRNsOEXjySrcbioS5eSi4ORU7QHDLGVyR/skUWRtKlOpH6bvWdi
	h5cI7Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcr811e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 01:51:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54G1pViq005568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 01:51:31 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 18:51:29 -0700
Message-ID: <50e0757f-03e8-460c-b14a-103e675f5f84@quicinc.com>
Date: Fri, 16 May 2025 09:51:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: clean-up during wrong ath11k_crypto_mode
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, <jjohnson@kernel.org>
CC: <~lkcamp/patches@lists.sr.ht>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250515222520.4922-1-rodrigo.gobbi.7@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250515222520.4922-1-rodrigo.gobbi.7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oFmd9ZE8O3rekEovDSMgfM2t5JrJJGjT
X-Authority-Analysis: v=2.4 cv=Auju3P9P c=1 sm=1 tr=0 ts=68269a37 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VJvuOwoLhTZW_tfsPHkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oFmd9ZE8O3rekEovDSMgfM2t5JrJJGjT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDAxNiBTYWx0ZWRfX5EZH73auMXZ2
 BdR0hP03ZoOHE0zmXhY1S7o8HNb+GQkIvfpjL4SeDkVAKqVI3KJRu/+cNlXKzsNPpv05O1JviMR
 x6xc6pbbeFd7EM58pzoBGlfalhEjLdhg4TBZXcoc3g8dBQEpitgt8kkg8K/7QqDTkZdPiyFYlZu
 THOpnKP9Q0XLElT6mO2xYenOxHNMS6/8q33EXl7duqghZIFqOAAfqN8zda7vMdwCe/Zs2z5FR09
 9G7AjRNNpXIPp2zqDh0tdnQFR7fw+lpfWn8KZ0+t2X2TtWcTJrOCb/IhUcirIzFW9KB7gZ4mzyQ
 9Dmp6UAZuharqnk+8+tH1IiKuEez1TjfpDH37U7tfKCgLNA6wU2K40MshB4CF+lPgXkhxjNw+7g
 Cz2FyEAyGZ6QSQDDs8XNFqeOqNUQYfDnncxWjWCIHPGpnE6h4sJDqBoRqap37lp/6KVqaiQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_01,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=944
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160016



On 5/16/2025 6:22 AM, Rodrigo Gobbi wrote:
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
>  drivers/net/wireless/ath/ath11k/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 2e9f8a5e61e4..fd3017c444a4 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -2163,7 +2163,9 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
>  		break;
>  	default:
>  		ath11k_info(ab, "invalid crypto_mode: %d\n", ath11k_crypto_mode);
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		ath11k_dp_free(ab);
> +		goto err_firmware_stop;
>  	}

Instead, how about moving the ath11k_crypto_mode validating to the top of
ath11k_core_qmi_firmware_ready()?

>  
>  	if (ath11k_frame_mode == ATH11K_HW_TXRX_RAW)


