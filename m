Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2DA635F
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfICICV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 04:02:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34107 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfICICV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 04:02:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id a13so18651541qtj.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2019 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mf23oRVAg9Ado2Z55/YVQ2maTun9rnutQ4lnmDriggw=;
        b=XW+EtOwRLw5B2SS2HDdQ0Jre3Ow0r2M0FuFhClSnHkJrIEcV0NvCPnqCYazJ6P9iHD
         jTjBhOyMix4ECMRwwGIpTwy52lYWQBlaWnxxXXCQ/yoYNbluiOKguQPG8E9YJdMxCE+J
         ITWK3KAoF9Xpqu2suBfE2J0IXfC6yqmVYY2zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mf23oRVAg9Ado2Z55/YVQ2maTun9rnutQ4lnmDriggw=;
        b=SizaCM5jDlvSqD32OUUwiR7OEnAJ2aDv5R52a86uBmjRDNEf1VCA6ji+Tiz/Yhhiew
         s5Wecy/2bdoJHiJP551q8eoJBI+uJEIGit67hJB1EDwTn9MAl0vUK9jp3Y9H7NcNfpHr
         tc9o/8ES4PjzSkLWTGiCVq1sSTJkjm6mGZPn5gmIxvgUWX9GHWd5ewyJNXra4jg7uL7O
         qFS1iOPIFkgd2KMdJdPdk+moNxKxdbLopew3BVe0IcCgbVemffdi5tYu3y/Dj0gpqmzS
         KEV+toYjRP0n5Uml62Z0k94VaERBMyHVHzqG2qYDugyswKgbkh0pa0omHKVXrYL23bPV
         hzsA==
X-Gm-Message-State: APjAAAX6LWabXARZ/fF3xmvUD7pjufNaraj7HipsJDm+7zWKXx0hxSiz
        tG+snmwduikGFbUjiugaB3EVe3uTOi9uxdJYg1cA+Q==
X-Google-Smtp-Source: APXvYqxCyMTtSDnqQNKgScrdJiT+0Ur52eMffmQXpByPZk4mSJL07jqQMyAKG2mTOxw18It5WaDu3UfInMMRLxz9do0=
X-Received: by 2002:ad4:540c:: with SMTP id f12mr7138400qvt.104.1567497740147;
 Tue, 03 Sep 2019 01:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <1567416146-14403-1-git-send-email-wgong@codeaurora.org> <1567416146-14403-2-git-send-email-wgong@codeaurora.org>
In-Reply-To: <1567416146-14403-2-git-send-email-wgong@codeaurora.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 3 Sep 2019 16:02:09 +0800
Message-ID: <CANMq1KANHhmP+yEj7Yw3P+akT+mM=y6rjfq1sEjg0NUuWJkdCw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] ath10k: adjust skb length in ath10k_sdio_mbox_rx_packet
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>, Wen Gong <wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle: Can you please help prioritize the review and merge of this
patch? This is quite a serious regression (the rest of the series is
performance improvement and probably a little less urgent).

On Mon, Sep 2, 2019 at 5:22 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> From: Nicolas Boichat <drinkcat@chromium.org>
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
> Fixes: 8530b4e7b22bc3b ("ath10k: sdio: set skb len for all rx packets")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
> v2: no this patch
> v3: new added
> v4: change commit log
>
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
