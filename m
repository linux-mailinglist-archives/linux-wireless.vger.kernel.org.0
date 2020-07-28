Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142F3230B34
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jul 2020 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgG1NOB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jul 2020 09:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgG1NOA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jul 2020 09:14:00 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ADAC061794
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 06:14:00 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z17so988595ill.6
        for <linux-wireless@vger.kernel.org>; Tue, 28 Jul 2020 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9Z95bvBvlUZjClEwxbd+3yZePwIePP5r7+c9u78/i8M=;
        b=jMg0Uj+RQf02mekZbKsGukfoDu0ib4c/eGs/FKOa17WVzQwLdDiEN0YKzuP+tluPUu
         NKVdLqJbFsErsibgzAlIJwbIccch1L1Hpk5gs7ZdHClsSu+l3pPJZbGCJxAlBOrqMcyx
         yFgcWah0u5fwPfrYhki03KhfHuYUva2s98uL/0gPrLfeQrXiauEsF0JR5vw0x3/yLj2r
         HQxW9tYLw37/Xb2jmwUyciShz5b3Z/9TheImS7cgu1T2OlHTZylH7bO/vUqw56g7Ve+p
         sqEQUs4zkRGGxTO5blO6vjH5BQW9G/je47vEyZKRvxEAzO9yZjy4qvkf02xOFGAU//ZZ
         4e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9Z95bvBvlUZjClEwxbd+3yZePwIePP5r7+c9u78/i8M=;
        b=mFr+8bvGYn7xuDf3U0k9QGqcBROegscQq2ry8//EDth9WDxgtSPqJ4Sib4WUbXiSWB
         +Ps3Gwc86YEOVpLfJYfF4GwkkO+8zhrzM2T4Meqa+4EQ40hXNsjR44IiXLsGz83U4cp8
         pwyIh/hN42h6IZZocsEotAts2wQVKPXDvg+3FrnxIvXK4q7Pq/uDLxN/bvbp03t8hZS0
         KPlhJ29EzQ+2W/a7b1QWMQHz1nJG7KpMsnw52ddcrkyEw+pjKUizgCYZT24dJ6UKzMe2
         Hi2vjt+X14xfwH/HcZIbHSL8DSM/d/jwZ7zaSAtJz1pXxETbu3eFNfl5SiYs/Vn8FLcO
         XDeA==
X-Gm-Message-State: AOAM531zZBpgdRlYZETMtEdnOCZwGlnvKSwtmzAzQAeF79pjIFTiwzmH
        EN7vL+VfnlUfb1bCyluJFz95QXeIbMfSn3IbJchgmghPl3A=
X-Google-Smtp-Source: ABdhPJwHCdGoobo795wxmz9HJ/8zCGoZhfEHaYRd2xl9QClLPRaEfcSqMN6wvz/xPeqMy+s/SeQtOaX45JlhOM5tf2Q=
X-Received: by 2002:a92:bada:: with SMTP id t87mr22866230ill.112.1595942040063;
 Tue, 28 Jul 2020 06:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWoycCvAAs5H0sigHTB+GGhX5NRVonYqKg7BRLB97dGkA@mail.gmail.com>
 <87mu3magfp.fsf@tynnyri.adurom.net>
In-Reply-To: <87mu3magfp.fsf@tynnyri.adurom.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 28 Jul 2020 15:13:48 +0200
Message-ID: <CA+icZUUY_cSbhT8piRED_RBw4rjrMesVoNgj-sCLnGU0zoAzWA@mail.gmail.com>
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

On Sun, Jul 26, 2020 at 9:23 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Sedat Dilek <sedat.dilek@gmail.com> writes:
>
> > Hi,
> >
> > I am seeing this failed/error message for a long time:
> >
> > [Sat Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
> > for iwl-debug-yoyo.bin failed with error -2
> >
> > So, I started to look for the file "iwl-debug-yoyo.bin" in [1], but failed.
> > AFAICS this is a file for debugging purposes?
> >
> > Why do I see such a message as an end-user w/o iwlwifi-debugging enabled?
> > For some end-users I can imagine this looks scary and they will look
> > into their cupboards and below their beds but will not find any
> > monsters.
> >
> > I found a rename from an ini file to bin here:
> > commit 8d9e982bf9bf ("iwlwifi: dbg_ini: rename external debug
> > configuration file")
> >
> > Is "iwl-debug-yoyo.bin" a binary or as before an ini (text) file I
> > have to configure somehow.
> >
> > Does this need to be guarded by some "ifdef CONFIG_IWLWIFI_DEBUG" in
> > "drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c"?
> >
> > Or does drivers/net/wireless/intel/iwlwifi/Makefile needs some tuning
> > - as said I have no iwlwifi debugging enabled via Kconfig?
> > ...
> > iwlwifi-objs            += iwl-dbg-tlv.o
> >
> > Please enlighten me/us?
> >
> > Thanks.
> >
> > Regards,
> > - Sedat -
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git/
> > [2] https://git.kernel.org/linus/e8d9e982bf9bf0e6f99099f1f09a37563b2b95b5
> >
> >>From my dmesg-output:
> >
> > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: can't disable ASPM; OS
> > doesn't have ASPM control
> > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: loaded firmware
> > version 18.168.6.1 6000g2b-6.ucode op_mode iwldvm
> > [Sa Jul 25 13:03:28 2020] iwlwifi 0000:01:00.0: Direct firmware load
> > for iwl-debug-yoyo.bin failed with error -2
>
> There's an RFC patch about this:
>
> https://patchwork.kernel.org/patch/11625759/
>
> I think that should be applied. Intel folks, should I take that directly
> to wireless-drivers-next?
>

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # Linux v5.8-rc7; GCC
v10.2 + GNU/ld v2.35

- Sedat -
