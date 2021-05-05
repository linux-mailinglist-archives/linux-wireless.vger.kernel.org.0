Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17CA373DBF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhEEOh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 10:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229707AbhEEOh0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 10:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620225389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WL6Tcqmslqy19OJPrWxP+wJdCjOrUpaRZUPI00uOD70=;
        b=KOpCLUL4HitcWf/awwIh4ZQV3G1l/oWJuuyXcWanV8POl3qH+EjHNBjuWrFoESVLJim4fl
        xkoc7Vv1fUaDbya36oaZbGbhFMiq6Sk7FPL3Eq0/6Ob7Ezb9/tSrkF4AqNrf02N3z24Wj4
        VSL5/LG+TlbjgOLQpJQ13DapjXLnUC8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-oJmQmZU7Pv2BS94F613BHw-1; Wed, 05 May 2021 10:36:26 -0400
X-MC-Unique: oJmQmZU7Pv2BS94F613BHw-1
Received: by mail-pg1-f197.google.com with SMTP id m36-20020a634c640000b02901fbb60ec3a6so1441867pgl.15
        for <linux-wireless@vger.kernel.org>; Wed, 05 May 2021 07:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WL6Tcqmslqy19OJPrWxP+wJdCjOrUpaRZUPI00uOD70=;
        b=j0N1dJofUHJpSeiq0mkxnzo8ZrCh/R5R1Id+7u2lg8LxKrLscw086sqL41iQ8aOw9H
         H0otPtTjPEWvb5js+dLOabxEQlM/j0K/p9JvOrpmCo789Vm8LqQw+mZqsrs6WU/d6aoA
         CIDwV4pEnapegmabmqsVLi2jTjw2D625VFA40Wt6Vfzn2jFZ4D8eTm7wr8FER6JvkRDb
         pmRcl+AfX6NH5xfIcFaiR5gkFBnWjRS6QPETl6+LJ9N3/PpwaOtYCD0pQIBOnMkZE/YM
         iv8Lx/SZZbEM5+Q3IMG0SfTpnmrBC2r2DBo/P8ZRWZr8XpB7ZAnsfQEb1jl7ebxxgvY4
         2gnw==
X-Gm-Message-State: AOAM533CmUFAuRMKdS9iTrzr8s6eSbEpoxOewXNenQVo7Qz18aQY2Y9M
        ciIO1TIoVRfQdnXJDariSmKjgT0gfJh0rV+l5QULEOwqab0HavBwBX2R6u1XTBYokgsKoXa7WL7
        009bh8pXUkpB/mBpac/+1mQTPZVDSakXMRTKox539a5k=
X-Received: by 2002:aa7:8050:0:b029:28e:e823:5f1f with SMTP id y16-20020aa780500000b029028ee8235f1fmr6470593pfm.40.1620225385635;
        Wed, 05 May 2021 07:36:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb470PiupbdzTWzsrbjdhO2QmNMZWwryj2B+AUoRv0ZTohBpZs7SfyQwMrywBpZsx8dm0boaCWFEa5uAZPbxE=
X-Received: by 2002:aa7:8050:0:b029:28e:e823:5f1f with SMTP id
 y16-20020aa780500000b029028ee8235f1fmr6470565pfm.40.1620225385346; Wed, 05
 May 2021 07:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
 <CACT4oudp9Je55zjg7N8QFDWi5h3kmzMj6syfdi3KgAqQOVgPMA@mail.gmail.com>
 <1620216779.15370.10.camel@realtek.com> <CACT4ouehaQsGr1UGqncvAFgay0v40Zv=O=oz5f8W=E+YmV=SYg@mail.gmail.com>
 <1620223407.28283.2.camel@realtek.com> <CACT4ouePVqwkFRYRLCE7TznfWG87OKwhR2ukAYxO+ijOgZ26Dg@mail.gmail.com>
 <1620225209.1966.4.camel@realtek.com>
In-Reply-To: <1620225209.1966.4.camel@realtek.com>
From:   Inigo Huguet <ihuguet@redhat.com>
Date:   Wed, 5 May 2021 16:36:14 +0200
Message-ID: <CACT4oueTiwZPSvrZFZJpgkMQ04AKKP5qGB8ag2guTY==Y-KmVg@mail.gmail.com>
Subject: Re: rtlwifi: potential bugs
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Don't worry then, the explanation for humans is more than enough.

