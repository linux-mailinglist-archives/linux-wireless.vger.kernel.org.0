Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A355D394C22
	for <lists+linux-wireless@lfdr.de>; Sat, 29 May 2021 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhE2MNl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 May 2021 08:13:41 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhE2MNj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 May 2021 08:13:39 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MXH7g-1lu9Ne3R4o-00Yf3k; Sat, 29 May 2021 14:12:00 +0200
Received: by mail-wr1-f48.google.com with SMTP id f11so5890940wrq.1;
        Sat, 29 May 2021 05:12:00 -0700 (PDT)
X-Gm-Message-State: AOAM531V7mB4y/tTXAEpqh7y55HkzmQC/UYHSA3NQAQSFHT9wRdoNVJ5
        jyR8K1ZkqYB+4mUJ5ij/5h4ULXMyiNOMoqdzHCY=
X-Google-Smtp-Source: ABdhPJwj4ddQH/kkWrToqiXjuuZw4oFvsfNtI2oNoNLEHzsy+IDZup8Sh5Bs8Mc6+7rFuKBo95mR+TPvDL/Kd5fyNU0=
X-Received: by 2002:adf:a28c:: with SMTP id s12mr14087456wra.105.1622290320379;
 Sat, 29 May 2021 05:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210529071523.2044-1-rdunlap@infradead.org>
In-Reply-To: <20210529071523.2044-1-rdunlap@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 29 May 2021 14:10:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2mmQvsK+geQCGAOjZ4r2S9E4AUkWaT2coKW2AL8ZOAYg@mail.gmail.com>
Message-ID: <CAK8P3a2mmQvsK+geQCGAOjZ4r2S9E4AUkWaT2coKW2AL8ZOAYg@mail.gmail.com>
Subject: Re: [PATCH] wireless: carl9170: fix LEDS build errors & warnings
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:WOe+E8GiYoi1YJ4uKMT6YmB+XjCet8Kfi/iSai+QXjAeBQVST3U
 HLbbfFzz5iijFRLdiOyu9yDC/0pCn7rIiSC6Lbq2oCDBrzbNXldrBaE/bbzCwlxnHj0fUQ2
 qQCXNUcpWRczeBK+CB/0JkfjBeRmTOGkMhVlzvxQtT2xU2wN5EmS5kQTXbiyW5hz0AAcWdL
 vnOb5HI/b1zuW2Wj+rl8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:A7YDe+6hyxU=:qxG3mZ7FPJrAcI1aKPsHBJ
 ztulVK2c4LMbKD4msf12x4DUG5BCM8U3bFy1Koj/6glM2ELnr6SVjfUi9A2W5LNPxkfymNpbE
 kLrY9XyqvESglKMGop5xpqvivt+tWD9kJxz4I2XkRlaIKnTQC/avYoaxFzcHaZ0FVfI5kflpC
 1aUvBO9yHLPvRFkovdjpdOtnPUdH6xpc5hRtDmEkNl/BlZKTEL/62PR620EGVZv7Hr5590Dxf
 DkV4OflCylmV0pnffbe+3+QKujvP0OdXiVkpQkZOYVVfgbvk4x5btOoq9Kp0CenZ6BTMbbMRi
 dX3r1TeWfiHGWpBL2BCDRi0E/s+uW7mdI9uDgjl055aAQ4vyzeN0tkGLy7tvMHZwKSuo98ZX0
 4ENXYESMabNnWP6ywxRSCZvZ/yZh6+l9ipMc9YkfK95ZgDmSTBWRZwJpVE15hxE9NmLsVlE/F
 TEBF9yb0fuuHDqOBvFRaCLvqHbQc3eyOZea41PCvg+hlg7ievlyqdtl2O0WPPH2QN5oX5cGEM
 mEkmsK5+BH8DYtFobZ8daU=
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 29, 2021 at 9:16 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> kernel test robot reports over 200 build errors and warnings
> that are due to this Kconfig problem when CARL9170=m,
> MAC80211=y, and LEDS_CLASS=m.

I think this avoids the build problems, but it's not really logical:

> --- linux-next-20210528.orig/drivers/net/wireless/ath/carl9170/Kconfig
> +++ linux-next-20210528/drivers/net/wireless/ath/carl9170/Kconfig
> @@ -17,9 +17,7 @@ config CARL9170
>  config CARL9170_LEDS
>         bool "SoftLED Support"
>         depends on CARL9170
> -       select MAC80211_LEDS
> -       select LEDS_CLASS
> -       select NEW_LEDS
> +       select MAC80211_LEDS if LEDS_CLASS=y || LEDS_CLASS=MAC80211
>         default y
>         help
>           This option is necessary, if you want your device' LEDs to blink

The point of the option is to enable LED support, but now it doesn't do that
when LEDS_CLASS is a loadable module and MAC80211 is built-in.

I think a more sensible solution would be to follow the example of

config MT76_LEDS
        bool
        depends on MT76_CORE
        depends on LEDS_CLASS=y || MT76_CORE=LEDS_CLASS
        default y

    Arnd
