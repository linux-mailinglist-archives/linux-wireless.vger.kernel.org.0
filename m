Return-Path: <linux-wireless+bounces-6747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57028AF8E5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 23:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E02D1F23F5F
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 21:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E82143866;
	Tue, 23 Apr 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OmPRVBXm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFE13CFA4
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907463; cv=none; b=OBNCG2dx1tqzrLJACyrSvUVR1DeFlZ/VMfYAPQ6/IUMpHadXlCLLYZdH9EvtkTXctn7y8rTAHntW4qasIfYkFKnb6HlA/y+MjGOYlmw00j7anTRH5LKnnUy6JYL1Wp0Re288MLdNcRt9J+pN3cKHubriUmWCRWBHLxD83xKx5jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907463; c=relaxed/simple;
	bh=0TJ79oS3F1/r24qeY1nzJccgtBLSwbz4R+sUrYVGHBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Eqa749AhNFjSwC9YbFxsCXzM7dTGc7/z5lwYWWl4UB4Cf7a+TotUAlzolz5aoqppmwgyfP8gzuR62XP77n52E7qrqc+EWq/xR3NO2d78g9JUFBNACjDdVF4QBHTFizkQP5AXTranwT15XKzxIluvAuwO5+oEK3fffjzR1oKUgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OmPRVBXm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NKZ1I2006144;
	Tue, 23 Apr 2024 21:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wPfM51Upgx96/oBlnqUPCSmDp0NKk15xLUiXmxIflzI=; b=Om
	PRVBXmhj+K9ygh8jpvydMNCebfUVkYxL0K+k+isPwmGwUhR+lsgppFKEIiHAIDDc
	LqRvL7rm28FJuQHR2zgl0x1fQWlhbCVyJQPWQcGy25UCOGuVoIBd52jOB8/Ni6AP
	1YgzvIPx4WmMmb9B7ZxwEMWmeGW8ZBCLUIakyBzIFtbrXW4Ebofr3vunyM6aTHLz
	OPOZT3tIV9GKwFb3kxex7LY9CGF8UtT3BinoH99/L0R1Y/XQcBv2d4Dh4yDpJlve
	yjrFNaUhEEb1a+LjuyqB0jAQaBy+W0DhB5h0PPEeNKbPfATjfhPcTAAOQnUSctrd
	PxPnzYYk714gWHXddjHA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp9buabx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 21:24:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NLOEbB000338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 21:24:14 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 14:24:13 -0700
Message-ID: <57002bbf-2c85-4fa7-b249-4bd3f2ba1bcf@quicinc.com>
Date: Tue, 23 Apr 2024 14:24:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Harshitha Prem <quic_hprem@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240420083750.1545670-1-quic_hprem@quicinc.com>
 <878r14v2o4.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <878r14v2o4.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ij0mSr74GSgx3iFMZMf7_NMZ7pLGWSps
X-Proofpoint-ORIG-GUID: Ij0mSr74GSgx3iFMZMf7_NMZ7pLGWSps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230053

On 4/23/2024 2:39 AM, Kalle Valo wrote:
> Harshitha Prem <quic_hprem@quicinc.com> writes:
> 
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
>>                  Grouping of multiple devices (in future)
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
>>         device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
>>         (5 GHz) will be registered separately to mac80211 as phy0 and phy1
>>         respectively. Similarly, device 2 will register its hw (6GHz) as
>>         phy2 to mac80211.
>>
>> In future, with multi-link abstraction
>>
>>         combination 1 - Different group id for device1 and device 2
>>                 Device 1 will create a single hardware abstraction hw1
>>                 (2 GHz and  5 GHz) and will be registered to mac80211 as
>>                 phy0. similarly, device 2 will register its hardware
>>                 (6 GHz) to mac80211 as phy1.
>>
>>         combination 2 - Same group id for device1 and device 2
>>                 Both device details are combined together as a group, say
>>                 group1, with single hardware abstraction of radios 2 GHz,
>>                 5 GHz and 6 GHz band details and will be registered to
>>                 mac80211 as phy0.
>>
>> Add base infrastructure changes to add device grouping abstraction with
>> a single device.
>>
>> This patch series brings the base code changes with following order:
>>         1. Refactor existing code which would facilitate in introducing
>>            device group abstraction.
>>         2. Create a device group abstraction during device probe.
>>         3. Start the device group only after QMI firmware ready event is
>>            received for all the devices that are combined in the group.
>>         4. Move the hardware abstractions (ath12k_hw - ah) from device
>>            (ath12k_base - ab) to device group abstraction (ag) as it would
>>            ease in having different combinations of group abstraction that
>>            can be registered to mac80211.
>>
>>
>> Depends-on:
>>         [PATCH 0/3] wifi: ath12k: Refactor the hardware recovery
>> procedures
> 
> Are you referring to this patchset:
> 
> https://patchwork.kernel.org/project/linux-wireless/list/?series=821155&state=*&order=date
> 
> That was sent three months ago and at least I couldn't find a newer
> version. So I'll just drop this patchset for now without even looking at
> it.
> 

Yes, I'm stumped as well. the patch specifies:
>base-commit: c416602943dd36fbd13af7496430723935c867a3
>prerequisite-patch-id: a4d62344b11368fb7e549c03b6a31f7ba4c9e2bb
>prerequisite-patch-id: b4a1e18a85d8c1e337fa133c2bd2956c33b11046
>prerequisite-patch-id: b16edd310baa35e2500267e338f60c9a2e6594e1

but lore is unable to find those prerequisite patch-ids, which leads me to
believe that they were rebased internally but never posted.

I tried to apply the January series on top of the base-commit:
c416602943dd36fbd13af7496430723935c867a3 but it doesn't apply cleanly.

So I think we need to have a rebased and updated "Refactor the hardware
recovery procedures" first.

/jeff

