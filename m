Return-Path: <linux-wireless+bounces-6863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2008B27CC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67609B25A11
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573ED14D6FF;
	Thu, 25 Apr 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KVJvG2bX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424614E2F8
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714067842; cv=none; b=hI0MlOXm+eFOT+qN1OpdWy3gMpsJpHMXaLa5WNMCTm2ekz7ZIo8FUAw9om7MlBDwcDoaX9mETLFo3HQ1zF6H94ufL38JSsKdfCZ4dKQMK7UuxHxLiBpP+AHtFbRsgR40Q11xNSJAsM4bMCZVrWMIaKMxOM+2FVRAnE9mvUIRQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714067842; c=relaxed/simple;
	bh=yP3NXqiXLKqqkchP6z5KLC2/t/iNdwPAqAM67wyOiSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DLwwW0XpIjV2QVhEeOsjexaIilfHLsgiFClzFJ4LUxxxStWMPsdr/QABKOIhEhmEIt/5gqb9gnWxloUZ0Gq3KRll4fEbB1BnI2LhQsUZ+Httid76UfmpmuWgnHaKzown4sf5qZEsJ2a0t4aUjvtTErK38V7zkZ7pceHyvRbnM2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KVJvG2bX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PHeSDW006700;
	Thu, 25 Apr 2024 17:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4z+i16tb1w1joqomF4K9UzWB6xzxlER0TJF55Sxn78U=; b=KV
	JvG2bXlQlkXe0jgX2/G2aRwDf8wFvpFjRZReog23FXZrn95DfvlFVlQZ06y5KXfi
	ztlBXu5ZZvvWPr7DDC04X/hABN/d6JJA5OAIHhDqgD5aig0qcreMc2+x4/oTrYoz
	QHEcjaPD4hnJ4ames2Y/xvebWEr68ynBCXBZxmmjkqgMa9+Wuf7+lkblPuEBbmFa
	tpGONvd7m8faPME4Pf4y/8qKTfc37Q94b48TIeeIqDm5nRtRFiXixVYNiaF/nNRD
	O7UoR/t9Eszhshhj1++RyTl1xcBFwsM6/H2wVFimT/V68i7Q7TshHV90DOrMSuM5
	JimjvoIq/8IUFfhuqqiQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqqtf0qe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:57:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PHvFNf017618
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 17:57:15 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 10:57:15 -0700
Message-ID: <7a30952b-c3a0-4fbf-97f2-035ed438bb54@quicinc.com>
Date: Thu, 25 Apr 2024 10:57:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/6] wifi: ath12k: refactor smps configuration
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
 <20240424191141.32549-6-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240424191141.32549-6-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hLamDC8yASjV1CnebK40NXjkFkUYfCNQ
X-Proofpoint-ORIG-GUID: hLamDC8yASjV1CnebK40NXjkFkUYfCNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404250130

On 4/24/2024 12:11 PM, Pradeep Kumar Chitrapu wrote:
> Move fetching smps value to a new function and use u16_get_bits

v2 comment not addressed:
s/smps/SMPS/ here and in the next line

> to extract smps value from capabilities. This will help in
> extending the functionality when SMPS support in 6 GHz band gets
> added in subsequent patches.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 32 ++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 8836dc67f7e0..65688e55c285 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -2086,18 +2086,29 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
>  				     ampdu_factor)) - 1;
>  }
>  
> +static inline int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,

v2 comment not addressed:
remove inline

> +					    int *smps)
> +{
> +	if (!ht_cap->ht_supported)
> +		return -EOPNOTSUPP;
> +
> +	*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
> +
> +	if (*smps >= ARRAY_SIZE(ath12k_smps_map))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
>  				     struct ath12k_wmi_peer_assoc_arg *arg)
>  {
>  	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
>  	int smps;
>  
> -	if (!ht_cap->ht_supported)
> +	if (ath12k_get_smps_from_capa(ht_cap, &smps))
>  		return;
>  
> -	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
> -	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
> -
>  	switch (smps) {
>  	case WLAN_HT_CAP_SM_PS_STATIC:
>  		arg->static_mimops_flag = true;
> @@ -2571,16 +2582,11 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
>  				  const u8 *addr,
>  				  const struct ieee80211_sta_ht_cap *ht_cap)
>  {
> -	int smps;
> +	int smps, ret = 0;
>  
> -	if (!ht_cap->ht_supported)
> -		return 0;
> -
> -	smps = ht_cap->cap & IEEE80211_HT_CAP_SM_PS;
> -	smps >>= IEEE80211_HT_CAP_SM_PS_SHIFT;
> -
> -	if (smps >= ARRAY_SIZE(ath12k_smps_map))
> -		return -EINVAL;
> +	ret = ath12k_get_smps_from_capa(ht_cap, &smps);
> +	if (ret < 0)
> +		return ret;
>  
>  	return ath12k_wmi_set_peer_param(ar, addr, arvif->vdev_id,
>  					 WMI_PEER_MIMO_PS_STATE,


