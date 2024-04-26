Return-Path: <linux-wireless+bounces-6921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758F38B31DF
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 10:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F761F2162A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7D8762FF;
	Fri, 26 Apr 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iIs/JPpY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9C42A9B
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118500; cv=none; b=N2Gjj/sivGRcq7aCFY4tzhkrOt+qJPHt+ynktflnURqDts22Ss0NTeEIERkgNnPk17k9JwX1xBDe8cYPZEImMYNssqql3ZUB+O5lAcb0Y/e838+tmYO6FnQt1bFNujFZli/k0HwpkvsAA5EcIoY+hcfOhA7odAnJ3mB4/v7CMEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118500; c=relaxed/simple;
	bh=0hK+C3udJNQbzB6AFHRiX6E5RNgM2WQ7WF1IST7PlOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QHfq9Ryb4hu7Qho8yvysmWAM5D+I7PVOj8sNl5HFx7wuVoI9BGGAmx2XfmxREu5WgJYHYm18EL6U4UddGzTuWxXDZM9QRTUyzY131TyJqbBx/wCIGccTkKWkfNooon6O6PJqrhPitiZupjTjVo6m/6GEkSptcTFwNjeIC0NAoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iIs/JPpY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q4p6Wj010584;
	Fri, 26 Apr 2024 08:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7XCpFNcUVGUw/dx6yA5JuwpoFJAq8+N68WrOV5Dr72M=; b=iI
	s/JPpYFGYX5YV8PNoLDQurfAcwAifvODiPBORk84hC9z4HZzqsJK65lc1L4683PF
	6iUtfsWQmGksv68cmxjKIJG2SJiuoTQPdnV0ZK3rxodCs4gLXmxvA0zfnOV7zM9H
	zWJSyQ08NTDab9NUlUfx5od9aAgDVmKm6Va4a+2WybVnOP15l4ufFw0JiinuAXIF
	UADMQr3cK1kiyP4tXLYJyXSgFPmEHUchJ+JizVfxRmixosxTbX5mBEUIR9QJRd7g
	dZCtBFl66yxfhvi7EtumxKqA1AsWoCe7L27AlEZtuyHEkC8LjAbGZb8wusENfnLe
	dj1nBSDXNrRMOcrT+0jA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqrwwtjr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:01:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q81OZ0028759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 08:01:24 GMT
Received: from [10.38.245.251] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 01:01:23 -0700
Message-ID: <c01db4fc-03a0-41f6-9f16-bfa3b2c08007@quicinc.com>
Date: Fri, 26 Apr 2024 16:01:19 +0800
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
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <87r0etsp6u.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lqv18atgWOpvrZ3S5Y4iVwQO3wPBkc7y
X-Proofpoint-ORIG-GUID: lqv18atgWOpvrZ3S5Y4iVwQO3wPBkc7y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_07,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=990 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404260050



On 2024/4/25 18:37, Kalle Valo wrote:
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
> [...]
> 
>> +static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
>> +{
>> +	if (ar->last_ppdu_id != 0) {
>> +		if (ar->last_ppdu_id == ts->ppdu_id ||
>> +		    ar->cached_ppdu_id == ar->last_ppdu_id)
>> +			ar->cached_ppdu_id = ar->last_ppdu_id;
>> +
>> +		ath12k_dp_tx_update_txcompl(ar, ts);
>> +	}
>> +
>> +	ar->last_ppdu_id = ts->ppdu_id;
>> +}
> 
> A code comment would help a lot. Why is ar->cached_ppdu_id needed here?
> 
> And if 'ar->cached_ppdu_id == ar->last_ppdu_id' is true why do then do
> 'ar->cached_ppdu_id = ar->last_ppdu_id'? The value of ar->cached_ppdu_id
> is not changing here (unless I'm missing something).
> 
> Also I'm worried about locking. How is access to ar->last_ppdu_id and
> ar->cached_ppdu_id protected?
> 

Thanks for pointing to this.
you're right, the ar->cached_ppdu_id haven't used in here, so need to 
delete it.
i missed something in here.

So, change the ath12k_dp_tx_update(struct ath12k *ar, struct 
hal_tx_status *ts) to
static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
{
	if (ts->flags & HAL_TX_STATUS_FLAGS_FIRST_MSDU) {
		if (ar->last_ppdu_id != 0)
			ath12k_dp_tx_update_txcompl(ar, ts);
		ar->last_ppdu_id = ts->ppdu_id;
	}
}

best regards
Lingbo Kong

