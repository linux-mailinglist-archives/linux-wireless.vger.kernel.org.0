Return-Path: <linux-wireless+bounces-24710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0508AEF1D0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1072A3B8732
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F2B1EC01D;
	Tue,  1 Jul 2025 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jDxEWWQ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F601F09B6
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359827; cv=none; b=ii5kSV02DQUW96tb06RBzrlcr9yOfVId/t6GKbGnIh2n4NSefNdEPtUS75DH6yG586E0UN3v08xKoB+TWu8l4KMl59WU39w1J2/aDowg1mUmJ+bJepE1LmkzzFWNb35mpRQ9Id+dDYQgcccVaRuAwhjhKaUVbCnBAHPOJnfJ6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359827; c=relaxed/simple;
	bh=zUsbKd/VlFw8jdqAt2xtj2eMz8uRH4GN+3uo46ppEgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QFLJjT8mNpme1DADkQABuULv4ypF7jJJK6uueqQN2Z23iqwzcu7i8jJ6UBrq7zI72aQwgiVqPyfMooPO+CDi/5bX+Rq6yD0cPyrAR9kbTPNEd+TZOJF6+NJ5qjDjE7cP3P0fhYeC5cfZ9vYTzAOVD8tfnCBZBPcWZ1XD4UIL+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jDxEWWQ7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5613hHsL000324;
	Tue, 1 Jul 2025 08:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9rKL/G3uJjiLZbR2M6EnvDktMc/VbIG3KMeAKMEYbFo=; b=jDxEWWQ7nxol4jWE
	q34Cpk9JFCvyRYwcYZVRYyfYsc4tOgi91viojPNHz7Z+paweIOkuL3j9ZZWpAkua
	aTrJFUelRfTqC7BVmMnJ5xM3+nfpiPt/1X7Tt/QX4PA7vnFunLP4J3wJyQUH2vpx
	hZx4UdYTigSxUPnm0/mWF30cFmcV5BARoadS8ccnrmJJs2iiY34nuqnPODZOUVIf
	LzFJkod2QpZbAWldn0MCMNh3TYp2bFPhbyt2XTdB1gbs0FoE3pav4Yi0FY9Za23e
	y8KFXG3pcxdXwW6y0cGOe8Dn1P1isZPwBwDQsEryED0Ei6EMpuVyJfhj3jeRYYLF
	Zrv96A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qm7vpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Jul 2025 08:50:20 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5618oJtr000901
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 08:50:19 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Jul
 2025 01:50:18 -0700
Message-ID: <b0daaafa-07a2-4372-b063-75e0cf75a4fd@quicinc.com>
Date: Tue, 1 Jul 2025 14:20:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v7 4/5] wifi: ath12k: correctly update bw for
 ofdma packets
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
 <20250630071114.3474672-5-quic_sarishar@quicinc.com>
 <6e64bd6c-c6eb-b9ac-4f82-e241a7323ddc@oss.qualcomm.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <6e64bd6c-c6eb-b9ac-4f82-e241a7323ddc@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=6863a14c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=WtVtEp7Jhg6eC0_IT5IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Cwc5o-86OCbYNN3YnH5kW66CwL63cCwJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA1MSBTYWx0ZWRfX179VbKIs9l4s
 /t5Hofrqs88Ec6eKN0oiSxnp/xHOLtO4MJrBMuma5pp89gJs/2XzoghnjujNTiF2zODEl4/g67p
 OIIEgFI1b2cJDtlOdaRtB/m50bjR+QADEZMaur3puIZzmd2ai2PhYt0OWJY6ALHIcsTYFwNpZ5j
 GMU8TPhSY/Ox+vIsd4pXV0G0Ge4GwsHP1QSbWpG6tiaKaH45m2sDRXYkhruUXVe3hus+9LvXkZT
 LWIMC4ZtSU7r0qpL+lg+6tHzR14UBGUNMPOnyGjULyPpiEXxUFLjgUwbIopbC/HITMnNhXFmc40
 XOY8Oe7pvC22fYufLOLOoAnmWpoIaZ3HV7q9OSKK4izgAjHNkeXyAarUBsvPBvJWdxIbEu9IoSK
 UEz2YmeR1Kk6aA2eh2tv96FUEgnN3CbR23M5ab3wX8ub4ziYwBBwSFXq/SaM6hE0La6J1y3z
X-Proofpoint-GUID: Cwc5o-86OCbYNN3YnH5kW66CwL63cCwJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=752
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010051

On 7/1/2025 1:02 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 6/30/2025 12:41 PM, Sarika Sharma wrote:
>> Currently, arsta->txrate.bw is filled from 
>> ath12k_mac_bw_to_mac80211_bw(bw)
>> during ath12k_update_per_peer_tx_stats(). But in tx_completion path bw
>> is filled differently if ppdu_type is ofdma for HE/EHT rates.
>>
>> Hence, update arsta->txrate.bw correctly if packet is ofdma for HE
>> and EHT rate.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp.h    |  2 ++
>>   drivers/net/wireless/ath/ath12k/dp_rx.c | 15 ++++++++++++---
>>   2 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/ 
>> wireless/ath/ath12k/dp.h
>> index a353333f83b6..0c1fece27264 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp.h
>> +++ b/drivers/net/wireless/ath/ath12k/dp.h
>> @@ -1559,6 +1559,8 @@ enum HTT_PPDU_STATS_PPDU_TYPE {
>>   #define HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M        BIT(28)
>>   #define HTT_PPDU_STATS_USER_RATE_FLAGS_LDPC_M        BIT(29)
>> +#define HTT_USR_RATE_PPDU_TYPE(_val) \
>> +        le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M)
>>   #define HTT_USR_RATE_PREAMBLE(_val) \
>>           le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M)
>>   #define HTT_USR_RATE_BW(_val) \
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/ 
>> wireless/ath/ath12k/dp_rx.c
>> index 0f5edc81fc5d..ff92ec764ae5 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
>> @@ -1423,12 +1423,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k 
>> *ar,
>>       struct htt_ppdu_user_stats *usr_stats = &ppdu_stats- 
>> >user_stats[user];
>>       struct htt_ppdu_stats_common *common = &ppdu_stats->common;
>>       int ret;
>> -    u8 flags, mcs, nss, bw, sgi, dcm, rate_idx = 0;
>> +    u8 flags, mcs, nss, bw, sgi, dcm, ppdu_type, rate_idx = 0;
>>       u32 v, succ_bytes = 0;
>>       u16 tones, rate = 0, succ_pkts = 0;
>>       u32 tx_duration = 0;
>>       u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
>> -    bool is_ampdu = false;
>> +    bool is_ampdu = false, is_ofdma = false;
> 
> nit: initialization of is_ofdma is unnecessary as it is unconditionally
> populated below.
> 
>  >       if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
>  >           return;
>  > @@ -1457,6 +1457,10 @@ ath12k_update_per_peer_tx_stats(struct ath12k 
> *ar,
>  >       sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
>  >       dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
>  >
>  > +    ppdu_type = HTT_USR_RATE_PPDU_TYPE(user_rate->info1);
>  > +    is_ofdma = (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA) ||
>  > +           (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA);
>  > +
> 

Sure, will remove it.

> 
> Vasanth


