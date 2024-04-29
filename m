Return-Path: <linux-wireless+bounces-7007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926AC8B64AC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 23:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF9AB208FC
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 21:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6D1836E5;
	Mon, 29 Apr 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hip7ilIJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050FB1836D3
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426499; cv=none; b=K60+RZ5OqD3kKLbwcaPkWY1eDQtRkMonrjBBo1lRf42wCX5M4X3qt41PeDD9/LjQ8HmQVFj+qmcYSKx+Jj076UNXyJJ/jGf9jvRwVbWLQEOxfn8LjrxbJuW6jbWusk0NZkztF97NUm58IrYrEZvb6mwoOIZccwAap83vmDAMCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426499; c=relaxed/simple;
	bh=2MpRLTeAyMax/HMOmz7YGX2/zJq/XFJjiiJlf4K8ey8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U36B2VL3eosBzagsyPJqLVvqGyFlht6x/vy5mM4GIAqu93Ynml3zuXp59VO7ia3WlXj2ND0rGTDVu3HBRMdpoQoLwSVT1UvMbI9H32DOrGr4eTEYIIQuRKXEKQkNJy1ng+7SMb0hrkW9QGlS+HbcPzJRSPxFSV1j6bkFxbuBVI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hip7ilIJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TFlGJ0023904;
	Mon, 29 Apr 2024 21:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rUV3JVycPxekOYpjyDyrJnPKorXzYimfkLXMlcfIj3w=; b=hi
	p7ilIJ3qiWeX0SorvyBOLS6NyN5kKe8n5jr9WxSmT5eVUd1f0x1hMfloDBiGU7i8
	Uo6XxzoNqSmjCpsAEtUPDlGxhQJBBXo9JCuPSc8y13c/eMdjagidkgwSQwcKiSPZ
	g3AT14nAlbalPY76XdyqKVaIJgmTg3SKNGpaTf6pfTOa953JXgDIP+ScWxtuulWg
	lP3lQ5p+IPdyiIwLLDEGSi357BGINdBaebQIuvlTbI1rgiLuOhj4jRv+dub3g2G5
	63Fkfv/6d6Vrl29hA+9VDp6EGbWe/ePwZl1CLQ7dAjvBVXXACqRX0p9EGPnWAh5c
	nLI3p78VLOS+RY2DirBA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtbv8ap71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 21:34:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TLYoB6005167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 21:34:50 GMT
Received: from [10.110.13.147] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 14:34:50 -0700
Message-ID: <adb4e20d-a6e5-4508-a3d6-9c46a1aeebaa@quicinc.com>
Date: Mon, 29 Apr 2024 14:34:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] wifi: ath12k: Add support to enable debugfs_htt_stats
Content-Language: en-US
To: Ramya Gnanasekar <quic_rgnanase@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240429173825.2369355-1-quic_rgnanase@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240429173825.2369355-1-quic_rgnanase@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GOuRtY2OrP6ZReW4bshUinfzVco5eLbW
X-Proofpoint-GUID: GOuRtY2OrP6ZReW4bshUinfzVco5eLbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_19,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290143

On 4/29/2024 10:38 AM, Ramya Gnanasekar wrote:
> Bring in the basic infrastructure necessary for enabling htt_stats via debugfs.
> Patch series bring support to request stats type to firmware,
> dump the stats and request to reset the stats from firmware.
> 
> Schema with one ath12k device:
> 
> ath12k
> `-- pci-0000:06:00.0
>     |-- mac0
>         `-- htt_stats
>         |-- htt_stats_type
>         |-- htt_stats_reset
> 
> Dinesh Karthikeyan (3):
>   wifi: ath12k: Add support to enable debugfs_htt_stats
>   wifi: ath12k: Add htt_stats_dump file ops support
>   wifi: ath12k: Add support to parse requested stats_type
> 
> Ramya Gnanasekar (1):
>   wifi: ath12k: Dump additional Tx PDEV HTT stats
> 
>  drivers/net/wireless/ath/ath12k/Makefile      |   2 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  11 +
>  drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 713 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 300 ++++++++
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |  10 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |   4 +
>  7 files changed, 1038 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h
> 
> 
> base-commit: 326f8f68f28b0b831233acfabffb486a5b0f4717

testing on my laptop

good news is the files are being populated:
# ls /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/
dfs_simulate_radar  htt_stats  htt_stats_reset  htt_stats_type

bad news is:
# echo 1 > /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats_type
# cat /sys/kernel/debug/ath12k/pci-0000\:03\:00.0/mac0/htt_stats
cat: '/sys/kernel/debug/ath12k/pci-0000:03:00.0/mac0/htt_stats': Connection timed out

journalctl shows:
Apr 29 14:17:16 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: htc rx completion ep 2 skb ffff8c4e50e5ed00
Apr 29 14:17:19 qca-HP-ZBook-14-G2 kernel: ath12k_pci 0000:03:00.0: stats request timed out

so something isn't right, at least for WCN7850

has this been tested with upstream kernel?


