Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4901C380F05
	for <lists+linux-wireless@lfdr.de>; Fri, 14 May 2021 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbhENReU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 May 2021 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhENReS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 May 2021 13:34:18 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E395FC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 14 May 2021 10:33:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l7so35593351edb.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 May 2021 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bmbAftPboaY7hu+DnMgt2b6hH50EmPqKJHrC7bAGn8=;
        b=OCUpNcjguSpqlmqGqLclnsNCOhgzU3pBtJ+0aWvCc2SR59QNIHWTyn2iHNnFIXoHb/
         IlrJnYgxa3QKa7TD5DPjuhh0hv9dsnnG2SJC44eepw5A/YU6NsZQR/5smJrlWciM7Uz7
         oY/UTgSqeb9/fYqELWpyA+6END7cpdJzA1bkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bmbAftPboaY7hu+DnMgt2b6hH50EmPqKJHrC7bAGn8=;
        b=blzzf6/87x2LeMc7VUuE8hZGh85zvo/fNoHS2Ggb1hmWgvtzQ0UX19zkQZ6Ja5los3
         MhscYlI8rpS1zE4JFr9T8v2SY8sh5PR0BHADNOxGSzJ5lDqcoFYBegcS+35WUcDMQDZL
         1ZUN26U0KKAuOW+orahqEpGt+nTCOKYb/89LVgcngKl7GwRQyZkRAI+yUeytueu2d005
         Dzfa1KP5742JWgQ1kTE9ThYw8gD5a1etaslk7yig/reQyl5jxXgkQ7VKpqptzRnUOx/P
         hdaz0g7BiKKzxCIVJH07p1LOhb1FZob4gq81vLnzXDDfBSmEjnPsdGrwEFKKv8ze1b4L
         M/9A==
X-Gm-Message-State: AOAM533VkFN76SOUQ4/2IBVFNz4HSYJXmMGTAi332R2GAvchdtc1TLdS
        QYcZJl659/0ucumVe2fgog0TyS4YTNs4t3KCZWA=
X-Google-Smtp-Source: ABdhPJzKed5vID4WLBwk3hsi3Exte/vQKeNtCOv2rGKcyi9Tca9pejwljHfmjByyvrozkrxDfd6Veg==
X-Received: by 2002:a50:9346:: with SMTP id n6mr5013793eda.365.1621013585448;
        Fri, 14 May 2021 10:33:05 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id nd36sm3750443ejc.21.2021.05.14.10.33.04
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 10:33:04 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id z17so24398wrq.7
        for <linux-wireless@vger.kernel.org>; Fri, 14 May 2021 10:33:04 -0700 (PDT)
X-Received: by 2002:a2e:9251:: with SMTP id v17mr38807472ljg.507.1621013573543;
 Fri, 14 May 2021 10:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210514100106.3404011-1-arnd@kernel.org>
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 May 2021 10:32:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
Message-ID: <CAHk-=whGObOKruA_bU3aPGZfoDqZM1_9wBkwREp0H0FgR-90uQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Unify asm/unaligned.h around struct helper
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jens Axboe <axboe@kernel.dk>,
        John Johansen <john.johansen@canonical.com>,
        Jonas Bonn <jonas@southpole.se>,
        Kalle Valo <kvalo@codeaurora.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Russell King <linux@armlinux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        openrisc@lists.librecores.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-ntfs-dev@lists.sourceforge.net,
        linux-block <linux-block@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 14, 2021 at 3:02 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> I've included this version in the asm-generic tree for 5.14 already,
> addressing the few issues that were pointed out in the RFC. If there
> are any remaining problems, I hope those can be addressed as follow-up
> patches.

This continues to look great to me, and now has the even simpler
remaining implementation.

I'd be tempted to just pull it in for 5.13, but I guess we don't
actually have any _outstanding_ bug in this area (the bug was in our
zlib code, required -O3 to trigger, has been fixed now, and the biggy
case didn't even use "get_unaligned()").

So I guess your 5.14 timing is the right thing to do.

        Linus
