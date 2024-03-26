Return-Path: <linux-wireless+bounces-5289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB21E88CB17
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 18:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2A53244CF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A947D1CD2E;
	Tue, 26 Mar 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lritVc9v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E8A95B
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 17:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474671; cv=none; b=SqnMAYn1GBw7xreva6T9GdPn4mc0oDKYQ/ZF/BsPNYkOlbHaXhW2Pl+v18QJcE6e/iAxLpcR4c2mlU+m6Q5j09MHmRemLvP8eW4BeqdYcnfvaFVdTlcnh8RP1zvBelLzUUuEwAwm3SaHcB5DtPDD+wGerddCBe1YfthcFVEAIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474671; c=relaxed/simple;
	bh=xMzq9iVgaewctc8NkPonTG8yDLV8QoISJYNO81PvofI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ox24dtKzBQYQBzmIoSWUeZ7dNcLg4sE3TAlSFOaMTdDQW3wkTYk6GO2lyfgLdeOhUJzs8ZYrm+lGwXytn+/aJspLdAcjd8Rnb9DLRbnI+QDklzO18cKAJ2uOvnXIta08L0pyKthNdL9nBHpIYeWjcKm+G5kAmDVDMC0J9rpW5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lritVc9v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QCJ5ZY021597;
	Tue, 26 Mar 2024 17:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=YNIpaKlclGRETpF/2f/uhy0oGDE7y2HTiWrsd5QTLt0=; b=lr
	itVc9vZNDp2OBiiztOT7ZPE4QoOuiaCqvGxSJJoDTy/xAR6ovwAz1SYB6EgZoqgh
	PtM/5Rugs2UHrJhLLvw5Nuu6AQimo/+9PBLboMxgMd+h7Xyi81f73FjchLdreGQe
	Xjb23q6O6yRwYWTywcKF32E8sKURa1dNO8ogVNYYgvqLFNXbzAPEmC9bx/YzCH8N
	kTqVPwAFMShE2EBE39bzExKAq0MM2RHL5VB7tIX3TKWteE7w+virXK858A/EkSu/
	W0NT4mvlkKmpRjitP9LyOwUEp9Rcgzr7TLMRZISPYYcgBqhJDxO75ZZX9yF8PqQb
	Mdtk+GsdZsGL8a8IIIvg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3s7n1qcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 17:37:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QHbdXx001633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 17:37:39 GMT
Received: from [10.110.10.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 10:37:39 -0700
Message-ID: <d3b269fa-33c0-44c3-a458-27c1ed943cb0@quicinc.com>
Date: Tue, 26 Mar 2024 10:37:38 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] wifi: ath12k: support SMPS configuration for 6 GHz
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240325212304.28241-1-quic_pradeepc@quicinc.com>
 <20240325212304.28241-7-quic_pradeepc@quicinc.com>
 <2c7739bd-09d4-4e0d-ab8c-32e8d2d030b8@quicinc.com>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <2c7739bd-09d4-4e0d-ab8c-32e8d2d030b8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xplc4_J9yMlU6BoknbjADriau_BoHrdP
X-Proofpoint-ORIG-GUID: Xplc4_J9yMlU6BoknbjADriau_BoHrdP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260125



