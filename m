Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5B107291
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKVM4c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:56:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27776 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726836AbfKVM4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574427390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KZZqFDWqvlMMFoRSYAezA8tSd4brzrxOsFXtDdI8/H8=;
        b=AvErvV0TaXTop8F439AoqFlzjr93wBfH7R5/xXCsQ0bMofRSJPBusUtuVfBGPDEjzB5sNz
        k/BBmHPdM77yl3D0hEZ4tK3/ZamxD3Qd4rQNc9GNtP93ih23KrOL0YVagNoThvKtnj8WdY
        SgAkuDyfMi4mGv5MSQwTtjmUPD3cuCw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-OEzA-kQmO022x4LG57WPNw-1; Fri, 22 Nov 2019 07:56:29 -0500
Received: by mail-lj1-f200.google.com with SMTP id u6so1297171ljg.8
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 04:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KZZqFDWqvlMMFoRSYAezA8tSd4brzrxOsFXtDdI8/H8=;
        b=bC8Ha1Orpkd3rPAaZbv6w+LG4BtabL4nagv3Oo/CVWgZyvdRZm3tV3cpFsgje0hPqT
         WEDazvmRz6bvrNOIEZewp9Ppm5J3pKA59E5dkEGxmP23/L+S2U9+RRPPVx6YDjxsI7xg
         +xel9WeyyrPEHMeQh+HyGE8fo5TuUaJ/2v31Pt6fQBdsBVCmUXykOrD8fNy73SsKDQB9
         5CbHcNb28GNjYNMookTpdEjTubr+UDdbz1bB1auzoewkbunawvy0WibpGMymIim46OQU
         z/mQAqB5lrc5jq9YcT7yepN6sAE6lxejlbt3bb95LbQZUsONs2msoJ2IfNpA316I3RJF
         En9w==
X-Gm-Message-State: APjAAAVgmP/uriugneHtgTwWxGfY+lAQ1Wr9XwiTq/5fLt+eo7jeeMtu
        KGdbxI8HYivRmSGbFsOGWgdp0uvAPWhVLILnFm/Ay/QzanuXx+iwK2MUs2RqyRLdWq0IS5PdAFW
        BTP9DpaU95MPSS0E9fpUnQbHl6lc=
X-Received: by 2002:ac2:5f0a:: with SMTP id 10mr11782714lfq.57.1574427387565;
        Fri, 22 Nov 2019 04:56:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyM+scGkITeEjkDI5ttlc4qaK8t9f3w2wOV392mxY0gkbSf8TGyCC6mRQejmCZhVHicohf2cA==
X-Received: by 2002:ac2:5f0a:: with SMTP id 10mr11782702lfq.57.1574427387352;
        Fri, 22 Nov 2019 04:56:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id u4sm2924660ljj.87.2019.11.22.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 04:56:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 031A51800B9; Fri, 22 Nov 2019 13:56:25 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, nbd@nbd.name,
        yiboz@codeaurora.org, john@phrozen.org, lorenzo@kernel.org,
        rmanohar@codeaurora.org, kevinhayes@google.com
Subject: Re: [PATCH v11 2/4] mac80211: Import airtime calculation code from mt76
In-Reply-To: <3e7bea0cc643714ec90978a7999022544a39b118.camel@sipsolutions.net>
References: <20191119060610.76681-1-kyan@google.com> <20191119060610.76681-3-kyan@google.com> <3e7bea0cc643714ec90978a7999022544a39b118.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 22 Nov 2019 13:56:25 +0100
Message-ID: <87tv6w3w92.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: OEzA-kQmO022x4LG57WPNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> On Mon, 2019-11-18 at 22:06 -0800, Kan Yan wrote:
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>=20
>> Felix recently added code to calculate airtime of packets to the mt76
>> driver. Import this into mac80211 so we can use it for airtime queue lim=
it
>> calculations.
>>=20
>> The airtime.c file is copied verbatim from the mt76 driver, and adjusted=
 to
>> be usable in mac80211. This involves:
>>=20
>> - Switching to mac80211 data structures.
>> - Adding support for 160 MHz channels and HE mode.
>> - Moving the symbol and duration calculations around a bit to avoid
>>   rounding with the higher rates and longer symbol times used for HE rat=
es.
>
> :)
>
> I'll apply this, I guess,

Great!

> but I do wonder to what extent it overlaps with
> cfg80211_calculate_bitrate()?

Well, one calculates bitrates while the other calculates airtime? ;)

But yeah, I get what you mean. I think Felix went through quite some
pains to structure this code to avoid divisions in the fast path. I
guess that is the main blocker for cfg80211_calculate_bitrate() to be
used instead (assuming we do want to consolidate them eventually). Not
sure if that can be fixed easily though?

-Toke

