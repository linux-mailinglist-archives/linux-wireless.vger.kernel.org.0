Return-Path: <linux-wireless+bounces-5619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E165D89233C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 19:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC481F2249C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597F38565D;
	Fri, 29 Mar 2024 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MGXxKrLM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A541206
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736451; cv=none; b=Nd32I06e31gbjIkjDQ9NH5/AlninfH1S6YIBUn2gfUz0AOp6F8923oqqbdQo5061EVdaMNFPoUkM23OssYmYcGd4Ee+PFIB/jPqnv2/VjmR6dQKUoEvla0GgyHeNpLVPjNweX+MX2p8aAeFooD+enD0zRU+Cwdh9nFtZd3PArds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736451; c=relaxed/simple;
	bh=boFoSsVM2rVyX1CYu9KgTui1U/h24BvBeCzVUIc+77E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E8+UXtycqn+DjHz9lz9USFhuWQL78twkBNfF8MkVaccODZt1rRalAOkCmemu7rKPWfc/BtOnPAydWHkVNlxVPnq35WiVpcXhiheiHHbjHR7z+NcbObr16eGv97cZ05GDdi8RpIa2OFOnHcX5x1TQivjJWThrE02qO/2PTgqQenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MGXxKrLM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THfAia007617;
	Fri, 29 Mar 2024 18:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BGIi56S4cHYx60VIaqFluzUsNJwImiynIgSRpvsBCX4=; b=MG
	XxKrLMNk9ocWx8ojYQLiPdRqK/mgJrITrePG0CP36+Puex1xfOi0fBv+Rgeu42CW
	dIt2IMEtsKTze30ywUqa9fBMJV3YsZna90JwroD5OWx70PeLngiFeCFjclkWV13a
	e4GjSMOu7bOahL6vJ56djK7s9QYlRojuBjq/xyHvoI2v9mzMp7kkxtrmXLuZ2ddH
	tx8UqTvyZebCkYXAhQ5DUc0XlwvGFEm+Qnjjs5VLREFbFshQXB8hkZyJ6ZPA4rVx
	yIc0RewVwWua7Q49B4SbIzOyzPoPEsA1WHd8UscwGx0Zko1drsPC14UZsg58UmLG
	BQ+Wwb2mFLo1/k+HMlvA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5np2a339-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:20:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TIKk46001962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:20:46 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 11:20:46 -0700
Message-ID: <c26cf3e5-16c4-430c-ad9e-be20c10bb570@quicinc.com>
Date: Fri, 29 Mar 2024 11:20:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] wifi: ath12k: refactor smps configuration
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
 <20240329173926.17741-6-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329173926.17741-6-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6cfo8GvaKZRe1osxuOWRzBNR497u9KYm
X-Proofpoint-GUID: 6cfo8GvaKZRe1osxuOWRzBNR497u9KYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290163

On 3/29/2024 10:39 AM, Pradeep Kumar Chitrapu wrote:
> Move fetching smps value to a new function and use u16_get_bits

s/smps/SMPS/ here and in the next line

> to extract smps value from capabilities. This will help in
> extending the functionality when SMPS support in 6 GHz band gets
> added in subsequent patches.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 32 ++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 7e296140439a..b4114dd22bf0 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1963,18 +1963,29 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
>  				     ampdu_factor)) - 1;
>  }
>  
> +static inline int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,

remove inline
since it is static the compiler will inline it if it makes sense to do so

(doesn't that fix the ath12k-check issue in the 6/6 patch)?

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
> @@ -2448,16 +2459,11 @@ static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
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


