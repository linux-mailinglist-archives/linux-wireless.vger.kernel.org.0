Return-Path: <linux-wireless+bounces-1864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE66E82C8E0
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 02:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C954B226B8
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 01:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC215EA6;
	Sat, 13 Jan 2024 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ShQeC31N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDE14001
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40D1HXIe006492;
	Sat, 13 Jan 2024 01:44:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DiBXxLL2LDZpyhA/lxbmVShZAh0UlFbhP+9z5tZBDiI=; b=Sh
	QeC31Nv4prEQZjzDq5H/sFqICv0Ql3mHYYyZSqEBrPlzJN7V941T2Dqj50a64K3F
	J9/vKogWecZyS+7/Vr7BLEgWbFGIBMfEkIHzoy2elrtRsIVOoZPlaMt9jpwju70K
	icLa5cWZ8Ito4bzEgJLu2YF0+/7cKdkIT6D7WIxJZnerwOpuD8F92q/UGyom/0TP
	vvjHaxXOfI+sD8GzTVm3ybrhqbTKw5XOu5kjQd/YvkVuSDSgmXXx2+iVgzPG93Vd
	1/S8zo3NwQUkVtC/sMcwvVXN9EoDqJ3PfxWKPEoBIyjkdra3ZDqZebN+8uIrg29q
	OElnFPwnxmQ89FKNdiiw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkcb70gpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 01:44:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40D1ijcd021552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 01:44:45 GMT
Received: from [10.50.59.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 17:44:43 -0800
Message-ID: <3771cd9b-f526-7704-75af-76ea8f73a7cc@quicinc.com>
Date: Sat, 13 Jan 2024 07:14:39 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/10] wifi: ath12k: implement remain on channel for
 P2P mode
Content-Language: en-US
To: Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20240112092824.7664-1-quic_kangyang@quicinc.com>
 <20240112092824.7664-5-quic_kangyang@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20240112092824.7664-5-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p_oWiUBcoMOH0qfCsmf6wiYJdY6j_GlM
X-Proofpoint-ORIG-GUID: p_oWiUBcoMOH0qfCsmf6wiYJdY6j_GlM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401130011


