Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3A664C8C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jan 2023 20:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjAJTeA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Jan 2023 14:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjAJTd5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Jan 2023 14:33:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F41E3FD
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:33:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w1so12885954wrt.8
        for <linux-wireless@vger.kernel.org>; Tue, 10 Jan 2023 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hImi6469OiuMCuul023+xtyWQ0vqGis5sJYAw6nS1ew=;
        b=Sv32abioOH8Czt67OZBiAUVOXV5g05Wr8EuamXx7QJcK0lceoE3u0SZlTJQuvinXQf
         QKkeYYagKHooVS2MsWp9pnXvf4i+fGxKPzdDpIBG7n9cZ6gTwOHzu25ViTmowMhzQEJU
         I4EVbGrPoySb6Rvmbeq3tiX+kxY/eVCLVgQ+FscEkEMONQtTqZn+11VM+2mrVTojYUdj
         01k01XCrTteBWm0OVajXwHdbl+dRBdwsPyuVDq+9Oxv6iX8Ln33qJ3+RiEVSdQStjemk
         V3yYMnnAM2mi7Q+wZDZKSRjJpKhAbAkjta+P7MSCDkJYyY9369mIXRb2ILb6rrCjO9IX
         5M2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hImi6469OiuMCuul023+xtyWQ0vqGis5sJYAw6nS1ew=;
        b=35QwxDil7+ieP5S+zx9B31EgliDQ3+5RMuGrenn5CmIGNXtKcgpnzXkiItdpL7XJD1
         GND2UzGrtiG8Vgl6MzUSx/HSTD5lJTwGvlDk5RExdQhDhPW7Fb0lhuvbRtS/WKGj7fKA
         +v3tuYARybGeltE5lC39667+sujySpID+jeBkXgb8Rn2XQzkDu9GA60UrNBMe6dq9dRw
         vUUD7JlvbVJUkBBM4bJgshIo7aJL3mYReH5358vKzz/P/baFwLNf3gaujV9as//eKIkV
         xxggOQ2MOh9OpWQ/oq4VtJoOPlBcSdEWHE6qwL3Z3jexBYagHZLynfOCTnTi4R8H/xRD
         RpSQ==
X-Gm-Message-State: AFqh2krzJmVsrkqGvK442MxJPEb8tC/j94y3odYOGyqdj7Xgv2tLjVCl
        uCsnJlNmO5C8zoBtVR1MJGsoqA==
X-Google-Smtp-Source: AMrXdXvDIIc4Hjx6mDFdFJc2EQDE964rxsh5FhcZFYsC2YImXZSImDdiFMf8ST1MRscM4IwJJ39aGg==
X-Received: by 2002:a05:6000:100a:b0:2bb:eb1d:bbae with SMTP id a10-20020a056000100a00b002bbeb1dbbaemr6201493wrx.5.1673379233034;
        Tue, 10 Jan 2023 11:33:53 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6152000000b002425be3c9e2sm11683000wrt.60.2023.01.10.11.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 11:33:51 -0800 (PST)
