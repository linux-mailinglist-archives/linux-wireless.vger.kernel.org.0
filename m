Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD37373940
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 13:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhEELY5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 07:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbhEELY5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 07:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620213840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hffqOq3YCP4M39yMWPMnYY8Ldp9nls3UMIU5xjslAeg=;
        b=XHnAjiaDq0iwGGx+vK6zvo423qUkRxf+pf1dLwXI5e3WkcA6lfbroUiuZKQ71DSrxFKdg9
        2ym+OruPRgei8ApddzW3QoBokSHF0BiYomOaQ81M9H66AGCHKRsHTjgd/pH6SBb1i4bUnD
        WnBdcfkDK3sQsKuYdWq+0OvXZZ+/YjA=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-dfrZy1g0PZ-pQ3_EVH2bMg-1; Wed, 05 May 2021 07:23:59 -0400
X-MC-Unique: dfrZy1g0PZ-pQ3_EVH2bMg-1
Received: by mail-pf1-f200.google.com with SMTP id j184-20020a6255c10000b0290214249d921cso1213973pfb.17
        for <linux-wireless@vger.kernel.org>; Wed, 05 May 2021 04:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hffqOq3YCP4M39yMWPMnYY8Ldp9nls3UMIU5xjslAeg=;
        b=JSnBPIWekiifNi18t3gjcSiAY54j5rSMAIxoDvRF/v7CKpnWAGv0T+sLXqelQAc03F
         qiZvqffUaCgmyVW6Vw7wVLcNCkCWbtntWoiXveU25fthho2k4VGjA4o6JOTr1KeCzM+O
         LSWKDtpqOPcW5tONZpWqbGads5vfMhvI6r8Nouew7CFoiiSuBczsj9oiEEHx4jcEnq5F
         tqDX1gpUBWR+2xeOAQyIih2I5GVDmYnxlzOEre/A7/hkfDEjHswmv8rkv2TNJ9v9Fxm4
         YOTz5QWeBrqaC23j11UF9KmQZvxp8kaI5mZ2eztT5tJN2UrlXild6fT3RcShrUZ2N3TE
         uAkA==
X-Gm-Message-State: AOAM532L0iObuQjY9DU0Kci7UItzJvfUdcecnmR1TtkkE8dVGZzWV0Jo
        wCbzl2QYJZPKC021uMg0852L4ptmT9GK5RsQwPgqfuKjM43v8gxCEoQoHY1T/jS/CWE9pMAjAQF
        AK78V+noeVmN4AHrbQk7ezzD0xOUzhpwuEQ2sVnvf3Gc=
X-Received: by 2002:a62:808b:0:b029:252:eddc:afb0 with SMTP id j133-20020a62808b0000b0290252eddcafb0mr29213459pfd.41.1620213837778;
        Wed, 05 May 2021 04:23:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCN0bXv54xoWXgP5Zl7GbpvNyJ+8PUFUv6XPHJyHjJUvlz9M7kxBNadWHIuCCMmXC3Yes8lKfrRJhNNXYjPTk=
X-Received: by 2002:a62:808b:0:b029:252:eddc:afb0 with SMTP id
 j133-20020a62808b0000b0290252eddcafb0mr29213442pfd.41.1620213837502; Wed, 05
 May 2021 04:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
In-Reply-To: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
From:   Inigo Huguet <ihuguet@redhat.com>
Date:   Wed, 5 May 2021 13:23:46 +0200
Message-ID: <CACT4oudp9Je55zjg7N8QFDWi5h3kmzMj6syfdi3KgAqQOVgPMA@mail.gmail.com>
Subject: Re: rtlwifi: potential bugs
To:     pkshih@realtek.com, linux-wireless@vger.kernel.org
Cc:     Ivan Vecera <ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 23, 2021 at 2:56 PM Inigo Huguet <ihuguet@redhat.com> wrote:
>
> Hello,
>
> Executing some static analysis on the kernel, we've got this results
> affecting rtlwifi drivers:
>
> Error: IDENTICAL_BRANCHES (CWE-398): [#def212]
> kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net/wir=
eless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2813:
> identical_branches: The same code is executed regardless of whether
> "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> branches are identical. Should one of the branches be modified, or the
> entire 'if' statement replaced?
> # 2811|   }
> # 2812|
> # 2813|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> # 2814|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH)) {
> # 2815|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);
>
> Error: IDENTICAL_BRANCHES (CWE-398): [#def213]
> kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net/wir=
eless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2947:
> identical_branches: The same code is executed regardless of whether
> "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> branches are identical. Should one of the branches be modified, or the
> entire 'if' statement replaced?
> # 2945|   }
> # 2946|
> # 2947|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> # 2948|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH))
> # 2949|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 26);
>
> Error: IDENTICAL_BRANCHES (CWE-398): [#def214]
> kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net/wir=
eless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3135:
> identical_branches: The same code is executed regardless of whether
> "wifi_bw =3D=3D BTC_WIFI_BW_LEGACY" is true, because the 'then' and 'else=
'
> branches are identical. Should one of the branches be modified, or the
> entire 'if' statement replaced?
> # 3133|   btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &wifi_bw);
> # 3134|
> # 3135|-> if (wifi_bw =3D=3D BTC_WIFI_BW_LEGACY) {
> # 3136|   /* for HID at 11b/g mode */
> # 3137|   btc8821a2ant_coex_table(btcoexist, NORMAL_EXEC, 0x55ff55ff,
>
> Error: IDENTICAL_BRANCHES (CWE-398): [#def215]
> kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net/wir=
eless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3324:
> identical_branches: The same code is executed regardless of whether
> "bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
> BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
> branches are identical. Should one of the branches be modified, or the
> entire 'if' statement replaced?
> # 3322|   }
> # 3323|
> # 3324|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
> # 3325|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH)) {
> # 3326|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);
>
>
> In my opinion, they seem to be real bugs. However, it's very difficult
> to imagine what actions must be taken on each branch of the if-else
> because they strongly depend on magic numbers, which are different
> configurations for the hw, I guess.
>
> Can the maintainers confirm if these are real bugs and see how to fix the=
m?
>
> Regards
> --
> =C3=8D=C3=B1igo Huguet

Hello,

A few weeks ago I sent the message above notifying a potential bug in
rtlwifi module. I just wanted to be sure that it has been received.
Can the maintainers acknowledge whether they have seen it?

Thanks!
--=20
=C3=8D=C3=B1igo Huguet

