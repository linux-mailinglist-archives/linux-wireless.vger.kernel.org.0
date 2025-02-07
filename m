Return-Path: <linux-wireless+bounces-18641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC47DA2CA10
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 18:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9643ABCEF
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 17:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0814F192B9D;
	Fri,  7 Feb 2025 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K2psDz07"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FA191F95
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948932; cv=none; b=eABpwY51lUNMz/2hwQ76pwr2PbZ5vwXt+WKmIwuzMtItiA2ScrEaFcM6snjIXUbsY1qatpvRCG+DMN0RLvjr8e3fDKClrFDgbrympLVWztml71okCk83fyhmlh6dudvKGGzcSjs4KfTWH9MadFM0lxwoZ6Rwihj1WSozABkGhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948932; c=relaxed/simple;
	bh=DdO1WIXA7MiLnvoGHOtxlOF1Rh51gaPYmRnv2pcciYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AKNqsDxqgoUqyM7xbQwgjVrifnaxsImUMNCT7KxqxSfORahlWT23NA9EPM29OyU4ZCm4qNhrgXAojJsbHJQnKJ/0bsExtbN++oU0TjCKLUJjTYCmmZHPVnNfTMp19Pwzp8P9Fo4NhOCq/JVxZITQlDnB7jA+5ZcmJcQWpwtlCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K2psDz07; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517B2frC003172;
	Fri, 7 Feb 2025 17:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3+kGIu2+0jELvTgzM8FnuszxLPQWE4otgI+EIZeKUbc=; b=K2psDz07oKR5loFK
	TftjcpQOoJfntlOBNe78+oFtLIsMF/sStTz6ar0339ZsArcdUYun2gZSNAWJ3cPr
	4a8P6y73bP+Ka6HKs6oqHOdFJITzQsU8fl4+FxRrnKRmvvQtMkgx0Lx5ZwzzSei+
	9wzTGjZygMwVm4wJpD+tSt2QJzMPs9XhaUcGVlGjK2cAQ+kFj///VTviLLYQOLI+
	wqpHavnF1dIhSupWRkHnHOS3KgEu5sJMQSV/ewY2IQ7v6kwAoZmHL7oG+/ApKH5A
	GvzdsdaP8tlCQZsP0CbWUh8LLGV5CBF/ftscXFK2dblaeOyfRXiDhdnIKl/JK6YW
	sHGmQw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ngy10x3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 17:22:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 517HM7tE020993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 17:22:07 GMT
Received: from [10.50.26.45] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 7 Feb 2025
 09:22:06 -0800
Message-ID: <4b4ea75c-8af2-6021-34a4-ff382a42d413@quicinc.com>
Date: Fri, 7 Feb 2025 22:52:03 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] wifi: ath12k: Enable REO queue lookup table on
 QCN9274
Content-Language: en-US
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250207164703.3818135-1-quic_nithp@quicinc.com>
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
In-Reply-To: <20250207164703.3818135-1-quic_nithp@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6yw3jbf4lMoozL_2aEq2ka1N6kBJ2CBm
X-Proofpoint-GUID: 6yw3jbf4lMoozL_2aEq2ka1N6kBJ2CBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=866
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070129

On 2/7/2025 10:17 PM, Nithyanantham Paramasivam wrote:
> Instead of storing the REO queue address inside peer entries, REO
> hardware module prefers them to be stored in SRAM which could be
> directly accessed by REO using peer_ID/TID based Lookup table(LUT)
> mechanism. This feature is expected to improve stability by reduced
> interaction between host and firmware during both MLO and non-MLO
> operations.This feature is enabled only for the QCN9274, so it does
> not impact the WCN7850.
> 
> v9:
> - Rebased to latest TOT
> - refactored the common code to function
> - reolut size variable added
> - moved ab to front
> 
> v8:
> - Addressed baochen comments
> - For this, added changes for paddr/vaddr alignment
> 
> v7:
> - updated copyrights
> - removed memset
> 
> v6:
> - commit subject change patch (1/3)
> - tested latest FW
> 
> v5:
> - Rebased to latest TOT
> - updated the changes for ml peers
> 
> v4:
> - Changed Read Address Name
> - reo lut support check added for qref service flag
> - Instead of [PATCH V4 0/3], had [PATCH V4 0/2]
> 
> v3:
> - Added new patchset(patch-3) to enable the reo lut
> - Edited patch names
> 
> v2:
> - Rebased on ToT
> - Addressed review comments
> 
> Balamurugan S (1):
>    wifi: ath12k: Add support to clear qdesc array in REO cache
> 
> Nithyanantham Paramasivam (1):
>    wifi: ath12k: Enable REO queue lookup table feature on QCN9274
> 
> Sriram R (1):
>    wifi: ath12k: Fix the enabling of REO queue lookup table feature
> 
>   drivers/net/wireless/ath/ath12k/dp.c     | 79 ++++++++++++++++--------
>   drivers/net/wireless/ath/ath12k/dp.h     |  7 ++-
>   drivers/net/wireless/ath/ath12k/dp_rx.c  | 11 +++-
>   drivers/net/wireless/ath/ath12k/hal.h    | 10 ++-
>   drivers/net/wireless/ath/ath12k/hal_rx.c | 19 +++++-
>   drivers/net/wireless/ath/ath12k/hw.c     |  6 +-
>   drivers/net/wireless/ath/ath12k/hw.h     |  5 +-
>   drivers/net/wireless/ath/ath12k/wmi.c    |  8 ++-
>   drivers/net/wireless/ath/ath12k/wmi.h    |  1 +
>   9 files changed, 110 insertions(+), 36 deletions(-)
> 
> 
> base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9

Please ignore this version due to junk version histories added.

