Return-Path: <linux-wireless+bounces-12268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F851966669
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 18:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DDD1F265D2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3311B5ED2;
	Fri, 30 Aug 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jZAtzviA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE1E1A2C35;
	Fri, 30 Aug 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033712; cv=none; b=jiACe9yAkZ86e+9aMNBe6mlcppyAn0CcW8kHz6GECV1opwZQ5X/VAOIYyEJL+wqd1He9hJ77dugUWPzfP5KEmHADKwQ8pcDbsPG6O6i+Zh5fiv5hz9fGfojgIMdCaeXDD9VNUIGprX+lWaYSESCrWqdRZuidXB0NKz8gHaTw/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033712; c=relaxed/simple;
	bh=16lj0Ja7gHILLEZora4E65v9tQ3y4iAKP3+Kl60/RSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OmIZAaFAp+/EhZSlaGyUluUSMNMWiP4uuR5J1vWFzPEqr/6s7a195OO4ppkMVrz9v6y1qFgtUwK60j/WugAwPXWVqpHxFCWNfLDl1r5FjbaUeVll7rfn4CS8mQwxl+UDGyJb4bG2868UbGW6Xr1shGq8yS2BJ9pvnpqe67r8M+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jZAtzviA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UEttMM011674;
	Fri, 30 Aug 2024 16:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fZ6BleY6hJxhqNSKGHouVM4VvjSsw9CDGQREuyoil4U=; b=jZAtzviAb4NjNWR8
	5llO2FoqPCfsZXwpNcLCfvqor0OpeXwtBviJySKVJZEO8Oy827/+QDjdBDQhPbe/
	T63Zib5JO1WjFlS8Jj06OOt0mRZl9zm1fnkvnAF0VFqbXMiyXwG4sC59JdalfrYH
	DMHJkmuuT1iBuiMWJXxCedS6nLWsRAARe9PX2a2YvazD0aIZ8wHUIpr9QIE+P9kW
	iYNHxB1LL56M50Qt7JTQ033GF+y4GiAsnfDd6IflJVuRH6r4ZMlHZFOL+hoCE5Jf
	qGpyS/pIWsxoQ7ovQYY8jXoHPNak8lGHcr34ASfPNFSEWfwXMrggb0KhTLUnEmJ4
	uuo0KQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0sk4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 16:01:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47UG1bt1030541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 16:01:37 GMT
Received: from [10.111.180.95] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 09:01:36 -0700
Message-ID: <29bf2e9c-ca24-46d1-93e4-3b3f3f812705@quicinc.com>
Date: Fri, 30 Aug 2024 09:01:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: Fix potential RCU dereference issue in
 ath11k_debugfs_htt_ext_stats_handler
To: Jiawei Ye <jiawei.ye@foxmail.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>, <corbet@lwn.net>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <tencent_A64CA96B962349E369B349EA01EBC53C3505@qq.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <tencent_A64CA96B962349E369B349EA01EBC53C3505@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ARulsQs3EzcXSvTL9NRtBApJhL6BoHhr
X-Proofpoint-ORIG-GUID: ARulsQs3EzcXSvTL9NRtBApJhL6BoHhr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=737 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011
 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300122

On 8/30/2024 5:02 AM, Jiawei Ye wrote:
> In the `ath11k_debugfs_htt_ext_stats_handler` function, the `ar` pointer
> obtained via RCU lock is accessed after the RCU read-side critical
> section might be unlocked. According to RCU usage rules, this is illegal.
> Reusing this pointer can lead to unpredictable behavior, including
> accessing memory that has been updated or causing use-after-free issues.
> The `ath12k_debugfs_htt_ext_stats_handler` function in the
> `drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c` file provides a good
> example to follow for addressing this issue.
> 
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
> 
> To address this issue, the RCU read lock is now kept until all accesses
> to the `ar` pointer are completed. A `goto exit` statement is introduced
> to ensure that the RCU read unlock is called appropriately, regardless of
> the function's exit path.

This analysis is incorrect since ar is not an RCU-protected structure

The rcu_read_lock() is required internally within
ath11k_mac_get_ar_by_pdev_id() when retrieving the RCU-protected pdev pointer.

So NAK this patch.



