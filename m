Return-Path: <linux-wireless+bounces-24472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD84AE7E4A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B3C16C0FD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 10:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA028642A;
	Wed, 25 Jun 2025 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R95V02ej"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D2221DB9;
	Wed, 25 Jun 2025 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845614; cv=none; b=u0xx3JNeHs7PartUAz/jtFkAcbp3LJhvWqim2BJp7iiQ0aGM3GeVSKN1bczOostsDP2ZrQrOv0lig9SXG4/4s7zlKxocYZGL0extPdN1/whIR1GQTuOa4XAVWbFqNUsLhepQxwFTvix1x7fT80LAc+YmdOWM1Hu+Rfa4c1I+p0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845614; c=relaxed/simple;
	bh=BeaMRImxY9Rsxe0eAq/JVZzac9qi2Y4iE4QKSUZLtwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fc+9vvwDjBvilVPgalO8KRKSerXC8o9v1NRFpheAFLDAe0IdRKAyuTbSQXyu19+mpwkJ7OK7DUxJi071jgX4QmJz1Elqy11TW78Ku/kelXAT7CKJtbKQ9ZcWyweo0HpPbbUkuZRlMw2ZQjd/6S2KzMyrks7sUxL0jIbRXDAFa90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R95V02ej; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P1pgjl001551;
	Wed, 25 Jun 2025 10:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IkadxbS0FqUhIvXtyau88bHjaVqtYdQSG74nCpxQAg8=; b=R95V02ejD2GPCf/Z
	Yu5G1gLJ0szhGITc7Uhi+GacaX6E03wIczps3ngAOzBAwb32uWHbJUUT3BFngt13
	UWF1q67EnJqT+5/TC0H0DBmHzKIg4qHQC3HPj1WB/4HMMdUfjiv54GKqJG3x2GXY
	rKzs8fN/jZFO+7ZGf37qJdtBTeeDft1e6xPiqQJ5j7Ajhnkw73d5N4dVauWVUmJR
	NqDVrc7lu3JmO013kuyNrD1hezN557VFMUzw8EcqNIgi+/142YNp/N+He55uUkIs
	VHfu6bAX8LAyDSWYerdeAfbbiRLJtLFkkhe2BhsEDsu+cJjeOq0x/l9Pt9I7NuzK
	dCEpFA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g7td98tx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:00:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55PA086e019975
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:00:08 GMT
Received: from [10.133.33.71] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Jun
 2025 03:00:06 -0700
Message-ID: <73e7548b-fb23-4887-a575-dfa0f681a0dd@quicinc.com>
Date: Wed, 25 Jun 2025 18:00:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] wifi: ath11k: fix source ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250604143457.26032-1-johan+linaro@kernel.org>
 <20250604143457.26032-5-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250604143457.26032-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CPYqXQrD c=1 sm=1 tr=0 ts=685bc8a9 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=WnX9ENNIfPvkDGQfGdAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA3NCBTYWx0ZWRfX3KV2ow5qkjf9
 fxa070+XiKv/KShaAXXYTgl6/EN61JgNQC3NaqJ2tSD0Sms3XD0Z2evgnqknpvXnd1bdtz7zuFy
 n/GWLKZythALOa7bTDhFyBO6g85KDaeUejJ15m6WoKi4IC0C9SPEfLSPmODSWFwKNWQujyoGxi7
 dka1RZlwlxQR6O5gKmhA/uqMLYYNZI+BbU/lsaHJwrcFnCrkT8iXqkWosPAc3bk54JqPs0e6wmn
 dIDvlAgwXZYn/C1/Qulci/U5ML4+5Zm+qTOiGaaLzGzOfZUQGgRxr+TVfVa5JirPN9n2fEA4hPv
 9c6zh0hbbWQPt+prkSlMSPkU0wG06a6z2v+/slan7Wi+WpPqZML5Src8/Z98uaMyIjghuszQhNe
 MqdQa8jxCBEQgPa/gJoxKbRrfWZEMRjjqLYJK2pR4+oVh98bQbTudIY2vQnNozZld8U48Xuk
X-Proofpoint-GUID: ExzvcJTQUntCBxMsBmWJ1C5ihX3GB_zD
X-Proofpoint-ORIG-GUID: ExzvcJTQUntCBxMsBmWJ1C5ihX3GB_zD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 mlxlogscore=433 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250074



On 6/4/2025 10:34 PM, Johan Hovold wrote:
> Add the missing memory barrier to make sure that LMAC source ring
> descriptors are written before updating the head pointer to avoid
> passing stale data to the firmware on weakly ordered architectures like
> aarch64.
> 
> Note that non-LMAC rings use MMIO write accessors which have the
> required write memory barrier.
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org      # 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath11k/hal.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index b1f5a927dddd..927ed2bc3fbf 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -862,7 +862,11 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  			srng->u.src_ring.last_tp =
>  				*(volatile u32 *)srng->u.src_ring.tp_addr;
> -			*srng->u.src_ring.hp_addr = srng->u.src_ring.hp;
> +			/* Make sure descriptor is written before updating the
> +			 * head pointer.
> +			 */
> +			dma_wmb();
> +			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
>  		} else {
>  			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
>  			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
> @@ -871,6 +875,10 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  			srng->u.src_ring.last_tp =
>  				*(volatile u32 *)srng->u.src_ring.tp_addr;
> +			/* Assume implementation use an MMIO write accessor
> +			 * which has the required wmb() so that the descriptor
> +			 * is written before the updating the head pointer.
> +			 */
>  			ath11k_hif_write32(ab,
>  					   (unsigned long)srng->u.src_ring.hp_addr -
>  					   (unsigned long)ab->mem,

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>


