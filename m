Return-Path: <linux-wireless+bounces-1839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D5682C55E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 19:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B061C22302
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97D25611;
	Fri, 12 Jan 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f5lzfC3j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D822560A
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CGQuJb010497;
	Fri, 12 Jan 2024 18:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fe4akUkUVyB+kVTkZU4inYl0No9qSEYqBo9dcrH6a8M=; b=f5
	lzfC3j/WuS4xc836JsJ5A9utUya/cvLglCGOOG8hMg9qv7CCxuc2GNIUli5dIPvj
	l4ACCvuBPiNKVKjl7m+9EHBxv0FFNb9aLqYJ9PIfGkDQZ394wCmYdUE+8fEA++Bj
	GzshnDXUQSkYQyGBdZIckCZjDnJ+gZ3qRiiyPUthnC5ImpSCiGkqOE7J6xd3cf8T
	IaFbs3pQqK12EC1wKLQHamhUPFH0v+tngo34ILoyQULKSPMecaHQKyn/Hemnlfl6
	YbT1n6wXxLs9yux1zfkqjN4ncUibvewWrtzWgSY0D4dQ3sDSM24Ho2yhVrwNMzsc
	oohaZcQWYYfhF8NI5Qqg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk43xgx8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 18:25:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40CIPUs0016512
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 18:25:30 GMT
Received: from [10.110.16.29] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 10:25:30 -0800
Message-ID: <bfdf62da-e2f3-4b59-971c-e10349e705f6@quicinc.com>
Date: Fri, 12 Jan 2024 10:25:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] wifi: ath12k: Modify set and get antenna mac ops
 for single wiphy
Content-Language: en-US
To: Sriram R <quic_srirrama@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240111045045.28377-1-quic_srirrama@quicinc.com>
 <20240111045045.28377-11-quic_srirrama@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240111045045.28377-11-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BELvJjw88OR-EtYg1Nh7i8k3Ns_Ro0ij
X-Proofpoint-GUID: BELvJjw88OR-EtYg1Nh7i8k3Ns_Ro0ij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401120143

On 1/10/2024 8:50 PM, Sriram R wrote:
> As multiple radios are combined into a single wiphy, and
> the current infrastructure supports only set/get antenna
> for the wiphy, the max Tx/Rx antenna capability is advertised
> during wiphy register.
> Hence, When antenna set/get is received we adjust the set/get
> based on max radio capability and set/get antenna accordingly.
> 
> Multi radio capability would get introduced with interface

Since this multi-radio capability is not part of the current series, I
don't think it is correct to say this "would get introduced". Rather, I
think it is more appropriate to say it "would need to be introduced in
the future" if you want per-radio configuration

> combination changes to support single wiphy model in cfg80211
> which would help extend the wiphy specific get/set configs similar
> to this to per hw level.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 41 +++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 2f19d6c5b741..00063c783e6c 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5064,6 +5064,13 @@ static int __ath12k_set_antenna(struct ath12k *ar, u32 tx_ant, u32 rx_ant)
>  	if (ath12k_check_chain_mask(ar, rx_ant, false))
>  		return -EINVAL;
>  
> +	/* Since we advertised the max cap of all radios combined during wiphy
> +	 * registration, ensure we don't set the antenna config higher than our
> +	 * limits

*specific radio* limits

> +	 */
> +	tx_ant = min_t(u32, tx_ant, ar->pdev->cap.tx_chain_mask);
> +	rx_ant = min_t(u32, rx_ant, ar->pdev->cap.rx_chain_mask);
> +
>  	ar->cfg_tx_chainmask = tx_ant;
>  	ar->cfg_rx_chainmask = rx_ant;
>  
> @@ -6380,21 +6387,25 @@ static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
>  static int ath12k_mac_op_get_antenna(struct ieee80211_hw *hw, u32 *tx_ant, u32 *rx_ant)
>  {
>  	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	int antennas_rx = 0, antennas_tx = 0;
>  	struct ath12k *ar;
> +	int i;
>  
>  	mutex_lock(&ah->conf_mutex);
>  
>  	ar = ath12k_ah_to_ar(ah, 0);
>  
> -	mutex_lock(&ar->conf_mutex);
> -
> -	*tx_ant = ar->cfg_tx_chainmask;
> -	*rx_ant = ar->cfg_rx_chainmask;
> -
> -	mutex_unlock(&ar->conf_mutex);
> -
> +	for (i = 0; i < ah->num_radio; i++) {
> +		mutex_lock(&ar->conf_mutex);
> +		antennas_rx = max_t(u32, antennas_rx, ar->cfg_rx_chainmask);
> +		antennas_tx = max_t(u32, antennas_tx, ar->cfg_tx_chainmask);
> +		mutex_unlock(&ar->conf_mutex);
> +		ar++;
> +	}
>  	mutex_unlock(&ah->conf_mutex);
>  
> +	*tx_ant = antennas_rx;
> +	*rx_ant = antennas_tx;
>  	return 0;
>  }
>  
> @@ -6402,16 +6413,22 @@ static int ath12k_mac_op_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx
>  {
>  	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
>  	struct ath12k *ar;
> -	int ret;
> +	int ret = 0;
> +	int i;
>  
>  	mutex_lock(&ah->conf_mutex);
>  
>  	ar = ath12k_ah_to_ar(ah, 0);
>  
> -	mutex_lock(&ar->conf_mutex);
> -	ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
> -	mutex_unlock(&ar->conf_mutex);
> -
> +	for (i = 0; i < ah->num_radio; i++) {
> +		mutex_lock(&ar->conf_mutex);
> +		ret = __ath12k_set_antenna(ar, tx_ant, rx_ant);
> +		mutex_unlock(&ar->conf_mutex);
> +		if (ret)
> +			goto out;
> +		ar++;
> +	}
> +out:
>  	mutex_unlock(&ah->conf_mutex);
>  
>  	return ret;
Since I just have documentation nits:

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


