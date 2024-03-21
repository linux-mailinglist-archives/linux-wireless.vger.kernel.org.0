Return-Path: <linux-wireless+bounces-5115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CC5886155
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 20:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795E91C21588
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49212BF16;
	Thu, 21 Mar 2024 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nKI+BBH9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F9258AC0
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050874; cv=none; b=P0ocrgGweN7e4lFWM1UMtUR0g5d3Ipmaxy2EnCB4NgtTDrq5lma7+haqAipdaCWaa3tHBf8MqZsdHC9keLc1/TlLD4hl6oBeQkwo2NDHW78DnzpR9CAdF7XZRsXJyXV1ltjzPqeWX8EWsfGFMI0JsJ3WWKslRRk8I38viEP+Wog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050874; c=relaxed/simple;
	bh=IF+2zaoUVVsHoQ8mCxnwlt1CX7PqMVISq+B4UiyLSP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bBer+SbF98K1QkxGa30JicqrOjnazFjeCREW4H6vHMHV2ch9WDwzmWIQeIRTNtxVf6YY++EJd+H5BBB/Hvkjcar23ysvgUbiHWi0fw89/hweE2mYuwCW89wiEQDYspQ0W7P+4IvbBEVMBHuWVW7dv+CeTVpWZaXr6/vQeZJFdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nKI+BBH9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LCtnVJ028785;
	Thu, 21 Mar 2024 19:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vx6tkd2vEJA5iK9okA7Yg2T0BVYn2Gbbwe3OzsY7z4g=; b=nK
	I+BBH9mkawQrE3cM9IGn+LVU1RXGwXGC4bvrrCQrCAJYkUeBmw1QqW53lexF2VDn
	OmjBpOYlGdc5wjUfAFfN4PZhRUGKRUWy7ZSWVZyMkSCjFOhUrYHZ9i/xsd4chYA3
	Sxra0Iylg2Dz+hhojzQagOw1PqajDps8CPk/CwMPz/2lZ5+/CGLa/+muo24gpxmA
	+hWkA7RBw3cJ5Cht1ptLzVyzbVwG5ffUD1eDgiVoB5G5SU1RJRSWuFZrbWNXNfs5
	J9kxPx+0uEm9BJ9AqMZ4Oj9+H1iPTku6R3/Y+iwc+8fpymxBjoKZVeYxXXrQkUCj
	JTt3D1vD0hohpZGFZLJA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0nb314m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 19:54:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LJsS2s007632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 19:54:28 GMT
Received: from [10.110.74.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 12:54:27 -0700
Message-ID: <85e7f591-ed52-4554-bd92-09086eaebcdb@quicinc.com>
Date: Thu, 21 Mar 2024 12:54:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] wifi: ath12k: scan statemachine changes for
 single wiphy
Content-Language: en-US
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <20240320190943.3850106-6-quic_ramess@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240320190943.3850106-6-quic_ramess@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uvgS-bHIk2o0dkDEfJmiiTgypvVgoq0_
X-Proofpoint-ORIG-GUID: uvgS-bHIk2o0dkDEfJmiiTgypvVgoq0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210148

On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
> From: Sriram R <quic_srirrama@quicinc.com>
> 
> When multiple radios are advertised as a single wiphy which
> supports various bands, a default scan request to mac80211
> from cfg80211 will split the driver request based on band,
> so each request will have channels belonging to the same band.
> With this supported by default, the ath12k driver on receiving
> this request checks for one of the channels in the request and
> selects the corresponding radio(ar) on which the scan is going
> to be performed and creates a vdev on that radio.
> 
> Note that on scan completion this vdev is not deleted. If a new
> scan request is seen on that same vif for a different band the
> vdev will be deleted and created on the new radio supporting the
> request. The vdev delete logic is refactored to have this done
> dynamically.
> 
> The reason for not deleting the vdev on scan stop is to avoid
> repeated delete-create sequence if the scan is on the same band.
> Also, during channel assign, new vdev creation can be optimized
> as well.
> 
> Also if the scan is requested when the vdev is in started state,
> no switching to new radio is allowed and scan on channels only
> within same radio is allowed.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
> Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 211 +++++++++++++++++++++-----
>  1 file changed, 176 insertions(+), 35 deletions(-)
...
> -static void ath12k_mac_op_remove_interface(struct ieee80211_hw *hw,
> -					   struct ieee80211_vif *vif)
> +static int ath12k_mac_vdev_delete(struct ath12k *ar, struct ieee80211_vif *vif)
>  {
> -	struct ath12k *ar;
>  	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> -	struct ath12k_base *ab;
> +	struct ath12k_base *ab = ar->ab;
>  	unsigned long time_left;
>  	int ret;
>  
> -	if (!arvif->is_created)
> -		return;
> -
> -	ar = arvif->ar;
> -	ab = ar->ab;
> -
> -	mutex_lock(&ar->conf_mutex);
> -
> -	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
> -		   arvif->vdev_id);
> -
> -	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
> -		ret = ath12k_peer_delete(ar, arvif->vdev_id, vif->addr);
> -		if (ret)
> -			ath12k_warn(ab, "failed to submit AP self-peer removal on vdev %d: %d\n",
> -				    arvif->vdev_id, ret);
> -	}
> -
> +	lockdep_assert_held(&ar->conf_mutex);
>  	reinit_completion(&ar->vdev_delete_done);
>  
>  	ret = ath12k_wmi_vdev_delete(ar, arvif->vdev_id);
>  	if (ret) {
> -		ath12k_warn(ab, "failed to delete WMI vdev %d: %d\n",
> +		ath12k_warn(ab, "failed to delete WMI scan vdev %d: %d\n",

this change seems strange. isn't ath12k_mac_vdev_delete() called from both the
scan logic and from the normal ath12k_mac_op_remove_interface(), so it might
not be a scan vdev that is being deleted?

>  			    arvif->vdev_id, ret);
>  		goto err_vdev_del;
>  	}


