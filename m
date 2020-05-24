Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D5E1DFFA6
	for <lists+linux-wireless@lfdr.de>; Sun, 24 May 2020 17:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgEXPHg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 May 2020 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgEXPHg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 May 2020 11:07:36 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC71C061A0E
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 08:07:36 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id v26so8768100vsa.1
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2020 08:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLfigoBgfX3pLZL6y4dD42gbF99ATRwuAxvLuNBjSFU=;
        b=U5+JNR0GRkFGA6NVy/gem6i56WYRVFTLzoNPTRwxZiyiEytFAOWuTM6vLvzfrHzgSp
         KFMNeJ4QBCQE3TODbw+GcwWAxHFOphpn+ofq2u0bLaFMWGhZi1QcR1P9xzTtXMz2wejU
         gmvhtA23rL8XFyd5vFZeY5Fzf4C5jdn3jDlLRQwoBZrF9d694vr/KI/bY9I/DHC/7vMh
         iq49BXQdPGx70Ojyj0lsnVQwE8oF/dJihHPHQdMQaTqtMP6W7iJLEVWak6zYL8JLID2M
         q+EA0wdfDuxiRBtSgeAY7OewBJtL3BqG/Gm1F7twpdJW1NlPnGJDUaGZRh7sz027Xd9l
         9lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLfigoBgfX3pLZL6y4dD42gbF99ATRwuAxvLuNBjSFU=;
        b=eo3Uov8fuEWZ0pKNZkdOCKyhBhYxLKlsevmRbJB0w39L0RKZFND5GFlvrqZ8jF8m4f
         2ZwPFYO/yVR/uDDKTdSyNmtrBC7iGBlXRAd7Aynhrk4jLJAZYmflCf9Yig+6x1i4E4/H
         FJA1m0o9G25XWkeYNDTacR+80mcq87HYjA+H+2zk2ZV7hIIDmdmh7h5o8Mw8VG0TWDzH
         z6vsrTMo42M+heCc2pGmbd1TYZVPm/znQ4N58Gcf39PnYq9RZ9p1E7CEqN5CM4x2LAFb
         aYowAAUZpdcF7AmXiS3tkhXPVOyAgtyOKUopgmXdgMOHiHPYzEhoCc6FTjCXpsjDWQmf
         UO9Q==
X-Gm-Message-State: AOAM5305363k2TbXQ3qHsUFSH28Yie2h3odHryfAPg352cjIeZ68fVjG
        Ug4MSmMNV7q0l4+epX9uOxN4MKSPQKxGLA4NYzbY3W1OKDfv
X-Google-Smtp-Source: ABdhPJyOjJx6FIUMBQbl8c1jRMySZsB1ALPeh8/z75vicEvPv6zbF4lw0PagksJ6yjkq9/zEzc9I1HNyof6j8fsPQ5Q=
X-Received: by 2002:a67:6dc7:: with SMTP id i190mr15337788vsc.75.1590332855606;
 Sun, 24 May 2020 08:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200524094730.2684-1-rsalvaterra@gmail.com> <20200524111751.GA914918@wp.pl>
In-Reply-To: <20200524111751.GA914918@wp.pl>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Sun, 24 May 2020 16:07:23 +0100
Message-ID: <CALjTZvbHbMEWTmZk4Li5ZNAETdVd3Q_kHUS6KQw+WDS6ayE9vA@mail.gmail.com>
Subject: Re: [RFC PATCH] rt2800lib: unconditionally enable MFP
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     kvalo@codeaurora.org, Larry.Finger@lwfinger.net,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Stanislaw,

On Sun, 24 May 2020 at 12:18, Stanislaw Gruszka <stf_xl@wp.pl> wrote:
>
> AFICT more work need to be done to support MFP by HW encryption properly
> on rt2x00. See this message and whole thread:
> https://lore.kernel.org/linux-wireless/977a3cf4-3ec5-4aaa-b3d4-eea2e8593652@nbd.name/
>
> Stanislaw

This RT2790 has been working just fine with my patch for hours. No
hangs at all. What additional bad behaviour should I expect?

Thanks,
Rui
