Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8545DBC435
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 10:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440670AbfIXIoH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 04:44:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46057 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439012AbfIXIoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 04:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569314645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3rkN8MH0IxkN2ptEk2A38ufQaZUiB5IkfFSgtoEu5oY=;
        b=KgkslaluHDQNz9QcOQC28SIr634YgstGHlukhzQ0yEydqDAiL02B9zfk+yhW9L7qfWNMt9
        Th5v3QZeCCMCz6LapJVHUYT5J4pvwgoo+oKwDg6ZnDVljYq++A+bTsykXaLXg1a7BMwr5/
        IphJmH0nkOsREMRkVncXQVsjC4Ifqnk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-xktv0HqzPpiOYMatIZlV_Q-1; Tue, 24 Sep 2019 04:44:04 -0400
Received: by mail-ed1-f70.google.com with SMTP id w12so630167eda.6
        for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2019 01:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0s+wvn51JwcIE6+b/0TfX281k8oD+BZhgHvYh3Sx18c=;
        b=rA0nN485kTcp4qfD7Nayuf2YAhyrz9Cg8OM7YGrI1DwqaimqK8MbQpAR7BxQP6eOsm
         eN13cQLPMNV+Ko5mOeKcKVHri+HlPk8hKp5/A3c+zxydIKPP//c14J3YYoJ3D7Jpw77A
         JWCaeCQTqBRx1MHKgdbw37pVcZYNUnHhGIpQzF459n2fzz/HHgQ1aBWnzP4eyjHi9Wak
         BZ+zKpToiEQWib931DvMVMVh4KKtCMXFlRjj/7XgF7eO/mm/JTWUFy9hZjuW3mkgx0V2
         ffiRfBfrq6S4tC11XvU5lBjSY7/F+cql/ni7+cK/2s1CNYSgZwxh1NkRcmxfyLq/jrYg
         IdVQ==
X-Gm-Message-State: APjAAAVjexCGPVnDaexaoBEzA0WlaVh4x1fTGS8nlz+YgFZvELfMa234
        Oa5KAg9296FHV7LWP9Z/6M/RiRx53pprddovtXw9oslUnfEu2PxqcdVmD/4/3V2HPkjVvIfBqSR
        xba8cXz/ygC0CQJeYk4QZM3NYDLY=
X-Received: by 2002:a50:8a9d:: with SMTP id j29mr1427602edj.283.1569314643536;
        Tue, 24 Sep 2019 01:44:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw5GhLsosb8d3+pHn5gjMGcFz9uQMDJluWXWbFjtnzdAbrmy7O7xL/JLo+YgMsFyvkeIJ/M8g==
X-Received: by 2002:a50:8a9d:: with SMTP id j29mr1427590edj.283.1569314643335;
        Tue, 24 Sep 2019 01:44:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id f36sm238153ede.28.2019.09.24.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 01:44:02 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 22FD018063F; Tue, 24 Sep 2019 10:44:01 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <4cb086a2ec62b6bb127d933d2dcfb17c@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-2-git-send-email-yiboz@codeaurora.org> <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org> <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org> <87tv98fu6l.fsf@toke.dk> <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org> <8736gre3bm.fsf@toke.dk> <198124204167325252fcfcd65e3f2733@codeaurora.org> <87ftkp7uuz.fsf@toke.dk> <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org> <877e617qg2.fsf@toke.dk> <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org> <874l157nrt.fsf@toke.dk> <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org> <87lfuf5ly2.fsf@toke.dk> <1b3eab1f2481e0102b284f133605c6c4@codeaurora.org> <87r24640kb.fsf@toke.dk> <4cb086a2ec62b6bb127d933d2dcfb17c@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 24 Sep 2019 10:44:01 +0200
Message-ID: <87ftkm3wz2.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: xktv0HqzPpiOYMatIZlV_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

> On 2019-09-24 15:26, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Hmm, yeah, I guess we could end up with a loop like that as well.
>>>> Keeping the schedule_round would be a way to fix it, but I'm not sure
>>>> we
>>>> should just skip that station; maybe we should just end the round
>>>> instead?
>>> I am not sure. I believe, in some cases, the rest of the nodes which
>>> could be most of the nodes in the tree will not have the chance to be
>>> scheduled in this round.
>>=20
>> My guess would be that it doesn't really matter, because in most cases
>> each schedule round will only actually end up queueing packets from one
>> or two stations; as the driver will pull multiple packets from that one
>> station which will often fill up the firmware queues (especially once=20
>> we
>> start throttling that with the AQL stuff).
>>=20
>> So I guess we can just skip TXQs that we've already seen this=20
>> scheduling
>> round, and let the v_t compare determine transmit eligibility :)
>
> I am a little confused. So do you mean it is fine for you to skip the=20
> TXQs we met in this round before and continue the loop until the end or=
=20
> vt comparison failure?

Yeah. In most cases it won't make any difference; but it'll make sure we
visit all eligible TXQs in all cases, so we might as well do that if
we're tracking the scheduling round anyway.

-Toke

