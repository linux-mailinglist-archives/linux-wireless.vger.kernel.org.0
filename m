Return-Path: <linux-wireless+bounces-10403-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE36F937E4C
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 01:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21ACF1F24C26
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 23:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1AE6FD3;
	Fri, 19 Jul 2024 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q4hx50cp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4FA35
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433488; cv=none; b=hTbcrEBhUiBF6yLGuUsn1YUqzNYVZp2YbD7jmz3qRxF2KiYSrSEtY1jrRo6ZtQ/TvZ4d1rdfiKq0DbmBiLzb0w0WNjJwVuWrp/gs9qidqStA98oAVcbdbDUo2rO1aIxoBgzEBWF2OSOscqIfSOPdDPhxoK0rmmyjpiimoeDLCdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433488; c=relaxed/simple;
	bh=A4dTkHjt908Ijc13Pvi27ulAMJ10Klk4zNz8bcejjK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cxab9bUBalG+q2YEmRlbpH0JbcXspkIuZ8D+yszadUMpBMtbJwsKPfiY3ACuPl5eu7INlhCkF+NrPxr0JtxREmUl7ZeikMqfks+z3mLfAo+xqkClD3xXUIpzi2jQOobCqEktmX5BpStxF5rHZqf03Dno1NEx1jaO4KNmJ058Wgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q4hx50cp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBnbqT026644;
	Fri, 19 Jul 2024 23:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EyKmHv6DgPfM8GkovqEyR/xI1FsVZOMudVvuW6mxyqE=; b=Q4hx50cpJn3pjLMj
	SJPr3Nype4Cn0yvB7Wrxe13QPOFK+21kJe3/LZ7wCHCD6JHcV5cnXSN8eAHlbrw3
	1uSTMaj5aFxaMSuLEqFbMQTrGmudK/HHS4RNLJL0739i7vLrrEDXBVuvKFlWdiEw
	l95ptsJ1Nfuhzy5D8wvIlhX8vNwRHUtnvQfBK0Q4rHNEwkxMgsEi++3IIyLK2Jr1
	EnPoX/A5vAvtmDEvBCoOvOAqKOXJwXiZzarxgg2Fs2FznvqNSnUipfTrel4TvG0P
	Ji23aFjicqRrCVwlZmgPYWK/Kh9vF+ERqCegi6/xeYuoLW22TqUxM4p4m1ANyJRZ
	iRGtww==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40fe2utpxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 23:58:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46JNw2UT030431
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jul 2024 23:58:02 GMT
Received: from [10.48.244.127] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Jul
 2024 16:58:02 -0700
Message-ID: <3413e113-91c2-420f-83f8-5d610aeac877@quicinc.com>
Date: Fri, 19 Jul 2024 16:58:01 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] wifi: ath12k: report station mode stats
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240718120725.130265-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240718120725.130265-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 415wasvYwyuyPUfrmaM9MVF2jfDLRBGM
X-Proofpoint-GUID: 415wasvYwyuyPUfrmaM9MVF2jfDLRBGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_09,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407190177

On 7/18/2024 5:07 AM, Lingbo Kong wrote:
> Currently, the transmit rate, the receive rate and signal strength of "iw
> dev xxx station dump" always show an invalid value. 
> 
> This is because ath12k has no logic to handle this relevant information.
> 
> To solve this issue, ath12k parses the information passed by the firmware
> and passes it to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct value.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  600 ms
>         rx bytes:       4642228
>         rx packets:     23796
>         tx bytes:       933967
>         tx packets:     8761
>         tx retries:     66
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      8925
>         rx drop misc:   191
>         signal:         -20 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>         tx duration:    0 us
>         rx bitrate:     1801.4 MBit/s 80MHz EHT-MCS 11 EHT-NSS 3 EHT-GI 0
>         rx duration:    0 us
> 
> v5:
> 1.use ieee80211_find_sta_by_ifaddr() to avoid using base_lock
> 
> v4:
> 1.rebase ath-pending-202404181533
> 2.change ATH12K_EHT_MCS_MAX from 13 to 15
> 
> v3:
> 1.change wmi_vdev_stats_event to wmi_vdev_stats_params
> 
> v2:
> 1.change copyright
> 2.change name according Naming conventions for structures
> 
> Lingbo Kong (3):
>   wifi: ath12k: report station mode transmit rate
>   wifi: ath12k: report station mode receive rate for IEEE 802.11be
>   wifi: ath12k: report station mode signal strength
> 
>  drivers/net/wireless/ath/ath12k/core.h    |   5 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c   |  20 ++-
>  drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
>  drivers/net/wireless/ath/ath12k/dp_tx.c   | 117 +++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/hal_rx.h  |   3 +
>  drivers/net/wireless/ath/ath12k/hal_tx.h  |   7 +-
>  drivers/net/wireless/ath/ath12k/mac.c     | 141 +++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h     |   4 +-
>  drivers/net/wireless/ath/ath12k/rx_desc.h |   3 +
>  drivers/net/wireless/ath/ath12k/wmi.c     | 130 ++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h     |  49 +++++++-
>  11 files changed, 472 insertions(+), 10 deletions(-)
> 
> 
> base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45

FYI this series does not apply cleanly on top of:
4c1cf2d8e5dd ("wifi: ath12k: prepare sta data structure for MLO handling")

And I currently have that as my basis of work since it is high priority to be
merged since the MLO feature is dependent upon it.

Can you rebase against that series?

/jeff

