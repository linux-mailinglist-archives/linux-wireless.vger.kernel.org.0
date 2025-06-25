Return-Path: <linux-wireless+bounces-24470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD11AE7E48
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AFF7AA914
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45028689C;
	Wed, 25 Jun 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DEJONGvZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C92868BF;
	Wed, 25 Jun 2025 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845582; cv=none; b=HlpvKXBZJT5Ok4jJiIFG9LEt5ION9YEOxvLrOacRqfI32eDXSiB2rbOy8Nq8zchrNaG7YQKm32Nw2NhvgtT9OyW1Jxh0ty7qBz9DeaN8ZChTHPkMJnDoARGDIm8Nz9Hwwn536upg9rYtfOmZd8eJiOKGEpCLyHo2tYWWvbmmQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845582; c=relaxed/simple;
	bh=AZQgeq+wzaP6c1NxNqLyOELLBKFnx3cpL59HyFLTKVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GyrDWoN8XsaPnazNhLwC75KmDfAVwJ6C5D2RWde0tQ7xiIfSiIrfv0BlRoNfA5Lo2uCrsIGh475u/jAk89HDKl2v16t+pnR+NPEKHztcUhHBCuoiqVN7eeOLWGLXLbhKMvpn4Dr+Cz7WDs2eTW7/x94/2mV7Ij1BLO11kjtSSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DEJONGvZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P4Mr9p021510;
	Wed, 25 Jun 2025 09:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WAJGmVLkcSHj7fVRUBSlZ3mqVrP+vEQzKX4QGAJkaOw=; b=DEJONGvZX4VsQRtq
	w8qS9BebcGoZPEfrZV7eYnWhLTlHl3EzikfqIOuMDM8KjHSA/h0LWqiVtaWDeY6e
	6NeVnDJvrSXljE6Yl4K9WZRXrRQ1ZeC5Eya8Gfy8GbiITZIGQqzWQtXsQdEq1p+h
	o6GzA10dNGJSZQZoz0O+8aoPGtGs4DHgVgOpV1048/oe04FJnSKVYGKjOT3F/UGy
	X/wJIEZ0eoD4FnvJKe98a5olatgvXR2wjP/Yt9EZjy/Nea3MwJOX3O6CMth0wWsk
	OqyIIi9xXgpvVOf20XseSJGlBBWsfN1wU9R1wVfv6pGcYscCbIz6gkZhVNnZ4aVc
	decuYw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4rn1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:59:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P9xXmd014301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:59:33 GMT
Received: from [10.133.33.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 02:59:32 -0700
Message-ID: <2e72da79-e443-4168-979d-43722493001f@quicinc.com>
Date: Wed, 25 Jun 2025 17:59:29 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] wifi: ath11k: use plain access for descriptor
 length
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
 <20250604143457.26032-3-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250604143457.26032-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685bc886 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=ijPAINBQZKyftGx5nG4A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NeFfw4ZHt0MuwvFnFKj7ouEZ9c_oM_4s
X-Proofpoint-ORIG-GUID: NeFfw4ZHt0MuwvFnFKj7ouEZ9c_oM_4s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3NCBTYWx0ZWRfX8DC/yWYfjyN/
 kfcyHQ7julZ++IIbfjFA1PQWWt1a/Rdtp0fW/1iHwUQni3FWlM0JR3SvaHaPU2yhexSggcpVtUh
 36pRjqFPUoZXy6JeVEXijAD31pXHX2YIT8qHqsSEWzX+UaUpR2Kl6XG6m6mSoSzRluS81xjT0wh
 i0Q7owJPt2BqJ48QJjjuntkWbmW15uHCQPg1Z/fz7vg3rJiGJCMjXEi+JOq67OqpLwkYj1712vm
 nLLByO7SvPkTdpbNV7tss0x6Y0e0mHP0uS3Puv7N2x6CqR05h/D83AvC7UyRveOOp0AbCOCkwxr
 yI/YiR/Q5lDa5L2X2QHYbbobZohHSPe08wNWO3lreRpf6obNcGhwJWA8xydHE+2lnykcOjzI+ZU
 TJ8/nYf+z2YmJm0oMH4p22XkeX2XeOGbexkXMGOJ8TJcnMFWfrxdjK+/ZXwh7kQwPpJiOENe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=870
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250074



On 6/4/2025 10:34 PM, Johan Hovold wrote:
> The read memory barrier added by commit 6d037a372f81 ("wifi: ath11k: fix
> ring-buffer corruption") is enough to guarantee ordering also for plain
> descriptor accesses if the length helper is ever inlined so drop the
> unnecessary READ_ONCE().
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/hal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index 921114686ba3..b1f5a927dddd 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -599,7 +599,7 @@ u32 ath11k_hal_ce_dst_status_get_length(void *buf)
>  	struct hal_ce_srng_dst_status_desc *desc = buf;
>  	u32 len;
>  
> -	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, READ_ONCE(desc->flags));
> +	len = FIELD_GET(HAL_CE_DST_STATUS_DESC_FLAGS_LEN, desc->flags);
>  	desc->flags &= ~HAL_CE_DST_STATUS_DESC_FLAGS_LEN;
>  
>  	return len;

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>

