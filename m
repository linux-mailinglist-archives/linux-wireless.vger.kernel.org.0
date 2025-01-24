Return-Path: <linux-wireless+bounces-17900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB11EA1B348
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 11:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E4C7A2B49
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 10:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2CA207A03;
	Fri, 24 Jan 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LZxw6flP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B121B87C3
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737713307; cv=none; b=N4i7mD6eX03k5tbBheR/ONpHuwwxtgmzPBYq0sRlg2wSheZ9TZ5SL8mxiNUBrEyPVDUdTAksj3IsePsClE3Dyz0h/z7D+zFJa+x9fHgdDdDMa5Q+w9NW1Ls6gSjLNu6n764ETa819PM7xcNbgnGfWfKfHNFJuz4Z6xOPgpDLFjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737713307; c=relaxed/simple;
	bh=Xw0kJnXcIYa7mBWm1j+CDG7APS5W50l392UKN07temU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c9XAWXURmi3/D+zIAmiOxQM2q1/++YQzRFB04CRtEnmxJwatXKaDEodVNg8FXXGOqCalsYnjOo4Bf8S8K8UqcM4ZdXGeVAH7S2OfpDZWN244uddqblu59Go5yU8FpUnz+bhU+T0UwI5ZxLTg+EwAFSs04NLXtrT69aby7yvBaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LZxw6flP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OA5V0W010856;
	Fri, 24 Jan 2025 10:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S9BBXevNosdbXLVUHtlw1/GoAjgEwK2p4smVZBzOJgc=; b=LZxw6flPnMtudkVD
	ZeMHjMMs4gK1MS8njmZC42GHe1KDfXikfXwFN4gLE6PFF7A81pfUE0gVMulbJzNn
	YbFX56/DdIAXDsFwJ+H71GyqLyzf0tK2xdgxDj5AKbEHdI9iwlP2ovcjoY7RorH0
	AgtDLIalfqa2I04ekt69w3gmEJepokP4n1qiTiHOBPtT8AHSKIewbT5i1dCjaggv
	c3zYLMeqNgcJNES0qqofoS3+Jiahiup6brijn4SiqoJbf4I13Qi/Cu1yFgAxVEcY
	YILWIwEmClrg4XtRxCIHFVp5vmlDMLACicTnM1OfOAGTUQDS6vb4vzMDIAZzxvqn
	CJkRRw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c8ta8060-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 10:08:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50OA8HbN001206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 10:08:17 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 24 Jan
 2025 02:08:15 -0800
Message-ID: <1bfaee3a-3e82-4c55-8141-047d10feafa8@quicinc.com>
Date: Fri, 24 Jan 2025 15:38:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] wifi: ath12k: add EHT support for TX rate
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>
References: <20250122133424.1226555-1-quic_sarishar@quicinc.com>
 <20250122133424.1226555-4-quic_sarishar@quicinc.com>
 <653484cd0984e12dff094e5f9436ae4170509976.camel@freebox.fr>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <653484cd0984e12dff094e5f9436ae4170509976.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XlCFzpgOzMwwKa1CA1HqwV8NHrKs8Ccb
X-Proofpoint-ORIG-GUID: XlCFzpgOzMwwKa1CA1HqwV8NHrKs8Ccb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240073

On 1/23/2025 7:03 PM, Maxime Bizon wrote:
> 
> On Wed, 2025-01-22 at 19:04 +0530, Sarika Sharma wrote:
> 
> Hello,
> 
>> +       case WMI_RATE_PREAMBLE_EHT:
>> +               arsta->txrate.mcs = mcs;
>> +               arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
>> +               arsta->txrate.he_dcm = dcm;
>> +               arsta->txrate.eht_gi = ath12k_eht_gi_to_nl80211_eht_gi(sgi);
>> +               tones = le16_to_cpu(user_rate->ru_end) -
>> +                       le16_to_cpu(user_rate->ru_start) + 1;
>> +               v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
>> +               arsta->txrate.eht_ru_alloc = v;
>> +               break;
>>          }
>>
> 
> The logic to set arsta->txrate.bw to RATE_INFO_BW_HE_RU or
> RATE_INFO_BW_EHT_RU like in dp_tx completion is missing here.
> 

This patch is to support EHT rates and currently arsta->txrate.bw is 
filled as
arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(bw).

Sure will check below suggestion and add another patch to include 
arsta->txrate.bw for both HE and EHT correctly.

> How about something like this ?
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index c3c607eae476..de2095ed8863 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -1506,6 +1506,8 @@ enum HTT_PPDU_STATS_PPDU_TYPE {
>   #define HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M           BIT(28)
>   #define HTT_PPDU_STATS_USER_RATE_FLAGS_LDPC_M          BIT(29)
>   
> +#define HTT_USR_RATE_PPDU_TYPE(_val) \
> +               le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M)
>   #define HTT_USR_RATE_PREAMBLE(_val) \
>                  le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M)
>   #define HTT_USR_RATE_BW(_val) \
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index eaec3949470d..c8d377544422 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1370,12 +1370,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
>          struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
>          struct htt_ppdu_stats_common *common = &ppdu_stats->common;
>          int ret;
> -       u8 flags, mcs, nss, bw, sgi, dcm, rate_idx = 0;
> +       u8 flags, mcs, nss, bw, sgi, dcm, ppdu_type, rate_idx = 0;
>          u32 v, succ_bytes = 0;
>          u16 tones, rate = 0, succ_pkts = 0;
>          u32 tx_duration = 0;
>          u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
> -       bool is_ampdu = false;
> +       bool is_ofdma, is_ampdu = false;
>   
>          if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
>                  return;
> @@ -1403,6 +1403,9 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
>          mcs = HTT_USR_RATE_MCS(user_rate->rate_flags);
>          sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
>          dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
> +       ppdu_type = HTT_USR_RATE_PPDU_TYPE(user_rate->rate_flags);
> +       is_ofdma = (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA) |
> +               (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA);
>   
>          /* Note: If host configured fixed rates and in some other special
>           * cases, the broadcast/management frames are sent in different rates.
> @@ -1479,6 +1482,16 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
>                  v = ath12k_he_ru_tones_to_nl80211_he_ru_alloc(tones);
>                  arsta->txrate.he_ru_alloc = v;
>                  break;
> +       case WMI_RATE_PREAMBLE_EHT:
> +               arsta->txrate.mcs = mcs;
> +               arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
> +               arsta->txrate.he_dcm = dcm;
> +               arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(sgi);
> +               tones = le16_to_cpu(user_rate->ru_end) -
> +                       le16_to_cpu(user_rate->ru_start) + 1;
> +               v = ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(tones);
> +               arsta->txrate.eht_ru_alloc = v;
> +               break;
>          }
>   
>          arsta->txrate.nss = nss;
> @@ -1486,6 +1499,13 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
>          arsta->tx_duration += tx_duration;
>          memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
>   
> +       if (is_ofdma) {
> +               if (flags == WMI_RATE_PREAMBLE_HE)
> +                       arsta->txrate.bw = RATE_INFO_BW_HE_RU;
> +               else if (flags == WMI_RATE_PREAMBLE_EHT)
> +                       arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
> +       }
> +
>          /* PPDU stats reported for mgmt packet doesn't have valid tx bytes.
>           * So skip peer stats update for mgmt packets.
>           */
> 
> 


