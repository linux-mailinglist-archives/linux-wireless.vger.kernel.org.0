Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9F1BC633
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2020 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgD1RKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Apr 2020 13:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgD1RKs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Apr 2020 13:10:48 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922AC03C1AB
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 10:10:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id s10so21192480iln.11
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2020 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wWnZWc2eIL5m4prB0tQSVe9ACu/1Y9skaMpnFim491o=;
        b=bB4KYtRfxr9FzpWQRm0TNW1208Smkh4d62Jr6+w7oIdOwI4RCn1SngORdP3cQ600ho
         YnzmMilUMTCSM+hrytDR5G5WVeXQsxGjyyUQiiJycEbWxBQ0tcFqmnjd14BkpVj2vFi/
         8+mFtgjUecwVWu/ThM9+WxPk2XgVIxjMigT7uskL8giD22zmKhZFgXvK3lf/tVKmGhRk
         P9D8o0eQZV5x40Y+EhqLQZMIxsKZWGW+f8P3OH+aGzH4YKzjivuTTFrH8RUA+tzc1LvN
         a6euuQcEb8e7JIlFPHkaKGDUN3lRHz8VhvgxgUbfFIn9IR9XaXocQPKymv7j+k2C+Au+
         t+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wWnZWc2eIL5m4prB0tQSVe9ACu/1Y9skaMpnFim491o=;
        b=jFs3WDDm0aGVhac8ViTpcQWZUPqtN7dTNMxDAwo+2emRnjgW2BCf27XFx4btZ0OoGg
         9abywLvmgUf18kMHyrHVtC6o8dG1P2o8aKVHU/VOJwyW63SrxmNLZ5KFGZ2s5zylGGoH
         5QdR0KYvkkMvgEgqlLK4CSSH8FQjPEBCyF0qS/O+TuJx5OaC11DzXxz3T5bHma5aJ0S9
         lnmgEEh3wVz83UB3IQbkbkTop9RgY0+Q9zgv8tYcCe9EglLP6yN1GNofkJnELtV0vgT8
         u4UCcFK3ahHtuKFQx1ruRiFjexGtmyjmieY2btzheIN+jB2PNSOhquBIFFYGPWrJBazL
         wTRw==
X-Gm-Message-State: AGi0PuYm2nyR/7TCq5KTRbBwbYlZTtZBfHbRStGfV57EQ23b0eZHRxfn
        BHJeaHy2w8ysrCXRk+F7j6EaWXYgdoiefIWxxpI=
X-Google-Smtp-Source: APiQypI4IEf5F318K0t/T2TFcBHQVFDnYcyWUd5QkfIgf07fBZPN54xunfajAJ9lBCSjSzrk58HnhsMKPm8L3szfuEY=
X-Received: by 2002:a92:dccf:: with SMTP id b15mr26343705ilr.246.1588093847178;
 Tue, 28 Apr 2020 10:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200427145435.13151-1-greearb@candelatech.com>
 <CALLGbR+fY9w1q=6HuU56OZLD6BeP_0KkU2xeoAA0ZZXxns+i3g@mail.gmail.com>
 <CAA93jw5tcptB64B8nGH0hqr4xC9G2SXNjp2tPf3YK5R7t6ZjXw@mail.gmail.com> <ae5587d1-f910-5fbe-42ab-3c4d722b259b@candelatech.com>
In-Reply-To: <ae5587d1-f910-5fbe-42ab-3c4d722b259b@candelatech.com>
From:   Dave Taht <dave.taht@gmail.com>
Date:   Tue, 28 Apr 2020 10:10:35 -0700
Message-ID: <CAA93jw4hesg9+qS+=z=G0upjHoRJeFuyMT1gKRx3qZoTRu0uaA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Restart xmit queues below low-water mark.
To:     Ben Greear <greearb@candelatech.com>
Cc:     Steve deRosier <derosier@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 28, 2020 at 9:35 AM Ben Greear <greearb@candelatech.com> wrote:
>
>
>
> On 04/28/2020 09:27 AM, Dave Taht wrote:
> > On Tue, Apr 28, 2020 at 7:56 AM Steve deRosier <derosier@gmail.com> wro=
te:
> >>
> >> On Mon, Apr 27, 2020 at 7:54 AM <greearb@candelatech.com> wrote:
> >>>
> >>> From: Ben Greear <greearb@candelatech.com>
> >>>
> >>> While running tcp upload + download tests with ~200
> >>> concurrent TCP streams, 1-2 processes, and 30 station
> >>> vdevs, I noticed that the __ieee80211_stop_queue was taking
> >>> around 20% of the CPU according to perf-top, which other locking
> >>> taking an additional ~15%.
> >>>
> >>> I believe the issue is that the ath10k driver would unlock the
> >>> txqueue when a single frame could be transmitted, instead of
> >>> waiting for a low water mark.
> >>>
> >>> So, this patch adds a low-water mark that is 1/4 of the total
> >>> tx buffers allowed.
> >>>
> >>> This appears to resolve the performance problem that I saw.
> >>>
> >>> Tested with recent wave-1 ath10k-ct firmware.
> >>>
> >>
> >> Hey Ben,
> >>
> >> Did you do any testing with this patch around latency?  The nature of
> >> the thing that you fixed makes me wonder if it was intentional with
> >> respect to making WiFi fast - ie getting rid of buffers as much as
> >> possible.  Obviously the CPU impact is likely to be an unintended
> >> consequence. In any case, I don't know anything for sure, it was just
> >> a thought that went through my head when reading this.
> >
> > I note that I'd prefer a BQL-like high/low watermark approach in
> > general... bytes, not packets, or better, perceived
> > airtime in a revision of AQL...
> >
> > ... but we'll try this patch, thx!
>
> Is there a nice diagram somewhere that shows where the various
> buffer-bloat technologies sit in the stack?  I suspect such should
> be above the txqueue start/stop logic in the driver that I mucked
> with, and certainly the old behaviour has no obvious tie-in with
> any higher-level algorithms.

There are some good diagrams of the new queue stuff buried in toke's
book and online papers, notably "ending the anomaly"

https://bufferbloat-and-beyond.net/

Plug: They just did a print run, and it makes for good bathroom
reading. There's also a preso on it around here somewhere.

That said, let's see... there's some rants in this:
http://flent-fremont.bufferbloat.net/~d/broadcom_aug9.pdf and here
... https://conferences.sigcomm.org/sigcomm/2014/doc/slides/137.pdf
but that's mostly about what was wrong at the time.

Definitely! revising this piece would be a good idea in light of
modern developments and increased knowledge.
https://www.linuxjournal.com/content/queueing-linux-network-stack

IMHO "how to use AQL" is underdocumented at the moment. I'd hoped to
produce some after we successfully
got the iwl drivers to use it, but we haven't got around to it, and
merely getting the ath10k using it (really really) well,
has eaten into my ax200 time.....


>
> I doubt my patch will change much except in pathological cases where
> the system is transmitting frames fast enough to fully fill the tx buffer=
s
> and also loaded in such a way that it can process just a few tx frames
> at a time to keep bouncing to full and not full over and over.
>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com



--=20
Make Music, Not War

Dave T=C3=A4ht
CTO, TekLibre, LLC
http://www.teklibre.com
Tel: 1-831-435-0729
