Return-Path: <linux-wireless+bounces-6277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A08A3E32
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Apr 2024 21:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73601C2093F
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Apr 2024 19:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21EC4C637;
	Sat, 13 Apr 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U81LjPlo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6292901
	for <linux-wireless@vger.kernel.org>; Sat, 13 Apr 2024 19:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713035717; cv=none; b=YQsRUk1mK1qgfx7Z7sFYLuNtxKFYJVH+78dV8zM6QP31sIgxAk06smWafR1RBEkRy0SiObJgdXp/LpinOux35oxAlGCM7io6whHPI7NvsnRdcPR0AH9upAMGH/3NEftqzZhe6Lf3ZNIi6B2RyI7lZH5ikFh7WtQ4GNEGp2XXIGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713035717; c=relaxed/simple;
	bh=tojD15hbjDlFL7EezZKmwP+uOEnDUhI9KiGCe05GDpQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=mDsA6/JyKvSPzOZIsPaxaCIIhVyZWG18xdXhUa6t9RChl7PqeoeJvhy0o6mLGqd12D4uEBjkvcII6TEPvw497t9jzvq6+3RxX8qVWvZEiUuWclnTtqTR78XafYYNkWgw9MftYm4UMWNqaFK46+yVw37qnmJcSL8TmjO4pmGusMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U81LjPlo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43DIrV6l003108;
	Sat, 13 Apr 2024 19:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=t5mgxfJuUw821fzqNDGvWmLREVXh2YOEXZBv9+bOMtY=; b=U8
	1LjPlovC8h4FnqFIrJbLe2iX3OZiM9/2e7g4RRd1G8E1KiD9MQoENL9+7FmQsxtb
	7m7W3lPcEWJLVIlBDnJ4brdX8qnDLz/Z1eMLK+qxI1xiUzJB4eIWWNDt026Yharw
	HjvIKH+oVp03fgDqIFDtAJ+55UXYntckzGfzBW9m2uQDtXylLopafMUof5M49O+x
	NLNANhjb+ORlOgYt1/6MBaMU+FbWk6lP7FpsCQMP51G+045diQVQi/z2748dmMKI
	FkegS+6SWZMX/q1Op5NKfOpcX4Npn9LlVQMk8l/rK05PsRI5leRhdvjx7ENWRyQy
	ZGVhUVyx1QGkvVw1JfLw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfhn40u5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 19:15:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43DJF5g9030627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 19:15:05 GMT
Received: from [10.110.3.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 13 Apr
 2024 12:15:04 -0700
Message-ID: <ab9fd6ca-10cd-43a7-9d78-a6e740983869@quicinc.com>
Date: Sat, 13 Apr 2024 12:15:03 -0700
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
 <b441cf78-cf1e-4f09-beb4-634b8d4b564b@quicinc.com>
In-Reply-To: <b441cf78-cf1e-4f09-beb4-634b8d4b564b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CPoA1wGJSe3daVJ02r0hym4RzI5L4xo7
X-Proofpoint-GUID: CPoA1wGJSe3daVJ02r0hym4RzI5L4xo7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=939 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404130143

On 4/11/2024 1:59 PM, Jeff Johnson wrote:
> On 4/11/2024 12:41 PM, Jeff Johnson wrote:
>> On 4/11/2024 9:56 AM, Kalle Valo wrote:
>>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>>
>>> ath12k will support Multi-Link Operation (MLO) in the future but not yet. A
>>> major change with MLO is that cfg80211 will disable Wireless Extension (WEXT)
>>> user space interface. To avoid having inconsistent user experience, first
>>> supporting WEXT and later not, disable WEXT already now.
>>>
>>> Now ath12k claims that WEXT is not supported:
>>>
>>> $ iwconfig wlan0
>>> wlan0     no wireless extensions.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>>> ---
>>>  drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>>> index f15dcd75157d..e989628d7d72 100644
>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>> @@ -8556,6 +8556,12 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>>>  	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
>>>  				   NL80211_FEATURE_AP_SCAN;
>>>  
>>> +	/* MLO is not yet supported so disable Wireless Extensions for now
>>> +	 * to make sure ath12k users don't use it. This flag can be removed
>>> +	 * once WIPHY_FLAG_SUPPORTS_MLO is enabled.
>>> +	 */
>>> +	wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
>>> +
>>>  	hw->queues = ATH12K_HW_MAX_QUEUES;
>>>  	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
>>>  	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
>>>
>>> base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9
>>
>> Currently on my version of Ubuntu when I switch to Hotspot mode I'm seeing:
>> [   55.189623] warning: `iwconfig' uses wireless extensions which will stop
>> working for Wi-Fi 7 hardware; use nl80211
>>
>> So are userspace folks aware of the need to move away from iwconfig?
>> Is there a Ubuntu / Network Manager fix fir this?
> 
> And I've confirmed that with this patch in place I cannot start the Hotspot.
> So suggest you sit on that until userspace is ready.

It turns out that once I configured the Hotspot explicitly for 2.4 GHz
operation that it works even with this patch in place. So I have a separate
issue somewhere with 5 GHz Hotspot operation.

So this patch can go forward...
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



