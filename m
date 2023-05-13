Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDDC701621
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 12:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237357AbjEMKXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 May 2023 06:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238057AbjEMKXZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 May 2023 06:23:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38804868D
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 03:23:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965ac4dd11bso2163689166b.2
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683973399; x=1686565399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J22Q5H27WmcmWSXLvWXXEDseF5qQQ4t6t/II9V1keG0=;
        b=EUXTvSjC1CvDfnB/0Cf6ubHy8POd3W8Xh9FNOdhUKrHDCE2ycWOv/0EbCmAdxfNhEQ
         mfELGkxBqJvY2hbJBq4pewu7bKJZADAY6S9llr0HvL5CG4HT0r0p/n5Z1dzGXPTKtnqc
         T/HJn1J3hN8JBU2zwbp2r2x+FeLUAeQihs4Woj7VCuM9klbkF7qb3lou9DX2nnBXNNl7
         khWy8M/yNLpdjufTrUcy/ZBengZsaGUi86QQlL3qZSnZRKBILtRkuaxcrYvRFf2coAPz
         bmxhncGnjpwFYmdt71lsBaBMSMjEA4y5AhCrtqq9BpCXVfiunoFmwNhL8pMGnUSFz7vH
         8vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683973399; x=1686565399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J22Q5H27WmcmWSXLvWXXEDseF5qQQ4t6t/II9V1keG0=;
        b=A5loBR3GeAPjgFsVlH8ExUa70WfECfzYz6T9ozlDbT1w57Ii4JCNrEVDllx4OsMsd5
         x48X+2wLxxVGcZcMb+XajxabsoX1+hI2jSQWgZyCUYvRwMD9hbfLAVAyhTXCxibYrKo9
         4Czg27UD4bu+knTCQPIS63vl7XF/ZeiuYL/wqwEdKo45JJZQ3BOu/FslSLVQQp2S5DG6
         qFFKyNb/tQt0hoNoaWJPfAmnUuMIEQNQ9onTM8iTRsR1RgqrH7KvyPf2JGK3SsQM/f1K
         gcuBIM11RyTMNi4xHudz1iM2lhyvy8H6ZsbylJC7i6Ch5mFjgjIE5zl81nD9BnQoYZ2e
         FmNQ==
X-Gm-Message-State: AC+VfDzA9tVjmobdANJFh3CzqFZK0T2rvfHrPdAM9IcEHXBRND1Lk2mt
        MTYOkhsLTLxcivtxYabvGlM=
X-Google-Smtp-Source: ACHHUZ625T+d7YPvGMxIwRX/D2cgwsyYzZvSm9QamwpaOqeh7VCRVMZcW5dLitTS4skacXLVUBB0HA==
X-Received: by 2002:a17:907:1c01:b0:966:335a:5b0b with SMTP id nc1-20020a1709071c0100b00966335a5b0bmr22701935ejc.18.1683973399440;
        Sat, 13 May 2023 03:23:19 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id jy11-20020a170907762b00b0094f3b18044bsm6621624ejc.218.2023.05.13.03.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 03:23:18 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Driver for rtw8723ds
Date:   Sat, 13 May 2023 12:23:17 +0200
Message-ID: <13262218.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <880bb4ed-f3a5-2d7f-db10-fec65087dd05@lwfinger.net>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <CAFBinCAA2CXZBRO7yb4Hjg6Cos4JFQiCMWZLGVh8DCOYWg7HhA@mail.gmail.com>
 <880bb4ed-f3a5-2d7f-db10-fec65087dd05@lwfinger.net>
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

Larry,

Dne sreda, 10. maj 2023 ob 23:47:24 CEST je Larry Finger napisal(a):
> On 5/10/23 16:07, Martin Blumenstingl wrote:
> > On Wed, May 10, 2023 at 12:02=E2=80=AFAM Larry Finger <Larry.Finger@lwf=
inger.net> wrote:
> > [...]
> >> I added that patch to the driver. The user reports that he was able to=
 do a ping
> >> and an nslookup before it crashed with the following in the log:
> > That's some positive news alongside the crash log: it seems that a
> > part of the driver works! :-)
> >=20
> >> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:3341 =
put:3341
> >> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 dev:<=
NULL>
> > [...]
> >> Somehow skb->tail was greater than skb->end. Unfortunately I do not ha=
ve access
> >> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 on th=
e MangoPi
> >> MQ Quad.
> > I need to have a closer look at the pkg_offset and struct
> > rtw_rx_pkt_stat which we receive.
> > Recently my own MangoPI MQ-Quad arrived but I did not have the time to
> > set it up yet. I'll try to do so during the weekend so I can debug
> > this on my own.
> >=20
> > Please ping me next week in case I haven't provided any update until th=
en.
>=20
> I have some test prints in to check for skb overrun. My initial indicatio=
n is=20
> that the problem was in the c2h branch of rtw_sdio_rx_skb(), but my next =
run=20
> should verify that. My changes will do a pr_warn_once() when the problem=
=20
> happens, and then drop the skb.
>=20
> My contact reported that he had one run of 3 minutes before the problem=20
> happened, which is good news for most of the driver.

I may have discovered something interesting. rtl8723ds vendor driver has
following checks in RX data parsing code:
https://github.com/lwfinger/rtl8723ds/blob/master/hal/rtl8723d/sdio/rtl8723=
ds_recv.c#L83-L99

Those checks are absent in rtl8822bs vendor driver, which was my original
development platform for SDIO. This may indicate some kind of bug in FW
and/or HW.

I think that at least second check, which checks for exactly the case your
client experience, can be easily added and tested.

Best regards,
Jernej



