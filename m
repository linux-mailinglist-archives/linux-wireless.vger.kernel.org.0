Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAAC2FA9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfJAJIh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:08:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29621 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728892AbfJAJIh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569920915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztuEv3F1VvUb37/sb6lMwENjtvEWt91fS/pfkH1uTOo=;
        b=DAIv4TtbMvnaAU1cwjaHs0TUJzmf9lRWanjd+Jbh/YTsrYalKBN5TTO586xsnuXMmY7GWE
        NNNnG0P2M5v3GXK+sdu9mYGrLhBGRunQHO8/MnyNajTFlJvj00olIMmKpM+3Ner1pBmENY
        fatnaw+i6oXM0mUKpEZ99/S/UZI9nwc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-CWdt7FA0OSKwpO3SIgyM5w-1; Tue, 01 Oct 2019 05:08:33 -0400
Received: by mail-lf1-f71.google.com with SMTP id p15so2620654lfc.20
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 02:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=10PCp8jeul/Ln8OdCxlZHThqI0Uexho93oGHCJziLrg=;
        b=cwaEqMZ4gTY9KbWfbxDtb9fImITi+tPNzqi9UJXz4311bf6bJX9fl0yD4/uyqk1gi6
         VMzLkM/QxETXqu2sEzk/dFXuHyImaR27U+pdsOXFu04Nh7oek3CkK73lCRh0f/zwPL73
         K5/Wepre7Dg6p0tFPjKHNSRxGySt5FTr/NrTkjG7deHOWSalmJUFiUZekatzsgAi2aJK
         MAtNVHs003PBw5K47PNihMqmsBuVBkJaY5eNv8Xiuu5w029uFHU+lWnhe4qw9GIc3lOk
         WI9vXJeIl3yZRIkmN3nFfE6k05jUK8Kk94eLM7ktqcBY43ygmEMnPLp4BBlIF7YQmQ6F
         4jBQ==
X-Gm-Message-State: APjAAAWqwnMeNPcqOGrZF2f6YI3ERR6O5Pcx8bHliWjcbcdekwJ2tn0x
        zlk3mttfoIEqHDFryazCQ0m+KqmtcIiALyytvBzw7OUjFyMOI2ZShX02v2vTwzzpZXml4MxQBtv
        zLJK1p48s+qS9lqP+QRYJSVvYSS0=
X-Received: by 2002:a2e:894b:: with SMTP id b11mr10980566ljk.152.1569920912182;
        Tue, 01 Oct 2019 02:08:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwMmoZWktrU9t3bsxs/zxOrAZ9ZKCtaEs/KadF1Rn2MREKt6ho0vvj8CvEvxNHwXsMNihwIvg==
X-Received: by 2002:a2e:894b:: with SMTP id b11mr10980561ljk.152.1569920912043;
        Tue, 01 Oct 2019 02:08:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id t22sm3720806lfg.91.2019.10.01.02.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 02:08:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 589A218063D; Tue,  1 Oct 2019 11:08:30 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH RFC/RFT 1/4] mac80211: Rearrange ieee80211_tx_info to make room for tx_time_est
In-Reply-To: <fd0d467d352177ac20100239cb18f80310b43fa9.camel@sipsolutions.net>
References: <156889576422.191202.5906619710809654631.stgit@alrua-x1> <156889576534.191202.17686228416284995279.stgit@alrua-x1> <fd0d467d352177ac20100239cb18f80310b43fa9.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Oct 2019 11:08:30 +0200
Message-ID: <87v9t8vnn5.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: CWdt7FA0OSKwpO3SIgyM5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Hi,
>
> Sorry for the long time to review here ...
>
> On Thu, 2019-09-19 at 14:22 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> To implement airtime queue limiting, we need to keep a running account o=
f
>> the estimated airtime of all skbs queued into the device. Do to this
>> correctly, we need to store the airtime estimate into the skb so we can
>> decrease the outstanding balance when the skb is freed. This means that =
the
>> time estimate must be stored somewhere that will survive for the lifetim=
e
>> of the skb.
>>=20
>> Fortunately, we had a couple of bytes left in the 'status' field in the
>> ieee80211_tx_info; and since we only plan to calculate the airtime estim=
ate
>> after the skb is dequeued from the FQ structure, on the control side we =
can
>> share the space with the codel enqueue time. And by rearranging the orde=
r
>> of elements it is possible to have the position of the new tx_time_est l=
ine
>> up between the control and status structs, so the value will survive fro=
m
>> when mac80211 hands the packet to the driver, and until the driver eithe=
r
>> frees it, or hands it back through TX status.
>
> Seems reasonable to me, if we end up needing it and don't have an out-
> of-band path (that you seem to have been discussing in this long
> thread too)

Awesome! Any idea for how to make it work on big-endian systems? I got a
splat from the kbuild robot that triggered the BUILD_BUG_ON when
building for m68k. I assume it's the union with codel_time_t that ends
up being aligned wrong...

-Toke

