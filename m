Return-Path: <linux-wireless+bounces-6358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8228A6110
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 04:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED361C20A8C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 02:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957D0A38;
	Tue, 16 Apr 2024 02:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="osEy2wog"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F2A34
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 02:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234776; cv=none; b=tYcDQaYOIv+vlKsI5Rry+5N66SS/wXs0/ZXAfUKjAIjtqKrI4DTTMzFkGwOI0IBF6/oggB2L7c/INQb6o8ecitD55Q9qhsbNBlGyhxgrgea/3teSQL5Aei5JjmYwOIbm3tJAPvIKRoujG/JuF4N/f7hRfo4sA3gio0jVBw9f13Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234776; c=relaxed/simple;
	bh=7AHkriU1CVNP4ETpEP/VxQCsyjWfLtijP4+QkxHCkvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R3YV2SpavWDKuBTAkkGkddKZwTIbpVCqiTNlgt1Tiu/p/lPA74A5J6NZbkn1m6dvwoq5farvBgKHiZwmAdQkRVAoDzCoIf9fiYlD3SjatZOJZRJ1tx1lWTPJX22j3svLpn/H6HqtYoON5PX2LoWEEpV/rsTuCJPHqiGxswf8Yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=osEy2wog; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FNlXlc011240;
	Tue, 16 Apr 2024 02:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JfxBhNcHTp6rosHCfxl1lr6W6uZBHS1zFih12ed4yso=; b=os
	Ey2wogRQuP4rAaBju+KbijsxMPbChBuqyGCrgRXJ9RUvCUFovRG4Ms9hGJ9kO1Qs
	wyUwAw7V4lwtwEOUUOPxHyalwbucKzzDO93bXv9spITXgbQ+KU9/uIgIDIMqzSYv
	NDG+eLewf5SqV+Te2o5FzOn+5RRxuq2Aau4ieAXy//1/q8jyG92/yjb315obuU1Q
	BCtQsnTP7vInXdKTE9uohDAyF8iiVMoIQkrB1gPCUt94oehtPTzI5dNFFkZ/rVcR
	9i6p9RqjikpM8RD4uke0Ur+B4NRQ3d48qEtG7l91LY59gCJndZ4YI16xmaW1nE0y
	JPHRHi/nm7oZpAgUX4Nw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xh5jx9fa4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 02:32:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43G2Wmew004565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 02:32:48 GMT
Received: from [10.110.8.16] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 19:32:47 -0700
Message-ID: <4658e8e9-9720-4622-9cd1-03faf790ea21@quicinc.com>
Date: Tue, 16 Apr 2024 10:32:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] wifi: ath12k: report station mode stats
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240414131008.71519-1-quic_lingbok@quicinc.com>
 <3103b7cf-fa1a-4bfc-ad78-301965b72035@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <3103b7cf-fa1a-4bfc-ad78-301965b72035@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ri2_7CtGdfN1OFgsnvHK_2Yj8P0iGCVl
X-Proofpoint-ORIG-GUID: Ri2_7CtGdfN1OFgsnvHK_2Yj8P0iGCVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_01,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160013



On 2024/4/16 0:51, Jeff Johnson wrote:
> On 4/14/2024 6:10 AM, Lingbo Kong wrote:
>> Currently, the transmit rate, the receive rate and signal strength of
>> “iw dev xxx station dump” always show an invalid value.
>>
>> This is because ath12k has no logic to handle this relevant information.
>>
>> To solve this issue, ath12k parses the information passed by the firmware
>> and passes it to mac80211.
>>
>> After that, "iw dev xxx station dump" show the correct value.
>> Such as:
>>
>> Station 00:03:7f:12:03:03 (on wlo1)
>>          inactive time:  600 ms
>>          rx bytes:       4642228
>>          rx packets:     23796
>>          tx bytes:       933967
>>          tx packets:     8761
>>          tx retries:     66
>>          tx failed:      0
>>          beacon loss:    0
>>          beacon rx:      8925
>>          rx drop misc:   191
>>          signal:         -20 dBm
>>          beacon signal avg:      -18 dBm
>>          tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>>          tx duration:    0 us
>>          rx bitrate:     1801.4 MBit/s 80MHz EHT-MCS 11 EHT-NSS 3 EHT-GI 0
>>          rx duration:    0 us
>>
>> v3:
>> 1.change wmi_vdev_stats_event to wmi_vdev_stats_params
>>
>> v2:
>> 1.change copyright
>> 2.change name according Naming conventions for structures
>>
>> Lingbo Kong (3):
>>    wifi: ath12k: report station mode transmit rate
>>    wifi: ath12k: report station mode receive rate for IEEE 802.11be
>>    wifi: ath12k: report station mode signal strength
>>
>>   drivers/net/wireless/ath/ath12k/core.h    |   5 +
>>   drivers/net/wireless/ath/ath12k/dp_rx.c   |  20 ++-
>>   drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
> 
> My Qualcomm Innovation Center copyright checker reports:
> drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2024
> 
> However note that "wifi: ath12k: support suspend/resume" is modifying the same
> file, so if you rebase on that you'll pick up the copyright change
> 

Ok, thanks for pointing out.

Best regards
Lingbo Kong

>>   drivers/net/wireless/ath/ath12k/dp_tx.c   | 147 +++++++++++++++++-
>>   drivers/net/wireless/ath/ath12k/hal_tx.h  |   9 +-
>>   drivers/net/wireless/ath/ath12k/mac.c     | 180 +++++++++++++++++++++-
>>   drivers/net/wireless/ath/ath12k/mac.h     |   3 +
>>   drivers/net/wireless/ath/ath12k/rx_desc.h |   2 +
>>   drivers/net/wireless/ath/ath12k/wmi.c     | 130 ++++++++++++++++
>>   drivers/net/wireless/ath/ath12k/wmi.h     |  48 ++++++
>>   10 files changed, 538 insertions(+), 9 deletions(-)
> 

