Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32AA1D2143
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2020 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgEMVlg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 May 2020 17:41:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:35854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbgEMVlf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 May 2020 17:41:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B469DAD03;
        Wed, 13 May 2020 21:41:36 +0000 (UTC)
Date:   Wed, 13 May 2020 23:41:28 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
Message-ID: <20200513214128.GB6733@zn.tnic>
References: <20200509120707.188595-1-arnd@arndb.de>
 <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, May 13, 2020 at 11:28:09PM +0200, Arnd Bergmann wrote:
> I see the patch in linux-next but not in mainline. I suppose we want
> it in v5.7 and backported to stable kernels so they can boot when
> built with gcc-10?

It is queued for 5.8. For a good reason, if you read the whole thread
Arvind pointed you to.

Lemme guess: gcc10 got released in the meantime (hohumm, website says
so) and so we probably should expedite this and send it to Linus now...?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
