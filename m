Return-Path: <linux-wireless+bounces-18349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F1A26ADA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620F7167644
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 03:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75115689A;
	Tue,  4 Feb 2025 03:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mLqocqq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365F03232
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738641275; cv=none; b=IdLyrgfxCy5cR+FZGcIza9m94Xw4CvTwKr2UYrVnhGAGh5aVjT/FhfPbGbYf1buaqriKbFLuvlBYTNlLJ4ANj5ACuojGJVewN79l7FBft39IUkifs+ewrxmeQulpdzaEg1IIxKGeDV8EcIx7SxgCR/W/JX0eRpT0D7YZxDdEB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738641275; c=relaxed/simple;
	bh=yko7KKTwfBH3DXFVhk+AKEIHlnlECDMDka2pbWXI3P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vtj1Rbhh2ARmlmHXTbZJkNFDexjgWXz7OJlwyNV44Jo4ld3FDsPxKryd2eIWZ13KKvL3VJuQLfVs4IADOQ6buHT/q6itkjV8VWYZ1oq9RL/IpOHDGJiv1D7bZY9/dt11PAgIjbcD0h92ehWEMJ1GKYykNhnvcI4wYBnZUUJFBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mLqocqq9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IaWqE008687;
	Tue, 4 Feb 2025 03:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5aJyJcuP119WmaSVesxA87WNqjtRvg+EFnMREFJQ9kk=; b=mLqocqq9N0oUKUVD
	NqD1fjAVl2psib7C2yK66ubuDrawAN9lb36ymPTPIWgo6SvbJfRzURkHUbElgMAe
	eeawOka+zbtlXdOodiFP4Z+TjSNdEDEbDQCDckNwACg0tYa3m3fASvdepNHko/j5
	yHd/BESybhXPrDOJc+6MU9hJ3D6NuP1x2v800E7laMVcDRAEw5NQ/r5TdT0RyV+I
	cQ798lAKlMfKtyNkZ43AmVEirSBRUUlNNiE5lKqob2rU60L0ImwDpqUeHIEbjCXZ
	riFpx7GQ53x9qgYEXPXyBj3Q7qL5MNY0Lb4a4Wy8cNvMB2ReRT5VbnBt+9V0Ldyq
	j170Eg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k37u10cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 03:54:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5143sUFS015498
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 03:54:30 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 19:54:28 -0800
Message-ID: <88fd703a-75e3-1d47-79d6-313c0c56e036@quicinc.com>
Date: Tue, 4 Feb 2025 09:24:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 0/9] wifi: ath12k: Add peer extended Rx statistics
 debugfs support
Content-Language: en-US
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250204035022.3227100-1-quic_periyasa@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20250204035022.3227100-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ykkp1ArRO4qCqcGQTGNTngs6SyVlaEhr
X-Proofpoint-GUID: Ykkp1ArRO4qCqcGQTGNTngs6SyVlaEhr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=976 spamscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040028



On 2/4/2025 9:20 AM, Karthikeyan Periyasamy wrote:
> Currently, peer extended Rx statistics are not supported. Peer extended Rx
> statistics are collected form the TLV data reported in the monitor status
> Rx path. Therefore, add support for TLV tag parser handling and debugfs
> to configure and dump the collected information. Additionally, this series
> does not impact the WCN7850.
> 
> v7:
>   - Rebased on ToT
> v6:
>   wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>   wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>   wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
>    - modified the return type as void
> v5:
>   Removed the patch "wifi: ath12k: Add EHT rate statistics support" since it
>   is already merged
> v4:
>   wifi: ath12k: Add peer extended Rx statistics debugfs support
>    - fixed the kernel test robot noticed build errors
> v3:
>   wifi: ath12k: Add peer extended Rx statistics debugfs support
>    - avoid ext_rx_stats filter overwrite in default filter setting
> v2:
>   wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>   wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>    - fixed the length calculation in the EHT radiotap procedure
> 
> Balamurugan Mahalingam (2):
>    wifi: ath12k: Add EHT MCS support in Extended Rx statistics
>    wifi: ath12k: Refactor the format of peer rate table information
> 
> Karthikeyan Periyasamy (6):
>    wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>    wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>    wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
>    wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
>    wifi: ath12k: Update the peer id in PPDU end user stats TLV
>    wifi: ath12k: Add peer extended Rx statistics debugfs support
> 
> P Praneesh (1):
>    wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
> 
>   drivers/net/wireless/ath/ath12k/Makefile      |    2 +-
>   drivers/net/wireless/ath/ath12k/core.h        |   10 +-
>   drivers/net/wireless/ath/ath12k/debugfs.c     |   97 ++
>   drivers/net/wireless/ath/ath12k/debugfs.h     |   21 +-
>   drivers/net/wireless/ath/ath12k/debugfs_sta.c |  337 ++++++
>   drivers/net/wireless/ath/ath12k/debugfs_sta.h |   24 +
>   drivers/net/wireless/ath/ath12k/dp_mon.c      | 1033 ++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/hal_rx.h      |  433 ++++++-
>   drivers/net/wireless/ath/ath12k/mac.c         |   18 +-
>   drivers/net/wireless/ath/ath12k/mac.h         |    4 +-
>   drivers/net/wireless/ath/ath12k/rx_desc.h     |    9 -
>   11 files changed, 1924 insertions(+), 64 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h
> 
> 
> base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9

Ignore this series, missed patches

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

