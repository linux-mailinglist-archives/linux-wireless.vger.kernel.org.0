Return-Path: <linux-wireless+bounces-5264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E4A88B8C4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 04:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 693F82E5F68
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850FC12AAD8;
	Tue, 26 Mar 2024 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YqHKZ3A+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6E12AADF
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 03:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711424291; cv=none; b=lvqi1uqlmcmtEbrjNwx/ccnVtzbS2lDEvvJ0ionFpe9pcgtRlebqAwi9Wt3OPVcOqbvxAFEdMcS3z8oXztv/gAUFN1M6NE1qE7rQ2/pltX5BSGbsfS7fdYOrEcWUdCeRM8GvttzeGR7ihSofN1UvB67pLMFZytQneifVr2KBA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711424291; c=relaxed/simple;
	bh=Zxls1TcI1LsdMwwgGgWZCnHP28qIHVuDU46sievUYmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kg2RY2sAPfVa379nttrAqpWt6MtdjN6LcjTIM21pA7TzKTh3outqcL4TnXKVX2nfTQNeUxchmb1L2g/AWesn+CXk8tRN9f8y4+QXSPePgmep/kh/mr4Yx171L5QXsFMFzPderQlyb876jiVMlMOJ2Kx19ROKtzRBV4GHEqjIL2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YqHKZ3A+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42Q0imm3018627;
	Tue, 26 Mar 2024 03:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xIIVpALjKfPAp3IHw9+JqrhpaJ5ITT3AQMaqHQwG/sY=; b=Yq
	HKZ3A+nHU1Y7rl/nQGgPcGbUnN79XEdDAFo24R7mjpxHAE8wZDgufLOEdmDvuxwn
	2La+Q0JNWPLWPwCLcxzUYIPxfZf2Zo7IAJrnN2qlhMRUt/BF38ATH2wv1e3uutFD
	/mOckC8MKOeOxPSII+uQQCMjIpOnrV2LxAwE7142xij8rUH26mAYgHgQvrwz1qbf
	x920H/4HEe5We7POJ9Y3y6NImuDfoqQA41FpXtzgYfaPOUnl5SjZw3hn0VSp85e/
	nLnZ/T237cKUommBvI4jmIH/5PIn943OWc8Ts6yW/kKzuxuzCCeiTt7Y7FhTccYq
	po/AaeegFJSEiu+MmTbQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3huu0fdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 03:38:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42Q3c42S025780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 03:38:04 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 20:38:03 -0700
Message-ID: <2c7739bd-09d4-4e0d-ab8c-32e8d2d030b8@quicinc.com>
Date: Tue, 26 Mar 2024 11:38:00 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] wifi: ath12k: support SMPS configuration for 6 GHz
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
 <20240325212304.28241-7-quic_pradeepc@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240325212304.28241-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Htyx8h88Iohc9RSPAZX4pR-oZYleVa5H
X-Proofpoint-ORIG-GUID: Htyx8h88Iohc9RSPAZX4pR-oZYleVa5H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_01,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260022



On 3/26/2024 5:23 AM, Pradeep Kumar Chitrapu wrote:
> Parse SMPS configuration from IEs and configure. Without this,
> SMPS is not enabled for 6 GHz band.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index b4114dd22bf0..433b8be74997 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1964,12 +1964,17 @@ static void ath12k_peer_assoc_h_he_6ghz(struct ath12k *ar,
>   }
>   
>   static inline int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *ht_cap,
> +					    const struct ieee80211_he_6ghz_capa *he_6ghz_capa,
>   					    int *smps)
>   {
> -	if (!ht_cap->ht_supported)
> +	if (!ht_cap->ht_supported && !he_6ghz_capa->capa)
>   		return -EOPNOTSUPP;
>   
> -	*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
> +	if (ht_cap->ht_supported)
> +		*smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
> +	else
> +		*smps = le16_get_bits(he_6ghz_capa->capa,
> +				      IEEE80211_HE_6GHZ_CAP_SM_PS);
>   
>   	if (*smps >= ARRAY_SIZE(ath12k_smps_map))
>   		return -EINVAL;
> @@ -1980,10 +1985,11 @@ static inline int ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *h
>   static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
>   				     struct ath12k_wmi_peer_assoc_arg *arg)
>   {
> +	const struct ieee80211_he_6ghz_capa *he_6ghz_capa = &sta->deflink.he_6ghz_capa;
>   	const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
>   	int smps;
>   
> -	if (ath12k_get_smps_from_capa(ht_cap, &smps))
> +	if (ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps))
>   		return;
>   
>   	switch (smps) {
> @@ -2457,11 +2463,12 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
>   
>   static int ath12k_setup_peer_smps(struct ath12k *ar, struct ath12k_vif *arvif,
>   				  const u8 *addr,
> -				  const struct ieee80211_sta_ht_cap *ht_cap)
> +				  const struct ieee80211_sta_ht_cap *ht_cap,
> +				  const struct ieee80211_he_6ghz_capa *he_6ghz_capa)
>   {
>   	int smps, ret = 0;
>   
> -	ret = ath12k_get_smps_from_capa(ht_cap, &smps);
> +	ret = ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -2514,7 +2521,8 @@ static void ath12k_bss_assoc(struct ath12k *ar,
>   	}
>   
>   	ret = ath12k_setup_peer_smps(ar, arvif, bss_conf->bssid,
> -				     &ap_sta->deflink.ht_cap);
> +				     &ap_sta->deflink.ht_cap,
> +				     &ap_sta->deflink.he_6ghz_capa);
>   	if (ret) {
>   		ath12k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
>   			    arvif->vdev_id, ret);
> @@ -3677,7 +3685,8 @@ static int ath12k_station_assoc(struct ath12k *ar,
>   		return 0;
>   
>   	ret = ath12k_setup_peer_smps(ar, arvif, sta->addr,
> -				     &sta->deflink.ht_cap);
> +				     &sta->deflink.ht_cap,
> +				     &sta->deflink.he_6ghz_capa);
>   	if (ret) {
>   		ath12k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: %d\n",
>   			    arvif->vdev_id, ret);
> @@ -8104,7 +8113,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>   	 * for each band for a dual band capable radio. It will be tricky to
>   	 * handle it when the ht capability different for each band.
>   	 */
> -	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)
> +	if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)
WCN7850 supports 6 GHz but it does not support feature 
NL80211_FEATURE_DYNAMIC_SMPS. Enabling this for WCN7850 can lead to 
MU-MIMO test failures.

>   		wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
>   
>   	wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;

