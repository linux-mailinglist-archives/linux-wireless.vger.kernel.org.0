Return-Path: <linux-wireless+bounces-6881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14888B2A99
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 23:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667D32880DB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE256153812;
	Thu, 25 Apr 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dhiCb6RN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4414F9ED
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080097; cv=none; b=EHbhsEw4xbyGnfBsuJEf8IJKK7Ooo4t7TBN/Nsrs670Qe5arpct6gvQ/7AYwSZH1zCIXVUqz7iYCHEFxRrgbNMI9FDbfgur2zf/5BSw/CKMdcKmZ+yPa1ouLTxmT5DZ5/g5lm3cUwDbBq39HaH0PKzzof4Za/uOrY+UjxAGg0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080097; c=relaxed/simple;
	bh=8ioZXOLV55ddOcBbB1d2XgBRrTi+rCHb8PjpQC+QSYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FHtTXKzgX1zQlc5BwdJq/Rz3i3GgEw8rI6QVFsVjoEbUFXe/k4c+Selp8fHzd8pbMKh5Z8iMSRBQeAo9NbAUKNPjrLwDkJWVFyUmsNbgXGFjLfhVRKvPd7H2sbdemBAntt/5jjfvjuFwHW7H/xisas88tw0OhWQ+VzXEFPGNPvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dhiCb6RN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P3rq11028838;
	Thu, 25 Apr 2024 21:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=h7OVjYd2ZkG2i3CQzboABoWRZf/+yUr5mPF/n99M2yw=; b=dh
	iCb6RNvEFCE5Qmgimej+pZGV6OBOW2PCdZFmuPjtqF8tRpT0+0tPaqog6EozfgRI
	DwZTPzvYsc1QB4hGpuyJbdQHMMiScMsfGl+qxav5zlerstWG15Z1VZEKcyUhOeXM
	mw0sghusxkRtS4iOLtmnWt96ha+sGXoL7jSHAEOkD7UlI3si2eYAC5LbXRUa2ia2
	5X8kVpPKvcBqbuX+fouiTFYJGhLl7ii6Rk1ST5ltG9e6HeitrHzY5F4hMlyTmDXe
	NkNWQr9AYgaZpx+9YXPB/3TWtGDoe4t38Aoit3Xa+RSbw4ccpv90Cl1J47r6b99Z
	EM/r8cT8XMmLOvRHbwqw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhus0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:21:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLLWpB004591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:21:32 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 14:21:31 -0700
Message-ID: <6dea1dbd-f684-4155-8f08-33527287e438@quicinc.com>
Date: Thu, 25 Apr 2024 14:21:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240425055759.1181165-1-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tgOgK2u2-p7FmLjCjNXDQcDB_Obj3fVZ
X-Proofpoint-GUID: tgOgK2u2-p7FmLjCjNXDQcDB_Obj3fVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 mlxlogscore=902 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404250155

On 4/24/2024 10:57 PM, Harshitha Prem wrote:
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
> 
> Depends-on:
>         [PATCH v2 0/3] wifi: ath12k: Refactor the hardware recovery
> 	procedures.
> 	Link - https://lore.kernel.org/ath12k/87a5ljt0p9.fsf@kernel.org/T/

current dependency link (v3):
https://lore.kernel.org/ath12k/20240425090307.3233434-1-quic_periyasa@quicinc.com

I verified this series cleanly applies on top of that

> 
> v2:
>  - Rebased to ToT
> 
> Karthikeyan Periyasamy (8):
>   wifi: ath12k: Refactor core start api
>   wifi: ath12k: Add helpers to get or set ath12k_hw
>   wifi: ath12k: Add ath12k_get_num_hw api
>   wifi: ath12k: Introduce QMI firmware ready flag
>   wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
>   wifi: ath12k: Introduce device group abstraction
>   wifi: ath12k: refactor core start based on hardware group
>   wifi: ath12k: move ath12k_hw from per soc to group
> 
>  drivers/net/wireless/ath/ath12k/core.c | 428 +++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/core.h |  88 ++++-
>  drivers/net/wireless/ath/ath12k/mac.c  | 108 +++++--
>  drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
>  drivers/net/wireless/ath/ath12k/pci.c  |   1 +
>  drivers/net/wireless/ath/ath12k/qmi.c  |  10 +-
>  6 files changed, 527 insertions(+), 117 deletions(-)
> 
> 
> base-commit: 326f8f68f28b0b831233acfabffb486a5b0f4717
> prerequisite-patch-id: fa330433b950da57175cc84c5e97c2def1d24959
> prerequisite-patch-id: 75254d9efeb5eb6e3b2027155be94334c85a76b9
> prerequisite-patch-id: edd3d755bafc868bae646b54d279c2a8ba66acd1


