Return-Path: <linux-wireless+bounces-6677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1788AD2D7
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 18:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC741C2129A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 16:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34F6153824;
	Mon, 22 Apr 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QKhUZ9Gn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB115382C
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805080; cv=none; b=PqjtaFHjUq+hoFX4qbj/I93IWEwjZg/28tjnVkIQgHYpvicpmYNBUsZ9tzSISbvqB8lK2Ob8H2SA/MsxzSAy/wEQ+FVmGygzhmSQcx4zaFM+I09c8qtwn452RSLicXKlN3TJ/lgZr6jcYgnwSskhIISO6BlexclBoPS5eThApXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805080; c=relaxed/simple;
	bh=aeUXVU5MRcmpq6U7tBIWCdV7ObEQ8k1muvYq1v6Yhwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RFmz/Yct9F7z3fU3Q0UHy8y8MQU10g7j/lB40ZuGwd5EGmIqbFalr0lg/UL8xDh1iujCWROavRWWtYbsn3qSho3nSbM87hLl5BnGCU+wnukPnsA8zXTaPiKE+j6HDckhxQU3RfdhHVkfLUNGoPy82HuInTYKoNVmkrczhiGOGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QKhUZ9Gn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MGRkcF001569;
	Mon, 22 Apr 2024 16:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1TPiGsUqwlDfQHmD+CiUPo3WK8MQ0v+EyrDGMk0Rk/s=; b=QK
	hUZ9GnIu7dWX6u6pyE5LZ8O0tYguN+athW6G8xQPUrgSrd/vH69tXbJyg80FJxgo
	/e5hjGV8y62EvZQstoGRIRABwqjicu4PMe6tezJlenICBJci3x4SAcEtNCRhKMuh
	TVoOVJFukpWZXv8/bsBczufRTip09j1J8jP614VG+7jvpsEzA7/bXfmpr4abMJF+
	kaDB+3iZXHW93WU+hRJtYhESpoqFrrO69/WOrHiEfFjZQO3Q/bzjFDS21hxGVAbY
	tW4dbVLdcUgcj6Bngs6l7fd1Rqy2nGbGHO3uuSiaB4p/479hM6oLiITuNyRe4gvu
	3dnsDuxP9+GlrGflY2/Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82s4hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:57:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGvrZK029301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:57:53 GMT
Received: from [10.50.37.13] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 09:57:50 -0700
Message-ID: <f4c65f7e-ccc7-4a0b-a6e8-df56d5c19d7f@quicinc.com>
Date: Mon, 22 Apr 2024 22:27:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: drop failed transmitted frames from metric
 calculation.
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240419170314.3117623-1-quic_kathirve@quicinc.com>
 <D0QHV8UV73N5.2N5E3MH37JQW7@gmail.com>
Content-Language: en-US
From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
In-Reply-To: <D0QHV8UV73N5.2N5E3MH37JQW7@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Lm9Oh1CLxx70fl5EU5rVNJDgfl-JA8wa
X-Proofpoint-ORIG-GUID: Lm9Oh1CLxx70fl5EU5rVNJDgfl-JA8wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220071



On 4/22/2024 1:35 PM, Nicolas Escande wrote:
> On Fri Apr 19, 2024 at 7:03 PM CEST, Karthikeyan Kathirvel wrote:
> [...]
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> index 9b6d7d72f57c..164431b7eb4e 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
>> @@ -481,18 +481,36 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
>>   	/* skip tx rate update from ieee80211_status*/
>>   	info->status.rates[0].idx = -1;
>>   
>> -	if (ts->status == HAL_WBM_TQM_REL_REASON_FRAME_ACKED &&
>> -	    !(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
>> -		info->flags |= IEEE80211_TX_STAT_ACK;
>> -		info->status.ack_signal = ATH12K_DEFAULT_NOISE_FLOOR +
>> -					  ts->ack_rssi;
>> -		info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
>> +	switch (ts->status) {
>> +	case HAL_WBM_TQM_REL_REASON_FRAME_ACKED:
>> +		if (!(info->flags & IEEE80211_TX_CTL_NO_ACK)) {
>> +			info->flags |= IEEE80211_TX_STAT_ACK;
>> +			info->status.ack_signal = ATH12K_DEFAULT_NOISE_FLOOR +
>> +						  ts->ack_rssi;
>> +			info->status.flags = IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
>> +		}
>> +		break;
>> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX:
>> +		if (info->flags & IEEE80211_TX_CTL_NO_ACK) {
>> +			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
>> +			break;
>> +		}
>> +		fallthrough;
>> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_MPDU:
>> +	case HAL_WBM_TQM_REL_REASON_DROP_THRESHOLD:
>> +	case HAL_WBM_TQM_REL_REASON_CMD_REMOVE_AGED_FRAMES:
>> +		/* The failure status is due to internal firmware tx failure
>> +		 * hence drop the frame do not update the status of frame to
>> +		 * the upper layer
>> +		 */
>> +		dev_kfree_skb_any(msdu);
> Shouldn't this be ieee80211_free_txskb ? I'm not clear when to use which.
Yes, there is an internal patch is in pipeline, that will take care of 
addressing all dev_kfree_skb_any() to ieee80211_free_txskb() in 
ath12k_dp_tx_complete_msdu(), this patch doesn't take care of that.
>> +		goto exit;
>> +	default:
>> +		ath12k_dbg(ab, ATH12K_DBG_DP_TX, "tx frame is not acked status %d\n",
>> +			   ts->status);
>> +		break;
>>   	}
>>   
>> -	if (ts->status == HAL_WBM_TQM_REL_REASON_CMD_REMOVE_TX &&
>> -	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
>> -		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
>> -
>>   	/* NOTE: Tx rate status reporting. Tx completion status does not have
>>   	 * necessary information (for example nss) to build the tx rate.
>>   	 * Might end up reporting it out-of-band from HTT stats.
> 
> Thanks