Message-ID: <961fa151-b5ee-2ffa-6b30-425d26c98eb4@nexus-software.ie>
Date:   Tue, 10 Jan 2023 19:33:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] wifi: mac80211: Proper mark iTXQs for resumption
Content-Language: en-US
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20221230121850.218810-1-alexander@wetzel-home.de>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20221230121850.218810-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 30/12/2022 12:18, Alexander Wetzel wrote:
> When a running wake_tx_queue() call is aborted due to a hw queue stop
> the corresponding iTXQ is not always correctly marked for resumption:
> wake_tx_push_queue() can stops the queue run without setting
> @IEEE80211_TXQ_STOP_NETIF_TX.
> 
> Without the @IEEE80211_TXQ_STOP_NETIF_TX flag __ieee80211_wake_txqs()
> will not schedule a new queue run and remaining frames in the queue get
> stuck till another frame is queued to it.
> 
> Fix the issue for all drivers - also the ones with custom wake_tx_queue
> callbacks - by moving the logic into ieee80211_tx_dequeue() and drop the
> redundant @txqs_stopped.
> 
> @IEEE80211_TXQ_STOP_NETIF_TX is also renamed to @IEEE80211_TXQ_DIRTY to
> better describe the flag.
> 
> Fixes: c850e31f79f0 ("wifi: mac80211: add internal handler for wake_tx_queue")
> Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
> ---
>   include/net/mac80211.h     |  4 ----
>   net/mac80211/debugfs_sta.c |  5 +++--
>   net/mac80211/driver-ops.h  |  2 +-
>   net/mac80211/ieee80211_i.h |  2 +-
>   net/mac80211/tx.c          | 20 +++++++++++-------
>   net/mac80211/util.c        | 42 +++-----------------------------------
>   6 files changed, 21 insertions(+), 54 deletions(-)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 689da327ce2e..e3235b9c02c2 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -1832,8 +1832,6 @@ struct ieee80211_vif_cfg {
>    * @drv_priv: data area for driver use, will always be aligned to
>    *	sizeof(void \*).
>    * @txq: the multicast data TX queue
> - * @txqs_stopped: per AC flag to indicate that intermediate TXQs are stopped,
> - *	protected by fq->lock.
>    * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
>    *	&enum ieee80211_offload_flags.
>    * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
> @@ -1863,8 +1861,6 @@ struct ieee80211_vif {
>   	bool probe_req_reg;
>   	bool rx_mcast_action_reg;
>   
> -	bool txqs_stopped[IEEE80211_NUM_ACS];
> -
>   	struct ieee80211_vif *mbssid_tx_vif;
>   
>   	/* must be last */
> diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
> index 7a3d7893e19d..f1914bf39f0e 100644
> --- a/net/mac80211/debugfs_sta.c
> +++ b/net/mac80211/debugfs_sta.c
> @@ -167,7 +167,7 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
>   			continue;
>   		txqi = to_txq_info(sta->sta.txq[i]);
>   		p += scnprintf(p, bufsz + buf - p,
> -			       "%d %d %u %u %u %u %u %u %u %u %u 0x%lx(%s%s%s)\n",
> +			       "%d %d %u %u %u %u %u %u %u %u %u 0x%lx(%s%s%s%s)\n",
>   			       txqi->txq.tid,
>   			       txqi->txq.ac,
>   			       txqi->tin.backlog_bytes,
> @@ -182,7 +182,8 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
>   			       txqi->flags,
>   			       test_bit(IEEE80211_TXQ_STOP, &txqi->flags) ? "STOP" : "RUN",
>   			       test_bit(IEEE80211_TXQ_AMPDU, &txqi->flags) ? " AMPDU" : "",
> -			       test_bit(IEEE80211_TXQ_NO_AMSDU, &txqi->flags) ? " NO-AMSDU" : "");
> +			       test_bit(IEEE80211_TXQ_NO_AMSDU, &txqi->flags) ? " NO-AMSDU" : "",
> +			       test_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ? " DIRTY" : "");
>   	}
>   
>   	rcu_read_unlock();
> diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
> index 809bad53e15b..5d13a3dfd366 100644
> --- a/net/mac80211/driver-ops.h
> +++ b/net/mac80211/driver-ops.h
> @@ -1199,7 +1199,7 @@ static inline void drv_wake_tx_queue(struct ieee80211_local *local,
>   
>   	/* In reconfig don't transmit now, but mark for waking later */
>   	if (local->in_reconfig) {
> -		set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txq->flags);
> +		set_bit(IEEE80211_TXQ_DIRTY, &txq->flags);
>   		return;
>   	}
>   
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index 63ff0d2524b6..d16606e84e22 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -838,7 +838,7 @@ enum txq_info_flags {
>   	IEEE80211_TXQ_STOP,
>   	IEEE80211_TXQ_AMPDU,
>   	IEEE80211_TXQ_NO_AMSDU,
> -	IEEE80211_TXQ_STOP_NETIF_TX,
> +	IEEE80211_TXQ_DIRTY,
>   };
>   
>   /**
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 2171cd1ca807..178043f84489 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -3783,6 +3783,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>   	struct ieee80211_tx_data tx;
>   	ieee80211_tx_result r;
>   	struct ieee80211_vif *vif = txq->vif;
> +	int q = vif->hw_queue[txq->ac];
> +	bool q_stopped;
>   
>   	WARN_ON_ONCE(softirq_count() == 0);
>   
> @@ -3790,16 +3792,20 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
>   		return NULL;
>   
>   begin:
> -	spin_lock_bh(&fq->lock);
> +	spin_lock(&local->queue_stop_reason_lock);
> +	q_stopped = local->queue_stop_reasons[q];
> +	spin_unlock(&local->queue_stop_reason_lock);
>   
> -	if (test_bit(IEEE80211_TXQ_STOP, &txqi->flags) ||
> -	    test_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txqi->flags))
> -		goto out;
> +	if (unlikely(q_stopped)) {
> +		/* mark for waking later */
> +		set_bit(IEEE80211_TXQ_DIRTY, &txqi->flags);
> +		return NULL;
> +	}
>   
> -	if (vif->txqs_stopped[txq->ac]) {
> -		set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txqi->flags);
> +	spin_lock_bh(&fq->lock);
> +
> +	if (unlikely(test_bit(IEEE80211_TXQ_STOP, &txqi->flags)))
>   		goto out;
> -	}
>   
>   	/* Make sure fragments stay together. */
>   	skb = __skb_dequeue(&txqi->frags);
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 6f5407038459..261ac667887f 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -292,22 +292,12 @@ static void wake_tx_push_queue(struct ieee80211_local *local,
>   			       struct ieee80211_sub_if_data *sdata,
>   			       struct ieee80211_txq *queue)
>   {
> -	int q = sdata->vif.hw_queue[queue->ac];
>   	struct ieee80211_tx_control control = {
>   		.sta = queue->sta,
>   	};
>   	struct sk_buff *skb;
> -	unsigned long flags;
> -	bool q_stopped;
>   
>   	while (1) {
> -		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
> -		q_stopped = local->queue_stop_reasons[q];
> -		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
> -
> -		if (q_stopped)
> -			break;
> -
>   		skb = ieee80211_tx_dequeue(&local->hw, queue);
>   		if (!skb)
>   			break;
> @@ -347,8 +337,6 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
>   	local_bh_disable();
>   	spin_lock(&fq->lock);
>   
> -	sdata->vif.txqs_stopped[ac] = false;
> -
>   	if (!test_bit(SDATA_STATE_RUNNING, &sdata->state))
>   		goto out;
>   
> @@ -370,7 +358,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
>   			if (ac != txq->ac)
>   				continue;
>   
> -			if (!test_and_clear_bit(IEEE80211_TXQ_STOP_NETIF_TX,
> +			if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY,
>   						&txqi->flags))
>   				continue;
>   
> @@ -385,7 +373,7 @@ static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
>   
>   	txqi = to_txq_info(vif->txq);
>   
> -	if (!test_and_clear_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txqi->flags) ||
> +	if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
>   	    (ps && atomic_read(&ps->num_sta_ps)) || ac != vif->txq->ac)
>   		goto out;
>   
> @@ -517,8 +505,6 @@ static void __ieee80211_stop_queue(struct ieee80211_hw *hw, int queue,
>   				   bool refcounted)
>   {
>   	struct ieee80211_local *local = hw_to_local(hw);
> -	struct ieee80211_sub_if_data *sdata;
> -	int n_acs = IEEE80211_NUM_ACS;
>   
>   	trace_stop_queue(local, queue, reason);
>   
> @@ -530,29 +516,7 @@ static void __ieee80211_stop_queue(struct ieee80211_hw *hw, int queue,
>   	else
>   		local->q_stop_reasons[queue][reason]++;
>   
> -	if (__test_and_set_bit(reason, &local->queue_stop_reasons[queue]))
> -		return;
> -
> -	if (local->hw.queues < IEEE80211_NUM_ACS)
> -		n_acs = 1;
> -
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
> -		int ac;
> -
> -		if (!sdata->dev)
> -			continue;
> -
> -		for (ac = 0; ac < n_acs; ac++) {
> -			if (sdata->vif.hw_queue[ac] == queue ||
> -			    sdata->vif.cab_queue == queue) {
> -				spin_lock(&local->fq.lock);
> -				sdata->vif.txqs_stopped[ac] = true;
> -				spin_unlock(&local->fq.lock);
> -			}
> -		}
> -	}
> -	rcu_read_unlock();
> +	set_bit(reason, &local->queue_stop_reasons[queue]);
>   }
>   
>   void ieee80211_stop_queue_by_reason(struct ieee80211_hw *hw, int queue,

Nice

Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
