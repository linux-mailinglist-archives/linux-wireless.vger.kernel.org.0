Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED4373D89
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhEEOVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 10:21:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232355AbhEEOVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 10:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620224453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFvV09lf5KXhS4Pjkg7YSyawOoknjeJT298X+tPtU5M=;
        b=Y+r4BTqb2HFRaoFWJSIHAfX5yjvROk6SiGWz+xQEUxa2iHtUixZInP0NVe5NsXANSBq2dP
        ffYO1ctV/RRPRz2BQHq3S0ODPRXM2T9qCwo7KMA/2Icjbf/daTLy7JwQatl8nJKAqo1+DF
        70QnHfcXNsJatS9xr94J43ThIbNwECs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-iPu1wlPiPdGiPrBa-P63yg-1; Wed, 05 May 2021 10:20:52 -0400
X-MC-Unique: iPu1wlPiPdGiPrBa-P63yg-1
Received: by mail-pf1-f198.google.com with SMTP id 9-20020a056a000729b029025d0d3c2062so1578258pfm.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 May 2021 07:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wFvV09lf5KXhS4Pjkg7YSyawOoknjeJT298X+tPtU5M=;
        b=MrLiGAGMOUf5nCPOS1lyPfIhj3dLkH36L6EzVcn2CjOLQfIQpe0F/sJ1GPV0i3D/XS
         CINC0btaOkpD481zuwp1QtXatlfOony+TTUMjuIeFoZbkMzhOPQEO/Hke1YPjwsHu/cG
         Y6WE1ZxlTbabgRfJJPpCSvFUZ9hRqJTNfxjP41EaU800ajbfwCb+egePA4tj6C8vIpny
         CXe7cl4Kkx/gth9EFHche4xGMn7N0Y0DASXO/XaafbMbjl9Qs5BPbJ05ohJhX5nO+QYz
         3StTP6/5lJ1qUFWgD0De+mRZQn5SjYcoTuY37Oz6G2TcWRkYmYJL9DiJoXn+tDO4BLbl
         4hHQ==
X-Gm-Message-State: AOAM532R7h4i+FM3ef87nw1z7MtlZ5Azfd9iIYJsW0PwRksW6mNBswGM
        2Jab1xw7SYtUji0fABCqufc6VXNx3q1K7JoVODv3SBspRzn4ktl9c60+pKS8N32pz43jj7Fp/Qn
        vVZk13qiR6W/iT3ZU5AMaThQzHVVI9HJa1C0jh5WeR9w=
X-Received: by 2002:a17:903:22cd:b029:ee:9b67:4012 with SMTP id y13-20020a17090322cdb02900ee9b674012mr30055646plg.15.1620224451138;
        Wed, 05 May 2021 07:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEKdPtPZsF1sLgA79j6LsaF75peNFITMnEwAeQPG539UrmyUJKktJ13kw29Kt7/bhYWW/kkbklDvReV6U4lZo=
X-Received: by 2002:a17:903:22cd:b029:ee:9b67:4012 with SMTP id
 y13-20020a17090322cdb02900ee9b674012mr30055614plg.15.1620224450880; Wed, 05
 May 2021 07:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
 <CACT4oudp9Je55zjg7N8QFDWi5h3kmzMj6syfdi3KgAqQOVgPMA@mail.gmail.com>
 <1620216779.15370.10.camel@realtek.com> <CACT4ouehaQsGr1UGqncvAFgay0v40Zv=O=oz5f8W=E+YmV=SYg@mail.gmail.com>
 <1620223407.28283.2.camel@realtek.com>
In-Reply-To: <1620223407.28283.2.camel@realtek.com>
From:   Inigo Huguet <ihuguet@redhat.com>
Date:   Wed, 5 May 2021 16:20:39 +0200
Message-ID: <CACT4ouePVqwkFRYRLCE7TznfWG87OKwhR2ukAYxO+ijOgZ26Dg@mail.gmail.com>
Subject: Re: rtlwifi: potential bugs
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If it's no problem to add them, a comment STARTING WITH
`coverity[identical_branches]` should suppress the warnings.

Example:

/* Explanation why this code is fine
 * and great
 */
/* coverity[identical_branches] */
if (...)
        ...

Thanks!

