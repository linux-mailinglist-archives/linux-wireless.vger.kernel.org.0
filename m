Return-Path: <linux-wireless+bounces-14204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EEF9A3722
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 09:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0A1F21D00
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 07:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C37187322;
	Fri, 18 Oct 2024 07:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SH3SlSL0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B4184535;
	Fri, 18 Oct 2024 07:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729236497; cv=none; b=uYPGfx2jApMxDNxP3xTe+MWYF91yk+F+EQaSFxq9M20OPPO1s/x30N9j6j0zdQMnjY5Wd9SGHvzQljzTGvkCUXNwfPcRuS9J8SyV7WN1pyR8tn4PoHhEL9rwJX2P3LYPygVM+0lXuoh8N/CyZaRJotQ5BtWMpQly5hKkpjsRbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729236497; c=relaxed/simple;
	bh=LuKCZ5x/YKMG8MOOPMolLpvMYzNowpmmZDeqHAokgqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=erLeIOHfKnhCzvilC4qwZDIb7yUge02le64a4nZv3rgCentguchl/EYadvM2v7RT41XUGwOFGHLHsFoPpx0U5BHYx7glFtfZ5MgX6Iq2JR3YXN/mIPf6flRO1VsVphL7qRpWuwmaG0GEvsEFbp5M9s1L1gPRcfkeN1O/OS8hQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SH3SlSL0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I3nxTT004533;
	Fri, 18 Oct 2024 07:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oNYrLGdVtKkZUrpdXNOYceevxnVz4AS27ppKohsmT+c=; b=SH3SlSL0BcBbT1hU
	UDJN4DDGAqqxOeqECwn9BbRNWOU+AD7CXveEhmO6UG32+J099uMQU+KWs3n++6e7
	ou2se3GAq1nQfx6vuzKSQQe1M0nGAxAvjGaBVoj0rQj3gGA6Z9BlboqbC2WRNvFn
	UEWaoQEm6UZsTe8CxXkGhHGO55Y7WqbQP4YIn+3iwSgDJBml5OeS00rYMbl68/oU
	vFReUfHSZt/MUtLVB5oBvJS8X0Bw4gBwFsIf4kFQnnpTSPd7k666pw9kz3jKEZ93
	mS3zkpOrxtSHdGV6kd/tMqEkPVNurBJnzLqyU7CuceJ+0zSwfa9h8IFmRyx2HDWR
	lIfukw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42athc45wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 07:27:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49I7Rrom014781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 07:27:53 GMT
Received: from [10.216.12.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 00:27:51 -0700
Message-ID: <4aadb1a9-b4a8-595e-b413-99bc3aef480a@quicinc.com>
Date: Fri, 18 Oct 2024 12:57:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] wifi: ath10k: Implement ieee80211 flush_sta callback
Content-Language: en-US
To: Remi Pommarel <repk@triplefau.lt>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Cedric
 Veilleux <veilleux.cedric@gmail.com>
References: <cover.1728741827.git.repk@triplefau.lt>
 <481540132c62b16f6d823b7556c11a0ce68f5c58.1728741827.git.repk@triplefau.lt>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <481540132c62b16f6d823b7556c11a0ce68f5c58.1728741827.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QxUF8ITfdfVC0pCcQ7JVl0rNz8zLtcne
X-Proofpoint-ORIG-GUID: QxUF8ITfdfVC0pCcQ7JVl0rNz8zLtcne
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180045



