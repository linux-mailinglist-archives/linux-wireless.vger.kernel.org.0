Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9527F5A4FCB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiH2PGZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiH2PGZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 11:06:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618F180027
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:06:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bs25so10584963wrb.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=2GtRhjpgiVjEKeSnuZIE7BGc8bzxZE0tXt3Z4WyrzNw=;
        b=Q0VpwKodH3W54E1iQ6tygjTzkO7TATXWFo1CjH4ewtId7vvR+My+s3cv7VA8KkKe/K
         oKnhXWifQXeEMlX1qSlXUxOBsSelhOwK6ZHwgiUt4hBWddcfBKaddftoKcuWMaZphuGw
         EjyodwOKE0jDXa/3SOBABA7FFZRrAlx/DI9wOZA2RkKQX1FSnuF4qsPydeHa38lSWlLH
         QMIQM9Yj8MkbUzpm5ob+Sz36lFATU0V3pI3IFV3+KZKICuMUJ1L4FuruL2NrQxmdjnYY
         TcbTdRLzs9TLdZlnBCGvzCb1MPzDNXugGE7d+m4SJDX6oL78EiUhHD7RVBoaqQQVpLZB
         ckwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=2GtRhjpgiVjEKeSnuZIE7BGc8bzxZE0tXt3Z4WyrzNw=;
        b=QZGwvvbFX2SScj2jMeMRQaBBTWwEWnF9S2iDOjPjTq/IfY+wC0Gzwcre0KgK9yGCz+
         tgoQc3hqx+7Oz1OYCbqZ0HfR7L8nVWQnkxcuMIbqoUTMoVU0I6aL7rUzOQ85xEHPnxVa
         vYxPvYJeFXKPSuSFsp1F61ZO0W3+Zx23ePP0fQYUTYoNfWJuf5O0H7rw3Dm1Tup3SfU8
         URihDXinN+CYP8CUAEU/oCkCF9CX6ZD/eLdt7kAEGuRM39KCwBt55E+lJW8H90fcB4Qy
         cSic1t4xP0l4VrFGHj1XZJp5FFX1GbUnnkQGc0Z9hUkCa4pfeXNg7fPziOgEu2QV62BB
         nsKA==
X-Gm-Message-State: ACgBeo0DKkfgLWne96Vd3Ts2Ba0m3IxB4pRwiduZH7VASuaS8QDtzyT6
        kdDHai50EMDVijqSviVzv70hD29FNaU=
X-Google-Smtp-Source: AA6agR46DyGKNvJsfYOn0A/isFdVOeBPNwGbS/Z8QK+kPs628NS6l1+y68PrUUuyIQNFNyffZuKaMQ==
X-Received: by 2002:a5d:59ad:0:b0:225:5b41:3dee with SMTP id p13-20020a5d59ad000000b002255b413deemr6639426wrr.302.1661785581966;
        Mon, 29 Aug 2022 08:06:21 -0700 (PDT)
Received: from smtpclient.apple (p200300c56f18a60054f4ba7ca0871a5f.dip0.t-ipconnect.de. [2003:c5:6f18:a600:54f4:ba7c:a087:1a5f])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d4d88000000b002253d865715sm4141002wru.87.2022.08.29.08.06.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2022 08:06:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <467218ec220ea6e36b4222efc5c46e4e350fe1ea.camel@sipsolutions.net>
Date:   Mon, 29 Aug 2022 17:06:20 +0200
Cc:     linux-wireless@vger.kernel.org, nbd@nbd.name,
        =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE871D89-B996-4D8B-8C65-7C53382C30D8@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
 <467218ec220ea6e36b4222efc5c46e4e350fe1ea.camel@sipsolutions.net>
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

We planned to get these changes upstream at first to have the foundation =
for TPC
in the mac80211, and then develop driver implementations and TPC =
algorithm on=20
top of this once all is reviewed, approved and upstream.=20
The ath9k tpc support is currently not upstream-ready but can be in a =
next version.
For testing the actual TPC support I modified minstrel=E2=80=99s debugfs =
to be able to set=20
fixed tx-power per STA.

I think we can develop this series further to come up with fully working =
driver
implementation and a TPC algorithm if you think that would be better.=20
Else we could also provide at least a debugfs patch to be able to set =
fixed
tx-power per STA.

Greetings
Jonas

> On 29. Aug 2022, at 16:46, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> On Mon, 2022-08-29 at 16:41 +0200, Jonas Jelonek wrote:
>>=20
>> I tested the tx-power annotation with an implementation of TPC in =
ath9k
>> (not included in this RFC) and small changes in minstrel_ht for =
debugfs
>> access. Tx-power status report in ath9k required the proposed utility
>> function in mac80211.
>>=20
>=20
> Huh wait, now that I got to the end of the series ... this doesn't
> actually *do* anything, so what's the point? Shouldn't it come with =
some
> implementation of the control?
>=20
> johannes

