Return-Path: <linux-wireless+bounces-8343-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E98D5F36
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4581F238BE
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C147313664C;
	Fri, 31 May 2024 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oU1aQy7z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD89558A5
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149938; cv=none; b=tllkL/mrCMVTHrZrSHPN/GkwMRTzzXUCTLkz5F2nq4HmD/dbtgeQB+jVzUyLDawNMaFJJr9yFnlwLOPgVKTpoegP8J7wPwdE1VCZ5zFyC5sSjWdcqBAjjn8XHDSPzZQv4RmuOjKz6g1IWDzC0bMgIzJ1moThKpvfiU6nDMCNJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149938; c=relaxed/simple;
	bh=u5IKBCGF4PDEPAmFGV1+NscU2wll0EbwA/6tUDIvGA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fA368MY5gDvf39EelJ3oOdR7g+JFsm9S2JozV7yY/exhQLSiJqsFSeHL1uMbvyfwrLL8JmD24QDcf25H7U1Adep5P8WaI+dJlCK8cCAXVPNczCAOxkff085ntf1TM/7Wbk1b9TPN+BzFPYX+XsZDk1fBrr+FUvIB+faBF8Zkt+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oU1aQy7z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V7YD3E003129;
	Fri, 31 May 2024 10:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rKVuoKznSNkUWNCln/Gy6NfeFRO+cFje7ysWLbAk9JA=; b=oU1aQy7z5mEnGZcY
	74gOdzc7LS/HGxZvNxXU0N14uW/OO9meWquAkKR8eDbcUQ5jN+4+gJzOgVAESVE2
	v9HYLFpXZNe+4tovZJcr3sdipv7uJFelr6yq2ViHs8gXQAnVQLiJZTDGtrsl56gz
	FlsIH4KXMBht30kdLl2H6J2Uw192kwUhaJK1NHirlXmDM1DBayMeqJG9OMMP0paY
	1QRaYcq1r48bIg0zwiPR/P0xvt7Q+PdLMSoo2yYVo4EKctJuep47ulmQh2hX4gOO
	L7cEocnjdi+CN2DwoBWh4+UiufWqbeeq1J8CS/q3QMHTaYxlTRpqzTODfbc1UjpX
	Eh343g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfa9bgct5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 10:05:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44VA5TOr021904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 10:05:29 GMT
Received: from [10.152.206.169] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 31 May
 2024 03:05:27 -0700
Message-ID: <cc0fdf88-7046-eb93-265b-35a2d7299952@quicinc.com>
Date: Fri, 31 May 2024 15:35:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v7 0/8] wifi: ath12k: Introduce device group abstraction
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Baochen Qiang
	<quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240528063547.1400700-1-quic_hprem@quicinc.com>
 <396d645d-6f3b-4c1b-9d4b-d056fad36192@quicinc.com>
 <7b92a6cd-187d-4b6d-8cfb-af54365751fc@quicinc.com>
 <d7898dd9-b3d2-45a1-8581-41d16b900a27@quicinc.com>
Content-Language: en-US
From: Harshitha Prem <quic_hprem@quicinc.com>
In-Reply-To: <d7898dd9-b3d2-45a1-8581-41d16b900a27@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CJCyKGWWW82jmUWcNyuEk5NA35wG7gHN
X-Proofpoint-GUID: CJCyKGWWW82jmUWcNyuEk5NA35wG7gHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_06,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310075



