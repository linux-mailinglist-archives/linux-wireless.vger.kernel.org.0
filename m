Return-Path: <linux-wireless+bounces-18336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F01CA269FB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 03:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FAA1881B28
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 02:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D541132117;
	Tue,  4 Feb 2025 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O+PlCNyX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A225A655
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738634966; cv=none; b=LYsdI/1EO7/IS3AAkT+F00H2ak8PPI0FIfDH1UGW+9kIGjhMq+cNDUep5BWnog/tcWdK29zPB5BAEv+wLDWB+g17My3Yt0Up5QpykTC3V2NzJpfn5pyCsTPL4Ls9HrmrsA4No6zs8MQW/5JaMWnqYuJ7fWOUE6c7ZWLp0UymnjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738634966; c=relaxed/simple;
	bh=WXOLOM9qEEXp2pXB5mAGnSJ2yxFdXTRGF86o5RTTY7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N69CBveNU3DEIp6YJ3J8KKj+jmwo25MBC4joQWuO8Iu7F6iXAdIbjcZ4+CEDAwgZuSbh17W0bS7BmPSo1JdK2BlFenxY9jV2UQ2wO6gV2oMvbITdihiTGean4Jz7JANgXbs1pcn71RdP+X/ymQt0/PcPCd3GhyKArNR7+KjtSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O+PlCNyX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513Iphs3006097
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 02:09:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JwxH5eaHP07LekM95UHcWYMO0l5O5gAtWQNIbNz0zDk=; b=O+PlCNyX83DWw2A1
	M3lRTPx6ZX86rg7Cghp6KXBxfrwadM3bzroUpW4mvd02EPsIHViAZxTxIt/SAbu1
	46Ranih8Ad/VSLxKWo99jl+JHcbEhQhhIC1s9S5voGJtocfwCsXqepEO7p3B4h/Z
	Irxf6yrZnx+6XCbjbghGcUX+/7TQjISZjgrfByk23YjWfK52jni/374soVt5Y2lR
	MX+13kgbXEe0WdfvAdwV/LaJrUEeu2QRZ2LmgYvLIqDv7iar7wcatOObeHIdW39X
	YSSjnEaPQ3Iq5PFBJB4O5ZIn+r5DG78Yi4RP46TXJHIilB3wm10CTQb6L1Cx1vWo
	9jqvRg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k3ex0sgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 02:09:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f02a2410aso7240925ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 18:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738634961; x=1739239761;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwxH5eaHP07LekM95UHcWYMO0l5O5gAtWQNIbNz0zDk=;
        b=GNoq7QlALYuPNW+DxBVBezV1MXhC4kPUrNEVCS29ryFiIuUqQ15T9XfvUUyLqhzd/x
         4AagvQw+bPLaRpAufq8T/iYSUKR921KSd/ACF57U69XV1ggY9CUctWtORchifYCigARt
         JmFVQjgRNxc5Kj1C7w/B2d3UDUUOfQ5NUyJ3Ks4zZpA4EDE+e7ykEuM4uWsBLywvXhLH
         N+4eWTVXHg5HiEzTi+I5h3kozVjgM7UPVs6U8DWEDghHTP/Wd52JnDonSpIyai3HLj2t
         9g7ENK1G2q9FW2PZ63jpAZQ/ZH9fOMpPmv4bf/9itCfkaXlooUv6fjNWN3uW6T8cGL68
         tU/Q==
X-Gm-Message-State: AOJu0YxQKx3ThrZsjWmCGKMW5o7lXCuSzUjwYEaSeM/bZf5LoWO8N45o
	9IesI4UbSf3v3DrA+dUAFvcd0n7CVxDai66Q70PFpJR1WQNQx1NAUlo/A3jGBAqJeCDZcd3bCud
	Sj1uP83BT+27OPWQQnegDRn1Q6Z/27jldyMoh5JOU4+56c/4ANaN2Hzx9QxXaDcO8Guoh8xUYrQ
	==
X-Gm-Gg: ASbGncsaTE016dm/nhBDPg2z1AVC6u4np3hwjubjGZHPjBiPc8YyZkcyE9EktCWmdOT
	DWbG9yIp1yhP+KewLvPXuOYz8yQsvvidI4Nc9fWm6EVY83TFxG/qroMjUvk2TV0xFUxnRJMcbN1
	XhdvGtjM17YTbS3u6IMj3aTJFZpHB8ge/Yrf3JiI7SWcJcFz4PnYefOBpJulndI5O1NjlL8UqDH
	DEEpBI7RRpP3t8cH61kUqnga9gue6HIXR4pUw2DQ09WCfMQ3SKr+BLcTz5l23vMxUR3vhzngyIZ
	x5R/XofjmNY6e5XH2UxkuddeDq4FDkdj595ngKJrlipwa7l5hgc9R1PPHoICNK3Z+PrTF24/7Q=
	=
