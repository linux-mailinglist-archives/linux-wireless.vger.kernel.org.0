Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D144CD6AA
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Oct 2019 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfJFRkv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Oct 2019 13:40:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730011AbfJFRku (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Oct 2019 13:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570383648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OplA5Eho1GIEW8dDMs+xxflTmjf1UF/kSpiSZWDT73c=;
        b=bxdx6AgxYptqRCVhvjdMQe6jvrNTUie4qtaYs41qIHaIuSHQnNxAgpHKLgG9mVeQZu25Rg
        IelYLP2/sBKXo6jwHZnUvNM/1qmewwm5uRcdri7kN/+o9fRUVw8Z1AWLZrpNYyXIvvCe+O
        B/1RubRabhNv2rKj0m9eK382Zh6HMrU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Ud0LdVA0PqWvlfD9sk8b1A-1; Sun, 06 Oct 2019 13:40:45 -0400
Received: by mail-ed1-f72.google.com with SMTP id l5so7477956edr.10
        for <linux-wireless@vger.kernel.org>; Sun, 06 Oct 2019 10:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wZ8y88e72WyyshxxhVRkdi4DU4ry9fvzWnGuXY2vT1Q=;
        b=Nnp2tFwYaP7CZQD413WaPxF2Xo4DKetYjXBXwUlM2Frtj/0dET/9LUk2Fxx2s8agHh
         SRlSDkndn4F9oPcxpQSfc9TkftHyfLNLdCcapCwIc4ml59BSxMUFbLY7Jk5c4ECKK35D
         TYt4GWEjVQBDozAg/UgFSqy/prlfprxT1zQth1RaQ0ivx4b6Bz4goGKCIoWiy6T1lReC
         Ns/VSN4Ij4cstd83SmZyt0xWktnpj4P3hkUNtGuY8TNFHXlORzS/b2b3Mjf1HFm0DZa5
         TM0amuw0HbdjVcm9FG7/GN01An7tRdKJsl5l5lYX81ZBXbs4lWWkYPjU8ZeBzhYbQavC
         q/BQ==
X-Gm-Message-State: APjAAAViN3dxuVTQ8cDlFC9/HemGjU5mEszA3MY9KeqQxzYbf5/M/R52
        EO9g6lT6g5E2/lqMPBMt8hqLKFkTqDhGqbV6mniHotbGW7VrIaPFtwW89lF4H68PUTKujCH+n63
        CQMJ69cDJR1iMdolj+2UIjm22VjM=
X-Received: by 2002:aa7:d688:: with SMTP id d8mr25510700edr.156.1570383643706;
        Sun, 06 Oct 2019 10:40:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxz+Mr44y1o6iTqmFxjA2C8R7UKKt5W88AlsDY6m5Zm3OCto1orWgmWTjOhIaNZywlG8943iA==
X-Received: by 2002:aa7:d688:: with SMTP id d8mr25510684edr.156.1570383643450;
        Sun, 06 Oct 2019 10:40:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id g9sm1509091ejj.51.2019.10.06.10.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 10:40:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4941718063D; Sun,  6 Oct 2019 19:40:41 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        Yibo Zhao <yiboz@codeaurora.org>
Subject: Re: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <CA+iem5vJFRxskyHOKf5K73X8aGH965P4hoiCj-wQtK-Z-47pdg@mail.gmail.com>
References: <20191004062151.131405-1-kyan@google.com> <20191004062151.131405-2-kyan@google.com> <87imp4o6qp.fsf@toke.dk> <CA+iem5vJFRxskyHOKf5K73X8aGH965P4hoiCj-wQtK-Z-47pdg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 06 Oct 2019 19:40:41 +0200
Message-ID: <87pnj9n55y.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: Ud0LdVA0PqWvlfD9sk8b1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Hi Johannes,
>
> Thanks for help review this patch.  I will fix all style errors.
>
>> > +ieee80211_txq_airtime_check(struct ieee80211_hw *hw, struct ieee80211=
_txq *txq);
>> Why is it necessary to call this, vs. just returning NULL when an SKB is
>> requested?
> This function is also called by ath10k, from ath10k_mac_tx_can_push(),
> which returns a boolean.
>
>> However, I'm not sure it *shouldn't* actually be per interface (i.e.
>> moving from
>>         local->aql_total_pending_airtime
>> to
>>
>>         sdata->aql_total_pending_airtime
>>
>> because you could have multiple channels etc. involved and then using a
>> single airtime limit across two interfaces that are actually on two
>> different channels (e.g. 2.4 and 5 GHz) doesn't make that much sense.
>>
>> Actually, it does make some sense as long as the NIC is actually
>> channel-hopping ... but that's in the process of changing now, there's
>> going to be hardware really soon (or perhaps already exists) that has
>> real dual-band capabilities...
>
> That's a good point.  I haven't thought about real simultaneous dual
> band chipset and such chipset do exists now. Is RSDB support coming to
> mac80211 soon? Just curious if it will be just virtual interfaces or
> something else. I chose "local" instead of "sdata" thinking about the
> case of several virtual interfaces (AP, STA, MESH) operates in the
> same channel, then the interface total could be a better choice.
>
> I am ok with moving the "aql_total_pending_airtime" into sdata, but
> afraid that's not the most optimal choice for the case of multiple
> virtual interfaces operates in the same channel.
> Maybe we could leave it in "local" for now. What do you think?

I'd lean towards keeping it in 'local' for consistency with all the
other airtime stuff. For now, I think having multiple SSIDs on the same
radio is more common than the reverse (multiple bands on a single
radio).

In particular, the per-group airtime fairness stuff is definitely
designed on the assumption that all BSSes share the same band.

So if and when we start supporting true multi-band devices we'll have to
change these things anyway. So might as well keep everything together so
it all gets fixed :)

-Toke

