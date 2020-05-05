Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3A1C6243
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgEEUtV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 16:49:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33931 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgEEUtV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 16:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588711759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSZcp1FpfZ2SSq2zzWqOQCbfjBz8yPOF7xmSQpKc9lk=;
        b=SQpBUrJSgFXDIOCwF1Ky091x7gXpN2li2+bgr+4AswDGAOsVqmBvG6TOOdfgf/ksPd79DI
        AhkZKeGQH+KmwpK7ZUrGuRUvUP2F7TeQVjDQ4cQSybN1yy8lrkwv2SrWoUqw26jWVaJuF7
        FPSxtwI+L0G+MB8H7QkO2qFqnTpT30E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-RgnX4_W2M-6ASjSL7BWhjw-1; Tue, 05 May 2020 16:49:15 -0400
X-MC-Unique: RgnX4_W2M-6ASjSL7BWhjw-1
Received: by mail-lf1-f70.google.com with SMTP id y21so1115089lfl.10
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 13:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=CSZcp1FpfZ2SSq2zzWqOQCbfjBz8yPOF7xmSQpKc9lk=;
        b=pYWArJgNu7bO6zeaUgvHHvy084Gc1eB+Fblkz9UbI7llnJECt/w545eOr1V1dFOjHl
         1Swrb83n2sXyOy7J7MszSInNzY+0j1jlYdGAcFUBwplK7VwgCePSegJ/MqbUlHt4VraC
         HyeG5yNE2+YQjWPcIJJkZoRXmuOAhtkyDeOpxtofqAXAQt/pMmbEF1noCfnV0EjLKIAi
         aRgIw3xnbZr4OSL9442JDkFhCAlhUAedCN9gPRn48NpmsAc2wMwHwcpFVnwNEaIcbqe+
         u0NAs+0mFZLU4J6uEsg+pT4d50fycIWbryflnfHyDm/GaqiMCWol2BBiHAuqDlQR4vRD
         ZfBA==
X-Gm-Message-State: AGi0PuZ2d/NEZVYSXVwLNUcpwouy+03+VvYRSx1cE8a0acms9GGRMNxc
        876TRkZkby0YMn9MLeOJ3laWlJBFtDsg+gHWbjceGhzRgRQ7aS9TX5J/OGIpTzQCO/V25gKo5cA
        KQ8rR16gY5ynNNDw/V4BavPV6QW8=
X-Received: by 2002:a2e:9713:: with SMTP id r19mr2946878lji.89.1588711753600;
        Tue, 05 May 2020 13:49:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypKq91/2vTa67RN3ETjjhEGWOXkdT5QSlTdAWCQ7Vj2EojmvM8FpUVauWoqRDcvBAqGTx0JLBQ==
X-Received: by 2002:a2e:9713:: with SMTP id r19mr2946867lji.89.1588711753309;
        Tue, 05 May 2020 13:49:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b1sm3017081lfb.22.2020.05.05.13.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:49:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9928C1804E9; Tue,  5 May 2020 22:49:11 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Regarding .wake_tx_queue() model
In-Reply-To: <20200505174947.GB2079@sakura>
References: <20200504193959.GC26805@sakura> <878si6oabp.fsf@toke.dk> <20200505131531.GA32619@sakura> <87368eo5dn.fsf@toke.dk> <20200505152010.GA33304@sakura> <87pnbimil6.fsf@toke.dk> <20200505174947.GB2079@sakura>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 May 2020 22:49:11 +0200
Message-ID: <87d07im7js.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Tuesday 05 May 2020 =C3=A0 18:50:45 (+0200), Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>
>> This seems like a bad idea; we want the TXQ mechanism to decide which
>> frame to send on wakeup.
>
> .release_buffered_frames() is only needed/used if STA went into
> powersave while packets were already sitting inside txqi, that's an
> edge case.
>
> In the other much more common case (STA went into sleep without any
> traffic pending in txqi), then the "classic" ps delivery code is used:
> frames gets pulled from ps_tx_buf queue (1 by 1 for ps poll, more for
> uapsd), and those frames ends up being sent through drv_tx(), since
> they have the flag IEEE80211_TX_CTRL_PS_RESPONSE so they bypass txqi.

Ah, I see, and if there are a lot of outstanding frames the client is
supposed to wake up and resume regular operation? As I said, I really
don't know much about how PS works; but I'm enjoying learning about it,
so thanks! :)

> so I was just looking at removing that edge case, sending those frames
> back to ps_tx_buf() from the driver.

Right, that makes sense. But I guess this is only something you can do
if you never buffer frames in the driver, no? E.g., ath9k has its own
internal retry queue, so it needs the callback to train that; and once
the callback is there, extending it to pull from the TXQs is quite
straight forward... So it's not necessarily a generally-applicable
optimisation, is what I mean.

>> really is no way around having a way to instruct the driver "please use
>> these flags for the next N frames you send" - which is what
>> release_buffered_frames() does. What you're suggesting is basically
>> turning off this 'pull mode' for the frames buffered during PS and have
>> mac80211 revert to push mode for those, right? But then you lose the
>> benefits of pull mode (the TXQs) for those frames.
>
> I just want to give those back to mac80211, those frames were already
> in push mode anyway.

Gotcha.

>> I remember Johannes talking about a 'shim layer' between the mac80211
>> TXQs and the 'drv_tx()' hook as a way to bring the benefits of the TXQs
>> to the 'long tail' of simple drivers that don't do any internal
>> buffering anyway, without having to change the drivers to use 'pull
>> mode'. Am I wrong in thinking that mwl8k may be a good candidate for
>> such a layer? From glancing through the existing driver it looks like
>> it's mostly just taking each frame, wrapping it in a HW descriptor, and
>> sticking it on a TX ring?
>
> maybe with the current firmware interface, but with the new one
> aggregation is done on host side, so tx path is no more that simple.

Right, OK. Is this just a different firmware that's generally available,
or is it a new thing? I am generally a fan of moving logic out of the
firmware like this...

-Toke

