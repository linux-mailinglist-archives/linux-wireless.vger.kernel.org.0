Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427B712E728
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 15:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgABON7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jan 2020 09:13:59 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:59382 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgABON7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jan 2020 09:13:59 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1in1Ea-005WoJ-Qk; Thu, 02 Jan 2020 15:13:56 +0100
Message-ID: <5bab549a72d526f4fd0f708f14b49a7af6e2c0b9.camel@sipsolutions.net>
Subject: Re: [PATCH v5] mac80211: Switch to a virtual time-based airtime
 scheduler
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>,
        make-wifi-fast@lists.bufferbloat.net,
        Yibo Zhao <yiboz@codeaurora.org>
Date:   Thu, 02 Jan 2020 15:13:55 +0100
In-Reply-To: <20191222172423.131033-1-toke@redhat.com> (sfid-20191222_182529_460296_FED7C003)
References: <20191222172423.131033-1-toke@redhat.com>
         (sfid-20191222_182529_460296_FED7C003)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-12-22 at 18:24 +0100, Toke Høiland-Jørgensen wrote:
>  Didn't have a chance to
> do anything other than compile-test it yet, but wanted to get it out
> before the holidays (which I almost managed, since technically my
> holiday started two days ago)...

Didn't help you much, I at least was already on vacation by then too :P

> @@ -1948,6 +1978,7 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
>  			       tx_pending, 0);
>  }
>  
> +

nit, what's that doing here? :)

> +#define IEEE80211_RECIPROCAL_DIVISOR 0x100000000ULL
> +#define IEEE80211_RECIPROCAL_SHIFT 32

Could we live with less precision and use 32-bit arithmetic only? That
might help 32-bit systems?

This is basically a 32.32 (31.32 for signed) fixed point number, right?
So I guess I'm asking if we could live with 16.16 (or 15.16), or
similar.

> @@ -525,6 +532,7 @@ struct ieee80211_sta_rx_stats {
>   * @status_stats.ack_signal_filled: last ACK signal validity
>   * @status_stats.avg_ack_signal: average ACK signal
>   */
> +

another pointless blank line

> +	air_info = to_airtime_info(&txqi->txq);
> +	ret = (air_info->v_t <= air_sched->v_t);

no need for parentheses :)

I think overall this looks good. I guess you should subject it to some
testing since I can't.

johannes

