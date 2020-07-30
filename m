Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED7023313B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgG3Lsw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 07:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgG3Lsv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 07:48:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73B9C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 04:48:51 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k173I-00DV6g-UU; Thu, 30 Jul 2020 13:48:49 +0200
Message-ID: <a3a6a9303eeaf91f83bcbc413ad0782659218966.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: do not iterate active interfaces when in
 re-configure
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 13:48:43 +0200
In-Reply-To: <20200525165317.2269-1-greearb@candelatech.com> (sfid-20200525_185328_305694_D3007257)
References: <20200525165317.2269-1-greearb@candelatech.com>
         (sfid-20200525_185328_305694_D3007257)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-05-25 at 09:53 -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> This appears to fix a problem where ath10k firmware would crash,


"appears to", heh

Really though, in general, you need to start thinking about mac80211 and
the drivers as two separate things. You've also submitted another patch
where you say "this iwlwifi thing requires mac80211 to change", and here
you're submitting a patch saying "this ath10k thing requires mac80211 to
change", but I don't see you considering much the fact that mac80211 is
actually used for both.

It'd be good to have a discussion of such things in the commit log for
changes that will affect multiple drivers, rather than focusing on a
single bug for a single driver. In general, not just in this patch.

> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 5db2cd0..186a696 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -831,7 +831,7 @@ static void __iterate_interfaces(struct ieee80211_local *local,
>  			break;
>  		}
>  		if (!(iter_flags & IEEE80211_IFACE_ITER_RESUME_ALL) &&
> -		    active_only && !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
> +		    (active_only && (local->in_reconfig || !(sdata->flags & IEEE80211_SDATA_IN_DRIVER))))
>  			continue;

Anyway, this seems wrong to me. If anything, it should skip those
interfaces that weren't re-added yet, but not all of them. I'm pretty
sure this would cause iwlwifi to misbehave with multiple interfaces, as
it sometimes relies on iterating to understand what else is going on
before configuring something.

It might even be that this can only be done subject to driver choice.

johannes

