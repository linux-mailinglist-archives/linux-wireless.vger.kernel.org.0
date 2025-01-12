Return-Path: <linux-wireless+bounces-17371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4250A0A762
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 07:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4884E3A8909
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A51494A8;
	Sun, 12 Jan 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LjWbpHfY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80061E526
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736664877; cv=none; b=tXf0nnz5UvDm4tSBA//f/yX1inOMXxLx3BGP6+b//GZhn80yPshjSsHGHUL7VJvKPC3sSbJIF6fszmB2R6XY0RwCa0MyU79yWaSB4CDvfg38dQFtRuU+jHiFTH0JCiwnVvzQmIfV3YFO1KXbvSJnEyUvOelxxUOqLlho1P0zV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736664877; c=relaxed/simple;
	bh=3BtaSuYHIFUVlyRNbXwMtlCPmbpgSw+okUVULAeGDNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IL4MankTB2qDoTwtV0W9hnhp9znnoYt+xY7vg0jBcFQnx5pLvHyl6C5TuKBgMHjCWL5l+8P64amqt+9UH4fZEKXj3Q6/OCEg9h2ahygw9J3CF/MG0fWYpmLkVVEbyqaqW1aQo2Qp3qMzM6/BQTbxrm7qxkmGWSwqVekHGFE5RNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LjWbpHfY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50C4qlRP001052;
	Sun, 12 Jan 2025 06:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P6SOdswlXQpJeG9M9/zb3bM5YxqdVJmfufizN2uWnJg=; b=LjWbpHfYim1x5c0v
	DKVBJcag2FG07pA4yk0+Yu4nWTtgFNuVy4umXCruLvrYnviLNZWn5eHYQuq7cbOc
	40vE/ue0iqRR2f2ENr58/tXpq7fbL8BJSu0QPkISMOC649vFP6IBKQR9rsLLOQvF
	BgznQ1ydx1T9zUWEbEOQGZYUgWOQVjNlm3+trUigo6FKA5E58JhIvk5jW2LnEtVZ
	f18H8UKg6LGSYL4LDNYXVwe6oqn3zHrZPyZkjFSnhTms333GRbyQwtDbB+y/rKoA
	5FiU1qsjNT/mNvtlJ22xxlGIf9NahNR7MHhQt35Eksa/U7zMwF/sFHZhg3j9kRzw
	n7FbKg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 443hkfhnx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 06:54:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50C6sTNm013843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Jan 2025 06:54:29 GMT
Received: from [10.216.44.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 11 Jan
 2025 22:54:27 -0800
Message-ID: <48d37acb-5374-2181-0b35-8bd8dd632a8b@quicinc.com>
Date: Sun, 12 Jan 2025 12:24:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/4] wifi: ath12k: Fix the static checker warning
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250111090129.2733338-1-quic_periyasa@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20250111090129.2733338-1-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F1M0pmrXRkuxaNG6JPbjOkU_gPxwhpD_
X-Proofpoint-ORIG-GUID: F1M0pmrXRkuxaNG6JPbjOkU_gPxwhpD_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=536 impostorscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501120059



On 1/11/2025 2:31 PM, Karthikeyan Periyasamy wrote:
> This patch series fix the below Smatch static checker warnings
> 
> Warnings:
> mac.c:10941 ath12k_mac_destroy() error: we previously assumed 'ab' could be null (see line 11348)
> mac.c:11007 ath12k_mac_allocate() error: uninitialized symbol 'ab'.
> mac.c:11013 ath12k_mac_allocate() error: uninitialized symbol 'ab'.
> 
> v3:
>   wifi: ath12k: Remove ath12k_get_num_hw() helper function
>    - Renamed the patch title
>    - Removed ath12k_get_num_hw() helper function
> v2:
>   - Rebased on ToT
> 
> Karthikeyan Periyasamy (4):
>    wifi: ath12k: Refactor ath12k_hw set helper function argument
>    wifi: ath12k: Refactor the ath12k_hw get helper function argument
>    wifi: ath12k: Remove ath12k_get_num_hw() helper function
>    wifi: ath12k: Fix uninitialized variable access in
>      ath12k_mac_allocate() function
> 
>   drivers/net/wireless/ath/ath12k/core.c | 20 ++++++-----
>   drivers/net/wireless/ath/ath12k/core.h | 13 +++----
>   drivers/net/wireless/ath/ath12k/mac.c  | 47 +++++++++++++++++---------
>   3 files changed, 47 insertions(+), 33 deletions(-)
> 
> 
> base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256


Ignore this patch, will send the next version with updated copyrights.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

