Return-Path: <linux-wireless+bounces-21302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C8A81D6E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 08:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D279C8A0CF6
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257121D5AD4;
	Wed,  9 Apr 2025 06:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TvlSmvmC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB598BEA
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181186; cv=none; b=tl1WWWDB/etxA3VpDyVPONvw1MRrq+WQK78PGiWPIs0EqVK+E+PmsDKJmqDs05jq69hKHRCV5GUOFHg9rXfMmeoMoEbDFAGyO3Vxmpb1UJC4zpfcvLuQqYGLeYCMgDpystZ7d2Xams6HShRpM1D7i7MaX9Q9kF6cL13REMcTvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181186; c=relaxed/simple;
	bh=1uJW6ZT62u1IK7+inDkRJd+y/wDvPKOcTnp/8F8uYAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QPEDS9FsiT+dcZQY2vIoVY8EUdp7J0DL/hwg2I5Wm6UavTAPisDZnSZDiEie+P6lpY8CXtRi1zqtX8DcGj6MdRXS6TfcctkDEHlZjc4ck8juW7zNTfdcogczD93iDC5dpgTOYv+qRKW2sH2dfGEK/YRrv2kXSr5cJZEaFais7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TvlSmvmC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538JZ2R8006892;
	Wed, 9 Apr 2025 06:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u/Rtdw729DrYsVcMcBJ5bS0z0LMNSPt1aCCP1Q8gcBA=; b=TvlSmvmCX0nS0u7x
	JLjeHlagfJrlgqSYUx846bf8b0NIKpBtdyP63RawepFi1g0Hz5S4qtHjko+gmJKW
	NszyyHxOlX8VFeusLqxC1bguf65MK4Ry8E6dN2pSStcolRzJb/qx6990wMrZ+Dn5
	jvfbhbk9TaY8SGwaD/49nP1Jcq4Onae08+sd4FR9TITEnoJ1ePYyYfRqSnYDzdCS
	96Y0Jve/t4ERmuiP/XLrwdJgT0BioXifmBU7Or/N8kdpY+A3M2JLgn7ED8fyasmN
	iOPyeRcrZIF3267YDFIvHOFFDMoYsYXh6OBC1/ZXYPkC96DIYtfD6IMPD//krqXJ
	RbPruQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twg3ja92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 06:46:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5396kKjq002640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Apr 2025 06:46:20 GMT
Received: from [10.216.15.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 8 Apr 2025
 23:46:18 -0700
Message-ID: <cb37ecfe-c737-de97-0729-af2c87062058@quicinc.com>
Date: Wed, 9 Apr 2025 12:16:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: using msdu end descriptor to
 check for rx multicast packets
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250408130132.2919329-1-quic_sarishar@quicinc.com>
 <20250408130132.2919329-2-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250408130132.2919329-2-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vOPB5BQOJv4ux141sfRx5uVvHB8Z3BlG
X-Proofpoint-ORIG-GUID: vOPB5BQOJv4ux141sfRx5uVvHB8Z3BlG
X-Authority-Analysis: v=2.4 cv=I/9lRMgg c=1 sm=1 tr=0 ts=67f617bd cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=PuXzj55vBIrZp1NSK-YA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=894 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090027



On 4/8/2025 6:31 PM, Sarika Sharma wrote:
> Currently, the RX multicast broadcast packet check is performed using
> bit 15 from the info6 field of the MPDU start descriptor. This check
> can also be done using bit 9 from the info5 field of the MSDU end
> descriptor. However, in some scenarios multicast bit is not set when
> fetched from MPDU start descriptor.
> Therefore, checking the RX multicast broadcast packet from the MSDU
> end descriptor is more reliable as it is per MSDU.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/hal.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index d00869a33fea..d961392bb981 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -449,8 +449,8 @@ static u8 *ath12k_hw_qcn9274_rx_desc_mpdu_start_addr2(struct hal_rx_desc *desc)
>   
>   static bool ath12k_hw_qcn9274_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
>   {
> -	return __le32_to_cpu(desc->u.qcn9274.mpdu_start.info6) &
> -	       RX_MPDU_START_INFO6_MCAST_BCAST;
> +	return __le16_to_cpu(desc->u.qcn9274.msdu_end.info5) &
> +	       RX_MSDU_END_INFO5_DA_IS_MCBC;
>   }
>   
>   static void ath12k_hw_qcn9274_rx_desc_get_dot11_hdr(struct hal_rx_desc *desc,
> @@ -902,8 +902,8 @@ static u8 *ath12k_hw_qcn9274_compact_rx_desc_mpdu_start_addr2(struct hal_rx_desc
>   
>   static bool ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc(struct hal_rx_desc *desc)
>   {
> -	return __le32_to_cpu(desc->u.qcn9274_compact.mpdu_start.info6) &
> -	       RX_MPDU_START_INFO6_MCAST_BCAST;
> +	return __le32_to_cpu(desc->u.qcn9274_compact.msdu_end.info5) &
> +	       RX_MSDU_END_INFO5_DA_IS_MCBC;

hal.c:905:16: warning: cast to restricted __le32
hal.c:905:16: warning: cast from restricted __le16

Pls address the above warning.

Vasanth

