Return-Path: <linux-wireless+bounces-3864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5685E2DF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 17:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8FC2874B9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708C280BE1;
	Wed, 21 Feb 2024 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AsoYCcrp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3C8120D
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532239; cv=none; b=TfiKRtkWYaNEiokNxbAf0sYpGuAjQwamnmzMeOl1igUhsS8ON4J9yKI6yGUrKrIxgJBB5hYhC912oJ7HdruI8s7WIdxBcoDkxIovbTarymf0xjIYZpwsJbuqPJ8yuaW4FTUIT1Bc+EUB/L9d6909xPnaxYiKoZUdikb31wwFlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532239; c=relaxed/simple;
	bh=M9X7EscYvMF2dO7chP8EmiQsd0duTJ5JHJHZEjmCBAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K3Tp0z2RE0aql6IGyAGoZJivpOA0Jh7QsnEYjOoxDltBt72dWS9rzIWB1I7RX+oOy+z/CoWDDvUU0WOlfDwZu90c+0ofskPiqIvAXqSQ+/1hsFJJzMn8tLYyB1ct7c6h5dIzTMzx8LM48dDpgjEwiBAORhMdFf4O3N/6gIGXINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AsoYCcrp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LDD7Df019284;
	Wed, 21 Feb 2024 16:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Up5OiSJPtByuUJ5N/MVp5+gGdCLOb4T2zv/QM0xeTIE=; b=As
	oYCcrpz5Mevnzfbo1husL6FUHusaCAnmc0LAxsmm/9OzL9glKeDWXOMaPpN23nEO
	Q6NSg74tUMVfUP369Mv/Q5n4jXOaApBieRLzYvfS89i2UsSSuY4ao7HAdTiMpGqE
	sfoG/RqIRb/MnSE4M8jwBZZwBSPh4pCh7+wV0kCAefvOc7qwJG4J9T+6843xU8Qq
	7fIH1gn7tQYLepkUhZLFpQejN2legGDs2UWu2H//WfwYGwLG77xZL1UxHINOaElb
	4asIIaEVyYjt3wu/wMf3ub9Y/EiO1gQglMyMLQi7OtJ7DpT1/IywfmbSTBhK5Jtx
	4rKMA/T7HSQX9cscbLKw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdgge0nhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 16:17:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LGH4fA001353
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 16:17:04 GMT
Received: from [10.110.34.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 08:17:04 -0800
Message-ID: <19bd12e3-e943-4d93-a8d3-ae8103d50e6c@quicinc.com>
Date: Wed, 21 Feb 2024 08:17:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240219095802.1147-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240219095802.1147-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dt3mMg-lpiOsp_8XjMaQ9UmkTHv1VJkx
X-Proofpoint-ORIG-GUID: dt3mMg-lpiOsp_8XjMaQ9UmkTHv1VJkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_03,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxlogscore=978
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210126

On 2/19/2024 1:58 AM, Lingbo Kong wrote:
> The tx bitrate of "iw dev xxx station dump" always show an invalid value
> "tx bitrate: 6.0MBit/s".
> 
> To address this issue, parse the tx complete report from firmware and
> indicate the tx rate to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct tx bitrate such as:
> tx bitrate: 104.0 MBit/s MCS 13
> tx bitrate: 144.4 MBit/s MCS 15 short GI
> tx bitrate: 626.9 MBit/s 80MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
> tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

With one correction below which Kalle can make in the pending branch
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> diff --git a/drivers/net/wireless/ath/ath12k/hal_tx.h b/drivers/net/wireless/ath/ath12k/hal_tx.h
> index 7c837094a6f7..7cfc584649ad 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_tx.h
> +++ b/drivers/net/wireless/ath/ath12k/hal_tx.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.

since no changes were made in 2023 should be 2021-2022, 2024



