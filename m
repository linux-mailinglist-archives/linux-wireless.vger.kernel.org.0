Return-Path: <linux-wireless+bounces-17370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC44A0A752
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 06:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F047E1887CD9
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 05:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615914830A;
	Sun, 12 Jan 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oKt+xjAF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49948ECF;
	Sun, 12 Jan 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736661247; cv=none; b=NIBKJ1x2/EX+NszlTC32eKF9Wp8Q8Fsg4ypC+k5Y0dPzzZltzzPyLYKl64MaqFJA5tsjEF+9AJb4D9oA6v/DrG0qbUSqsrhG2btuuYn7A7eS3pWzsfWW6UUBOVLHGmF7ZUji0PrxNE488RpZ/POm242JThMPa3oKXYiZaKbWY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736661247; c=relaxed/simple;
	bh=j6ZnfiLyzI3Y1Y3y0EKDXiM72fQtmvSJ5oiMRI3bNRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qcT3Q5StCz3/WmD0lRq4depSjp3tTjzbC4Meu2pdov9u+pHpEA4rs7ZRRZSy644jfExjfwJMEAs4qRIPY7dcCmFSv/DTUM3GxTLu8mnKePU90WLs2wPPKFfHsyMFETJLneASrD3pSPugnCeB0uYBMdSiKFuYVY0btIl0ID+wjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oKt+xjAF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C5l7hw023794;
	Sun, 12 Jan 2025 05:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dxDFs57jp7DbEc7eo6MiHeVk4WSoOvzdFORJxgnxc6k=; b=oKt+xjAFIvXEMvA5
	1TSBKHju/CngbqvWxGpIs6ffkeq+Yry3v3Q0uZF7fDrmH7QQRUQ/H+VnQSXeVVBW
	svmlv3xHErq+jHYp7e6s4P/AwWM9Wlyiurpd2ptDMXa8tBsHFeUjKjoKFyzyQ3sf
	AbncV2jptHYpkwKt8uWryGCgHI6F6mPxqLA+qfa1zbhGgZit+n4qXvaMToQh/7sG
	IGCbL9qOx5+aSCw1856c5KFayijw8DOXEqCUjne+CMW67eAL52eemYGhE6GRc6rT
	ejI+gHJtnmtdcRQgryHca185AMKvRw3STJUjJkBFyfLRzTY4eO/siNPSADWF0knl
	ellWww==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hj2skuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 05:54:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C5s2EK003270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 05:54:02 GMT
Received: from [10.216.41.154] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 11 Jan
 2025 21:53:59 -0800
Message-ID: <b9021f1a-3ea1-4e31-9f44-5b031878e0ff@quicinc.com>
Date: Sun, 12 Jan 2025 11:23:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix key cache handling
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
CC: Kalle Valo <quic_kvalo@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20250112-fix_key_cache_handling-v1-1-aa952cd3c368@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250112-fix_key_cache_handling-v1-1-aa952cd3c368@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9q46CH9ko1NEP0k4pnbcfzQFY7CEPW3T
X-Proofpoint-ORIG-GUID: 9q46CH9ko1NEP0k4pnbcfzQFY7CEPW3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501120049

On 1/12/25 11:19, Aditya Kumar Singh wrote:
> Currently, an interface is created in the driver during channel assignment.
> If mac80211 attempts to set a key for an interface before this assignment,
> the driver caches the key. Once the interface is created, the driver
> installs the cached key to the hardware. This sequence is exemplified in
> mesh mode operation where the group key is set before channel assignment.
> 
> However, in ath12k_mac_update_key_cache(), after caching the key, due to
> incorrect logic, it is deleted from the cache during the subsequent loop
> iteration. As a result, after the interface is created, the driver does not
> find any cached key, and the key is not installed to the hardware which is
> wrong. This leads to issue in mesh, where broadcast traffic is not
> encrypted over the air.
> 
> Fix this issue by adjusting the logic of ath12k_mac_update_key_cache()
> properly.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 25e18b9d6b4b ("wifi: ath12k: modify ath12k_mac_op_set_key() for MLO")
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> ---

Pls ignore this. 2025 Copyright is missing. I will add and send v2. 
Sorry for the noise.

-- 
Aditya

