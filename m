Return-Path: <linux-wireless+bounces-8398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE968D7AEA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 07:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AEB1C20C9F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 05:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2AD17C77;
	Mon,  3 Jun 2024 05:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hUE7O13Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB22E12B83
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 05:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717391011; cv=none; b=MLyknMfvfa24+oyUpBc/UqBOClR66Kc7XjJPKrk8EwA0nNOeOxt6TpM+HF7idhhjfrmG4fkb3yQdeNWttScXkG7PhznEV15oABQSzg27zXkVlkP9b+YQ4Hjk2hWG3G9BSnhJPYQcKafrtanK/sOG1QEx4/1E+54KITVHF9pqj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717391011; c=relaxed/simple;
	bh=dnqjCzButwxwd92zG3LblM+Qf8mZVspmmVNA5ux4P0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ox5Wmear9TW+RkLG7xEaaOC2zfvnCzjMRlvUrAPMtnoa7Fq+y8PeOQoyUmucM3DQvkzj+MSU29UkQ11+3hykiAzYcyyautHZfjoG8eU0ur+wlQfFrEgTruJzxgX6bC8QfPwvkjLhGGcVYo8GW0p32c4AeQ3mxCTpriR7K+Nk4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hUE7O13Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4530TN7P019792;
	Mon, 3 Jun 2024 05:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nxQa0RT8lvXGcWqcyu5vkKdFsML3DG8qdjx2Mf4Bk9o=; b=hUE7O13QwJCjsmJ9
	MAZLokyitOmhnndGHpiTxAb+ATer3916TOPFYjgCjHyQ92fT2j61SnR7coEWlgx8
	ifOaTyy3KxBx3dN5bHsaILDmKd9rBM9hTG2RpLNUJu6O+r372U4DeJOTh2/Jvz8u
	6jrR05nT2KioH/F8JGMv/X+ceZb9N+/O1RX8+CWWMc9icpxcw9dzZHivxfq1fRWb
	IN0b6FIQ/bpSq4IszVn7iWzMwDFvjdaUOSNepZLnaXMRggu841pSNOLJaq9arGrH
	8brGIP4Ere21+V37MgS7lTEGOXV6MAUnWQf994h+9nfCAhvqOEer04Dyb6r66g9u
	Rx5MFw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw6qjynj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 05:03:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 45353FgO030762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 05:03:15 GMT
