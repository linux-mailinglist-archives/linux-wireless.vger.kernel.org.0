Return-Path: <linux-wireless+bounces-15020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13D9BFA98
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74AE3282CB7
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 00:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2763D;
	Thu,  7 Nov 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PVIAGo6j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD44624
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938514; cv=none; b=gfRqCGJTB4P40bjxTEdjXjk7STScnCqSuyXeaxQjVKw2FYdqGBww9uEjiYuY0mmZpJ11H/Tl32UL6UH2E5WJ34gIKHu3gNUhLonU3VZWewmkUu/W8i2KGkBZsBfHUcrbzXZh9uP4Ol8VWDEAHzxVN2tsB0NxHTmTulVY8UYeqcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938514; c=relaxed/simple;
	bh=yMTIGMxSsmy0RP15BqJQbeDpv4WmtdZLIhRjdx9cYXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VSKFM5Bd3eFbFNOX5AIZPcgWRaItjeCwU7AGXFRWmRibgmK25Bv6Aq1uZhdObXEnaNjEiS6TU63B1r+62vUstAdc8ZsoZxGTvCmDFC41a7MWmvlfQg6tTnEsRXMWujEk86ku/OrPEqycFPxZpSrmcRliYYdB6PDcOEKVr7Q8DDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PVIAGo6j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6M8hJk015673;
	Thu, 7 Nov 2024 00:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kxbd82ch1M5jS8FmBwduEv1Knck7CcQmjM3RT1ky96Q=; b=PVIAGo6j4ARNsRTQ
	VYGxQixJopV9KvaRYUafZPlHPgVqO71SzGOdnokfqdcQfKsmyBMYeMaFfuQBNJC9
	F5xXqVYML1dEWCelmpm+omCkWHt81WCOKXGgaacj3qiKLN5mnryhoHhU9OMrCura
	hR0GZ/OyqC0QJx8DDoeFqV6qek9/qBVWHru/i3Zwza8D2HJOMmUJVYepgWCTn5QC
	68JlCra8XajL3Qc2FWdxZu2q5Z4gZ53/iEaXbOh9IuYiy9picWUdbj4fEn2MMO+Z
	Vw2P8TYC11VqpI2aooBSZNF1SlJoPdDDzY49z2yrG6xvrX1PNuTVV3+vkWq7WRwF
	aBOUIA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42q5n8q7mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 00:15:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A70F95G011406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 00:15:09 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 16:15:08 -0800
Message-ID: <6f995c95-d9db-4169-8216-fd1959fce2a7@quicinc.com>
Date: Wed, 6 Nov 2024 16:15:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] wifi: ath12k: Support Pager, Counter, SoC,
 Transmit Rate Stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rb8b6eTeK-hTruHi0FxJtLeTBeQEg989
X-Proofpoint-ORIG-GUID: Rb8b6eTeK-hTruHi0FxJtLeTBeQEg989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070000

On 11/5/2024 8:45 PM, Roopni Devanathan wrote:
> Add support to request HTT stats type 36, 37, 38 and 40 from firmware.
> These stat types give downlink pager stats, counter and TPC stats, SoC
> common stats and Transmit PER rate stats, respectively.
> 
> v4:
>  - Addressed Jeff's comments pertaining to data type conversions.
> v3:
>  - Added macros to fix compilation issues.
> v2:
>  - Removed dependencies. No change in code.
> 
> Dinesh Karthikeyan (4):
>   wifi: ath12k: Support Downlink Pager Stats
>   wifi: ath12k: Support phy counter and TPC stats
>   wifi: ath12k: Support SoC Common Stats
>   wifi: ath12k: Support Transmit PER Rate Stats
> 
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 630 +++++++++++++++++-
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 204 +++++-
>  2 files changed, 831 insertions(+), 3 deletions(-)
> 
> 
> base-commit: d63fbff74ab1af1573c1dca20cfe1e876f8ffa62
I acked 2-4/4. I can fix 1/4 in pending so no need to spin v5

