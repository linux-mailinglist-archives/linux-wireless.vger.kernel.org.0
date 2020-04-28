Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536941BC523
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgD1Q1c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgD1Q1c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 12:27:32 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17621C03C1AB
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 09:27:32 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s10so20974894iln.11
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NRWQt4RmEprZLai1URR8anUH/rgZmOn/c5Yd6vXzGBE=;
        b=eoCwyvX7bhuw4DxLbV4AVuNE13++SdRI5UPUYDg0BcLShXzKazf1ZeZCZwaf5zD4j7
         5rJpg7b+dAPd3gcIFpZnoF612AIGgxlOXCkoa5b2hFH+urDyoYn0flgi1QwImkJcoCJM
         IR5hnUiMzGPuRXBuDN1dD96n7BAVj60wJ+Lo6Ez1FX0OOGEjOAYCMvstF/YFPHIh3cHR
         n1a4ddFUzE9A2TOq1x9d08+w/SPbvKjU7q4iiS6WOFu7zoTZucLLg6IrcS4PPxjCKzb8
         W5KISa92d0/71pFi04Z7SqfupBMOQYBXquwEYwAKyK/ykWGgtvkJrmvyeIrMQ7MU9Ekh
         gjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NRWQt4RmEprZLai1URR8anUH/rgZmOn/c5Yd6vXzGBE=;
        b=Qmsbifxng51uBYS750SrghQyn7rOprrT9u+yU1mBmjb74PsBT2rgQalgO//fA+tCTX
         pkS2NJ97tAezBmWz0g9d2JEmPmhjuRKw6EH80HMH8oY+YVYG2fvF7mYkWhyFsACtrI1b
         IYNS5WWNRix7P+wofmJDLT3AXM4Omp7LbRF7w0Lac0s0v0nI1xSML6EIMFBSY1c3ACPA
         bxtpYJaP76lJFj3xjJ5YbR7Ca1vhUWe0abPlyAj2+ZA7GVSoH6gva4WjW6CnGYhYx6hF
         RrIfNikQoZVBSg+tGNQgqCY3ThK4cnWvHLnA9gCmyKlLrDVRGc9T7gFu0ikKiXhFcS7C
         A4NQ==
X-Gm-Message-State: AGi0PuYKpTAuxmHDx2NUXHpmRE3ZNxqC1NxBx09pkeqojJJCqVEbp03O
        3BvrCeWLVkdeKPVA7sw1m/NXn6TpCIgk4DzfTjY=
X-Google-Smtp-Source: APiQypIIKHpSMKowlpCo5rDDT2lXJcVs5FO9u+wLobQWtW3DmOHQXYqzd0rTCv0V4vC20ko8JHQkV6qVEj6gdGFQjeE=
X-Received: by 2002:a92:c7a9:: with SMTP id f9mr28422102ilk.0.1588091251379;
 Tue, 28 Apr 2020 09:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200427145435.13151-1-greearb@candelatech.com> <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com>
In-Reply-To: <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Tue, 28 Apr 2020 09:27:19 -0700
Message-ID: <CAA93jw5tcptB64B8nGH0hqr4xC9G2SXNjp2tPf3YK5R7t6ZjXw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     Steve deRosier <derosier@gmail.com>
Cc:     Ben Greear <greearb@candelatech.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 7:56 AM Steve deRosier <derosier@gmail.com> wrote:
>
> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
> >
> > From: Ben Greear <greearb@candelatech.com>
> >
> > While running tcp upload + download tests with ~200
> > concurrent TCP streams, 1-2 processes, and 30 station
> > vdevs, I noticed that the __ieee80211_stop_queue was taking
> > around 20% of the CPU according to perf-top, which other locking
> > taking an additional ~15%.
> >
> > I believe the issue is that the ath10k driver would unlock the
> > txqueue when a single frame could be transmitted, instead of
> > waiting for a low water mark.
> >
> > So, this patch adds a low-water mark that is 1/4 of the total
> > tx buffers allowed.
> >
> > This appears to resolve the performance problem that I saw.
> >
> > Tested with recent wave-1 ath10k-ct firmware.
> >
>
> Hey Ben,
>
> Did you do any testing with this patch around latency?  The nature of
> the thing that you fixed makes me wonder if it was intentional with
> respect to making WiFi fast - ie getting rid of buffers as much as
> possible.  Obviously the CPU impact is likely to be an unintended
> consequence. In any case, I don't know anything for sure, it was just
> a thought that went through my head when reading this.

I note that I'd prefer a BQL-like high/low watermark approach in
general... bytes, not packets, or better, perceived
airtime in a revision of AQL...

... but we'll try this patch, thx!

>
> > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > ---
> >  drivers/net/wireless/ath/ath10k/htt.h    | 1 +
> >  drivers/net/wireless/ath/ath10k/htt_tx.c | 8 ++++++--
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/htt.h b/drivers/net/wirele=
ss/ath/ath10k/htt.h
> > index 31c4ddbf45cb..b5634781c0dc 100644
> > --- a/drivers/net/wireless/ath/ath10k/htt.h
> > +++ b/drivers/net/wireless/ath/ath10k/htt.h
> > @@ -1941,6 +1941,7 @@ struct ath10k_htt {
> >
> >         u8 target_version_major;
> >         u8 target_version_minor;
> > +       bool needs_unlock;
> >         struct completion target_version_received;
> >         u8 max_num_amsdu;
> >         u8 max_num_ampdu;
> > diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wir=
eless/ath/ath10k/htt_tx.c
> > index 9b3c3b080e92..44795d9a7c0c 100644
> > --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> > +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> > @@ -145,8 +145,10 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *=
htt)
> >         lockdep_assert_held(&htt->tx_lock);
> >
> >         htt->num_pending_tx--;
> > -       if (htt->num_pending_tx =3D=3D htt->max_num_pending_tx - 1)
> > +       if ((htt->num_pending_tx <=3D (htt->max_num_pending_tx / 4)) &&=
 htt->needs_unlock) {
> > +               htt->needs_unlock =3D false;
> >                 ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
> > +       }
> >  }
> >
> >  int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
> > @@ -157,8 +159,10 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *h=
tt)
> >                 return -EBUSY;
> >
> >         htt->num_pending_tx++;
> > -       if (htt->num_pending_tx =3D=3D htt->max_num_pending_tx)
> > +       if (htt->num_pending_tx =3D=3D htt->max_num_pending_tx) {
> > +               htt->needs_unlock =3D true;
> >                 ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
> > +       }
> >
> >         return 0;
> >  }
> > --
> > 2.20.1
> >



--=20
Make Music, Not War

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-435-0729
