Return-Path: <linux-wireless+bounces-4087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3906869161
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 14:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4771C264A9
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D4013A895;
	Tue, 27 Feb 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GNsrePF/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7D1332A7
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039273; cv=none; b=F26FF18hbJp4vHctJl53y5cm96PETqC/V0FRcZXCT1ekhJTz5+MMrIhKIXiNGcNqeV1y3cWZD2JxnSOewo3UrMht6hjYJWQncadEccuKzVZMq+1LQc6p3CElyCtmesi3n26JlizaCzrmksk4st+iUIxW0/SlYXuyUN4r7qRWT6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039273; c=relaxed/simple;
	bh=puiO2+8sz1EhFgTsNxHgx8KD2sffyKVDcEXSDgY8p64=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rU7lLObBs7SxLdSXtNziiiex/6skM8HVFilbzh3Wgj98BQUhDWdVAjf6IWlGHJ+K48E5PokayaFddHS2zJLwUmIJp7tkpL7MUeH09mEaZDr3JVHKEyCIlvTkbp9FqF8KZek05D3Evq/ynDxxNmFyEEhkO9ikvckIUXm7e1KPyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GNsrePF/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R9YUPX032419;
	Tue, 27 Feb 2024 13:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4aEfDH3JCWuZL1XsRoYSpGGEP/yQT0AhdzMcOtLK7No=; b=GN
	srePF/0nj68Z7sBrD+uBXyh4d4IFJyLK5u6HeEmsIAPf9gnCjZVb+Q2RirD04mhZ
	w/zzyIGnPu8FL01HZQ0xLP/V96Uw8m0e/oCaRn8K3vXO7sbyneO+DEWA87Bolziz
	4XxBKMcUeh/pROR4B2e+9ZbLwgXFYP03HafdysiXfD1Y0TpbO4BOVvD9uQGMLQLV
	0tqsH1Iuf2nkAHd3iIPSrCZWNT9vNLvqTwDqBOqCnvVHjUYx1gaNdapY8HxufHnq
	yjoXVnXrOTZBmUDvY7tTxcKQDrSbHVPT7lhmdNjs7PmVlxOR27n48FUOo2PpS++c
	2en1Iqa2VPSRrOAwkkWA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wha078wp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 13:07:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RD7djA002795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 13:07:39 GMT
Received: from [10.110.92.246] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 05:07:38 -0800
Message-ID: <6f39eb1c-97f7-4029-a5f2-5ab36ff0f0a6@quicinc.com>
Date: Tue, 27 Feb 2024 21:07:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240219095802.1147-1-quic_lingbok@quicinc.com>
 <87y1b7jkxu.fsf@kernel.org>
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87y1b7jkxu.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kelzppGcu28dIgiCv4xqiyPoPjJ1SkUN
X-Proofpoint-GUID: kelzppGcu28dIgiCv4xqiyPoPjJ1SkUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402270102



On 2024/2/26 23:37, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> writes:
> 
>> The tx bitrate of "iw dev xxx station dump" always show an invalid value
>> "tx bitrate: 6.0MBit/s".
>>
>> To address this issue, parse the tx complete report from firmware and
>> indicate the tx rate to mac80211.
>>
>> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
>> tx bitrate: 104.0 MBit/s MCS 13
>> tx bitrate: 144.4 MBit/s MCS 15 short GI
>> tx bitrate: 626.9 MBit/s 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
>> tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI QCN9274 hw2.0 PCI
>> WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> Please use full englist words like transmit instead of tx. Also the
> title could be simplified to:
> 
> wifi: ath12k: report station mode transmit rate to user space
> 
> Here I assumed this only works in station mode. Or does this also
> support AP and P2P mode? The commit message should explain that.
> 

Ok, i will apply it in next version. Thanks for pointing out.

>> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> @@ -290,7 +290,7 @@ static void ath12k_dp_mon_parse_he_sig_b1_mu(u8 *tlv_data,
>>   
>>   	ru_tones = u32_get_bits(info0,
>>   				HAL_RX_HE_SIG_B1_MU_INFO_INFO0_RU_ALLOCATION);
>> -	ppdu_info->ru_alloc = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
>> +	ppdu_info->ru_alloc = ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(ru_tones);
> 
> Now there would be two very similar functions:
> 
> ath12k_mac_he_gi_to_nl80211_he_gi() vs ath12k_he_gi_to_nl80211_he_gi()
> 
> ath12k_he_ru_tones_to_nl80211_he_ru_alloc() vs ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc()
> 
> Why do we need those?
> 

Yes, you're right, we don't need these functions. i will delete these 
functions and directly modify ath12k_he_gi_to_nl80211_he_gi() and
ath12k_he_ru_tones_to_nl80211_he_ru_alloc() in next version.
Thanks for pointing out.

>> +static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
>> +{
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct ath12k_peer *peer;
>> +	struct ath12k_sta *arsta;
>> +	struct ieee80211_sta *sta;
>> +	u16 rate;
>> +	u8 rate_idx = 0;
>> +	int ret;
>> +
>> +	spin_lock_bh(&ab->base_lock);
> 
> Empty line after spin_lock_bh(), please.
> 
> 
>> +	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
>> +	if (!peer || !peer->sta) {
>> +		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
>> +			   "failed to find the peer by id %u\n", ts->peer_id);
>> +		goto err_out;
>> +	}
>> +
>> +	sta = peer->sta;
>> +	arsta = ath12k_sta_to_arsta(sta);
>> +
>> +	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
>> +
>> +	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
>> +	 * if it is invalid, then choose the NSS value while assoc.
>> +	 */
>> +	if (arsta->last_txrate.nss)
>> +		arsta->txrate.nss = arsta->last_txrate.nss;
>> +	else
>> +		arsta->txrate.nss = arsta->peer_nss;
>> +
>> +	if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
>> +	    ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
>> +		ret = ath12k_mac_hw_ratecode_to_legacy_rate(ts->mcs,
>> +							    ts->pkt_type,
>> +							    &rate_idx,
>> +							    &rate);
>> +		if (ret < 0)
>> +			goto err_out;
> 
> Should we print a warning here? Otherwise we might miss something.
> 
>> +
>> +		arsta->txrate.legacy = rate;
>> +	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
>> +		if (ts->mcs > ATH12K_HT_MCS_MAX)
>> +			goto err_out;
> 
> Warning?
> 
>> +
>> +		if (arsta->txrate.nss != 0)
>> +			arsta->txrate.mcs = ts->mcs + 8 * (arsta->txrate.nss - 1);
> 
> Empty line here, please.
> 
>> +		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
> 
> And here.
> 
>> +		if (ts->sgi)
>> +			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
>> +	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
>> +		if (ts->mcs > ATH12K_VHT_MCS_MAX)
>> +			goto err_out;
> 
> Warning?
> 
>> +		arsta->txrate.mcs = ts->mcs;
>> +		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
> 
> Empty line.
> 
>> +		if (ts->sgi)
>> +			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
>> +	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
>> +		if (ts->mcs > ATH12K_HE_MCS_MAX)
>> +			goto err_out;
>> +
>> +		arsta->txrate.mcs = ts->mcs;
>> +		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
>> +		arsta->txrate.he_gi = ath12k_mac_he_gi_to_nl80211_he_gi(ts->sgi);
>> +	}
>> +
>> +	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(ts->bw);
> 
> Empty line.
> 

