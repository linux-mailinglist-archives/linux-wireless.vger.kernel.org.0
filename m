Return-Path: <linux-wireless+bounces-6326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE5D8A5290
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822711F222E8
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 14:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEEE73186;
	Mon, 15 Apr 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="myhaeWiN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763186FE0D
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189757; cv=none; b=seugktCbwBPbrCNZG0iEEFSWrPwp0R4dA4jxWb+MWomXAOA7dk7LodziIVHsq9iqfuHUW8iEBp7HIceTA0tP5o1DTzb6tEi+LuJG0xEuDUFYtKpiiK3VjaBrBNsj61Oyy5tyxCnJhk1h/yT9y5YIeLfuwM7SLwKKqQPUHhIfX18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189757; c=relaxed/simple;
	bh=yCi/yxlNFxGQx7n1xlCdQpzkBB/2nQ84sEoO/vvmHE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TcQH6GbEFbwyWuoSeda5tjOqet054eEWOFc4rNq0YlZTFEwDTahm3f1D4bZCJ7GyavRmcSuG7TIYwrXGT0rySEiHktZc/XPo7bgB7WkbBOQKcuukxy7OZz1Gxv9SYiTtM0pEJ85xZ+6Iyo6+HtkbrXp9SSmMGoxGm/FkgrscgsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=myhaeWiN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F4BL6v012361;
	Mon, 15 Apr 2024 14:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Gmu4xyr8BLIwTy1WpndOXjG2FAoStSBZKqwdQIj6Ih8=; b=my
	haeWiN3wYI+P/UD7aRTluGlWSilbJgn/0RG4EHk5bjUQLD/EVEOygJc2lfsLX5pA
	yshpW9jYlJ3l9RW7MbdEhZwSiQk7B4cgaLCcwhA3JTy5POqnlsof+KZRiEmJRYOK
	sb6FOeEHo1g0dmTmtinoT1Xa5OlZEW7KO8UpBD5DXlrF2Bwe5oQjArrehZSru1u8
	w3GGZ6yLFsQ/btTljM8RQmJIi2jnXENS517yNe7guLKRqhHmoVCD1K2dtQnAvgch
	/9r6whq+dqzMP15Mb8YgZA1fUSzbhn7OlMnlDOa5/k1Ta2GNHzvL9o/nn+UJPgNd
	rtfKEQz9MBun1qygIA/Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgw01s9q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:02:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FE2Nj7002464
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 14:02:23 GMT
Received: from [10.110.8.16] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 07:02:23 -0700
Message-ID: <2e98fd7b-03a6-4821-aaeb-79819dc941db@quicinc.com>
Date: Mon, 15 Apr 2024 22:02:20 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] wifi: ath12k: report station mode stats
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240414131008.71519-1-quic_lingbok@quicinc.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <20240414131008.71519-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JZu_2XfYcyzHgZruXdzCq6e10ekNjftd
X-Proofpoint-GUID: JZu_2XfYcyzHgZruXdzCq6e10ekNjftd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_11,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=986 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404150091



On 2024/4/14 21:10, Lingbo Kong wrote:
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
>          inactive time:  600 ms
>          rx bytes:       4642228
>          rx packets:     23796
>          tx bytes:       933967
>          tx packets:     8761
>          tx retries:     66
>          tx failed:      0
>          beacon loss:    0
>          beacon rx:      8925
>          rx drop misc:   191
>          signal:         -20 dBm
>          beacon signal avg:      -18 dBm
>          tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>          tx duration:    0 us
>          rx bitrate:     1801.4 MBit/s 80MHz EHT-MCS 11 EHT-NSS 3 EHT-GI 0
>          rx duration:    0 us
> 
> v3:
> 1.change wmi_vdev_stats_event to wmi_vdev_stats_params
> 
> v2:
> 1.change copyright
> 2.change name according Naming conventions for structures
> 
> Lingbo Kong (3):
>    wifi: ath12k: report station mode transmit rate
>    wifi: ath12k: report station mode receive rate for IEEE 802.11be
>    wifi: ath12k: report station mode signal strength
> 
>   drivers/net/wireless/ath/ath12k/core.h    |   5 +
>   drivers/net/wireless/ath/ath12k/dp_rx.c   |  20 ++-
>   drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
>   drivers/net/wireless/ath/ath12k/dp_tx.c   | 147 +++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/hal_tx.h  |   9 +-
>   drivers/net/wireless/ath/ath12k/mac.c     | 180 +++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/mac.h     |   3 +
>   drivers/net/wireless/ath/ath12k/rx_desc.h |   2 +
>   drivers/net/wireless/ath/ath12k/wmi.c     | 130 ++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.h     |  48 ++++++
>   10 files changed, 538 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9

Please ignore this series. Need to change some commit message.
I will modify in v4.

