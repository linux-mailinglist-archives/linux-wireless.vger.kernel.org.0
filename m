Return-Path: <linux-wireless+bounces-8432-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C288D86F5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 18:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD421F21BAD
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3512FB2D;
	Mon,  3 Jun 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KmUHlp7t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FEA12DDAF
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431129; cv=none; b=cdnGPN/Z1jrgJrjRzraGteaENsSro4yqBlkSbIN5n4dHIwgQLAwjCSz5wFv5Fsumxmr4CqnCGC6fo0zLqJ4DboNhAbmngGYKHaZf2zPFntJdo71VajS7FC2t1h+5+tCrghX9yh/NPuglk/E/Lm8wDZqpz5obd1JFBI6BJ2nkUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431129; c=relaxed/simple;
	bh=Qw1ljCRWEEKkuHWZ46S6Al3Ww937UQbS1ZpwlUbnDZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZpktNrSzlYujVQ1a0d7vSxZnSk6T09aee0d/6jxRzMRkXb5m2Bf7ttSOMulSCuHg/394g5mWYVnJwUSsLuyL+iE38gEpHMBmIsh1rxdKuCCPIfqo/1cNEIa0XGKHaUyf299fu0yXBwAeQWGEVjzbHTkebgGNVTz73CPGKAudock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KmUHlp7t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 453BvbCW021204;
	Mon, 3 Jun 2024 16:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VnOe1t30INAiPSeKkhHWAdJDuH36r6qoHyAbUuFwzCs=; b=KmUHlp7tldKtPXGX
	6xzL8ziE7OdEncqlDspFwMh2ovLsx1dBQoy4oWjC6dKkfVugfzhEuPdKfCwzw3tA
	lQ0u98yrI6FEz/jGBSKLchuyaydLjqvic6/vfBZ0XEbf5eb4bW9S0rsrN5xCfoBX
	OGyuSTXNyuFGv119RSre2posdpHusSqGqN8vLJ+2tg48UR03xp28wJJPxdrDIRj1
	VnZM/aPLp8NuzZY6EgMMhTWhkzMBRKSd9wDKZS6yrq5CFUESCOeyFBzs1L24vtPA
	RSM/f7zLg+pnweoYEBIn4EafTfd7cb+B9lWq/yWvmEwjg0fRtrOu4GO5CCFfdJSm
	JXJSbA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw42vcew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 16:12:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 453GBxGg028456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Jun 2024 16:11:59 GMT
Received: from [10.48.241.139] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 09:11:58 -0700
Message-ID: <52108cb7-621c-40fe-a556-ed0b4b36371f@quicinc.com>
Date: Mon, 3 Jun 2024 09:11:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240531180411.1149605-1-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p5m_T9XujSCFusLxNNAjA-QJJxV1e_fq
X-Proofpoint-ORIG-GUID: p5m_T9XujSCFusLxNNAjA-QJJxV1e_fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 mlxlogscore=843 clxscore=1015 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406030133

