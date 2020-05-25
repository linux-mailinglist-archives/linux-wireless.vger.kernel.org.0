Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC11E0FC0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbgEYNrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 09:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403812AbgEYNrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 09:47:02 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B3C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:47:02 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id d22so1221668vkf.12
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjzOgAOVX56mD5d7tTFKCX84W8Yl/BNswt+w4S5YJ7s=;
        b=DNtEKJtyB8uI6bwyCYLR97YPGXsGZcUZnvBpP2SC14bpuUMxTEiScwOiHnuBMlv4+H
         ClRpX1I38+aTFlF5lXgGOqDfKv+xEXxbA/GGwI52xQ8nd/lEHFZqVNMpTGCNwuUpOgH6
         vpLmw3zXGCKxACC9IsNhGVkuMcyoU/RS2RCLNsOZm+ch8/udee1gJ3lIuLEmpsKebg40
         OQeGTqL9zY/9pUx5oh9khamJaJxiPKIHs1VWvb21iNeO88JJLYQh6sI9PuuH8K3WzqZk
         0jsHarvkNEpFhG+gXev1iBY6GT/ICgDoEwCnXBZHaW6aIBJmYiITnO8+yeqzfJbUqF5o
         Zpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjzOgAOVX56mD5d7tTFKCX84W8Yl/BNswt+w4S5YJ7s=;
        b=HJWoavXJCBR6EMPbQFynznVYS9LAQ/ibZG5Q/6iSIrUIcsa9veW+cuthBEPsGB7qjY
         UAUyLaRLu1h4wAnpVs+ynn0BROjGW5p+geUiEMq+SvdlD2gXfnpH1mA2xRzHBeJpaVT3
         2uvqJhcnYe4j20HPujymlz7mmzo2mkNYuSQBfWafLlaQ/K1+cZD+L2wOgVaLJYxlNHSz
         hFyS50+o0WMFbB0mUS1hUlfL7oPeKEXkjs7Krw7rieXDtbiJ6cQfE9fvVkbvdnEJ+ZHe
         qbpnB0KSCUB7hgsVCczwsol601SNNhRK4UpFva6VSfs3QnSENnheXwWpZfdWHdPYgQ/y
         zr2w==
X-Gm-Message-State: AOAM530qg7c+8JZ3+A06L3lO9POzxOiQarKnVx2FVl01FRyya0icW2KG
        mTljSbHgT6ZEix6RNpqgoBRrHgb6BQ/qWK9YTw==
X-Google-Smtp-Source: ABdhPJyQema7n5tmtF8QVaoEyIaPvg1anekLlRI9oBEQ9QUJF3JkamHA4QidaedPu76RWRZN757T6dTFYH2RiTrW4sY=
X-Received: by 2002:a1f:2e16:: with SMTP id u22mr18673418vku.12.1590414421457;
 Mon, 25 May 2020 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200525134519.1333-1-rsalvaterra@gmail.com>
In-Reply-To: <20200525134519.1333-1-rsalvaterra@gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Mon, 25 May 2020 14:46:50 +0100
Message-ID: <CALjTZvYEqUy+es+gNxETj0CkRGBPRAwJBCEMK+yr=fXGcJ2D+w@mail.gmail.com>
Subject: Re: [PATCH] rt2800: enable MFP support unconditionally
To:     johannes@sipsolutions.net
Cc:     stf_xl@wp.pl, julian.calaby@gmail.com, kvalo@codeaurora.org,
        Larry.Finger@lwfinger.net, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Crap. Please ignore this, I sent the old version by mistake.

On Mon, 25 May 2020 at 14:45, Rui Salvaterra <rsalvaterra@gmail.com> wrote:
>
> This gives us WPA3 support out of the box without having to manually disable
> hardware crypto. The driver will fall back to software crypto if the connection
> requires management frame protection.
>
> Suggested-by: Stanislaw Gruszka <stf_xl@wp.pl>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 4 +---
>  drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 3 ++-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index 6beac1f74e7c..a779fe771a55 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -9971,9 +9971,7 @@ static int rt2800_probe_hw_mode(struct rt2x00_dev *rt2x00dev)
>         if (!rt2x00_is_usb(rt2x00dev))
>                 ieee80211_hw_set(rt2x00dev->hw, HOST_BROADCAST_PS_BUFFERING);
>
> -       /* Set MFP if HW crypto is disabled. */
> -       if (rt2800_hwcrypt_disabled(rt2x00dev))
> -               ieee80211_hw_set(rt2x00dev->hw, MFP_CAPABLE);
> +       ieee80211_hw_set(rt2x00dev->hw, MFP_CAPABLE);
>
>         SET_IEEE80211_DEV(rt2x00dev->hw, rt2x00dev->dev);
>         SET_IEEE80211_PERM_ADDR(rt2x00dev->hw,
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
> index 32efbc8e9f92..4f19581edd0f 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
> @@ -468,7 +468,8 @@ int rt2x00mac_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>         if (!test_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags))
>                 return 0;
>
> -       if (!rt2x00_has_cap_hw_crypto(rt2x00dev))
> +       /* The hardware can't do MFP */
> +       if (!rt2x00_has_cap_hw_crypto(rt2x00dev) || sta->mfp)
>                 return -EOPNOTSUPP;
>
>         /*
> --
> 2.26.2
>
