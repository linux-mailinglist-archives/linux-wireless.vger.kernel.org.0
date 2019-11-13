Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D135FB20C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 15:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfKMOCW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 09:02:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59216 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727129AbfKMOCV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 09:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573653740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8zN9uWkP7CUfQN6wLUGfJKeTOPoPLldWS17arxPNEg0=;
        b=MzKJiB3gHGhauhEQnzmI6wFrrAPZidZHILoacaygOE6hPXvXnIpB7E9TQTNvuMjxUXLVtt
        wcoo6bJlUzL/jpneCMDBVO0/96Z+r1NbPRgvDOHKUuSxs4kXujpMBzqQiECMWd4kyojOUc
        IPe0XIdtDVGRX756CcTvdST3P5k8ruI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-1W355UsHO5qpZlGIFzpGnw-1; Wed, 13 Nov 2019 09:02:16 -0500
Received: by mail-lj1-f198.google.com with SMTP id e12so243514ljk.19
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 06:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=J+H+PxGzqPrRW5FjT+UNTmmU9n8VS97HbTwR5IJ901M=;
        b=OXoSm6/C5XHv7FeDljWm90+CKX370KHBHBV0iiMEZrJZ60h58Z0KfDOn4cXj9Hmjlv
         CAp56T5gEpprLZ6IXSype3ig8no7xBUMz0yZ3429KzuSV3jJMKybhBgaBwwRTuMwg79j
         qIzKallCUblMpyrIJwIKlRa6zlSuTdZa1mivRNdlVF8x5/zq+Jzt3yg4OeSjl6HZoJ7W
         Qv6CFL2HQbujyZjhwTdEEHdUTU4IGB4WGy6r8DCv9Yitegj9tdhVFkFNZcSdxIp0amW5
         Q/a1TDo4K3X2bu9h4Z5FE/D4KZhUfmfgFbvXIJH5DWRhX3udK9DLNoMxBjS/FCDVSMJN
         leUA==
X-Gm-Message-State: APjAAAWqaido9lkaFvz2Yc4+/MBG7DARyyFpPhyAKaEDRRSFV/nqGJfV
        /enPzvPAN0SYSD54fGOJN6nELkOboSgdPX42WVHWAsAdP4nE0aOgOhc+4P8HJHdaRFsJY4rYw/j
        4KwNLB4D0tMJ85Ca0pkvfnGRGtTk=
X-Received: by 2002:a19:790c:: with SMTP id u12mr2971852lfc.183.1573653735327;
        Wed, 13 Nov 2019 06:02:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTR6Pu42EVoLqVM1tBLpy1vmX7MXyLbpDsHRkkP2CNzoiTuBWU8vSbHCfI5Wyc2HYKZIHBdg==
X-Received: by 2002:a19:790c:: with SMTP id u12mr2971804lfc.183.1573653734783;
        Wed, 13 Nov 2019 06:02:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y21sm886415ljm.25.2019.11.13.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 06:02:14 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 223C41803C7; Wed, 13 Nov 2019 15:02:13 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kan Yan <kyan@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Make-Wifi-fast <make-wifi-fast@lists.bufferbloat.net>,
        Felix Fietkau <nbd@nbd.name>, Yibo Zhao <yiboz@codeaurora.org>,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Subject: Re: [PATCH v7 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
In-Reply-To: <CA+iem5vrM0iF+yvS9m==UWnhp=DFV924ir-0nHcn6cwarEjZNA@mail.gmail.com>
References: <20191112021136.42918-1-kyan@google.com> <20191112021136.42918-2-kyan@google.com> <871rudqpsg.fsf@toke.dk> <CA+iem5vrM0iF+yvS9m==UWnhp=DFV924ir-0nHcn6cwarEjZNA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 13 Nov 2019 15:02:13 +0100
Message-ID: <87woc3oowq.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 1W355UsHO5qpZlGIFzpGnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Thanks for the review. I will pick up your new patches and give it a
> try tomorrow.
>
>> Why is this setting sta and device limits to the same value?
>
> local->aql_txq_limit_low is not the per device limit, but the default
> txq_limit for all STAs. Individual stations can be configured with
> non-default value via debugfs entry
> "netdev:interface_name_x/stations/mac_addr_x/airtime". "aql_threshold"
> is the device limit for switching between the lower and higher per
> station queue limit.

Oh, right, I see. But in that case, should writing the default really
stomp on all the per-station values? If I set the value of a station, I
wouldn't expect it to change just because I changed the default value
afterwards?

>> Also, are you sure we won't risk write tearing when writing 32-bit
>> values without locking on some architectures?
>
> Does mac80211 ever runs in any 16-bit architectures? Even in an
> architecture that write to 32-bit value is not atomic, I don't think
> there is any side-effect for queue limit get wrong transiently in rare
> occasions. Besides, the practical value of those queue limits should
> always fit into 16 bits.

I'm not sure about the platform characteristics of all the weird tiny
MIPS boxes that run OpenWrt; which is why I'm vary of making any
assumptions that it is safe :)

But yeah, I suppose you're right that since we're just setting the
limit, it is not going to be a huge concern here...

>> I don't think this is right; another thread could do atomic_inc()
>> between the atomic_read() and atomic_set() here, in which case this
>> would clobber the other value.
>> I think to get this right the logic would need to be something like
>> this:
>> retry:
>>   old =3D atomic_read(&sta->airtime[ac].aql_tx_pending);
>>   if (warn_once(tx_airtime > old))
>>      new =3D 0;
>>   else
>>      new =3D old - tx_airtime;
>>   if (atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending, old, new) !=3D ol=
d)
>>      goto retry;
>> (or use an equivalent do/while).
>
> That's indeed not right. However, if a potential aql_tx_pending
> underflow case is detected here (It should never happen), reset it to
> 0 maybe not the best remedy anyway. I think it is better  just
> WARN_ONCE() and skip updating aql_tx_pending all together, so the
> retry or loop can be avoided here. What do you think?

If we don't reset the value to zero may end up with a device that is
unable to transmit. Better to reset it I think, even if this is never
supposed to happen...

-Toke

