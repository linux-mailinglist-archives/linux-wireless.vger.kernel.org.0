Return-Path: <linux-wireless+bounces-24451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7741AE7484
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 03:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310787AD933
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 01:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BAA197A76;
	Wed, 25 Jun 2025 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NnaWeI6Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6670813;
	Wed, 25 Jun 2025 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816442; cv=none; b=nvk4FDFLLOIWMlQdLwTkr6Z5GE3Ojzv3q1yPb8IIIWrJSohy2i2X+CAswJCvhVS49x0AnzIemqS1fe2oUHpmp7Sq8aQEXhb5JVz2Ipmz6tpFxyxP2mfDEPpkicUVAOUa89izT30hyhat2/cCHW+SBR8h4KvMQwDfJHujm0j/f2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816442; c=relaxed/simple;
	bh=HswP0ElbMRQq7lm+j1gU2NsVBFngbaAOTOYfFV7/BOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rACm9TcwqLThrKOVuulYipDM7sR1/SHKv5uk5r303hWF1KiAAD1eBxgOvuRFjVuduJKwJKOGZU/vN9W1ls1N8q47IFj+pmiZVsb1Q8noaljBiRdJJl3rvIKiZlhGCWcirmxDV+BjGptYHLIBWYj/GudLF2zptLdSo7A1BYsNmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NnaWeI6Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFhLV1021010;
	Wed, 25 Jun 2025 01:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KcIRdC0ggL2+IzhQozZShGTOy+MPRgfU0woMX8YlWZ4=; b=NnaWeI6ZhIjDiNzR
	eeqeUszQvET8taB6qVSefAL3shzjOHjL1xpKlTeSYdillU3brmS/u+4yM367abRR
	Pv3DE0CEjkLsXixnlHmMOvizET1yRW8igaROTTvSgPRCf4AhzuDbWdoasFxsjhfF
	ENx20peyT8b8elmxxFjWUVqJjFDi73VtCclVnnEngTSCAGMMTTsauGbaeDmO2KGp
	AjcDvE0/zXw13YQBqFIBpEc7NYIQqHV3V+ZECPl2MCMjwinUXfW7XW2JGiOL7CRB
	27JGG5LmJM2F1niXBHPhJuxM/bbK+KwHj+bkuH85a1qxYJNa+WiSRk4atU0T0In6
	KZjKRA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfwvcsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 01:53:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P1rqfb005547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 01:53:53 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Jun
 2025 18:53:51 -0700
Message-ID: <4503f964-f2e1-42ff-a263-613f340f9a7c@quicinc.com>
Date: Wed, 25 Jun 2025 09:53:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] wifi: ath12k: use plain access for descriptor
 length
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Remi Pommarel
	<repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250617084402.14475-1-johan+linaro@kernel.org>
 <20250617084402.14475-3-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250617084402.14475-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wsb-wvDVf5_SKpyghEr1H0CKDFB8wp2i
X-Proofpoint-ORIG-GUID: wsb-wvDVf5_SKpyghEr1H0CKDFB8wp2i
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685b56b2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=DtruAg4B5Pfe8s7-AC8A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAxMyBTYWx0ZWRfX5d1Vmo8kkxcT
 bmw7Z02yB03Ri7b0p55cY4ptYMlQzyZhP452M+XwN61QJYGFkfqxEI0fNCFgx7PUDMv39TWiSTO
 RSKfnJ1VOel7uoy7ZXOsiuN0tc69EHYzYIva5kVY6T1oPf/EwpkYpZTIm+FxOG0hn6UzIi1nGeT
 8gR5+4vNrO75FUr8JaVP47CJJZS+hAk241+8CYQZFJtaIvvum0dKRLGm2MG1Erc++i4k+z9tZ01
 cQXdChgQR1u5Jagx2QxelFdoYiW5nDwgyHOAK0j33JGqhToojrpQix3dJR3Kf1S/WwFjRoqMctv
 5eqrJhk+PBstTnAWF1RRWXUUTHQyZcqpF4lPc1n9FH92DtAMBM3wHjh+uXAMPXOh44Nra0/c92k
 8/0A8fLuSqtyKEOB4TEbAF3ObnkryJ5mVd56FTGUr+dBzxxAQbqjPRieBQoqEnDRkT2NkL7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=735 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250013



On 6/17/2025 4:44 PM, Johan Hovold wrote:
> The read memory barrier added by commit 6b67d2cf14ea ("wifi: ath12k: fix
> ring-buffer corruption") is enough to guarantee ordering also for plain
> descriptor accesses if the length helper is ever inlined so drop the
> unnecessary READ_ONCE().
> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath12k/hal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index f8bd3837b9dc..726969cfcaec 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -1950,7 +1950,7 @@ u32 ath12k_hal_ce_dst_status_get_length(struct hal_ce_srng_dst_status_desc *desc
>  {
>  	u32 len;
>  
> -	len = le32_get_bits(READ_ONCE(desc->flags), HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
> +	len = le32_get_bits(desc->flags, HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
>  	desc->flags &= ~cpu_to_le32(HAL_CE_DST_STATUS_DESC_FLAGS_LEN);
>  
>  	return len;


Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>



