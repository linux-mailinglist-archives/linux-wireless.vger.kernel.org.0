Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F81D3592
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 17:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgENPue (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgENPud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 11:50:33 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD2AC061A0C;
        Thu, 14 May 2020 08:50:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id j2so3210576qtr.12;
        Thu, 14 May 2020 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CF7ZKxURTQoS3eBunm8YHC86iEwPWBFHZIqxXqgVG6E=;
        b=sCkEKquFt1u2MzkNsA6N/+LlFtJ5OmiaoTyx1J0oyhEc//gXyVmJIFG2FUmXqVQ9yL
         ujQBK8DBn3QL8QNSRo66yZlW6LGLhR2Lb0cwITWt9eOcjuXph8pWsCT6+5U7pUpK1/Xq
         An22fTS+g4OybLC3Jcf67HReJcMa5hxb18E2c2A/+8FvbBy5WFD4trMn5nkCCHeXqZtZ
         M/4pWLHHOTBI1IM91vuo7IJF4PBuIsKYIP+0p7K4itvlkUBY6KvARcFnlCKHo5BLGJCE
         NBOApuVSEE/Fv0wqaRjD4LKBbiOjKgCWWCEe69k6PgLwogDAaPwAJJjNaNEyzj3VcXl4
         8ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=CF7ZKxURTQoS3eBunm8YHC86iEwPWBFHZIqxXqgVG6E=;
        b=astb9NHNkzm/YX6pHev19Eo4nSop3vvCbmBBhffzAdUkbLsS+ZsvNSPrHhp5SmORW5
         AY5uQ1Tw4bn1ZBqkKjWkfG2NYl9RZginC0mPXZ7mEFuDaHxtLYz7naypWRlBVXAsWXNH
         ySIohdignA2YTrYmbU30D+g8ng7qpA+6PH17bXP6Fox/LJmljtgDtoj8L5+AvAX91dyp
         sIRtvsS5aO2c5H1/4Vhmgw+bGsiffjwyy2HdPyk3aAIVKEi/hPGA9xszDC6O5WkRCRWK
         k6zEzQUC20b8a6gIS31ya3kadFiOkwhmyzN0W35JlO2gwjzaE+WDg9F+GqpQH1Deyo3o
         UuUQ==
X-Gm-Message-State: AOAM53388RxNn8P0Y7OsSs9Jsq6N3vNF7rQ5En991DaNn2k4eaibjeZ8
        DWFqZjWjgKRmo5vMA0xJTJA=
X-Google-Smtp-Source: ABdhPJzGUelMbU9E5cvSADE9jYdPywHzq6svHabobIyAONSg5/xZ0WrUco59mbwgZ/9ietBO+zV0oQ==
X-Received: by 2002:ac8:188c:: with SMTP id s12mr5288182qtj.172.1589471431535;
        Thu, 14 May 2020 08:50:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d9sm2722040qtj.77.2020.05.14.08.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 08:50:30 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 14 May 2020 11:50:28 -0400
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
Message-ID: <20200514155028.GA2336285@rani.riverdale.lan>
References: <20200513222038.GC6733@zn.tnic>
 <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic>
 <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
 <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com>
 <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
 <CALCETrUYA60fWu+=MviKx0NmW+_ppsOcv-ShUXdbyM4EjyfzHQ@mail.gmail.com>
 <CAHk-=wgiGxRgJGS-zyer1C_x2MQUVo6iZn0=aJyuFTqJWk-mpA@mail.gmail.com>
 <20200514052234.GA1894416@rani.riverdale.lan>
 <CAK8P3a1Cfzu7L30bFP-Sf2_GbkN_10CCJsbefTXyfnGF16uHMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1Cfzu7L30bFP-Sf2_GbkN_10CCJsbefTXyfnGF16uHMA@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 14, 2020 at 10:40:44AM +0200, Arnd Bergmann wrote:
> On Thu, May 14, 2020 at 7:22 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > On Wed, May 13, 2020 at 09:52:07PM -0700, Linus Torvalds wrote:
> > > On Wed, May 13, 2020, 20:50 Andy Lutomirski <luto@amacapital.net> wrote:
> > The gcc docs [1,2] at least don't inspire much confidence that this will
> > continue working with plain asm("") though:
> >
> > "Note that GCC’s optimizers can move asm statements relative to other
> > code, including across jumps."
> > ...
> > "Note that the compiler can move even volatile asm instructions relative
> > to other code, including across jump instructions."
> >
> > Even if we don't include an instruction in it I think it should at least
> > have a memory clobber, to stop the compiler from deciding that it can be
> > moved before the call so it can do the tail-call optimization.
> 
> I think LTO would still be able to notice that cpu_startup_entry() can
> be annotated __attribute__((noreturn)) and optimize the callers
> accordingly, which in turn would allow a tail call again after dead code
> elimination.
> 
>      Arnd

Yes, with LTO the only solution is to actually compile the caller
without stack checking I think.  Although at present gcc actually
doesn't tail-call optimize calls to noreturn functions that could easily
change.
