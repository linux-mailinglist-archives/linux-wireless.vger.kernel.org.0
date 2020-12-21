Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB32E010A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 20:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLUTcg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Dec 2020 14:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUTcf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Dec 2020 14:32:35 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FFDC0613D6
        for <linux-wireless@vger.kernel.org>; Mon, 21 Dec 2020 11:31:55 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 15so12383432oix.8
        for <linux-wireless@vger.kernel.org>; Mon, 21 Dec 2020 11:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N5yF8MX27ibe8pYaUNX9jkjz98WF9cXm94+NVHlwyyc=;
        b=GrhC+e8EhcqI7uTngJIjhv7kKLDWW5kVVFQXdUvjlcvZ74knhY4R1EZpQiii79P0ds
         eKRLxsKJ3wA8dQAS5ypOvr+nhykt2QxF4/2EWKBD2ITGhHwNGWpJ4VebS7uUL0+WaPys
         KjDhC7ncbVv1SUcX2cz4GX99kfQ99IzB0GBx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N5yF8MX27ibe8pYaUNX9jkjz98WF9cXm94+NVHlwyyc=;
        b=WOm/7wIq5WUwhD3X7zfJ6nkNons2rguJj7ksYv9qqKP92eRN09RrL1ChSVbZT00YUt
         hr/xrAS+wE43QVwfUwW5TrIMZuLbi/rTA/sGh9m7Ls3yhXEGN0hvyvCxGpLqNkaJa/62
         wjtP5L+w7XNfLxNjY36FvLtH1/p2OA5o1x1MxdII2KwxiY3HWSBP2SsBYFYA+49+FKpU
         YGz2eAtftKdRzqAOMTYCsjNts6IBgXKbkh4pBM6jrFHqcpKEowjPVdlANpnvLetg1Q8+
         ursQOJiypGJpHq9LPzwYp10XU0Whoi02noZw86OQaxO0dnogR34uPfvO1mZ/tIkgwe94
         94tw==
X-Gm-Message-State: AOAM530laxHkXb3tS52nyfFoh/SJjkNBF/lUasevcU3V01bmPWrcRrHC
        woEs+oaJZUCKed1YakEis3O7SUF19rdNvg==
X-Google-Smtp-Source: ABdhPJwo1B1gPhXM3uecF6iGawkR+vh+r2c+pDJd3v/CiacXTqsudXbdfxDbjMfQbL7Mk2xpXtPazA==
X-Received: by 2002:aca:568f:: with SMTP id k137mr12218760oib.138.1608579114580;
        Mon, 21 Dec 2020 11:31:54 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id u85sm3786237oif.57.2020.12.21.11.31.53
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 11:31:53 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id q25so12360267oij.10
        for <linux-wireless@vger.kernel.org>; Mon, 21 Dec 2020 11:31:53 -0800 (PST)
X-Received: by 2002:aca:af4d:: with SMTP id y74mr11678757oie.105.1608579112704;
 Mon, 21 Dec 2020 11:31:52 -0800 (PST)
MIME-Version: 1.0
References: <1608515579-1066-1-git-send-email-miaoqing@codeaurora.org>
In-Reply-To: <1608515579-1066-1-git-send-email-miaoqing@codeaurora.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 21 Dec 2020 11:31:40 -0800
X-Gmail-Original-Message-ID: <CA+ASDXP8LotnQZNvXYZqfYH8za6rx1DaZmnH21TsO2NmzX+OZA@mail.gmail.com>
Message-ID: <CA+ASDXP8LotnQZNvXYZqfYH8za6rx1DaZmnH21TsO2NmzX+OZA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: fix wmi mgmt tx queue full due to race condition
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Sun, Dec 20, 2020 at 5:53 PM Miaoqing Pan <miaoqing@codeaurora.org> wrot=
e:
>
> Failed to transmit wmi management frames:
>
> [84977.840894] ath10k_snoc a000000.wifi: wmi mgmt tx queue is full
> [84977.840913] ath10k_snoc a000000.wifi: failed to transmit packet, dropp=
ing: -28
> [84977.840924] ath10k_snoc a000000.wifi: failed to submit frame: -28
> [84977.840932] ath10k_snoc a000000.wifi: failed to transmit frame: -28
>
> This issue is caused by race condition between skb_dequeue and
> __skb_queue_tail. The queue of =E2=80=98wmi_mgmt_tx_queue=E2=80=99 is pro=
tected by a
> different lock: ar->data_lock vs list->lock, the result is no protection.

Nice catch!

> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -3763,23 +3763,16 @@ bool ath10k_mac_tx_frm_has_freq(struct ath10k *ar=
)
>  static int ath10k_mac_tx_wmi_mgmt(struct ath10k *ar, struct sk_buff *skb=
)
>  {
>         struct sk_buff_head *q =3D &ar->wmi_mgmt_tx_queue;
> -       int ret =3D 0;
> -
> -       spin_lock_bh(&ar->data_lock);
>
>         if (skb_queue_len(q) =3D=3D ATH10K_MAX_NUM_MGMT_PENDING) {

I believe you should be switching this to use skb_queue_len_lockless()
too. And this still probably leaves a TOCTOU race; maybe we should use
">=3D" here, in case we queue a few SKBs simultaneously? It doesn't seem
like we actually have a hard limit here, but it still seems like we
shouldn't leave this potential inconsistency.

Brian

>                 ath10k_warn(ar, "wmi mgmt tx queue is full\n");
> -               ret =3D -ENOSPC;
> -               goto unlock;
> +               return -ENOSPC;
>         }
>
> -       __skb_queue_tail(q, skb);
> +       skb_queue_tail(q, skb);
>         ieee80211_queue_work(ar->hw, &ar->wmi_mgmt_tx_work);
