Return-Path: <linux-wireless+bounces-22175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8FBAA0169
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA054670E3
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 04:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDDF4409;
	Tue, 29 Apr 2025 04:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Muiw8bBw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5B2222A2
	for <linux-wireless@vger.kernel.org>; Tue, 29 Apr 2025 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745901480; cv=none; b=P6HLll9iwtuF7rbHc13F+NkOa1Q5xJ9D0ePbYVhnFU4+xX8BSw3FH/bM/JURoU0q9pZbR6rc0CSNpPncnVEaqmR3uIW2CuM9Ho6giaK5eISftAqfxGehAx+z9M5NMoitV8PbPWYI7XbLWluUVEXdsvpndoEq20Zu8+AJqwEhXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745901480; c=relaxed/simple;
	bh=ZLqubQtiYO3l2hrdWYcaAn1BdkAUFPg6Hz4c04Uw5Ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LpXE4f89fSba5P78JQMe3o3G3DBFYu+WTHEQOde8kucwKmIdJt1Wt4UYvicVteeAUWYM0Ruq7cQiTAY5raW4kcVCeymrwPIYbVfGrN9ElgWbBLgBQxk9B8lc809V/u/5g215JIuAObFEV1Jo8pn8dUin3JJqpmJLZLmttW/WYqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Muiw8bBw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SNqAV6013029;
	Tue, 29 Apr 2025 04:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AgxAh8ngai196lIsRMjynDeiT0inYH+VGZBuNyAHtd0=; b=Muiw8bBwH4k1rE4S
	CeGfJxoeo3Efmbis6pZ1YZmWRoJ7kO0hpyuN18jynxq0uPVNUljE0IOZAEHX0UFa
	KIN548AXTXDrlXl2QfOWDvaenakEXbkv75JIxAoCkCOLSTYg0uVHZMe51J/fsh4F
	Mr40lkj9frfd9qXAgCCWuGIRU25ttB9NASnYl7+BTxXXUWkmNzTMBwxRfW7rj4lT
	p0xp6yJ7gNdo1H4bfrHyqwF2dW7wBbDeiczOudExBVX3GlLk4yDzXJK0ACmKqwm8
	27/Yk+JiVpfPkLXl1iVIX3+VhuFHo13pcInyXX+tWkz9g+kKXTbgstXZPhLTonzQ
	Ufggew==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468rnn2528-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:37:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53T4btU9005386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 04:37:55 GMT
Received: from [10.216.24.29] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 28 Apr
 2025 21:37:53 -0700
Message-ID: <c34320c3-84ab-47a4-b2bf-9cb68efc1c09@quicinc.com>
Date: Tue, 29 Apr 2025 10:07:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix invalid RSSI values in station
 dump
To: Sowjanya vardhineni <quic_svardhin@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <praneesh.p@oss.qualcomm.com>
References: <20250424055104.2503723-1-quic_svardhin@quicinc.com>
From: Mahendran P <quic_mahep@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250424055104.2503723-1-quic_svardhin@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2mxb1CTQy-78sdLD27lnW_Pu8_Y4Alrm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDAzMyBTYWx0ZWRfXzEK+0tYGNwie gNXqtxyMf2LhtOF+x++FDWf8cxEDn261xCwnO9fBT/FzWJHGhhXuO7LuC3rYFxsRLMdFDpMqi5X hJU8+F6gQ1iDJiRj3VmeWoWcpDMzW3TarhstM1uiadLoAJs+2n2AbkVQRPTuCkL0ITgY4BwL/Nm
 1B/NiTgm3988tFF+a5whsDF89UqxdbJ2nmz0l67jdGOedZoGiGzh5VOj/p6l3h23bEI0kBx8KSM stVEJZniJU/fncQHIXTCuVlQhSo+VsfyZ16sKj+d4/C8G54IzuxCbjEiBA6U1WJ7n1MmfARIfHU +BFYKn48L/Lu6c5O0Q0wcmHnsCj1mjLEGA31spyB75VkcyG0tSYwXYvpaYIhlFSDrSHJp8p0Yr6
 9Nv3mjU9wSt/Veke0XTCuNyjbYa9369VcXFbeLjOTw1iCSF+7MooLbQZ/MczkcuWROF8OSk2
X-Proofpoint-GUID: 2mxb1CTQy-78sdLD27lnW_Pu8_Y4Alrm
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=681057a3 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=K6L4iRK0gKkcvzKg9_MA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290033

On 4/24/2025 11:21 AM, Sowjanya vardhineni wrote:
> From: P Praneesh <praneesh.p@oss.qualcomm.com>
> 
> When processing a "station dump" command, the driver retrieves RSSI
> values from the HAL_PHYRX_RSSI_LEGACY TLV received from the monitor
> destination ring, and reports them to userspace. Currently, the RSSI
> values reported are improper because the hardware has not been
> configured to update them properly.
> 
> To fix this, enable the HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO in
> the filter setup to ensure the correct RSSI values are returned in the
> HAL_PHYRX_RSSI_LEGACY TLV, resulting in correct RSSI values being
> reported to userspace.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
> Signed-off-by: Sowjanya vardhineni <quic_svardhin@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index b19e30d95560..fa952f6ca4a3 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -229,7 +229,8 @@ ath12k_phymodes[NUM_NL80211_BANDS][ATH12K_CHAN_WIDTH_NUM] = {
>  const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default = {
>  	.rx_filter = HTT_RX_FILTER_TLV_FLAGS_MPDU_START |
>  		     HTT_RX_FILTER_TLV_FLAGS_PPDU_END |
> -		     HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE,
> +		     HTT_RX_FILTER_TLV_FLAGS_PPDU_END_STATUS_DONE |
> +		     HTT_RX_FILTER_TLV_FLAGS_PPDU_START_USER_INFO,
>  	.pkt_filter_flags0 = HTT_RX_FP_MGMT_FILTER_FLAGS0,
>  	.pkt_filter_flags1 = HTT_RX_FP_MGMT_FILTER_FLAGS1,
>  	.pkt_filter_flags2 = HTT_RX_FP_CTRL_FILTER_FLASG2,
> 
> base-commit: 12b93f7c6d101d22e0ea3bf4a240699746c79117

Reviewed-by: Mahendran P <quic_mahep@quicinc.com>