On 10/12/2024 7:43 PM, Remi Pommarel wrote:
> When a STA reassociates, mac80211's _sta_info_move_state() waits for all
> pending frame to be flushed before removing the key (so that no frame
> get sent unencrypted after key removable [0]). When a driver does not
> implement the flush_sta callback, ieee80211_flush_queues() is called
> instead which effectively stops the whole queue until it is completely
> drained.
> 
> The ath10k driver configure all STAs of one vdev to share the same
> queue. So when flushing one STA this is the whole vdev queue that is
> blocked until completely drained causing Tx to other STA to also stall
> this whole time.
> 
> One easy way to reproduce the issue is to connect two STAs (STA0 and
> STA1) to an ath10k AP. While Generating a bunch of traffic from AP to
> STA0 (e.g. fping -l -p 20 <STA0-IP>) disconnect STA0 from AP without
> clean disassociation (e.g. remove power, reboot -f). Then as soon as
> STA0 is effectively disconnected from AP (either after inactivity
> timeout or forced with iw dev AP station del STA0), its queues get
> flushed using ieee80211_flush_queues(). This causes STA1 to suffer a
> connectivity stall for about 5 seconds (see ATH10K_FLUSH_TIMEOUT_HZ).
> 
> Implement a flush_sta callback in ath10k to wait only for a specific
> STA pending frames to be drained (without stopping the whole HW queue)
> to fix that.
> 
> [0]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")
> 
> Reported-by: Cedric Veilleux <veilleux.cedric@gmail.com>
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>   drivers/net/wireless/ath/ath10k/core.h   |  4 +++
>   drivers/net/wireless/ath/ath10k/htt.h    |  4 +++
>   drivers/net/wireless/ath/ath10k/htt_tx.c | 32 ++++++++++++++++++
>   drivers/net/wireless/ath/ath10k/mac.c    | 43 +++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath10k/txrx.c   |  3 ++
>   5 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
> index 446dca74f06a..4709e4887efc 100644
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -558,6 +558,10 @@ struct ath10k_sta {
>   	u8 rate_ctrl[ATH10K_TID_MAX];
>   	u32 rate_code[ATH10K_TID_MAX];
>   	int rtscts[ATH10K_TID_MAX];
> +	/* protects num_fw_queued */
> +	spinlock_t sta_tx_lock;
> +	wait_queue_head_t empty_tx_wq;
> +	unsigned int num_fw_queued;
>   };
>   
>   #define ATH10K_VDEV_SETUP_TIMEOUT_HZ	(5 * HZ)
> diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wireless/ath/ath10k/htt.h
> index 603f6de62b0a..d150f9330941 100644
> --- a/drivers/net/wireless/ath/ath10k/htt.h
> +++ b/drivers/net/wireless/ath/ath10k/htt.h
> @@ -2452,6 +2452,10 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt);
>   void ath10k_htt_tx_mgmt_dec_pending(struct ath10k_htt *htt);
>   int ath10k_htt_tx_mgmt_inc_pending(struct ath10k_htt *htt, bool is_mgmt,
>   				   bool is_presp);
> +void ath10k_htt_tx_sta_inc_pending(struct ath10k_htt *htt,
> +				   struct ieee80211_sta *sta);
> +void ath10k_htt_tx_sta_dec_pending(struct ath10k_htt *htt,
> +				   struct ieee80211_sta *sta);
>   
>   int ath10k_htt_tx_alloc_msdu_id(struct ath10k_htt *htt, struct sk_buff *skb);
>   void ath10k_htt_tx_free_msdu_id(struct ath10k_htt *htt, u16 msdu_id);
> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
> index 9725feecefd6..7477cb8f5d10 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> @@ -195,6 +195,38 @@ void ath10k_htt_tx_mgmt_dec_pending(struct ath10k_htt *htt)
>   	htt->num_pending_mgmt_tx--;
>   }
>   
> +void ath10k_htt_tx_sta_inc_pending(struct ath10k_htt *htt,
> +				   struct ieee80211_sta *sta)
> +{
> +	struct ath10k_sta *arsta;
> +
> +	if (!sta)
> +		return;
> +
> +	arsta = (struct ath10k_sta *)sta->drv_priv;
> +
> +	spin_lock_bh(&arsta->sta_tx_lock);
> +	arsta->num_fw_queued++;
> +	spin_unlock_bh(&arsta->sta_tx_lock);
> +}
> +
> +void ath10k_htt_tx_sta_dec_pending(struct ath10k_htt *htt,
> +				   struct ieee80211_sta *sta)
> +{
> +	struct ath10k_sta *arsta;
> +
> +	if (!sta)
> +		return;
> +
> +	arsta = (struct ath10k_sta *)sta->drv_priv;
> +
> +	spin_lock_bh(&arsta->sta_tx_lock);
> +	arsta->num_fw_queued--;
> +	if (arsta->num_fw_queued == 0)
> +		wake_up(&arsta->empty_tx_wq);
> +	spin_unlock_bh(&arsta->sta_tx_lock);
> +}
> +
>   int ath10k_htt_tx_alloc_msdu_id(struct ath10k_htt *htt, struct sk_buff *skb)
>   {
>   	struct ath10k *ar = htt->ar;
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
> index 646e1737d4c4..373a0aa6b01c 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -4423,6 +4423,8 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
>   		spin_unlock_bh(&ar->htt.tx_lock);
>   	}
>   
> +	ath10k_htt_tx_sta_inc_pending(&ar->htt, sta);
> +
>   	ret = ath10k_mac_tx(ar, vif, txmode, txpath, skb, false);
>   	if (unlikely(ret)) {
>   		ath10k_warn(ar, "failed to push frame: %d\n", ret);
> @@ -4432,6 +4434,7 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
>   		if (is_mgmt)
>   			ath10k_htt_tx_mgmt_dec_pending(htt);
>   		spin_unlock_bh(&ar->htt.tx_lock);
> +		ath10k_htt_tx_sta_dec_pending(&ar->htt, sta);
>   
>   		return ret;
>   	}
> @@ -7474,7 +7477,8 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
>   		arsta->peer_ps_state = WMI_PEER_PS_STATE_DISABLED;
>   		INIT_WORK(&arsta->update_wk, ath10k_sta_rc_update_wk);
>   		INIT_WORK(&arsta->tid_config_wk, ath10k_sta_tid_cfg_wk);
> -
> +		spin_lock_init(&arsta->sta_tx_lock);
> +		init_waitqueue_head(&arsta->empty_tx_wq);
>   		for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
>   			ath10k_mac_txq_init(sta->txq[i]);
>   	}
> @@ -8098,6 +8102,42 @@ static void ath10k_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>   	mutex_unlock(&ar->conf_mutex);
>   }
>   
> +static void ath10k_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +			     struct ieee80211_sta *sta)
> +{
> +	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
> +	struct ath10k *ar = hw->priv;
> +	bool skip;
> +	long time_left;
> +
> +	/* TODO do we need drop implemented here ? */
> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	if (ar->state == ATH10K_STATE_WEDGED)
> +		goto out;
> +
> +	time_left = wait_event_timeout(arsta->empty_tx_wq, ({
> +			bool empty;
> +
> +			spin_lock_bh(&arsta->sta_tx_lock);
> +			empty = (arsta->num_fw_queued == 0);
> +			spin_unlock_bh(&arsta->sta_tx_lock);
> +
> +			skip = (ar->state == ATH10K_STATE_WEDGED) ||
> +			       test_bit(ATH10K_FLAG_CRASH_FLUSH,
> +					&ar->dev_flags);
> +
> +			(empty || skip);
> +		}), ATH10K_FLUSH_TIMEOUT_HZ);
> +
> +	if (time_left == 0 || skip)
> +		ath10k_warn(ar, "failed to flush sta txq (sta %pM skip %i ar-state %i): %ld\n",
> +			    sta->addr, skip, ar->state, time_left);
> +out:
> +	mutex_unlock(&ar->conf_mutex);
> +}
> +
>   /* TODO: Implement this function properly
>    * For now it is needed to reply to Probe Requests in IBSS mode.
>    * Probably we need this information from FW.
> @@ -9444,6 +9484,7 @@ static const struct ieee80211_ops ath10k_ops = {
>   	.set_rts_threshold		= ath10k_set_rts_threshold,
>   	.set_frag_threshold		= ath10k_mac_op_set_frag_threshold,
>   	.flush				= ath10k_flush,
> +	.flush_sta			= ath10k_flush_sta,
>   	.tx_last_beacon			= ath10k_tx_last_beacon,
>   	.set_antenna			= ath10k_set_antenna,
>   	.get_antenna			= ath10k_get_antenna,
> diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
> index da3bc35e41aa..ece56379b0f0 100644
> --- a/drivers/net/wireless/ath/ath10k/txrx.c
> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
> @@ -91,6 +91,9 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
>   					       skb_cb->airtime_est, 0);
>   	rcu_read_unlock();
>   
> +	if (txq)
> +		ath10k_htt_tx_sta_dec_pending(htt, txq->sta);
> +

This should be called within rcu?

Vasanth

