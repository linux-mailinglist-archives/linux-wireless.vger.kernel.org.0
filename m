Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD39AF444C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 11:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfKHKRD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 05:17:03 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:53708 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfKHKRD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 05:17:03 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT1K9-0007j0-SI; Fri, 08 Nov 2019 11:17:01 +0100
Message-ID: <0b43c4822ab83ea4d33a5a32d8ff6c7a56eff6c5.camel@sipsolutions.net>
Subject: Re: [PATCH v6 4/4] mac80211: Use Airtime-based Queue Limits (AQL)
 on packet dequeue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 08 Nov 2019 11:17:00 +0100
In-Reply-To: <157182474399.150713.16380222749144410045.stgit@toke.dk>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
         <157182474399.150713.16380222749144410045.stgit@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-10-23 at 11:59 +0200, Toke Høiland-Jørgensen wrote:
> 
> +	if (info->tx_time_est) {
> +		struct sta_info *sta = NULL, *s;
> +		struct rhlist_head *tmp;
> +
> +		rcu_read_lock();
> +
> +		for_each_sta_info(local, hdr->addr1, s, tmp) {
> +			/* skip wrong virtual interface */
> +			if (!ether_addr_equal(hdr->addr2, s->sdata->vif.addr))
> +				continue;
> +
> +			sta = s;
> +			break;
> +		}

I guess that is better than looking up the sdata and then using
sta_info_get(), but I think I'd like to see this wrapped into a function
(even if it's an inline) in sta_info.{c,h}.

> +		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
> +							     skb->len);
> +		if (airtime) {
> +			/* We only have 10 bits in tx_time_est, so store airtime
> +			 * in increments of 4us and clamp the maximum to 2**12-1
> +			 */
> +			airtime = min_t(u32, airtime, 4095) & ~3U;
> +			info->tx_time_est = airtime >> 2;
> +			ieee80211_sta_update_pending_airtime(local, tx.sta,
> +							     txq->ac, airtime,
> +							     false);

I wonder if it'd be better to pass the shifted value to
ieee80211_sta_update_pending_airtime() to avoid all the shifting in all
places?

You could even store the shifted value in "aql_tx_pending" and
"aql_total_pending_airtime" etc., it's completely equivalent, and only
shift it out for people looking at debugfs.

johannes

