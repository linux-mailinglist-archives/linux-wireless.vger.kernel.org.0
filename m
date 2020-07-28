Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4198231489
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jul 2020 23:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgG1VXl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jul 2020 17:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgG1VXl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jul 2020 17:23:41 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31891C061794
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 14:23:41 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z17so2415061ill.6
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 14:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qbrYLgZbxKVnooJBhqmD5CD+Q10RN0mhpS1Kgqx4Sog=;
        b=a1fMlXncL3dU4Bc1by3SNT6F4IqDUIPfirwX8mIdgoKbeACCVR8g89eTzr24+kgm7E
         qOVgaBxlcRlqiBHOl4ehZkQG5gzjjUnKK7J9+TRP1cndUTm8ZejnIqjkjxKmiImUdbvE
         f/ILD5hRMo1oThxvoRdDQ9Rsy2vc06F4DEqkLa1cWrCJV5ppAoK2PGg0fbc0U7tUoYs2
         idgkFi8QUsJkb2NClHKMShfTx22p2JJBxXeY9YTZ/q0Vi4vHxLPkdLVJGOYzIKJWUtVn
         cmaSPlwrW36S14upKg220DW+FsNUP/zD31dqVqkIlS/V2hH7cAIOpnIir16i25WquhOk
         Oe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qbrYLgZbxKVnooJBhqmD5CD+Q10RN0mhpS1Kgqx4Sog=;
        b=Cknmrsyk7eMvOrOQYi7zPHkzGRNPm3tTaE5TPjZ8gwVp8fdy5YZXUHDoT7ueUzL6Qa
         AlXoMJ++c9QUaJ773Sw/AgRrELc3s9mFLxbsu0d0LFLJD1aTQ0D7zn5lM1USv6z72w/S
         Rv9EK8P8KBlVSkZ1pxvfpi9YWkSDkWyp7p5+QX8opOsZZ2bAUb+0ewCwuuD+7TmYq28R
         uZQFV8ehOyf/O0QwUqmpTmwTUYQE0PNeCU1K5if8gZDClsQqGWqPKqJilDjTwog+kbmW
         2aPWNXEt1NrW1JVQTGwYfTUjN4568CWtiMHY+GP6BEMikU0GHiGJ3YAD98y6Auxnv9O1
         ZEng==
X-Gm-Message-State: AOAM533ePJCSAGWbXZyYonP3hOaLexvWBfJG1yNz50171YfUclkDt56O
        mNe996q9uZnxvBZ4jltXvnGsKcaqSDjzxGQUQx504FxU
X-Google-Smtp-Source: ABdhPJwFOY82YV0+F7TNBtd6wu6ORa9xytsI+BB1ZPjt+sHa5C/5JIyA8qG6PA2bsWUGJZktTf99zJWKtQZJuhBjzGY=
X-Received: by 2002:a92:7f04:: with SMTP id a4mr10115166ild.10.1595971420633;
 Tue, 28 Jul 2020 14:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWoycCvAAs5H0sigHTB+GGhX5NRVonYqKg7BRLB97dGkA@mail.gmail.com>
 <87mu3magfp.fsf@tynnyri.adurom.net> <CA+icZUUY_cSbhT8piRED_RBw4rjrMesVoNgj-sCLnGU0zoAzWA@mail.gmail.com>
In-Reply-To: <CA+icZUUY_cSbhT8piRED_RBw4rjrMesVoNgj-sCLnGU0zoAzWA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 28 Jul 2020 23:23:29 +0200
Message-ID: <CA+icZUVCPxjp3zQg1rgx+33v1vjZCep6uEg4wkmq3MdY4a9j5w@mail.gmail.com>
Subject: Re: iwlwifi: Direct firmware load for iwl-debug-yoyo.bin failed with
 error -2
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Luca Coelho <luciano.coelho@intel.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 28, 2020 at 3:13 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Jul 26, 2020 at 9:23 AM Kalle Valo <kvalo@codeaurora.org> wrote:
> >
> > Sedat Dilek <sedat.dilek@gmail.com> writes:
> >
> > > Hi,
> > >
> > > I am seeing this failed/error message for a long time:
> > >
> > > [Sat Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
> > > for iwl-debug-yoyo.bin failed with error -2
> > >
> > > So, I started to look for the file "iwl-debug-yoyo.bin" in [1], but failed.
> > > AFAICS this is a file for debugging purposes?
> > >
> > > Why do I see such a message as an end-user w/o iwlwifi-debugging enabled?
> > > For some end-users I can imagine this looks scary and they will look
> > > into their cupboards and below their beds but will not find any
> > > monsters.
> > >
> > > I found a rename from an ini file to bin here:
> > > commit 8d9e982bf9bf ("iwlwifi: dbg_ini: rename external debug
> > > configuration file")
> > >
> > > Is "iwl-debug-yoyo.bin" a binary or as before an ini (text) file I
> > > have to configure somehow.
> > >
> > > Does this need to be guarded by some "ifdef CONFIG_IWLWIFI_DEBUG" in
> > > "drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c"?
> > >
> > > Or does drivers/net/wireless/intel/iwlwifi/Makefile needs some tuning
> > > - as said I have no iwlwifi debugging enabled via Kconfig?
> > > ...
> > > iwlwifi-objs            += iwl-dbg-tlv.o
> > >
> > > Please enlighten me/us?
> > >
> > > Thanks.
> > >
> > > Regards,
> > > - Sedat -
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/
> > > [2] https://git.kernel.org/linus/e8d9e982bf9bf0e6f99099f1f09a37563b2b95b5
> > >
> > >>From my dmesg-output:
> > >
> > > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: can't disable ASPM; OS
> > > doesn't have ASPM control
> > > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: loaded firmware
> > > version 18.168.6.1 6000g2b-6.ucode op_mode iwldvm
> > > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
> > > for iwl-debug-yoyo.bin failed with error -2
> >
> > There's an RFC patch about this:
> >
> > https://patchwork.kernel.org/patch/11625759/
> >
> > I think that should be applied. Intel folks, should I take that directly
> > to wireless-drivers-next?
> >
>
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # Linux v5.8-rc7; GCC
> v10.2 + GNU/ld v2.35
>

Re-tested with LLVM/Clang/LLD v11.0.0-rc1.

- Sedat -