On 5/31/2024 11:04 AM, Harshitha Prem wrote:
> To support multi-link operation, multiple devices with different bands say
> 2 GHz or 5 GHz or 6 GHz can be combined together as a group and provide
> an abstraction to mac80211.
> 
> Device group abstraction - when there are multiple devices that are
> connected by any means of communication interface between them, then these
> devices can be combined together as a single group using a group id to form
> a group abstraction. In ath12k driver, this abstraction would be named as
> ath12k_hw_group (ag).
> 
> Please find below illustration of device group abstraction with two
> devices.
> 
>                  Grouping of multiple devices (in future)
> +------------------------------------------------------------------------+
> |  +-------------------------------------+       +-------------------+   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
> |  |         (Dual band device)          |       |                   |   |
> |  +-------------------------------------+       +-------------------+   |
> |                 ath12k_hw_group (ag) based on group id                 |
> +------------------------------------------------------------------------+
> 
> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
> device 2 has one radio (6 GHz).
> 
> In existing code -
>         device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
>         (5 GHz) will be registered separately to mac80211 as phy0 and phy1
>         respectively. Similarly, device 2 will register its hw (6GHz) as
>         phy2 to mac80211.
> 
> In future, with multi-link abstraction
> 
>         combination 1 - Different group id for device1 and device 2
>                 Device 1 will create a single hardware abstraction hw1
>                 (2 GHz and  5 GHz) and will be registered to mac80211 as
>                 phy0. similarly, device 2 will register its hardware
>                 (6 GHz) to mac80211 as phy1.
> 
>         combination 2 - Same group id for device1 and device 2
>                 Both device details are combined together as a group, say
>                 group1, with single hardware abstraction of radios 2 GHz,
>                 5 GHz and 6 GHz band details and will be registered to
>                 mac80211 as phy0.
> 
> Add base infrastructure changes to add device grouping abstraction with
> a single device.
> 
> This patch series brings the base code changes with following order:
>         1. Refactor existing code which would facilitate in introducing
>            device group abstraction.
>         2. Create a device group abstraction during device probe.
>         3. Start the device group only after QMI firmware ready event is
>            received for all the devices that are combined in the group.
>         4. Move the hardware abstractions (ath12k_hw - ah) from device
>            (ath12k_base - ab) to device group abstraction (ag) as it would
>            ease in having different combinations of group abstraction that
>            can be registered to mac80211.
> 
> v8:
>   - Addressed firmware assert issue seen during hibernation scenario in
>     "[PATCH v7 7/8] wifi: ath12k: refactor core start based on hardware group"
> 
> v7:
>    - Added linux-wireless mailer to cc.
>    - Removed Acked-by tag from "[PATCH v6 8/8]" as it has minor change.
> 
> v6:
>   - Addressed smatch error seen on "[PATCH v5 8/8] wifi: ath12k: move
>     ath12k_hw from per soc to group"
>   - Rebased to ToT
> v5:
>   - on "[PATCH 8/8] wifi: ath12k: move ath12k_hw from per soc to
>     group", refactor the ath12k_mac_hw_allocate() api based on ag rather
>     than ab and update hardware abstraction array size in ath12k_hw_group
>     as ATH12K_GROUP_MAX_RADIO.
>   - Rebased to ToT
> v4:
>   - Modified the cover letter
> v3:
>   - Removed depends-on tag of "wifi: ath12k: Refactor the hardware recovery
>     procedures" as it is merged to ToT
>   - Addressed the deadlock warning seen during rmmod.
> 
> v2:
>  - Rebased to ToT
> 
> 
> Karthikeyan Periyasamy (8):
>   wifi: ath12k: Refactor core start api
>   wifi: ath12k: Add helpers to get or set ath12k_hw
>   wifi: ath12k: Add ath12k_get_num_hw api
>   wifi: ath12k: Introduce QMI firmware ready flag
>   wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
>   wifi: ath12k: Introduce device group abstraction
>   wifi: ath12k: refactor core start based on hardware group
>   wifi: ath12k: move ath12k_hw from per device to group
> 
>  drivers/net/wireless/ath/ath12k/core.c | 427 +++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/core.h |  87 ++++-
>  drivers/net/wireless/ath/ath12k/dp.c   |  19 +-
>  drivers/net/wireless/ath/ath12k/dp.h   |   2 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 117 ++++---
>  drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
>  drivers/net/wireless/ath/ath12k/pci.c  |   2 +
>  drivers/net/wireless/ath/ath12k/qmi.c  |  10 +-
>  8 files changed, 540 insertions(+), 133 deletions(-)
> 
> 
> base-commit: 6e7a5c6d5e38b93f9cc3289d66a597b9a4ca0403

this no longer applies cleanly to ath/master or ath/ath-next,
can you please rebase and repost?


