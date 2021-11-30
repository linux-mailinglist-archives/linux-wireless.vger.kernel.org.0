Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413724633AB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 12:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhK3MAn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 07:00:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241349AbhK3MAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 07:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638273404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NyK9rJSXkcBPZtqbqvhmDFQs12LcliC0l/c29wh4iyk=;
        b=EhiivF3rCHVimaqxJMpX7+gTAgEFD9kX9xd/GWVx71o9DXeX+ZTTMfJovy6mLk3z9ORycO
        bhB0z2Q0umoEr/rVLQCzFXfJFBLSwsH6fVIN9uhbinQXx/AegPL8ZeU1CgZ8+ut74NrLG1
        Xss/f5/CkusGtmQw01RvcH1/3TubzMA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-TiLSqI_AMqmDNZ_ZBfqqDQ-1; Tue, 30 Nov 2021 06:56:43 -0500
X-MC-Unique: TiLSqI_AMqmDNZ_ZBfqqDQ-1
Received: by mail-ed1-f70.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso16735031edq.19
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 03:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NyK9rJSXkcBPZtqbqvhmDFQs12LcliC0l/c29wh4iyk=;
        b=sBh+4L1FzkhMxga+70vmBCZc/Y9AVmElo/q2PRZ1dKe6ETcEdRuEi9EDPNiUczXamm
         AgVi/d3lERqAq2HyCzwFo9QFg+YIUh2sQBRs2afJ9iZce7dzSVfgQdSBvLyfom0aFqiq
         krX6oyfdtW7DwZhxKv8q4sQbU9RcYPwPBEegWOCI0t7Vta1qTlYgsPofJ+poC4DElKTn
         kw2Q/24EGlxlgSoMPEcfIvNPa9sZmAnRPwDlvq/53QYzRh4rUEQpAG7sGQwJ3YflBOQR
         bP0TE4v0+7ToX/bfaL7NMGusk1aW8mBHQYiRrNn1dyYaDirasKC2oih1Ds7YQfMyJ7ye
         GncQ==
X-Gm-Message-State: AOAM5310A39UZ+ZeX6fMkuBNgaur0PFAHmY5FYLzRI9U7qPXAkBl6uLu
        WEbgdH2Tpk4Ia0T3d+ZykDuw5JVLGmh2rDkQc7gdw+ee4yqZU2qAN5ncziSaKp3MTGb8Dz34A7y
        zpEL0rFGImVHvLkOaLy3MLU5znd4=
X-Received: by 2002:a17:907:3d9e:: with SMTP id he30mr68253349ejc.177.1638273400544;
        Tue, 30 Nov 2021 03:56:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBhLBJR9cn80p9ESJCwnyMesviIeAbeHIhV9VYur74Bu9+Mr0L9Jcb1ABFY+r0EXFGMy8PAQ==
X-Received: by 2002:a17:907:3d9e:: with SMTP id he30mr68253259ejc.177.1638273399739;
        Tue, 30 Nov 2021 03:56:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id de37sm8819766ejc.60.2021.11.30.03.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:56:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 93C511802A0; Tue, 30 Nov 2021 12:56:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 15/16] mac80211: agg-tx: don't schedule_and_wake_txq()
 under sta->lock
In-Reply-To: <41b83b76a37c51585fbe53cb03f9cf3ddc395e2c.camel@sipsolutions.net>
References: <20211129133248.83829-1-luca@coelho.fi>
 <iwlwifi.20211129152938.d5fceeb7e166.I555fef8e67d93fff3d9a304886c4a9f8b322e591@changeid>
 <8735nf9ieg.fsf@toke.dk>
 <e947923fbeefd81d3b24acf009212d61864fac2c.camel@coelho.fi>
 <87ilw998vk.fsf@toke.dk>
 <41b83b76a37c51585fbe53cb03f9cf3ddc395e2c.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 30 Nov 2021 12:56:38 +0100
Message-ID: <87czmh97rd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Tue, 2021-11-30 at 12:32 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Luca Coelho <luca@coelho.fi> writes:
>>=20
>> > On Mon, 2021-11-29 at 14:54 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>> > > Luca Coelho <luca@coelho.fi> writes:
>> > >=20
>> > > > From: Johannes Berg <johannes.berg@intel.com>
>> > > >=20
>> > > > When we call ieee80211_agg_start_txq(), that will in turn call
>> > > > schedule_and_wake_txq(). Called from ieee80211_stop_tx_ba_cb()
>> > > > this is done under sta->lock, which leads to certain circular
>> > > > lock dependencies, as reported by Chris Murphy:
>> > > > https://lore.kernel.org/r/CAJCQCtSXJ5qA4bqSPY=3DoLRMbv-irihVvP7A2u=
GutEbXQVkoNaw@mail.gmail.com
>> > > >=20
>> > > > In general, ieee80211_agg_start_txq() is usually not called
>> > > > with sta->lock held, only in this one place. But it's always
>> > > > called with sta->ampdu_mlme.mtx held, and that's therefore
>> > > > clearly sufficient.
>> > > >=20
>> > > > Change ieee80211_stop_tx_ba_cb() to also call it without the
>> > > > sta->lock held, by factoring it out of ieee80211_remove_tid_tx()
>> > > > (which is only called in this one place).
>> > > >=20
>> > > > This breaks the locking chain and makes it less likely that
>> > > > we'll have similar locking chain problems in the future.
>> > > >=20
>> > > > Reported-by: Chris Murphy <lists@colorremedies.com>
>> > > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> > > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> > >=20
>> > > Does this need a fixes: tag?
>> >=20
>> > Hi Toke,
>> >=20
>> > Neither Johannes nor Chris pointed to any specific patch that this
>> > commit is fixing.  If you know the exact commit that broke this, I can
>> > add the tag and send v2.
>>=20
>> Well, it looks like the code you're changing comes all the way back from:
>> ba8c3d6f16a1 ("mac80211: add an intermediate software queue implementati=
on")
>>=20
>> Maybe Johannes can comment on whether it's appropriate to include this,
>> or if the code changed too much in the meantime...
>>=20
>
> I think that probably makes sense, and I guess I can include that tag
> when I apply it.
>
> I suspect the reason I didn't do it internally (we have a different tag
> though, so that's no excuse) is that there we didn't care until iwlwifi
> actually gained TXQ support.

Right, makes sense - thanks! :)

-Toke

