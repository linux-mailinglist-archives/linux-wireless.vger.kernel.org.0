Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5741D3361
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgENOqJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 10:46:09 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53068 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgENOqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 10:46:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589467565; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=X9eeOaMY30WtouQV4/0fc/7J6rSEn2W5kR2k0EBq61Y=; b=wwHJdn63Og7ASmehjzd2RYGIhv0IvJOxiVncD1Tv84Byjs7LVvorJ6i9LyDxGPe6w5XDRo6N
 7V64p3O6kq4f7jM5IaePaLsOmUZh+/fv4srAt28eJZZVe8xBVcSRmLH3BuuW0swqwVh7++V5
 0g2J9Q9oAvpsukd5BDM4/v8DS+4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd59a5.7fe0a526b378-smtp-out-n04;
 Thu, 14 May 2020 14:45:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38A42C44791; Thu, 14 May 2020 14:45:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E651C432C2;
        Thu, 14 May 2020 14:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E651C432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Matz <matz@suse.de>,
        Martin =?utf-8?Q?Li=C5=A1ka?= <mliska@suse.cz>,
        Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] x86: Fix early boot crash on gcc-10, third try
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
        <20200514132706.GB9266@zn.tnic>
Date:   Thu, 14 May 2020 17:45:50 +0300
In-Reply-To: <20200514132706.GB9266@zn.tnic> (Borislav Petkov's message of
        "Thu, 14 May 2020 15:27:06 +0200")
Message-ID: <87blmqr2w1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> Ok,
>
> here's the new version. Changes are:
>
> - It does mb() now (Linus).
> - I've added a call to prevent_tail_call_optimization() in init/main.c
>   because it does generate the stack canary there too. This is a
>   future-proof thing. (Arvind).
> - Dropped Reviewed-by tags.
> - Dropped compiler checking from the branch (Linus).
> - Added Cc:stable because gcc10 has released already, apparently.
>
> Testing with gcc10 passes after making sure that without it it would
> cause the tailcall optimization and fail stack check.
>
> Plan is to send it to Linus on the weekend so that it makes it into 5.7.

This fixed my boot issue, thanks!

Tested-by: Kalle Valo <kvalo@codeaurora.org>

[    0.000000] Linux version 5.7.0-rc4-wt-ath+ (gcc version 10.1.0 (GCC), GNU ld (GNU Binutils) 2.34) #11 SMP Thu May 14 17:28:35 EEST 2020

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
