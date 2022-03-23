Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC804E5316
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 14:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiCWNZf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 09:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiCWNZd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 09:25:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF77E32076
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=WeV7CdyKrCQzTXSqea1mXx13HfQbhrkZpQJIED/eVxc=;
        t=1648041842; x=1649251442; b=MxUXY1/1LmFNren+DgO4Hb004K+vAkMPdV/kePRAbpgL0KT
        90xTUf9JG2NYwA9YTgJzG1TqVymLO4s5fgXxXPMdhX5RD6I8JF9LXeRXGnQqdFHmyD54yt+PFDWFB
        5k7r+KyWjqYfePiEh2RM0Z0XmMYc5rWi2uWCYazNBWV7ZH1X0xt7phEvq/I6dlRw0B32u4EzfgpDL
        c4MXraJTbxkDfOP99mHUyFo6UzVDt3GG+2QEjhQf28BIkYU1lttHkup3Hv6fHvgVyVH7ZZpcz3TpG
        xmdd/00EGs3siGbuGnigxX4x/0Ai0VYYXlRQ5VfR9MjzGBwpKxeGVofbaSFdRnnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nX0xz-00H64Q-9y;
        Wed, 23 Mar 2022 14:23:59 +0100
Message-ID: <acb77f59a5e6488b54197cd89a3c1f4f8f5ec585.camel@sipsolutions.net>
Subject: Re: netconsole fail, iwlwifi, WARNING: at net/mac80211/tx.c:3638
 ieee80211_tx_dequeue
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 23 Mar 2022 14:23:58 +0100
In-Reply-To: <CAJCQCtQa+zpHHMsaAq2MYsdZ1bDTfZNyPBgi2Y1hs9OgWxihaw@mail.gmail.com>
References: <CAJCQCtQsvWMzVPDdLeGOwMWtZgfS3qLvFkPOtUbuFT640emW4w@mail.gmail.com>
         <CAJCQCtQa+zpHHMsaAq2MYsdZ1bDTfZNyPBgi2Y1hs9OgWxihaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-02-16 at 20:44 -0700, Chris Murphy wrote:
> So this is quite a bit more verbose with kernel
> 5.17.0-0.rc4.96.fc36.x86_64+debug.
> 
> Is netconsole expected to work from a host with wifi?

Let's say it seems pretty audacious to try? There's a huge stack between
the hardware and the network (MAC service) interface...

We might sometimes even need to do memory allocations to send out a
frame, or touch other hardware (e.g. crypto engines if crypto is not in
wifi HW) etc.

We also didn't really expect to  be called from interrupts-disabled
contexts here.

> [ 4970.929723] kernel: WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
> [ 4970.929726] kernel: 5.17.0-0.rc4.96.fc36.x86_64+debug #1 Tainted: G       W        --------- ---
> [ 4970.929728] kernel: -----------------------------------------------------
> [ 4970.929729] kernel: modprobe/8230 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
> [ 4970.929734] kernel: ffff953c499b9070 (&fq->lock){+.-.}-{2:2}, at: ieee80211_xmit_fast+0x412/0xb90 [mac80211]
> [ 4970.929823] kernel:
>                        and this task is already holding:
> [ 4970.929824] kernel: ffffffffc1504618 (target_list_lock){....}-{2:2}, at: write_msg+0x48/0xf0 [netconsole]
> [ 4970.929834] kernel: which would create a new lock dependency:
> [ 4970.929835] kernel:  (target_list_lock){....}-{2:2} -> (&fq->lock){+.-.}-{2:2}
> [ 4970.929840] kernel:
>                        but this new dependency connects a HARDIRQ-irq-safe lock:
> [ 4970.929841] kernel:  (&ec->lock){-.-.}-{2:2}
> [ 4970.929842] kernel:
>                        ... which became HARDIRQ-irq-safe at:
> 
[...]
> [ 4970.930019] kernel:
>                        to a HARDIRQ-irq-unsafe lock:
> [ 4970.930020] kernel:  (&fq->lock){+.-.}-{2:2}
> [ 4970.930022] kernel:
>                        ... which became HARDIRQ-irq-unsafe at:
> [ 4970.930023] kernel: ...
> [ 4970.930024] kernel:   lock_acquire+0xd0/0x2d0
> [ 4970.930027] kernel:   _raw_spin_lock_bh+0x38/0x80
> [ 4970.930030] kernel:   ieee80211_get_txq_stats+0x49/0x190 [mac80211]
[...]

which is pretty much what it's telling us here, I suppose, just in a bit
more roundabout way.

Unfortunately, I don't think we can really support that - there's so
much code below ... We'd have to make *everything* IRQ safe here?

johannes
