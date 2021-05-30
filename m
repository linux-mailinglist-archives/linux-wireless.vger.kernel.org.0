Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0930A395033
	for <lists+linux-wireless@lfdr.de>; Sun, 30 May 2021 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE3JLI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 May 2021 05:11:08 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3JLH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 May 2021 05:11:07 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MMoT4-1m5uEG2ulI-00Inc7; Sun, 30 May 2021 11:09:28 +0200
Received: by mail-wm1-f41.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so4784935wmc.2;
        Sun, 30 May 2021 02:09:28 -0700 (PDT)
X-Gm-Message-State: AOAM532ZCsO8Hn1XL6s+KwD1hPinAqvwQ8VZgQqg84jqq2R+YI137bcl
        LnaOvnUIrINDf7cfUEY0wYZGnzpeVNawb5RqkZ0=
X-Google-Smtp-Source: ABdhPJzLDpQqsw/hIIucnfBoeU/nYJEtus8c7KsN+7ScHMWa23ZynfYlp4a7U4WjNtr1pvnGtVRkvoqxwZu+DWtwanE=
X-Received: by 2002:a7b:c446:: with SMTP id l6mr20508838wmi.75.1622365768363;
 Sun, 30 May 2021 02:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210530031134.23274-1-rdunlap@infradead.org>
In-Reply-To: <20210530031134.23274-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 30 May 2021 11:07:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0_BJ4POV1rq4na5R0Wo0fTXqrU6-5vXutjwZ3Lx2f8nw@mail.gmail.com>
Message-ID: <CAK8P3a0_BJ4POV1rq4na5R0Wo0fTXqrU6-5vXutjwZ3Lx2f8nw@mail.gmail.com>
Subject: Re: [PATCH v3] wireless: carl9170: fix LEDS build errors & warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oIL4BfkaaN083VkLmBXmeCQW+COsg9ZW0ID3JnTe26EGKHguVe7
 u0yzQHbwZLg+ullWiT05tkWQ8zrDaFfWF9zlt5vJYa9gX08ntkhCte/BcD+logHhgzhhn7G
 Wv69kEca0q+56NbJSZ3JHa25Jx6Qowxp6KW43CB4ZK3IYDWHC1Q4caVHnOwmnlqYaHUw/+T
 cRxP5NlIwXbZQzYbOB9WQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:y/qbQuHduPI=:t0eSvINWyE2zdUWiH/eC4/
 Id9U0hJrwyZqkiPBcMYN4a9cYrVqPhyF8ExiImjeqP1V55SthnENgd/bwlgFpbwj9fABQlx0X
 i9DYx1OPeDs8zm9WqFBBYqYQeaAp3Q0rbFuKjDrpYwSJh8k4tEBN02ESWlrAKETZ/fdPwnDlH
 rQpIUx6YpWZBw8WSdblEl7uCmFuWC09cXaZsundU6YQivbA/XX6uKV7LZ+CDPgsfS3I202+ba
 89V6WQEavyVh3QqXABGtrjKy3ByeVDYRoP5cptzAypJKMPscdjMyaktbeDngRUJD/spgidXuR
 6Mnj/gZ3iqdLpzH7X4AVzk0JRPnienJExtjUqKSjtQxXzQ7rbR2FNs7f2w6T7VWwk6qgtXKug
 uGauyF9w+GuYF4S04Ha4HNjKAWLcvmsN4ihtayE7ZAuKsfQIMq4uN4xir0xOq5+9AF/LpKY4M
 yFDinMva+AhpK6e/KkuGyzVTeH3IGjj+Wp659Jf+qcBi9glQWh0B6Mz/e58buVRzbsgfJEjP3
 J3wKu9inHgO5hSqetOOs+w=
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, May 30, 2021 at 5:14 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> kernel test robot reports over 200 build errors and warnings
> that are due to this Kconfig problem when CARL9170=m,
> MAC80211=y, and LEDS_CLASS=m.
>
> WARNING: unmet direct dependencies detected for MAC80211_LEDS
>   Depends on [n]: NET [=y] && WIRELESS [=y] && MAC80211 [=y] && (LEDS_CLASS [=m]=y || LEDS_CLASS [=m]=MAC80211 [=y])
>   Selected by [m]:
>   - CARL9170_LEDS [=y] && NETDEVICES [=y] && WLAN [=y] && WLAN_VENDOR_ATH [=y] && CARL9170 [=m]
>
> CARL9170_LEDS selects MAC80211_LEDS even though its kconfig
> dependencies are not met. This happens because 'select' does not follow
> any Kconfig dependency chains.
>
> Fix this by making CARL9170_LEDS depend on MAC80211_LEDS, where
> the latter supplies any needed dependencies on LEDS_CLASS.
>
> Fixes: 1d7e1e6b1b8ed ("carl9170: Makefile, Kconfig files and MAINTAINERS")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Christian Lamparter <chunkeey@googlemail.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Christian Lamparter <chunkeey@googlemail.com>
> ---
> v2: modify as suggesed by Arnd
> v3: modify as suggested by Christian

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

> --- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
> +++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
> @@ -16,13 +16,11 @@ config CARL9170
>
>  config CARL9170_LEDS
>         bool "SoftLED Support"
> -       depends on CARL9170
> -       select MAC80211_LEDS
> -       select LEDS_CLASS
> -       select NEW_LEDS
>         default y
> +       depends on CARL9170
> +       depends on MAC80211_LEDS
>         help
> -         This option is necessary, if you want your device' LEDs to blink
> +         This option is necessary, if you want your device's LEDs to blink.
>

I see some other drivers using a similar approach, but then making the
symbol silent. This also makes sense to me, but more importantly it would
be good to be consistent across drivers, and eventually move them all
to one model. Ideally that would avoid the 'select NEW_LEDS' entirely.

       Arnd
