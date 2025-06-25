Return-Path: <linux-wireless+bounces-24471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53EAE7E4C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AD6188E55E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A87F28937A;
	Wed, 25 Jun 2025 09:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kPJyZ/ue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732829AB13;
	Wed, 25 Jun 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845594; cv=none; b=Tj/eX7FqRAMt7d/TZaVzcsXs0EmdvPrN7IjSKaxN81AkLdY8XDniAFdW5SNcv6JjLjrqcLAcHWjGx8qfWtbnjLwXAqTSDPm/5qsHtU2cq/XRx1loQX8KYAeLQ5EfRmx0xnvM2/VgTavNkJm1JDbh/klpr8Q/C+kzMi2OQ42vbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845594; c=relaxed/simple;
	bh=lP1y+hxZt7l9eoogBTFoDaowUEO150LmZyIiltfUMrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kIJUcBUD4Kqt1yUeajIHUMdRg0ZZj5w40Irk5MORWn6k3ApLd71UgAL2rMbIHPYjdJ0iBRq+CUQOGtqPNOMZBWlr5H5ugSEsQzNqtKg3wmIWxVimt0JnvfueuIArGC29d3ZlhKt331Z/xtQFa2W5RY6AbMkfRYgLGCALXbMHr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kPJyZ/ue; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P5Ntig032017;
	Wed, 25 Jun 2025 09:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YzatJVk7HULpAK16hp2DZtWnmjU7xj3LImLAiQLPHcE=; b=kPJyZ/uetvO+BuRN
	Fo2uy1gXlRkr9p/tW/0xJlawR9tbaEtXUz7peUSWo2hl9fqsDLkOwCdB6aXSebUg
	jzmiV2rnFWYLLZLxDhsGXoIOdWhJJXlmmZ1IfP+RJvDHScvoyZTQcwhy1bhr7Q+m
	7EcRyWBqf/tjgj1iBiRddIHe1y2H2z0ykZR4WJgE64kxMRTX4rgM6mceoa5uo7eY
	3YPvmVJYpHnUswuBGPzgXGQnHQVPBKUOVZpBvKVt2Be/aFmwrDXvLprvEmMe/fKG
	qPHvXi6v+23uXi+C1OjwwiAupa4kluEo5uEWV6jE82/5sCy1mMurdRcKXZmPh+8R
	MTpBBQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4rn28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:59:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P9xlgM019131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:59:47 GMT
Received: from [10.133.33.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 02:59:46 -0700
Message-ID: <fcb5c21d-a2a2-469e-8fd3-b0104d392bce@quicinc.com>
Date: Wed, 25 Jun 2025 17:59:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] wifi: ath11k: use plain accesses for monitor
 descriptor
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
 <20250604143457.26032-4-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250604143457.26032-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685bc894 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=PK9IGAJSL3QZDn1QluMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: o6HnElnQ1XgdMq66l--787zsDa_3moZL
X-Proofpoint-ORIG-GUID: o6HnElnQ1XgdMq66l--787zsDa_3moZL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3NCBTYWx0ZWRfX72g01TTUvA6C
 cjKzFkMtRl21YcpK/TjfbhScGoSp1oOMSxm27cCEpJ9Vb776b3KyJFFVhSDomL6JYdMwn/jPSMw
 Zl3qMXxotjBy4rjhUh00ekXRBJOgMKHvVRES735idhlpyNEatEmGhjAr4WAbd9WwHT72L8xYsM4
 cfiDdLtcYqmaEb0mg3ZDg00kXA02yW/qVfkDe/JvMY5QF4IQtHr3FR3wv1RlFHJz1zOQbJbr3Uq
 BYs5T4eIVBcohjgFevMrIH/AuTWhKmXQ+QMVyFvakoou6h3cftgZOtxWAE1IKZbT4RxyLSRnOa5
 w16gQilHjEtrK04DI4qbveE9y05jHCjiHWUUNCCa5JIEsVkoirJzAN5PURMdxO1Pj0kGaS9sycG
 CD0VV2hmcMeNV2i7KfD6HDWVGKuAoO0yaQ3h6MBE7yVo4r8n7oT7gIA+kgyjk+ag4EXv52eg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250074



On 6/4/2025 10:34 PM, Johan Hovold wrote:
> The read memory barrier added by commit ab52e3e44fe9 ("wifi: ath11k: fix
> rx completion meta data corruption") is enough to guarantee ordering
> also for plain descriptor accesses so drop the unnecessary READ_ONCE().
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index d8dab182a9af..218ab41c0f3c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2637,7 +2637,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
>  	struct ath11k *ar;
>  	struct hal_reo_dest_ring *desc;
>  	enum hal_reo_dest_ring_push_reason push_reason;
> -	u32 cookie, info0, rx_msdu_info0, rx_mpdu_info0;
> +	u32 cookie;
>  	int i;
>  
>  	for (i = 0; i < MAX_RADIOS; i++)
> @@ -2654,7 +2654,7 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
>  	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
>  									     srng))) {
>  		cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
> -				   READ_ONCE(desc->buf_addr_info.info1));
> +				   desc->buf_addr_info.info1);
>  		buf_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_BUF_ID,
>  				   cookie);
>  		mac_id = FIELD_GET(DP_RXDMA_BUF_COOKIE_PDEV_ID, cookie);
> @@ -2683,9 +2683,8 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
>  
>  		num_buffs_reaped[mac_id]++;
>  
> -		info0 = READ_ONCE(desc->info0);
>  		push_reason = FIELD_GET(HAL_REO_DEST_RING_INFO0_PUSH_REASON,
> -					info0);
> +					desc->info0);
>  		if (unlikely(push_reason !=
>  			     HAL_REO_DEST_RING_PUSH_REASON_ROUTING_INSTRUCTION)) {
>  			dev_kfree_skb_any(msdu);
> @@ -2693,21 +2692,18 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
>  			continue;
>  		}
>  
> -		rx_msdu_info0 = READ_ONCE(desc->rx_msdu_info.info0);
> -		rx_mpdu_info0 = READ_ONCE(desc->rx_mpdu_info.info0);
> -
> -		rxcb->is_first_msdu = !!(rx_msdu_info0 &
> +		rxcb->is_first_msdu = !!(desc->rx_msdu_info.info0 &
>  					 RX_MSDU_DESC_INFO0_FIRST_MSDU_IN_MPDU);
> -		rxcb->is_last_msdu = !!(rx_msdu_info0 &
> +		rxcb->is_last_msdu = !!(desc->rx_msdu_info.info0 &
>  					RX_MSDU_DESC_INFO0_LAST_MSDU_IN_MPDU);
> -		rxcb->is_continuation = !!(rx_msdu_info0 &
> +		rxcb->is_continuation = !!(desc->rx_msdu_info.info0 &
>  					   RX_MSDU_DESC_INFO0_MSDU_CONTINUATION);
>  		rxcb->peer_id = FIELD_GET(RX_MPDU_DESC_META_DATA_PEER_ID,
> -					  READ_ONCE(desc->rx_mpdu_info.meta_data));
> +					  desc->rx_mpdu_info.meta_data);
>  		rxcb->seq_no = FIELD_GET(RX_MPDU_DESC_INFO0_SEQ_NUM,
> -					 rx_mpdu_info0);
> +					 desc->rx_mpdu_info.info0);
>  		rxcb->tid = FIELD_GET(HAL_REO_DEST_RING_INFO0_RX_QUEUE_NUM,
> -				      info0);
> +				      desc->info0);
>  
>  		rxcb->mac_id = mac_id;
>  		__skb_queue_tail(&msdu_list[mac_id], msdu);

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>


