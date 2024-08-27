Return-Path: <linux-wireless+bounces-12101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D2D961929
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 23:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072D1284FCB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 21:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A926515539A;
	Tue, 27 Aug 2024 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e6X+6BJE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8391F943
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793844; cv=none; b=fG3HXx76JgsW3LJAZ3a97qQo//TBpr8q8FtPjkOLdiKJPFiOebT69k+SQaziFBsM47tmSA0h3fiRQQ6KdobYDNYtzv0aWSbH+Yx/8+uEb8XaBaF9ixS3cRb4MqngAou5SlOudvtRbttmyBZZOwjbDzoYJZu36l1fGhFPBuTbhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793844; c=relaxed/simple;
	bh=dAQK8x3YC5ASfZjA2Rdwi+8nmVRJ91lzA/dd7t34y/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oPetIt136s46RnbmdEnRh5AyZb8Puuai1MhwavUu77GlyTfrbfAcpfdOxT3MGfohYy1Em3+h8jH2LJ6NtnqdMQMBjffJnevfu+1okG2S1a82L71xNR68edLa0Ps4XyFk+p7RnG7xGDIyr2L3q+UB3OfYX7NdQejInk0P/KiJjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e6X+6BJE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RJl4Qx004601;
	Tue, 27 Aug 2024 21:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6ATruHzgf+ZRTibHdRDA0EM9Ge4yqYIFW8Zi7HPoOt0=; b=e6X+6BJE//UK4f2B
	niTRUnv4eeXg4p7oxiw4CymJqkzopzofqD7GQhr46WOQkG6KlydpxRGOb7P9/Wg3
	taTFWB9DgdKfEBO4FiHTWMwKbDuVR1WgnP1kE+IOLJ+IHTRdtNaAKPLCaxpLYwQp
	gPq4k+Y/9ZTl8FMSWeKBwkNo/VvLBG3mZJIrVDpB3fibIk8eEHan4BrKjHyhD6F4
	Pko8XhU1LzFJV7TJibD+e6pK944L1nP2fJAvYuTPfVYTxVso7kjYC89zKvTid404
	kP9YTbGNucdzEQPeU7L61pyEWVutM8GpFbeyi2ilRiTMWId27hhaxnqnvy+Q+W7B
	smnUYw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4199yt27ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 21:24:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47RLO0RH018660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 21:24:00 GMT
Received: from [10.111.180.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 14:23:59 -0700
Message-ID: <e6d674b3-fcf8-4a0c-b7c7-24865870cc0d@quicinc.com>
Date: Tue, 27 Aug 2024 14:23:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] wifi: ath11k: fix leaking station RX/TX stats in
 reset scenario
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240826014942.87783-1-quic_bqiang@quicinc.com>
 <20240826014942.87783-4-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240826014942.87783-4-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TzaidvqHj0LjKl5DrWIApPjVzdW-yeOY
X-Proofpoint-ORIG-GUID: TzaidvqHj0LjKl5DrWIApPjVzdW-yeOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=985
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270157

On 8/25/2024 6:49 PM, Baochen Qiang wrote:
> Currently ath12k_sta::rx_stats/tx_stats would only get freed when the station
> transit from NONE to NOTEXIST state within ath11k_mac_op_sta_state(). However
> in reset scenario, there is no chance for it to go through such transition.
> Further, after reset, when a new connection to AP starts, ath12k_sta is zerod
> in NOTEXIST to NONE transition, making rx_stats/tx_stats leaked:
> 
> Kmemleak reports:
> unreferenced object 0xffff9a3cd0a23400 (size 1024):
>   backtrace (crc 21ee4c52):
>     kmalloc_trace_noprof+0x2ba/0x360
>     ath11k_mac_op_sta_state+0x1b6/0xca0 [ath11k]
>     drv_sta_state+0x11e/0x9c0 [mac80211]
>     sta_info_insert_rcu+0x469/0x880 [mac80211]
>     sta_info_insert+0x10/0x80 [mac80211]
>     ieee80211_prep_connection+0x295/0x950 [mac80211]
>     ieee80211_mgd_auth+0x230/0x5a0 [mac80211]
>     cfg80211_mlme_auth+0xeb/0x2a0 [cfg80211]
> 
> Add a new function which frees them, and call it during reset to fix this issue.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>



