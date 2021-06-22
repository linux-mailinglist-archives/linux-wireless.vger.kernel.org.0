Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B183B075A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhFVO1b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 10:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhFVO10 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 10:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624371910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCflcc9DDHTNNAkd92nsNiNwbbVljRsMVFiiBCW1kJ0=;
        b=dy8SiCK3qhwdA4pmbMWaLNgQkI0QXiOo4TloUm7KTDP9aZJR3ieYH3Y+7TT5tnoSy8rOYN
        nhfXWhwMFWKSoluq5W+rCxmIfcg4U8R5vw7ul00/X+ZdJpm+f10rKl50VXH7MYstLYnael
        jcO10gLdbJH15yeTMpw1fVBDCzKhyfU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-_1XNrca3Mua-5ZCDLnQw0w-1; Tue, 22 Jun 2021 10:25:08 -0400
X-MC-Unique: _1XNrca3Mua-5ZCDLnQw0w-1
Received: by mail-ej1-f70.google.com with SMTP id q14-20020a1709066aceb029049fa6bee56fso2089091ejs.21
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jun 2021 07:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=LCflcc9DDHTNNAkd92nsNiNwbbVljRsMVFiiBCW1kJ0=;
        b=gECqBvJKHzBWohoEnBwnkGGepzJ753HUM4dbFBZm6c/tDpfC69iUa2E2r0uSRKPJ9B
         7lcHcgC57d7unb3uGOKpjCfAfClbKLyFDwmZVk/z4QFtmP96YUfvyR1eadOpQTphhurE
         m/R6/SY2wZMXU4lYYyrQ0wM1W7xwNFJo7T7Fg6np4EPgZasz8yadpEViC5fDA5T3wj0d
         OLJpdOvyVbl6nF5TcfYHIsP/R9qZvWi3DYV/ZFu8fKkcG/FbSofGwDUC3pAzvnl35wkF
         f/bXfcQRGitH8IY4TFvD8oCeGWU5n9YHLFNKw5/si3k+o8SZc+g9I58vfuzEUCBBtL7Z
         kOew==
X-Gm-Message-State: AOAM531v3OppM2s6qtJouslJgbxvnDKtTvHxd86OVTH8Mf2vSqr9Iomu
        Ydbgr9qpnrvYPgIZRpuiJOzTEgHcNPPVC/gNKlhxkCt07SVq666KeXI8ak+a9cx84nEsyYwwqm0
        jlWeHm0biAQUcGH0J9PXFRO8TO7c=
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr4294470ejk.338.1624371907351;
        Tue, 22 Jun 2021 07:25:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfhQ9n159wBTBj85gnBrCTgrjxKuGkYGuGtBN1OcVEly2AURLap2vSlV+EfQGSjnfFnVPIRw==
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr4294452ejk.338.1624371907193;
        Tue, 22 Jun 2021 07:25:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r17sm12057603edt.33.2021.06.22.07.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 07:25:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8AA2218071E; Tue, 22 Jun 2021 16:25:03 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     make-wifi-fast@lists.bufferbloat.net,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kan Yan <kyan@google.com>, Yibo Zhao <yiboz@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH mac80211-next v8] mac80211: Switch to a virtual
 time-based airtime scheduler
In-Reply-To: <20210507094851.180838-1-toke@redhat.com>
References: <20210507094851.180838-1-toke@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Jun 2021 16:25:03 +0200
Message-ID: <87o8byou2o.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> This switches the airtime scheduler in mac80211 to use a virtual time-bas=
ed
> scheduler instead of the round-robin scheduler used before. This has a
> couple of advantages:
>
> - No need to sync up the round-robin scheduler in firmware/hardware with
>   the round-robin airtime scheduler.
>
> - If several stations are eligible for transmission we can schedule both =
of
>   them; no need to hard-block the scheduling rotation until the head of t=
he
>   queue has used up its quantum.
>
> - The check of whether a station is eligible for transmission becomes
>   simpler (in ieee80211_txq_may_transmit()).
>
> The drawback is that scheduling becomes slightly more expensive, as we ne=
ed
> to maintain an rbtree of TXQs sorted by virtual time. This means that
> ieee80211_register_airtime() becomes O(logN) in the number of currently
> scheduled TXQs because it can change the order of the scheduled stations.
> We mitigate this overhead by only resorting when a station changes positi=
on
> in the tree, and hopefully N rarely grows too big (it's only TXQs current=
ly
> backlogged, not all associated stations), so it shouldn't be too big of an
> issue.
>
> To prevent divisions in the fast path, we maintain both station sums and
> pre-computed reciprocals of the sums. This turns the fast-path operation
> into a multiplication, with divisions only happening as the number of
> active stations change (to re-compute the current sum of all active stati=
on
> weights). To prevent this re-computation of the reciprocal from happening
> too frequently, we use a time-based notion of station activity, instead of
> updating the weight every time a station gets scheduled or de-scheduled. =
As
> queues can oscillate between empty and occupied quite frequently, this can
> significantly cut down on the number of re-computations. It also has the
> added benefit of making the station airtime calculation independent on
> whether the queue happened to have drained at the time an airtime value w=
as
> accounted.
>
> Co-developed-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Hey Felix

Had a chance to look at this yet? :)

-Toke