X-Received: by 2002:a17:902:ecc1:b0:216:45b9:43ad with SMTP id d9443c01a7336-21dd7dcb011mr403527095ad.34.1738634961279;
        Mon, 03 Feb 2025 18:09:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqILNSrnAPMgEY4Sw5wGbNbvICyCrdB+mr/0pb1KXyDFpt9iwAPyvisUW90bxZJv5sSbjnkw==
X-Received: by 2002:a17:902:ecc1:b0:216:45b9:43ad with SMTP id d9443c01a7336-21dd7dcb011mr403526705ad.34.1738634960740;
        Mon, 03 Feb 2025 18:09:20 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad25ee99ba0sm3782124a12.69.2025.02.03.18.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 18:09:20 -0800 (PST)
Message-ID: <d96a5643-64c6-4bce-930f-f1651a09cb11@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 18:09:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] wifi: ath12k: Add peer extended Rx statistics
 debugfs support
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250129105810.1094359-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3XyyAl1VGalwYNRL1XOlxjJZfciAn7pT
X-Proofpoint-GUID: 3XyyAl1VGalwYNRL1XOlxjJZfciAn7pT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_01,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502040015

On 1/29/2025 2:58 AM, Karthikeyan Periyasamy wrote:
> Currently, peer extended Rx statistics are not supported. Peer extended Rx
> statistics are collected form the TLV data reported in the monitor status
> Rx path. Therefore, add support for TLV tag parser handling and debugfs
> to configure and dump the collected information. Additionally, this series
> does not impact the WCN7850.
> 
> v6:
>  wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>  wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>  wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
>   - modified the return type as void
> v5:
>  Removed the patch "wifi: ath12k: Add EHT rate statistics support" since it
>  is already merged
> v4:
>  wifi: ath12k: Add peer extended Rx statistics debugfs support
>   - fixed the kernel test robot noticed build errors
> v3:
>  wifi: ath12k: Add peer extended Rx statistics debugfs support
>   - avoid ext_rx_stats filter overwrite in default filter setting
> v2:
>  wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>  wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>   - fixed the length calculation in the EHT radiotap procedure
> 
> Balamurugan Mahalingam (2):
>   wifi: ath12k: Add EHT MCS support in Extended Rx statistics
>   wifi: ath12k: Refactor the format of peer rate table information
> 
> Karthikeyan Periyasamy (6):
>   wifi: ath12k: Add HAL_PHYRX_GENERIC_U_SIG TLV parsing support
>   wifi: ath12k: Add HAL_PHYRX_GENERIC_EHT_SIG TLV parsing support
>   wifi: ath12k: Add HAL_RX_PPDU_START_USER_INFO TLV parsing support
>   wifi: ath12k: Add HAL_PHYRX_OTHER_RECEIVE_INFO TLV parsing support
>   wifi: ath12k: Update the peer id in PPDU end user stats TLV
>   wifi: ath12k: Add peer extended Rx statistics debugfs support
> 
> P Praneesh (1):
>   wifi: ath12k: fix the ampdu id fetch in the HAL_RX_MPDU_START TLV
> 
>  drivers/net/wireless/ath/ath12k/Makefile      |    2 +-
>  drivers/net/wireless/ath/ath12k/core.h        |   10 +-
>  drivers/net/wireless/ath/ath12k/debugfs.c     |   97 ++
>  drivers/net/wireless/ath/ath12k/debugfs.h     |   20 +
>  drivers/net/wireless/ath/ath12k/debugfs_sta.c |  337 ++++++
>  drivers/net/wireless/ath/ath12k/debugfs_sta.h |   24 +
>  drivers/net/wireless/ath/ath12k/dp_mon.c      | 1033 ++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/hal_rx.h      |  433 ++++++-
>  drivers/net/wireless/ath/ath12k/mac.c         |   18 +-
>  drivers/net/wireless/ath/ath12k/mac.h         |    4 +-
>  drivers/net/wireless/ath/ath12k/rx_desc.h     |    9 -
>  11 files changed, 1924 insertions(+), 63 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_sta.h
> 
> 
> base-commit: b5aeca2e66899430827b8afcad061201f3b7861b

Unfortunately some new debugfs code was promoted to ath/main and this series
no longer applies cleanly. Please rebase & repost.


