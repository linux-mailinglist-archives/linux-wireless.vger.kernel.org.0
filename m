Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB97ADC6BC
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408699AbfJROBd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 10:01:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22293 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408689AbfJROBc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 10:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571407290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9RSTGVJD9xVIyj975EqK/c+6MLtw+vWyhQYOOPRwQ4=;
        b=gtMWhQkejBmapTnLvD/RSLq6oAdomwnPK1p3BduXCgPVSkwLq2u8b5grRDNWRCG+TRY7Gi
        NNmff6tws23WRA0MPNe/B27p4TYL/sk0f8OTKX2Fui9eke9y4v3nxL92D5bCW2XjmoUZmf
        M/wg9lVnMsqLQblqzIwKRPc/1CHl5H8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-Fpxwl3oxPnOwGr0TYykhIg-1; Fri, 18 Oct 2019 10:01:12 -0400
Received: by mail-lj1-f199.google.com with SMTP id x13so1090021ljj.18
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 07:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9KU3AOEPNJNeSCWouDLYLTZDs7qEv20m2zC3KeyYxCQ=;
        b=Pr46+KduVpXiIm65Zc4U4eiKdlLAFZHHDwMhke4hrYiB4FysI3xlkJ5yRCw7R8AjjS
         dUMbl4kzNAgr3C3e7mklMmTlYFXP1Rk5oYAYaTDYmwyUp/EkK4z1yh+Ux/0bqAedOM9M
         H5npUHjoW3SqBKGEYzbPpmXMoimBAwjTzshkouLRI04fVoeYZJ1vl5Dz+vYXlfZkYueM
         OkrX7IJbhaXdKvr+ybvkper8Sd9L3/+Lr7M+XAXDz046hrd7wBWOmABEnOTGhLaB1Zzj
         /R/Mh2j24KP75Zei2TAl3075cHtP6KkQtEzQS/0f/XEcTjI5s0OzrLnGM3hQdPGQ4Mkw
         2ilw==
X-Gm-Message-State: APjAAAXR54F+g29fTp/3kEjhUxNE6Mkf+wC504IHLO4R5VMhthayT+Eu
        tYig7zMFFPgPv2plvTg1l9oQH2u2dnmiOhLeMhTKiksT3fyuJUUTihe35Ixi/7Zy1CoD+RGtOZH
        sYiYCNMJU4V8CLiIHuZ0pX0DOlJU=
X-Received: by 2002:a19:641b:: with SMTP id y27mr6274401lfb.3.1571407271185;
        Fri, 18 Oct 2019 07:01:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwC6odn8LyJJs0daZtmkS6VFaA8BtPD78mDU4XrBdIGwZMhS0aV6Gnwq4KieL+5R/+KfSjfzQ==
X-Received: by 2002:a19:641b:: with SMTP id y27mr6274369lfb.3.1571407270886;
        Fri, 18 Oct 2019 07:01:10 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id l25sm2867020ljg.72.2019.10.18.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:01:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0D5871804B6; Fri, 18 Oct 2019 16:01:09 +0200 (CEST)
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
In-Reply-To: <9fc60b546b54b40357264d67536733251cf39ebe.camel@sipsolutions.net>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115993866.2500430.13989567853855880476.stgit@toke.dk> <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com> <87sgnqe4wg.fsf@toke.dk> <10b885b3238cede2d99c6134bebcc0c8ba6f6b10.camel@sipsolutions.net> <87imomdvsj.fsf@toke.dk> <9fc60b546b54b40357264d67536733251cf39ebe.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Oct 2019 16:01:09 +0200
Message-ID: <87d0eudufu.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Fpxwl3oxPnOwGr0TYykhIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Fri, 2019-10-18 at 15:31 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote=
:
>
>> Well, let's try to do the actual math... A full-size (1538 bytes) packet
>> takes ~2050 microseconds to transmit at 6 Mbps. Adding in overhead, it's
>> certainly still less that 4096 us, so 12 bits is plenty.
>
> What about A-MSDUs? But I guess maximum continous transmissions are at
> most 4ms anyway, so a single packet should never be longer.

Ah yeah, those could be a bit bigger, but yeah, 4ms should at least be
enough.

>> That leaves
>> four bits for the ACK status ID if we just split the u16; if we only
>> ever have "a handful", that should be enough, no?
>
> It's how many are in flight at a time, 16 doesn't seem likely to happen,
> but I don't really know what applications are doing with it now.
> Probably only wpa_s for the EAPOL TX status.

Right. Well in that case, let's try it. As long as we fail in a
reasonable way, we can just see if we run into anything that breaks? I
guess in this case that means rejecting requests from userspace if we
run out of IDs rather than silently wrapping and returning wrong data :)

>> We could also split 5/11. That would support up to 32 ACK IDs, and we
>> can just truncate the airtime at 2048 us, which is not a big deal I'd
>> say.
>
> We can also play with the units of the airtime, e.g. making that a
> multiple of 2 or 4 us? Seems unlikely to matter much?

Sure, that's a good point! Increments of 4us means we can fit 4ms is 10
bits, leaving plenty of space for ACK IDs (hopefully).

I'll rework the series to use that instead :)

-Toke

