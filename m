Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9508DBC43F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2019 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440695AbfIXIs7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Sep 2019 04:48:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34013 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439012AbfIXIs6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Sep 2019 04:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569314937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vX1x3OwxVW1gA9DDAeV4qit7OavOIJKGn/Wr1PtPc04=;
        b=M3j9nU2ffayrZgS6MGKwF3gnHQGnaIrIdUpcafJdh9DTL8rFEzY/9Qr+qRhtG08sEXNebS
        y484Na24Yc8F7OeF4qLHvhA231Lyyi27LaCXjtuFm681PRwz7moRIcnr3zgvmTePo8xvUP
        2EXDRA+AxIeQqUXv3C9feUyqz2msE5s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-tGOtcCHCPCyx6nD5Fh5LxA-1; Tue, 24 Sep 2019 04:48:56 -0400
Received: by mail-ed1-f71.google.com with SMTP id y25so619417edv.20
        for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2019 01:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=TKN7mJbs5ICiKXTXySTCfkZ4/+HSLF+fQVqMVK7B8kI=;
        b=RcghwtCyg0TWLnU9uB8eEEME5zVDiXuzEpUV+BTUxOk3VNn3JnZkhzQySXgoxg+HQB
         yZA/iwTvM2eskzgxLj2wPFHs328TIaHx3w/nvyMqKT0Kmr0KJE/m1Pn6nch5aqIv72uC
         mj2KTCQjsvLc5L3+FJNUGwlzSYe27sQqVtXNT6s5v/hnC76/yS/rjBLATqMgPKPrcXHg
         Dq2loglf/ek+bBi/Mu0pywxyLRwx3fIZB9dZXvDFPG8VLNeKmoZb6YXblGYUENWaVuOa
         tKCsmBygvI1pHrWDtMcV3W8A6ikFlB57H9aJSpADr++y5tdUk4R4raMxTzPd5vwmaNlz
         0dMQ==
X-Gm-Message-State: APjAAAUl2RPzz5oEvACWN2/D4R0ZZonzIGfUQ75Gf7kAC+30gOsEFIqY
        caK+Ws68S8V19BsVIdeoYEFJEXdct5UUqc5SajgZia4vjq4nFKAQVQ4AG89eqnXrG2Rk9CxXha5
        jkZ2xWIrcwXtnInJ75EdbDahY9Jw=
X-Received: by 2002:a50:e791:: with SMTP id b17mr1408509edn.11.1569314935207;
        Tue, 24 Sep 2019 01:48:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZpr7o9y+z4g1i/DDY9nWdtJYS8D6BJlhn8xZVR+d5IMWf5V+rMVb0EskxpmiqhLjRP4VskA==
X-Received: by 2002:a50:e791:: with SMTP id b17mr1408500edn.11.1569314935067;
        Tue, 24 Sep 2019 01:48:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id y29sm242525edd.7.2019.09.24.01.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 01:48:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E974318063F; Tue, 24 Sep 2019 10:48:53 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yibo Zhao <yiboz@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH V3 3/4] mac80211: fix low throughput in multi-clients situation
In-Reply-To: <2aab0bd944ee34751304a5f92b885113@codeaurora.org>
References: <1569223201-1490-1-git-send-email-yiboz@codeaurora.org> <1569223201-1490-4-git-send-email-yiboz@codeaurora.org> <87impj5lkm.fsf@toke.dk> <2aab0bd944ee34751304a5f92b885113@codeaurora.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 24 Sep 2019 10:48:53 +0200
Message-ID: <87d0fq3wqy.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: tGOtcCHCPCyx6nD5Fh5LxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yibo Zhao <yiboz@codeaurora.org> writes:

>> I can see why we need the second part (basically, this happens because=
=20
>> I
>> forgot to add a check for "no eligible stations" in may_transmit(),=20
>> like
>> the one in next_txq()). And rounding up the division result doesn't
>> hurt, I guess. But why does it help to change the grace period if we're
>> doing all the other stuff?
> In multi-clients case, it is possible a TXQ sometimes gets drained due=20
> to FW has deep queue and few packets in TXQ at that time. So the TXQ is=
=20
> removed from the rbtree after dequeuing. When it is about to added back=
=20
> very soon after the removal, the g_vt might have gone a little far away=
=20
> from sta vt where sync is needed. With this sync, the station is forced=
=20
> to catch up with the g_vt, however, its chance for transmission has been=
=20
> reduced. I think 500us is quite a short period in multi-clients case.

That's a good point, actually: Having the grace period be too small will
allow stations that leave and re-enter the queue to "skip ahead" and use
more than its share. However, I think it's a separate issue from what
this patch is about; so how about I just increase the grace period in
the next version of the base patch?

-Toke

