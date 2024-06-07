Return-Path: <linux-wireless+bounces-8692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B0900594
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 15:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3926B21A35
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D5B194A53;
	Fri,  7 Jun 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oE9dZCQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA71CA85
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768244; cv=none; b=nPwxKPCy82iKZG36bo0nAJykQeTW9JL7iodenxM3pnYDTj7XjnKr70esbywZKFOTCLeDZLjqwGs5wa/3EWFJa+22NWSJg9QEAHA/e8L892PchmxsrZWtNHw5mI5UdNu3m2TkPeh4LOUepjo9aH74qeR3X3fSZDHPae4g3za/qZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768244; c=relaxed/simple;
	bh=y68FqPYOAd01Tp6uW7W0GcF+XpxanqKyBlSkZ3x40WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AkjxLf1D6FUeCQhJMjYWZrjXfBMFcQjZpI31QNplnQDgqjNB3YhEd6CmSZ5X3yYy2xJOoOtgqS4Rr8dNEnwxhrtzILzlsNJvHB8qrpO/fBhA+BRTo//NJQtni+CdkmuUI3wxClzBD7v06soWM4j61NlTVk0Fk34QO3X2bNl7Jwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oE9dZCQY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457Ami1h023664;
	Fri, 7 Jun 2024 13:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MYU01ey1UppdWrhYAwMrlz/e+tvn2KLlRkKjXtOqk2I=; b=oE9dZCQYhNKhtdnA
	rsZ2JVVrQkU2Owodf8XuEh6IlfH2MsrQ/HTnxK6sNLYWksMTOfEBamt7NAbe4mT3
	ylnwtSyF8+KHcY+Cgk1qiOmGpytFe4Pc4qOiyUs1odIMoe3Hq8mR7KKzLkM2EBIe
	LXNLve/rzyHpfNoCqaPdEgMs1z0yRMpORXDUMp6/PGuSXYbiNaTtZPSNQxaHedOe
	giekj9y5av/NiHxflCb8NQOm0Pj6HO9IQYiLfSnZvhGA7JmsKeBkRiMHZ0aQ1BdW
	Po+LXi3uPLc21CMSBHxmL7tzfcqeTkj928jdv3WclOBhqCYBCZ73uJvEms1MLEfZ
	CUxb9g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ym0sf0h5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 13:50:36 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457DoZWD020012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 13:50:35 GMT
Received: from [10.216.36.52] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Jun 2024
 06:50:33 -0700
Message-ID: <2fc7a5c7-126a-bd16-7d7b-46071768871c@quicinc.com>
Date: Fri, 7 Jun 2024 19:20:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v8 0/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
 <52108cb7-621c-40fe-a556-ed0b4b36371f@quicinc.com>
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <52108cb7-621c-40fe-a556-ed0b4b36371f@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TGR3pMNHG7_YgrSSNNbpZOuqWfcA5UnL
X-Proofpoint-ORIG-GUID: TGR3pMNHG7_YgrSSNNbpZOuqWfcA5UnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_07,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=883 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070100



