Return-Path: <linux-wireless+bounces-6918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E98B30A9
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 08:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9820F1C21793
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 06:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F25113A276;
	Fri, 26 Apr 2024 06:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J9nWuDtz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58BF13A268
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113715; cv=none; b=jV5uVRDl69daV2JW8u1R21Rs63PY4GMY6YvJgdNJb7F7ofYltnlj4tfrWva2mGmiyVF+Zyj6YXekhWGNraV/Zib2T7RRKaTYHELWI9zFBmLUoziYaIOx6mAWBV/4rxzAkFgEWqhEc3jASBN2MbOXbx7s5R+1icbFGwgDHsevRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113715; c=relaxed/simple;
	bh=o9lxc+Tlf7N+KV0qZ/T0ZfiZpoovNGjv4KyYj84hQWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DsERGcY52tIoDsXBlrYLtBdc5c0X+wGkO1AzlcGhLHD1q4ZQVVbt4vYeybh5CgbMF/3+lzrhaKOh60UIr3lfF9AsRoaVb93cy7APm58SVAeqZWV5foT8ftA8heMs9wP3o7b2zvK8qHx80x8lkefiwknlFKgV/OWw1h2G6flt8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J9nWuDtz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q4nvn6003132;
	Fri, 26 Apr 2024 06:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ps2YyPv7Faq+wIsEonNNjEylmWEy+Iw10a8qpExHhPA=; b=J9
	nWuDtzdk6/FaQ6mcSk7GgcD5DZYmWn8gW8v/144x6T8xhYnqxi0vae+7EROe7jLg
	JMFxVdxLYTbbFzz5HakULD+Maj9kF9PtUUWcTjNtVCLfiQBN+vEXV5Yx48XcE4IT
	fTZTZpBMW9qNexL6CumuEekoWBg1a+5aeZzlg5s26o5p2noMXx1hu7GbXt/RBBcD
	Ug/EDQrpSFy58b7sMi72jY72/eIOtqaBCIY00HlSbfd9zblUg5ht8agbypWRMkuq
	NTAWHUR8JU2yGlzGIYuXK92q41cY4cX/JfDg44pRGZkNT2VzeRRR/M0CK1Rhnbd0
	7LktzWbmbrwdZ71dlQ4Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqtph9y4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:41:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q6fcAQ025195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 06:41:39 GMT
Received: from [10.38.245.251] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 23:41:37 -0700
Message-ID: <050ae0d4-c879-40c2-b2ac-1766aaa2c789@quicinc.com>
Date: Fri, 26 Apr 2024 14:41:33 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] wifi: ath12k: report station mode transmit rate
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
 <20240419032122.7009-2-quic_lingbok@quicinc.com> <87bk5xs7qj.fsf@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87bk5xs7qj.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SrhhuTs0F8JJ0jRLjCMaowP_k5Ph09A0
X-Proofpoint-ORIG-GUID: SrhhuTs0F8JJ0jRLjCMaowP_k5Ph09A0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_06,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260039



On 2024/4/26 0:54, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> writes:
> 
>> Currently, the transmit rate of "iw dev xxx station dump" command
>> always show an invalid value.
>>
>> To address this issue, ath12k parse the info of transmit complete
>> report from firmware and indicate the transmit rate to mac80211.
>>
>> This patch affects the station mode of WCN7850 and QCN9274.
>>
>> After that, "iw dev xxx station dump" show the correct transmit rate.
>> Such as:
>>
>> Station 00:03:7f:12:03:03 (on wlo1)
>>          inactive time:  872 ms
>>          rx bytes:       219111
>>          rx packets:     1133
>>          tx bytes:       53767
>>          tx packets:     462
>>          tx retries:     51
>>          tx failed:      0
>>          beacon loss:    0
>>          beacon rx:      403
>>          rx drop misc:   74
>>          signal:         -95 dBm
>>          beacon signal avg:      -18 dBm
>>          tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> 
> I'm still going throught the patchset, please don't send a new version
> yet. Few quick comments:
> 
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
> Did you analyse how this function, and especially taking the base_lock,
> affects performance?
> 

The base_lock is used here because of the need to look for peers based 
on the ts->peer_id when calling ath12k_peer_find_by_id() function, which 
i think might affect performance.

Do i need to run a throughput test?

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
> 
> How does this function compare to ath12k_he_ru_tones_to_nl80211_he_ru_alloc()?
> 

ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc() is different from 
ath12k_he_ru_tones_to_nl80211_he_ru_alloc().

the logic of ath12k_he_ru_tones_to_nl80211_he_ru_alloc() is

static inline
enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 
ru_tones)
{
         enum nl80211_he_ru_alloc ret;

         switch (ru_tones) {
         case RU_52:
                 ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
                 break;
         case RU_106:
                 ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
                 break;
         case RU_242:
                 ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
                 break;
         case RU_484:
                 ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
                 break;
         case RU_996:
                 ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
                 break;
         case RU_26:
                 fallthrough;
         default:
                 ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
                 break;
         }
         return ret;
}

#define RU_26  1
#define RU_52  2
#define RU_106 4
#define RU_242 9
#define RU_484 18
#define RU_996 37


>> +enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi)
>> +{
>> +	enum nl80211_eht_gi ret;
>> +
>> +	switch (sgi) {
>> +	case RX_MSDU_START_SGI_0_8_US:
>> +		ret = NL80211_RATE_INFO_EHT_GI_0_8;
>> +		break;
>> +	case RX_MSDU_START_SGI_1_6_US:
>> +		ret = NL80211_RATE_INFO_EHT_GI_1_6;
>> +		break;
>> +	case RX_MSDU_START_SGI_3_2_US:
>> +		ret = NL80211_RATE_INFO_EHT_GI_3_2;
>> +		break;
>> +	default:
>> +		ret = NL80211_RATE_INFO_EHT_GI_0_8;
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> BTW the ret variable is unnessary, this could be simplified to:
> 
> switch (foo) {
> case FOO1:
>          return BAR1;
> case FOO2:
>          return BAR2;
> default:
>          return BAR3;
> }
> 
>> +enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones)
>> +{
>> +	enum nl80211_eht_ru_alloc ret;
>> +
>> +	switch (ru_tones) {
>> +	case 26:
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
>> +		break;
>> +	case 52:
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_52;
>> +		break;
>> +	case (52 + 26):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_52P26;
>> +		break;
>> +	case 106:
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_106;
>> +		break;
>> +	case (106 + 26):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_106P26;
>> +		break;
>> +	case 242:
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_242;
>> +		break;
>> +	case 484:
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_484;
>> +		break;
>> +	case (484 + 242):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_484P242;
>> +		break;
>> +	case 996:
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996;
>> +		break;
>> +	case (996 + 484):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484;
>> +		break;
>> +	case (996 + 484 + 242):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242;
>> +		break;
>> +	case (2 * 996):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996;
>> +		break;
>> +	case (2 * 996 + 484):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484;
>> +		break;
>> +	case (3 * 996):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996;
>> +		break;
>> +	case (3 * 996 + 484):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484;
>> +		break;
>> +	case (4 * 996):
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_4x996;
>> +		break;
>> +	default:
>> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
>> +	}
>> +
>> +	return ret;
>> +}
> 
> Same here.
> 

