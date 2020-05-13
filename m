Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FCE1D2177
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgEMVuI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 17:50:08 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:36723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbgEMVuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 17:50:08 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MbRbr-1ixzYF26Z7-00bqgH; Wed, 13 May 2020 23:50:06 +0200
Received: by mail-qv1-f54.google.com with SMTP id ee19so687688qvb.11;
        Wed, 13 May 2020 14:50:06 -0700 (PDT)
X-Gm-Message-State: AOAM531JAEN9kSOOT1Y1baGa3r4pXSpQxM3vbmLSiwXKY1sseErZos0/
        szpHAOjmK/PoYhEmkoU4y5YmUzsnfQ3Db0WCQcU=
X-Google-Smtp-Source: ABdhPJxu6IOeZhVVTBpAnf6wMcH+LrEESP7lfvaexyVk2mxPcafnnpFLiQtV6YqpD7k1w+UdsGU8e7ppGk9I/merpdo=
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr1706535qvp.197.1589406605322;
 Wed, 13 May 2020 14:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-1-arnd@arndb.de> <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com> <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com> <20200513214128.GB6733@zn.tnic>
In-Reply-To: <20200513214128.GB6733@zn.tnic>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 May 2020 23:49:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
Message-ID: <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Borislav Petkov <bp@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ObwVCSlB/YIwv/A8inaMufMiam7thFJq82AUznYSpJ74m2HOXz7
 TcPAdoPZ7qyhsM2nd0SmTXxwQvPlXdZoZTnC7dJekeqFSJ2a7ZD8hVIpnHP2khbHU+8gsK0
 YjZl0nAkqb/Jx8vEs0h8ucVVZlIrfIMBBkcp1fc4MozTwaO66Tkj25v7tZh7+e+J7vPkZjk
 ggoxlgoCpekurLCQI7PYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tDehfZeI1xE=:qrAs+11EYEgqXNdleolY3D
 xku0pVmWpaS80lOiusVPe/MyQGiBkiCjhQbqUKlGnweUiCpQ4AQVAzmaxytZhWhrA6sT18A0C
 CVC0FRTMiP+LPFSx3wDDOnReKHd7EVLSUvRDdiRyEUAI2V7etT18DyeeBIq33hh176X/AOKGx
 q4t2DV8xAHNWXk+UES7Qxz7f0dfwyO5tA9N+5UeQPX5pvl1wCNGb8wurOfiPx740RWGXmVKGD
 SaADQUk4MWogCRgz48RYAArbnUhpgDX7pZpmFQvditqVYEveu9l6UIT4/xVMHTI54lLv8R3NT
 Rfyj1lLjPFy1nz3JOyrcdiwmMt47803sarE8HwYN069k5xTVFCq2Bihyoyr3p5uImBmwAqCsx
 1l4SwRoF3ITvH2TTxvs+nQZ5gEFIP+rXYOqUkt7fbF6zglQyWMtzcrDlgdo/vOczJdPJquMTg
 CxZfMs7SLc0uTfKKbTgSnAJOW2qUj4p0/aof10Gl2hAz28npbEqPKmU3oCMB+dFSvANk7BrLI
 DUz3LksPzkGSg1Z8g7kBOumU9DWtAVZBvjRXz6xi1ZFcRDbnIzUYacv7thXt6Zodro3vthK7y
 z6S3t9qQq80kKnpIIKSqeo7YI85bDZuG2YJg8poDQb7E9lMWiWzRbJ/uaUP4TeOWlfp/Ccy6r
 PT2yZ2tJOvr2OJ2C5BBF+fKvsaCfNdFB3X4PA4Vk5sH7Vkh51z3fxVRuVYIqKGv1dlaUrE/BQ
 TSbKcZzVxTaYIgr5XYVXhW+/6mTCPkhGq5kUN3GzFQF7LnurwM3hD38j2+CjnJpkV3u5Bzli1
 UzGx6I83Rxfu69yh2IyVJyTQWNu4W1lopWJMkG0qxXuSb/YzU0=
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 11:41 PM Borislav Petkov <bp@suse.de> wrote:
>
> On Wed, May 13, 2020 at 11:28:09PM +0200, Arnd Bergmann wrote:
> > I see the patch in linux-next but not in mainline. I suppose we want
> > it in v5.7 and backported to stable kernels so they can boot when
> > built with gcc-10?
>
> It is queued for 5.8. For a good reason, if you read the whole thread
> Arvind pointed you to.
>
> Lemme guess: gcc10 got released in the meantime (hohumm, website says
> so) and so we probably should expedite this and send it to Linus now...?

Right, in particular since Linus started building with gcc-10 already and
would likely soon run into that problem if he hasn't already ;-)

      Arnd
