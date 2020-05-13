Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197D61D2326
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 01:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbgEMXgd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 19:36:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:36108 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732638AbgEMXgc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 19:36:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1BD01AB64;
        Wed, 13 May 2020 23:36:32 +0000 (UTC)
Date:   Thu, 14 May 2020 01:36:16 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
Message-ID: <20200513233616.GD6733@zn.tnic>
References: <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic>
 <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic>
 <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 04:13:53PM -0700, Linus Torvalds wrote:
> The check itself doesn't seem worth it. If your worry is that an empty
> asm() can be optimized away, then don't use an empty asm!

gcc guys said we should use that since the first attempt using

__attribute__((optimize("-fno-stack-protector")))

didn't work because, well, that attribute turned out to be "not suitable in
production code". :)

Full thread here:

https://lore.kernel.org/lkml/20200314164451.346497-1-slyfox@gentoo.org/

> In other words, the only reason for that check seems to be a worry
> that simply isn't worth having.

Yes, that was me asking for a way to check whether any future gccs would
violate that. But if they'd do that, they would break a lot of code
depending on it.

> In fact, I think the check is wrong anyway, since the main thing I can
> see that would do a tailcall despite the empty asm is link-time
> optimizations that that check doesn't even check for!
> 
> So everything I see there just screams "the check is bogus" to me. The
> check doesn't work, and if it were to work it only means that the
> prevent_tail_call_optimization() thing is too fragile.

So I did test it trivially by removing the asm("") and then it would
tailcall optimize. But we didn't think about LTO so hm, that would
probably break it.

> Just put a full memory barrier in there, with an actual "mfence"
> instruction or whatever, so that you know that the check is pointless,
> and so that you know that a link-time optimizer can't turn the
> call+return into a tailcall.

Right, the intention here was to have it arch-agnostic in
include/linux/compiler.h because powerpc might need it too soon:

arch/powerpc/kernel/smp.c:1296: boot_init_stack_canary();

Looking at them, they do have an mb() too so how about this then
instead?

#define prevent_tail_call_optimization()	mb()

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
