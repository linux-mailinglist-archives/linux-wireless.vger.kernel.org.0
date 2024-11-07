Return-Path: <linux-wireless+bounces-15032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11C9BFD6B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 05:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A392928390F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 04:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5914018E35D;
	Thu,  7 Nov 2024 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L1aNA8+6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E818FDDF
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730954438; cv=none; b=bMZU9RJZ/tfCD0ZzjRnrA2yxvKmTiukS67YevZnWbzAhnZHJA8k8gWqPjYrYLolXDKPAcaVOSF3mfYgvMcT76g6I1/7pRh316rbQogw/pxpoKXiZlJYovEAPtlUej7Zs/uHs36DwSM4OIuoef6+9B+UQEkG8NAGrzsSFl4LLEfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730954438; c=relaxed/simple;
	bh=O3/dRq8ppzljGeUsIhQIZ58Ef+XGXwAM6j7Vrj6vxsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nldPWOcTzRPN7SixXa1WwfAc/qcrCcapYUdGumfrfpjJAP+QemzlaeMzdw5en4ucs2q2YcBhsCWB20pY9jaYarLKEP/lKbzqIX8XKsrXSbLOtKXMkvfJ4I9M5NcORwIchzE1xHpRXriVEc+NxqpC/aImIbtGJFb+zvBf3yNYL9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L1aNA8+6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A710DtG003824;
	Thu, 7 Nov 2024 04:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	674JsR+74WDU+DeXRuClw9K98WoQD8yNovT8Da/Kxp8=; b=L1aNA8+6v1viAXH5
	4cD5JzR7l+Cv067BQpwtpTgytTsOH2bfCX4EpKkGFwcZyMZ8P259ym/XwdOaRsZK
	OLIG0ITwILNU+s3eLP2ZNFIkNpSt68zXCXhfn4zjB4nZjn8YWVo/9YaaUBqwyZxA
	fSl1oXZ2Rjyf120DVWpdmDtJ/af3ylE7hVqaWpxjPpPqT0E7//NDykRU5OLGSEjv
	A0rDE3/GsTd0+FYOGtkFuDh8jGu/MoTUWjr7MUSNZgeg9aRDtbvn3iaDd+lTB1YL
	Dcup9+W3lfKjNXcV4mIFHUCsXdeXQGZpl2AHxDRqXQGMjcIDi0mYucmU+KrOCwyu
	05m9eA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qhbue19r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 04:40:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A74eVZa006627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 04:40:31 GMT
Received: from [10.48.242.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 20:40:30 -0800
Message-ID: <70aa1ba8-b648-4be0-af6a-db424010d743@quicinc.com>
Date: Wed, 6 Nov 2024 20:40:29 -0800
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
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nww6r40upfz6OdkFIWYm_lXfNydtk2yA
X-Proofpoint-GUID: Nww6r40upfz6OdkFIWYm_lXfNydtk2yA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070032

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

when I build this series with W=1

drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c: In function 'ath12k_htt_print_dlpager_entry':
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2582:13: warning: variable 'ts_hi' set but not used [-Wunused-but-set-variable]
drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c:2581:13: warning: variable 'ts_lo' set but not used [-Wunused-but-set-variable]

I can remove these locally in 'pending' if there are no other issues.

/jeff

