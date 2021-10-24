Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074AC4388BD
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 13:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhJXLzi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 07:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhJXLzh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 07:55:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B70C061764
        for <linux-wireless@vger.kernel.org>; Sun, 24 Oct 2021 04:53:16 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 65so2388513ljf.9
        for <linux-wireless@vger.kernel.org>; Sun, 24 Oct 2021 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+PvmwGxCXpoCCdWrbtXlK0A0l3eOFxkfLJ+L9yhaEI=;
        b=QILMcs3ZRk5jg4zC0IwT10N41GWU0vmTLC1B0CFu1+upzhRq0AKoPbWkRe7/AS718V
         vaZiF4gCTSQFcdANjAP9Y1M20h5sF9lu6UzevpNYLsXj2jXUHtTcEkczqMh0Ua9CKVYW
         S8B/3PxkapoQrcMfhazQtAthBrf2wvBzrr22JBs5cANi2R5kRjYuKDkPzd3XrwfNzal4
         YTDNKiuev31jFUcYih7rybd5s6g5Zm3ihw2FcYWFdYIRxINeNNUDbf2iKIlz+wLCuHSw
         MaiIGjDNRCjxALl+Jf5wniJrN8mk2sOqTnsUORb/CuPJk8E6WUxgezavqFUa2PmXvmr6
         aYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+PvmwGxCXpoCCdWrbtXlK0A0l3eOFxkfLJ+L9yhaEI=;
        b=dAOMA27Zke2oH/4qGSgBKgYMTxUhh9B/zgMgIDPMpKHTOl34MGuadqWTqOpIu8GGSW
         XDQLmETzHx1KbK92YSVUjxbpomjIsH315cwq4bkXO3mqAybJrkJ0sQiblUuUDyUlWueM
         Dn4KjqF5xlEEir5WdGS4iqfLTq38pFl7N08IHA/0SM0u8lVfkoyccWJjKMmDtfNWiARf
         BofoowbUI3asH8JfZGEWHso8aqbtID6AyCUsATedoMTztV0nPvXw6JiVTZcotEqZOOt+
         STCykoQV828V1devfC+lM/EFuzRp6Mnht2Oo1FqqbulnhDvJRdR16YdQIyw6WbPxaN03
         nRgw==
X-Gm-Message-State: AOAM532VSUt+bz9QR5e9F12Je/Ett+GhBJu0oE+9OvLgLOLZG3kS4QXM
        68Jk+YW3v/M2DMxD60jC9Q0WoiASy9QiVbwBG9M=
X-Google-Smtp-Source: ABdhPJyLZ55k32GenJ9hs8/EmQzPaO131303rybosvc7edR8ba+hk7Tiv0edwSuYu7M3QqbfWDpTkmF+8xS/yngvNQE=
X-Received: by 2002:a2e:8948:: with SMTP id b8mr12281271ljk.499.1635076394991;
 Sun, 24 Oct 2021 04:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20211018235021.1279697-1-kuba@kernel.org> <20211018235021.1279697-10-kuba@kernel.org>
In-Reply-To: <20211018235021.1279697-10-kuba@kernel.org>
From:   Stanislav Yakovlev <stas.yakovlev@gmail.com>
Date:   Sun, 24 Oct 2021 15:53:10 +0400
Message-ID: <CA++WF2NS9xwE3z=nZo29zVBSgy9A20zmSb9kdtu3gXLaXGmftQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] wireless: ipw2200: prepare for const netdev->dev_addr
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 19 Oct 2021 at 03:50, Jakub Kicinski <kuba@kernel.org> wrote:
>
> netdev->dev_addr will be come const soon, constify the argument
> to command send to avoid compiler warnings.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: stas.yakovlev@gmail.com
> CC: kvalo@codeaurora.org
> CC: linux-wireless@vger.kernel.org
> ---
>  drivers/net/wireless/intel/ipw2x00/ipw2200.c | 6 +++---
>  drivers/net/wireless/intel/ipw2x00/ipw2200.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

Looks fine, thanks!

Stanislav.
