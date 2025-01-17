Return-Path: <linux-wireless+bounces-17617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64EA148EB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 05:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7178168561
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 04:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462CB1F63E3;
	Fri, 17 Jan 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B9RbpC96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267F1F63C6
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737088650; cv=none; b=qy4KwR7U6adhZP7JPChEg0NS6di0FqkupWslsvkub/YMUnlmEkwvQe66mIe7wJiukxrBRrinwvFAoaWUnTQI4jJ+VCGVNTBbaiNv3+2xk7PkVhywoP8YZB1x6i4Th1e3Q5tyBCVcx8gJSgM9NEVXAB/h77eLf+tZA7VitcQhKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737088650; c=relaxed/simple;
	bh=HsGv7wZj3LBwu0NrvupYzBgX4RtOIUahuA97qI9PnSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YeZs2q83eNDE1dfdiWSapKF3YMdAuJFYwbC1PkBdrH6EzT5ai3NmnDNTN66UWjFKCtnIzC0touYeYBpbO/mhY/n50xtMkH39ULPHBpp7QFR3yfShSQQ9U7nLHOM6XKErbUB5jGLvNZKaBNNz8+JJDj01VFlAMbnPzir896IxwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B9RbpC96; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GKx9WL029080;
	Fri, 17 Jan 2025 04:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8E89dybjaPA3cOgxUl+Lo8Spm50soae98tpHODi5GOk=; b=B9RbpC960L1+ePhl
	5JwMruI8iyRNtRNLsP6XHQBCaffOENMrMRYdRmrOBQjhhR6dYY/v2aBaS8+52IBL
	8hY5Ad1y12AvwUciN0u+uXL4pKDY8RiOiF0GP49QRO/3qWWBdosCRqiTjYAuyAk7
	zgF4hlAk6bjqAop4wjRmhp6o6pLVnjb5c44vQA01YzAfKm/EwNj0TGxvRWJ0kndD
	m82m3fejc/6Q+TDW8EO5/J8FEdMjk5Ra0zSGorUFTd50QLwy04b7ZA8aR8005UT1
	JBo4A5P9joKExM7U7sF47o9rGRpOKJTD16tkSNoX/92IHFKadKypTy9PUFMdUDpc
	upOQWw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4479mf8sfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 04:37:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50H4bM05018643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 04:37:22 GMT
Received: from [10.216.26.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 Jan
 2025 20:37:18 -0800
Message-ID: <d9181c82-ffb1-e8de-c5c6-f58b73f9291f@quicinc.com>
Date: Fri, 17 Jan 2025 10:07:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/7] wifi: ath12k: Add monitor interface support on
 QCN9274
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250107021017.3857555-1-quic_periyasa@quicinc.com>
 <D72U91ZG2PNM.2IXUT304LMEC0@gmail.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <D72U91ZG2PNM.2IXUT304LMEC0@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gu27F9BVXJUP77n_dTSJzx82_00iJmOd
X-Proofpoint-ORIG-GUID: gu27F9BVXJUP77n_dTSJzx82_00iJmOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_01,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170033



On 1/15/2025 11:25 PM, Nicolas Escande wrote:
> On Tue Jan 7, 2025 at 3:10 AM CET, Karthikeyan Periyasamy wrote:
>> Currently, monitor interface not supported. Therefore, add the missed TLV
>> tags parsing in the monitor parser, configure the monitor vdev state
>> identifier with HTT filter setup.
>>
>> Depends-On:
>> 	[PATCH v3 0/3] wifi: ath12k: Refactor monitor Rx handler
>> 	https://lore.kernel.org/all/20241224143613.164921-1-quic_periyasa@quicinc.com/
>>
>> 	[PATCH v2 00/14] wifi: ath12k: Enable monitor ring for updating station dump in QCN9274
>> 	https://lore.kernel.org/all/20241223060132.3506372-1-quic_ppranees@quicinc.com/
>>
>> 	[PATCH v2 00/10] wifi: ath12k: Add peer extended Rx statistics debugfs support
>> 	https://lore.kernel.org/all/20241224161442.263729-1-quic_periyasa@quicinc.com/
>>
>> Hari Chandrakanthan (1):
>>    wifi: ath12k: fix link valid field initialization in the monitor Rx
>>
>> Karthikeyan Periyasamy (1):
>>    wifi: ath12k: Replace band define G with GHZ where appropriate
>>
>> P Praneesh (5):
>>    wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
>>    wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
>>    wifi: ath12k: change the status update in the monitor Rx
>>    wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
>>    wifi: ath12k: add monitor interface support on QCN9274
>>
> [...]
> 
> Hello,
> 
> There might be something wrong with this series.
> 
> I applied it on top of ath-pending-202501150104 + the "ath12k: Add peer extended
> Rx statistics debugfs support" and now 'iw dev wlan0 station dump' shows me
> that the RSSI value seems to not be updated anymore after I stop a monitor
> interface on the same phy.
> 
> Steps to reproduce:
> iw phy phy0 interface add mon0 type monitor
> ip link set mon0 up
> # then just for 1 sec but it might not be usefull at all
> tcpdump -nepi mon0
> ip link set mon0 down
> watch -n1 iw dev wlan0 station dump
> # 'signal' seems to not be updating anymore, maybe some other fields too ?
> 

Not able to find the wlan0 interface details from the above steps ?


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

