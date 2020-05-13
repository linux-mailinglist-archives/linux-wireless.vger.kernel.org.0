Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8164A1D2263
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 00:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbgEMWvM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 18:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731276AbgEMWvL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 18:51:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA20C061A0C;
        Wed, 13 May 2020 15:51:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id r8so1295464qtm.11;
        Wed, 13 May 2020 15:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TtpVlZ/2RH6oo7EEPwbarNNxdV4bkajp7+H3tQWdqBo=;
        b=j6EbuTzcVqeARseNXu0wZHmmYoYVIYoakEBD1XUwFYcWzb7aMwG1QW85Zo+iF/RNdt
         i9BWaOe2B7+bq4EYo4lMkkK4pCrfhdWFbKEeCZzA538z/s7E+cHXSvx1cPiqDEHcOzpv
         cwHld95mBK8YJwVBh+WhIdMzx/x/sLShi+iSfYZ8G7QBG/IRD/3GP4NhLHIyFme22O6j
         yEithcIFUfYA/jW8kyK1sSBJ8J1oE9esDoPtP14/2Bjgn92+LjehMRmMXXZaDiXl/vpa
         Zt3aGLMXfgtHJXDRAQ13KbdyQUd9/dJOmH1M8rPAFK3daMxlgofZW9/6Gwk4BELeDZX9
         A0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=TtpVlZ/2RH6oo7EEPwbarNNxdV4bkajp7+H3tQWdqBo=;
        b=cjgMN5qlT12uxLsdo8MwjLu98aPN4E2wOWFX+NRVuqhHrYoTJKVQY5/gzQDkxywCuU
         NqMnHlLBwZ0vpjChH+UXWii7UulUqqqDi6VzzG1F5++9z7SM56VQXXql8owVwmyGoSCg
         5qZkf1GXHzk8FyHri8fK1qBHg5Eb8It1gBjUNKEGssiqerPIUBLVpfDLJ7RYT5b4HNxn
         LYwEaOqMg0LQxPv98QL/Dk5fDHDqLlqdT0cgqQUADe3MUSQ2OrcjQlhV2M/z9G/Cf+6i
         3HEBwkbNT6Vl4UbsRto31uahWdQGvoYQ0Gvm5K/CSi2+MBmkD3DUzpha4qH+cRKNDeeJ
         WDqA==
X-Gm-Message-State: AOAM532xhhVYGmiYFrshcndplz8J/beh6GvY7DCdcwQJxfAix/cp0BNI
        IflBe6uNYSnf7xapuzT4zIo=
X-Google-Smtp-Source: ABdhPJyI6le8yBvjLmiPUUMO054CX8HvmVjFsJlzKqTmIJV0+LObQZjNOXq/FecJomr3D0LJfQ/PGQ==
X-Received: by 2002:aed:3783:: with SMTP id j3mr1506685qtb.306.1589410270502;
        Wed, 13 May 2020 15:51:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 132sm1076909qkj.117.2020.05.13.15.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 15:51:09 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 13 May 2020 18:51:08 -0400
To:     Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
Message-ID: <20200513225108.GA2317231@rani.riverdale.lan>
References: <20200509120707.188595-1-arnd@arndb.de>
 <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic>
 <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200513222038.GC6733@zn.tnic>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 14, 2020 at 12:20:38AM +0200, Borislav Petkov wrote:
> On Wed, May 13, 2020 at 11:49:49PM +0200, Arnd Bergmann wrote:
> > Right, in particular since Linus started building with gcc-10 already and
> > would likely soon run into that problem if he hasn't already ;-)
> 
> Oh noo, we don't want Linus' kernel broken. ;-)
> 
> We will send him the fix this weekend.
> 
> Looking at that branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/build
> 
> I think we can send the whole thing even.
> 
> Linus, shout if you'd prefer only the last three commits there:
> 
> 950a37078aa0 x86/build: Use $(CONFIG_SHELL)
> f670269a42bf x86: Fix early boot crash on gcc-10, next try
> 73da86741e7f x86/build: Check whether the compiler is sane
> 
> but the other three from Masahiro are simple cleanups:
> 
> 675a59b7dec6 x86/boot/build: Add phony targets in arch/x86/boot/Makefile to PHONY
> 30ce434e44d7 x86/boot/build: Make 'make bzlilo' not depend on vmlinux or $(obj)/bzImage
> e3c7c1052271 x86/boot/build: Add cpustr.h to targets and remove clean-files
> 
> which should be ok to take now too AFAICT.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

I notice that doesn't add it to start_kernel (init/main.c). That's not
currently affected, but I think we should it add for consistency and
future-proofing, at least for 5.8?
