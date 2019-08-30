Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B748A2D03
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfH3CyG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:54:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32797 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfH3CyG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:54:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so859556qtd.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 19:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fwcmdgU7q00kFuht+qsrxDsozfaixeSAbbkeY/T3Nl0=;
        b=FcsPpaEA1GnSH1As34kCS/P0soJKps2U5TaBHw3zamZaXqd2YR2g34a/nwD0sUyO4x
         TEtEUZM0QfdeB5EqY89retOOsPljOsrVcyVjxmgHGWAaq/2cxberiPPxZKFNnkGLhCKl
         KjV/0t7H1bDAdpIs3X3Sz9Q76KPZxjZqZMprI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fwcmdgU7q00kFuht+qsrxDsozfaixeSAbbkeY/T3Nl0=;
        b=pF320kKDVkvnH8KQv1DJ3xsC/WW2TyZ9cxy97at4Fay8nZaB9Qy1A12gltPN0btfvk
         Ice9fHc8CD5mjhh/21DyaO5w8aLSQKrnfoLidD/f8bQsLusIukIc9/EL/4UU7kIoWFuT
         UQCAa3Y7Xsyf6us3NJ6Amz1RSMa3hohYRYO/1NjRKnHek2buSlLV4ZelFhlJ6sZHKFFu
         Hr4J75RPLxw44tSyyRTZsakQDlcngD/KQhJrbG6bW+pSJmecJr9LfJFgahH2iJCYiARw
         HNx224L0ZcFEgWIMgFQvUhah3a4E49ugeNxUASwF27bCYj7N+KY+gmxKdAltHwzkLPzS
         7kvQ==
X-Gm-Message-State: APjAAAXCSh7yc35Fh1wuI2RWE9aFQoWXaweAbdV5XgVFYfQXluo+7ijm
        zrBpXiHsz9pQO/K030OidrIjqkdWM+sXW+9BNLQlahZOMeA=
X-Google-Smtp-Source: APXvYqwDkY3eDuCbDjmrNBPDlO7/EgGQG++Wc94vJHGaD71iojqHJywI9ufS+3YGEmdHdRdcmnGQqE26YJ0df7uJhpY=
X-Received: by 2002:a0c:d981:: with SMTP id y1mr9059658qvj.104.1567133645165;
 Thu, 29 Aug 2019 19:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <1566998177-2658-1-git-send-email-wgong@codeaurora.org> <1566998177-2658-2-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1566998177-2658-2-git-send-email-wgong@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 30 Aug 2019 10:53:53 +0800
Message-ID: <CANMq1KA2oxpObkP1oj2uK=90sZc9DEXbvdgu9P+87+cwJ__wQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 29, 2019 at 12:18 AM Wen Gong <wgong@codeaurora.org> wrote:
>
> When the FW bundles multiple packets, pkt->act_len may be incorrect
> as it refers to the first packet only (however, the FW will only
> bundle packets that fit into the same pkt->alloc_len).
>
> Before this patch, the skb length would be set (incorrectly) to
> pkt->act_len in ath10k_sdio_mbox_rx_packet, and then later manually
> adjusted in ath10k_sdio_mbox_rx_process_packet.
>
> The first problem is that ath10k_sdio_mbox_rx_process_packet does not
> use proper skb_put commands to adjust the length (it directly changes
> skb->len), so we end up with a mismatch between skb->head + skb->tail
> and skb->data + skb->len. This is quite serious, and causes corruptions
> in the TCP stack, as the stack tries to coalesce packets, and relies
> on skb->tail being correct (that is, skb_tail_pointer must point to
> the first byte_after_ the data).
>
> Instead of re-adjusting the size in ath10k_sdio_mbox_rx_process_packet,
> this moves the code to ath10k_sdio_mbox_rx_packet, and also add a
> bounds check, as skb_put would crash the kernel if not enough space is
> available.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00007-QCARMSWP-1.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

You are not the author of this patch, please reset the author in your
git tree and resend.

Once you do that, the first line should say:
From: Nicolas Boichat <drinkcat@chromium.org>

Without this fix:
NACKed-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
> v2:no this patch
> v2:new added
>  drivers/net/wireless/ath/ath10k/sdio.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 8ed4fbd..1127e44 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -381,16 +381,11 @@ static int ath10k_sdio_mbox_rx_process_packet(struct ath10k *ar,
>         struct ath10k_htc_hdr *htc_hdr = (struct ath10k_htc_hdr *)skb->data;
>         bool trailer_present = htc_hdr->flags & ATH10K_HTC_FLAG_TRAILER_PRESENT;
>         enum ath10k_htc_ep_id eid;
> -       u16 payload_len;
>         u8 *trailer;
>         int ret;
>
> -       payload_len = le16_to_cpu(htc_hdr->len);
> -       skb->len = payload_len + sizeof(struct ath10k_htc_hdr);
> -
>         if (trailer_present) {
> -               trailer = skb->data + sizeof(*htc_hdr) +
> -                         payload_len - htc_hdr->trailer_len;
> +               trailer = skb->data + skb->len - htc_hdr->trailer_len;
>
>                 eid = pipe_id_to_eid(htc_hdr->eid);
>
> @@ -632,13 +627,29 @@ static int ath10k_sdio_mbox_rx_packet(struct ath10k *ar,
>  {
>         struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
>         struct sk_buff *skb = pkt->skb;
> +       struct ath10k_htc_hdr *htc_hdr;
>         int ret;
>
>         ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
>                                  skb->data, pkt->alloc_len);
> +
> +       if (!ret) {
> +               /* Update actual length. The original length may be incorrect,
> +                * as the FW will bundle multiple packets as long as their sizes
> +                * fit within the same aligned length (pkt->alloc_len).
> +                */
> +               htc_hdr = (struct ath10k_htc_hdr *)skb->data;
> +               pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
> +               if (pkt->act_len <= pkt->alloc_len) {
> +                       skb_put(skb, pkt->act_len);
> +               } else {
> +                       ath10k_warn(ar, "rx packet too large (%zu > %zu)\n",
> +                                   pkt->act_len, pkt->alloc_len);
> +                       ret = -EMSGSIZE;
> +               }
> +       }
> +
>         pkt->status = ret;
> -       if (!ret)
> -               skb_put(skb, pkt->act_len);
>
>         return ret;
>  }
> --
> 1.9.1
>
