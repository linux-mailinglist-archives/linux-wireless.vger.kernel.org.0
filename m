Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B86703401
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 18:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbjEOQns (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 12:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242640AbjEOQnm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 12:43:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C924698
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 09:43:41 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so11870057a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169019; x=1686761019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpsKINDySfB7fCIjepiTuqAM7vA255CaPJo8J9yBIso=;
        b=seD1SIuhLWSMtkFx66FmWAernjSY9vNhA6vyiG8Sj/yr5wxEuA/ZE6KRfSoxUGcWX2
         FjCJfCrvkp2imUh6IYGgvRknMTxbnoRDvbu+3flfgfGtqxhxUqW+mieqS7Oo/AhyEWax
         JT1V8QHuo5jpIwFPIjJ67ARMG1ahzXqVkAGHpPJ1KF9gT4xg1vUGchW2A7NjZtFFd3BB
         igPL4TG+Mn4ZQGQ7QfzAfpZJ1H2Wfx6/bBZm4yYXw9WQwniCLWQdGJ+k70f3zQl7Hhrr
         kQuA/G73W1rtTvA8ru5dWR9n2btDLRG387OtCWHzjfPjkXM25VOfiyACwEX9Ft7IVea/
         ZH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169019; x=1686761019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpsKINDySfB7fCIjepiTuqAM7vA255CaPJo8J9yBIso=;
        b=gKPMs9gsIETKMUHxB0/Rcx3TmbdthuQ+AAIyaUJZ5mkxiHZAcdzHPkGHlNtsMt3ugv
         zetk+p7pyp5aCW+JmYgXAdyiG3McJGizwwjr8Zyy9s2KiKKR/d5NKeC3ubda5GGQUaL2
         58OlPZ25CJGxiqlI95h53EOCKn5B/eeiLrHrFpnPPiWBtfx2bNZH1bNVwvO5/TzgSSBz
         wMCmFeO88i6NtOe5R1woMcSFCzJJODdj/WlDi6c9etu0OAWxYQQgwsEmURpXvGllIGVy
         iJpjeVWy98/+xFw6hazet1Hf4iGWHIPy5XFUzWeNxqsXDjr5Ngq8WeQNRor6CnWQTylN
         2KTw==
X-Gm-Message-State: AC+VfDyvk8VP7TWPINCsJChMIN9S5B7Sdh/b6+BXMtC50s+tJUWtSa9N
        gG9zH0bdLH47OajZd3pKh7Q=
X-Google-Smtp-Source: ACHHUZ5a6HM4pWL4J0069EtiaoXnP/94Ie8esYdxloYhdKV5KmwRqGP3L3xP9bvYdKtL/9ZmlhYeQg==
X-Received: by 2002:aa7:d158:0:b0:50d:b7e5:fdde with SMTP id r24-20020aa7d158000000b0050db7e5fddemr16622829edo.19.1684169019296;
        Mon, 15 May 2023 09:43:39 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id n7-20020aa7d047000000b004fbdfbb5acesm7579804edo.89.2023.05.15.09.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:43:38 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Driver for rtw8723ds
Date:   Mon, 15 May 2023 18:43:37 +0200
Message-ID: <3162376.5fSG56mABF@jernej-laptop>
In-Reply-To: <fc20e35c-c7e6-cfa5-bdc5-f88ceee12f71@lwfinger.net>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <21872829.EfDdHjke4D@jernej-laptop>
 <fc20e35c-c7e6-cfa5-bdc5-f88ceee12f71@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dne sobota, 13. maj 2023 ob 23:21:47 CEST je Larry Finger napisal(a):
> On 5/13/23 15:13, Jernej =C5=A0krabec wrote:
> > Dne sobota, 13. maj 2023 ob 21:55:51 CEST je Larry Finger napisal(a):
> >> On 5/13/23 05:23, Jernej =C5=A0krabec wrote:
> >>> Larry,
> >>>
> >>> Dne sreda, 10. maj 2023 ob 23:47:24 CEST je Larry Finger napisal(a):
> >>>> On 5/10/23 16:07, Martin Blumenstingl wrote:
> >>>>> On Wed, May 10, 2023 at 12:02=E2=80=AFAM Larry Finger <Larry.Finger=
@lwfinger.net> wrote:
> >>>>> [...]
> >>>>>> I added that patch to the driver. The user reports that he was abl=
e to do a ping
> >>>>>> and an nslookup before it crashed with the following in the log:
> >>>>> That's some positive news alongside the crash log: it seems that a
> >>>>> part of the driver works! :-)
> >>>>>
> >>>>>> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:3=
341 put:3341
> >>>>>> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 d=
ev:<NULL>
> >>>>> [...]
> >>>>>> Somehow skb->tail was greater than skb->end. Unfortunately I do no=
t have access
> >>>>>> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 o=
n the MangoPi
> >>>>>> MQ Quad.
> >>>>> I need to have a closer look at the pkg_offset and struct
> >>>>> rtw_rx_pkt_stat which we receive.
> >>>>> Recently my own MangoPI MQ-Quad arrived but I did not have the time=
 to
> >>>>> set it up yet. I'll try to do so during the weekend so I can debug
> >>>>> this on my own.
> >>>>>
> >>>>> Please ping me next week in case I haven't provided any update unti=
l then.
> >>>>
> >>>> I have some test prints in to check for skb overrun. My initial indi=
cation is
> >>>> that the problem was in the c2h branch of rtw_sdio_rx_skb(), but my =
next run
> >>>> should verify that. My changes will do a pr_warn_once() when the pro=
blem
> >>>> happens, and then drop the skb.
> >>>>
> >>>> My contact reported that he had one run of 3 minutes before the prob=
lem
> >>>> happened, which is good news for most of the driver.
> >>>
> >>> I may have discovered something interesting. rtl8723ds vendor driver =
has
> >>> following checks in RX data parsing code:
> >>> https://github.com/lwfinger/rtl8723ds/blob/master/hal/rtl8723d/sdio/r=
tl8723ds_recv.c#L83-L99
> >>>
> >>> Those checks are absent in rtl8822bs vendor driver, which was my orig=
inal
> >>> development platform for SDIO. This may indicate some kind of bug in =
=46W
> >>> and/or HW.
> >>>
> >>> I think that at least second check, which checks for exactly the case=
 your
> >>> client experience, can be easily added and tested.
> >>
> >> Thanks for this update. I added the following to the start of rtw_sdio=
_rx_skb():
> >>          /* fix Hardware RX data error, drop whole recv_buffer */
> >>          if (!(rtwdev->hal.rcr & BIT_ACRC32) && pkt_stat->crc_err) {
> >>                  kfree_skb(skb);
> >>                  return;
> >>          }
> >> I think that duplicates the code in the vendor driver.
> >>
> >> I have not heard from my user as to whether it helps. My communication=
s with him
> >> are at https://github.com/lwfinger/rtl8723ds/issues/37.
> >=20
> > I had second part in mind (see attachment), but this is IMO only sanity=
 check
> > and it will mask the issue. At this point I'm not sure if this is somet=
hing that
> > can happen occasionally or is there additional bug in rtw88 code. I'll =
check
> > rtl8723ds c2h code in greater detail.
> >=20
> > In any case, I would argue that all 3 patches in this thread are valid =
and
> > should be submitted upstream.
>=20
> That patch looks good. I ill apply it to my rtw88 repo.

I see that issue is still there. Next idea would be to check if RX aggregat=
ion
is the problem. Just commenting out call to rtw_sdio_enable_rx_aggregation()
is enough to disable it.

Best regards,
Jernej