Received: from [10.152.201.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 22:03:12 -0700
Message-ID: <3453b0f2-6cf8-8377-127e-77f955593d3b@quicinc.com>
Date: Mon, 3 Jun 2024 10:33:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 0/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: <pgupta@hindutool.com>, <quic_hprem@quicinc.com>,
        <quic_jjohnson@quicinc.com>, <quic_bqiang@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240528063547.1400700-1-quic_hprem@quicinc.com>
 <396d645d-6f3b-4c1b-9d4b-d056fad36192@quicinc.com>
 <7b92a6cd-187d-4b6d-8cfb-af54365751fc@quicinc.com>
 <d7898dd9-b3d2-45a1-8581-41d16b900a27@quicinc.com>
 <cc0fdf88-7046-eb93-265b-35a2d7299952@quicinc.com>
 <1717161560.nw3mokq68g8og484@mailapp03.register.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <1717161560.nw3mokq68g8og484@mailapp03.register.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o1L4X6D6XhQgIJ37RHX2YnpiKWc0Xx_L
X-Proofpoint-ORIG-GUID: o1L4X6D6XhQgIJ37RHX2YnpiKWc0Xx_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_15,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030040



On 5/31/2024 6:49 PM, pgupta@hindutool.com wrote:
> Is there a limit to the number of hardware abstraction layers?

Please note that grouping multiple hardware under one wiphy is still not supported in 
ath12k. This patch series is a strep towards such architecture. When the full hardware 
grouping support is added, there will not be any restrictions in the number of hardware 
which can be be grouped under only wiphy.

  My current platform has 3 physical WiFi 7 modules in one machine - one for each 
frequency 2.4 GHz, 5 GHz, and 6GHz.  Is this currently not supported?

This should work with ath12k as all three will be registered as three different wiphys.

> What if I want to connect more than 3 modules including identical modules of the same frequency? My setup will not be utilizing combined frequency modules.

Grouping hardware having same frequency capability will make things very complex, I dont 
think it is worthy of the effort especially there is no obvious real use case to combine 
such radios under one wiphy.

> FYI, in my platform, each module is connected to its own PCIe slot, and has its own antennas so I assume it would be recognized as its own wireless device by the OS (i.e wlan0, wlan1, wlan2, etc.).
> 

Yes, each hardware will be registered as separate phy and wlan
interfaces with respective capability can be created on top of
them.

Vasanth


> 
> On Fri, 31 May 2024 15:35:24 +0530, Harshitha Prem <quic_hprem@quicinc.com> wrote:
> 
>>> On 5/30/2024 3:58 AM, Jeff Johnson wrote:
>>>> On 5/28/2024 8:13 PM, Baochen Qiang wrote:
>>>>>
>>>>>
>>>>> On 5/29/2024 6:04 AM, Jeff Johnson wrote:
>>>>>> On 5/27/2024 11:35 PM, Harshitha Prem wrote:
>>>>>>> To support multi-link operation, multiple devices with different bands say
>>>>>>> 2 GHz or 5 GHz or 6 GHz can be combined together as a group and provide
>>>>>>> an abstraction to mac80211.
>>>>>>>
>>>>>>> Device group abstraction - when there are multiple devices that are
>>>>>>> connected by any means of communication interface between them, then these
>>>>>>> devices can be combined together as a single group using a group id to form
>>>>>>> a group abstraction. In ath12k driver, this abstraction would be named as
>>>>>>> ath12k_hw_group (ag).
>>>>>>>
>>>>>>> Please find below illustration of device group abstraction with two
>>>>>>> devices.
>>>>>>>
>>>>>>> Grouping of multiple devices (in future)
>>>>>>> +------------------------------------------------------------------------+
>>>>>>> | +-------------------------------------+ +-------------------+ |
>>>>>>> | | +-----------+ | | +-----------+ | | +-----------+ | |
>>>>>>> | | | ar (2GHz) | | | | ar (5GHz) | | | | ar (6GHz) | | |
>>>>>>> | | +-----------+ | | +-----------+ | | +-----------+ | |
>>>>>>> | | ath12k_base (ab) | | ath12k_base (ab) | |
>>>>>>> | | (Dual band device) | | | |
>>>>>>> | +-------------------------------------+ +-------------------+ |
>>>>>>> | ath12k_hw_group (ag) based on group id |
>>>>>>> +------------------------------------------------------------------------+
>>>>>>>
>>>>>>> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
>>>>>>> device 2 has one radio (6 GHz).
>>>>>>>
>>>>>>> In existing code -
>>>>>>> device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
>>>>>>> (5 GHz) will be registered separately to mac80211 as phy0 and phy1
>>>>>>> respectively. Similarly, device 2 will register its hw (6GHz) as
>>>>>>> phy2 to mac80211.
>>>>>>>
>>>>>>> In future, with multi-link abstraction
>>>>>>>
>>>>>>> combination 1 - Different group id for device1 and device 2
>>>>>>> Device 1 will create a single hardware abstraction hw1
>>>>>>> (2 GHz and 5 GHz) and will be registered to mac80211 as
>>>>>>> phy0. similarly, device 2 will register its hardware
>>>>>>> (6 GHz) to mac80211 as phy1.
>>>>>>>
>>>>>>> combination 2 - Same group id for device1 and device 2
>>>>>>> Both device details are combined together as a group, say
>>>>>>> group1, with single hardware abstraction of radios 2 GHz,
>>>>>>> 5 GHz and 6 GHz band details and will be registered to
>>>>>>> mac80211 as phy0.
>>>>>>>
>>>>>>> Add base infrastructure changes to add device grouping abstraction with
>>>>>>> a single device.
>>>>>>>
>>>>>>> This patch series brings the base code changes with following order:
>>>>>>> 1. Refactor existing code which would facilitate in introducing
>>>>>>> device group abstraction.
>>>>>>> 2. Create a device group abstraction during device probe.
>>>>>>> 3. Start the device group only after QMI firmware ready event is
>>>>>>> received for all the devices that are combined in the group.
>>>>>>> 4. Move the hardware abstractions (ath12k_hw - ah) from device
>>>>>>> (ath12k_base - ab) to device group abstraction (ag) as it would
>>>>>>> ease in having different combinations of group abstraction that
>>>>>>> can be registered to mac80211.
>>>>>>>
>>>>>>> v7:
>>>>>>> - Added linux-wireless mailer to cc.
>>>>>>> - Removed Acked-by tag from "[PATCH v6 8/8]" as it has minor change.
>>>>>>>
>>>>>>> v6:
>>>>>>> - Addressed smatch error seen on "[PATCH v5 8/8] wifi: ath12k: move
>>>>>>> ath12k_hw from per soc to group"
>>>>>>> - Rebased to ToT
>>>>>>> v5:
>>>>>>> - on "[PATCH 8/8] wifi: ath12k: move ath12k_hw from per soc to
>>>>>>> group", refactor the ath12k_mac_hw_allocate() api based on ag rather
>>>>>>> than ab and update hardware abstraction array size in ath12k_hw_group
>>>>>>> as ATH12K_GROUP_MAX_RADIO.
>>>>>>> - Rebased to ToT
>>>>>>> v4:
>>>>>>> - Modified the cover letter
>>>>>>> v3:
>>>>>>> - Removed depends-on tag of "wifi: ath12k: Refactor the hardware recovery
>>>>>>> procedures" as it is merged to ToT
>>>>>>> - Addressed the deadlock warning seen during rmmod.
>>>>>>>
>>>>>>> v2:
>>>>>>> - Rebased to ToT
>>>>>>>
>>>>>>> Karthikeyan Periyasamy (8):
>>>>>>> wifi: ath12k: Refactor core start api
>>>>>>> wifi: ath12k: Add helpers to get or set ath12k_hw
>>>>>>> wifi: ath12k: Add ath12k_get_num_hw api
>>>>>>> wifi: ath12k: Introduce QMI firmware ready flag
>>>>>>> wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
>>>>>>> wifi: ath12k: Introduce device group abstraction
>>>>>>> wifi: ath12k: refactor core start based on hardware group
>>>>>>> wifi: ath12k: move ath12k_hw from per device to group
>>>>>>>
>>>>>>> drivers/net/wireless/ath/ath12k/core.c | 431 +++++++++++++++++++++----
>>>>>>> drivers/net/wireless/ath/ath12k/core.h | 87 ++++-
>>>>>>> drivers/net/wireless/ath/ath12k/dp.c | 19 +-
>>>>>>> drivers/net/wireless/ath/ath12k/dp.h | 2 +-
>>>>>>> drivers/net/wireless/ath/ath12k/mac.c | 117 ++++---
>>>>>>> drivers/net/wireless/ath/ath12k/mac.h | 9 +-
>>>>>>> drivers/net/wireless/ath/ath12k/pci.c | 2 +
>>>>>>> drivers/net/wireless/ath/ath12k/qmi.c | 10 +-
>>>>>>> 8 files changed, 544 insertions(+), 133 deletions(-)
>>>>>>>
>>>>>>>
>>>>>>> base-commit: f8320064a28242448eeb9fece08abd865ea8a226
>>>>>>
>>>>>> With this series I'm seeing a firmware crash upon resume from hibernation, but
>>>>>> I'm not sure if it is the same intermittent crash I reported in another thread
>>>>>> where firmware is not correctly handling a low physical memory address.
>>>>>>
>>>>>> Baochen & Kalle, since this issue may be specific to my laptop, can you
>>>>>> validate hibernation on your setups?
>>>>> I can also see a firmware crash upon resume. I am using ath-202405281746 as code base.
>>>>
>>>> I bisected to:
>>>> [PATCH v7 7/8] wifi: ath12k: refactor core start based on hardware group
>>>>
>>>>
>>> Thank you so much, Jeff. Identified the possible reason that is causing
>>> the firmware assert with hibernation scenario and will address it in
>>> next version.
> 

