Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1E4DA0F2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Mar 2022 18:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350495AbiCORP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 13:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350489AbiCORPZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 13:15:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778841EAEC
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 10:14:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w4so25076870edc.7
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89AapUKE/1pFpkNlzVSvl0gcg/r2kqLZ2/9LmCBzmGw=;
        b=eIytPWVlHZG2c+3ssVjE3ER93sxCwkcHLBBjPEF/CN2OkYiJ1qyEanUT5e2Fng/dvQ
         cTz2EqvgfhPaL6KT/YJ1aKcd5EWDAWbwCu0qrNrZPRj+zxQ4mZzMCdTXGsGsPQfjic5y
         /a8HTCfZuBmRijJeDeSHHPfXo3cwN72mlQj5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89AapUKE/1pFpkNlzVSvl0gcg/r2kqLZ2/9LmCBzmGw=;
        b=A/ug4nLi6Ubh+12k+1ixC4MLspKwoAHrGQT3VVF0Ws6W7bc6WOqBNHSyaZWENhq1oO
         SrcP2ph2SyMcWoPEg8NZjhjauiZsjeQbfQAna9VGp1Qr2DaRsPVkT0xX32J22KOqceLL
         CjwooG0/3DNDk2bi9L+VhtUhnefd/uznXGdTRQkephZNXgjTOtk3rRUbFpV4rPUDNJMH
         wNwYcgGXbTw18h7jzu3azk3x7iRM/TOzZc3f3+gMf049NIsuNJVNLwljxNpgLkgLL9eM
         WuattP2uJcu6RcajUF6OGbEnXi5lTWxnDRz1Q8AR353NoPkh3OJBrz9jvk1c/TjUlP/o
         Wq5A==
X-Gm-Message-State: AOAM533hJPoiDW2FSDW+q4agER8t6IBa7lIJS8EDXnVeguJD3j6yMG0l
        9VnTV78HA4wpv1XQq4XuS7pNhel2O/d9CL8gJm4=
X-Google-Smtp-Source: ABdhPJz1s1hFF3aoy5vki5xBzIwTjZi0qFZDqv4g6nDb3rv9iHm+wc1Kz6N03jCw2Q8rFkvTSY4xIQ==
X-Received: by 2002:a05:6402:4248:b0:416:9c69:4f80 with SMTP id g8-20020a056402424800b004169c694f80mr26230385edb.83.1647364451725;
        Tue, 15 Mar 2022 10:14:11 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id w14-20020a170906d20e00b006cee22553f7sm8398678ejz.213.2022.03.15.10.14.11
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 10:14:11 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id p15so42964054ejc.7
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 10:14:11 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr10011514lfh.687.1647364132924; Tue, 15
 Mar 2022 10:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009e7a1905b8295829@google.com> <00000000000003887a05da3e872c@google.com>
In-Reply-To: <00000000000003887a05da3e872c@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Mar 2022 10:08:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4HBk7o8_dbpk=YiTOFxvE9LTiH8Gk=1kgVxOq1jaH7g@mail.gmail.com>
Message-ID: <CAHk-=wj4HBk7o8_dbpk=YiTOFxvE9LTiH8Gk=1kgVxOq1jaH7g@mail.gmail.com>
Subject: Re: [syzbot] KASAN: out-of-bounds Read in ath9k_hif_usb_rx_cb (3)
To:     syzbot <syzbot+3f1ca6a6fec34d601788@syzkaller.appspotmail.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        ath9k-devel@qca.qualcomm.com, chouhan.shreyansh630@gmail.com,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:USB GADGET/PERIPHERAL SUBSYSTEM" 
        <linux-usb@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 15, 2022 at 2:36 AM syzbot
<syzbot+3f1ca6a6fec34d601788@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit
> 09688c0166e7 ("Linux 5.17-rc8")

No, I'm afraid that means that the bisection is broken:

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140283ad700000

and yeah, looking at that log it looks like every single run has

  testing commit [...]
  run #0: crashed: KASAN: use-after-free Read in ath9k_hif_usb_rx_cb
  ...
  # git bisect good [...]

and you never saw a "bad" commit that didn't have the issue, so the
top-of-tree gets marked "good" (and I suspect you intentionally mark
the broken case "good" in order to find where it got fixed, so you're
using "git bisect" in a reverse way).

I didn't look closer, but it does seem to not reproduce very reliably,
maybe that is what confused the bot originally.

                   Linus
