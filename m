Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D033E57A2C3
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jul 2022 17:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238495AbiGSPPe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jul 2022 11:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiGSPPZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jul 2022 11:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A816F49B56
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658243707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DZfape1HvRcQDBJMjqCK8x7O2btj6Zg9uPaKpCKPLz4=;
        b=jId0WW1JGdQxYKlQZAHEckn0uE6UlARHtx7v/Pt6PoDVf+dRxBsr7MSpKMI69Kz22Ig+fZ
        40TYA/vaWJ309h/HcUBHDix+cFsDJNFKj/SddDafiEORgPwdG9P2dcsu66/K8Pw9X1aPhW
        H7bklgsXEt8Uzx/jP2z/u0aLGYiMOEM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-_cu7QG7tOGmSMFduuyw6AA-1; Tue, 19 Jul 2022 11:15:06 -0400
X-MC-Unique: _cu7QG7tOGmSMFduuyw6AA-1
Received: by mail-wm1-f71.google.com with SMTP id az39-20020a05600c602700b003a321d33238so1256501wmb.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Jul 2022 08:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DZfape1HvRcQDBJMjqCK8x7O2btj6Zg9uPaKpCKPLz4=;
        b=3ItKnG+BTTl/4QZnvsbGZ7DJ4CUMfBxG7j0ZBvhHJMgAqrYDhPe2vkAHxKk86Tu6Ku
         YmjHQwC4GNlEkZvi6GW+wKBv9gquC6vnOJtJPT7MTJni7ha5ksZTlWi8DDo1KLCdCFuG
         /tauAeT+DK/Cz1ZRJsiuNiBka1pyKP8Ux3MBxEZyI7VF7Cair47C/jgxyH2d9L/rDOI0
         r4Hr4OoKE/Rpp3RJiN2w4jsFTSpJ6dFFYhkUBdtwc31a72BmaXQyK+OUUdBJuLsex9e5
         7Q0ipuCeDFvN8hv25IeFLHg71+n5bC341kb02jB0AR9PJbHfyNHH+kL/XagxVD5Hx4X+
         iShg==
X-Gm-Message-State: AJIora+a/3ULUvSmo8m7u8L63c1gi87rb6iQYmPOS99Fb052H+MZhxuD
        a1ulKV6wTvRou4Oqqdg3yzseqqKwz50JJaUgitzIQoDzAVxb25GEYcXoLM9ILROoH9kHOUPDJ3K
        EQ6PNqDTBxdmV4te/pymfNUJy4BY=
X-Received: by 2002:a1c:2b05:0:b0:3a0:2ae2:5277 with SMTP id r5-20020a1c2b05000000b003a02ae25277mr32016339wmr.30.1658243704620;
        Tue, 19 Jul 2022 08:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ufZw67mDO/HMSiR5dpo2mMh5Dr7OZ3O/vXfLgflU9RixvUu7uhgILPHQ/3jGFAFcB3ZuKGow==
X-Received: by 2002:a1c:2b05:0:b0:3a0:2ae2:5277 with SMTP id r5-20020a1c2b05000000b003a02ae25277mr32016321wmr.30.1658243704438;
        Tue, 19 Jul 2022 08:15:04 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id bg10-20020a05600c3c8a00b003a0323463absm23061621wmb.45.2022.07.19.08.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:15:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Gregory Erwin <gregerwin256@gmail.com>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgense?= =?utf-8?Q?n?= 
        <toke@redhat.com>, Rui Salvaterra <rsalvaterra@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v8] ath9k: let sleep be interrupted when unregistering
 hwrng
In-Reply-To: <CAHmME9q8-1vpV9zFsKkawk+XFm96S6fmug7v-NPJNpQmRoe6-Q@mail.gmail.com>
References: <Yrw5f8GN2fh2orid@zx2c4.com>
 <20220629114240.946411-1-Jason@zx2c4.com> <87v8s8ubws.fsf@kernel.org>
 <xhsmho7xv512f.mognet@vschneid.remote.csb>
 <CAHmME9q8-1vpV9zFsKkawk+XFm96S6fmug7v-NPJNpQmRoe6-Q@mail.gmail.com>
Date:   Tue, 19 Jul 2022 16:15:02 +0100
Message-ID: <xhsmhcze16snd.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/07/22 13:53, Jason A. Donenfeld wrote:
> Hi Valentin,
>
> On 7/11/22, Valentin Schneider <vschneid@redhat.com> wrote:
>> Thanks for the Cc.
>>
>> I'm not hot on the export of wake_up_state(), IMO any wakeup with
>> !(state & TASK_NORMAL) should be reserved to kernel internals. Now, here
>> IIUC the problem is that the patch uses an inline invoking
>>
>>   wake_up_state(p, TASK_INTERRUPTIBLE)
>>
>> so this isn't playing with any 'exotic' task state, thus it shouldn't
>> actually need the export.
>>
>> I've been trying to figure out if this could work with just a
>> wake_up_process(), but the sleeping pattern here is not very conforming
>> (cf. 'wait loop' pattern in sched/core.c), AFAICT the signal is used to
>> circumvent that :/
>
> I don't intend to work on this patch more. If you'd like to ack the
> trivial scheduler change (adding EXPORT_SYMBOL), that'd help, and then
> this can move forward as planned. Otherwise, if you have particular
> opinions about this patch that you want to happen, feel free to pick
> up the patch and send your own revisions (though I don't intend to do
> further review). Alternatively, I'll just send a patch to remove the
> driver entirely. Hopefully you do find this ack-able, though.
>

I'm not for a blanket wake_up_state() export, however if we *really* need
it then I suppose we could have a wake_up_process_interruptible() exported
and used by __set_notify_signal().

