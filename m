Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4EDC75B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 16:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408333AbfJROar (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 10:30:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46253 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729584AbfJROar (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 10:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571409046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bakk7ZMdh+u0X+Hl2jLm9/YFhVpOg7xiWkA7OuAAt3c=;
        b=BOSadUsr5BV+E9tbZAgMG3i/5WkGu6pqrGmbiAXxxYVLjVIwyuXTzrBMk/Sg+D1yL6mHuq
        w4EqmCg4ORZr3H7DmyZRrxyiAtafnOnz7JVBewRwXfeVUqk7SUACRbyl3sO1h3+Fmb8lAc
        0zM/YeckUaclPqHMV/5zG4UIhaaQQvw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-n1EIdzZcOey4sN86CkCVkA-1; Fri, 18 Oct 2019 10:30:41 -0400
Received: by mail-lj1-f200.google.com with SMTP id m81so1115176lje.4
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2019 07:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rKJhlEJJw/5ARrgpbdb2WsNHVUGoOLGpeEW6RcLOYbk=;
        b=QS6SWlxTpVc7YlZEMZw7uVkMtZYBHM3cj3tqeUZvkv7Rw/+Oyu6DlevLKjqabai/CR
         SVI8cuPp1RbKd0u1NmMRDQmCprF3kfPB3wbg1bR6wmxT1iNeGCXvPuAYl0ho+f1IrriG
         zgpJn2K0nx2eXsvWM+AnyM+5V0SH5rzwsT7S6VVpWCJdvEBzzJIRZcRFoN3pdndkfytB
         xJSr6rFmlqOjNBFyrRkqzvAOgZEvCQieLQxnmARY9idc4scNeEQMTi9K8ULrEsHY5NwC
         PoIh/7JoIPmZ39S3uO+wez94YXRNAOVsrd2RVmai7ZcfnqC4W7R1ieYY2A/CTwv/q3pn
         MLZg==
X-Gm-Message-State: APjAAAXJXqmVQ41YchEsxY8fpej1qzuzl/arMmNyPsMq0OogV0DEhrmG
        9DDi/NL122cy+sPpeHDqeToE4N8AMxvEs7UCyeJ66xrXLUK4YSaB0kRqL9drLhC1NnSyCO/x1Nw
        frBOid4r0S3G27ef04O6KktUNYtA=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr594284lfi.24.1571409039651;
        Fri, 18 Oct 2019 07:30:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzILyzAuOEIj5ig6vIuTDFP316XFk3tSJVizLbq8TAYqZMR4SvKuZP0W2lfpHxx007dUHDYlg==
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr594270lfi.24.1571409039487;
        Fri, 18 Oct 2019 07:30:39 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id b20sm2413663ljo.106.2019.10.18.07.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 07:30:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3A6D81804B6; Fri, 18 Oct 2019 16:30:38 +0200 (CEST)
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
In-Reply-To: <78035e38264feac9d15a761b009c89b9738b4de1.camel@sipsolutions.net>
References: <157115993755.2500430.12214017471129215800.stgit@toke.dk> <157115993866.2500430.13989567853855880476.stgit@toke.dk> <CA+iem5t6xghBocck864nDX2snWQ5O+v6_M2Jc9aCdn_hE+mFCA@mail.gmail.com> <87sgnqe4wg.fsf@toke.dk> <10b885b3238cede2d99c6134bebcc0c8ba6f6b10.camel@sipsolutions.net> <87imomdvsj.fsf@toke.dk> <9fc60b546b54b40357264d67536733251cf39ebe.camel@sipsolutions.net> <87d0eudufu.fsf@toke.dk> <78035e38264feac9d15a761b009c89b9738b4de1.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 18 Oct 2019 16:30:38 +0200
Message-ID: <877e52dt2p.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: n1EIdzZcOey4sN86CkCVkA-1
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
>>=20
>> > We can also play with the units of the airtime, e.g. making that a
>> > multiple of 2 or 4 us? Seems unlikely to matter much?
>>=20
>> Sure, that's a good point! Increments of 4us means we can fit 4ms is 10
>> bits, leaving plenty of space for ACK IDs (hopefully).
>
> If you do need more bits (e.g. to be on the safe side and have space for
> 8ms) you could also steal bits out of 'band' (we only need 3 I think)
> and 'hw_queue' (not sure what the limit really is, but there aren't many
> users, seems like only iwlwifi/dvm and hwsim care, and those certainly
> don't need >32 queues).
>
> Of course if you leave more bits for later that's good too ;-)

Yeah, let's leave that for later. After all, with the limits we
currently have configured, if a single packet takes up 4096 us, that
will trigger the per-station queue throttling in itself, so I think
we'll be fine (famous last words).

-Toke

