Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48A22D4C18
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 21:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgLIUlC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 15:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgLIUlC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 15:41:02 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62370C0613CF;
        Wed,  9 Dec 2020 12:40:22 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id w18so1635630vsk.12;
        Wed, 09 Dec 2020 12:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVNbsG951grAa0nngTk546R3mqEcKdjGCQfl3jglux0=;
        b=tsEHJhG0MkjRSVhOuGlMI9bocHZIgrB7Q4F3SNPCijIGdImGYy9q0X6kIOcVmW7rRU
         83vq6mTuCwIAaqAHvB4BTx+irBq3DhKLBB/4H7y6TYyL4dy1SU13CdZjMyeV+G8kJ89i
         zMCkH/O6Ojuzd4Eg9vheu5ibeIamHEOl8VsehZ9sGmc9McbVOnMClj6ZUhFA+fmGLpQS
         iOONj9fNvlaP6lycp3I7m4DBKOrCjQWl+ufNy2dHnZcB6C58Yi8bCHLacBk/LIvzfvBj
         Py9UQOiW0sPnwl17sbKkQRlS1AzsBAPWT5OPIIxq5moGxHlrQW3fl4XFgGMC+SGHxqbZ
         36mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVNbsG951grAa0nngTk546R3mqEcKdjGCQfl3jglux0=;
        b=KMlze6bUkxVid1uN5DqH3cwXH7f1ANL/v7SikpoZbmot1hcYziUUSvyuqFQeVmVX71
         8Arpoj0s1sUo4lgPWJ7ypS3sSbtX51nvz7bKQ5WMxUoJVCV6m6SrI3plL+BVwOinWHuS
         gSWXz2jOjaMUreLyGpCw4iQjLUEJET41CQYn10rz//3lX1CK/KjKEV+lXg9yfMo/qQdN
         IDjGC7JM6MF3TM9bWpfVxy+RqISGyA1ITRmeyCyonKVJtlvEcI8Y1DSs8Zl3h6vuoxvj
         Rze2ZG70l2+e9tZMDRJZSsQxB5/pvQaiSFFQfmX5mmG/TpxTgX2ogMYde7TWeO4Ka0At
         LRyA==
X-Gm-Message-State: AOAM533ulgwkHjEPFfcqSRQ9wx2VzL+vqk5nhNd8BXSbEsCjz5haZB5N
        6zKFRCtYsgZaj9/axaVi2/d2ViH/0DamHrafErI=
X-Google-Smtp-Source: ABdhPJyqjMVe8NitGvgS1YWJWfuzp2U4pAPXcbQPYhNjW+c3+yy3hA1aaS6r3ue8GgWP+vsAf0HNZ4DBfYmvfFlKRVI=
X-Received: by 2002:a67:eb88:: with SMTP id e8mr4214547vso.28.1607546421585;
 Wed, 09 Dec 2020 12:40:21 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZZZVqnoV4YFTDHogVHv77=dKfcSSBGj1zC83zpUid9+g@mail.gmail.com>
 <4eb99a1da6342999c4dca355533a0847d0e942a5.camel@intel.com>
 <CALjTZvYwccfOVTTGNo1=oLnwXG2b9Vz1nVZuvLKFV94+3fQ6EQ@mail.gmail.com>
 <20201209091315.2c55e1c6@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com> <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
In-Reply-To: <CANUX_P1=yuPkK5BzJ99oniMiCgB0z98yNYUSw4_qk2Vg7ucoRQ@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 9 Dec 2020 22:40:10 +0200
Message-ID: <CANUX_P3S-Dt2homERtXgxQuh+q=xCTDvqx2ZwOXvZfjMrBY-9w@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: card unusable after firmware crash
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 9, 2020 at 10:32 PM Emmanuel Grumbach <egrumbach@gmail.com> wrote:
>
> On Wed, Dec 9, 2020 at 7:19 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Tue, 8 Dec 2020 23:17:48 +0000 Rui Salvaterra wrote:
> > > Hi, Luca,
> > >
> > > On Tue, 8 Dec 2020 at 16:27, Coelho, Luciano <luciano.coelho@intel.com> wrote:
> > > > On Tue, 2020-12-08 at 11:27 +0000, Rui Salvaterra wrote:
> > > > >
> > > > > [ 3174.003910] iwlwifi 0000:02:00.0: RF_KILL bit toggled to disable radio.
> > > > > [ 3174.003913] iwlwifi 0000:02:00.0: reporting RF_KILL (radio disabled)
> > > >
> > > > It looks like your machine is reporting RF-Kill to the WiFi device.
> > >
> > > Yes, that's an artifact of how I tested: I rebooted the router, the
> > > Wi-Fi interface disassociated and the dmesg was clean. However, after
> > > the router came up, the laptop didn't reconnect (and the connection
> > > had completely disappeared from nmtui). Afterwards, I did the rfkill
> > > cycle you see, and only then I got the register dump.
> > >
> > > > There seems to be some sort of race there that is causing us to still
> > > > try to communicate with the device (and thus you see the transaction
> > > > failed dump), but that will obviously fail when RF-Kill is enabled.
> > >
> > > I'm not sure about that, the card was already dead before the rfkill cycle.
> >
> > Any luck figuring this out, Luca? If this is a 5.10 regression we need
> > to let Linus know tomorrow, so the time is ticking :(
>
> Rui, I looked at the register dump and looks like you're using AMT on
> your system?
> Can you confirm?

Besides, don't you get a stack dump in the vicinity of this register
dump? That's be helpful to see.