On 3/25/2024 8:38 PM, Baochen Qiang wrote:
> 
> 
> On 3/26/2024 5:23 AM, Pradeep Kumar Chitrapu wrote:
>> Parse SMPS configuration from IEs and configure. Without this,
>> SMPS is not enabled for 6 GHz band.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 25 +++++++++++++++++--------
>>   1 file changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c 
>> b/drivers/net/wireless/ath/ath12k/mac.c
>> index b4114dd22bf0..433b8be74997 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -1964,12 +1964,17 @@ static void ath12k_peer_assoc_h_he_6ghz(struct 
>> ath12k *ar,
>>   }
>>   static inline int ath12k_get_smps_from_capa(const struct 
>> ieee80211_sta_ht_cap *ht_cap,
>> +                        const struct ieee80211_he_6ghz_capa 
>> *he_6ghz_capa,
>>                           int *smps)
>>   {
>> -    if (!ht_cap->ht_supported)
>> +    if (!ht_cap->ht_supported && !he_6ghz_capa->capa)
>>           return -EOPNOTSUPP;
>> -    *smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
>> +    if (ht_cap->ht_supported)
>> +        *smps = u16_get_bits(ht_cap->cap, IEEE80211_HT_CAP_SM_PS);
>> +    else
>> +        *smps = le16_get_bits(he_6ghz_capa->capa,
>> +                      IEEE80211_HE_6GHZ_CAP_SM_PS);
>>       if (*smps >= ARRAY_SIZE(ath12k_smps_map))
>>           return -EINVAL;
>> @@ -1980,10 +1985,11 @@ static inline int 
>> ath12k_get_smps_from_capa(const struct ieee80211_sta_ht_cap *h
>>   static void ath12k_peer_assoc_h_smps(struct ieee80211_sta *sta,
>>                        struct ath12k_wmi_peer_assoc_arg *arg)
>>   {
>> +    const struct ieee80211_he_6ghz_capa *he_6ghz_capa = 
>> &sta->deflink.he_6ghz_capa;
>>       const struct ieee80211_sta_ht_cap *ht_cap = &sta->deflink.ht_cap;
>>       int smps;
>> -    if (ath12k_get_smps_from_capa(ht_cap, &smps))
>> +    if (ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps))
>>           return;
>>       switch (smps) {
>> @@ -2457,11 +2463,12 @@ static void ath12k_peer_assoc_prepare(struct 
>> ath12k *ar,
>>   static int ath12k_setup_peer_smps(struct ath12k *ar, struct 
>> ath12k_vif *arvif,
>>                     const u8 *addr,
>> -                  const struct ieee80211_sta_ht_cap *ht_cap)
>> +                  const struct ieee80211_sta_ht_cap *ht_cap,
>> +                  const struct ieee80211_he_6ghz_capa *he_6ghz_capa)
>>   {
>>       int smps, ret = 0;
>> -    ret = ath12k_get_smps_from_capa(ht_cap, &smps);
>> +    ret = ath12k_get_smps_from_capa(ht_cap, he_6ghz_capa, &smps);
>>       if (ret < 0)
>>           return ret;
>> @@ -2514,7 +2521,8 @@ static void ath12k_bss_assoc(struct ath12k *ar,
>>       }
>>       ret = ath12k_setup_peer_smps(ar, arvif, bss_conf->bssid,
>> -                     &ap_sta->deflink.ht_cap);
>> +                     &ap_sta->deflink.ht_cap,
>> +                     &ap_sta->deflink.he_6ghz_capa);
>>       if (ret) {
>>           ath12k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: 
>> %d\n",
>>                   arvif->vdev_id, ret);
>> @@ -3677,7 +3685,8 @@ static int ath12k_station_assoc(struct ath12k *ar,
>>           return 0;
>>       ret = ath12k_setup_peer_smps(ar, arvif, sta->addr,
>> -                     &sta->deflink.ht_cap);
>> +                     &sta->deflink.ht_cap,
>> +                     &sta->deflink.he_6ghz_capa);
>>       if (ret) {
>>           ath12k_warn(ar->ab, "failed to setup peer SMPS for vdev %d: 
>> %d\n",
>>                   arvif->vdev_id, ret);
>> @@ -8104,7 +8113,7 @@ static int ath12k_mac_hw_register(struct 
>> ath12k_hw *ah)
>>        * for each band for a dual band capable radio. It will be 
>> tricky to
>>        * handle it when the ht capability different for each band.
>>        */
>> -    if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS)
>> +    if (ht_cap & WMI_HT_CAP_DYNAMIC_SMPS || ar->supports_6ghz)
> WCN7850 supports 6 GHz but it does not support feature 
> NL80211_FEATURE_DYNAMIC_SMPS. Enabling this for WCN7850 can lead to 
> MU-MIMO test failures.
> 
>>           wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
>>       wiphy->max_scan_ssids = WLAN_SCAN_PARAMS_MAX_SSID;

Thanks Baochen

will address this in next revision..
can you please let me know if WCN7850 firmware advertises any capability 
flag for this?
If not, I am planning to use hw_params for differentiating feature 
support. I will further look and update in next revision.

Thanks
Pradeep

