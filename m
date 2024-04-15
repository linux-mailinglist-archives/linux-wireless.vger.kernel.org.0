Return-Path: <linux-wireless+bounces-6335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CDE8A582C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 18:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7359B28804C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1B82872;
	Mon, 15 Apr 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gwL9jE+e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449E83A1A
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199869; cv=none; b=sHHxkIjW10Sy2M2GxGxb9FlVKSV4cWHGV8E2HSN+aoXfr+etRxJpEIeBF1jyEvo5AEWYHiA5YTq1XkLnstphScyeaMEEV/DTCZ95ZOS0Sj9G57RKx2zkbYgd7oxNF7p2wNCNhLfOeUUJXGkoJ/zVUO4ozh7A+HzPb5WJm5JkzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199869; c=relaxed/simple;
	bh=7Y6rZTEJwdgOxcp7Cw/4K65oA+MDNymb+ZciqZlsCYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rzBJb9Fm9VJyvlUv3o91J/23D+9XzxjcOdn+HlixnVG4cwHz8n06hCM9RzXKfiXOlq+IVdhTrVQREs2cdL0zVy+krjslfGNBTNhftAiaIKsO7DjRvOWwk58zq75mWUkspUY7kJCwlIIpXMfiiJ/j0hr5Ho8ntpDS4i7XnjunKXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gwL9jE+e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F4Aq2K011377;
	Mon, 15 Apr 2024 16:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kllx38wEmvwNNSO8IchnjiQ/8uT+LGevuj+cRMUxAvw=; b=gw
	L9jE+eHJ38UVI3s1Hu/d3N8BxSjgNLfuJGrZDF4c+NNd6Vy9mWP0ZwspHl95sAH3
	QjMFL3+IXfBtjWaZ5FC2DkOlOO8v7dsvHVBuY6Cmy+KOadooHXCl7qBux2Bhnjun
	L6owlP8KmgzHJFveDwcURL7mLE8PZETQH+mDvKCvmiH4cZe/BWDN0WIFIkvamSui
	xcExjm4Aj0//sFLlCRtMZnCvq+GOy83mQOH/y2Uw2zxW+nNLLTDjC9QQLy+GyFDr
	AB4xcpnZcaW0yDrOdQrz8NODQXocs64Zz0fIB5Zw7XnTL+7P23mulBVta7pVuyB0
	+e+mdmoqZrK+UhF+daRw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgw01sr1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 16:51:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FGp1iI023343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 16:51:01 GMT
Received: from [10.110.3.16] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 09:51:01 -0700
Message-ID: <3103b7cf-fa1a-4bfc-ad78-301965b72035@quicinc.com>
Date: Mon, 15 Apr 2024 09:51:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] wifi: ath12k: report station mode stats
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240414131008.71519-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240414131008.71519-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jc8a31qOirMZD3AxzQjvWwSwZsQiHiTl
X-Proofpoint-GUID: jc8a31qOirMZD3AxzQjvWwSwZsQiHiTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_14,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=980 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404150110

On 4/14/2024 6:10 AM, Lingbo Kong wrote:
> Currently, the transmit rate, the receive rate and signal strength of
> “iw dev xxx station dump” always show an invalid value.
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

My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2024

However note that "wifi: ath12k: support suspend/resume" is modifying the same
file, so if you rebase on that you'll pick up the copyright change

>  drivers/net/wireless/ath/ath12k/dp_tx.c   | 147 +++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/hal_tx.h  |   9 +-
>  drivers/net/wireless/ath/ath12k/mac.c     | 180 +++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h     |   3 +
>  drivers/net/wireless/ath/ath12k/rx_desc.h |   2 +
>  drivers/net/wireless/ath/ath12k/wmi.c     | 130 ++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h     |  48 ++++++
>  10 files changed, 538 insertions(+), 9 deletions(-)