Ok, i will add warnings and empty line where appropriate.
Thanks for pointing out.

>> +	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
>> +		arsta->txrate.bw = RATE_INFO_BW_HE_RU;
>> +		arsta->txrate.he_ru_alloc =
>> +			ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ts->ru_tones);
>> +	}
>> +
>> +err_out:
>> +	spin_unlock_bh(&ab->base_lock);
>> +}
>> +
>> +static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
>> +{
>> +	if (ar->last_ppdu_id == 0)
>> +		goto update_last_ppdu_id;
>> +
>> +	if (ar->last_ppdu_id == ts->ppdu_id ||
>> +	    ar->cached_ppdu_id == ar->last_ppdu_id)
>> +		ar->cached_ppdu_id = ar->last_ppdu_id;
>> +
>> +	ath12k_dp_tx_update_txcompl(ar, ts);
>> +
>> +update_last_ppdu_id:
>> +	ar->last_ppdu_id = ts->ppdu_id;
>> +}
> 
> I think like this you could avoid the goto:
> 
> 	if (ar->last_ppdu_id != 0) {
>          	if (ar->last_ppdu_id == ts->ppdu_id ||
>                      ar->cached_ppdu_id == ar->last_ppdu_id)
>                          ar->cached_ppdu_id = ar->last_ppdu_id;
> 
>          	ath12k_dp_tx_update_txcompl(ar, ts);
>          }
> 
> 	ar->last_ppdu_id = ts->ppdu_id;
> 

you're right. i will apply it in next version.

>> @@ -2383,6 +2387,7 @@ static void ath12k_peer_assoc_prepare(struct ath12k *ar,
>>   	ath12k_peer_assoc_h_phymode(ar, vif, sta, arg);
>>   	ath12k_peer_assoc_h_smps(sta, arg);
>>   
>> +	arsta->peer_nss = arg->peer_nss;
>>   	/* TODO: amsdu_disable req? */
>>   }
> 
> Empty line before TODO comment, please.
> 
>> @@ -8324,3 +8329,90 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
>>   
>>   	return ret;
>>   }
>> +
>> +enum nl80211_he_ru_alloc ath12k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy)
>> +{
>> +	enum nl80211_he_ru_alloc ret;
>> +
>> +	switch (ru_phy) {
>> +	case RU_26:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
>> +		break;
>> +	case RU_52:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
>> +		break;
>> +	case RU_106:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
>> +		break;
>> +	case RU_242:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
>> +		break;
>> +	case RU_484:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
>> +		break;
>> +	case RU_996:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
>> +		break;
>> +	default:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +enum nl80211_he_ru_alloc ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
>> +{
>> +	enum nl80211_he_ru_alloc ret;
>> +
>> +	switch (ru_tones) {
>> +	case 26:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
>> +		break;
>> +	case 52:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
>> +		break;
>> +	case 106:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
>> +		break;
>> +	case 242:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
>> +		break;
>> +	case 484:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
>> +		break;
>> +	case 996:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
>> +		break;
>> +	case (996 * 2):
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
>> +		break;
>> +	default:
>> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +enum nl80211_he_gi ath12k_mac_he_gi_to_nl80211_he_gi(u8 sgi)
>> +{
>> +	enum nl80211_he_gi ret;
>> +
>> +	switch (sgi) {
>> +	case RX_MSDU_START_SGI_0_8_US:
>> +		ret = NL80211_RATE_INFO_HE_GI_0_8;
>> +		break;
>> +	case RX_MSDU_START_SGI_1_6_US:
>> +		ret = NL80211_RATE_INFO_HE_GI_1_6;
>> +		break;
>> +	case RX_MSDU_START_SGI_3_2_US:
>> +		ret = NL80211_RATE_INFO_HE_GI_3_2;
>> +		break;
>> +	default:
>> +		ret = NL80211_RATE_INFO_HE_GI_0_8;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> Please don't add new function to the end of file, rather to the
> beginning or the middle. But like I mentioned earlier, do we really need
> these new functions?
> 

