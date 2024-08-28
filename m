Return-Path: <linux-wireless+bounces-12103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACCC961B19
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 02:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB26C1C22F2F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 00:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBE7E9;
	Wed, 28 Aug 2024 00:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="py0s1UBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA005C13C
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 00:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805208; cv=none; b=S4YYxVvtRafs2B88G9wA4W4aJokNU2kDbCPv3+2TDD8SHU5yp1N+QaSwVfCV7APTa8EuX93JlJhf5ibJXDVaxFvltrlnOq+nj4+eIQTaB/m6BB1McJ0a0tGvfkAiNufImCO32iEVN2Gu3UK+pXzHZtaWEIWqhRdfQ6ZjhKSCj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805208; c=relaxed/simple;
	bh=3jA+aBgwuupQ9nrDA6Qaipt/EUfa/STVzGuebPBL+II=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZpqgSMLbsJnFte+R2A6tGYYtcLOLkQeqeYeeVsitEnSov5PF1neHhE2D4d44Ip7rkwb2vOziKEY9NopwltBgtXXPpBBLVhkYsY1xWhgeWIiY46NXXvJerbwM6WDOipA14XZQhKu4CCOdU6lkQHq//uD8y9WOhmsjf1Ona0CqE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=py0s1UBs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RLbSGh020336;
	Wed, 28 Aug 2024 00:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ATOW2cAiXB+zlcZ6JGqBGQWBqhQJLeBPqYeGIGhH/FE=; b=py0s1UBs0a0Xcf22
	P+xS784UFgiqXBaLwiviCpIYysDcXhz8R1aL9zTaNxivA+ZC9bW5flITrs4NzSn2
	VPthwK3NzZ1XKD368T7SnQ151eTwxPu0P4mFM6S5no4bsY2Y8FnAJ1h97WzQNZfb
	YF+igVzo1odjbbhB/Lsh6JqL+v+vG76TUSRgbd0xXQw0W9MHVuAC+TyP/PFCOwF9
	PBI33bU6QFxe2iT3J1afQjXeYqYLpT5ovAhhVNiVidMKl1sZSeGMD2u24fH8566F
	6e97RLYwNs7B+i3OC+0Oi1lvqS4xZxHO6OlU8r+0c3Kcr6/rhAzuMYxFfcTtpa/h
	GoORIg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419putr8jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 00:33:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47S0XKhR026038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 00:33:20 GMT
Received: from [10.50.17.66] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 27 Aug
 2024 17:33:18 -0700
Message-ID: <d64f87fa-aad2-bc76-7de6-3e5056e2e637@quicinc.com>
Date: Wed, 28 Aug 2024 06:03:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] wifi: ath11k: fix leaking peer->tfm_mmic in reset
 scenario
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240826014942.87783-1-quic_bqiang@quicinc.com>
 <20240826014942.87783-3-quic_bqiang@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20240826014942.87783-3-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jbwV-x31QbMA-xKbfJRHg0gG0d1OVcv1
X-Proofpoint-GUID: jbwV-x31QbMA-xKbfJRHg0gG0d1OVcv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_10,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280001



On 8/26/2024 7:19 AM, Baochen Qiang wrote:
> Currently peer->tfm_mmic would only get freed, by ath11k_dp_peer_cleanup(),
> when the corresponding station transit from NONE to NOTEXIST state within
> ath11k_mac_op_sta_state(). However in reset scenario, there is no chance for
> it to go through such transition. Further, during reset, we call
> ath11k_mac_peer_cleanup_all() where peer is freed, thus leak peer->tfm_mmic:
> 
> Kmemleak reports:
> unreferenced object 0xffff9a3ca7828d00 (size 64):
>    backtrace (crc 4a016586):
>      __kmalloc_node_noprof+0x38f/0x480
>      crypto_alloc_tfmmem.isra.0+0x2e/0x60
>      crypto_create_tfm_node+0x29/0xe0
>      crypto_alloc_tfm_node+0x5d/0x130
>      ath11k_peer_rx_frag_setup+0x2c/0x150 [ath11k]
>      ath11k_dp_peer_setup+0x82/0x160 [ath11k]
>      ath11k_mac_op_sta_state+0x26f/0xca0 [ath11k]
>      drv_sta_state+0x11e/0x9c0 [mac80211]
>      sta_info_insert_rcu+0x469/0x880 [mac80211]
>      sta_info_insert+0x10/0x80 [mac80211]
>      ieee80211_prep_connection+0x295/0x950 [mac80211]
>      ieee80211_mgd_auth+0x230/0x5a0 [mac80211]
>      cfg80211_mlme_auth+0xeb/0x2a0 [cfg80211]
> 
> In order to fix it we need to call crypto_free_shash() as well in
> ath11k_mac_peer_cleanup_all(). Considering ath11k_peer_rx_tid_cleanup() is
> also called there, we can simply replace it with ath11k_dp_peer_cleanup().
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/mac.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index f1dff26bc237..f21d37cefb65 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -883,7 +883,7 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
>   	mutex_lock(&ab->tbl_mtx_lock);
>   	spin_lock_bh(&ab->base_lock);
>   	list_for_each_entry_safe(peer, tmp, &ab->peers, list) {
> -		ath11k_peer_rx_tid_cleanup(ar, peer);
> +		ath11k_dp_peer_cleanup(ar, peer->vdev_id, peer->sta->addr);

peer->tfm_mmic is allocated in ath11k_peer_rx_frag_setup() but its not 
cleanup in ath11k_dp_rx_frags_cleanup(), which is not symmetric now. 
Instead its freed in ath11k_dp_peer_cleanup(). can you refactor 
allocation/deallocation symmetric funcs ?

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

