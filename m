Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C0C1D21E3
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgEMWUr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 18:20:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:44862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbgEMWUq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 18:20:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C74EAB64;
        Wed, 13 May 2020 22:20:47 +0000 (UTC)
Date:   Thu, 14 May 2020 00:20:38 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
Message-ID: <20200513222038.GC6733@zn.tnic>
References: <20200509120707.188595-1-arnd@arndb.de>
 <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic>
 <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 11:49:49PM +0200, Arnd Bergmann wrote:
> Right, in particular since Linus started building with gcc-10 already and
> would likely soon run into that problem if he hasn't already ;-)

Oh noo, we don't want Linus' kernel broken. ;-)

We will send him the fix this weekend.

Looking at that branch:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/build

I think we can send the whole thing even.

Linus, shout if you'd prefer only the last three commits there:

950a37078aa0 x86/build: Use $(CONFIG_SHELL)
f670269a42bf x86: Fix early boot crash on gcc-10, next try
73da86741e7f x86/build: Check whether the compiler is sane

but the other three from Masahiro are simple cleanups:

675a59b7dec6 x86/boot/build: Add phony targets in arch/x86/boot/Makefile to PHONY
30ce434e44d7 x86/boot/build: Make 'make bzlilo' not depend on vmlinux or $(obj)/bzImage
e3c7c1052271 x86/boot/build: Add cpustr.h to targets and remove clean-files

which should be ok to take now too AFAICT.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
