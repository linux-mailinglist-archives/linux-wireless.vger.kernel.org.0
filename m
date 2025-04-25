Return-Path: <linux-wireless+bounces-22066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85907A9C6B4
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 13:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7697D17E773
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C032923D2AE;
	Fri, 25 Apr 2025 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BEse50Nm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312823D2AA;
	Fri, 25 Apr 2025 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579338; cv=none; b=Ig2KmW8pUaQvJwxsWzk0HxBuS9vWJD1+CH0aUw3MuCg4PU6GdOe+5vP/6vaymlxTAxH6VFWTn7h4Jd79IgYvh9hOYv6J+r5fCnvUlXTA3VPql43YHp4p/766amSqW15JUp0hGBm9ixRf9zfcIMovxys5eHv1o55pbtr5IAkPubU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579338; c=relaxed/simple;
	bh=A2/kZxRyL0ITwGQYyD6Z2fNR4JvWvhN9lZfhC1i+/bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hXtusS69nnPen3LirEJr2fITwTAEKjI6xNEf3LYXTw75JU0CGuFrQikCAW3dVCuN7TqhH6rOz/tHvX+NfYQYcJCnA8vxRYvjleSmE1o/GD5Lts1llTRWbJDlrj8veiH8Ooxncx8EmuuKuLRwA1IM/toclkEeJUMshakSdrBXSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BEse50Nm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8T77A008626;
	Fri, 25 Apr 2025 11:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KBe1NI1Wfn0ex1oNt269TcEak7ZMuXOxhR1u9j6mEyc=; b=BEse50NmGUYclXQ5
	hr5Y3Is4gSTA7KIL18BSOCjY5vd1U7lfhf4O718fWTREbW6fmIbyUHaBm5VH3CI5
	/fzwM/3NHYiIKEV1KBjoI2AcxkZYo2eHzKAqRnDVLbjniuIDy8aA2Dr/n37fZw3G
	ftGhcK4RiPXG33WMzjPmqM8m9KMEhpDK+yhv8q9m4fz9SXAsTzlHE3bm5oq5jzLH
	nvV8bLflsVXgl8YRq0KedULzNQyrHwKK2WhEMq5K0NPs4qx1JIcKRZAScay1IC1W
	PM9LFVwp8pYRqWPieHBtXyq6GMg8iXfGRd5O2wXIIv/phesxlw5pOo0z1GY8pBf/
	3yB6NQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jgy8r82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:08:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53PB8mcW002623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 11:08:48 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 25 Apr
 2025 04:08:46 -0700
Message-ID: <dee649f1-0516-4a59-a70d-ba206388e568@quicinc.com>
Date: Fri, 25 Apr 2025 19:08:44 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath11k: Fix MHI target memory reuse logic
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        <jeff.johnson@oss.qualcomm.com>, Jeff Johnson <jjohnson@kernel.org>
CC: <kernel@collabora.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250425110424.2530460-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250425110424.2530460-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MCBTYWx0ZWRfXz4BX1ZSm63PK CI54WtsYPBwnkQyE6/0x9AQ6taMFnSHc9w8X3+4N0Azob+TJ5t8lrE/OiI/hfeKzHOcCz+4pf3o N0AISNJHnPgUTLKQuW5Y8UWleATf9RmMuYPIU7F/e8/xbWYBV9nWiBvQMTkSfrGRl/Cn4S7pkrt
 +q6A08dt3f/8Kad9qvykD3lnVVD62pYmQZFN35r/s2XZCpKQHYGEvLmyE1FgzgaCOi/f/JnTHfp iyI3YPjk2FrS1RCbYFYs3prpJjZso99tkQEjOPBLsYUO87u5VRm1qmZqMQoAi7IPKz/y3rLVouq puBiIVTVN4E9hIG/kPAGWRRR/PswhUco8GsXHBd2Ln/Gkm8e4+2BYHZQC+DL2FEDmqNCA9c9pfK
 dfdwYoRVGkzmoGJOTPvhvU++zbWs1YRAhzHnhkxqfZXorMe7jkXvDHqsHzunGG4j9wUd34Yr
X-Proofpoint-GUID: 253i4z1cxlQ47EO0lmaGkPUHhyZN4vzB
X-Proofpoint-ORIG-GUID: 253i4z1cxlQ47EO0lmaGkPUHhyZN4vzB
X-Authority-Analysis: v=2.4 cv=M5VNKzws c=1 sm=1 tr=0 ts=680b6d41 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=QX4gbG5DAAAA:8 a=COk6AnOGAAAA:8 a=V4x8pWjM2KRL0iEsFYkA:9
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250080



On 4/25/2025 7:04 PM, Muhammad Usama Anjum wrote:
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
> - Update description
> 
> Changes since v3:
> - Update description
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

LGTM

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>

