Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050A018E1B3
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2020 15:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgCUOEl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Mar 2020 10:04:41 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]:43021 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgCUOEl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Mar 2020 10:04:41 -0400
Received: by mail-qt1-f172.google.com with SMTP id a5so464117qtw.10
        for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2020 07:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=C+fELGJdVONd1eorgvkowwvBoLWz33e73DTzwPdtvvw=;
        b=J/VuiWU4Tkq0tXrhc7sXeG343DWNv2jPQdCBtIZM4ZIrIQgxupD2E3UW12j7dcUCC0
         G/HtITRHOU+xcmehMKBKBpzRbJjw62GlDS6pK+w+ZBt8AkAIuZXh2RwXrlaN8P2dFvN6
         tN4EY+rMPtl5qk1MpRKpFcL5e1UYlF5A6InZSFa3TPAZj+OsiS5dsdS12OYL9tOYoROR
         znJHULp1s07K2mC/UXBivULxJrCNzwQDy9Pam6hm1VJ8rEipOiDLLtddyI1FuKf32ikm
         siPi0jPlcuZGfQWCAmLLxeA3as57psKCqj5JkqSLCGsjI8wGumDeLGL4SpmMi6Uhq3qd
         AbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=C+fELGJdVONd1eorgvkowwvBoLWz33e73DTzwPdtvvw=;
        b=SkdCDcTPhkLF7Qo5JmcgS2Ij1cWY8GUzRtQRFV9bTkxKCTk789CRkaYW/cOGxBW/h2
         N0DDC2hbIr7h6r+VQ4WWDQksIi7tlcICkRuX+/19Vds5U0Eq/62DRj4aBE4bIskJtkbA
         x47fseO4xDvUVLOTfNTiynOV6tcmQAqtoRhfYQtgp4pR64kHQLlwjHvW+vSZ1LIp+iiX
         f78RG3XhbY2iRmLLB89Om5sFbvFoO5+2A4pXeZBjBgiYL/egtq07kv7zGFO4/VQot4cr
         NXv6YgXMQSz/Vynj0utW5R/NHFnx+EFxL/fJtgmMOgAH1xiqWZieoF6a/vIUQE9U2jj1
         UnLQ==
X-Gm-Message-State: ANhLgQ0uGxzrhRH6JOAnI14nhv4kKWY2L+7oDef5MCSS61tjeBfD7dJD
        bMf6W6fo+BupKi/vuZTxYsu8ZzPejH3ElFf9mVqKl2wsilI=
X-Google-Smtp-Source: ADFU+vtYJUWyZsfPraG0OJZlqEgWdV06GIxXgZAJ3dBIJL9Sj9zfyZWjEWbd166aL2uaz3zGn6bUO35fsrlmsj8mdVc=
X-Received: by 2002:aed:33a6:: with SMTP id v35mr13244985qtd.328.1584799478659;
 Sat, 21 Mar 2020 07:04:38 -0700 (PDT)
MIME-Version: 1.0
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Sat, 21 Mar 2020 15:04:27 +0100
Message-ID: <CAFED-j=LrpURGKYwHd8Pmdo633nNb9mR4XmmPGNv-dhvBZQR+w@mail.gmail.com>
Subject: ath9k/mac80211 wrong hw RX filter? - tests, dpp_pkex* failed
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     Jouni Malinen <j@w1.fi>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Just check dpp_pkex* test cases in my remote test environment (ath9k
devices) and seems by default fail:
 - supplicant using remain_on_channel here
 - we don't receive broadcast action frame(s) (PKEX exchange request)
 - I suspect HW rx filter configuration don't work correctly here

In case will add monitor interface to the iface that ath9k station
using, test case always pass (we receive this action frame(s) when
remain-on-channel).

janusz@e4300:~/work/hostap-hwsim/tests/remote$ ./run-tests.py -c
config-home.py -r t2-ath9k-1 -r t2-ath9k-2 -h dpp_pkex
REF   (dev): t2-ath9k-1
REF   (dev): t2-ath9k-2
RUN check_devices
PASS
START - dpp_pkex (1/1)
FAILED (DPP authentication did not succeed (Responder)) - 30.925673s
Failed test cases:
dpp_pkex

janusz@e4300:~/work/hostap-hwsim/tests/remote$ ./run-tests.py -c
config-home.py -r t2-ath9k-1 -r t2-ath9k-2 -m t2-ath9k-1 -h dpp_pkex
REF   (dev): t2-ath9k-1
REF   (dev): t2-ath9k-2
MON: t2-ath9k-1
RUN check_devices
PASS
START - dpp_pkex (1/1)
PASS () - 2.396301s

Seems we pass this for hwsim, but I suspect we don't use hwsim filters?

I see that wpa_supplicant register different action frames and finally
we configure this in mgmt_frame_register() next
ieee80211_mgmt_frame_register().
Do we miss some functionality here (in mac80211) or this is pure ath9k bug?

Interesting, that 'monitor trick' doesn't work for intel-ax200.

janusz@e4300:~/work/hostap-hwsim/tests/remote$ ./run-tests.py -c
config-home.py -r t3-intel-ax200 -r t2-ath9k-2 -h dpp_pkex
REF   (dev): t3-intel-ax200
REF   (dev): t2-ath9k-2
RUN check_devices
PASS
START - dpp_pkex (1/1)
FAILED (DPP authentication did not succeed (Responder)) - 31.242791s
Failed test cases:
dpp_pkex

janusz@e4300:~/work/hostap-hwsim/tests/remote$ ./run-tests.py -c
config-home.py -r t3-intel-ax200 -r t2-ath9k-2 -m t3-intel-ax200 -h
dpp_pkex
REF   (dev): t3-intel-ax200
REF   (dev): t2-ath9k-2
MON: t3-intel-ax200
RUN check_devices
PASS
START - dpp_pkex (1/1)
FAILED (DPP authentication did not succeed (Responder)) - 32.449632s
Failed test cases:
dpp_pkex

BR
Janusz
