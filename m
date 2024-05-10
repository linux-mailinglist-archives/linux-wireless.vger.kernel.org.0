Return-Path: <linux-wireless+bounces-7413-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2590B8C1C63
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF574282EAF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBCE13B797;
	Fri, 10 May 2024 02:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YWE2ar88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E933EE
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715308025; cv=none; b=FIK/xq8jcGPgf5dFdWnJDxiQ0urhys1av7ZBNWnJ48TTpIS7gOx+cQ4DPo97to0BU169Ri/2bw+muaHnkOA49fJE17It59XKZWOvM5wzyAT5N7RBuAc20AJ5MvLOXdxt4z3tW0b1Gc/CEHwoPDEwUWVS6QERCRaIAOZ6AXatYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715308025; c=relaxed/simple;
	bh=MlVrxxO0AG/8j5nDgzdVUogzuVSCroog/IeiuHevcFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SuZcniZhnbLPj2ad0r6O5tujp3juJiASvk5JsWlAJGiLyUeb72KjxRbt4HjaoIsLGV5FsMn3zgSJQ/TMZhrNgqMCtqxPp7zYfCJ1uYt5rVscooXjGygH03QeNpSIiwiulFVhMJxbpJHmwfoj0uPMJM6Ld2uVg/V07TSmCHcJMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YWE2ar88; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1Alsm011053;
	Fri, 10 May 2024 02:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tEodmfjJziCXjegYb0WlKoqu8wX3ySG6oOpOZTf0pXc=; b=YW
	E2ar88uhI3B609MRKlmn0TQTCtSNsBHIDPhKUos1pD8uQjcwCK+3eO/hUjpnTknn
	gadd763PLJ+eMJe16KssRqBIdI2CtSxCqyWDz+tBY6iHOX4uBQ4d1xBL7Gw/ALEL
	eHDp06Tqb7SK7nk01iwOt80EsdfmDAi1vOmkwRxmdbDbDHAxGBZr7IW6hFZcNg4n
	NiFe4gToAkNdfk/F7cRoowsfxs8DrstDmD4LtXRE02hFi5AcFk/FRLaDVehfy+/0
	/OHt9o7uy21dqSbBZn7x/6HLXZHjRf4BO+U2vuS1gOy41Iowr/ZfvamFgQpIa8uV
	2Gf4kbYk7TZLkJnKIRXg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w20c0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:26:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A2QpZ7005864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:26:51 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 19:26:50 -0700
Message-ID: <32270967-c1c8-4681-a282-f33defede3fb@quicinc.com>
Date: Thu, 9 May 2024 19:26:50 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240507045702.2858954-1-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BWSTjHXI56f6o8f6HzEICQZ36GAWhLSL
X-Proofpoint-ORIG-GUID: BWSTjHXI56f6o8f6HzEICQZ36GAWhLSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_01,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100015

On 5/6/2024 9:56 PM, Harshitha Prem wrote:
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
>  drivers/net/wireless/ath/ath12k/core.c | 433 +++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/core.h |  87 ++++-
>  drivers/net/wireless/ath/ath12k/mac.c  | 108 ++++--
>  drivers/net/wireless/ath/ath12k/mac.h  |   9 +-
>  drivers/net/wireless/ath/ath12k/pci.c  |   2 +
>  drivers/net/wireless/ath/ath12k/qmi.c  |  10 +-
>  6 files changed, 534 insertions(+), 115 deletions(-)
> 
> 
> base-commit: 2c4d8e19cf060744a9db466ffbaea13ab37f25ca

Gentle reminder that when you post a new version of a previous patchset you
should propagate any Acked-by/Reviewed-by/Tested-by/etc tags given to the
previous patches unless the patches were modified significantly enough to
render those tags invalid (in which case document that in the cover letter).

/jeff

