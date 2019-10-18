Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C481DC73A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405517AbfJROWU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 10:22:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731923AbfJROWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 10:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571408538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CZJB5jgfqOkbA3pAcKVegphLG5lxMMLqppKUI+v+NT0=;
        b=Hif1k7pLT/Gx/6uJe+02IFcuD8dU10UkQf4Tq2vEJAIcAHnqB5ol0oYS4CqcJdCWYFgGYB
        k3owWmsGa7cl6S0CNP6qTwU191yNMjhkUXwDQGt5iQtVV+2+dGaKxR6nALtIF7r2wqSEAd
        A4xcSjkn8gXpmDfqpO8DeqcYlb78Rrw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-YOiv59G4MtS3su_oRgnoVg-1; Fri, 18 Oct 2019 10:22:17 -0400
Received: by mail-lj1-f197.google.com with SMTP id p14so1105432ljh.22
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 07:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WFSLNDo34e/hQ4mMaXqwSinumGcSHTA3VPI9PdShktc=;
        b=mYiq6iZLjQoxtXXyUQC2O68BbBPvOsP+PKAKdit2sTrsxyr9YQX28t3fTQ54fT8aTD
         8MJLavEii2HuP1l47GYxDottiV03d4Kuf06Yq5TS07H3xpbNC9Qk2y6am56ZPTlx1itl
         bsJASdZhEEPMQo7Yw1B3AiJN+dE7QDkUMMKjUgLIjq2ijnl49I6qltuFA8BQmvHlCMVn
         I1GuTLqWA8SSJKgoPMpnqTHo5qVHvvUG71CpMGz9rmmHZwea4P8dPsUaed76UgHSFnBA
         ntQIXga0AA6fzhikizIz4eYTmIgZmIToW3+Uoxved8zV59WcUU3epWKZa2AkMibV9XdT
         LJ6Q==
X-Gm-Message-State: APjAAAWap8kMd+jBdXZwlgjoO+x84t1Jx1F4/9DRG3OJLT7fSzxdP+Fr
        tu9D6QazhUS8Qsh8uzfsNMj0eGx2FzbCsNNRH3vx0tsIeAl37WEjVzEra22c4RuYKjAgXZasKn0
        piSokQTLYIN7olGaU9V8/ClvYWI8=
X-Received: by 2002:a19:22c4:: with SMTP id i187mr5926913lfi.152.1571408535630;
        Fri, 18 Oct 2019 07:22:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqkwQ+FzoYv6pBFiWwEhgsIA1mrDfY6EuiAaZf0ZL91B2Z9tof0t8W9lR0jkYi1be643oQ1Q==
X-Received: by 2002:a19:22c4:: with SMTP id i187mr5926898lfi.152.1571408535451;
        Fri, 18 Oct 2019 07:22:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id g3sm2667601lja.61.2019.10.18.07.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:22:14 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0FF491804B6; Fri, 18 Oct 2019 16:22:14 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v2 1/4] mac80211: Rearrange ieee80211_tx_info to make room for tx_time_est
In-Reply-To: <e2c54294fa5ac7b48e6099b47385a5f4df0859ce.camel@sipsolutions.net>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115993866.2500430.13989567853855880476.stgit@toke.dk> <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com> <87sgnqe4wg.fsf@toke.dk> <10b885b3238cede2d99c6134bebcc0c8ba6f6b10.camel@sipsolutions.net> <87imomdvsj.fsf@toke.dk> <9fc60b546b54b40357264d67536733251cf39ebe.camel@sipsolutions.net> <87d0eudufu.fsf@toke.dk> <e2c54294fa5ac7b48e6099b47385a5f4df0859ce.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Oct 2019 16:22:14 +0200
Message-ID: <87a79ydtgp.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: YOiv59G4MtS3su_oRgnoVg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2019-10-18 at 16:01 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>
>> Right. Well in that case, let's try it. As long as we fail in a
>> reasonable way, we can just see if we run into anything that breaks? I
>> guess in this case that means rejecting requests from userspace if we
>> run out of IDs rather than silently wrapping and returning wrong data :)
>
> We can't reject due to how this works, but if the idr_alloc() fails then
> we'll just not give a status back to userspace later.

OK, I guess someone will notice if that suddenly starts happening all
the time ;)

>> > > We could also split 5/11. That would support up to 32 ACK IDs, and w=
e
>> > > can just truncate the airtime at 2048 us, which is not a big deal I'=
d
>> > > say.
>> >=20
>> > We can also play with the units of the airtime, e.g. making that a
>> > multiple of 2 or 4 us? Seems unlikely to matter much?
>>=20
>> Sure, that's a good point! Increments of 4us means we can fit 4ms is 10
>> bits, leaving plenty of space for ACK IDs (hopefully).
>>=20
>> I'll rework the series to use that instead :)
>
> OK.
>
> There are two places that call idr_alloc() with a hardcoded limit of
> 0x10000, you'll have to fix those to have the right limit according to
> the bits you leave for the ACK id.

Yup, found those. Will send a new version of the series in a bit.

-Toke

