Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14100CBA6F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 14:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbfJDMa2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 08:30:28 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39192 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbfJDMa1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 08:30:27 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iGMj3-0007vC-1J; Fri, 04 Oct 2019 14:30:25 +0200
Message-ID: <22b6c96a5bd346408fa473af7d2f7b205e97dd99.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org
Date:   Fri, 04 Oct 2019 14:30:24 +0200
In-Reply-To: <20191004062151.131405-2-kyan@google.com> (sfid-20191004_082219_852781_215A08B7)
References: <20191004062151.131405-1-kyan@google.com>
         <20191004062151.131405-2-kyan@google.com>
         (sfid-20191004_082219_852781_215A08B7)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Just took a very brief look so I can think about it while offline ;-)

But some (editorial) comments:

> +/**
> + * ieee80211_sta_register_pending_airtime - register the estimated airtime for
> + * the frames pending in lower layer (firmware/hardware) txq.

That doesn't work - the short description must be on a single line.

> + * Update the total pending airtime of the frames released to firmware. The
> + * pending airtime is used by AQL to control queue size in the lower layer.

What does "released to firmware" mean? I guess it should either be
something like "transmitted by the device" or "sitting on the hardware
queues" - I'm guessing the latter?

> + * The airtime is estimated using frame length and the last reported data
> + * rate. The pending airtime for a txq is increased by the estimated
> + * airtime when the frame is relased to the lower layer, and decreased by the
> + * same amount at the tx completion event.
> + *
> + * @pubsta: the station
> + * @tid: the TID to register airtime for
> + * @tx_airtime: the estimated airtime (in usec)
> + * @tx_commpleted: true if called from the tx completion event.
> + */
> +void ieee80211_sta_register_pending_airtime(struct ieee80211_sta *pubsta,
> +					    u8 tid, u32 tx_airtime,
> +					    bool tx_completed);

The "bool tx_completed" is a bit confusing IMHO.

Probably better to do something like this:

void ieee80211_sta_update_pending_airtime(sta, tid, *s32* airtime);

static inline void ieee80211_sta_register_pending_airtime(...)
{
	ieee80211_sta_update_pending_airtime(..., airtime);
}

static inline void ieee80211_sta_release_pending_airtime(...)
{
	ieee8021
1_sta_update_pending_airtime(..., -airtime);
}

or something like that?

> +/**
> + * ieee80211_txq_aritme_check - check if the airtime limit of AQL (Airtime based
> + * queue limit) has been reached.

same comment as above - and there's a typo

> + * @hw: pointer obtained from ieee80211_alloc_hw()
> + * @txq: pointer obtained from station or virtual interface
> + * Retrun 

typo

> true if the queue limit has not been reached and txq can continue to
> + * release packets to the lower layer.
> + * Return false if the queue limit has been reached and the txq should not
> + * release more frames to the lower layer.
> + */
> +bool
> +ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211_txq *txq);

Why is it necessary to call this, vs. just returning NULL when an SKB is
requested?

