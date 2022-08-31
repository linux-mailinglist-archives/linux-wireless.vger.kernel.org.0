Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCB5A7F6C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 15:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiHaN7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHaN7a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 09:59:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFDAD5EA6
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 06:59:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so8044202wms.5
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=cSSofcj/fzMSByM5TVTgE5q2OyrYMYhLB+GYNE0Xyz4=;
        b=pyp/sWqwVMNjuTDgXKy2xJU4zNe8YHcfTuG9uaK40qK+9W6QnEiDFp/jZr8xvxGuwQ
         QMH+/q0v5y/++TJbvxnrAx+pWlcQdbcZvsow5YG0gHpIcd8dbAeW8oZS1FM/HxHFSicj
         cofJtsK5jftFd8Tqg8HMW98cREiajAItIL6tt85TTdTgyo4h4yh2NM3FvQTGLkslJ9IP
         4vcqED7SG2Gu/KfS0J1p1cEdHLc5iDWnD20ArYsxyqdx3Zb1HldursHJX7Ycn97Rg8+v
         +yPh3BFsiIS4nnrk0Kiy6Sq8CBhTEiyuHXyOQL0OvvIAUEaMaSfnfDguzeT8MhmhTlGQ
         mIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=cSSofcj/fzMSByM5TVTgE5q2OyrYMYhLB+GYNE0Xyz4=;
        b=gc19zH8lE0Z3QGwZYIk5W5pbzgr7F07Vtvpj6iQ1ap8VzW/3zfUNC8G4OqpqWDb1b2
         74BgtD0Q/UsdU7oF+rjd2KL0ktittzinWtuj8p5qrjsMt/ljh5nqTSyv+jwnKqKQI4JG
         MV56DSgY0EXYjY9sjW3qCu+DB5vR7rejmLA6eIniXR8SN3gJ8Z93uZraRROXceoVBeyK
         0Rz/+KP/lzwEspNjK3HoEpYpnyRLaBi4K6YB/XKzUUTaTUkL2FcsMhHqvaYo+xn6oyFf
         88PMTjI21n8eAoz8KReKf1eqf88typYLSu9hLIYOUwXPz1qbHVZG8jBFfCI0Kko1i+EB
         dAog==
X-Gm-Message-State: ACgBeo1Fdf9B/sswe/pnQu4sg1y9DIg4e06QOAFDYrio6XKUq62xdjWC
        /1+GKT9aEPEnwT0Nue26UnA=
X-Google-Smtp-Source: AA6agR48qgoPoDLg7p8UlN5f7LHXpph8oQW3vkazLk1o7IYal+/uufU+dT909GvKMvNk3rUsmhNkVg==
X-Received: by 2002:a7b:cd91:0:b0:3a8:5262:6aa9 with SMTP id y17-20020a7bcd91000000b003a852626aa9mr2029458wmj.143.1661954368218;
        Wed, 31 Aug 2022 06:59:28 -0700 (PDT)
Received: from smtpclient.apple (p200300c56f185400edcb108dfd391000.dip0.t-ipconnect.de. [2003:c5:6f18:5400:edcb:108d:fd39:1000])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003a502c23f2asm2586312wmq.16.2022.08.31.06.59.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:59:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <CE871D89-B996-4D8B-8C65-7C53382C30D8@gmail.com>
Date:   Wed, 31 Aug 2022 15:59:26 +0200
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7CFDCFCC-A369-4F41-90E1-A26591C20D92@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
 <467218ec220ea6e36b4222efc5c46e4e350fe1ea.camel@sipsolutions.net>
 <CE871D89-B996-4D8B-8C65-7C53382C30D8@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 29. Aug 2022, at 17:06, Jonas Jelonek <jelonek.jonas@gmail.com> =
wrote:
>=20
> We planned to get these changes upstream at first to have the =
foundation for TPC
> in the mac80211, and then develop driver implementations and TPC =
algorithm on=20
> top of this once all is reviewed, approved and upstream.=20
> The ath9k tpc support is currently not upstream-ready but can be in a =
next version.
> For testing the actual TPC support I modified minstrel=E2=80=99s =
debugfs to be able to set=20
> fixed tx-power per STA.
>=20
> I think we can develop this series further to come up with fully =
working driver
> implementation and a TPC algorithm if you think that would be better.=20=

> Else we could also provide at least a debugfs patch to be able to set =
fixed
> tx-power per STA.
>=20
> Greetings
> Jonas
>=20
>> On 29. Aug 2022, at 16:46, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>>=20
>> On Mon, 2022-08-29 at 16:41 +0200, Jonas Jelonek wrote:
>>>=20
>>> I tested the tx-power annotation with an implementation of TPC in =
ath9k
>>> (not included in this RFC) and small changes in minstrel_ht for =
debugfs
>>> access. Tx-power status report in ath9k required the proposed =
utility
>>> function in mac80211.
>>>=20
>>=20
>> Huh wait, now that I got to the end of the series ... this doesn't
>> actually *do* anything, so what's the point? Shouldn't it come with =
some
>> implementation of the control?
>>=20
>> johannes
>=20

I am working on the hwsim support right now, tpc support in hwsim=E2=80=99=
s control path is implemented.
However I encountered a problem in the status path. Hwsim seems to hand =
over to mac80211
tx-status asynchronously via ieee80211_tx_status_irqsafe only. There, =
the skb is added to
ieee80211_local->skb_queue and then dequeued in =
=E2=80=98ieee80211_tasklet_handler=E2=80=99 to be passed
to =E2=80=98ieee80211_tx_status=E2=80=99. For tx rates this is =
sufficient, but there is no space left in=20
ieee80211_tx_info->status to pass the tx-power per packet.
Please correct me if I missed something in the code.

My idea to solve this may be: to use the SKB extension (struct skb_ext =
*extensions) to pass the=20
tx-power information (and maybe more) for each SKB. Could this be an =
appropriate approach or=20
do I miss something here? Maybe someone who is much more aware of the =
mac80211 layer=20
design does have a better idea for this?

Greetings
Jonas=
