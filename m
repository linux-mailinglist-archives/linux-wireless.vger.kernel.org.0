Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B6357FD0A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 12:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiGYKJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 06:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbiGYKJF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 06:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79A8917AA0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 03:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658743743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOdNDi4us/f1Sas6UpqCTnnTTYxPBuf2sETCHij1Xqg=;
        b=ZAiB7YnXDuRUvcuJJ5tuzkF31udAlE8ezUUEoP6sh6Vq7OQBaOWBrtne5vz3pHguzlWiyt
        piweYTg1qTeEGYf4yHhXHfPnanIQgrVLtLnIRN3ch2B3ETEjudNaelElL3UbcrBY3RZUWu
        jmqSt1qt9O/BpiLUKRmWUcF5oqPzYIk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-Q7GyD3Z9MnC-xzUwGGzHJw-1; Mon, 25 Jul 2022 06:09:02 -0400
X-MC-Unique: Q7GyD3Z9MnC-xzUwGGzHJw-1
Received: by mail-wm1-f71.google.com with SMTP id 189-20020a1c02c6000000b003a2d01897e4so5947094wmc.9
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 03:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zOdNDi4us/f1Sas6UpqCTnnTTYxPBuf2sETCHij1Xqg=;
        b=JekLIaEK4fTUqUwabkw82wHzXvqnP9TlWugR7uxStD2Z7TGTuBoDd9vUgqcjJFsOVh
         GgWTuzYd+6nv5RQmn9llMPfLbX6XxfCrp9kYugl7j1Z3uzUfHjYCd+726zkakYi+P4Ry
         NkERfKeQdHq1/VBfSqBxedRW2HSnT8lEQryMWxMtmXhF8h26iTBAZHNbOzqno1k8f+3b
         Qe3B7xYcWLButT+hBAUWHj49F2NTYoyArkCR1hxLucB0DKPuruIe1L3fJ+7yE69qYRWS
         doKVgj5BvbW+9rAGw/9eofHsS4LfLQunnMXh2NAlPLZQkqnaWautgsehNvvA8T/cETpv
         hPvQ==
X-Gm-Message-State: AJIora82qKLYyez1zEpDdSQ8miqxDKTbv0ho8TnQUbdXrdvoLIR0PjKz
        Lji3NHUh+0mMpVbkp03CwapyqwI/scQe24jdCaNOuKrLPJnqxnLjUSR6w5JrF9fHcnlgMMQJ9UV
        xqnXSCoK6lgmsktaczAPm2bkzgvM=
X-Received: by 2002:adf:ec02:0:b0:21e:8e67:d0f9 with SMTP id x2-20020adfec02000000b0021e8e67d0f9mr1668586wrn.114.1658743741218;
        Mon, 25 Jul 2022 03:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uhPpazF4+NLltIjfSDcACz17CKS2QpshcLz6JrwZPRfWbbvUTKy+nduUYohktC9GwVNNrh6A==
X-Received: by 2002:adf:ec02:0:b0:21e:8e67:d0f9 with SMTP id x2-20020adfec02000000b0021e8e67d0f9mr1668572wrn.114.1658743740926;
        Mon, 25 Jul 2022 03:09:00 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id l3-20020a1c7903000000b003a320e6f011sm14764718wme.1.2022.07.25.03.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 03:09:00 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Gregory Erwin <gregerwin256@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J?= =?utf-8?Q?=C3=B8rgensen?= 
        <toke@toke.dk>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v10] ath9k: let sleep be interrupted when unregistering
 hwrng
In-Reply-To: <CAHmME9pEvr_F2C9cG4qNSCc91a7YAAquW7Jqczcgn2fr_vA4Ow@mail.gmail.com>
References: <CAHmME9qrd25vfRYYvCWtPg+wVC5joEzzJiihCN+L4rqMfTL4Rg@mail.gmail.com>
 <20220719201108.264322-1-Jason@zx2c4.com>
 <xhsmhfsisgbam.mognet@vschneid.remote.csb>
 <CAHmME9pEvr_F2C9cG4qNSCc91a7YAAquW7Jqczcgn2fr_vA4Ow@mail.gmail.com>
Date:   Mon, 25 Jul 2022 11:08:58 +0100
Message-ID: <xhsmhbktdfqrp.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Jason,

On 22/07/22 22:13, Jason A. Donenfeld wrote:
> Hi Valentin,
>
> On Fri, Jul 22, 2022 at 10:09 PM Valentin Schneider <vschneid@redhat.com> wrote:
>> I had initially convinced myself this would be somewhat involved, but
>> writing the above I thought maybe not... The below is applied on top of
>> your v10, would you be able to test whether it actually works?
>> It does however mean patching up any sleeping hwrng (a quick search tells
>> me there are more, e.g. npcm-rng does readb_poll_timeout())
>
> I'm not able to test this easily, no (I don't own any hardware), and
> I'm not going to put in the effort to rewrite/audit every sleeping
> hwrng. That's not a good use of time, given the numerous other
> problems the framework has (briefly discussed with Eric). Instead,
> maybe at some point I'll look into overhauling all of this so that
> none of this will be required anyway. So I think v10 is my final
> submission on this.
>

I think that's fair, I hope I didn't discourage you too much from
contributing in that area.

> But if you'd like to attempt more comprehensive changes throughout the
> tree on all the drivers and do something large, I guess you can do
> that independently (since you mentioned your thing works on top of
> v10). And this way v10 still exists to fix the actual bug that's
> currently reeking havoc. On the other hand, maybe don't bother, and we
> can look into fixing the whole rats nest properly in some months when
> I'm more motivated to jump into hwrng.
>

Just to make sure I'm on the same page as you - is your patch solely for
ath9k, or is it supposed to fix other drivers?

AFAICT your changes to hw_random/core.c work with any hwnrg driver that
does a variant of schedule_timeout() during rng_get_data(), whereas what I
suggested only works for "opted-in" drivers (just ath9k ATM), but it
doesn't break the other drivers in any way.

So if ath9k is widely used / a problem for lots of folks, we could just fix
that one and leave the others TBD. What do you think?

