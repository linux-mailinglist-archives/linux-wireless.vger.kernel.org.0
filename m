Return-Path: <linux-wireless+bounces-18337-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3664A26A83
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 04:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF142168019
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 03:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED111531C8;
	Tue,  4 Feb 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n+9/7H9a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEA1509BD
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738638235; cv=none; b=dOU0oJBqLImn20hc154ECMr6RF1DDBcieWfN/jIsg6VVTsFgGKdNEhPk7RPXBWFHB91LzZFjBY59URjZYQohNziarfHgmvnQ8oU3RWSsfIKHwOeUnYysldXs2s3xJvp3ggkdjl+MPR0yTGhNM46UGmIRcuXYnixBxJ/1ueJ0QME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738638235; c=relaxed/simple;
	bh=lnzuOBeePsfeN0oxdMZr7yspU27rJZsFNZ8VBgBhs6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ii3F7qVrv3O5EOejPhPLdyQrBmvdQsP0CX/p+UcR75Fe/cD/AtW/BuO0jUbP5uy3zVCgax5XWx5xmtNvFzunlKWNOjmPANwkk49ntjLuZFJIGJwRM+lLWW46L+Tt9IcCVwwUxGpFc/CDAWJFcFynsuJLwOfcD/ctNkpzB7IVqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n+9/7H9a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5141Bjv5021346;
	Tue, 4 Feb 2025 03:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TfZsCyXqGKCet9CPOFT3EzVqBO5gkY3JAAt4RK6Vyos=; b=n+9/7H9akQe/WpUM
	gr5Qwf9XyVbjSzRB526dLkuthumICNJLdXC1NysdDUBfD7Eh7EWfHEZbM1Sur3Ef
	TEd39G0hRUy35UKwr3ew7UvqNb29B7ydVbmGJRt98b7NOYtPocjPox21nfMms5aj
	PcapgtO6AnL98Ae+qrquUNswhROJTgOxVL2s6pU473OySh97MhY9mHv3ffV3RiLR
	6dDmkwF97paDS5Rid+cXmEVO3AzJPV7fvu0Aa7s2RMF5B9tyUXu9gnIDXCyTiJa7
	OWnpZ6+G+g93RmufawtIrIvf9HoooYvHiErDFIkUF6gV19hXTipsZUI2W8/DnJgL
	OX08sw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k911g618-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 03:03:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51433frf032427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 03:03:41 GMT
Received: from [10.151.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Feb 2025
 19:03:39 -0800
Message-ID: <9a9bfc40-890f-3df5-55f2-5a6406c72463@quicinc.com>
Date: Tue, 4 Feb 2025 08:33:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 0/9] wifi: ath12k: Add peer extended Rx statistics
 debugfs support
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
 <d96a5643-64c6-4bce-930f-f1651a09cb11@oss.qualcomm.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <d96a5643-64c6-4bce-930f-f1651a09cb11@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DLFDknsgNkfYzEImH-I9A5Pl_3nmvtf7
X-Proofpoint-ORIG-GUID: DLFDknsgNkfYzEImH-I9A5Pl_3nmvtf7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=952
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040022



On 2/4/2025 7:39 AM, Jeff Johnson wrote:
> On 1/29/2025 2:58 AM, Karthikeyan Periyasamy wrote:
>> Currently, peer extended Rx statistics are not supported. Peer extended Rx
>> statistics are collected form the TLV data reported in the monitor status
>> Rx path. Therefore, add support for TLV tag parser handling and debugfs
>> to configure and dump the collected information. Additionally, this series
>> does not impact the WCN7850.
>>
>> v6:
>>   wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>>   wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>>   wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
>>    - modified the return type as void
>> v5:
>>   Removed the patch "wifi: ath12k: Add EHT rate statistics support" since it
>>   is already merged
>> v4:
>>   wifi: ath12k: Add peer extended Rx statistics debugfs support
>>    - fixed the kernel test robot noticed build errors
>> v3:
>>   wifi: ath12k: Add peer extended Rx statistics debugfs support
>>    - avoid ext_rx_stats filter overwrite in default filter setting
>> v2:
>>   wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>>   wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>>    - fixed the length calculation in the EHT radiotap procedure
>>
>> Balamurugan Mahalingam (2):
>>    wifi: ath12k: Add EHT MCS support in Extended Rx statistics
>>    wifi: ath12k: Refactor the format of peer rate table information
>>
>> Karthikeyan Periyasamy (6):
>>    wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>>    wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>>    wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
>>    wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
>>    wifi: ath12k: Update the peer id in PPDU end user stats TLV
>>    wifi: ath12k: Add peer extended Rx statistics debugfs support
>>
>> P Praneesh (1):
>>    wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
>>
>>   drivers/net/wireless/ath/ath12k/Makefile      |    2 +-
>>   drivers/net/wireless/ath/ath12k/core.h        |   10 +-
>>   drivers/net/wireless/ath/ath12k/debugfs.c     |   97 ++
>>   drivers/net/wireless/ath/ath12k/debugfs.h     |   20 +
>>   drivers/net/wireless/ath/ath12k/debugfs_sta.c |  337 ++++++
>>   drivers/net/wireless/ath/ath12k/debugfs_sta.h |   24 +
>>   drivers/net/wireless/ath/ath12k/dp_mon.c      | 1033 ++++++++++++++++-
>>   drivers/net/wireless/ath/ath12k/hal_rx.h      |  433 ++++++-
>>   drivers/net/wireless/ath/ath12k/mac.c         |   18 +-
>>   drivers/net/wireless/ath/ath12k/mac.h         |    4 +-
>>   drivers/net/wireless/ath/ath12k/rx_desc.h     |    9 -
>>   11 files changed, 1924 insertions(+), 63 deletions(-)
>>   create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
>>   create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h
>>
>>
>> base-commit: b5aeca2e66899430827b8afcad061201f3b7861b
> 
> Unfortunately some new debugfs code was promoted to ath/main and this series
> no longer applies cleanly. Please rebase & repost.
> 

sure

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

