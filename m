Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D948A1C577A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgEENxR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 09:53:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32379 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728995AbgEENxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 09:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588686795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnRCYu6QqNe+uhHJF6df2eBFtENL9hCQofoezZvgClA=;
        b=UnhRIQg/WVyucATlNl+vskRssxoWcBiZwlU6sHhYIPgNNCqzaVwaoAhI3wXfLY+q0jFPka
        I8f3kfWKANinSnb0fVClTwdpz7O5j6o6+SdLmEufuQI86b/adAPD17jWzq1LikDGDxSve0
        z6snxLamF5wTChgvHRJifJ3Ow3QbHr4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-KYCZjFdnP6Sfhlk4QOnfGg-1; Tue, 05 May 2020 09:53:12 -0400
X-MC-Unique: KYCZjFdnP6Sfhlk4QOnfGg-1
Received: by mail-lj1-f200.google.com with SMTP id k14so444257ljg.21
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2020 06:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cnRCYu6QqNe+uhHJF6df2eBFtENL9hCQofoezZvgClA=;
        b=SVDsJGrTdiD65x2a9pqxSlV+cM8Izdqa6EO8mRINdFgoUmbYpfoAVJU4q9sI+SO1UR
         +eiglueprXQQeCg0DZXguTNv00QaTOsUznCezfV1eWA8CCQnivS3YaOmm6JJUAnxioHq
         t5O6vVK0EZr1+QPTD4ID2zumTSp4xHSzz8NzHWd63Uwn+uew7Yok9kj9WFha53tyJYjn
         x8s6858kiOz62sFiVasDwNUXcZ/n5oB+vakcHICr5iili1i4iqrzya6vAnqWxLlaelXY
         VGtozqbSkwGdYYLal49SAIhXQQ0gTSXAQooPaFwkEEgTW28FWyOqhZe7dmDZcislzFrl
         JgGQ==
X-Gm-Message-State: AGi0PuZ6oSJIHGiM2DswXjHzm5Pah2ys5SXgYTzCvAgmbbvJECrJ5z0b
        BzKANza/2S8X60iHyMjYmSQyZFOVo+FCNhK8pYSWVgKCUVS398jHK/GTgrUgLH9dlkpoFmNXgUB
        A+pDWI6cfiStuDuP93EH7MOIZ8V8=
X-Received: by 2002:a05:651c:287:: with SMTP id b7mr2006683ljo.82.1588686790773;
        Tue, 05 May 2020 06:53:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypLcT/zScDXT5L25RP2hLDd3AaSPxSn2Ciuo2dX+wVLMkO0ggrQPK8zl5YXnWw3geHOK0fdv8A==
X-Received: by 2002:a05:651c:287:: with SMTP id b7mr2006659ljo.82.1588686790337;
        Tue, 05 May 2020 06:53:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d9sm1845065lfa.77.2020.05.05.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 06:53:09 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B23F31804E9; Tue,  5 May 2020 15:53:08 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Regarding .wake_tx_queue() model
In-Reply-To: <20200505131531.GA32619@sakura>
References: <20200504193959.GC26805@sakura> <878si6oabp.fsf@toke.dk> <20200505131531.GA32619@sakura>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 05 May 2020 15:53:08 +0200
Message-ID: <87368eo5dn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maxime Bizon <mbizon@freebox.fr> writes:

> On Tuesday 05 May 2020 =C3=A0 14:06:18 (+0200), Toke H=C3=B8iland-J=C3=B8=
rgensen wrote:
>
> Hello Toke,
>
> thanks for your comments
>
>> I don't think ieee80211_stop_queue() is meant to be used this way at all
>> in the wake_tx_queue case. Rather, when you get a wake_tx_queue()
>> callback, you just queue as many frames as you feel like (see '2
>> aggregate' limit above), and then return.  Then, on a TX completion you
>> just call your internal driver function that tries to pull more frames
>> from the mac80211 TXQs.
>
> alright, indeed .wake_tx_queue() does not have to result in any actual
> frame sent.
>
> but what about .release_buffered_frames then ?
>
> .release_buffered_frames() and .drv_tx() are both "push" oriented
> interface. When they are called, you have to push a frame to the
> hardware, so if they are called when hardware FIFO is full, you need
> to drop the frame (or add yet another intermediate level of queuing)
>
> from what I can see, .release_buffered_frames() will happily be called
> even if queue is stopped, and you have to at least send one frame.
>
> I'm just trying to avoid any additionnal intermediate queing in the
> driver between what mac80211 gives me and the HW fifo which has a
> fixed size (well actually you can choose the size, but only at init
> time).
>
> my current workaround is to pre-size the hw fifo queue to handle what
> I think is the worst case

Well, I think that should be fine? Having a longer HW queue is fine, as
long as you have some other logic to not fill it all the time (like the
"max two aggregates" logic I mentioned before). I think this is what
ath9k does too. At least it looks like both drv_tx() and
release_buffered_frames() will just abort (and drop in the former case)
if there is no HW buffer space left.

> Also .release_buffered_frames() codepath is difficult to test, how do
> you trigger that reliably ? assuming VIF is an AP, then you need the
> remote STA to go to sleep even though you have traffic waiting for it
> in the txqi. For now I patch the stack to introduce artificial delay.
>
> Since my hardware has a sticky per-STA PS filter with good status
> reporting, I'm considering using ieee80211_sta_block_awake() and only
> unblock STA when all its txqi are empty to get rid of
> .release_buffered_frames() complexity.

I'm probably not the right person to answer that; never did have a good
grip on the details of PS support.


What hardware is it you're writing a driver for, BTW, and are you
planning to upstream it? :)

-Toke

