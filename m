Return-Path: <linux-wireless+bounces-22165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22B7AA0000
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D215A7B13
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 02:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BB322F3B1;
	Tue, 29 Apr 2025 02:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IR4ajaxR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1939C148;
	Tue, 29 Apr 2025 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745894367; cv=none; b=koTEzxLMIHCHkzoPuxIOMSpEHkdo8KiU1EX7I+kPbE8FlJf+L78NRvtu8x8dOhHg/smkr0j8NcdlttinONFuejf7uw7k2uhQNNCujPxP5GVbR02XztYj4a9pp8g0dVLgW9iTOaTbXBCXYWh0woq7TkyVmjAT0mMV8uh1Lt14CkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745894367; c=relaxed/simple;
	bh=CrwT/ljPsJFDXtcbdCiabcYKmXMKrWVP8Z31dUUNNA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tb6JmDfnvjSKdq6YAurUPW6kAr49cN9xZ2OwcdFagshDbPMZg7I8usW4v21SvrMVKEKU8AO8PXgr6DitNsAmBQVgpI47Y3PP5HwySfB72lpVu0QUUtELByn5ycX7he2n/pfhmkN+3nmFeoyXKKIdtASvftHFD3XMNkMYIe0GStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IR4ajaxR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNqEg5025873;
	Tue, 29 Apr 2025 02:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NKktZXjUVHJTf01+SeFofdJnC/BYWnl8koKOQ2R+rp0=; b=IR4ajaxRVA6arZQq
	Xyn9Yc1IamGIubk8l+gDMRwVv0fzEyE3FFWhSI/atsW7o3zHbM1uHsodP6mq5+H0
	XwqGa/cEkaimj/yAAfIc7I77FSpSMkzAqghLCpatshwCJuo9j2PVnuWGvrUyRe/r
	oGV5k+vkrogZldvsV5qJW7hzt7Ae3njUZQJRVfsk+ixlc7UBBppLlI4i1MevJBSO
	0vtRdap3I6bGcBSF/RnEuI20hTLZbZRZm7GoPZGTagGcqyFS10oUQ1DH2WxK/EYx
	vc7wGqVN0/FnK2YHN8hStdfjfqMGsdy/gNw3KZncel4I6YuGC13Xke5euyD0bVhY
	kvefFw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468qq5j4tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 02:39:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T2dG5P007055
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 02:39:17 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 19:39:14 -0700
Message-ID: <f574983e-bd12-4d8b-b294-87c5e554f784@quicinc.com>
Date: Tue, 29 Apr 2025 10:39:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        <jeff.johnson@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>
CC: <kernel@collabora.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250428080242.466901-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250428080242.466901-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jep2DKH73GU4AkaTDt10RXB5OvepQmwV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAxOCBTYWx0ZWRfX6XHN9NauGqYO ER9JmSwSW4mDiLyflRcUjdBr7pAgY+55VbAMv2QXcOGf6wY72O+nWzdVEATLcxGgNPCU5CnGwHk W0ACY3bm4n/gJkTzAJT7vs7SgJEWUcwjsOADy77swkrpb5SdNSyxfjfhXYj/har6+hzC/jBvIfC
 fimFqae+f9Lbq3hNip18GO6nf+iPWDLhI9mGdOvShOkfcLY42PPZ0hAZ5bMYeNNX74mfrwZwodk Ev0D5ZhxxfpF1T+Xw13XEzsh0gaaU6vBpYVwo0zLRISz/1dbsIxVq4Ja209VKU2vyQm4kputsiC JiwlxO6FOicKbPgKEmG+lVDjfHNoA6h4Hx/vpw53VpQKwEroj6czezc286Eq9VkNEx7HYQHYXuU
 Zd01KuzXATHapr7KrdhevpzD1g+jcAW1N9ksdtkFyQsYgB0e5kY3PdIS9qDQbpfhWOtoNWbH
X-Authority-Analysis: v=2.4 cv=QP1oRhLL c=1 sm=1 tr=0 ts=68103bd5 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QX4gbG5DAAAA:8 a=COk6AnOGAAAA:8 a=7xKvOyCpBhAOSqRoKRkA:9
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: jep2DKH73GU4AkaTDt10RXB5OvepQmwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290018



On 4/28/2025 4:02 PM, Muhammad Usama Anjum wrote:
> Firmware requests 2 segments at first. The first segment is of 6799360
> whose allocation fails due to dma remapping not available. The success
> is returned to firmware. Then firmware asks for 22 smaller segments
> instead of 2 big ones. Those get allocated successfully. At suspend/
> hibernation time, these segments aren't freed as they will be reused
> by firmware after resuming.
> 
> After resuming, the firmware asks for the 2 segments again with the
> first segment of 6799360 size. Since chunk->vaddr is not NULL, the
> type and size are compared with the previous type and size to know if
> it can be reused or not. Unfortunately, it is detected that it cannot
> be reused and this first smaller segment is freed. Then we continue to
> allocate 6799360 size memory which fails and ath11k_qmi_free_target_mem_chunk()
> is called which frees the second smaller segment as well. Later success
> is returned to firmware which asks for 22 smaller segments again. But
> as we had freed 2 segments already, we'll allocate the first 2 new
> smaller segments again and reuse the remaining 20. Hence 20 small
> segments are being reused instead of 22.
> 
> Add skip logic when vaddr is set, but size/type don't match. Use the
> same skip and success logic as used when dma_alloc_coherent() fails.
> By skipping, the possibility of resume failure due to kernel failing to
> allocate memory for QMI can be avoided.
> 
> 	kernel: ath11k_pci 0000:03:00.0: failed to allocate dma memory for qmi (524288 B type 1)
> 	ath11k_pci 0000:03:00.0: failed to allocate qmi target memory: -22
> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Update description
> 
> Changes since v2:
> - Update description and title of patch
> 
> Changes since v3:
> - Update description and title of patch
> 
> Changes since v4:
> - Update title of the patch
> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 47b9d4126d3a9..2782f4723e413 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -1993,6 +1993,15 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>  			    chunk->prev_size == chunk->size)
>  				continue;
>  
> +			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
> +					    chunk->size, chunk->type,
> +					    chunk->prev_size, chunk->prev_type);
> +				ab->qmi.target_mem_delayed = true;
> +				return 0;
> +			}
> +
>  			/* cannot reuse the existing chunk */
>  			dma_free_coherent(ab->dev, chunk->prev_size,
>  					  chunk->vaddr, chunk->paddr);

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>



