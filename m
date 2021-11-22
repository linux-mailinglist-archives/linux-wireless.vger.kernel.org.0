Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C893C458DE8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Nov 2021 12:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhKVL6C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Nov 2021 06:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbhKVL6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Nov 2021 06:58:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CA4C061574
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 03:54:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id h63so15033929pgc.12
        for <linux-wireless@vger.kernel.org>; Mon, 22 Nov 2021 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a8PQ6tQbD9uDoxtMHNP7ubZbWlAWInktUNCNBX9iM1w=;
        b=aIPAH7oRESO8Y8mhOvv+k+0O5dn06XOQhljvEj3CqkbDYfAhscFrffedOmefe0d7kj
         3pUulI1FdFed2CpyOkjgnI0AfDcIw4nr10mM7c5WY2Uf1DPv4mxLmLHk15Au9rSEH17k
         HXM0ReyHxqIC2tZomSFULVBnEMvCgkbHKGZLs5/5iZI7x1t49FVZebGUXsSjtEBaq1ao
         ORBQBDXFb+tvOHIWsDCG8k7pRfGonpp1NHPOEm6n8iyG6fHy/z4sX+XjvP4jdkvJNAyE
         TUiMu2eLXB5AQZz0IbpOvwFPEWA2s9WEtNwi8jtQeSsQRAOWjdlTyXxTKdHTBYHKxr4l
         NX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a8PQ6tQbD9uDoxtMHNP7ubZbWlAWInktUNCNBX9iM1w=;
        b=LHvcz9W+CgHDmQFCD/DORjrRNn2iDJK2Br/8OJkm1RNC9N8cGPcxzD4IUmwoH7ZMEd
         B8b6f211tR/CYNsyIp9/WIRkKjQt7MkCdvipOONtY3iv18DBuv4a9PnQzaiiLAS7koTE
         N4Ij2on1XCPxLEsuDAZDUAIg8tO//WG/p/p+Rzlk+YjZFJ4shpQNqlRQHhBnXeQN9k6d
         u72Dt1zFGsW2IQxDhcmzXVWlA6XCvuumZZzoCzen+1F2beqfIa8l4GQfo9hcFNWwTbK9
         kUZjiPqebMCMjx1WpVyTKjpFg1qvF4z/RQI2KwdX/S7uXrfBJnrZGDGShJusOFkBOt8B
         WMKg==
X-Gm-Message-State: AOAM532deEPAeCmO0mzNRKpKbBhwf52uZDf0uR0944MEmVkN7uE+xkxD
        /xdgCGJ0TGQautbKnh7xzfEmtU/Hmq0IJjJzSx4nKg==
X-Google-Smtp-Source: ABdhPJz0ixKOqrK1U2494ZGX3xcWnJVvARo82NTv51Rn160ZGwzastXrQdvkaGmy8TmYb+216pVDVeGhRtOAiG8oLCA=
X-Received: by 2002:a63:2542:: with SMTP id l63mr5733720pgl.431.1637582095041;
 Mon, 22 Nov 2021 03:54:55 -0800 (PST)
MIME-Version: 1.0
References: <1637571856-1191-1-git-send-email-loic.poulain@linaro.org> <8735nobgje.fsf@codeaurora.org>
In-Reply-To: <8735nobgje.fsf@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Mon, 22 Nov 2021 13:05:30 +0100
Message-ID: <CAMZdPi9xWdJU_-k9mJxTkeyctsEmNCuzvBpdR-FMg=onEim+9w@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: Configure keep-alive packet on suspend
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Mon, 22 Nov 2021 at 12:01, Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Loic Poulain <loic.poulain@linaro.org> writes:
>
> > When system enter suspend, there is no more wireless traffic, and
> > if there is no incoming data, most of the AP kick-out the client
> > station after few minutes because of inactivity.
> >
> > The usual way to prevent this is to submit a Null function frame
> > periodically as a keep-alive. This is supported by brcm controllers
> > and can be configured via the mkeep_alive IOVAR.
>
> This is with brcmfmac in client mode, right?

Right, it's in client mode.

> Wouldn't it make more sense to disconnect entirely during suspend?
> Nobody is processing the data packets anyway during suspend.

Disconnect is performed automatically when wowlan is not enabled,
otherwise we may want to wake-up on events (disconnect,
4-way-handshake) or data packets (magic, unicast, etc...). Some
devices use suspend aggressively such as Android in which the network
link is expected to be maintained.

Regards,
Loic