On 5/30/2024 3:58 AM, Jeff Johnson wrote:
> On 5/28/2024 8:13 PM, Baochen Qiang wrote:
>>
>>
>> On 5/29/2024 6:04 AM, Jeff Johnson wrote:
>>> On 5/27/2024 11:35 PM, Harshitha Prem wrote:
>>>> To support multi-link operation, multiple devices with different bands say
>>>> 2 GHz or 5 GHz or 6 GHz can be combined together as a group and provide
>>>> an abstraction to mac80211.
>>>>
>>>> Device group abstraction - when there are multiple devices that are
>>>> connected by any means of communication interface between them, then these
>>>> devices can be combined together as a single group using a group id to form
>>>> a group abstraction. In ath12k driver, this abstraction would be named as
>>>> ath12k_hw_group (ag).
>>>>
>>>> Please find below illustration of device group abstraction with two
>>>> devices.
>>>>
>>>>                   Grouping of multiple devices (in future)
>>>> +------------------------------------------------------------------------+
>>>> |  +-------------------------------------+       +-------------------+   |
>>>> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
>>>> |  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
>>>> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
>>>> |  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
>>>> |  |         (Dual band device)          |       |                   |   |
>>>> |  +-------------------------------------+       +-------------------+   |
>>>> |                 ath12k_hw_group (ag) based on group id                 |
>>>> +------------------------------------------------------------------------+
>>>>
>>>> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
>>>> device 2 has one radio (6 GHz).
>>>>
>>>> In existing code -
>>>>          device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
>>>>          (5 GHz) will be registered separately to mac80211 as phy0 and phy1
>>>>          respectively. Similarly, device 2 will register its hw (6GHz) as
>>>>          phy2 to mac80211.
>>>>
>>>> In future, with multi-link abstraction
>>>>
>>>>          combination 1 - Different group id for device1 and device 2
>>>>                  Device 1 will create a single hardware abstraction hw1
>>>>                  (2 GHz and  5 GHz) and will be registered to mac80211 as
>>>>                  phy0. similarly, device 2 will register its hardware
>>>>                  (6 GHz) to mac80211 as phy1.
>>>>
>>>>          combination 2 - Same group id for device1 and device 2
>>>>                  Both device details are combined together as a group, say
>>>>                  group1, with single hardware abstraction of radios 2 GHz,
>>>>                  5 GHz and 6 GHz band details and will be registered to
>>>>                  mac80211 as phy0.
>>>>
>>>> Add base infrastructure changes to add device grouping abstraction with
>>>> a single device.
>>>>
>>>> This patch series brings the base code changes with following order:
>>>>          1. Refactor existing code which would facilitate in introducing
>>>>             device group abstraction.
>>>>          2. Create a device group abstraction during device probe.
>>>>          3. Start the device group only after QMI firmware ready event is
>>>>             received for all the devices that are combined in the group.
>>>>          4. Move the hardware abstractions (ath12k_hw - ah) from device
>>>>             (ath12k_base - ab) to device group abstraction (ag) as it would
>>>>             ease in having different combinations of group abstraction that
>>>>             can be registered to mac80211.
>>>>
>>>> v7:
>>>>     - Added linux-wireless mailer to cc.
>>>>     - Removed Acked-by tag from "[PATCH v6 8/8]" as it has minor change.
>>>>
>>>> v6:
>>>>    - Addressed smatch error seen on "[PATCH v5 8/8] wifi: ath12k: move
>>>>      ath12k_hw from per soc to group"
>>>>    - Rebased to ToT
>>>> v5:
>>>>    - on "[PATCH 8/8] wifi: ath12k: move ath12k_hw from per soc to
>>>>      group", refactor the ath12k_mac_hw_allocate() api based on ag rather
>>>>      than ab and update hardware abstraction array size in ath12k_hw_group
>>>>      as ATH12K_GROUP_MAX_RADIO.
>>>>    - Rebased to ToT
>>>> v4:
>>>>    - Modified the cover letter
>>>> v3:
>>>>    - Removed depends-on tag of "wifi: ath12k: Refactor the hardware recovery
>>>>      procedures" as it is merged to ToT
>>>>    - Addressed the deadlock warning seen during rmmod.
>>>>
>>>> v2:
>>>>   - Rebased to ToT
>>>>
>>>> Karthikeyan Periyasamy (8):
>>>>    wifi: ath12k: Refactor core start api
>>>>    wifi: ath12k: Add helpers to get or set ath12k_hw
>>>>    wifi: ath12k: Add ath12k_get_num_hw api
>>>>    wifi: ath12k: Introduce QMI firmware ready flag
>>>>    wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
>>>>    wifi: ath12k: Introduce device group abstraction
>>>>    wifi: ath12k: refactor core start based on hardware group
>>>>    wifi: ath12k: move ath12k_hw from per device to group
>>>>
>>>>   drivers/net/wireless/ath/ath12k/core.c | 431 +++++++++++++++++++++----
>>>>   drivers/net/wireless/ath/ath12k/core.h |  87 ++++-
>>>>   drivers/net/wireless/ath/ath12k/dp.c   |  19 +-
>>>>   drivers/net/wireless/ath/ath12k/dp.h   |   2 +-
>>>>   drivers/net/wireless/ath/ath12k/mac.c  | 117 ++++---
>>>>   drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
>>>>   drivers/net/wireless/ath/ath12k/pci.c  |   2 +
>>>>   drivers/net/wireless/ath/ath12k/qmi.c  |  10 +-
>>>>   8 files changed, 544 insertions(+), 133 deletions(-)
>>>>
>>>>
>>>> base-commit: f8320064a28242448eeb9fece08abd865ea8a226
>>>
>>> With this series I'm seeing a firmware crash upon resume from hibernation, but
>>> I'm not sure if it is the same intermittent crash I reported in another thread
>>> where firmware is not correctly handling a low physical memory address.
>>>
>>> Baochen & Kalle, since this issue may be specific to my laptop, can you
>>> validate hibernation on your setups?
>> I can also see a firmware crash upon resume. I am using ath-202405281746 as code base.
> 
> I bisected to:
> [PATCH v7 7/8] wifi: ath12k: refactor core start based on hardware group
> 
> 
Thank you so much, Jeff. Identified the possible reason that is causing 
the firmware assert with hibernation scenario and will address it in 
next version.

