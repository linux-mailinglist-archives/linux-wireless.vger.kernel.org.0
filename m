Return-Path: <linux-wireless+bounces-5615-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7303789231F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 19:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A68B1F227CE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E6836AF9;
	Fri, 29 Mar 2024 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WI3bVZmH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959D52F79
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 18:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735534; cv=none; b=ciCzz+8vVglL3apBVIgHJKp0JQvwa2u5/ak8NacaXhs/sAinfh5gjRB5dH037cKvNvvpYVW8rMZ3wQN0zRFsT2AwJa5K7yZg6MFOIqzd0heS3yVzEa7H8V9JMXSldNl0gX9VaxLqHgMU7EKUg3L1mqCctewm9d/HT2S1mrITO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735534; c=relaxed/simple;
	bh=ZPlR9VMf8USY38H118MYxTGysbG1CXfPVv1i9Qh4/0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UPr3rknBQ1o9Uq65o4XzvzIF5cnLFJ/JbVFvHrzab0gve6GeIEpjd/2oWA/A69fm06AyEm+C4LjxuTe3fRoiIhwE8NRDcEtMCYKTHmBUjo3RwHX+Gop4Npk0S3sEteAOIPykQWwlKhQ3SzMeUDZ0F3rLe5yDrRyYG+b/6ykToz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WI3bVZmH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THvch7015978;
	Fri, 29 Mar 2024 18:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ycvtkaXpqneUcI2YMu/pfRuSa49WepmX1fMSiUK+vkY=; b=WI
	3bVZmH12P4Ya/uLUU1pZQKpDVHfw0v+79Sdlbvq/2EC5nfyqR4CgXkgdcUG0pTyz
	T168+Q8fsfoHm7NUDkUcCb+C13vj/JqQ0Co8P1x4ddt2R038R5qsMiB9jgG2mtqb
	nc9AXQRFu99fDqLvOlgPUvgYLRvvcGYbJxOTUZZJOaTfPzibmGggFns7vrZOBw1e
	itqOeFI0OEKVTCKXRmBOYIfqJoC8HFFTKgIDPYH90Ia2B4cdIW7sMAlliYZZg1JL
	GVFZlsT2iMtjxNcSY/9em++nIPWWg7tmZjCJz4Gfy801342T7oqiqwDk9mmY6k6S
	n/RKo8/vfvAMGmm9ER9g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g0rgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:05:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TI5SBJ004860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 18:05:28 GMT
Received: from [10.110.124.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 11:05:28 -0700
Message-ID: <b06aa120-8d01-48e4-8caf-63f7653878a5@quicinc.com>
Date: Fri, 29 Mar 2024 11:05:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] bug fixes and enhancements to 6 GHz band support
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240329173926.17741-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TokXJTNjf9VUOem9ZCsxacaPCHbGlUOa
X-Proofpoint-ORIG-GUID: TokXJTNjf9VUOem9ZCsxacaPCHbGlUOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290161

On 3/29/2024 10:39 AM, Pradeep Kumar Chitrapu wrote:
> In 6 GHz band, add support for
> 1. channel 2.
> 2. Fix packet drop issues.
> 3. AMPDU aggregation
> 4. SMPS configuration
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v2:
>  - Disable smps for WCN7850 after review comment from Boachen
>  - Added Tested-on tag for WCN7850
> 
> Pradeep Kumar Chitrapu (6):
>   wifi: ath12k: add channel 2 into 6 GHz channel list
>   wifi: ath12k: Correct 6 GHz frequency value in rx status
>   wifi: ath12k: fix survey dump collection in 6 GHz
>   wifi: ath12k: add 6 GHz params in peer assoc command
>   wifi: ath12k: refactor smps configuration
>   wifi: ath12k: support SMPS configuration for 6 GHz
> 
>  drivers/net/wireless/ath/ath12k/core.h  |   2 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c |   9 +-
>  drivers/net/wireless/ath/ath12k/hw.c    |   3 +
>  drivers/net/wireless/ath/ath12k/hw.h    |   1 +
>  drivers/net/wireless/ath/ath12k/mac.c   | 116 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/wmi.c   |  10 +-
>  6 files changed, 116 insertions(+), 25 deletions(-)
> 
> 
> base-commit: fe7e1b830cf3c0272aa4eaf367c4c7b29c169c3d
Unsurprisingly since I just reported them, the two ath12k-check issues in the
v1 series are also present in this series:

drivers/net/wireless/ath/ath12k/mac.c:1946: line length of 93 exceeds 90 columns
drivers/net/wireless/ath/ath12k/mac.c:1967: line length of 94 exceeds 90 columns