On 6/3/2024 9:41 PM, Jeff Johnson wrote:
> On 5/31/2024 11:04 AM, Harshitha Prem wrote:
>> To support multi-link operation, multiple devices with different bands say
>> 2 GHz or 5 GHz or 6 GHz can be combined together as a group and provide
>> an abstraction to mac80211.
>>
>> Device group abstraction - when there are multiple devices that are
>> connected by any means of communication interface between them, then these
>> devices can be combined together as a single group using a group id to form
>> a group abstraction. In ath12k driver, this abstraction would be named as
>> ath12k_hw_group (ag).
>>
>> Please find below illustration of device group abstraction with two
>> devices.
>>
>>                   Grouping of multiple devices (in future)
>> +------------------------------------------------------------------------+
>> |  +-------------------------------------+       +-------------------+   |
>> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
>> |  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
>> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
>> |  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
>> |  |         (Dual band device)          |       |                   |   |
>> |  +-------------------------------------+       +-------------------+   |
>> |                 ath12k_hw_group (ag) based on group id                 |
>> +------------------------------------------------------------------------+
>>
>> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
>> device 2 has one radio (6 GHz).
>>
>> In existing code -
>>          device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
>>          (5 GHz) will be registered separately to mac80211 as phy0 and phy1
>>          respectively. Similarly, device 2 will register its hw (6GHz) as
>>          phy2 to mac80211.
>>
>> In future, with multi-link abstraction
>>
>>          combination 1 - Different group id for device1 and device 2
>>                  Device 1 will create a single hardware abstraction hw1
>>                  (2 GHz and  5 GHz) and will be registered to mac80211 as
>>                  phy0. similarly, device 2 will register its hardware
>>                  (6 GHz) to mac80211 as phy1.
>>
>>          combination 2 - Same group id for device1 and device 2
>>                  Both device details are combined together as a group, say
>>                  group1, with single hardware abstraction of radios 2 GHz,
>>                  5 GHz and 6 GHz band details and will be registered to
>>                  mac80211 as phy0.
>>
>> Add base infrastructure changes to add device grouping abstraction with
>> a single device.
>>
>> This patch series brings the base code changes with following order:
>>          1. Refactor existing code which would facilitate in introducing
>>             device group abstraction.
>>          2. Create a device group abstraction during device probe.
>>          3. Start the device group only after QMI firmware ready event is
>>             received for all the devices that are combined in the group.
>>          4. Move the hardware abstractions (ath12k_hw - ah) from device
>>             (ath12k_base - ab) to device group abstraction (ag) as it would
>>             ease in having different combinations of group abstraction that
>>             can be registered to mac80211.
>>
>> v8:
>>    - Addressed firmware assert issue seen during hibernation scenario in
>>      "[PATCH v7 7/8] wifi: ath12k: refactor core start based on hardware group"
>>
>> v7:
>>     - Added linux-wireless mailer to cc.
>>     - Removed Acked-by tag from "[PATCH v6 8/8]" as it has minor change.
>>
>> v6:
>>    - Addressed smatch error seen on "[PATCH v5 8/8] wifi: ath12k: move
>>      ath12k_hw from per soc to group"
>>    - Rebased to ToT
>> v5:
>>    - on "[PATCH 8/8] wifi: ath12k: move ath12k_hw from per soc to
>>      group", refactor the ath12k_mac_hw_allocate() api based on ag rather
>>      than ab and update hardware abstraction array size in ath12k_hw_group
>>      as ATH12K_GROUP_MAX_RADIO.
>>    - Rebased to ToT
>> v4:
>>    - Modified the cover letter
>> v3:
>>    - Removed depends-on tag of "wifi: ath12k: Refactor the hardware recovery
>>      procedures" as it is merged to ToT
>>    - Addressed the deadlock warning seen during rmmod.
>>
>> v2:
>>   - Rebased to ToT
>>
>>
>> Karthikeyan Periyasamy (8):
>>    wifi: ath12k: Refactor core start api
>>    wifi: ath12k: Add helpers to get or set ath12k_hw
>>    wifi: ath12k: Add ath12k_get_num_hw api
>>    wifi: ath12k: Introduce QMI firmware ready flag
>>    wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
>>    wifi: ath12k: Introduce device group abstraction
>>    wifi: ath12k: refactor core start based on hardware group
>>    wifi: ath12k: move ath12k_hw from per device to group
>>
>>   drivers/net/wireless/ath/ath12k/core.c | 427 +++++++++++++++++++++----
>>   drivers/net/wireless/ath/ath12k/core.h |  87 ++++-
>>   drivers/net/wireless/ath/ath12k/dp.c   |  19 +-
>>   drivers/net/wireless/ath/ath12k/dp.h   |   2 +-
>>   drivers/net/wireless/ath/ath12k/mac.c  | 117 ++++---
>>   drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
>>   drivers/net/wireless/ath/ath12k/pci.c  |   2 +
>>   drivers/net/wireless/ath/ath12k/qmi.c  |  10 +-
>>   8 files changed, 540 insertions(+), 133 deletions(-)
>>
>>
>> base-commit: 6e7a5c6d5e38b93f9cc3289d66a597b9a4ca0403
> 
> this no longer applies cleanly to ath/master or ath/ath-next,
> can you please rebase and repost?
> 
Sure Jeff, will rebase and repost with comments addressed.

Thank you.

