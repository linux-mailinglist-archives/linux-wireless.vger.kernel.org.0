Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E646FE5F4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 23:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbjEJVHa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 17:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjEJVH2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 17:07:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5251FFB
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 14:07:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso1407226766b.2
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683752846; x=1686344846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l3eNNSo0VtmYNvZJ2Jk5NVVYKMeZRM2YUMnUq+YuaE=;
        b=X8x2toPjAeODRqf1SvbREsU9b4O0RjTFVowkAIFo4YwwtopRR94JX7IrktGUwqBFY5
         Pf7RksdJF44EmMqwGQ1Sqm0Fh5rQofnPgpqNQ2yyRespnwmsx7528vDSyRkcPHhXizSL
         sgBx0VXjWLOJsfQO6K9tSguWuETfb+mkfqT8fQvTDtoJ6wzDB/pNoRgflvfnklKJNwFK
         bz10e7HWEVKOO//sT8/huFzqMI5CQhKSfTrrZSEmK1Jqf1D55BnB/16x2N7IoP7hbaHZ
         aPgKvcWLO2cAkp6Ij3pnqBhX0C+t4GVx3MKKNyeoFzwqJdgoZlgzBwLMf6WhlGX+OIVK
         RX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683752846; x=1686344846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6l3eNNSo0VtmYNvZJ2Jk5NVVYKMeZRM2YUMnUq+YuaE=;
        b=dBCFKS/XFRSHN2J/t5Xvr49xXai16aqzKPAzctb7kFZlo+YbhJ1CGY7cOVf3Jmrkae
         3ofZ4XmmrBNObwTCEwTYNaJ5Uh2a5ph8DnGbVqmEN5jVbf0xVAaJIXPzoYIpFhEsDBlW
         cvWRENqKof2onSkSOyBMl6Q8qzWruGebthqC9FhBxRqO6YurTHa4xYskHaS4n2zV++sI
         UIq9YEj9dD2OVWz7MwCr1F4ifF43EgI7jUxV6jHj8HVirpaaSnjOEmSGTVhdTtqjNv1S
         IOwbdnmzGQri4Z/Rge+gtSf3lQ6Tp8E/W6XqEnr56nE6uTEb5zeytGrcrdEjjByJlZLq
         VH+A==
X-Gm-Message-State: AC+VfDxY9kFcOQOHB/jgYu/66Uhm3Ga5gLsn8uImaNCYJpf+9vMyDurw
        ycB9OLh1wRJ3GErAL6JHdEKva9sXrhr5PfGV8fqYZv+Ycdw=
X-Google-Smtp-Source: ACHHUZ5IIfDLwqei7itOIi+s2b4k6BUSbto3d5mYRbMOJH36YYeAFR+N9NAMp8hnxJJ/sl5xV+NuNAyMofaMWlsHdHY=
X-Received: by 2002:a17:906:58d5:b0:969:9fd0:7cee with SMTP id
 e21-20020a17090658d500b009699fd07ceemr9605819ejs.10.1683752845594; Wed, 10
 May 2023 14:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <5930608.lOV4Wx5bFT@jernej-laptop> <813d74b8-6d9f-c7b0-40b4-c661fca13002@lwfinger.net>
 <CAFBinCB3xnCrLvEvqsFMQuDxL+xC9tkxnwubfC+xEMP3-ZXqSg@mail.gmail.com>
 <527585e5-9cdd-66ed-c3af-6da162f4b720@lwfinger.net> <CAFBinCCdbt0OAHMnGPYA+xH8WC1nWqJPP5aBU48R=LHRu_xuew@mail.gmail.com>
 <77bdcc7b-c3b2-7c3b-5146-9b7f8c3ae5a7@lwfinger.net>
In-Reply-To: <77bdcc7b-c3b2-7c3b-5146-9b7f8c3ae5a7@lwfinger.net>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 10 May 2023 23:07:14 +0200
Message-ID: <CAFBinCAA2CXZBRO7yb4Hjg6Cos4JFQiCMWZLGVh8DCOYWg7HhA@mail.gmail.com>
Subject: Re: Driver for rtw8723ds
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 10, 2023 at 12:02=E2=80=AFAM Larry Finger <Larry.Finger@lwfinge=
r.net> wrote:
[...]
> I added that patch to the driver. The user reports that he was able to do=
 a ping
> and an nslookup before it crashed with the following in the log:
That's some positive news alongside the crash log: it seems that a
part of the driver works! :-)

> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:3341 put=
:3341
> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 dev:<NUL=
L>
[...]
> Somehow skb->tail was greater than skb->end. Unfortunately I do not have =
access
> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 on the M=
angoPi
> MQ Quad.
I need to have a closer look at the pkg_offset and struct
rtw_rx_pkt_stat which we receive.
Recently my own MangoPI MQ-Quad arrived but I did not have the time to
set it up yet. I'll try to do so during the weekend so I can debug
this on my own.

Please ping me next week in case I haven't provided any update until then.


Best regards,
Martin
