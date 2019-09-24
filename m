Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F656BC28E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409307AbfIXH0g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 03:26:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409285AbfIXH0f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 03:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569309995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bB6TxRbain4WIDuZF37AFcbI5yiKvhEh7P47JkbPNmE=;
        b=drPCx8qS+4Y4rEgebPH6USePtirgkuGHjzx0oPvdT2zOY2LBL9XTBN8iZL71GZJ52hunWo
        hniJvnWWBooADmxSPzwG/lDC+qZLskRl9uWUTRAr+b02hFuEnAqx12Q55UR0N2KAWKPTzc
        u+zBM2hQCENCUSjNNTNFdKQRWaEueZo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-fDgtc5XJPcSX7clEs1ghCQ-1; Tue, 24 Sep 2019 03:26:31 -0400
Received: by mail-ed1-f69.google.com with SMTP id c90so494054edf.17
        for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2019 00:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/DbcvOaQW52kpEy5mspgh7NMJnYjChbVEruifrXRTR8=;
        b=s1z2RykqgkXyf5jgDy8dsjFbkBhwb2fazekYatkZxAk7Xy6yNO7KDGeo7PrsjvbGKg
         OCB6MT2FkDFctTaPRccf/0tb20+kNnWrgV0x4Qe/UeUmshg0LneLSYcSM2EMi8h0I+w4
         sW/a/LqwgvLTgB+jnGgGfbnYnNn9MedYoowqhr4LJ2tMpVF7ELImKV6JUc9KL0cNMTLf
         ozbI7mRkr0OXSEOTfN7+cwOOt4tTykpc1UejUPfmDn8k2EiiCxYwRZY0sj2uDCyo5gr+
         an5j85efg1gdoeb5qqTXJSHScOXOfWPu4PNMCNAOzBfdJeJUAMFIWELZN1W/twKdC0AW
         +Nzw==
X-Gm-Message-State: APjAAAXqPK5Jsb8P9U4wO6arfa2vmnwbT3G2DdIk7QLc4xEz8dX6S1my
        fX93hHhrumCGDGyIbgLWA+CP4QzNOK+X91sDsmkzHedmsZbTeHTvast4vhv3BAAgU3lc2dKD3Zr
        4B8uSbrPeoLRTGzFnBqXq2MPGBz8=
X-Received: by 2002:aa7:d688:: with SMTP id d8mr1194196edr.156.1569309990055;
        Tue, 24 Sep 2019 00:26:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYzOy3Wq0d8MIIgN/rs7j5umPy/q/GAygXGRQo8TPGdg81MuEx3Hkxu6uQT6y17g2M2kyDRA==
X-Received: by 2002:aa7:d688:: with SMTP id d8mr1194188edr.156.1569309989866;
        Tue, 24 Sep 2019 00:26:29 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id dt4sm106620ejb.45.2019.09.24.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 00:26:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B0F1C18063F; Tue, 24 Sep 2019 09:26:28 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH 2/4] mac80211: defer txqs removal from rbtree
In-Reply-To: <1b3eab1f2481e0102b284f133605c6c4@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org> <1568639388-27291-2-git-send-email-yiboz@codeaurora.org> <87pnjyiq7o.fsf@toke.dk> <c3ee7ece0986f1c50513cd5fdd2ee03f@codeaurora.org> <87sgothmpy.fsf@toke.dk> <8cdece5c030fd95817fb099021c38613@codeaurora.org> <87tv98fu6l.fsf@toke.dk> <1b4ab006d9b5c88035845aaac193ef48@codeaurora.org> <8736gre3bm.fsf@toke.dk> <198124204167325252fcfcd65e3f2733@codeaurora.org> <87ftkp7uuz.fsf@toke.dk> <4574cce4079f8dab2b2bf223431a6eae@codeaurora.org> <877e617qg2.fsf@toke.dk> <910d9bb5f9016b29fb2aaeb0b89bac38@codeaurora.org> <874l157nrt.fsf@toke.dk> <2935b00bf3e29ad8b2738fe98dc24a76@codeaurora.org> <87lfuf5ly2.fsf@toke.dk> <1b3eab1f2481e0102b284f133605c6c4@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 24 Sep 2019 09:26:28 +0200
Message-ID: <87r24640kb.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: fDgtc5XJPcSX7clEs1ghCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>> Hmm, yeah, I guess we could end up with a loop like that as well.
>> Keeping the schedule_round would be a way to fix it, but I'm not sure=20
>> we
>> should just skip that station; maybe we should just end the round
>> instead?
> I am not sure. I believe, in some cases, the rest of the nodes which=20
> could be most of the nodes in the tree will not have the chance to be=20
> scheduled in this round.

My guess would be that it doesn't really matter, because in most cases
each schedule round will only actually end up queueing packets from one
or two stations; as the driver will pull multiple packets from that one
station which will often fill up the firmware queues (especially once we
start throttling that with the AQL stuff).

So I guess we can just skip TXQs that we've already seen this scheduling
round, and let the v_t compare determine transmit eligibility :)

-Toke

