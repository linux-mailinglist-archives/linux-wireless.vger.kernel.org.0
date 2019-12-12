Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974A611CABE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2019 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfLLKaB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Dec 2019 05:30:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33541 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728561AbfLLKaB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Dec 2019 05:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576146600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2M6G8iAhRV7/cjIOqjMt+xr5yQGXJg0bdL2B5+adEQY=;
        b=beZaezn9kqCo0Tb1hzxPoQJCQeFjAS8MuQYyce10KKYC54zmRiK8KZ2ETRJKAk3vdnRyuf
        kjiQo8evi0xcKbVm/RMu4dJtm4DxGDYKWvqJmgwrBvzFUOTWrzaBM/iw6ko/SbDfrrptbR
        6EMR4E48udeBrSRlf3OE4+gV/4aGWfg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-B4DjG6-1Nw2KAJRDvvDR3g-1; Thu, 12 Dec 2019 05:29:59 -0500
X-MC-Unique: B4DjG6-1Nw2KAJRDvvDR3g-1
Received: by mail-lj1-f200.google.com with SMTP id s8so354315ljo.10
        for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2019 02:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2M6G8iAhRV7/cjIOqjMt+xr5yQGXJg0bdL2B5+adEQY=;
        b=NcfxZ1IgCekqo6C6rj652OAgGEs5t3Ot/BJemI8x1dNZt+Dhd41srdWcd9A2BT9d8l
         NrLx6R64V1vd1GkGV1gDsILllwnWoo15NwfzR4OFr0oaUGHdlYKqgO0fLhx4bfy2qKam
         JAhgWgLXuzoZAX4Wx61g8DelXnGkRBFmk2Tazrw0VXPf86gzDoWTA900BRB5zn/rkcgg
         UZxf3eZKOB2fMGPea58zSwOaYXAZFXYH06XtdZKXDs2Hlis0ucI7AmqehNQMAQZbYwxD
         47SwhaAoxFWUAEvJRx5hAhqBfDzzFrEV8Wnaw//eGz8W3q4rN8mw4JTE9YPY2lHSRnnE
         GO4Q==
X-Gm-Message-State: APjAAAXwZS3J5X2SYWf6Obwrf9X+SY9FDesS6VuMoXEJhZucbGPKaQIn
        hL+8aGUuMTfI1cN74ZtpKvgrzDH8JMYtikiEQgOyMpALtzZoM8HtR0eqCitLJA98HAea3rl7Bd0
        KPyqwejvFqNFyQIpG5ROfqpXaFEQ=
X-Received: by 2002:ac2:46dc:: with SMTP id p28mr5228240lfo.23.1576146597557;
        Thu, 12 Dec 2019 02:29:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqry9NQX+5JoJ1CMjEXLOjljhoSaIBxWUieZunQNd9ApcILr8cfNOm923DLupXjagv4JavaQ==
X-Received: by 2002:ac2:46dc:: with SMTP id p28mr5228234lfo.23.1576146597386;
        Thu, 12 Dec 2019 02:29:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c27sm2657557lfh.62.2019.12.12.02.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 02:29:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BAD811819EA; Thu, 12 Dec 2019 11:29:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Justin Capella <justincapella@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] mac80211: Turn AQL into an NL80211_EXT_FEATURE
In-Reply-To: <CAMrEMU9t-Ed9ASyjGcJvpKM=Japiy0fv_cd1_3D5Sy_UMte_9A@mail.gmail.com>
References: <20191211145230.200132-1-toke@redhat.com> <20191211145230.200132-2-toke@redhat.com> <df7eb0b71dc9cfdc7d9b5f7abdbcce0d42fa4a1e.camel@sipsolutions.net> <CAMrEMU9t-Ed9ASyjGcJvpKM=Japiy0fv_cd1_3D5Sy_UMte_9A@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 12 Dec 2019 11:29:55 +0100
Message-ID: <871rt9g7ks.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Justin Capella <justincapella@gmail.com> writes:

> Disclaimer: I'm new, so don't assume my questions are rhetorical...
>
> sta = container_of(txq->sta, struct sta_info, sta); // Is this
> correct?

Not sure what you're referring to here; but generally, yes? :)

> I see the use of IEEE80211_NUM_ACS seems to be standard, is that AC
> specific? I learned today that different devs have different numbers
> of queues...

AC numbers are defined in the standard, and there are always four of
them. Different hardware can have different numbers of queues, which may
or may not be related to NUM_ACS.

> What are the units of the THRESHOLD, iirc there was some bit
> shifting/masking?

Units are logically microseconds, but stored as increments of 4
microseconds because we ran out of bits; this is kept inside the
setter/getter function, though, so everywhere else is just microseconds.

> Is there supposed to be a queue per station, or just per interface?

There's a TXQ per TID (so 16 per station), and an additional one on the
interface for multicast.

> It seemed like the threshold was meant to pick a higher or lower
> queue, this seems to maybe just reject if not within the bounds?

There are two thresholds; one for the whole interface, and one per
station. If either is exceeded transmission will be throttled.

-Toke

