Return-Path: <linux-wireless+bounces-18103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0AA2177E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 06:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0261889414
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336D814F6C;
	Wed, 29 Jan 2025 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gkezIJ3f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D15672
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129626; cv=none; b=QQV3MTCO4nxeiNY1YrrBlfoRNEO4J9Um83+6U9KKyb9SHRefwihypYHpFCoDdtWK2idJeZUVtGOQUX5hQm3pqctLGFZUoTEc8PUp5yLRqfVbpW5zvnRGl/Fsv60tdp2nJauSbW5Shyq4yHJKU/zn56sxfnSg/Pk0lZvJUu3CS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129626; c=relaxed/simple;
	bh=7Cq0EKqXyS0td3bbu0LFOpzyIKf1+2xyzL0Gs1wDd0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mQonmczBv50QVozxG3muM1PaJ0p7QWiRaBPoneoj9sbi0nGn9ru+ss5hcUUb9/yrBMpBlbmLIwKLGXaf3e+SLTLwRPGeMqYsKfAAJ6YoVl4oDGKn8OdTjeN6QBSabaRoWEj1PG78vbknKihfgCBtw/iM0oYMHyXXGHYvPZpsozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gkezIJ3f; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T2h7si008337;
	Wed, 29 Jan 2025 05:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	liOkprOBmA5H1ABBSr6j8stIsrlrNenC/IAPKbzBQZE=; b=gkezIJ3fkWULo8V0
	39c4VWJ+drE0Wdep9KY37d92omDaSp0NnIEtPq2SdzG8DeehFm4X7QyKTjkJ3f9u
	kyNC/nAmJLupBaQbOjeNiI7Vymrq7CaDAFWYMJC9L6C+uQQ+vOGyRmqeQaucazL+
	/M6eiYDch0motBOwXcKKZpiZWz4xMpTxVYtwXBIffV23VONwUxTRlmyDseG14u58
	7hORZE+S0+y5WRNDr+WAN+olnEpfGoRldb7j+wh1VnseuQXmyOekPsJMnqwU0PE5
	WMnc9IRELsi+wKHp72A732j0c+h9jyq5W27nwxKydtEdlw6zXgfJgi+kxH4IzHRY
	X6Jovg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f3qth6bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:47:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T5l1AZ025648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:47:01 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 21:46:59 -0800
Message-ID: <adbb237a-01e8-0e3a-19cf-6a4fe31c0e7f@quicinc.com>
Date: Wed, 29 Jan 2025 11:16:56 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 4/9] wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV
 parsing support
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
 <20250127104738.4174862-5-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127104738.4174862-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JHoKtfRuvA5vYJdlgudNH9rrfFs5RnbK
X-Proofpoint-ORIG-GUID: JHoKtfRuvA5vYJdlgudNH9rrfFs5RnbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290046



On 1/27/2025 4:17 PM, Karthikeyan Periyasamy wrote:
> Currently, monitor is not enabled. However, in the future, the monitor
> will be enabled. Therefore, add the necessary HAL_PHYRX_OTHER_RECEIVE_INFO
> TLV parsing support in the monitor Rx path, which helps to populate the
> extended Rx statistics.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 7 +++++++
>   drivers/net/wireless/ath/ath12k/hal_rx.h | 8 ++++++++
>   2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index f9de8c509061..8ded73d87c73 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -1630,6 +1630,13 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   					     HAL_RX_PHYRX_RSSI_LEGACY_INFO_INFO0_RX_BW);
>   		break;
>   	}
> +	case HAL_PHYRX_OTHER_RECEIVE_INFO: {
> +		const struct hal_phyrx_common_user_info *cmn_usr_info = tlv_data;
> +
> +		ppdu_info->gi = le32_get_bits(cmn_usr_info->info0,
> +					      HAL_RX_PHY_CMN_USER_INFO0_GI);
> +		break;
> +	}
>   	case HAL_RX_PPDU_START_USER_INFO:
>   		ath12k_dp_mon_hal_rx_parse_user_info(tlv_data, userid, ppdu_info);
>   		break;
> diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
> index 765b53741861..445d1c33b41f 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
> @@ -683,6 +683,14 @@ struct hal_rx_resp_req_info {
>   #define HAL_RX_MPDU_ERR_MPDU_LEN		BIT(6)
>   #define HAL_RX_MPDU_ERR_UNENCRYPTED_FRAME	BIT(7)
>   
> +#define HAL_RX_PHY_CMN_USER_INFO0_GI		GENMASK(17, 16)
> +
> +struct hal_phyrx_common_user_info {
> +	__le32 rsvd[2];
> +	__le32 info0;
> +	__le32 rsvd1;
> +} __packed;
> +
>   #define HAL_RX_EHT_SIG_NDP_CMN_INFO0_SPATIAL_REUSE	GENMASK(3, 0)
>   #define HAL_RX_EHT_SIG_NDP_CMN_INFO0_GI_LTF		GENMASK(5, 4)
>   #define HAL_RX_EHT_SIG_NDP_CMN_INFO0_NUM_LTF_SYM	GENMASK(8, 6)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

