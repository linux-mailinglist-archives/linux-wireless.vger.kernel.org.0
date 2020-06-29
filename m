Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE220D754
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 22:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgF2T26 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 15:28:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732698AbgF2T2t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593458929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Af4KpIzEgr4pIiV2LebnToq75R4GNH67/fmvTzeBA6Q=;
        b=EUEHx4LSroOAMC/JIU7nE3pcMOvs75KEXiDClm4nYn8NVcfgsuPJnS4Dr+NDkqstRizX6P
        4too6K2x6xGVP+EmziX6pBT4ErUEWAALbM5HzBk1CtMEv/fyTazrUIbvt4BwXjXDxPJu5Y
        7vvBpN0XHNNETXctwGv06uL78ddQ2eU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-Jj84R5d3Nt-xjj-Ek8ziNg-1; Mon, 29 Jun 2020 06:26:02 -0400
X-MC-Unique: Jj84R5d3Nt-xjj-Ek8ziNg-1
Received: by mail-qk1-f199.google.com with SMTP id z1so1870637qkz.3
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2020 03:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Af4KpIzEgr4pIiV2LebnToq75R4GNH67/fmvTzeBA6Q=;
        b=MKiw7sLdoRUP1X15+FCcp8nASkNcXydMf6a7/me7CvXZ/W/yuja8aj2hABPMJ5ciKy
         2YEYx4/whceltGnX1Pel9V+I5zQOef+jYVZpuCk1iin3Fjt7ju16z0i8IOVC5pMNxjaM
         xX+rcYuqkJyFUiqdAiEdhSsWG+IoO9Xcsy6fA1lpm1st2A9mIUsBmQopqvD2LXSRqPfC
         cofnvw9EGXNYNpN10iZTOReQRRpwlpelctDVPbWXTq6YN+LP35PVQVvcGtYX8cFu2QDH
         FD/LySYbVH7iyV417ctwOMUZBUxARmccf3GQgYHM5eUTk148QTLY2kuOXmkiBMPm8P3Q
         NyKw==
X-Gm-Message-State: AOAM530KbsiUll3DeDjmYrHthZ1KN8i9R2D7zBfuKKUrz7C0jnQTEoJv
        o77tlYGsMIjJWCtbX7b/0A6QbOl1PkrGxY5HHjyZZjR8bkYpfm4qVAFubtHFsAKhAjr+XR0XCQu
        e7R4tcFyRSJHoNfNpY7hDaNz1HmE=
X-Received: by 2002:a37:4d0f:: with SMTP id a15mr14187679qkb.313.1593426361503;
        Mon, 29 Jun 2020 03:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVNgQ/1N8oN2928Xm86slDPHkUprPaGNArIarkd0p/jTYrFZfUMeJZ6rsi2b4L6AaDaOvVEw==
X-Received: by 2002:a37:4d0f:: with SMTP id a15mr14187663qkb.313.1593426361130;
        Mon, 29 Jun 2020 03:26:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d135sm3005834qkg.117.2020.06.29.03.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 03:26:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 04E011808CF; Mon, 29 Jun 2020 12:25:56 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Miguel Catalan Cid <miguel.catalan@i2cat.net>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        linux-wireless@vger.kernel.org
Subject: Re: [Make-wifi-fast] Support for airtime scheduling using ath10k
In-Reply-To: <CAMHmoouFjdOSBAq00SMeauO2GvEnXMvJG+vEMwhYUD4rdW9rxg@mail.gmail.com>
References: <CAMHmoovK_m=Yd4uUPhsdHZ588+d1DF-fyS+uGKdRWvd33Q2u+A@mail.gmail.com> <87zh8uruou.fsf@toke.dk> <CAMHmoouFjdOSBAq00SMeauO2GvEnXMvJG+vEMwhYUD4rdW9rxg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 29 Jun 2020 12:25:56 +0200
Message-ID: <87366ei2x7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miguel Catalan Cid <miguel.catalan@i2cat.net> writes:

> El mar., 23 jun. 2020 a las 11:35, Toke H=C3=B8iland-J=C3=B8rgensen
> (<toke@redhat.com>) escribi=C3=B3:
>>
>> Miguel Catalan Cid <miguel.catalan@i2cat.net> writes:
>>
>> > Hi,
>> >
>> > we are trying to apply different airtime weights to different stations=
 in
>> > order to have some prioritization among connected stations. While this=
 is
>> > working pretty well with ath9k, with ath10k we always obtain a fair
>> > distribution of the airtime (i.e. 50%-50% in the case of two stations),
>> > regardless of the airtime weight specified.
>> >
>> > E.g. STA1:
>> > RX: 0 us
>> > TX: 2295610622 us
>> >
>> > *Weight: 200*Deficit: VO: 256 us VI: 256 us BE: 34 us BK: 256 us
>> >
>> > E.g. STA2:
>> > RX: 0 us
>> > TX: 162597077 us
>>
>> 2295610622/162597077 ~=3D 14
>>
>> which is not *too* far from the 20/1 ratio you've configured? Does the
>> ratio change at all when you change the weights (i.e., if they are
>> equal, do you get closer to a 50/50 split?).
>>
>> Do the two stations have roughly the same signal strength / rate?
>
> In this case I started the STA1 a bit earlier, so it had a higher
> airtime aggregate. Indeed, to compare the airtime share, I was
> continuously monitoring the "airtime rate" (i.e. the difference
> between Airtime(now) and Airtime (now-4s)) and the results of both
> STAs were the same (i.e. 50/50 split) independently of the weight
> being used. But when using ath9k the same test runs perfectly
> according to the weights.
>
>>
>> > *Weight: 10*Deficit: VO: 256 us VI: 256 us BE: 9 us BK: 256 us
>> >
>> > We are using Compex WLE650V5-18A cards.
>> >
>> > So, does ath10k support airtime scheduling? In such a case, do we need
>> > specific Wi-Fi cards?
>>
>> It should. My guess would be that maybe you're not getting enough
>> backpressure for the scheduler to actually enforce things correctly. You
>> could try to look at the TXQ output and see if you actually have any
>> drops ('iw dev wlan0 station dump -v' and look at the drops/marks
>> columns).
>
> ok, i will check!

Another thing to check is the value of 'new_flows' in the TXQ output; if
that is high, it indicates that the queues run empty a lot, which can
prevent the airtime fairness scheduler from working properly.

>> What kernel version are you running? If it's not new enough to have AQL,
>> that might help moving the backlog to where the scheduler can do more
>> with it.
>
> Kernel 5.5.5.

Hmm, that should have AQL, actually.

-Toke

