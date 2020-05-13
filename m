Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523DA1D22CF
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbgEMXOS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 19:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732334AbgEMXOP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 19:14:15 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92107C061A0E
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 16:14:14 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a4so928042lfh.12
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0j3/OIPLsEoSjumgEsA8PXHbekOcSjeJ/f/Whs1clc8=;
        b=aWY/W00Vhs08u53IbUOOBmS6kQV0IdXs0gGbI9xldX6dgisVMq/l6vfmkGNI1z7fWx
         tOJl3WVP9kL5eNCEZgAeoeDhMecMnoXs+tEv8IopMGuY4Z8/YdVmykgjM8brjp9eWPdB
         rs/NoCXW7VxjHDjL5BXCEJsCICzD98wX2vGhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0j3/OIPLsEoSjumgEsA8PXHbekOcSjeJ/f/Whs1clc8=;
        b=M0D3vGXaURphzbkeRnqrWdHwiUHRcAQfP/0Q0GbnrYzX8kHUU8bcuEzgG7N8fFc0y3
         cAEF78H0LYIl9SbREV5nsbR2b9dNjbhv6oIMzEBdGEcYCtEmElXvrGXWSihQI+QGaTHS
         JjD7lCedKXM+d40zo6qJEhwzoJtDqfGx4g3KUDtbG70tRDPkuzORMRsL4YHcyT6f9n4F
         bem+YCQTSErfa+za9KCBCEsVvGL6U9z3FA6NUQKuf+0FO7mJG0Z7ffcdF0gFULlFj119
         1SmnuEsVMjtMEiCMw37lQYTGpNaNdztb0pAvoSMMfxjMx1mVq8A2yKb9n0XL8eov7a0o
         yTUw==
X-Gm-Message-State: AOAM531E720QTBaH9mPr3SfYUfQojo/MzFA5J9IWwCZ6OcdnDWXUclog
        c1oGnUSG0fpRna8Vju06l8H8IULduHM=
X-Google-Smtp-Source: ABdhPJx0vUD9wXWNiHBuhE3xZRs/Bn9POOrf3MLKqql65CQdykbRCYl6wwG+i2zFSXUBm0D3U9w36A==
X-Received: by 2002:ac2:5450:: with SMTP id d16mr1198966lfn.54.1589411652345;
        Wed, 13 May 2020 16:14:12 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id z23sm440605ljm.46.2020.05.13.16.14.09
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:14:10 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z22so1006331lfd.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 16:14:09 -0700 (PDT)
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr1201550lfo.142.1589411649429;
 Wed, 13 May 2020 16:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-1-arnd@arndb.de> <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com> <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic>
In-Reply-To: <20200513222038.GC6733@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:13:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
Message-ID: <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 3:20 PM Borislav Petkov <bp@suse.de> wrote:
>
> Linus, shout if you'd prefer only the last three commits there:
>
> 950a37078aa0 x86/build: Use $(CONFIG_SHELL)
> f670269a42bf x86: Fix early boot crash on gcc-10, next try
> 73da86741e7f x86/build: Check whether the compiler is sane

Do we really need that sanity check?

Are there known compilers that fail that check? Because honestly, that
sounds unlikely to me to begin with, but if it does happen then that
just means that the prevent_tail_call_optimization() thing is broken.

The check itself doesn't seem worth it. If your worry is that an empty
asm() can be optimized away, then don't use an empty asm!

In other words, the only reason for that check seems to be a worry
that simply isn't worth having.

In fact, I think the check is wrong anyway, since the main thing I can
see that would do a tailcall despite the empty asm is link-time
optimizations that that check doesn't even check for!

So everything I see there just screams "the check is bogus" to me. The
check doesn't work, and if it were to work it only means that the
prevent_tail_call_optimization() thing is too fragile.

Just put a full memory barrier in there, with an actual "mfence"
instruction or whatever, so that you know that the check is pointless,
and so that you know that a link-time optimizer can't turn the
call+return into a tailcall.

Don't send me the broken check.

                  Linus