On Wed, May 5, 2021 at 4:03 PM Pkshih <pkshih@realtek.com> wrote:
>
> On Wed, 2021-05-05 at 13:01 +0000, Inigo Huguet wrote:
> > Hi,
> >
> > Thanks for the info. Maybe we should consider adding some comments to
> > clarify this? Other people might also think these are bugs...
> >
> > Regards,
> >
> > On Wed, May 5, 2021 at 2:13 PM Pkshih <pkshih@realtek.com> wrote:
> > >
> > > On Wed, 2021-05-05 at 11:23 +0000, Inigo Huguet wrote:
> > > > On Fri, Apr 23, 2021 at 2:56 PM Inigo Huguet <ihuguet@redhat.com> w=
rote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > Executing some static analysis on the kernel, we've got this resu=
lts
> > > > > affecting rtlwifi drivers:
> > > > >
> > > > > Error: IDENTICAL_BRANCHES (CWE-398): [#def212]
> > > > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers=
/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2813:
> > > > > identical_branches: The same code is executed regardless of wheth=
er
> > > > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> > > > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> > > > > branches are identical. Should one of the branches be modified, o=
r the
> > > > > entire 'if' statement replaced?
> > > > > # 2811|   }
> > > > > # 2812|
> > > > > # 2813|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > > > # 2814|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH)) {
> > > > > # 2815|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);
> > > > >
> > > > > Error: IDENTICAL_BRANCHES (CWE-398): [#def213]
> > > > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers=
/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2947:
> > > > > identical_branches: The same code is executed regardless of wheth=
er
> > > > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> > > > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> > > > > branches are identical. Should one of the branches be modified, o=
r the
> > > > > entire 'if' statement replaced?
> > > > > # 2945|   }
> > > > > # 2946|
> > > > > # 2947|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > > > # 2948|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH))
> > > > > # 2949|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 26);
> > > > >
> > > > > Error: IDENTICAL_BRANCHES (CWE-398): [#def214]
> > > > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers=
/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3135:
> > > > > identical_branches: The same code is executed regardless of wheth=
er
> > > > > "wifi_bw =3D=3D BTC_WIFI_BW_LEGACY" is true, because the 'then' a=
nd 'else'
> > > > > branches are identical. Should one of the branches be modified, o=
r the
> > > > > entire 'if' statement replaced?
> > > > > # 3133|   btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &wifi=
_bw);
> > > > > # 3134|
> > > > > # 3135|-> if (wifi_bw =3D=3D BTC_WIFI_BW_LEGACY) {
> > > > > # 3136|   /* for HID at 11b/g mode */
> > > > > # 3137|   btc8821a2ant_coex_table(btcoexist, NORMAL_EXEC, 0x55ff5=
5ff,
> > > > >
> > > > > Error: IDENTICAL_BRANCHES (CWE-398): [#def215]
> > > > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers=
/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3324:
> > > > > identical_branches: The same code is executed regardless of wheth=
er
> > > > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> > > > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> > > > > branches are identical. Should one of the branches be modified, o=
r the
> > > > > entire 'if' statement replaced?
> > > > > # 3322|   }
> > > > > # 3323|
> > > > > # 3324|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > > > # 3325|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH)) {
> > > > > # 3326|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);
> > > > >
> > > > >
> > > > > In my opinion, they seem to be real bugs. However, it's very diff=
icult
> > > > > to imagine what actions must be taken on each branch of the if-el=
se
> > > > > because they strongly depend on magic numbers, which are differen=
t
> > > > > configurations for the hw, I guess.
> > > > >
> > > > > Can the maintainers confirm if these are real bugs and see how to=
 fix them?
> > > > >
> > > > > Regards
> > > > > --
> > > > > =C3=8D=C3=B1igo Huguet
> > > >
> > > > Hello,
> > > >
> > > > A few weeks ago I sent the message above notifying a potential bug =
in
> > > > rtlwifi module. I just wanted to be sure that it has been received.
> > > > Can the maintainers acknowledge whether they have seen it?
> > > >
> > >
> > > Hi,
> > >
> > > Not real bugs. The coexistence programmers preserve the same code of
> > > branches intentionally to fine tune performance easier, because bandw=
idth and
> > > RSSI strength are highly related to coexistence performance.
> > > The basic rule of performance tuning is to assign most time slot to B=
T
> > > for realtime application, and WiFi uses remaining time slot but don't=
 lower
> > > than low bound.
> > >
> > >
>
> Hi,
>
> I can add comments. Do you need any keyword within comment to avoid your
> checking tool warns this false alarm?
>
> --
> Ping-Ke
>


--=20
=C3=8D=C3=B1igo Huguet

