Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9852BBBA3
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Nov 2020 02:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgKUBnt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 20:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgKUBns (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 20:43:48 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8611C0613CF
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 17:43:48 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 92so7511830otd.5
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtxx31dFzQGQacf5dTvnj71JjDjHnsR2VLin6Yo8L9U=;
        b=CEJuvVvRB4YSJKMk+QIXF3OW3AZ03qI6Ht7lGJA/2YEGpQWEMs+p0Y9DUVQmI0sEgk
         3CWhUzhtCtQBGGrAnABUuscWi7qY1XSXGkA8kqvNdSFyR/FwGm0hmApz68tzP4/ZeHaz
         C9BKyA8kwWvwXaVN/D7erKCah0RZFemfOOXxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtxx31dFzQGQacf5dTvnj71JjDjHnsR2VLin6Yo8L9U=;
        b=OOXzbnCH8vHy81jYwUCnUvSoQwMnpc+Q+IK4wuUsyfCCHJMTV/u0SY16Iak29D5cMR
         ODJS34DH7mkHLAEb7kpPesTEJmYH12XgmH5ThGBe0/RVxSoLli+WZNe3+MWTQVWTPh9o
         cmynuJDIwv6FGYY3AjCLgeqHBwpA6QgWBncHP1p+VbEyi7jXvxXOEyiQj5beXx0/oKVB
         6isqRUFDp1yNWtH5XKYkm0bQavk1qGOPLLBiItezAizcqzTw7BLc9QgAtSjYPdZgg+6l
         V6hcPGD5BPQ/tDEYhCOWTAf/5CUZlfAwTujDncYWbEt3j4ETv7wuLEeHzt9cd31u5ryU
         Kk/A==
X-Gm-Message-State: AOAM530kTO5aoAnBmsbcnpC78tOyYHjh1128fv8NmJLtJkb4zNxfNYvF
        g3cFadjumBs35LPgzFHuyYel6xdZK3Y1eQ==
X-Google-Smtp-Source: ABdhPJznDKu0qlAwQpXKoirCIseEo3Bi9vNKDlRHhg6+dSqSSXyrJ+PBq3/59rL7mgv8OM6YK7opIw==
X-Received: by 2002:a9d:7d14:: with SMTP id v20mr15061714otn.106.1605923027778;
        Fri, 20 Nov 2020 17:43:47 -0800 (PST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id k1sm2211129otn.25.2020.11.20.17.43.46
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 17:43:46 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id f11so12683535oij.6
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 17:43:46 -0800 (PST)
X-Received: by 2002:aca:1c17:: with SMTP id c23mr8463977oic.117.1605923025590;
 Fri, 20 Nov 2020 17:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20200625201857.almm27xgzburyxxu@wololo.home.arpa>
 <3d8546b66a4f2027a7fab1de291ec40f@adapt-ip.com> <e42b0d0e87b2461a9b023e432635e6a6@realtek.com>
In-Reply-To: <e42b0d0e87b2461a9b023e432635e6a6@realtek.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 20 Nov 2020 17:43:31 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOPvnxZu7H2A8y-ApAVBOyK4vi7x7bTN0iF9SJe6qCU8g@mail.gmail.com>
Message-ID: <CA+ASDXOPvnxZu7H2A8y-ApAVBOyK4vi7x7bTN0iF9SJe6qCU8g@mail.gmail.com>
Subject: Re: [PATCH] rtw88: fix skb_under_panic in tx path
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Nick Owens <mischief@offblast.org>
Cc:     Thomas Pedersen <thomas@adapt-ip.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Swapping out Yen-Hsuan's new email)

Necromancing an old thread, since it's still relevant, and I had it
sitting in my inbox to deal with. Now I have something useful to say!

On Mon, Jun 29, 2020 at 11:50 AM Tony Chuang <yhchuang@realtek.com> wrote:
> > On 2020-06-25 13:18, Nick Owens wrote:

> > > fixes the following panic on my thinkpad A485
> > >
> > > Oops#1 Part3
> > > <0>[ 3743.881656] skbuff: skb_under_panic: text:000000005f69fd98
> > > len:208 put:48 head:000000009e2719e8 data:00000000bd3795e0 tail:0xc2
> > > end:0x2c0 dev:wlp2s0
...
> > skb->head and skb->data here are really far (0.5GB) apart. Maybe
> > skb->data actually got corrupted earlier?

For the record, I've reproduced similar issues myself, and the problem
occurs when
(a) the initial SKB starts with minimal headroom (I find that many
SKBs come into mac80211 with plenty of headroom)
(b) the SKB participates in AMSDU aggregation
I've spotted a specific bug, which I'll point out below. But I remain
confused why in many cases the SKB ends up looking so corrupted.

...
> > If it is a headroom issue, you can actually express the needed headroom
> > needed by the driver in hw->extra_tx_headroom during init and avoid the
> > pskb_expand_head() here.
>
> Looks like a headroom issue, but the driver already assigned headroom.
>         max_tx_headroom = rtwdev->chip->tx_pkt_desc_sz;
>         hw->extra_tx_headroom = max_tx_headroom;
>
> Then I am not sure why this happens. Nick, can you help to dump_stack()
> so we can see where is the skb from?

That's not so easy, because of the layers and queueing involved, but
per the above, I've blamed mac80211's AMSDU aggregation. Specifically:

ieee80211_amsdu_aggregate() -> ieee80211_amsdu_prepare_head(), where
we pad out / expand the SKB to fit some additional AMSDU headers (and
later append additional data). But the padding function
(ieee80211_amsdu_realloc_pad()) accounts only for the 802.11 protocol
headroom, and not for the driver-specific headroom. So it chooses not
to expand the headroom, and instead eats into rtw88's space.

For such SKBs, they end up in the driver without sufficient headroom
-- thus, Nick's bug report.

NB: the seemingly-obvious fix (changing the headroom checks in
ieee80211_amsdu_realloc_pad()) does not seem to work, as I hit other
bugs along the way. Unfortunately, I haven't had the time to fix this
all myself properly, nor have I convinced Realtek to fix this
themselves. So in the meantime, Chrome OS is running with this:

https://chromium.googlesource.com/chromiumos/third_party/kernel/+/260a7d4939c323aebe80efc73610682ad2cb187a%5E%21/#F0

It's a similar idea.

We should of course fix the mac80211 bug, but I wonder if we also
deserve some patch similar to either the Chromium patch or Nick's
somewhere (perhaps with a loud warning, etc.), because it's much more
user friendly (in the face of similar future bugs) to do some
suboptimal memcpy()'s, etc., than to crash their systems

Brian
