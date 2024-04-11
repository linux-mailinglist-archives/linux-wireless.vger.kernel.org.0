Return-Path: <linux-wireless+bounces-6203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39628A208F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 23:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACBD1F275A3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A215E8C;
	Thu, 11 Apr 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q7SPn9qf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C082205E2B
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869213; cv=none; b=BaYkK+rCiK3JyL0YksicGUDHH5E7he4let4e7Xm9kV/sfVcYc9pPvKQ8K4yLeCs65POFnkrKX8xFOVpHdtYPQgkZSFHKz4POQ20W1p1NmwJUslC0BQb+TxS4ZQyWQ/PDHy4DVBZAU2n+G4H1YhAVtzRL+3suo5nqrB8R2gsTsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869213; c=relaxed/simple;
	bh=nt7xfVcuARM0uTDhvvf+CGr80ESEL3NmS+G15DBECjs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=SuLpyTPeYsig81DdQ7qiaCT8rGj42bWIhd6mUOo+Nh2PNIu25cKmOBigb+WFTVFQeSKSkDQJaymXOwUOaMPdvMsK/k3Y+5nT8x6GcXFKE1uWJu0UQjl3k6kLClTvUC9g7khO6SlG8zSIRyrSRipN94DCwOxL7tNlPV+9lZYIGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q7SPn9qf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BKqnAM005971;
	Thu, 11 Apr 2024 21:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=idpkFfUV94TslMlWg/88sGDLxKPZFjAUmc7uAgAFmjU=; b=Q7
	SPn9qf/hXRfM3sl0edz8eILE519EqT8akkqEWQrMfGIXaftC29BXn7fYATkO+kbQ
	sQwNqY1B1DYGaUK0rYtJY829TTWxXHxkUgdRXpBOrwsWtsm371SAT/owKMCnRI2N
	EdLtcjOrb0UmEkiUMitj7mgFSHted4CVYOjQykmUcLqZiH01wtLsGhb6Ah6/TzQy
	iCbe7iHZp4TXvStycjodRTqUFWRzRuEgiROkKs98KWv9WPPl+IuIWRDrmkURCkUX
	rHOWmgru7Iz7kDiGw48ubw21kpoTodc08MHauUBqZxGUUAPWycpoaM0Jznxc0uBg
	xmppAOGOH8Q8ycG3Af6A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeb2rjhpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:00:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BL009i002544
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:00:00 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 14:00:00 -0700
Message-ID: <b441cf78-cf1e-4f09-beb4-634b8d4b564b@quicinc.com>
Date: Thu, 11 Apr 2024 13:59:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240411165645.4071238-1-kvalo@kernel.org>
 <e8618364-e547-41e1-b18f-4cddeafd3371@quicinc.com>
In-Reply-To: <e8618364-e547-41e1-b18f-4cddeafd3371@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xiLt4Kndvt8Gug0H17NMKsUDREAeaydE
X-Proofpoint-GUID: xiLt4Kndvt8Gug0H17NMKsUDREAeaydE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=914 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110153

On 4/11/2024 12:41 PM, Jeff Johnson wrote:
> On 4/11/2024 9:56 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> ath12k will support Multi-Link Operation (MLO) in the future but not yet. A
>> major change with MLO is that cfg80211 will disable Wireless Extension (WEXT)
>> user space interface. To avoid having inconsistent user experience, first
>> supporting WEXT and later not, disable WEXT already now.
>>
>> Now ath12k claims that WEXT is not supported:
>>
>> $ iwconfig wlan0
>> wlan0     no wireless extensions.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>> index f15dcd75157d..e989628d7d72 100644
>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>> @@ -8556,6 +8556,12 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>>  	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
>>  				   NL80211_FEATURE_AP_SCAN;
>>  
>> +	/* MLO is not yet supported so disable Wireless Extensions for now
>> +	 * to make sure ath12k users don't use it. This flag can be removed
>> +	 * once WIPHY_FLAG_SUPPORTS_MLO is enabled.
>> +	 */
>> +	wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
>> +
>>  	hw->queues = ATH12K_HW_MAX_QUEUES;
>>  	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
>>  	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
>>
>> base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
> 
> Currently on my version of Ubuntu when I switch to Hotspot mode I'm seeing:
> [   55.189623] warning: `iwconfig' uses wireless extensions which will stop
> working for Wi-Fi 7 hardware; use nl80211
> 
> So are userspace folks aware of the need to move away from iwconfig?
> Is there a Ubuntu / Network Manager fix fir this?

And I've confirmed that with this patch in place I cannot start the Hotspot.
So suggest you sit on that until userspace is ready.

/jeff


