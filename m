Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3924358028
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 12:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhDHKBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDHKBp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 06:01:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D8C061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 03:01:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lURTb-008wq0-Fh; Thu, 08 Apr 2021 12:01:27 +0200
Message-ID: <c0aef41d2ecf09188de372fe4f7d6b1954e54e07.camel@sipsolutions.net>
Subject: Re: [PATCHv2] mac80211: increment rx stats according to USES_RSS
 flag
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thiraviyam Mariyappan <tmariyap@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 08 Apr 2021 12:01:26 +0200
In-Reply-To: <1613563010-1489-1-git-send-email-tmariyap@codeaurora.org> (sfid-20210217_125904_154301_738B3086)
References: <1613563010-1489-1-git-send-email-tmariyap@codeaurora.org>
         (sfid-20210217_125904_154301_738B3086)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-02-17 at 17:26 +0530, Thiraviyam Mariyappan wrote:
> Currently, rx_stats were updated regardless of USES_RSS flag is
> enabled/disabled. So, updating the rx_stats from percpu pointers
> according to the USES_RSS flag.

OK actually, I'm not going to fix the commit log, you'll probably have
to resend it anyway.


> @@ -425,7 +426,8 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
>  					&basic_rates);

>  	spin_lock_bh(&sta->mesh->plink_lock);
> -	sta->rx_stats.last_rx = jiffies;
> +	stats = ieee80211_get_rx_stats(&local->hw, sta);
> +	stats->last_rx = jiffies;

This doesn't really make much sense? Not sure why that is even updating
anything at all, it doesn't update anything else?

Or at least you didn't change anything else, maybe you should have?
> 
> @@ -1734,49 +1745,49 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
>  	 * something went wrong the first time.
>  	 */
>  	if (rx->sdata->vif.type == NL80211_IFTYPE_ADHOC) {
> -		u8 *bssid = ieee80211_get_bssid(hdr, rx->skb->len,
> +		u8 *bssid = ieee80211_get_bssid(hdr, skb->len,

That seems unrelated.

> @@ -3625,8 +3648,10 @@ ieee80211_rx_h_mgmt(struct ieee80211_rx_data *rx)
>  	/* queue up frame and kick off work to process it */
>  	skb_queue_tail(&sdata->skb_queue, rx->skb);
>  	ieee80211_queue_work(&rx->local->hw, &sdata->work);
> -	if (rx->sta)
> -		rx->sta->rx_stats.packets++;
> +	if (rx->sta) {
> +		stats = ieee80211_get_rx_stats(&rx->sdata->local->hw, rx->sta);
> +		stats->packets++;
> +	}
> 

Picking this for no particular reason - everything else in this patch is
unnecessary since we have rx_path_lock held afaict, so it doesn't
matter. The whole per-cpu status stuff only matters once you get into
fast-rx path.


I'd argue that had you written a proper commit log that actually says
why you need to change things, you'd probably even have noticed these
issues yourself.

johannes

