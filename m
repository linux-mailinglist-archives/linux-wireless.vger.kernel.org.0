Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0735F5432
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 14:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJEMIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 08:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiJEMIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 08:08:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCB22F659
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=VaCAapUZEwzYdSEBPN80QsZ66/q/HO5QkArLNIExocw=;
        t=1664971711; x=1666181311; b=Mg7cI84Dc7MS668DPUbv9eUNkh3jiGAhVpvLWH8bBHoflx/
        Inrom9vm5U3SVMCNseNBlrAtVlIcTcSv8r8zY+gNwBPP+5hAaLMZuIo2y7No9i4TJC0MgzV5EC6Ui
        lqaW63V9dUYmvVCqC5yj6Ib8Q2pYw/i9Wbe33yzh2fCBtV/rvYBbHjASYUR0LK/hez1lzXcKqLFB2
        aUD9sJU80VTicqXTK1vVm6GhLjDtF9UBf8cVAbMeBaG2yZ9A7UW6nqrMrug7VuTLF/7995J2mFwWs
        QP6/UKivvEKG21mOyyyaiemoc2ecCfO9KCtvCNXf68K2x73es4r0j96Xh7irv3oQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og2ka-00G0f6-0t;
        Wed, 05 Oct 2022 13:39:44 +0200
Message-ID: <96e9ad692842853cfe92a7e5de18136baf20a492.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Date:   Wed, 05 Oct 2022 13:39:43 +0200
In-Reply-To: <20220926161303.13035-1-alexander@wetzel-home.de>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2022-09-26 at 18:13 +0200, Alexander Wetzel wrote:

> -	trace_drv_wake_tx_queue(local, sdata, txq);

Technically, I guess we could keep both tracepoints, but it'd be kind of
pointless since we know statically which driver does which...

> @@ -596,21 +598,18 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdat=
a,
> =20
>  	sta->last_connected =3D ktime_get_seconds();
> =20
> -	if (local->ops->wake_tx_queue) {
> -		void *txq_data;
> -		int size =3D sizeof(struct txq_info) +
> -			   ALIGN(hw->txq_data_size, sizeof(void *));
> +	size =3D sizeof(struct txq_info) +
> +	       ALIGN(hw->txq_data_size, sizeof(void *));
> =20
> -		txq_data =3D kcalloc(ARRAY_SIZE(sta->sta.txq), size, gfp);
> -		if (!txq_data)
> -			goto free;
> +	txq_data =3D kcalloc(ARRAY_SIZE(sta->sta.txq), size, gfp);
> +	if (!txq_data)
> +		goto free;
> =20
> -		for (i =3D 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
> -			struct txq_info *txq =3D txq_data + i * size;
> +	for (i =3D 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
> +		struct txq_info *txq =3D txq_data + i * size;
> =20
> -			/* might not do anything for the bufferable MMPDU TXQ */
> -			ieee80211_txq_init(sdata, sta, txq, i);
> -		}
> +		/* might not do anything for the bufferable MMPDU TXQ */
> +		ieee80211_txq_init(sdata, sta, txq, i);

Is that comment still true?

> +++ b/net/mac80211/util.c
> @@ -288,6 +288,64 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211=
_hw *hw,
>  }
>  EXPORT_SYMBOL(ieee80211_ctstoself_duration);
> =20
> +static void wake_tx_push_queue(struct ieee80211_local *local,
> +			       struct ieee80211_sub_if_data *sdata,
> +			       struct ieee80211_txq *queue)
> +{
> +	int q =3D sdata->vif.hw_queue[queue->ac];
> +	struct ieee80211_tx_control control =3D {};
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +	bool q_stopped;
> +
> +	control.sta =3D queue->sta;
> +
> +	while (1) {
> +		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
> +		q_stopped =3D local->queue_stop_reasons[q];
> +		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
> +
> +		if (q_stopped)
> +			break;
> +
> +		skb =3D ieee80211_tx_dequeue(&local->hw, queue);
> +		if (!skb)
> +			break;
> +
> +		drv_tx(local, &control, skb);
> +	}
> +}
> +
> +void wake_tx_queue(struct ieee80211_local *local, struct txq_info *txq)
> +{
> +	struct ieee80211_sub_if_data *sdata =3D vif_to_sdata(txq->txq.vif);
> +	struct ieee80211_txq *queue;
> +
> +	/* In reconfig don't transmit now, but mark for waking later */
> +	if (local->in_reconfig) {
> +		set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txq->flags);
> +		return;
> +	}
> +
> +	if (!check_sdata_in_driver(sdata))
> +		return;
> +
> +	trace_wake_tx_queue(local, sdata, txq);
> +
> +	if (local->ops->wake_tx_queue) {
> +		drv_wake_tx_queue(local, txq);
> +		return;
> +	}
> +
> +	/* Driver has no native support for iTXQ, handle the queues */
> +	ieee80211_txq_schedule_start(&local->hw, txq->txq.ac);
> +	while ((queue =3D ieee80211_next_txq(&local->hw, txq->txq.ac))) {
> +		wake_tx_push_queue(local, sdata, queue);
> +		ieee80211_return_txq(&local->hw, queue, false);
> +	}
> +	ieee80211_txq_schedule_end(&local->hw, txq->txq.ac);
> +}

Here's another thought:

Since this code is basically all moved from the original
drv_wake_tx_queue(), except for the "else" portion (after the if/return)
of it, another thing we could do is to just have an exported function
that does this:

void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
				    struct ieee80211_txq *txq)
{
	... *local =3D from_hw(hw);
	... *sdata =3D from_vif(txq->vif);

	wake_tx_push_queue(local, sdata, txq);
}

Actually ... I wonder why you'd here - in waking a single TXQ - use
ieee80211_next_txq() at all, Toke, what do you think?


Anyway, then we could require drivers set wake_txq to
ieee80211_handle_wake_tx_queue and make sure in main.c that
wake_tx_queue is non-NULL.

That's a bit more churn in drivers, but:
 * it's not really that hard to do
 * it avoids an extra function call to then jump to the op
 * it avoids the tracing changes since now it does look like a driver
   wake_tx_queue callback

What do you think?

johannes
