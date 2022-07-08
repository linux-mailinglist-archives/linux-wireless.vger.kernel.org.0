Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971FF56C44D
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Jul 2022 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240412AbiGHVMB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 17:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbiGHVMB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 17:12:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EF6A239A
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=n/M1fM2RChewEXKjg0ns64cNxye5PwAQ9pEQFaBqKtI=;
        t=1657314719; x=1658524319; b=E+VxdX+yoExXDC4eMcxvRLaxBBpEPR7DXht2+oxyyXw0FB+
        Fwezp7gn4DpUZG8mx79ExwRmZlbuIm0VPCVpYvO7qV+ulTylsX5eYRbCxP6E39URB4FSgcPmQLpQc
        fJaE0np1epu+K/KS8n0RVMEZT7fozW5eTdwvjgMWZOD80Z3aGkNRX8uKW2Bm9YiSFhPr0iPgoKNuM
        JVVEkNU/Fc+nGje2vQnpB4e+moaYNxso583rrlSXlv6y3XU4U0rOp+si7J7Vv0mxV8GFkF958eiVu
        BA6xAFyPx9TrhMrmP8nr1R5EKbI6oQyu3ZIS9f55K6PlTH+Ul6S39kFXX8pP8G6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o9vGX-00APhk-9r;
        Fri, 08 Jul 2022 23:11:57 +0200
Message-ID: <b2d6360f289ea0de4985a2909919049ff0f53e2b.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211: Switch all drivers over to iTXQs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 08 Jul 2022 23:11:56 +0200
In-Reply-To: <20220707143230.21686-1-alexander@wetzel-home.de>
References: <20220707143230.21686-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Nice!

I see your follow-up, but a few comments anyway here on this version.

> +	/* Driver has no native support for iTXQ, handle the queues */
> +	ieee80211_txq_schedule_start(&local->hw, txq->txq.ac);
> +	while ((queue =3D ieee80211_next_txq(&local->hw, txq->txq.ac)) !=3D NUL=
L) {
> +		control.sta =3D queue->sta;
> +		while ((skb =3D ieee80211_tx_dequeue(&local->hw, queue)))
> +			drv_tx(local, &control, skb);

Yeah, I think I see how that might not work right - you don't
necessarily want to pull out everything here.

But it should be easy to break out here, I guess, and continue if the
driver restarts the corresponding queue?

> -/* Indicate which queue to use. */
>  u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
>  			   struct sk_buff *skb)
>  {
> -[...]
> +	/* mac80211 only supports iTXQ nowadays. Only calculate the hash while
> +	 * the skb is still hot in the CPU cache
> +	 */
> +	skb_get_hash(skb);
> +	return 0;

Hmm. Is that really worth keeping? I'd probably rather remove the
netdev_select_queue callbacks completely.

Regardless, once this works I'm sure we can make a lot of cleanups
elsewhere, e.g. a couple of "!txq" checks in tx.c (tx_prep_agg,
amsdu_aggregate).



Eventually with this implementation I think it'd be worth doing it for
all the cases where ieee80211_get_txq() returns NULL or for where it's
skipped in ieee80211_queue_skb(), i.e.

 * monitor mode,
 * management frames,
 * after-DTIM
 * PS response
 *=C2=A0STA not uploaded

as well, and just going into the mac80211 iTXQ scheduling code you wrote
in wake_tx_queue() for those cases.

That way, we could get rid of all the special cases in
ieee80211_queue_skb() and callers that depend on the return value.

That would allow us to remove a LOT of code, all the stuff handling
local->pending (tx_pending), tx_frags, etc.

johannes

