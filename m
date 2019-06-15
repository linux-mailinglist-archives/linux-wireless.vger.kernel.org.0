Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB48C46FD9
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 14:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfFOMGl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 08:06:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42717 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfFOMGl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 08:06:41 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so11527746ior.9
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2019 05:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBH04N+Oo+lXe+lOBJbxzQQ4w3sFgjWEUql4acbbqG4=;
        b=o7tT/5BBSdw1FPd8ZOWTTzN5SrOza99GHSJ9j4acdbBgmbIPENhPok8gQsfupx30Ua
         A9qbrHBqlvCDrGFTXbSg3+eT6LAeritrBpsB9pfkEOTOJ6T9LxvTy9J3iW4yhuc7IB/i
         zmiEuX1/lgZle5g6SqTSIyecyEKTh8XvdAqhSFsgrUuQO4eYQFQwU2m11tkOQPfGqca8
         ZBcsRVhkYHWlkcGeCiyOA6qbsrsXNm5s6/KXXBD4LcfX1cpGuV/I/zZAdEy46rbtn9i4
         A+da9arn9Rv6ax0VBtiUhi82k0uCPypDe+6m/FsJZLJIu5Aj4tSS8PAXVKXwTML5Y/fI
         HNWg==
X-Gm-Message-State: APjAAAUibnf+HkYjcUNx5y/zbfp2SfalhFenfZ9g8RCMES9qX8yxskm8
        GE0vHXjjXAj1BOyP5DgU7obu/AFh8OgjBzAzMgLSBg==
X-Google-Smtp-Source: APXvYqzcB/AcApeA3AhPen19fHbvlQrV7TDlPOrqP8u4sy0ArR1WqCcG7GgYgIgKfMbDuwdi1pdkdYMKOdGaQXrYaZg=
X-Received: by 2002:a02:ccd2:: with SMTP id k18mr21169672jaq.3.1560600400378;
 Sat, 15 Jun 2019 05:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560461404.git.lorenzo@kernel.org> <66fc02e45fb5ce0d6176395b5ac43acbd53b3e66.1560461404.git.lorenzo@kernel.org>
 <20190614072449.GA3395@redhat.com> <20190614101115.GA2669@localhost.localdomain>
 <a50de3e52ece8a636ae902b1a5b901d0d3cd068f.camel@sipsolutions.net> <20190614113120.GC17298@redhat.com>
In-Reply-To: <20190614113120.GC17298@redhat.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 15 Jun 2019 14:06:29 +0200
Message-ID: <CAJ0CqmX00=d8BsoOfXQdxsh2JXha-d-F6+wAUQCgEYXs=4Z8Eg@mail.gmail.com>
Subject: Re: [PATCH v3 wireless-drivers 1/3] mt76: usb: fix rx A-MSDU support
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On Fri, Jun 14, 2019 at 12:20:59PM +0200, Johannes Berg wrote:
> > On Fri, 2019-06-14 at 12:11 +0200, Lorenzo Bianconi wrote:
> >
> > > Looking at __ieee80211_amsdu_copy() now I got why other drivers copy hdrlen +
> > > 8, thx :)
> > > In our case reuse_frag is true in __ieee80211_amsdu_copy, so we will end up
> > > copying 32B + ether_len. Anyway I think 32 is a little bit too low and we could get
> > > better performances increasing it a little bit.
> > > A typical use case (e.g IPv6 + TCP):
> > >
> > > IPv6 = 40B, TCP = 32B --> so 72B..I guess 128B is a good value :)
> > > @Felix, Johannes: what do you think?
> >
> > I think while we might *allocate* more, I don't think we should *copy*
> > more, since then the TCP payload will no longer be in pages.
> >
> > It'd probably be better to implement leaving enough tailroom (allocate
> > 128), but copying nothing, unless the *entire* packet fits.
>
> iwl4965 put entire packet in fragment in il4965_pass_packet_to_mac80211() .
> Initially I thought this is a bug, since mac80211 require header be
> in the linear area, but looks like ieee80211_rx_monitor() copy header
> before rest of mac80211 check it, so 4965 is fine.
>
> Anyway I think the driver should put ieee80211 header in linear area
> and iwlwifi & mt7601u implementation is somewhat optimal.

Actually the case is a little bit different for mt76 since we need
even mt76x02_rxwi in the linear area of the received skb.
Taking that into account the requested size to copy will be:
32 + 802.11 hdr + SNAP hdr  = ~ 70B
Moreover to pass rxwi size to usb module we need to add a field in
mt76_driver_ops (e.g rxwi_size).
I will carry out some tests and if there are no differences I will
post a single patch to wireless-drivers using 128B as default size

Regards,
Lorenzo

>
> Stanislaw
