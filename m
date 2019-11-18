Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17762100223
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 11:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfKRKKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 05:10:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbfKRKKh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 05:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574071835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G45mRJb2R55hTpqWOgmQqio32gnIzC1eCmtGv4EySOk=;
        b=T4005Zk9b5okSvR7UIrqB8OMKUGFatc+7TMaFuYy4yGfP4rqv/N4cXmpe021/jcbi4UUqS
        0YGRQy/JodIgBYjeZaEBjytMBFROtLUlYzbmiQJ6XsYSwI1PcT+pJa0S5un/8GXrwB20CQ
        d5+hvIsnbzRvlOLvH8md6lXC/SBt8QA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-O5AGdHMWMGGmG_KY2qyv8A-1; Mon, 18 Nov 2019 05:10:32 -0500
Received: by mail-lj1-f199.google.com with SMTP id l12so3134609ljg.21
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 02:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OIQCTBj1ZZClWzpd5quqOflGEWiO+R0tbK558qeMbh4=;
        b=BD5V0q5hANewYJZ/8Q46hyTVIvFoFg1zPRPac478yOzrlVHJ9OzNPDp4ZTP2DrsE+8
         XHSExIN35nKPX3nd1k6XKCFaTO7u/lap3qa28qfU+HAlhcF5gXbNhzN3ayPvyQPxqTiA
         d1u7VdWcSnUrXWFzsskOTd+VotbgUEJ73XNVyXOz4shqWBafzTFpxRw4yaJlVF5A8wK3
         Fpq862I+KQcsRSSA7AN70L09zKC5b1C0Io7Ta7K64dz0Ra2/0vvXpmcoSob7WCZBpQU7
         L3KAoQaoo6vzxeYM7vx74w9jxEapGirXdSSkYbw3q3aWbtoRFI5WDsK4uchs1WtTHbvf
         rwJQ==
X-Gm-Message-State: APjAAAVRkF6R202HtZhauTwKCIeR5WD8e9DOOsptJj4cnW2icy0Ch4O8
        rHgCp+PI4NmMAUhNz4I6LZWBNaoQkV2s1oP5K94/tG/rgyahZWNF+nl5o62ssdwanrTHsQ4Ndsq
        PaHdKDbyn+zlal7La+QOwcruKKXk=
X-Received: by 2002:a05:651c:1109:: with SMTP id d9mr20056936ljo.192.1574071831434;
        Mon, 18 Nov 2019 02:10:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyx34G0PV/fe8D53a+QUqfm/vO0wSGhLgSfIKtC5qf0UKXzF5h1YYJhlKi/PARk15AMZvmAJA==
X-Received: by 2002:a05:651c:1109:: with SMTP id d9mr20056921ljo.192.1574071831296;
        Mon, 18 Nov 2019 02:10:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id o196sm8775203lff.59.2019.11.18.02.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:10:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DF6B118190D; Mon, 18 Nov 2019 11:10:29 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v9 4/4] mac80211: Use Airtime-based Queue Limits (AQL) on packet dequeue
In-Reply-To: <CA+iem5vVhwTsTvAgnC_HF0utMDSfgyLCe2M=gfUOFU2VjjCB8Q@mail.gmail.com>
References: <157382403672.580235.12525941420808058808.stgit@toke.dk> <157382404118.580235.14216392299709793599.stgit@toke.dk> <CA+iem5tF+TN-osfGxu=EU5Xt1Uq+PcKgBVaoAmZY3a3JzS5JzQ@mail.gmail.com> <87y2wgjas4.fsf@toke.dk> <CA+iem5vVhwTsTvAgnC_HF0utMDSfgyLCe2M=gfUOFU2VjjCB8Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 18 Nov 2019 11:10:29 +0100
Message-ID: <87muctcx62.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: O5AGdHMWMGGmG_KY2qyv8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

>> > Given the fact that AQL is only tested in very limited platforms,
>> > should we set the default to disabled by removing this change in the
>> > next update?
>> >
>> > -       local->airtime_flags =3D AIRTIME_USE_TX | AIRTIME_USE_RX;
>> > +
>> > +       local->airtime_flags =3D AIRTIME_USE_TX |
>> > +                              AIRTIME_USE_RX |
>> > +                              AIRTIME_USE_AQL;
>> > +       local->aql_threshold =3D IEEE80211_AQL_THRESHOLD;
>> > +       atomic_set(&local->aql_total_pending_airtime, 0);
>> Well, we have the whole -rc series to get more testing in if we merge it
>> as-is. It's up to the maintainers, of course, but I would be in favour
>> of merging as-is, then optionally backing out the default before the
>> final release if problems do turn up. But I would hope that the limits
>> are sufficiently conservative that it would not result in any problems :=
)
>
> Sounds good. The current default limits are reasonably conservative
> and are tunable via debugfs.
>
> I will give the v10 version of this patch serial a quick test and
> hopefully we can wrap it up soon.

Sounds good, thanks! Also, seems we got a 5.4-rc8 yesterday, so we have
another week before the merge window.

Johannes, any chance you'll get a chance to take a look at this sometime
this week? :)

-Toke

