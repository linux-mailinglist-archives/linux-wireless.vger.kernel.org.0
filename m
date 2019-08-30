Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967A3A2D0B
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 04:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfH3C6T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Aug 2019 22:58:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40432 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfH3C6T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Aug 2019 22:58:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id g4so6108852qtq.7
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2019 19:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPLQ7BTQD4QmxZ4SmCozFsFwM264Pt8CJss3mn21Uvc=;
        b=BwYxDRwZ39yK8n3ItihjOL+cBbh12tcJrBTG621OTtttwbom5ELftpwqLkhxclNBZH
         VZtdNtSA70EhQ2ss238kUgi9A5pBDeVcGyZ9uhF/9lRxmAEb/lCJ88+neDnUM45n+D0g
         zNx5cY9pp7qWbYoJ10VOWYrVyrqYvRAvjqtjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPLQ7BTQD4QmxZ4SmCozFsFwM264Pt8CJss3mn21Uvc=;
        b=Q0sqLRdN2Kjn8cOz8ooeO0nuJL9jaWhq3TGqBlyAX5N0QgWXT+3w3WGHfxg529Eos7
         0J65GlkFFbH1Vl+ZwaMZERm1ydbbZbAX6ciBlOjgCa/Y5iDeLEkVlD12jvMe++RNpew3
         CRJ7HB1jxNR3Qqm5o4wBRsdzHMLqZE7TM/eEsokuokKdfoKYWyvorpdvQPqWeMC7TzvV
         IRe88C7TUJCvwfqZIwMPzB7MIC4zgPcUMk48OgxFcufDcNPaBtDXhfWSr5nXqp4FVWdR
         MZYLCgIIP4ESiYTh+gQnOwrcFgEUhh+25XkftLZKeTdkplUgqC0qOTvdjc1xPFN4uLUU
         a52Q==
X-Gm-Message-State: APjAAAV4gQpNelmeAFPCBfWC+LUBToqbEiAlVEP+X6fT8LN4MwzhsGyO
        cRmgIKpKbWPfOn1yP8cCElC30rhAm/d8kBe2v39E7w==
X-Google-Smtp-Source: APXvYqyfJyqdOTdlF46wH1dygwZP41ASOFWpTXyCP9VVXTjZuxLLBlVtx6ZIVHFofVA3RswoMYSwenX8O6UQ26Cv2Yc=
X-Received: by 2002:aed:3768:: with SMTP id i95mr13645168qtb.346.1567133897617;
 Thu, 29 Aug 2019 19:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <1566998177-2658-1-git-send-email-wgong@codeaurora.org>
 <1566998177-2658-2-git-send-email-wgong@codeaurora.org> <CANMq1KA2oxpObkP1oj2uK=90sZc9DEXbvdgu9P+87+cwJ__wQQ@mail.gmail.com>
In-Reply-To: <CANMq1KA2oxpObkP1oj2uK=90sZc9DEXbvdgu9P+87+cwJ__wQQ@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 30 Aug 2019 10:58:05 +0800
Message-ID: <CANMq1KAORTMMZNH90piG2hhOVQ1=UWaOQwPFtiLP=31iiJttUg@mail.gmail.com>
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