On 1/12/2024 2:58 PM, Kang Yang wrote:
> Implement remain on channel for p2p mode in ath12k_ops:
>          ath12k_mac_op_remain_on_channel
>          ath12k_mac_op_cancel_remain_on_channel
>
> P2P device can trigger ROC scan. Then keep listening or sending management
> frames on particular channels.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>
> v2:
>      1. add Tested-on tag of QCN9274.
>      2. update copyright.
>
> --
>   drivers/net/wireless/ath/ath12k/core.c |   3 +-
>   drivers/net/wireless/ath/ath12k/mac.c  | 113 +++++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wmi.c  |   4 +
>   3 files changed, 119 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index d73e2d33a41e..d030534a3ef0 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>   /*
>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <linux/module.h>
> @@ -942,6 +942,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
>   		ath12k_mac_drain_tx(ar);
>   		complete(&ar->scan.started);
>   		complete(&ar->scan.completed);
> +		complete(&ar->scan.on_channel);
>   		complete(&ar->peer_assoc_done);
>   		complete(&ar->peer_delete_done);
>   		complete(&ar->install_key_done);
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index a4a00a6606b4..92ba88d5e4e9 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -7193,6 +7193,116 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>   	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
>   }
>   
> +static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,
> +						  struct ieee80211_vif *vif)
> +{
> +	struct ath12k *ar = hw->priv;


Accessing the radio (ar) from hw->priv is modified in the patchset 
"[PATCH v2 2/2] wifi: ath12k: Introduce the container for mac80211 hw".

This change has conflict.

@jeff,

Any comments ?

> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	spin_lock_bh(&ar->data_lock);
> +	ar->scan.roc_notify = false;
> +	spin_unlock_bh(&ar->data_lock);
> +
> +	ath12k_scan_abort(ar);
> +
> +	mutex_unlock(&ar->conf_mutex);
> +
> +	cancel_delayed_work_sync(&ar->scan.timeout);
> +
> +	return 0;
> +}
> +
> +static int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
> +					   struct ieee80211_vif *vif,
> +					   struct ieee80211_channel *chan,
> +					   int duration,
> +					   enum ieee80211_roc_type type)
> +{
> +	struct ath12k *ar = hw->priv;


Accessing the radio (ar) from hw->priv is modified in the patchset 
"[PATCH v2 2/2] wifi: ath12k: Introduce the container for mac80211 hw".

This change has conflict.

@jeff,

Any comments ?


> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +	struct ath12k_wmi_scan_req_arg arg;
> +	int ret;
> +	u32 scan_time_msec;
> +
> +	mutex_lock(&ar->conf_mutex);
> +	spin_lock_bh(&ar->data_lock);
> +	switch (ar->scan.state) {
> +	case ATH12K_SCAN_IDLE:
> +		reinit_completion(&ar->scan.started);
> +		reinit_completion(&ar->scan.completed);
> +		reinit_completion(&ar->scan.on_channel);
> +		ar->scan.state = ATH12K_SCAN_STARTING;
> +		ar->scan.is_roc = true;
> +		ar->scan.vdev_id = arvif->vdev_id;
> +		ar->scan.roc_freq = chan->center_freq;
> +		ar->scan.roc_notify = true;
> +		ret = 0;
> +		break;
> +	case ATH12K_SCAN_STARTING:
> +	case ATH12K_SCAN_RUNNING:
> +	case ATH12K_SCAN_ABORTING:
> +		ret = -EBUSY;
> +		break;
> +	}
> +	spin_unlock_bh(&ar->data_lock);
> +
> +	if (ret)
> +		goto exit;
> +
> +	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;
> +
> +	memset(&arg, 0, sizeof(arg));
> +	ath12k_wmi_start_scan_init(ar, &arg);
> +	arg.num_chan = 1;
> +	arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
> +				GFP_KERNEL);
> +	if (!arg.chan_list) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	arg.vdev_id = arvif->vdev_id;
> +	arg.scan_id = ATH12K_SCAN_ID;
> +	arg.chan_list[0] = chan->center_freq;
> +	arg.dwell_time_active = scan_time_msec;
> +	arg.dwell_time_passive = scan_time_msec;
> +	arg.max_scan_time = scan_time_msec;
> +	arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
> +	arg.burst_duration = duration;
> +
> +	ret = ath12k_start_scan(ar, &arg);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to start roc scan: %d\n", ret);
> +
> +		spin_lock_bh(&ar->data_lock);
> +		ar->scan.state = ATH12K_SCAN_IDLE;
> +		spin_unlock_bh(&ar->data_lock);
> +		goto free_chan_list;
> +	}
> +
> +	ret = wait_for_completion_timeout(&ar->scan.on_channel, 3 * HZ);
> +	if (ret == 0) {
> +		ath12k_warn(ar->ab, "failed to switch to channel for roc scan\n");
> +		ret = ath12k_scan_stop(ar);
> +		if (ret)
> +			ath12k_warn(ar->ab, "failed to stop scan: %d\n", ret);
> +		ret = -ETIMEDOUT;
> +		goto free_chan_list;
> +	}
> +
> +	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
> +				     msecs_to_jiffies(duration));


ath12k_ar_to_hw(ar) is introduced to avoid direct access of hw from 
radio (ie, ar->hw).

This new helper function introduced by the patchset "[PATCH v2 1/2] 
wifi: ath12k: Refactor the mac80211 hw access from link/radio"


@jeff

Any comments ?

> +
> +	ret = 0;
> +
> +free_chan_list:
> +	kfree(arg.chan_list);
> +exit:
> +	mutex_unlock(&ar->conf_mutex);
> +	return ret;
> +}
> +
>   static const struct ieee80211_ops ath12k_ops = {
>   	.tx				= ath12k_mac_op_tx,
>   	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
> @@ -7227,6 +7337,8 @@ static const struct ieee80211_ops ath12k_ops = {
>   	.get_survey			= ath12k_mac_op_get_survey,
>   	.flush				= ath12k_mac_op_flush,
>   	.sta_statistics			= ath12k_mac_op_sta_statistics,
> +	.remain_on_channel              = ath12k_mac_op_remain_on_channel,
> +	.cancel_remain_on_channel       = ath12k_mac_op_cancel_remain_on_channel,


Both these new mac_op callback need to rework based on the patchset 
"[PATCH v2 0/2] wifi: ath12k: Introduce hw abstraction"


>   };
>   
>   static void ath12k_mac_update_ch_list(struct ath12k *ar,
> @@ -7777,6 +7889,7 @@ int ath12k_mac_allocate(struct ath12k_base *ab)
>   		init_completion(&ar->bss_survey_done);
>   		init_completion(&ar->scan.started);
>   		init_completion(&ar->scan.completed);
> +		init_completion(&ar->scan.on_channel);
>   
>   		INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
>   		INIT_WORK(&ar->regd_update_work, ath12k_regd_update_work);
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 861565eaab3d..e10289de84c1 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -5050,6 +5050,8 @@ static void ath12k_wmi_event_scan_started(struct ath12k *ar)
>   		break;
>   	case ATH12K_SCAN_STARTING:
>   		ar->scan.state = ATH12K_SCAN_RUNNING;
> +		if (ar->scan.is_roc)
> +			ieee80211_ready_on_channel(ar->hw);
>   		complete(&ar->scan.started);
>   		break;
>   	}
> @@ -5132,6 +5134,8 @@ static void ath12k_wmi_event_scan_foreign_chan(struct ath12k *ar, u32 freq)
>   	case ATH12K_SCAN_RUNNING:
>   	case ATH12K_SCAN_ABORTING:
>   		ar->scan_channel = ieee80211_get_channel(ar->hw->wiphy, freq);
> +		if (ar->scan.is_roc && ar->scan.roc_freq == freq)
> +			complete(&ar->scan.on_channel);
>   		break;
>   	}
>   }


Thanks,

Karthikeyan


