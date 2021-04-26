Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817E336B9E8
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Apr 2021 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbhDZTUk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239804AbhDZTUk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 15:20:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E09C061574;
        Mon, 26 Apr 2021 12:19:58 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lb6lq-000MBH-5V; Mon, 26 Apr 2021 21:19:50 +0200
Message-ID: <6e1052a5506acb0c5ba3b4954f199ee0c494c1c3.camel@sipsolutions.net>
Subject: Re: [BISECTED] 5.12 hangs at reboot
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Mon, 26 Apr 2021 21:19:49 +0200
In-Reply-To: <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
         <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-04-26 at 18:59 +0000, Linus Torvalds wrote:
> On Mon, Apr 26, 2021 at 11:47 AM Harald Arnesen <harald@skogtun.org> wrote:
> > 
> > Bisected to commit 776a39b8196dbca4afb69669db0d9926ffac29ab, and
> > reverting this makes the machine reboot as usual.
> 
> Hmm. That was already in rc1, so this isn't some late untested
> last-minute commit that broke things for you.

At least _that_ isn't, could be some other change elsewhere triggered
it? OTOH, then bisect should've landed there, and not on this, since
this came in early and merges with other stuff would've happened later.
So ...

> Which implies that it's likely something fairly specific to  your
> setup (either the config or the hardware - or possibly Void Linux
> doing something other distros don't).

Probably hardware (well, driver), cfg80211_destroy_ifaces() calls into
the driver.

Which wireless driver are you using? Looking at all of the ones in 5.12,
I see that
 * ath6kl obviously deadlocks immediately regardless of this change
   (Kalle, ISTR pointing this out to you a long time ago while I was
   developing the locking changes here?).
 * wil6210 is broken if you use P2P, and I can only blame myself for
   that, will send a fix; maybe that's the difference in your distro?
   But I think P2P on 60 GHz is not used much.
 * brcmfmac looks a bit fishy, but that seems unrelated to my code, I'll
   send an RFC patch to see what's that really doing
 * staging/rtl8723bs also looks bad, and needs to use
   cfg80211_unregister_netdevice() instead of just
   unregister_netdevice(), I'll also send a patch.

The others look fine. Not sure why I didn't see this before, I went over
it with a fine comb back then ... sorry.

Are you using one of the above?

The other special thing might be that you're actually explicitly
deleting (virtual) wireless interfaces, which isn't *that* common,
though of course not really uncommon either.

> Mind also attaching a dmesg of an affected kernel (or with the revert
> in place, I guess - it shouldn't matter until the reboot ;)
> 
> There's a lockdep assertion there, but you don't seem to have lockdep
> enabled. So it be interesting to see what happens if you
> 
>  (a) enable lockdep
> 
>  (b) make sure to reboot in text mode so that any lockdep messages
> would actually be visible.
> 
> Maybe Johannes will go "Doh!" and see what's wrong.

Almost certainly will :)

And here I was so happy that this survived from rc1 until the release
with just a handful of issues ;-)

Thanks!

johannes

