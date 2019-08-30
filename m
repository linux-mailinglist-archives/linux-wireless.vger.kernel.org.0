Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BAA34AC
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfH3KO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 06:14:58 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34270 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3KO6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 06:14:58 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3dvi-0003UB-QJ; Fri, 30 Aug 2019 12:14:55 +0200
Message-ID: <2eb256e8a7be09f35dc4f0f3b61e0363691f41f0.camel@sipsolutions.net>
Subject: Re: [RFCv2 4/4] nl80211: Send large new_wiphy events
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 12:14:53 +0200
In-Reply-To: <20190816192703.12445-4-denkenz@gmail.com> (sfid-20190816_212731_253959_D0B83E63)
References: <20190816192703.12445-1-denkenz@gmail.com>
         <20190816192703.12445-4-denkenz@gmail.com>
         (sfid-20190816_212731_253959_D0B83E63)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-08-16 at 14:27 -0500, Denis Kenzior wrote:
> Send large NEW_WIPHY events on a new multicast group so that clients
> that can accept larger messages do not need to round-trip to the kernel
> and perform extra filtered wiphy dumps.
> 
> A new multicast group is introduced and the large message is sent before
> the legacy message.  This way clients that listen on both multicast
> groups can ignore duplicate legacy messages if needed.

Since I just did the digging, it seems that this would affect (old)
applications with libnl up to 3.2.22, unless they changed the default
recvmsg() buffer size.

I think this is a pretty decent approach, but I'm slightly worried about
hitting the new limits (16k) eventually. It seems far off now, but who
knows what kind of data we'll add. HE is (and likely will be) adding
quite a bit since it has everything for each interface type - something
drivers have for the most part not implemented yet. That trend will only
continue, as complexity in the spec doesn't seem to be going down.

And I don't really want to see "config3" a couple of years down the
road...

So can we at least mandate (document) that "config2" basically has no
message limit, and you will use MSG_PEEK/handle MSG_TRUNC with it?

That way, we can later bump the 8192 even beyond 16k if needed, and not
run into problems.

> +       if (cmd == NL80211_CMD_NEW_WIPHY) {
> +               state.large_message = true;
> +               alloc_size = 8192UL;
> +       } else
> +               alloc_size = NLMSG_DEFAULT_SIZE;
> +

nit: there should be braces on both branches

> +       if (nl80211_send_wiphy(rdev, cmd, msg, 0, 0, 0, &state) < 0) {
> +               nlmsg_free(msg);
> +               goto legacy;
> +       }

I think that'd be worth a WARN_ON(), it should never happen that you
actually run out of space, it means that the above wasn't big enough.

Now, on the previous patches I actually thought that you could set
"state->split" (and you should) and not need "state->large_message" in
order to indicate that the sub-functions are allowed to create larger
data - just keep filling the SKBs as much as possible for the dump.

Here, it seems like we do need it. It might be possible to get away
without it (by setting split here, and then having some special code to
handle the case of it not getting to the end), but that doesn't seem
worth it.

> @@ -14763,6 +14787,8 @@ void nl80211_notify_iface(struct cfg80211_registered_device *rdev,
>                 return;
>         }
>  
> +       genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
> +                               NL80211_MCGRP_CONFIG2, GFP_KERNEL);

Hmm. That seems only needed if you don't want to listen on "config" at
all, but in the patch description you explicitly said that you send it
on "config2" *before* "config" for compatibility reasons (which makes
sense) - so what is it?

I'm having a hard time seeing anyone get away with only listening on
config2 since that'd basically require very recent (as of now future)
kernel. Are you planning this for a world where you can ditch support
for kernel<5.4 (or so)?

johannes

