Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2892B1312FF
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 14:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgAFNe1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 08:34:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbgAFNe1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 08:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578317666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Dkkujyfe/gezec8u0wxy79DdORx+9S3fm+dMwU0Eyc=;
        b=i3TQ5Fp7S+05pIqtLZwi+y9gfnXEqGfxSovEwQSmw8F/1zNGXxHxRsBbUMDPDTpzOHtqv8
        nD05nr5IZU+2/O6+o9/o8Zl7j+Hs5wgCxhl59/f48iv0KhQyiHXRq1SufdEyAUkCrJxlKr
        FlYkuDPK4HJgq0qqWMK5cp5EejP5+10=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-oMa1Am4ZNfWUxpfOP_Qa8w-1; Mon, 06 Jan 2020 08:34:25 -0500
X-MC-Unique: oMa1Am4ZNfWUxpfOP_Qa8w-1
Received: by mail-wm1-f69.google.com with SMTP id 18so2854678wmp.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 05:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+Dkkujyfe/gezec8u0wxy79DdORx+9S3fm+dMwU0Eyc=;
        b=kxG+IuyPUIDJ5gXy9pjQCtlivmf+oFi+yhiDUjGoJeivyr43xRVAmJOt+8IK8F2USg
         ARHg072VObYatSg667cZUBldlaWH+sWbwrVMmCqWaEJTNL4qUlsup/Yt+J1Rk57JFe6+
         zEKG/7ocA+nNhkELFlCavCHnsS6UB5+0Qxyw50CaBoW4ObsYTrQESp2bVXGHQvofJFJz
         I74yJwAvLUVr8NfDP+c4tR95EdZf6GNS6nCHdcgKyEogjM4nTkdUwAEmLy+n+WBCSNRP
         IJlK/bdLp9PQIEgWp/G59TPU4w7A/hh9m60d2KwBetwBvO8blusjQsqfysdYMntS5ClW
         aagg==
X-Gm-Message-State: APjAAAU2W5TxKFkqN62rj+b2j1M2Wlg7mB4tX4aN2fXHLVN4pRi4YGRY
        L+xRb8obRiQdExTaQbqRudDhXGiqXE1I4tZXnUFUJXgIFlc74w1LHuSpLgFiFQOmT95hl8OQXlA
        hijx4BmxQdyknUbpOeP8veSs0n00=
X-Received: by 2002:adf:f508:: with SMTP id q8mr27908554wro.334.1578317663890;
        Mon, 06 Jan 2020 05:34:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxm40NiLw1TYjidTWCotGayLqivBaOTg5hEb2NN8tw0Sw35bt3Zm76Owu+8ubw6JUQgXScAiA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr27908539wro.334.1578317663728;
        Mon, 06 Jan 2020 05:34:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q68sm24387041wme.14.2020.01.06.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:34:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A0E54180ADA; Mon,  6 Jan 2020 14:34:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>, Justin Capella <justincapella@gmail.com>
Cc:     Stephen Oberholtzer <stevie@qrpff.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Wireless networking goes down on Acer C720P Chromebook (bisected)
In-Reply-To: <CA+iem5uPaYmZr=+kdHopm1Yo9dgyL98k7KfV6uYx_yH22FSGag@mail.gmail.com>
References: <CAD_xR9eDL+9jzjYxPXJjS7U58ypCPWHYzrk0C3_vt-w26FZeAQ@mail.gmail.com> <1762437703fd150bb535ee488c78c830f107a531.camel@sipsolutions.net> <CAD_xR9eh=CAYeQZ3Vp9Yj9h3ifMu2exy0ihaXyE+736tJrPVLA@mail.gmail.com> <CAMrEMU-QF8HCTMFhzHd0w2f132iA4GLUXHmBPGnuetPqkz=U7A@mail.gmail.com> <CA+iem5uPaYmZr=+kdHopm1Yo9dgyL98k7KfV6uYx_yH22FSGag@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 06 Jan 2020 14:34:22 +0100
Message-ID: <87tv58k8td.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> I ran a ping, and saw this:
>>
>> - pings coming back in <5ms
>> - re-enable AQL (echo 7 | tee airtime_flags)
>> - pings stop coming back immediately
>> - some seconds later, disable AQL again (echo 3 | tee airtime_flags)
>> - immediate *flood* of ping replies registered, with times 16000ms,
>> 15000ms, 14000ms, .. down to 1000ms, 15ms, then stabilizing sub-5ms
>> - According to the icmp_seq values, all 28 requests were replied to,
>> and their replies were delivered in-order
>>
>> This certainly looks like a missing TX queue restart to me?
> I don't think TX queue restart is "missing", the TX queue should get
> restarted when the pending frames is completed and returned to the
> host driver. However, It looks like there is some issue with the
> deficit refill logic in ath9k, and the TX queue got blocked due to the
> negative deficit.

s/deficit refill/packet freeing/. I.e., there's an issue with the ath9k
driver either stomping on the tx_time_est field in the cb, or it's not
reporting back all freed TX skbs properly, so the AQL Q depth doesn't go
back down.

The large negative deficit is just because the queue is being blocked by
AQL, so it won't get its deficit refilled (and it keeps decreasing as RX
packets are being accounted).

All this being said, given the fact that ath9k definitely doesn't need
AQL, I think it's probably not worth it to try to find out exactly what
is causing this, and instead just leave AQL off for that driver?

(As an aside, this definitely disproves my initial "AQL should be benign
for drivers that don't need it" hypothesis. Guess that was way too
optimistic anyway ;))

-Toke

