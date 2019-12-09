Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F065116EB0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 15:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLIOKU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 09:10:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727720AbfLIOKU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 09:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575900618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8MHeSmErGIjySHPAAzp+CJ/YCYvZDrefSPRZN4SlDA=;
        b=FYl3vIC6599jLZlIpnUg+dhWdnf1Z7P8j/Dz/ye/WYTveD78wqVxe8Kh0mGNPKvSRNIsC/
        BjhIblQVT5Casskfb36DLE1K8a8+4eBpTv/EVtlDQ+DaxUDTBKEuX3zL8z/K62ddIN54cx
        wWsxzIqF80h/Xb1U0ya/JgaXI+rnWUk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-zrhEuhR6NPSIdynIysCarQ-1; Mon, 09 Dec 2019 09:10:15 -0500
Received: by mail-lf1-f70.google.com with SMTP id n24so2233142lfe.6
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2019 06:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=E8MHeSmErGIjySHPAAzp+CJ/YCYvZDrefSPRZN4SlDA=;
        b=sM7qjLXdplQPECNuNaYXMxO+ANHa1KjcA9bqequEfLQvkardNTd/osrwCJ3U4gWpSU
         eDid10BDYuiZ4G/Ne0CTTTlvW65ZcsnlB6Co25n+dnMV4u645peO1S+bzy7xJc5U13Cj
         +1XD44lDcGCB5pS1c/LXh4C+u7Bc/zD7GEf2rrqHY9gV0tqt1N+dkkPuMQeuk487qqJb
         hL1iUyWbnkZEbiMiR/NsZ90l80pDb54BUNcQw/orjzzkAjxc3U9LB7lGHnH3i1DHy4vb
         BkRQIu97APoWvD5ia8+iRIB9tjrfhj7T9ixMlUB+XqBYD5KbyTNErPF0pQEp2olG+2xH
         ZI1A==
X-Gm-Message-State: APjAAAWcC1Tg3j2ufjbL46Sig9gKKw2+LmW0QVf+yFsIU97UScfWES1l
        tZ5P71ZRjHpihZXE9ZJnquoRwMDGFqiMtVX0/iw8wgzF8TDqOFqSE9qsOfevwrpUsDXPXmTewUQ
        lbUux+CEAp6gIkzezTO0l7WYjjJY=
X-Received: by 2002:a2e:5850:: with SMTP id x16mr17025786ljd.228.1575900613925;
        Mon, 09 Dec 2019 06:10:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbgId3BcY2VrxCOO3tOzW3tTJ8ze5gQc8m0QowN0hydiXJKpH9z/cbAknaAe2Dzi4DnaAxQg==
X-Received: by 2002:a2e:5850:: with SMTP id x16mr17025767ljd.228.1575900613666;
        Mon, 09 Dec 2019 06:10:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r2sm10989213lfn.13.2019.12.09.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:10:12 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2182D181938; Mon,  9 Dec 2019 15:10:12 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: 5.5-rc1 oops on boot in 802.11 kernel driver
In-Reply-To: <87h829lpob.fsf@toke.dk>
References: <CAH2r5mvZ=S0FHGP+Y_r5f37TXVehv2shj9f6w67zBxfjR+Zt-Q@mail.gmail.com> <0101016eea3353da-835ca00e-d6c9-4e2c-aa0b-f6db8a4c518a-000000@us-west-2.amazonses.com> <87h829lpob.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 09 Dec 2019 15:10:12 +0100
Message-ID: <87muc1io8r.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: zrhEuhR6NPSIdynIysCarQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> Hi Steve,
>>
>> Steve French <smfrench@gmail.com> writes:
>>
>>> Noticed this crash in the Linux kernel Wifi driver on boot a few
>>> minutes ago immediately after updating to latest mainline kernel about
>>> an hour ago. I didn't see it last week and certainly not in 5.4.
>>
>> please CC linux-wireless on all wireless related problems, we don't
>> follow lkml very closely and I found your email just by chance.
>>
>> Full warning below. Steve is using iwlwifi.
>
> Right, we already got a similar report off-list, but with a different
> stack trace. I was going to try to reproduce this on my own machine
> today. However, the fact that this includes the iwl_mvm_tx_reclaim()
> function may be a hint; that code seems to be reusing skbs without
> freeing them?
>
> If I'm reading the code correctly, it seems the reuse leads to the same
> skb being passed to ieee80211_tx_status() multiple times; the driver is
> clearing info->status, but since we added the info->tx_time_est field,
> that would lead to double-accounting of that SKB, which would explain
> the warning?
>
> Can someone familiar with iwlwifi confirm that this is indeed what that
> code is supposed to be doing? If it is, I think it needs the patch
> below; however, if I'm wrong, then clearing the field could lead to the
> opposite problem (that skbs fail to be accounted at all), which would
> lead to the queue being throttled because the limit gets too high and is
> never brought back down...

Right, and now I did boot up my own laptop with the -next kernel, and
tested the patch. It definitely breaks things, so that was not the
issue. However, I don't get the WARN_ON either, so don't have any better
ideas. I guess we'll have to wait for someone who actually knows the
iwlwifi driver to take a look at this :)

-Toke

