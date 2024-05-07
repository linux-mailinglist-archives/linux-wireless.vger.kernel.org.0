Return-Path: <linux-wireless+bounces-7282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D208BE0A7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 13:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20A3AB22B48
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C0B14EC7E;
	Tue,  7 May 2024 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dw9Af4de"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61822AD5D
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080011; cv=none; b=uhwfA5b2uRUoovpJEwov9gZ8RDjQUXLVtmEZzk27V2uRKiJjiYSIGb8Q8aX4Eq0VFI+oBobaS3etG/xMr2NgTggf1PaLrl2u8awAm1rN6NZ/0gBSwuFzaI2Aqy8DE/DrBDrx5T+4PygW9yC+AIZw2i9vKrk7mowDTpOlFEVcNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080011; c=relaxed/simple;
	bh=MPnPP2qMugg2TRvW2oAKdddCsZb3IeUa4B3+lM+R1F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qxr0jSvoEi05MruQ8uU5RItzc/qkiSxbm8gJ13g/CWxxK/PAOFz5llg/Xrp3wgHA/AuycDhDWXy5SeitTfXPVU1Rqnq55x/NXzE48hwF9ScVhBcpp2MhlK6hwY/MXQpPzolv0N58VqDaw4pazfhGJ/QxIZYmxX6CuDAH6eDwRMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dw9Af4de; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4478Wekk004779;
	Tue, 7 May 2024 11:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qqAXvWLm4r9pTgqfH54lZmOjZaF4Sh5C2C6PPXDlvqk=; b=dw
	9Af4de6fccJAFd6Myjs8vq1OaD4/7mVMkULmfkd4+Em2g0Om2U658H6UMZBmPdue
	8N6cFICi4wmqS06p0PlKYTtWWvpKu7W0ENDifSbhKvWrATAChYUVCHWNiV3qRH7z
	nnDPxieroRm205v+iFf7ozNjn12XsbkW6j9dFK6kVL0Hc/Vd/IQB8vLMIuvV5FLO
	wI0/JIxGT9RugIn3KoHVCqqWYN2XDjVRTIU797umRGEhau4sQTcMzsLsfXUN+XGI
	4+SJ4gqy3mrnnWKVyo0mS4jpFzdGnuPfSk0v2LLbiCAKUdMBnxYMs9NqTxwnfPIv
	Aip3TWOKo94/jKSD+Emg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xxvv72u5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 11:06:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447B6fae031208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 11:06:41 GMT
Received: from [10.38.245.56] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 04:06:39 -0700
Message-ID: <5912d64a-3f69-44ad-9b06-9e02019141e6@quicinc.com>
Date: Tue, 7 May 2024 19:06:36 +0800
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
 <20240419032122.7009-2-quic_lingbok@quicinc.com> <87r0etsp6u.fsf@kernel.org>
 <c01db4fc-03a0-41f6-9f16-bfa3b2c08007@quicinc.com>
 <87r0esqsd6.fsf@kernel.org>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87r0esqsd6.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c6TP_HKVVFQ_xQRr-92HdySNGw7dOxuA
X-Proofpoint-ORIG-GUID: c6TP_HKVVFQ_xQRr-92HdySNGw7dOxuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_05,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405070076



On 2024/4/26 19:24, Kalle Valo wrote:
> Lingbo Kong <quic_lingbok@quicinc.com> writes:
> 
>> On 2024/4/25 18:37, Kalle Valo wrote:
>>> Lingbo Kong <quic_lingbok@quicinc.com> writes:
>>>
>>>> Currently, the transmit rate of "iw dev xxx station dump" command
>>>> always show an invalid value.
>>>>
>>>> To address this issue, ath12k parse the info of transmit complete
>>>> report from firmware and indicate the transmit rate to mac80211.
>>>>
>>>> This patch affects the station mode of WCN7850 and QCN9274.
>>>>
>>>> After that, "iw dev xxx station dump" show the correct transmit rate.
>>>> Such as:
>>>>
>>>> Station 00:03:7f:12:03:03 (on wlo1)
>>>>           inactive time:  872 ms
>>>>           rx bytes:       219111
>>>>           rx packets:     1133
>>>>           tx bytes:       53767
>>>>           tx packets:     462
>>>>           tx retries:     51
>>>>           tx failed:      0
>>>>           beacon loss:    0
>>>>           beacon rx:      403
>>>>           rx drop misc:   74
>>>>           signal:         -95 dBm
>>>>           beacon signal avg:      -18 dBm
>>>>           tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>>>>
>>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>>> [...]
>>>
>>>> +static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
>>>> +{
>>>> +	if (ar->last_ppdu_id != 0) {
>>>> +		if (ar->last_ppdu_id == ts->ppdu_id ||
>>>> +		    ar->cached_ppdu_id == ar->last_ppdu_id)
>>>> +			ar->cached_ppdu_id = ar->last_ppdu_id;
>>>> +
>>>> +		ath12k_dp_tx_update_txcompl(ar, ts);
>>>> +	}
>>>> +
>>>> +	ar->last_ppdu_id = ts->ppdu_id;
>>>> +}
>>> A code comment would help a lot. Why is ar->cached_ppdu_id needed
>>> here?
>>> And if 'ar->cached_ppdu_id == ar->last_ppdu_id' is true why do then
>>> do
>>> 'ar->cached_ppdu_id = ar->last_ppdu_id'? The value of ar->cached_ppdu_id
>>> is not changing here (unless I'm missing something).
>>> Also I'm worried about locking. How is access to ar->last_ppdu_id
>>> and
>>> ar->cached_ppdu_id protected?
>>>
>>
>> Thanks for pointing to this.
>> you're right, the ar->cached_ppdu_id haven't used in here, so need to
>> delete it.
>> i missed something in here.
>>
>> So, change the ath12k_dp_tx_update(struct ath12k *ar, struct
>> hal_tx_status *ts) to
>> static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
>> {
>> 	if (ts->flags & HAL_TX_STATUS_FLAGS_FIRST_MSDU) {
>> 		if (ar->last_ppdu_id != 0)
>> 			ath12k_dp_tx_update_txcompl(ar, ts);
>> 		ar->last_ppdu_id = ts->ppdu_id;
>> 	}
>> }
> 
> Access to ar->last_ppdu_id still looks racy to me.
> 
> And why do we need to track last_ppdu_id? I don't have time to start
> investigating that right now, a code comment explaining that would help
> a lot.

yes, you are right, kalle, thanks for pointing of this.
There really isn't a need to add a judgement of last_ppdu_id to this place.

The ath12k_dp_tx_update_txcompl() function should be called directly and 
no need to define ath12k_dp_tx_update() function.

Best regards
Lingbo Kong

