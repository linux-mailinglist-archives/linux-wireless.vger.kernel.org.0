Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48CF3C192F
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfI2Tqg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 15:46:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34429 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfI2Tqg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 15:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569786394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zfgzjEfye0lWTvoD3gsi+XMbCCYxBcYuwGbteK/Q6lU=;
        b=GAEUmaO2twb7CftsA6l/l+44PNmGhvjDwcYPqIoY05fKileEFSIjsPJ6+mj4ItLL/xP1Co
        goXI+X9Sht2lShpLKQs84pGKDaY3qwA1Zub+Xwd5S0NaPoKeJgO3wxoHVPPXMk0HaH3lrK
        vgYH9vW0EBKqCMNTbnAa/r9EL4OdhUU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-hUPa_rOvOS-aB6Z6d95uWw-1; Sun, 29 Sep 2019 15:46:32 -0400
Received: by mail-lf1-f71.google.com with SMTP id m16so2183905lfb.1
        for <linux-wireless@vger.kernel.org>; Sun, 29 Sep 2019 12:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MqAWEx97Jge+y+FP8G5Cavj3k74wwufQN6fC/d6LmXc=;
        b=b0qd8G5UML5YJxcNHatq9c0uFmp6LT8qWpCs1LgTAacndGE4Ugnky031q7Mzuo/evY
         RJYWLs2at6terceJSLuKs4W2gyQ4J1JI+NelXKTD6LDfgUApqFPpSDQOK5rwqpEj8MlF
         c6cbMS3Rg/+suhMgjjI0wtnJv7ruhMNbk3trqmbSq8G4AsL2fx179kwHWv6xNbD5kEe3
         73VDfgmk8f0NRFeerUMRRiJhDiuh1sKD3DW4sLVHoyxlsKOtgSL3wFGYZTpVs8DC8jIv
         V/zlbfpJIiNIBjYb7BKyDVsm3iMGcnAQUui4Im6YZaL94oVl+EAxneVrSqZQ1pGlh8Oy
         wNlw==
X-Gm-Message-State: APjAAAUGxGtfrXXQnVNfDgOBH4lY6u0MNsUpKr3/8TyW3BC9Xzxn8xCR
        n2dI53xta5Bd4EXriwlYvOveiQJZiTFnomjpJ7H1zR4TXGWCz4TEWlG9ERlGx/kaqw73dE3kYPN
        dNx4Lx77DOq4D4HkZr5WE+yTPIjA=
X-Received: by 2002:a2e:9692:: with SMTP id q18mr9617447lji.73.1569786390969;
        Sun, 29 Sep 2019 12:46:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxPw/7wD1xHDGDfSleV+h6SHe0WN47ls2k7wlxjnG972VutIM6F4WR5LFpToryI9avSHNmn+w==
X-Received: by 2002:a2e:9692:: with SMTP id q18mr9617440lji.73.1569786390813;
        Sun, 29 Sep 2019 12:46:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id h5sm2486109ljf.83.2019.09.29.12.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 12:46:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BFBF318063D; Sun, 29 Sep 2019 21:46:28 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: Re: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with a better moving average
In-Reply-To: <b2566142-a7ea-50e8-e683-a3702b75ea6f@nbd.name>
References: <20190929154646.90901-1-nbd@nbd.name> <20190929154646.90901-2-nbd@nbd.name> <87zhinx7u7.fsf@toke.dk> <b2566142-a7ea-50e8-e683-a3702b75ea6f@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 29 Sep 2019 21:46:28 +0200
Message-ID: <87k19qyjfv.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: hUPa_rOvOS-aB6Z6d95uWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2019-09-29 20:42, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Felix Fietkau <nbd@nbd.name> writes:
>>=20
>>> Rate success probability usually fluctuates a lot under normal conditio=
ns.
>>> With a simple EWMA, noise and fluctuation can be reduced by increasing =
the
>>> window length, but that comes at the cost of introducing lag on sudden
>>> changes.
>>>
>>> This change replaces the EWMA implementation with a moving average that=
's
>>> designed to significantly reduce lag while keeping a bigger window size
>>> by being better at filtering out noise.
>>>
>>> It is only slightly more expensive than the simple EWMA and still avoid=
s
>>> divisions in its calculation.
>>>
>>> The algorithm is adapted from an implementation intended for a complete=
ly
>>> different field (stock market trading), where the tradeoff of lag vs
>>> noise filtering is equally important. It is based on the "smoothing fil=
ter"
>>> from http://www.stockspotter.com/files/PredictiveIndicators.pdf.
>>>
>>> I have adapted it to fixed-point math with some constants so that it us=
es
>>> only addition, bit shifts and multiplication
>>>
>>> To better make use of the filtering and bigger window size, the update
>>> interval time is cut in half.
>>>
>>> For testing, the algorithm can be reverted to the older one via
>>> debugfs
>>=20
>> This looks interesting! Do you have any performance numbers from your
>> own testing to share? :)
> To show the difference, I also generated some random data, ran it
> through minstrel's EWMA and the new code and made a plot:
> http://nbd.name/ewma-filter-plot.png

Oh, wow, yeah, that looks way more responsive...

> The real world test that I did was using mt76x2:
> I ran 3 iperf TCP streams from an AP to a station in a cable setup with
> an attenuator.
> I switched from 70 dB attenuation to 40 dB and measured the time it
> takes for TCP throughput to stabilize at a higher rate.
> Without my changes it takes about 5-6 seconds, with my changes it's only
> 2-3 seconds.

Very cool. Thanks!

-Toke