> +static ssize_t aql_txq_limit_read(struct file *file,
> +				  char __user *user_buf,
> +				  size_t count,
> +				  loff_t *ppos)
> +{
> +	struct ieee80211_local *local = file->private_data;
> +	char buf[400];
> +	int len = 0;
> +
> +	rcu_read_lock();
> +	len = scnprintf(buf, sizeof(buf),
> +			"AC	AQL limit low	AQL limit high\n"
> +			"0	%u		%u\n"
> +			"1	%u		%u\n"
> +			"2	%u		%u\n"
> +			"3	%u		%u\n",
> +			local->aql_txq_limit_low[0],
> +			local->aql_txq_limit_high[0],
> +			local->aql_txq_limit_low[1],
> +			local->aql_txq_limit_high[1],
> +			local->aql_txq_limit_low[2],
> +			local->aql_txq_limit_high[2],
> +			local->aql_txq_limit_low[3],
> +			local->aql_txq_limit_high[3]);
> +	rcu_read_unlock();

I don't understand the RCI critical section here, you do nothing that
would require it.

> +	return simple_read_from_buffer(user_buf, count, ppos,
> +				       buf, len);
> +}
> +
> +static ssize_t aql_txq_limit_write(struct file *file,
> +				   const char __user *user_buf,
> +				   size_t count,
> +				   loff_t *ppos)
> +{
> +	struct ieee80211_local *local = file->private_data;
> +	char buf[100];
> +	size_t len;
> +	u32	ac, q_limit_low, q_limit_high;
> +	struct sta_info *sta;
> +
> +	if (count > sizeof(buf))
> +		return -EINVAL;
> +
> +	if (copy_from_user(buf, user_buf, count))
> +		return -EFAULT;
> +
> +	buf[sizeof(buf) - 1] = '\0';
> +	len = strlen(buf);
> +	if (len > 0 && buf[len - 1] == '\n')
> +		buf[len - 1] = 0;
> +
> +	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) == 3) {
> +		if (ac < IEEE80211_NUM_ACS) {

The double indentation is a bit odd here - why not return -EINVAL
immediately if any of the checks doesn't work?

if (sscanf(...) != 3)
	return -EINVAL;

if (ac >= NUM_ACS)
	return -EINVAL;

[...]


> +	buf[sizeof(_buf) - 1] = '\0';
> +	if (sscanf(buf, "queue limit %u %u %u", &ac, &q_limit_l, &q_limit_h)
> +	    == 3) {
> +		if (ac < IEEE80211_NUM_ACS) {

same here

> @@ -245,8 +266,8 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
>  		sta->airtime[ac].deficit = sta->airtime_weight;
>  		spin_unlock_bh(&local->active_txq_lock[ac]);
>  	}
> -
>  	return count;
> +
>  }

spurious change

> +void ieee80211_sta_register_pending_airtime(struct ieee80211_sta *pubsta,
> +					    u8 tid, u32 tx_airtime,
> +					    bool tx_completed)
> +{
> +	u8 ac = ieee80211_ac_from_tid(tid);
> +	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
> +	struct ieee80211_local *local = sta->local;
> +
> +	spin_lock_bh(&local->active_txq_lock[ac]);
> +	if (tx_completed) {
> +		sta->airtime[ac].aql_tx_pending -= tx_airtime;
> +		local->aql_total_pending_airtime -= tx_airtime;

maybe this should check for underflow, just in case the driver has some
symmetry bug?

> +bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
> +			     struct ieee80211_txq *txq)
> +{
> +	struct sta_info *sta;
> +	struct ieee80211_local *local = hw_to_local(hw);
> +
> +

please remove one blank line

>  bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
>  				struct ieee80211_txq *txq)
>  {
> @@ -3748,10 +3784,13 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
>  	struct sta_info *sta;
>  	u8 ac = txq->ac;
>  
> -	spin_lock_bh(&local->active_txq_lock[ac]);
> -
>  	if (!txqi->txq.sta)
> -		goto out;
> +		return true;
> +
> +	if (!(local->airtime_flags & AIRTIME_USE_TX))
> +		return true;
> +
> +	spin_lock_bh(&local->active_txq_lock[ac]);
>  
>  	if (list_empty(&txqi->schedule_order))
>  		goto out;
> @@ -3773,10 +3812,11 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
>  	}
>  
>  	sta = container_of(txqi->txq.sta, struct sta_info, sta);
> -	if (sta->airtime[ac].deficit >= 0)
> +	if (ieee80211_txq_airtime_check(hw, &txqi->txq))
>  		goto out;

OK, so you *do* call it here, but then why are you exporting it too?

> -	sta->airtime[ac].deficit += sta->airtime_weight;
> +        if (sta->airtime[ac].deficit < 0)
> +		sta->airtime[ac].deficit += sta->airtime_weight;

something seems wrong with indentation here (spaces instead of tabs?)

Anyway, like I said - very cursory and mostly editorial view.

Thanks,
johannes


