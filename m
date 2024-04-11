Return-Path: <linux-wireless+bounces-6205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F368A2117
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 23:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750FC28444E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 21:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B694A2E40D;
	Thu, 11 Apr 2024 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SygdXu6H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865D1CA8F
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712872066; cv=none; b=bSENVm+rh6lfnI3yxZT3gd96DvZvahOb28rjWDYCgwLtN56Fg4wlP21jtLFh5rwWrVBs0I19iGffqeabrdpRxG7jcimO+1+sQ4trzvkoHmDAbZ0IyNHefJhDEcAmMZBtCXOmccZSFr30Z2kjhvNolFVPrdMS4EU90pTl27C2GkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712872066; c=relaxed/simple;
	bh=RUumeUIzwWbwt6DAm7b5xhytSpZbxjBwF/extvkd9q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=juDtqpqAjQ53ENXVyTFkf3RbxIaQFIlbSAMkxFgVIzxSFOhtA4ioTnInYj6mTnSBpSiXL5RMUK6OpYaoejt8HdV77uwnhIwDX2h5cmUdORwx6cwIxNhwMaqPMxXry39H+da/3EVkVFkLIrN9Zk7qE0bwIGbMdhWcl2Z/m1REURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SygdXu6H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BLCeOR015507;
	Thu, 11 Apr 2024 21:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cihpdvIOW1doaaovCJ9ppL5XIiJi/EAo47Tu85nA6uU=; b=Sy
	gdXu6H8nxraZVPKvWb4be+iUvc4aeDBDZFI6Zgs6y2QnIxdn2xYRtP8iUONJjMUe
	9jIY4iMoVHMQ6lhPC8ljJQGuZsm7MVFvep2m4so32wXKhnbkUYLIBWKYfAuwrMq3
	l+ihzyCVr2ViVNMPG/aqDmumC8COjKA4JaR5dKBCa9QN9DXsZC0B0Mx5a3NPFUs+
	gl7ASI1P9hh45X9BtsAb+gdCf/yROzNITZN3nC4IIKb0d/QCum442TJ9kOftWdvf
	BZOg8mVNJ+lqb/Kbsk6KmKj/jOfm55zaXrxWEGRPHQBpX0cpZ5BMj2FQeYYJy8C1
	pFQkEr24AFCOBkfDd67A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xem8m0fk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:47:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BLldUw028119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:47:39 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 14:47:38 -0700
Message-ID: <d65bc112-3660-42f5-96f4-04fe2b556159@quicinc.com>
Date: Thu, 11 Apr 2024 14:47:37 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath12k: report station mode transmit rate
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240411025322.33888-1-quic_lingbok@quicinc.com>
 <20240411025322.33888-2-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240411025322.33888-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WKCLTl-O1SIQJuSjzePGfdSdsdprnlh7
X-Proofpoint-GUID: WKCLTl-O1SIQJuSjzePGfdSdsdprnlh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110157

On 4/10/2024 7:53 PM, Lingbo Kong wrote:
> Currently, the transmit rate of "iw dev xxx station dump" command
> always show an invalid value.
> 
> To address this issue, ath12k parse the info of transmit complete
> report from firmware and indicate the transmit rate to mac80211.
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> After that, "iw dev xxx station dump" show the correct transmit rate.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  872 ms
>         rx bytes:       219111
>         rx packets:     1133
>         tx bytes:       53767
>         tx packets:     462
>         tx retries:     51
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      403
>         rx drop misc:   74
>         signal:         -95 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h   |   2 +
>  drivers/net/wireless/ath/ath12k/dp_rx.h  |   3 +
>  drivers/net/wireless/ath/ath12k/dp_tx.c  | 147 ++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/hal_tx.h |   9 +-
>  drivers/net/wireless/ath/ath12k/mac.c    | 124 +++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/mac.h    |   3 +
>  6 files changed, 282 insertions(+), 6 deletions(-)
[...]
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

per current guidance if the file was not modified in 2023 the range should be
2021-2022, 2024



