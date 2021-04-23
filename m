Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD3369288
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 14:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhDWM5i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 08:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48307 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230305AbhDWM5h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 08:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619182620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JL37Xr5A7RxA1jk5xSyloErvW66a1R8MiXMyGHc3JD8=;
        b=UnDuX0ZREXlNu5EWyjfKFjCyfXO/LIbrn2E8K/gB5IJ2MlGV39F4JnSbkzRXv4a+4IF2DH
        sY2QLR4v/BJuc+UGZ7EnQmZD58XdaPdm+ydgBVT4TPcjA8DmfvyTQvZ4pXsbGiv5eRPmxh
        liNMtXsN0UnM71EMwEq9XKu8CGM9UGQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-UvfGiHIfNJy6nTt1qypKKQ-1; Fri, 23 Apr 2021 08:56:59 -0400
X-MC-Unique: UvfGiHIfNJy6nTt1qypKKQ-1
Received: by mail-io1-f72.google.com with SMTP id v18-20020a5ed7120000b02903f36dccaebcso9275009iom.15
        for <linux-wireless@vger.kernel.org>; Fri, 23 Apr 2021 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=JL37Xr5A7RxA1jk5xSyloErvW66a1R8MiXMyGHc3JD8=;
        b=Dc+LvBWwT5t4s+sahjrGW58Kp1IVXIMByfo5ckmk4RRRq/IYIo2N0KtlecFlXvYylr
         tQCr8+f3XpAcCTkWvqo3w9JuaqwvPHgfCh2DbUpPidUNuUP+F9Xrjpod1f7xElFoiQVs
         ab0vfCwcMJElDYV6jejcbUlZYt8cbMpf2B5hCGHf0FfUDQenKdV10LKAHjZXSHGuep3p
         DY8PDtxupmsjo7fDyiQnzL7TAbUYG2lHNgh0uVDNIEg7YXNCb26Pr1irXJU2h71bm42/
         xpKEBRlZL1ohEYLdsaOnd7ww7JCNLsSdS48cdMW/Ad3nZXbiTei/7qAI6OB6P4RsnRom
         GjyA==
X-Gm-Message-State: AOAM5336jByTJmBrFxxv1HQr0iADTsS3Y1RYK+9x0xnLv9Y6qBAvHXmJ
        EZOxIulCNf4+LV7ujLoqhwEAXSHYxCc9spI0qGfmEt3LcXwbE/9tsacuWcn8vabevrEWpazrgVJ
        VdafzrD5ylI9i28e7zaMUiu1K/x8WZQuLhIcvEB72KL4=
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr3265690ion.27.1619182618279;
        Fri, 23 Apr 2021 05:56:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBFc1NkjWCXqFw5X50mrGWpq853ky+GGVkfFBXTZmGOJrFpWadfV+Hkz5pB1nr1VCvC9zS3W7nIf/o0xcqBtI=
X-Received: by 2002:a5d:8c89:: with SMTP id g9mr3265676ion.27.1619182618040;
 Fri, 23 Apr 2021 05:56:58 -0700 (PDT)
MIME-Version: 1.0
From:   Inigo Huguet <ihuguet@redhat.com>
Date:   Fri, 23 Apr 2021 14:56:47 +0200
Message-ID: <CACT4ouecdXk3SQrgUNKnr4u2WAaiBUjgou5u_H1bEubTcrGtFQ@mail.gmail.com>
Subject: rtlwifi: potential bugs
To:     pkshih@realtek.com, linux-wireless@vger.kernel.org
Cc:     Ivan Vecera <ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Executing some static analysis on the kernel, we've got this results
affecting rtlwifi drivers:

Error: IDENTICAL_BRANCHES (CWE-398): [#def212]
kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net/wirel=
ess/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2813:
identical_branches: The same code is executed regardless of whether
"bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
branches are identical. Should one of the branches be modified, or the
entire 'if' statement replaced?
# 2811|   }
# 2812|
# 2813|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
# 2814|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH)) {
# 2815|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);

Error: IDENTICAL_BRANCHES (CWE-398): [#def213]
kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net/wirel=
ess/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2947:
identical_branches: The same code is executed regardless of whether
"bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
branches are identical. Should one of the branches be modified, or the
entire 'if' statement replaced?
# 2945|   }
# 2946|
# 2947|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
# 2948|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH))
# 2949|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 26);

Error: IDENTICAL_BRANCHES (CWE-398): [#def214]
kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net/wirel=
ess/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3135:
identical_branches: The same code is executed regardless of whether
"wifi_bw =3D=3D BTC_WIFI_BW_LEGACY" is true, because the 'then' and 'else'
branches are identical. Should one of the branches be modified, or the
entire 'if' statement replaced?
# 3133|   btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_BW, &wifi_bw);
# 3134|
# 3135|-> if (wifi_bw =3D=3D BTC_WIFI_BW_LEGACY) {
# 3136|   /* for HID at 11b/g mode */
# 3137|   btc8821a2ant_coex_table(btcoexist, NORMAL_EXEC, 0x55ff55ff,

Error: IDENTICAL_BRANCHES (CWE-398): [#def215]
kernel-5.11.0-0.rc7.151/linux-5.11.0-0.rc7.151.el9.x86_64/drivers/net/wirel=
ess/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3324:
identical_branches: The same code is executed regardless of whether
"bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH || bt_rssi_state =3D=3D
BTC_RSSI_STATE_STAY_HIGH" is true, because the 'then' and 'else'
branches are identical. Should one of the branches be modified, or the
entire 'if' statement replaced?
# 3322|   }
# 3323|
# 3324|-> if ((bt_rssi_state =3D=3D BTC_RSSI_STATE_HIGH) ||
# 3325|      (bt_rssi_state =3D=3D BTC_RSSI_STATE_STAY_HIGH)) {
# 3326|   btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);


In my opinion, they seem to be real bugs. However, it's very difficult
to imagine what actions must be taken on each branch of the if-else
because they strongly depend on magic numbers, which are different
configurations for the hw, I guess.

Can the maintainers confirm if these are real bugs and see how to fix them?

Regards
--=20
=C3=8D=C3=B1igo Huguet

