Return-Path: <linux-wireless+bounces-9807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B3C91EB71
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jul 2024 01:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649081C2135F
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3EE171652;
	Mon,  1 Jul 2024 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BtDK9JAt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D192F29
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719877335; cv=none; b=rDMC18utdLbSXJiNSETxQsHobf3VlFfpwCssajQlhC4bzetiHZacfm4ew93hZeqBj+MXNRfKVvnHaDZCuGdyq5rjAZ2QsK4qY3e9nk519q79Rcecf7h819fj2IAQP7A86gGhntwsBmmQmRVPfIfmR33kXfdqMPjiObCegHAnhEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719877335; c=relaxed/simple;
	bh=w2Q+BrvyApSt+aClLvfQGwQiesyWSPqW3TTkV5P6Oo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nKAfRqtrWN8vPHmSQUWmyqYYanX00jt47rI37VFDo73l1ryp92xyERk0a9W5l4aHH1rGLWVAro+IJGmbXu6qKUHeHF41u1DGHF0zKddTDhRlvKb6yJXNUrqRAuB7WrUuGupJx9BGz3XHEmOuVBvmrIF7yPOS/1ESnaM9rq1WH5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BtDK9JAt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461K9b66014909;
	Mon, 1 Jul 2024 23:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yp3yzejBBo8xe5ZiRAX72JFso1Cqwv4ZIUM7vu5V4Bg=; b=BtDK9JAtIq/ONGm8
	aEHpXbBw31owWwS/jRKF3UNNQbwjgZYpYky/5hxcIPiFiywb1k7kW8OW7IhCZby7
	bD+vp6PRw+2Jgjh8CntSA1FUzdWqWKxZrhjOZ0yRsObOJqHPfB9xgY/3YoCgjBtL
	Xm9b6OLSyPSGRH7sYNooK4+VihGrC2p+qW2IT7LE5ezXCGfbPUFMM/2Glsctlcum
	0Jsv0cIf2qBf3sVNsnAJbW+NbBSCSZUdtmG76xcnoHekaJ9bXWf7nxXTa/6mxq3H
	TnXFkhBydbRGJW7NJZ6sByr170Eo7vuY5XLcqn4TBrPrb9zXcXHkDGdG/9dqj88v
	D7KgHQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bejnanj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 23:42:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461NgAD0017909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 23:42:10 GMT
Received: from [10.48.245.148] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 16:42:10 -0700
Message-ID: <7da6dcaa-c01b-4a06-9e74-db193de538ab@quicinc.com>
Date: Mon, 1 Jul 2024 16:42:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] wifi: ath12k: move ath12k_hw from per device to
 group
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
 <20240628095139.292952-9-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240628095139.292952-9-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tuVkIqPJ6Q3g0m9Yu6vZeIE2y62lB0ro
X-Proofpoint-ORIG-GUID: tuVkIqPJ6Q3g0m9Yu6vZeIE2y62lB0ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=912
 impostorscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010176

On 6/28/2024 2:51 AM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, hardware abstractions (ah) of different radio bands
> are tightly coupled to a single device (ab). But, with hardware
> device group abstraction (ag), multiple radios across different
> devices in a group can possibly form different combinations of
> hardware abstractions (ah) within the group. Hence, the mapping
> between ah to ab can be removed and instead it can be mapped with ag.
> 
> Please find below illustration of how mapping between ath12k_hw (ah),
> ath12k_base (ab) and ath12k_hw_group (ag) is changed.
> 
>         current mapping of hardware abstraction (ah) with device (ab)
>             +------------------------------------------------+
>             |  +-------------------------------------+       |
>             |  | +---------------+ +---------------+ |       |
>             |  | |ath12k_hw (ah) | |ath12k_hw (ah) | |       |
>             |  | +---------------+ +---------------+ |       |
>             |  |                                     |       |
>             |  |  +-----------+ |   +-----------+    |       |
>             |  |  | ar (2GHz) | |   | ar (5GHz) |    |       |
>             |  |  +-----------+ |   +-----------+    |       |
>             |  |          Dual band device-1 (ab)    |       |
>             |  +-------------------------------------+       |
>             |    ath12k_hw_group (ag) based on group id      |
>             +------------------------------------------------+
> 
>                 After, with hardware device group abstraction
>                 (moving ah array out of ab to ag)
>             +----------------------------------------------+
>             |   +---------------+  +---------------+       |
>             |   |ath12k_hw (ah) |  |ath12k_hw (ah) |       |
>             |   +---------------+  +---------------+       |
>             |  +-------------------------------------+     |
>             |  | +-----------+     +-----------+     |     |
>             |  | | ar (2GHz) |     | ar (5GHz) |     |     |
>             |  | +-----------+     +-----------+     |     |
>             |  |     Dual band device-1 (ab)         |     |
>             |  +-------------------------------------+     |
>             |   ath12k_hw_group (ag) based on group id     |
>             +----------------------------------------------+
> 
> This decoupling of ath12k_hw (ah) from ath12k_base (ab) and mapping it
> to ath12k_hw_group (ag) will help in forming different combinations of
> multi-link devices.
> 
> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
> device 2 has one radio (6 GHz).
> 
> In existing code -
>         device 1 will have two hardware abstractions hw1 (2 GHz) and
>         hw2 (5 GHz) will be registered separately to mac80211 as phy0
>         and phy1 respectively. Similarly, device 2 will register its
>         hw (6 GHz) as phy2 to mac80211.
> 
> In future, with multi-link abstraction
> 
>         combination 1 - Different group id for device1 and device 2
>                 Device 1 will create a single hardware abstraction hw1
>                 (2 GHz and 5 GHz) and will be registered to mac80211 as
>                 phy0. similarly, device 2 will register its hardware
>                 (6 GHz) to mac80211 as phy1.
> 
>         combination 2 - Same group id for device1 and device 2
>                 Both device details are combined together as a group, say
>                 group1, with single hardware abstraction of radios 2 GHz,
>                 5 GHz and 6 GHz band details and will be registered to
>                 mac80211 as phy0.
> 
> Hence, Add changes to decouple ath12k_hw (ah) from ath12k_base (ab) and
> map it to ath12k_hw_group (ag).
> 
> Refactor the following APIs to help simplify the registration based on
> ath12k_hw_group (ag) rather than ath12k_base (ab)
>         * ath12k_mac_allocate()
>         * ath12k_mac_destroy()
>         * ath12k_mac_register()
>         * ath12k_mac_unregister()
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


