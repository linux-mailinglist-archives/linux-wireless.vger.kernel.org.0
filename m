Return-Path: <linux-wireless+bounces-6201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FC38A1F94
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 21:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D76AB21E12
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5F15E81;
	Thu, 11 Apr 2024 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bv5qq/r1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232610799
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 19:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864523; cv=none; b=AStmoWruRAwZlefnwuf9IXAO9SrhSHzHJDpkEmbBL3ZMYhkB1avf3LrjSa1O+/0TV0hJN7cV+B9TnGmoEwCH4LKVRVviR4hGs3IjzU4NFcXEDCrLfzW/PVHQy4BQi+5ngqgfpKTy2BOOUCDI44vvmHDblGopF+Qz7iDCE1/fcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864523; c=relaxed/simple;
	bh=ywHE38Z7G6KHVf1sYosMygJvH1W2143pya/ZHKPX5gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g2T+YlryIdtzipudSPPLbwyrtUzS+bSz2dAVLfdDRQK5e/UiepQwIu1036PWJLC+pDflVMRy+6QGOEVdv/Q2LcBfgTjj9USLHAODpZ1grnCfmGI4vr9XxbiJjdi5Xdk05wpKeGGagI2fIqQlyxxJJ8zrA0YgnLsL5h/c9EzuzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bv5qq/r1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BJcD39012420;
	Thu, 11 Apr 2024 19:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bEGXvIgBrqclXOoSKQ712D+KL6n0S2D53O1A/6qY7d8=; b=Bv
	5qq/r1z3rbIU4agK9Vj4C4VJn8GKA6PF2vUwN7c9n/3mgP4wm7oHxpX03JzzXlGW
	3WNqQbJkPXlncZNDfuvz4EBqADSUTJ9i1xzumRBnFtEEkITf99rHOFopa/kNS95o
	SeXTtLqlkdQgSAmw4UrA0cMIbuRqgg74t8MybDUH+IDr4k+mRtmL3i0rzvVBTJL9
	6zzoCdQpdJXHPOj6Hjy8hAMe2prgjhwkcRj9V2F0QWaMrQO0X3C2mnokI9UPnPkV
	qIewgRUcMl9mmAMWAKa2wKzqsLLALwIvF2iAos2nI4aBAoMBg3v/O0vhuJdFGehC
	N/Bkko2HuRgzDjrKMaqg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xep6fg06k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 19:41:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BJfovX008411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 19:41:50 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Apr
 2024 12:41:49 -0700
Message-ID: <e8618364-e547-41e1-b18f-4cddeafd3371@quicinc.com>
Date: Thu, 11 Apr 2024 12:41:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: enable WIPHY_FLAG_DISABLE_WEXT
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240411165645.4071238-1-kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240411165645.4071238-1-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QRqDyjhaD8zlQDfnDVj_H6IN-g3KkDFX
X-Proofpoint-ORIG-GUID: QRqDyjhaD8zlQDfnDVj_H6IN-g3KkDFX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404110144

On 4/11/2024 9:56 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> ath12k will support Multi-Link Operation (MLO) in the future but not yet. A
> major change with MLO is that cfg80211 will disable Wireless Extension (WEXT)
> user space interface. To avoid having inconsistent user experience, first
> supporting WEXT and later not, disable WEXT already now.
> 
> Now ath12k claims that WEXT is not supported:
> 
> $ iwconfig wlan0
> wlan0     no wireless extensions.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index f15dcd75157d..e989628d7d72 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -8556,6 +8556,12 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
>  	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
>  				   NL80211_FEATURE_AP_SCAN;
>  
> +	/* MLO is not yet supported so disable Wireless Extensions for now
> +	 * to make sure ath12k users don't use it. This flag can be removed
> +	 * once WIPHY_FLAG_SUPPORTS_MLO is enabled.
> +	 */
> +	wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
> +
>  	hw->queues = ATH12K_HW_MAX_QUEUES;
>  	wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
>  	hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
> 
> base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9

Currently on my version of Ubuntu when I switch to Hotspot mode I'm seeing:
[   55.189623] warning: `iwconfig' uses wireless extensions which will stop
working for Wi-Fi 7 hardware; use nl80211

So are userspace folks aware of the need to move away from iwconfig?
Is there a Ubuntu / Network Manager fix fir this?

/jeff

/jeff


