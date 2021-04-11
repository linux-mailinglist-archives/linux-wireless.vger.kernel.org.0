Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF7135B6D9
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 22:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbhDKUMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 16:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhDKUMa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 16:12:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118AC061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 13:12:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b9so10789610wrs.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DhAi88IoChwIhizMK/knwCvjQYO52YfxBiv5GwKIeQ=;
        b=PUzaegnovCBJxUmLT90K7W30zMd5e3vOKYKnSlcClaVq3HMrCre9E8GOUWB+HlvzrF
         udY3AgN9fuPqCsbRjiJO6ZymvPoF9okcrShwrdpoWtBDpFWQ//k3SBr6QmxxtgZXpNuv
         zQYhnK81AV1IgR8FtBMwwZrzRYDloSQpnsM6kl5EU6wm9v+Ptcy+XoIcpwVBI1WO2Qv7
         76jm5c+uOYcWEno7NKWHVhnyyuBuUFjnQWE2mceV+43uVN9oje8P5ow7h8LV7bkBxAvO
         f+muhbggv1Uu2hGaupoyBtMoqRNNz4nZcon91hrtB9pSnCZ89mFmF7FiZyaOnW4CKwt/
         1vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DhAi88IoChwIhizMK/knwCvjQYO52YfxBiv5GwKIeQ=;
        b=RAL7WDkJtvC7P73Loku1Bkx9jaW3yINuOjW2lfxPP/oi5JZTpaiDmVr+7UrnLtGvvK
         YOuX9h8imwBHl/tshWD0T4o3LxPu4oIL7yv1mr6Tj6oCaomTZ6oeiUwJgMvsXP1Nx6GS
         jEKZM8Wp+OwZ23xogBpzXEPTZ6lkgxzYMbgvFT4TMNXxd4Ir3asvRaEpmN+sSVwgkWmg
         zyTcmTUbDy9/okf9ugnXlOVyw6ThRBevrMwGDQgvQi4TE3cZVqPyH6sEI91vJVNMzGZ2
         IEDHwysk6q1L4tt8u5TmsA+aAUQUvuORl47ceAgOuM/LFqxBTNQxMQDKJw0D0NgHwvpM
         wXoA==
X-Gm-Message-State: AOAM530jMfCWYMOQL3iNX7Vz/+7qyiUnAFgvtbAbo9L9sY4mZG2Hs01f
        4OMhxukuO3olawYr+0XC7jLHASsfovCfl0Kp5wlzuw==
X-Google-Smtp-Source: ABdhPJwjGyyP4rEiAqyyypQdtnzqgblHitzoJO9MzUOB/fI0TTFpgKJTshd9fs7Tb9/+4pR0ffnQvbvt9URFypUKtvQ=
X-Received: by 2002:a5d:610f:: with SMTP id v15mr28281305wrt.236.1618171932032;
 Sun, 11 Apr 2021 13:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <40bb3a55-a872-414d-ed7f-6548beecd236@gmail.com>
In-Reply-To: <40bb3a55-a872-414d-ed7f-6548beecd236@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 11 Apr 2021 14:11:55 -0600
Message-ID: <CAJCQCtTxroboAeQgByCG0zfNK=Rda=2cOGW4i2_kqxu2Saqqsg@mail.gmail.com>
Subject: Re: iwlwifi: failed to load firmware chunk
To:     Friso Smit <fw.smit01@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Apr 11, 2021 at 2:24 AM Friso Smit <fw.smit01@gmail.com> wrote:
>
> Hi,
>
> After upgrading to linux 5.11.12.arch1-1 I suddenly had no wifi
> connection. I immediately tried downgrading again, but to no avail.

Did only kernel version change? 5.11.12 has one iwlwifi related commit:

commit 6159f947fb047fd8ecbfbcbcc86a8337e801bd10
    iwlwifi: pcie: don't disable interrupts for reg_lock


> trying to boot into windows didn't seem to help. The windows
> troubleshooter tried a reset of the wireless chip and that may have
> solved the issue. Currently it's working again (on linux
> 5.11.10.arch.1-1), but I'm hesitant to upgrade right now.
>
> I don't have a dmesg log unfortunatly, but journalctl provides the same
> error I saw in dmesg, namely that iwlwifi failed to load the firmware.
>
> journalctl output (from 5.11.10 weirdly enough):
> https://pastebin.com/yrqNgih0


-- 
Chris Murphy
