Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8456DE08E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 12:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfD2KaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 06:30:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34674 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbfD2KaM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 06:30:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id n68so5600180qka.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2019 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsbJoBOTkJ5iG+ZToRJP54iUPlrflioTmA0QK3mgDEc=;
        b=O6Jb8N54hpz3uPynvt6Yt5/rHuZZLUeyQ0rO2pFpfNvWnT1xSu7T4eYytHDR01LEQQ
         ZU1tzv39a8sX4YIaOH4s3mOel/4TQn7rwamS5K9B9YRJzc+N9RK4L4ocfxPOlWxMg4NL
         P1PX0fdUj7gXI8YJSe5Z1aany9gBNk4KVQbDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsbJoBOTkJ5iG+ZToRJP54iUPlrflioTmA0QK3mgDEc=;
        b=ZM9a1Mlk2XTCZv/Q1zkwZpz3q/sBOBxsIlWnULp0VuHCNGIP53Ogj+gBYiXwo5sPPf
         lqwBkTudwpWYGZ8e1KokctwU6bI+VldeEvnNIdpo6Qvnb7whVeLPqFY+/HUnO9I1Mx6S
         VMxI2nFLn3ypkUz7/RB4JOx5ttMXnkb98mUw3/twskyO3e7/t0FNdXFovQCNBYogwzoJ
         hRe/lfIoMgyc9bFu4oX1SeEkUGpdGjJvJlWkRerxsJ6B6RLzkfBb+cZcHY7Z0vIJ3P44
         qK6Mwr75qGjToqyMJFaL6+0axo+gdQJZDmB5YC0quFrOHbsnohL1I+SrwnCseQ9fXcrN
         IxZw==
X-Gm-Message-State: APjAAAWWUfAtahs8166x680jeAwbCAw6xHWIooVbkWSitNKBgRksyn3P
        fNe80PwvyeKCdgQ+PEcjICf46nR8zIY+mVfHe5TaoQ==
X-Google-Smtp-Source: APXvYqxZ73NWcz094Q/7/PmP4XT2MmsPOvqcdxePBjq87Uy02bxkEdIOmOR4YOXaAalFtBGm5if9wOLGQYtec+tcCPM=
X-Received: by 2002:a37:6897:: with SMTP id d145mr35198030qkc.185.1556533811413;
 Mon, 29 Apr 2019 03:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <1554260478-4161-1-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1554260478-4161-1-git-send-email-wgong@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 29 Apr 2019 18:30:00 +0800
Message-ID: <CANMq1KAU1B4Bweq3O6O8HOMwT7fHjj9tDyxqMsn_vn4gwxXL=Q@mail.gmail.com>
Subject: Re: [PATCH] ath10k: add peer id check in ath10k_peer_find_by_id
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Apr 3, 2019 at 3:01 AM Wen Gong <wgong@codeaurora.org> wrote:
>
> For some SDIO chip, the peer id is 65535 for MPDU with error status,
> then test_bit will trigger buffer overflow for peer's memory, if kasan
> enabled, it will report error.
>
> Add check for overflow the size of peer's peer_ids will avoid the buffer
> overflow access.
>
> Call trace of kasan:
> dump_backtrace+0x0/0x2ec
> show_stack+0x20/0x2c
> __dump_stack+0x20/0x28
> dump_stack+0xc8/0xec
> print_address_description+0x74/0x240
> kasan_report+0x250/0x26c
> __asan_report_load8_noabort+0x20/0x2c
> ath10k_peer_find_by_id+0x180/0x1e4 [ath10k_core]
> ath10k_htt_t2h_msg_handler+0x100c/0x2fd4 [ath10k_core]
> ath10k_htt_htc_t2h_msg_handler+0x20/0x34 [ath10k_core]
> ath10k_sdio_irq_handler+0xcc8/0x1678 [ath10k_sdio]
> process_sdio_pending_irqs+0xec/0x370
> sdio_run_irqs+0x68/0xe4
> sdio_irq_work+0x1c/0x28
> process_one_work+0x3d8/0x8b0
> worker_thread+0x508/0x7cc
> kthread+0x24c/0x264
> ret_from_fork+0x10/0x18
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/txrx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
> index 23606b6..33de9e1 100644
> --- a/drivers/net/wireless/ath/ath10k/txrx.c
> +++ b/drivers/net/wireless/ath/ath10k/txrx.c
> @@ -157,6 +157,9 @@ struct ath10k_peer *ath10k_peer_find_by_id(struct ath10k *ar, int peer_id)
>  {
>         struct ath10k_peer *peer;
>
> +       if (peer_id >= sizeof(peer->peer_ids) * BITS_PER_BYTE)

I'd use >= BITS_PER_TYPE(peer->peer_ids).

> +               return NULL;
> +
>         lockdep_assert_held(&ar->data_lock);
>
>         list_for_each_entry(peer, &ar->peers, list)
