Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2C3C2DB4
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 09:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbfJAG6B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 02:58:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725777AbfJAG6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 02:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569913079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRAFW8/U7zXvEEyNRQQ4ESdCPCLNo9vrPnN6FAlCs3Q=;
        b=O0j2BUeTO2vd31a7F8YG4FJwBov7MyipGOY9E/pVoi4MspFxEP8GcjbrZesF1jPiqcHqoc
        FbDLiMzoMoUH5kPXH3eQxqFoyzlrdldfrrKrgfe9PdXhZyI8F75jhc+C2EoI4yDs0Xi+bD
        VyCtWBLVydq+pyJyEkWcSqQi6iQBRm0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-UBeTJqwLM4SuwMpva5oFWQ-1; Tue, 01 Oct 2019 02:57:58 -0400
Received: by mail-lj1-f199.google.com with SMTP id h19so3830904ljc.5
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2019 23:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FkyKJAiKEgiIJtm1wmYNEnaa9QuHfBYZjrXStMrtpN4=;
        b=dUyn0iwTFxSKP1NVgztxCK6OZ/0anyaZ5hFLuCr91jnYKzJIimxs5RvLztvuzjHdbC
         n1gSHt99Szf75IQ/T9STk+ibXVBhs5Y0rqreZB8UR1PnUMnOkk3hA4bggfY8xCrDprS+
         5g98XITwvqYp1B+9pooXgUGFenL/VuDQ+MfB1wyHZyZUtv+ZMdqNe88j1heGGyTYI8pL
         XdYlBOtUJ6+07m23WuyhYOFEyPUWt2kLysfqTzt68D/z0lvvOktWjZrXfE77HdmaTqSU
         Def5xfM9dZ5CPi+6NDdvhe3zsL8KVdEiFxhN8qwmKo4yoeqswvIe9in5AfpmgWa32IG6
         T4VA==
X-Gm-Message-State: APjAAAXhK6/tGW83aUKwUxbEOdlqJmCCi61v3mXVUU2R87P1RX11VMjW
        P+qu4b4yvCKDRoU/EdipUWYmkjTzG6Iq6cVGqGE0r+8kHlAKwmfQEjFJ3dUFznOt3Izk89tOIEZ
        3zg20IVPbBImZt5TUvFersvUwCAI=
X-Received: by 2002:ac2:4149:: with SMTP id c9mr857954lfi.128.1569913076365;
        Mon, 30 Sep 2019 23:57:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx74ouQXfD14eaZUyj6r+EeRdMOKORTSfS/bmZWcxUp8rc28I/codK30MLL5lUb9GzxFTpNfw==
X-Received: by 2002:ac2:4149:: with SMTP id c9mr857932lfi.128.1569913076182;
        Mon, 30 Sep 2019 23:57:56 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id c26sm359795lfp.20.2019.09.30.23.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 23:57:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DA1D718063D; Tue,  1 Oct 2019 08:57:53 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Yibo Zhao <yiboz@codeaurora.org>, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH RFC/RFT 4/4] mac80211: Apply Airtime-based Queue Limit (AQL) on packet dequeue
In-Reply-To: <CA+iem5tDU9RYdUJ5y1E3E1iFRsSX_rA8dbDjaviGBxKyMS_3kA@mail.gmail.com>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576869.191202.510507546538322707.stgit@alrua-x1> <08f0ed6e-b746-9689-6dc8-7c0ea705666d@nbd.name> <87wodv19jl.fsf@toke.dk> <b0239b81-e3db-1f10-22cb-ad06536b97a8@nbd.name> <87tv8z13wv.fsf@toke.dk> <CA+iem5uir8GOq2psAVuUParY3MimsGhvdefUopiwHov128CQQA@mail.gmail.com> <87r2421d4f.fsf@toke.dk> <ed46699c32cd3d8d8bcc9bce1375ba04@codeaurora.org> <CA+iem5sGkRQy4B=Mz-C90sfqgFmuywa=W7Yjy2CDd8hfppQkvQ@mail.gmail.com> <87muemykqn.fsf@toke.dk> <CA+iem5tDU9RYdUJ5y1E3E1iFRsSX_rA8dbDjaviGBxKyMS_3kA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 08:57:53 +0200
Message-ID: <87imp9vtou.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: UBeTJqwLM4SuwMpva5oFWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> I guess the risk is lower when with a 24ms per-iface limit; but with
>> enough stations I guess it could still happen, no? So we should probably
>> handle this case...
> Each txq (per sta, per tid) is allowed to release at least the lower
> AQL limit amount of packet (default 4ms), which is not affected by
> other station's PS behavior and 4ms should be sufficient for most use
> cases.

Ah, I thought you'd meant each station can queue MIN(4ms, 24ms-<other
stations>). I see that is not the case; it's up to 10ms as long as the
total is less than 20ms, and up to 4ms otherwise.=20

> The 24ms per-interface limit is an optimization to get good benchmark
> score in peak performance test, which usually only involve 1-2
> stations.

Gotta get those benchmark numbers in ;)

> The higher limit probably won't matter anymore when there are many
> stations. I haven't noticed side effects due to PS behavior in the
> ChromiumOS version. Still, it is better to be able to take frames in
> PS queue in to account,

As long as one station always gets its 4ms, I'm not too worried about
PS; but that was not the case in my patch :)

>> Cool. Are you going to submit a ported version of your implementation?
>> Then we can work from the two submissions and see if we can't converge
>> on something...
> Working on porting, should have something ready before the end of this
> week.

Great!

-Toke