On Fri, Aug 30, 2019 at 10:53 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Thu, Aug 29, 2019 at 12:18 AM Wen Gong <wgong@codeaurora.org> wrote:
> >
> > When the FW bundles multiple packets, pkt->act_len may be incorrect
> > as it refers to the first packet only (however, the FW will only
> > bundle packets that fit into the same pkt->alloc_len).
> >
> > Before this patch, the skb length would be set (incorrectly) to
> > pkt->act_len in ath10k_sdio_mbox_rx_packet, and then later manually
> > adjusted in ath10k_sdio_mbox_rx_process_packet.
> >
> > The first problem is that ath10k_sdio_mbox_rx_process_packet does not
> > use proper skb_put commands to adjust the length (it directly changes
> > skb->len), so we end up with a mismatch between skb->head + skb->tail
> > and skb->data + skb->len. This is quite serious, and causes corruptions
> > in the TCP stack, as the stack tries to coalesce packets, and relies
> > on skb->tail being correct (that is, skb_tail_pointer must point to
> > the first byte_after_ the data).
> >
> > Instead of re-adjusting the size in ath10k_sdio_mbox_rx_process_packet,
> > this moves the code to ath10k_sdio_mbox_rx_packet, and also add a
> > bounds check, as skb_put would crash the kernel if not enough space is
> > available.
> >
> > Tested with QCA6174 SDIO with firmware
> > WLAN.RMH.4.4.1-00007-QCARMSWP-1.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > Signed-off-by: Wen Gong <wgong@codeaurora.org>
>
> You are not the author of this patch, please reset the author in your
> git tree and resend.
>
> Once you do that, the first line should say:
> From: Nicolas Boichat <drinkcat@chromium.org>
>
> Without this fix:
> NACKed-by: Nicolas Boichat <drinkcat@chromium.org>
>

Also you dropped the Fixes line:
Fixes: 8530b4e7b22bc3b ("ath10k: sdio: set skb len for all rx packets")

> > ---
> > v2:no this patch
> > v2:new added
> >  drivers/net/wireless/ath/ath10k/sdio.c | 27 +++++++++++++++++++--------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> > index 8ed4fbd..1127e44 100644
> > --- a/drivers/net/wireless/ath/ath10k/sdio.c
> > +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> > @@ -381,16 +381,11 @@ static int ath10k_sdio_mbox_rx_process_packet(struct ath10k *ar,
> >         struct ath10k_htc_hdr *htc_hdr = (struct ath10k_htc_hdr *)skb->data;
> >         bool trailer_present = htc_hdr->flags & ATH10K_HTC_FLAG_TRAILER_PRESENT;
> >         enum ath10k_htc_ep_id eid;
> > -       u16 payload_len;
> >         u8 *trailer;
> >         int ret;
> >
> > -       payload_len = le16_to_cpu(htc_hdr->len);
> > -       skb->len = payload_len + sizeof(struct ath10k_htc_hdr);
> > -
> >         if (trailer_present) {
> > -               trailer = skb->data + sizeof(*htc_hdr) +
> > -                         payload_len - htc_hdr->trailer_len;
> > +               trailer = skb->data + skb->len - htc_hdr->trailer_len;
> >
> >                 eid = pipe_id_to_eid(htc_hdr->eid);
> >
> > @@ -632,13 +627,29 @@ static int ath10k_sdio_mbox_rx_packet(struct ath10k *ar,
> >  {
> >         struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> >         struct sk_buff *skb = pkt->skb;
> > +       struct ath10k_htc_hdr *htc_hdr;
> >         int ret;
> >
> >         ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
> >                                  skb->data, pkt->alloc_len);
> > +
> > +       if (!ret) {
> > +               /* Update actual length. The original length may be incorrect,
> > +                * as the FW will bundle multiple packets as long as their sizes
> > +                * fit within the same aligned length (pkt->alloc_len).
> > +                */
> > +               htc_hdr = (struct ath10k_htc_hdr *)skb->data;
> > +               pkt->act_len = le16_to_cpu(htc_hdr->len) + sizeof(*htc_hdr);
> > +               if (pkt->act_len <= pkt->alloc_len) {
> > +                       skb_put(skb, pkt->act_len);
> > +               } else {
> > +                       ath10k_warn(ar, "rx packet too large (%zu > %zu)\n",
> > +                                   pkt->act_len, pkt->alloc_len);
> > +                       ret = -EMSGSIZE;
> > +               }
> > +       }
> > +
> >         pkt->status = ret;
> > -       if (!ret)
> > -               skb_put(skb, pkt->act_len);
> >
> >         return ret;
> >  }
> > --
> > 1.9.1
> >
