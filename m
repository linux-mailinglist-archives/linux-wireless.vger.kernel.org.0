Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03BC4A3A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 11:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJBJI4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 05:08:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfJBJI4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 05:08:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37920116BB21;
        Wed,  2 Oct 2019 09:08:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3E24261A7;
        Wed,  2 Oct 2019 09:08:55 +0000 (UTC)
Date:   Wed, 2 Oct 2019 11:08:49 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] mac80211: simplify TX aggregation start
Message-ID: <20191002090849.GA2943@redhat.com>
References: <1569960387-I152912660131cbab2e5d80b4218238c20f8a06e5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569960387-I152912660131cbab2e5d80b4218238c20f8a06e5@changeid>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Wed, 02 Oct 2019 09:08:56 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 01, 2019 at 10:06:29PM +0200, Johannes Berg wrote:
> index f1cdcd61c54a..b74e758cce09 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -10489,7 +10489,7 @@ int rt2800_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>  		 */
>  		break;
>  	case IEEE80211_AMPDU_TX_START:
> -		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
> +		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
>  		break;
>  	case IEEE80211_AMPDU_TX_STOP_CONT:
>  	case IEEE80211_AMPDU_TX_STOP_FLUSH:
<snip>
> +#define IEEE80211_AMPDU_TX_START_IMMEDIATE 1
> +
>  /**

On rt2x00 we already return 1 for case we do not have free HW WCID
number for a remote station.

        if (sta_priv->wcid > WCID_END)
                return 1;

So we should change that to some other error code i.e. -ENOSPC.

Stanislaw
