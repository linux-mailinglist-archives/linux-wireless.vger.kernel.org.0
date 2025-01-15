Return-Path: <linux-wireless+bounces-17540-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698EA119F4
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 07:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A257A167C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 06:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8F22F175;
	Wed, 15 Jan 2025 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JKE3iEj/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C511E04BE
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923493; cv=none; b=aAtL5UrqBJLNNZnMWknvWlp+UtcrroeHC+0hu9TqQftHezPB99W+kJl6RZRQUcaIqyuL2quX5KwIePdZ3zM6yZ275RtXQ1+Sgap/5kWCiD3w3DSmr35y4OlSyM0hpXKPEVw7STpqRRUmjVUc/B+lmkRWW02lT+pFal9Mxf8dfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923493; c=relaxed/simple;
	bh=TlUVncyIME8F1iB/QyOBs4nrnx064EZSZ94AnTbrWwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Eun0Euq/+tQastcdHYJshYvmT78IP50C3AEYx5AzffFfOfzVesc4D+vl+dsJ+qUPk69JVLmg0QMuPuFMFmcz/FQaU4Q0CfifE0xJiiuSsCaxmQnXCrAZ5qYDnqEJpe9dWsMMbb82wEzNZ0xmn5nKRWeDOJVJToff7dj3w3yvzTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JKE3iEj/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELcDJD012499;
	Wed, 15 Jan 2025 06:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YGZ0TShWUotMxawqv6H0GihgtrKfMbRR2KqTx5c8Y5s=; b=JKE3iEj/xiPe7zpP
	QvlagR3fN5z4kSZwl96IDej0wU18ZvVkW0kKBjl8gSpWE8H5xYSt4AXzNgq4i+8d
	QySHV2mldQp8Lnaf6p7jTd5Q6vyeoF10fTNLSwsj7KPjfFtAoBoK4F9dZ5XJN3Em
	qwi1UvJcRtqW4Wi4OUZkzIJTuWLkhBvK95y7zkmWRftueItjs6zqFA8q9YSedTdb
	kQ+B4eT7prM2ax6oQqzDLe/TldmENUBMw7vVx1fQA+1nCWlaSKVGjApVktustrjx
	Vp/mrV73Tg09Hb5tP26iIrcZ5xbj2Cf50j8HsM+bYUvxzN+QlE/Qh5jAwvAVtYzI
	tBSYTg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44600p12jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:44:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F6imlh031430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 06:44:48 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 22:44:46 -0800
Message-ID: <1d6b6601-f8a6-4ec0-9741-29eb634fa391@quicinc.com>
Date: Wed, 15 Jan 2025 12:14:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] wifi: ath12k: Support Sounding, Latency, Trigger,
 FSE stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250114123835.882926-1-quic_rdevanat@quicinc.com>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Content-Language: en-US
In-Reply-To: <20250114123835.882926-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MPtGlAPBL3MJWVEJGcLjVPU5gx-T8_1A
X-Proofpoint-GUID: MPtGlAPBL3MJWVEJGcLjVPU5gx-T8_1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_02,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150048

On 1/14/25 18:08, Roopni Devanathan wrote:
> Add support to request HTT stats type 22, 25, 26, 27 and 28 from
> firmware. These stats give sounding stats, latency stats, trigger stats
> for uplink OFDMA and MUMIMO and FSE stats, respectively.
> 
> v4:
>   - Squashed patches to avoid build warning.
> v3:
>   - Rebased on ToT.
>   - Removed patch dependencies.
> v2:
>   - Added line breaks where necessary, as pointed out by Kalle.
>   - Modified the use of pointer arithmetic print_array_to_buf_s8().
>   - Modified commit logs, as suggested by Kalle.
> 
> Dinesh Karthikeyan (4):
>    wifi: ath12k: Support Sounding Stats
>    wifi: ath12k: Support Latency Stats
>    wifi: ath12k: Support Uplink OFDMA Trigger Stats
>    wifi: ath12k: Support Received FSE Stats
> 
> Roopni Devanathan (1):
>    wifi: ath12k: Support Uplink MUMIMO Trigger Stats
> 
>   .../wireless/ath/ath12k/debugfs_htt_stats.c   | 736 ++++++++++++++++++
>   .../wireless/ath/ath12k/debugfs_htt_stats.h   | 269 ++++++-
>   2 files changed, 970 insertions(+), 35 deletions(-)
> 
> 
> base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256

Comments from v3 regarding copyright were ignored :(

v4 still throws -

* drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c: 2025 copyright 
missing
* drivers/net/wireless/ath/ath12k/debugfs_htt_stats.h: 2025 copyright 
missing

No need to resend just because of this. But if there is next version, 
please *address this*

-- 
Aditya

