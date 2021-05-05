Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E3373BE2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhEEND0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 09:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233225AbhEENCp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 09:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620219706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOqgZ3ZRMy0tlrHsf7RCrYq/TwiHxXEEQjJHOD1CnYQ=;
        b=QSDVus1b6RwlswwKrDGUhDxg+7Pp84SlY1RR6S7kVXBdyfumLOMOjCIaYdARlR5Qdzs4Fu
        eWzytig6XjnWzxrohxnyggJBGegpN9YhOpLoNWSA107AZOsCCt0IHsFMaY8FDsIqgV+uLp
        ol3zU2mJaBlmYEL3ztj1gDxQOQCoP2A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-sCvcxL_AO3mnw9xr6v544Q-1; Wed, 05 May 2021 09:01:40 -0400
X-MC-Unique: sCvcxL_AO3mnw9xr6v544Q-1
Received: by mail-pl1-f199.google.com with SMTP id l18-20020a170902e2d2b02900eefb0acd12so203852plc.18
        for <linux-wireless@vger.kernel.org>; Wed, 05 May 2021 06:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kOqgZ3ZRMy0tlrHsf7RCrYq/TwiHxXEEQjJHOD1CnYQ=;
        b=gJ1C0O6VR37ThS5U3n27o1dPiweVHrcMcNWwLc4SyscJ3QyVVgBi2tlBOmhB7TWBco
         k6zfrf40IFL3s6xOrI97qfM2+MlDEay3nnWEtctiEVG13mRy/ehiiPWxk43FhQmvdht7
         alvgsm0op+R8ZX1V6TDNE9KrXL2i99kC3DdnAA4tPVFJT+Ifjf2NprCmbWYRuWRQTeEv
         Y4MhU7vQYGTyDPNxNanolbrGouawQzLxcRq7fpEt2ZnDUkT8Fxnfkv3VbvxVHYM89yoT
         6MK+tr7n+es11gJgNu+TSRsbbUCmMcrn21Uim4t+LapXzDDYBtsO0iYS191Fq7pOP4k+
         QQFw==
X-Gm-Message-State: AOAM531B+3OM5snP2YUsS2MqizP14KoOanO/AFTjpALpBuAXSMFale/k
        hvUzMNeEaX459dHtyEfKbLsfmmITHJa2Y0BpkAtcXpQBL1IoqaQvLh4hpH2ETQMb9JsoCK/+LBU
        J2ad2a9t9xMNHtfCjn8FeZufne7b/zJMX/SSdw4Oh3jE=
X-Received: by 2002:a62:808b:0:b029:252:eddc:afb0 with SMTP id j133-20020a62808b0000b0290252eddcafb0mr29611017pfd.41.1620219699389;
        Wed, 05 May 2021 06:01:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykNVQSUbbgzjSyiAzxtUjklMFEtkuofikzhL41kVG95qwx8WVmC1IlDZPAyKmtUdigxs8/KxG0pKZLhzoBX+0=
X-Received: by 2002:a62:808b:0:b029:252:eddc:afb0 with SMTP id
 j133-20020a62808b0000b0290252eddcafb0mr29610979pfd.41.1620219699037; Wed, 05
 May 2021 06:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
 <CACT4oudp9Je55zjg7N8QFDWi5h3kmzMj6syfdi3KgAqQOVgPMA@mail.gmail.com> <1620216779.15370.10.camel@realtek.com>
In-Reply-To: <1620216779.15370.10.camel@realtek.com>
From:   Inigo Huguet <ihuguet@redhat.com>
Date:   Wed, 5 May 2021 15:01:27 +0200
Message-ID: <CACT4ouehaQsGr1UGqncvAFgay0v40Zv=O=oz5f8W=E+YmV=SYg@mail.gmail.com>
Subject: Re: rtlwifi: potential bugs
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Thanks for the info. Maybe we should consider adding some comments to
clarify this? Other people might also think these are bugs...

Regards,

On Wed, May 5, 2021 at 2:13 PM Pkshih <pkshih@realtek.com> wrote:
>
> On Wed, 2021-05-05 at 11:23 +0000, Inigo Huguet wrote:
> > On Fri, Apr 23, 2021 at 2:56 PM Inigo Huguet <ihuguet@redhat.com> wrote=
:
> > >
> > > Hello,
> > >
> > > Executing some static analysis on the kernel, we've got this results
> > > affecting rtlwifi drivers:
> > >
> > > Error: IDENTICAL_BRANCHES (CWE-398): [#def212]
> > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net=
/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2813:
> > > identical_branches: The same code is executed regardless of whether
> > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> > > branches are identical. Should one of the branches be modified, or th=
e
> > > entire 'if' statement replaced?
> > > # 2811|   }
> > > # 2812|
> > > # 2813|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > # 2814|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH)) {
> > > # 2815|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);
> > >
> > > Error: IDENTICAL_BRANCHES (CWE-398): [#def213]
> > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net=
/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2947:
> > > identical_branches: The same code is executed regardless of whether
> > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> > > branches are identical. Should one of the branches be modified, or th=
e
> > > entire 'if' statement replaced?
> > > # 2945|   }
> > > # 2946|
> > > # 2947|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > # 2948|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH))
> > > # 2949|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 26);
> > >
> > > Error: IDENTICAL_BRANCHES (CWE-398): [#def214]
> > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net=
/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3135:
> > > identical_branches: The same code is executed regardless of whether
> > > "wifi_bw =3D=3D BTC_WIFI_BW_LEGACY" is true, because the 'then' and '=
else'
> > > branches are identical. Should one of the branches be modified, or th=
e
> > > entire 'if' statement replaced?
> > > # 3133|   btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &wifi_bw)=
;
> > > # 3134|
> > > # 3135|-> if (wifi_bw =3D=3D BTC_WIFI_BW_LEGACY) {
> > > # 3136|   /* for HID at 11b/g mode */
> > > # 3137|   btc8821a2ant_coex_table(btcoexist, NORMAL_EXEC, 0x55ff55ff,
> > >
> > > Error: IDENTICAL_BRANCHES (CWE-398): [#def215]
> > > kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net=
/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3324:
> > > identical_branches: The same code is executed regardless of whether
> > > "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> > > BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> > > branches are identical. Should one of the branches be modified, or th=
e
> > > entire 'if' statement replaced?
> > > # 3322|   }
> > > # 3323|
> > > # 3324|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> > > # 3325|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH)) {
> > > # 3326|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);
> > >
> > >
> > > In my opinion, they seem to be real bugs. However, it's very difficul=
t
> > > to imagine what actions must be taken on each branch of the if-else
> > > because they strongly depend on magic numbers, which are different
> > > configurations for the hw, I guess.
> > >
> > > Can the maintainers confirm if these are real bugs and see how to fix=
 them?
> > >
> > > Regards
> > > --
> > > =C3=8D=C3=B1igo Huguet
> >
> > Hello,
> >
> > A few weeks ago I sent the message above notifying a potential bug in
> > rtlwifi module. I just wanted to be sure that it has been received.
> > Can the maintainers acknowledge whether they have seen it?
> >
>
> Hi,
>
> Not real bugs. The coexistence programmers preserve the same code of
> branches intentionally to fine tune performance easier, because bandwidth=
 and
> RSSI strength are highly related to coexistence performance.
> The basic rule of performance tuning is to assign most time slot to BT
> for realtime application, and WiFi uses remaining time slot but don't low=
er
> than low bound.
>
> --
> Ping-Ke



--=20
=C3=8D=C3=B1igo Huguet

