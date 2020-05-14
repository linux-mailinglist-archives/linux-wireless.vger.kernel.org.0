Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3551D26A2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 07:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgENFWi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 01:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENFWi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 01:22:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBEFC061A0C;
        Wed, 13 May 2020 22:22:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z80so1917923qka.0;
        Wed, 13 May 2020 22:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=z5uk4NHfluyoyKinmPhsA3PHI6OfQ+bSBmaBzpScwmw=;
        b=ALjXcdekUDYnKCo9mbwP5NFpsZBLyExdioIUHbsWFR8MvK+SCWzM66peJ68x5i+6NS
         TOOmRrj2tY83DX/ZtNXk+3bhZU5HSUuOQ0esn6RurOlg0teBADPC7yOfburIc4urfb6n
         7n4JUkBeyLzl5VU5TiQ+C9scW2ttMORwDnmtP2+RkkBZhynOF49DvkJt2mCxSuY656Hz
         G4yxgAxZOpC1i11vUkWVYXkRDMqkFtrbD3tDUp/5DopauJdPN7PH2VHfnB654FNKNREa
         HWij1DcReST74ph02PNPwYOVxAoWSQckdWt159yP8xOOeQ8GdV3mDIHqeqpxDGM/K/yw
         TJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=z5uk4NHfluyoyKinmPhsA3PHI6OfQ+bSBmaBzpScwmw=;
        b=m2IyCz5IKq4XHaRFM2UK6Mikp0a4IQjMX6vEX+bI7Z7x3876oeIu/R4Pa4RPyfkzP8
         6xqV2yktp1gXeDpc+Ye3eyyEhDU43xu5iy8/GM23hKCUufMQzvv3d0rGVXh8BA5gvBGq
         POsf0H8D/9fqOmIpmFIqJWUjqPEDNmbz4vF0N4FgsGkGWGrbCkyaJcZhJNX+hOdRSxX4
         SgDwszU84DGR9VGd9R2R99QYhZagBeerWWbav9ISBAX0AX4dApzjZA6XhuJXJQpa8cHd
         mxR0qwHgXzRCe+Ohgptv9K9/fwSbEqxKT8dCG7vAhZHUnYpB+xgd8NseiKAPn3kgv7j4
         GfIQ==
X-Gm-Message-State: AOAM531ObIRjK8BM4RyDZBt4hqlfbq8DfkpE3VFOSLmoSYB7gQMPmZlM
        K5Qa8aLgcu+KlJg+AXOVPmUPGqnfNqY=
X-Google-Smtp-Source: ABdhPJx3cdcn2+IV1zWsDjnGUc1Ywq5IEr5xgbyPAyNB5MNO81FbwGCmd9L8GBv5+A/27y4N235s7g==
X-Received: by 2002:ae9:e858:: with SMTP id a85mr3191511qkg.478.1589433756973;
        Wed, 13 May 2020 22:22:36 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x19sm1813380qkb.136.2020.05.13.22.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 22:22:36 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 14 May 2020 01:22:34 -0400
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
Message-ID: <20200514052234.GA1894416@rani.riverdale.lan>
References: <20200513214128.GB6733@zn.tnic>
 <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic>
 <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic>
 <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
 <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
 <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
 <CALCETrUYA60fWu+=MviKx0NmW+_ppsOcv-ShUXdbyM4EjyfzHQ@mail.gmail.com>
 <CAHk-=wgiGxRgJGS-zyer1C_x2MQUVo6iZn0=aJyuFTqJWk-mpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgiGxRgJGS-zyer1C_x2MQUVo6iZn0=aJyuFTqJWk-mpA@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 09:52:07PM -0700, Linus Torvalds wrote:
> On Wed, May 13, 2020, 20:50 Andy Lutomirski <luto@amacapital.net> wrote:
> 
> >
> > LTO isn’t a linker taking regular .o files full of regular machine
> > code and optimizing it. That’s nuts.
> >
> 
> Yeah, you're right. I wear originally thinking just an optimizing
> assembler, and then started thinking about link-time optimizations in that
> sense, but it was wrong to then go from that to LTO which has a very
> specific meaning.
> 
> We do have assemblers that do some optimizations, but they tend to all be
> at the single instruction level (eg things like turning "add $128" into
> "sub $-128" which fits in a byte constant).
> 
>     Linus
> 
> >

The gcc docs [1,2] at least don't inspire much confidence that this will
continue working with plain asm("") though:

"Note that GCC’s optimizers can move asm statements relative to other
code, including across jumps."
...
"Note that the compiler can move even volatile asm instructions relative
to other code, including across jump instructions."

Even if we don't include an instruction in it I think it should at least
have a memory clobber, to stop the compiler from deciding that it can be
moved before the call so it can do the tail-call optimization.

[1] https://gcc.gnu.org/onlinedocs/gcc/Basic-Asm.html#Basic-Asm
[2] https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
