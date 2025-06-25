Return-Path: <linux-wireless+bounces-24453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C846AE7488
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 03:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674B217AC0D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 01:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C9E197A76;
	Wed, 25 Jun 2025 01:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W9jTFjmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DFF70813;
	Wed, 25 Jun 2025 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816492; cv=none; b=rGr+R1X1gMEt4IculZ5e8NBgCTj8AGs3QOsm85RH8QKvU13O0uoGvRu8TqGOw6sLSqMsW5w6DNs3lm1qytQIPLC9w239clXqgvmztSg7fjNEBR4+PUZovyoTBoY8Tw2FZFz4FmKtVu5TlpPirZmBWuG3LquIqAQZg61ssA0IddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816492; c=relaxed/simple;
	bh=B7I8JEHf3lGoRCj0HUbRwbAqbw30uuDOEl/TpV2GTMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uBvLMfyTFgEDg1BLQ2y46XUn0qzGm+8nWawjYTB7QQySMjXmsZKMJNxCsHvirXdTnkD7s6HJ7fduwyUuB8+VMIjl8yEQFL2rIRKj0qwqSStGYfcs6G4GTG/AF8sjtayQZBB1lWFinTKyKbsR8P7zo0NUGNJTB9kWjuQqgUdixY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W9jTFjmz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFUYXJ014481;
	Wed, 25 Jun 2025 01:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fMeP4JMT5RRHOVfYF2hWyxK4pUekVhBHFBicBsTy5Cg=; b=W9jTFjmzfljaD9d4
	dfrPZ7Kbr8Stzy4xrLjEyp/Q54WiWkYSrmBxeUfQSSSGA+/mVEi9rxMAGRjwD4nQ
	YZhqcp6gpaMYXmi19bhnIdc2uKOULQ/UlDMJQxnHIZy+xgOnrhUifHwWsTP7i7vK
	PHe3ZZwRVD11OCEgzRVYtgJ6CdfIcKqzBaacT26cQtFZYGi30X+LV888A6IVxyhZ
	CYBltXK6NHG7eDBGq/ceLTlib1ZgLqdmvuT6Jffa/Kj0PtVYpYsZEkpvL7BjyoNm
	qin8PZ+OoyGW9BoAZ60YUJqDVbCHg9hs0JWv4Eh/FnJ96OgfTuyuIuJglq9WEU/J
	Q++DUw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5q7vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 01:54:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P1sgO9010190
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 01:54:42 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Jun
 2025 18:54:40 -0700
Message-ID: <2012077d-5da4-4805-a0e1-3c56b40a9b1b@quicinc.com>
Date: Wed, 25 Jun 2025 09:54:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: ath12k: fix dest ring-buffer corruption when
 ring is full
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Remi Pommarel
	<repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250617084402.14475-1-johan+linaro@kernel.org>
 <20250617084402.14475-5-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250617084402.14475-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BdPMhkEJTPpPpwbGmhdR4FQBFfn_PBf2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAxMyBTYWx0ZWRfX1XQplLuMN2yH
 /vw3oHTiT85PjC00l0TDL2tohadAG1Gc6CZzS4rS+Qpz3uvBM8e07SJ2FE3pFVnq4MdKdMgsR2w
 OIppEyAb/ugFnGdbCr6Kt9PdRD/GX+aDozkGqPrlkFuFy/CmGgAsIISXUJYDE9QnJQdlnxfgYt9
 BYOF7PLnwLZvxTUqyMV8hahzfjL6CX6w1oB3Bssr9WugJUkYX2MZVj/JYLcCeyjpUgSUkSRJRSa
 BTpIS2YujVWDRvr6I6S9ebbBIvGTr9eFhLJzgU1pHNiIRm2uFg7iAmNled9erUacsXGjuaSISdT
 ZTJSfDymtDayluTYnhRq/K04Wmmz2p4BT7l+dc6eNm+Y7MC0mHkPHW+YO6NT7+MXhj5emODhk5P
 OxI2fbLkatKhgfz1+r9HWgQx3arxJ2s+rhcbL8pi5sJFTeGrML5ZEkv26GuUaeSrHGE8H7Xd
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685b56e3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=3Go43yyQdFlCKqBfqAEA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BdPMhkEJTPpPpwbGmhdR4FQBFfn_PBf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=702 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250013



On 6/17/2025 4:44 PM, Johan Hovold wrote:
> Add the missing memory barriers to make sure that destination ring
> descriptors are read before updating the tail pointer (and passing
> ownership to the device) to avoid memory corruption on weakly ordered
> architectures like aarch64 when the ring is full.
> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: stable@vger.kernel.org      # 6.3
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath12k/hal.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index d8193d9577bb..6406fcf5d69f 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -2170,7 +2170,6 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  {
>  	lockdep_assert_held(&srng->lock);
>  
> -	/* TODO: See if we need a write memory barrier here */
>  	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
>  		/* For LMAC rings, ring pointer updates are done through FW and
>  		 * hence written to a shared memory location that is read by FW
> @@ -2185,7 +2184,11 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
>  		} else {
>  			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> -			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
> +			/* Make sure descriptor is read before updating the
> +			 * tail pointer.
> +			 */
> +			dma_mb();
> +			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
>  		}
>  	} else {
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> @@ -2201,6 +2204,10 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  					   srng->u.src_ring.hp);
>  		} else {
>  			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> +			/* Make sure descriptor is read before updating the
> +			 * tail pointer.
> +			 */
> +			mb();
>  			ath12k_hif_write32(ab,
>  					   (unsigned long)srng->u.dst_ring.tp_addr -
>  					   (unsigned long)ab->mem,

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>


