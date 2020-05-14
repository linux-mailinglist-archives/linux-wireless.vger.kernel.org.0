Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23DB1D237A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 02:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbgENALn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 20:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732847AbgENALm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 20:11:42 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E045FC061A0C
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 17:11:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g1so1521328ljk.7
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 17:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utoJ2tKHLEz+lZ3hja/CgFMrWscoXl/r2VYjQKIyAGQ=;
        b=dgAGAPUhoFn+CuYLX3qhe1jMrseuW5lWoLa9YJnJqxEirnWvTEs0V9fdT4wR2Pbuav
         ksHfg5B1xR6nbSC/FbwhfAwAEkiYvr/0yCXzPdNE2tC1kmuWjl2FDCJU8eshKLGL7qug
         7hQYoTeBsfOX8bFMOOk/iDCziz5PVRMkoOVPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utoJ2tKHLEz+lZ3hja/CgFMrWscoXl/r2VYjQKIyAGQ=;
        b=WMoNs6fX8/b74fdYSiHuWGF7cV1gmpDK5OXP3uLKVe0LkjOS7pzq9ETO6qWOrqeAUS
         jD9Pqr7qFvpcnSR+AWw64TbngRe3ptJcJ7lOjx3saB7s5ZnCRGIdX8drSL08FOjmaTxy
         z5ymeEGrZfXtSJfBzb6Yf+grBoy/w8Q0lf6Q3XU/LX+sEGLkgYlYGPdiyvwRHqceNFdv
         rwc4eSFgy2ZHVhWMGQXg2tyj8JIx5MHx6zCi1HEnsT67SBYw2JaWGhsBADM23cEmtjMs
         RQEceA5DWp6vCKSCb6D2QHuf2gyGyFPT/GX01+Z7fS3tgGKGqly4dFEgFifdr2Taqg4Q
         m2Jw==
X-Gm-Message-State: AOAM531JReJ7KxKWE/W5AZjQCpVH8MrGU6d6H7rZnYyp9e7P2WJjAIXh
        +Lj4qO9bXZU1lrHwlwAQtWJmoURBl/E=
X-Google-Smtp-Source: ABdhPJwM+rCaDv8YLR5XEiUMWnLJ8kaqRzZfpfKNqYa6Sep8xnRCETzN/1wJ02JVlmVyN2EYLkdTOA==
X-Received: by 2002:a2e:97d3:: with SMTP id m19mr916123ljj.136.1589415099221;
        Wed, 13 May 2020 17:11:39 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id w7sm635828lfe.28.2020.05.13.17.11.37
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 17:11:38 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id u15so1565111ljd.3
        for <linux-wireless@vger.kernel.org>; Wed, 13 May 2020 17:11:37 -0700 (PDT)
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr879037ljp.209.1589415097255;
 Wed, 13 May 2020 17:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-2-arnd@arndb.de> <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com> <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan> <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic> <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic>
In-Reply-To: <20200513233616.GD6733@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 17:11:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
Message-ID: <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
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

On Wed, May 13, 2020 at 4:36 PM Borislav Petkov <bp@suse.de> wrote:
>
>
> Looking at them, they do have an mb() too so how about this then
> instead?
>
> #define prevent_tail_call_optimization()        mb()

Yeah, I think a full mb() is likely safe, because that's pretty much
always going to be a real instruction with real semantics, and no
amount of link-time optimizations can move it around a call
instruction.

I could imagine some completely UP in-order CPU that doesn't need to
serialize with anything at all, and even "mb()" might be empty.  I
think you can compile old ARM kernels for that. But realistically I
think we can ignore them at least for now - I'm not sure the link-time
optimization will even do things like that tailcall conversion, and
I'm not convinced that old pre-ARMv7 systems will be relevant by the
time (if) it ever does.

                   Linus
