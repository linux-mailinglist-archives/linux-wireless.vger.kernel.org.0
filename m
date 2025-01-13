Return-Path: <linux-wireless+bounces-17405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2000BA0B0DF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 09:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375C31664F4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625523236F;
	Mon, 13 Jan 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PNvoNLtK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43817231A56
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756427; cv=none; b=px6851KmRTl82kpPF8DSmD0GmgAuSqGwH4OD/RJjrt6S0XzwJD5rPVcA8cE//s7HHpKzQoV2Td3H68hzsVXm3DdtaeyjTBoerpvyf5cfCcc+5Py2c4o4cFOzWUZDw8XyK82cclzKJ/dVquZVgTZ9T2clAAYSN+XR5NyBWZirLCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756427; c=relaxed/simple;
	bh=4jivD9s+nUERHd5KduF43qTNKrTAGfwE+qicaE3vTTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tTwTODCcY7puQzsTAqewM5acFTkJQcoC/HjF5vfIDGaBWUP8Hy9DQ7fGl+klAK8zUD03gXZXt0GNRIgjgesFm56CO5upBQE5LBMC9eHQDjUmrx1eODrKDfRysoJn2gxmgLav+Ka+8oBJyjJ3Pv6FNiNras5/wzyJglLW62rx1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PNvoNLtK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D7Mfdx019858;
	Mon, 13 Jan 2025 08:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TiSVq6vsAjU/Q5LI/ww3idU0nznsZ12WrbEFhTwKU9s=; b=PNvoNLtKGe/nEXKy
	cHLASobPtnvN2GyQ7UgmF3vCazhngmhv2t7gKpVYbrT0JaW7fGeT48ElAYu0MOHb
	ws4iF2YPrGDGDAiYqqCXt6cuZutXJrgtkW/jVtVxnqrULZgn1mKsynYZAi/xWUzn
	XFNwBT1FwmEawn2FQDLQMvA0ToA2myE54q+3Z103D6vPoSWhuYo5kSJOP4sA8DiQ
	DFUnsS5sfio7dlB4D2motOkx9OF9IXIJvIhSnr9CbnqXGo9M2j0A62G02odpS4HQ
	7RiRW3s+j5HK9s1BWntmRERdefUF/IMpx4pDSc5USK/Dq4nLeQnu9bk2zs/mPmh5
	rWhIIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 444xcxr4cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 08:20:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50D8KJw3010721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 08:20:19 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 Jan
 2025 00:20:17 -0800
Message-ID: <1e1b5159-3f4f-4876-9e31-11a1f5b3584c@quicinc.com>
Date: Mon, 13 Jan 2025 13:50:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] wifi: ath12k: Add API to print s8 arrays in HTT
 stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250113071144.3397293-1-quic_rdevanat@quicinc.com>
 <20250113071144.3397293-5-quic_rdevanat@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20250113071144.3397293-5-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Zm5Tz-mIyKWo4jbRv0PdfqXbKlLaEc_G
X-Proofpoint-GUID: Zm5Tz-mIyKWo4jbRv0PdfqXbKlLaEc_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=861
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130070

On 1/13/25 12:41, Roopni Devanathan wrote:
> Currently, print_array_to_buf() is used to print arrays to HTT
> stats buffer. This function supports printing only arrays with
> 32-bit unsigned integers. Add print_array_to_buf_s8(), which
> implements print_array_to_buf()'s functionality to all the
> arrays with 8-bit signed integers.
> 
> Sample output:
> rx_ul_mumimo_target_rssi: user_0  =  0:-128, 1:-128, 2:-128, 3:-128
> rx_ul_mumimo_target_rssi: user_1  =  0:-128, 1:-128, 2:-128, 3:-128
> rx_ul_mumimo_target_rssi: user_2  =  0:-128, 1:-128, 2:-128, 3:-128
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 77c51269669f..92935134735a 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -48,6 +48,34 @@ print_array_to_buf(u8 *buf, u32 offset, const char *header,
>   					footer);
>   }
>   
> +static u32
> +print_array_to_buf_s8(u8 *buf, u32 offset, const char *header, u32 stats_index,
> +		      const s8 *array, u32 array_len, const char *footer)


Who is the user of this new function? I don't see it called from
anywhere. At least have 1 caller to it in this patch?

Or else this patch fails to compile with W=1

drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:52:1: error: 'print_array_to_buf_s8' defined but not used [-Werror=unused-function]
52 | print_array_to_buf_s8(u8 *buf, u32 offset, const char *header, u32 stats_index,
| ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

-- 
Aditya

