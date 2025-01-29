Return-Path: <linux-wireless+bounces-18100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15501A21757
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 06:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502651888E90
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 05:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E4EEAF6;
	Wed, 29 Jan 2025 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eHATckdQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91957FD
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738128086; cv=none; b=UEILrOaftd0apXdk/2iPMbl9GI2xVnkxkxEiWdGsdEUrJEONzNLLZ1nTjx7Q4Igbd7DUGANVMdd43m/d6yNNggNOmHp/4bjiQ4YmKG5j6PA7z1qJrrZ8fIvrGSJmxc/FS3gTM/PzTwxEK1G4109SaCA1XBg9k6n+YBy2VVBACqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738128086; c=relaxed/simple;
	bh=GMSRvFz5LGr0QHxv/qSfRbvUl+ICTakZjShmvPIWcEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hYIJWOYyLm43rXiblziWn4WUyI0/RfgES+H2SZQXmDSiaonW6iSThDLy27Iq5E576is6qBSM77XHcE0qOUK8Zl9Ii1x7BB6ToClCtF7+xTIiW1QyJlss2lPCHM8SYQOCUy7Y6v8sqWQDzJIDtNdI56WCXoeyS8pXqjaYHuJwLv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eHATckdQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T2hTvZ021198;
	Wed, 29 Jan 2025 05:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PN3t4ICONZDRDV54eH4uyvDuwLwSMYI8MBgZy+50YFY=; b=eHATckdQQPG5tlv5
	5CrjsqupHu+dmvr9ElyCnuXoyECaaYaJMYLYcKI9Qr/Gm2JMfeCngEpxQrjT+dl+
	kzey/WpjZk73n7cGAY3CU4Y9ojxspYgZSEnPvgu1qcxRm7vYGyUWQyQEjrhP3EuN
	HbEZSTgA0HQAIou+28sd3uPHdPufmegMVYZHkJnrCQZXO29JDh2RddlFnOfFpLDQ
	CQj8u/FPa5vUqignZQXujkNKrB1ofGx/9TeffGOCmvMFyCMbkLMLUzeQ1yTb938r
	uGqE8PXMBsJWDBQsqAyd6EV0eabHHndQa/hTg7Pot1yk6PY5C/Ica+5sP3U0CPsR
	1iuAjQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f7xfgjrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:21:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T5LJqc023940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:21:20 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 21:21:18 -0800
Message-ID: <35fcc2d4-519b-8f71-c722-7aceea590b0e@quicinc.com>
Date: Wed, 29 Jan 2025 10:51:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/9] wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV
 parsing support
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
 <20250127104738.4174862-2-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127104738.4174862-2-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NRFuNPixwBMj-Biee0swBVHQi4ok5j3-
X-Proofpoint-GUID: NRFuNPixwBMj-Biee0swBVHQi4ok5j3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501290042



On 1/27/2025 4:17 PM, Karthikeyan Periyasamy wrote:
> Currently, monitor is not enabled. However, in the future, the monitor
> will be enabled. Therefore, add the necessary HAL_PHYRX_GENERIC_U_SIG TLV
> parsing support in monitor Rx path, which help to populate the EHT
> radiotap data.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 211 ++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/hal_rx.h |  60 +++++++
>   2 files changed, 270 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 4e9a60181c06..4c8fe1b65fda 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -10,6 +10,9 @@
>   #include "dp_tx.h"
>   #include "peer.h"
>   
> +#define ATH12K_LE32_DEC_ENC(value, dec_bits, enc_bits)	\
> +		u32_encode_bits(le32_get_bits(value, dec_bits), enc_bits)
> +
>   static void
>   ath12k_dp_mon_rx_handle_ofdma_info(const struct hal_rx_ppdu_end_user_stats *ppdu_end_user,
>   				   struct hal_rx_user_status *rx_user_status)
> @@ -562,6 +565,193 @@ static void ath12k_dp_mon_parse_he_sig_su(const struct hal_rx_he_sig_a_su_info *
>   	ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_SU;
>   }
>   
> +static enum hal_rx_mon_status
> +ath12k_dp_mon_hal_rx_parse_u_sig_cmn(const struct hal_mon_usig_cmn *cmn,
> +				     struct hal_rx_mon_ppdu_info *ppdu_info)
> +{
> +	u32 common;
> +	u8 bw;
> +
> +	bw = le32_get_bits(cmn->info0, HAL_RX_USIG_CMN_INFO0_BW);
> +
> +	common = __le32_to_cpu(ppdu_info->usig.common);
> +	common |= IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER_KNOWN |
> +		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN |
> +		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL_KNOWN |
> +		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR_KNOWN |
> +		  IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP_KNOWN |
> +		  ATH12K_LE32_DEC_ENC(cmn->info0,
> +				      HAL_RX_USIG_CMN_INFO0_PHY_VERSION,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_PHY_VER) |
> +		  u32_encode_bits(bw, IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW) |
> +		  ATH12K_LE32_DEC_ENC(cmn->info0,
> +				      HAL_RX_USIG_CMN_INFO0_UL_DL,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_UL_DL) |
> +		  ATH12K_LE32_DEC_ENC(cmn->info0,
> +				      HAL_RX_USIG_CMN_INFO0_BSS_COLOR,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_BSS_COLOR) |
> +		  ATH12K_LE32_DEC_ENC(cmn->info0,
> +				      HAL_RX_USIG_CMN_INFO0_TXOP,
> +				      IEEE80211_RADIOTAP_EHT_USIG_COMMON_TXOP);
> +	ppdu_info->usig.common = cpu_to_le32(common);
> +
> +	switch (bw) {
> +	default:
> +		fallthrough;
> +	case HAL_EHT_BW_20:
> +		ppdu_info->bw = HAL_RX_BW_20MHZ;
> +		break;
> +	case HAL_EHT_BW_40:
> +		ppdu_info->bw = HAL_RX_BW_40MHZ;
> +		break;
> +	case HAL_EHT_BW_80:
> +		ppdu_info->bw = HAL_RX_BW_80MHZ;
> +		break;
> +	case HAL_EHT_BW_160:
> +		ppdu_info->bw = HAL_RX_BW_160MHZ;
> +		break;
> +	case HAL_EHT_BW_320_1:
> +	case HAL_EHT_BW_320_2:
> +		ppdu_info->bw = HAL_RX_BW_320MHZ;
> +		break;
> +	}
> +
> +	return HAL_TLV_STATUS_PPDU_NOT_DONE;

Return code for this function and the below ones dont seem
to have a real use in the callers. May be these can be made
void instead?

Vasanth