On Wed, May 5, 2021 at 4:33 PM Pkshih <pkshih@realtek.com> wrote:
>
> On Wed, 2021-05-05 at 16:20 +0200, Inigo Huguet wrote:
> > If it's no problem to add them, a comment STARTING WITH
> > `coverity[identical_branches]` should suppress the warnings.
> >
> > Example:
> >
> > /* Explanation why this code is fine
> >  * and great
> >  */
> > /* coverity[identical_branches] */
> > if (...)
> >         ...
> >
> > Thanks!
> >
> > On Wed, May 5, 2021 at 4:03 PM Pkshih <pkshih@realtek.com> wrote:
> > >
> > > On Wed, 2021-05-05 at 13:01 +0000, Inigo Huguet wrote:
> > > > Hi,
> > > >
> > > > Thanks for the info. Maybe we should consider adding some comments =
to
> > > > clarify this? Other people might also think these are bugs...
> > > >
> > > > Regards,
> > > >
> > > > On Wed, May 5, 2021 at 2:13 PM Pkshih <pkshih@realtek.com> wrote:
> > > > >
> > > > > On Wed, 2021-05-05 at 11:23 +0000, Inigo Huguet wrote:
> > > > > > On Fri, Apr 23, 2021 at 2:56 PM Inigo Huguet <ihuguet@redhat.co=
m> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > Executing some static analysis on the kernel, we've got this =
results
> > > > > > > affecting rtlwifi drivers:
> > > > > > >
> > > > > > > Error: IDENTICAL_BRANCHES (CWE-398): [#def212]
> > > > > > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/dri=
vers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2813:
> > > > > > > identical_branches: The same code is executed regardless of w=
hether
> > > > > > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =
=3D=3D
> > > > > > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'el=
se'
> > > > > > > branches are identical. Should one of the branches be modifie=
d, or the
> > > > > > > entire 'if' statement replaced?
> > > > > > > # 2811|   }
> > > > > > > # 2812|
> > > > > > > # 2813|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > > > > > # 2814|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH))=
 {
> > > > > > > # 2815|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, =
23);
> > > > > > >
> > > > > > > Error: IDENTICAL_BRANCHES (CWE-398): [#def213]
> > > > > > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/dri=
vers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2947:
> > > > > > > identical_branches: The same code is executed regardless of w=
hether
> > > > > > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =
=3D=3D
> > > > > > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'el=
se'
> > > > > > > branches are identical. Should one of the branches be modifie=
d, or the
> > > > > > > entire 'if' statement replaced?
> > > > > > > # 2945|   }
> > > > > > > # 2946|
> > > > > > > # 2947|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > > > > > # 2948|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH))
> > > > > > > # 2949|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, =
26);
> > > > > > >
> > > > > > > Error: IDENTICAL_BRANCHES (CWE-398): [#def214]
> > > > > > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/dri=
vers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3135:
> > > > > > > identical_branches: The same code is executed regardless of w=
hether
> > > > > > > "wifi_bw =3D=3D BTC_WIFI_BW_LEGACY" is true, because the 'the=
n' and 'else'
> > > > > > > branches are identical. Should one of the branches be modifie=
d, or the
> > > > > > > entire 'if' statement replaced?
> > > > > > > # 3133|   btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &=
wifi_bw);
> > > > > > > # 3134|
> > > > > > > # 3135|-> if (wifi_bw =3D=3D BTC_WIFI_BW_LEGACY) {
> > > > > > > # 3136|   /* for HID at 11b/g mode */
> > > > > > > # 3137|   btc8821a2ant_coex_table(btcoexist, NORMAL_EXEC, 0x5=
5ff55ff,
> > > > > > >
> > > > > > > Error: IDENTICAL_BRANCHES (CWE-398): [#def215]
> > > > > > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/dri=
vers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3324:
> > > > > > > identical_branches: The same code is executed regardless of w=
hether
> > > > > > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =
=3D=3D
> > > > > > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'el=
se'
> > > > > > > branches are identical. Should one of the branches be modifie=
d, or the
> > > > > > > entire 'if' statement replaced?
> > > > > > > # 3322|   }
> > > > > > > # 3323|
> > > > > > > # 3324|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > > > > > # 3325|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH))=
 {
> > > > > > > # 3326|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, =
23);
> > > > > > >
> > > > > > >
> > > > > > > In my opinion, they seem to be real bugs. However, it's very =
difficult
> > > > > > > to imagine what actions must be taken on each branch of the i=
f-else
> > > > > > > because they strongly depend on magic numbers, which are diff=
erent
> > > > > > > configurations for the hw, I guess.
> > > > > > >
> > > > > > > Can the maintainers confirm if these are real bugs and see ho=
w to fix them?
> > > > > > >
> > > > > > > Regards
> > > > > > > --
> > > > > > > =C3=8D=C3=B1igo Huguet
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > A few weeks ago I sent the message above notifying a potential =
bug in
> > > > > > rtlwifi module. I just wanted to be sure that it has been recei=
ved.
> > > > > > Can the maintainers acknowledge whether they have seen it?
> > > > > >
> > > > >
> > > > > Hi,
> > > > >
> > > > > Not real bugs. The coexistence programmers preserve the same code=
 of
> > > > > branches intentionally to fine tune performance easier, because b=
andwidth and
> > > > > RSSI strength are highly related to coexistence performance.
> > > > > The basic rule of performance tuning is to assign most time slot =
to BT
> > > > > for realtime application, and WiFi uses remaining time slot but d=
on't lower
> > > > > than low bound.
> > > > >
> > > > >
> > >
> > > Hi,
> > >
> > > I can add comments. Do you need any keyword within comment to avoid y=
our
> > > checking tool warns this false alarm?
> > >
>
> I do "git grep coverity | wc -l" and there are only 8 instances.
> I'm not sure if I can add comments with "coverity" marker.
>
> --
> Ping-Ke
>


--=20
=C3=8D=C3=B1igo Huguet

