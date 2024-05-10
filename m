Return-Path: <linux-wireless+bounces-7410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A057D8C1C5D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 04:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEB01B21901
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 02:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CDE13A889;
	Fri, 10 May 2024 02:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TJAE5jo6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF35579A
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715307651; cv=none; b=B2MpHjJHD8Ky1TmyKrVnkuXbOarA31MCnceun1LZjnP/gax5viGmg4/eAad/SjuHQcJivzIxmQH4rA8Y1LCk1CNHzhfZALmhQ5og2k+6YUqtqK+GLRC3dkIgxawhkpon2/VhrRkyzBsZYz+bgls4y7p8KF0EFWuvq3LJh6ZDP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715307651; c=relaxed/simple;
	bh=bVu7d3qtz6Bjb/sTO8usKEg+3ThiIjSZJ3Zim593a/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i4PPbKKIvWcBGQJcUOAll0MW09umIuc9ZpEJy9hTb4kqUl3B3m6CkkJTahZ4+0wqjRP0slVj1HYnTWUAo2lYPq9R/3/s1enh4CUM/xxUppTb8QSJqdzq6MW0LJXCaVLsHsgqta3glbEGsoxER9YFucCdHqz8LfSPm5gXjHDthos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TJAE5jo6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A1AmUW011076;
	Fri, 10 May 2024 02:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6hYabgO62xCNvZOxlsNVnJZUXSbQJ+JUmUv6QXRSjzA=; b=TJ
	AE5jo6IY5tsNFIelTX9mTdlvYZK0honDybpyZta/AkmmfjwtGNWeOVyaFrRyKCEx
	0R0GO5obhIkEgfGB+1M3D09wIUhNuHLn4Lmnf0HIvRsz+5DK1ojolcVGhPahoRrQ
	XsjYryEGJdr5lQE/mD4XCK+fnbBPH2VTjIk0wvtbkiq8ThOcM76xHGynWrWOpM+c
	py8JfVoyPJBH0/Qa1sDpaq8pqOQ0wDFzNzU+hL5kS5wjvVz0rdObQ9l0t+CzZva1
	awuBVTtzGmhmM7BYMTbuYlZpgJvn6PuUYcM243+nxYuxvjmMFbGrmgNDvmAnl4xE
	8+s6tt1NHXejGh8GAZJg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w20bqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:20:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44A2KdZL027476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:20:39 GMT
Received: from [10.110.100.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 May 2024
 19:20:38 -0700
Message-ID: <83cbcd41-7167-4b27-92c2-02bce3d9e5e4@quicinc.com>
Date: Thu, 9 May 2024 19:20:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] wifi: ath12k: Introduce device group abstraction
Content-Language: en-US
To: Harshitha Prem <quic_hprem@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
References: <20240507045702.2858954-1-quic_hprem@quicinc.com>
 <20240507045702.2858954-7-quic_hprem@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240507045702.2858954-7-quic_hprem@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v-2uYGGMthvhsnFQXOyn1YhGJp_fYRwZ
X-Proofpoint-ORIG-GUID: v-2uYGGMthvhsnFQXOyn1YhGJp_fYRwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_01,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=769
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100015

On 5/6/2024 9:57 PM, Harshitha Prem wrote:
> From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> Currently, single device is probed and once firmware is ready, the device
> is registered to mac80211. For multi-link operation, different bands of
> different devices or same device would be part of a single wiphy and for
> this, hardware device group abstraction would be helpful.
> 
> Hardware device group abstraction - when there are multiple devices (with
> single radio or dual radio) that are connected by any means of interface
> for communicating between them, then these devices can be combined
> together as a single group using a group id to form a group abstraction
> and register to mac80211.
> 
> The grouping information of multiple devices would be based on device tree
> during device probe. If no such information is available then a single
> device will be part of group abstraction and registered to mac80211 else
> multiple devices advertised in device tree are combined and then registered
> to mac80211.
> 
> For device group abstraction, a base structure named ath12k_hw_group (ag)
> and the following helpers are introduced:
>         ath12k_core_hw_group_alloc()    : allocate ath12k_hw_group (ag)
>                                           based on group id and number
>                                           of devices that are going to
>                                           be part of this group.
>         ath12k_core_hw_group_free()     : free ag during deinit.
>         ath12k_core_assign_hw_group()   : assign/map the details of group
>                                           to ath12k_base (ab).
>         ath12k_core_unassign_hw_group() : unassign/unmap the details of ag
>                                           in ath12k_base (ab).
>         ath12k_core_hw_group_create()   : create the devices which are part
>                                           of group (ag).
>         ath12k_core_hw_group_destroy()  : cleanup the devices in ag
> 
> These helpers are used during device probe and mapping the group to the
> devices involved.
> 
> Please find the illustration of how multiple devices might be combined
> together in future based on group id.
> 
>                 Grouping of multiple devices (in future)
> 
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
> In the above representation, two devices are combined into single group
> based on group id.
> 
> Add base code changes where single device would be part of a group with an
> invalid group id forming an group abstraction. Multi device grouping will
> be introduced in future.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Co-developed-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


