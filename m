Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C72233246
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 14:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgG3Md4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 08:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3Md4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 08:33:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B1FC061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 05:33:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k17kw-00DWH8-90; Thu, 30 Jul 2020 14:33:54 +0200
Message-ID: <62c74ddba571af59b2aeba116ff78ecc3b9b9710.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211:  Fix kernel hang on ax200 firmware crash.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 14:33:53 +0200
In-Reply-To: <20200610204017.4531-1-greearb@candelatech.com> (sfid-20200610_224247_926019_7174DFE4)
References: <20200610204017.4531-1-greearb@candelatech.com>
         (sfid-20200610_224247_926019_7174DFE4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-06-10 at 13:40 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> I backported out-of-tree ax200 driver from backport-iwlwifi to my
> 5.4 kernel so that I could run ax200 beside other radios (backports
> mac80211 otherwise is incompatible and other drivers will crash).
> 
> Always possible that upstream kernel doesn't suffer from exactly this
> case, but upstream ax200 is too unstable to even get this far, so...
> 
> The ax200 firmware crash often causes the kernel to deadlock due to the
> while (sta->sta_state == IEEE80211_STA_AUTHORIZED)
> loop in __sta_info_Destroy_part.  If sta_info_move_state does not
> make progress, then it will loop forever.  In my case, sta_info_move_state
> fails due to the sdata-in-driver check.

Interesting. I don't think I've seen this in our testing before.

> iwlwifi 0000:12:00.0: dma_pool_destroy iwlwifi:bc, 00000000d859bd4c busy

Ugh, yeah, as an aside - we still leak stuff there... need to dig into
that.

> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  net/mac80211/sta_info.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
> index e2a04fc..31a3856 100644
> --- a/net/mac80211/sta_info.c
> +++ b/net/mac80211/sta_info.c
> @@ -1092,6 +1092,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
>  	struct ieee80211_sub_if_data *sdata = sta->sdata;
>  	struct station_info *sinfo;
>  	int ret;
> +	int count = 0;
>  
>  	/*
>  	 * NOTE: This assumes at least synchronize_net() was done
> @@ -1104,6 +1105,13 @@ static void __sta_info_destroy_part2(struct sta_info *sta)
>  	while (sta->sta_state == IEEE80211_STA_AUTHORIZED) {
>  		ret = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
>  		WARN_ON_ONCE(ret);
> +		if (++count > 1000) {
> +			/* WTF, bail out so that at least we don't hang the system. */
> +			sdata_err(sdata, "Could not move state after 1000 tries, ret: %d  state: %d\n",
> +				  ret, sta->sta_state);
> +			WARN_ON_ONCE(1);
> +			break;
> +		}

I guess that should be

if (WARN_ON_ONCE()) ...


etc.

>  		int err = drv_sta_state(sta->local, sta->sdata, sta,
>  					sta->sta_state, new_state);
> -		if (err)
> -			return err;
> +		if (err == -EIO) {
> +			/* Sdata-not-in-driver, we are out of sync, but probably
> +			 * best to carry on instead of bailing here, at least maybe
> +			 * we can clean this up.
> +			 */

It _could_ be the driver itself returning -EIO, so why not check the
sdata-in-driver flag?


Anyway, that mostly looks good and would make mac80211 more robust, but
like I just said in the other patch I think you need to consider
mac80211 changes more from mac80211's POV, not from an arbitrary
driver's POV.

Really here that mostly applies to the commit log, which should probably
say something like

	mac80211: deadlock due to driver misbehaviour

or so, and then go on to explain what it does in *mac80211*, and show
the iwlwifi parts only as an *example*.

Thanks,
johannes

