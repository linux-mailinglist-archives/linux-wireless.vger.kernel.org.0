Return-Path: <linux-wireless+bounces-8897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1E905BEE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 21:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34979286E12
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4DB82C7D;
	Wed, 12 Jun 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T72jWBUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0D374D3
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718220401; cv=none; b=qW2JsekKsX+TU1BIzjrRfs+Z4PvzcISPlGYuCI/4HQP5Qmn+OHlMPQMlW/SLR1jUAZVyY7dhIelUIw9eEwyywqV0mAQC5Tzyy9PRptY0U9z7zjqzB5NwSID2ic1mBz8f8Ck9YEyhWrgjxlS0BLhFLA3khpEQ5y6DO8kiFMmAfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718220401; c=relaxed/simple;
	bh=mQ5HCu/yYf295hF0HmU6VbI/56nsYqxUvlSie5zh3o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pEWM0wcKDJI4U266efyx6XKvSl5XIaWFS6DAwCcEC/uOngoEVdIReZkV53doLia5JyRH6VTVNRp7Z1v7splaOW0U5U4xL2BXtQ/XW3VnB6PGLoLMq4GiiM4iZV4BJXtPsYG2OQjp8pbIlN0HD0GflwQ6bIymXFIhHVAQyC183is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T72jWBUZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CDqqZN019231;
	Wed, 12 Jun 2024 19:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g3ftkoyR5O0kSK38yll0SLWdrY4adiKP1UY4i0+tPjU=; b=T72jWBUZ8jcnNpnF
	xD3T16jNLnjMvgKWwsL96XkPr7R/bRgqm0x02gwbXbT7ACjPTQV+MJlJBvIB/kqu
	/w2iMrpET7vzwDZZzb1aqJqDQsIwUOxa99f0BAHbM0CYusH1daziz6SvO+Os/wpz
	9ThjbNgM2XRtBheRR0lbTWbvPTioVxlQtSfwgY/YkLrKNOLB16N1FthzBjDAWKtx
	OrQOorivIwu5AnoRH7hhDhHcMAdxIeqYL/z901ypzFN6JFuuL4fMzojc0VE3zECf
	O7DOaMLdMdciR2FWd/vuYPg2thZRn0ms+f93+UYdNuy8OkSLYzbaQcVEdV8IakKz
	lGokrg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqcxth1xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 19:26:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CJQZjB000751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 19:26:35 GMT
Received: from [10.48.243.20] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 12:26:35 -0700
Message-ID: <5cf39d31-c470-4c28-bb82-a489a44488ef@quicinc.com>
Date: Wed, 12 Jun 2024 12:26:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix ack signal strength calculation
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240611022550.59078-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240611022550.59078-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 80f8f7cz3vu-P3IBDnYl0jvH1L7-Fpz2
X-Proofpoint-GUID: 80f8f7cz3vu-P3IBDnYl0jvH1L7-Fpz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_10,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120137

On 6/10/2024 7:25 PM, Lingbo Kong wrote:
> Currently, the calculation of ack signal strength is incorrect.
> 
> This is because before calculating the ack signal strength, ath11k need
> to determine whether the hardware and firmware support db2dbm. If the
> hardware and firmware support db2dbm, do not need to add noise floor,
> otherwise, need to add noise floor.
> 
> Besides, the value of ack_rssi passed by firmware to ath11k should be a
> signed number, so change its type to s8.
> 
> After that, "iw wlan0 station dump" show the correct ack signal strength.
> 
> Such as:
> root@CDCCSTEX0799733-LIN:~# iw wlp88s0 station dump
> Station 00:03:7f:12:df:df (on wlp88s0)
>         inactive time:  75 ms
>         rx bytes:       11599
>         rx packets:     99
>         tx bytes:       9029
>         tx packets:     81
>         tx retries:     4
>         tx failed:      0
>         rx drop misc:   2
>         signal:         -16 dBm
>         signal avg:     -24 dBm
>         tx bitrate:     1560.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 4
>         tx duration:    9230 us
>         rx bitrate:     1560.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 4
>         rx duration:    7201 us
>         last ack signal:-23 dBm
>         avg ack signal: -22 dBm
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


