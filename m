Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D011CECDB
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfJGTdd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 15:33:33 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45140 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTdd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 15:33:33 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHYl8-0007pV-OG; Mon, 07 Oct 2019 21:33:30 +0200
Message-ID: <02069f490a1b328deffdee384720515549d506b2.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] mac80211: Implement Airtime-based Queue Limit
 (AQL)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org
Date:   Mon, 07 Oct 2019 21:33:29 +0200
In-Reply-To: <20191007043120.67567-2-kyan@google.com> (sfid-20191007_063130_415610_B799A895)
References: <20191007043120.67567-1-kyan@google.com>
         <20191007043120.67567-2-kyan@google.com>
         (sfid-20191007_063130_415610_B799A895)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-10-06 at 21:31 -0700, Kan Yan wrote:

> +/**
> + * ieee80211_sta_update_pending_airtime - update txq's estimated airtime
> + *
> + * Update the estimated total airtime of frames queued in the lower layer queue.
> + *
> + * The airtime is estimated using frame length and the last reported data
> + * rate. The pending airtime for a txq is increased by the estimated
> + * airtime when the frame is relased to the lower layer, and decreased by the

typo - released.

> + * same amount at the tx completion event.

I think this isn't really all that clear, "The airtime is [...]
decreased by the same amount at the tx completion event." makes it sound
like that is implicit? But that's not true, this needs to be called at
that point, afaict?

I'm not sure why you decided to not add the inlines I suggested, but I
still think it'd be clearer to have them to indicate that both need to
be called.

Some note should probably also be there that we really want to decrease
later again with the same value that it was increased with, not with the
actual airtime that's now known due to the TX completion, right?

> + *
> + * @pubsta: the station
> + * @tid: the TID to register airtime for

s/register/update/ now, I guess

> +/**
> + * ieee80211_txq_aql_check - check if a txq can send more frames to firmware

s/firmware/device/ IMHO

> +static ssize_t aql_txq_limit_write(struct file *file,
> +				   const char __user *user_buf,
> +				   size_t count,
> +				   loff_t *ppos)
> +{
> +	struct ieee80211_local *local = file->private_data;
> +	char buf[100];
> +	size_t len;
> +	u32	ac, q_limit_low, q_limit_high;

use a space here please, not a tab

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

You could use "0" and "'\0'" consistently - I'd prefer just plain 0, but
here you have two spellings within 4 lines ;-)

> @@ -245,7 +268,6 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
>  		sta->airtime[ac].deficit = sta->airtime_weight;
>  		spin_unlock_bh(&local->active_txq_lock[ac]);
>  	}
> -
>  	return count;

better leave that

> +void ieee80211_sta_update_pending_airtime(struct ieee80211_sta *pubsta, u8 tid,
> +					  s32 tx_airtime)
> +{
> +	u8 ac = ieee80211_ac_from_tid(tid);
> +	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
> +	struct ieee80211_local *local = sta->local;
> +
> +	spin_lock_bh(&local->active_txq_lock[ac]);
> +	sta->airtime[ac].aql_tx_pending += tx_airtime;
> +	local->aql_total_pending_airtime += tx_airtime;
> +	WARN_ONCE(sta->airtime[ac].aql_tx_pending < 0, "STA pending airtime < 0");
> +	WARN_ONCE(local->aql_total_pending_airtime < 0,
> +		  "Total pending airtime < 0");

I think you should reset them if the warning happens?

> +++ b/net/mac80211/sta_info.h
> @@ -127,11 +127,15 @@ enum ieee80211_agg_stop_reason {
>  /* Debugfs flags to enable/disable use of RX/TX airtime in scheduler */
>  #define AIRTIME_USE_TX		BIT(0)
>  #define AIRTIME_USE_RX		BIT(1)
> +#define AIRTIME_USE_AQL		BIT(2)
>  
>  struct airtime_info {
>  	u64 rx_airtime;
>  	u64 tx_airtime;
>  	s64 deficit;
> +	s32 aql_tx_pending; /* Estimated airtime for frames pending in queue */

This doesn't make sense as an s32. I realize you need it above for the
warning, but you can check for underflow before doing the calculation
and keep the storage unsigned.

> +bool ieee80211_txq_aql_check(struct ieee80211_hw *hw,
> +			     struct ieee80211_txq *txq)
> +{
> +	struct sta_info *sta;
> +	struct ieee80211_local *local = hw_to_local(hw);
> +
> +	if (!(local->airtime_flags & AIRTIME_USE_AQL))
> +		return true;
> +
> +	if (!txq->sta)
> +		return true;
> +
> +	sta = container_of(txq->sta, struct sta_info, sta);
> +	if (sta->airtime[txq->ac].aql_tx_pending <
> +	     sta->airtime[txq->ac].aql_limit_low ||
> +	    (local->aql_total_pending_airtime < local->aql_threshold &&
> +	     sta->airtime[txq->ac].aql_tx_pending <
> +	     sta->airtime[txq->ac].aql_limit_high))
> +		return true;
> +	else
> +		return false;

This is a massive expression ... IMHO it'd be clearer as either
splitting it up into pieces ("if (first) return true; if (second) return
true; return false;") or just returning the value of the expression?

	if (x) return true; else return false;

is just

	return x;

after all.

johannes

