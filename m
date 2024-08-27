Return-Path: <linux-wireless+bounces-12100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF456961928
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 23:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D137284FCB
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 21:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5475315539A;
	Tue, 27 Aug 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mAR7NR9F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC041F943
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 21:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793839; cv=none; b=rdClUue0LvNGygQPF/tJd0YjIFIfffrZCN98ov3enQMKuv6ZkbK6khuhtyw7S0RyxGH6eWfu5CzLW96w5bFy1mnaFwEfZJazpoXIWAsuuXE6VZuxZMtU8nA5UYhku8pSHbcCc7fOqMkMH+Okw/DpJLLirfhJ6My1JjEHMthIWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793839; c=relaxed/simple;
	bh=zgj3tapFbekn6F1Mc80+DvU7j72d0GJtvcvHsOWJaEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jdu/M9qjJzH908dmr9AlBLrzmcV4q8uAnvC0cgNakEjfRg1zvPzge30cAXrXjAqE4wXNNzVoZyvo1Y1XLAdBmWamy+0CaE8vTW+pZJgIXCnpVw9exRJVw6mBA9X1lXPE5B+rf/7XKuIzRaVtgauy1lNcEErcHD4pf3Y5xx0wS60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mAR7NR9F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RJlDgK018406;
	Tue, 27 Aug 2024 21:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KZn1v7tP6Q3s6XALZaE+JZFvbyNfUHImo0cHPTCZ2GI=; b=mAR7NR9Fqx/VKTx2
	ktBW47RW5s8wAxuD1IJ0ystTd9lsONBLOCzS9mamNwsnw9v4eE6FiZ8KaS4BkKVr
	drfsffcwmhIHklM0Z/KtZWwZTJ8rhgrksoiRBrxgZttjnCDyguvoRkeNGBdvLQ9n
	AcEf/RPVsU7+HJe3X3x8VAFR4U4EiHDt0PWQVIdkfrW8lFGSnJ1O5VAOMiymsGvl
	gKmKMs9YhwTzIEH57Z4jAGIGcXVuxdwkkuxmegtut5cVVbeWkAx5hl/qJ/2MV7IL
	uXro8u6AF1nUtQQNuXkBIu3Prc9IJeH6/KHacNVI7Ik4nR57XOykuC0zx2HEaOo5
	yg15Ag==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179810akr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 21:23:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47RLNsBJ018252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 21:23:54 GMT
Received: from [10.111.180.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 14:23:54 -0700
Message-ID: <47a3f17b-cbb8-4f57-bf81-b1b11533cfde@quicinc.com>
Date: Tue, 27 Aug 2024 14:23:53 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] wifi: ath11k: fix leaking peer->tfm_mmic in reset
 scenario
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240826014942.87783-1-quic_bqiang@quicinc.com>
 <20240826014942.87783-3-quic_bqiang@quicinc.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240826014942.87783-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wYohlgyISTpAay7dTBhHEGo0dYft8jVH
X-Proofpoint-ORIG-GUID: wYohlgyISTpAay7dTBhHEGo0dYft8jVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270157

On 8/25/2024 6:49 PM, Baochen Qiang wrote:
> Currently peer->tfm_mmic would only get freed, by ath11k_dp_peer_cleanup(),
> when the corresponding station transit from NONE to NOTEXIST state within
> ath11k_mac_op_sta_state(). However in reset scenario, there is no chance for
> it to go through such transition. Further, during reset, we call
> ath11k_mac_peer_cleanup_all() where peer is freed, thus leak peer->tfm_mmic:
> 
> Kmemleak reports:
> unreferenced object 0xffff9a3ca7828d00 (size 64):
>   backtrace (crc 4a016586):
>     __kmalloc_node_noprof+0x38f/0x480
>     crypto_alloc_tfmmem.isra.0+0x2e/0x60
>     crypto_create_tfm_node+0x29/0xe0
>     crypto_alloc_tfm_node+0x5d/0x130
>     ath11k_peer_rx_frag_setup+0x2c/0x150 [ath11k]
>     ath11k_dp_peer_setup+0x82/0x160 [ath11k]
>     ath11k_mac_op_sta_state+0x26f/0xca0 [ath11k]
>     drv_sta_state+0x11e/0x9c0 [mac80211]
>     sta_info_insert_rcu+0x469/0x880 [mac80211]
>     sta_info_insert+0x10/0x80 [mac80211]
>     ieee80211_prep_connection+0x295/0x950 [mac80211]
>     ieee80211_mgd_auth+0x230/0x5a0 [mac80211]
>     cfg80211_mlme_auth+0xeb/0x2a0 [cfg80211]
> 
> In order to fix it we need to call crypto_free_shash() as well in
> ath11k_mac_peer_cleanup_all(). Considering ath11k_peer_rx_tid_cleanup() is
> also called there, we can simply replace it with ath11k_dp_peer_cleanup().
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


