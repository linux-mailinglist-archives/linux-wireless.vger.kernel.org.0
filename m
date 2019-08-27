Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC49E109
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2019 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfH0IIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Aug 2019 04:08:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42638 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732626AbfH0IIQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Aug 2019 04:08:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so16270789qkm.9
        for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2019 01:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YMyttUCQZ4ISy8V1dwK6zHFJylST2fDCu+TqHXmTfhk=;
        b=OwI9RAnGPIW0FSy18F1g8gNB+/QjYzphOy0byRLX7eoNfJyu7OVon5TzZadgdSk2lZ
         l4zE6zYQvcC46AD8t0iVx6/xkbmj7kkOURTQmLPGGXQEnMLheAe3f/xvXfkuTCbC1MgM
         Wtou6RDmjMuX/ph8M1XvPSUhkdCOmmxfPNxeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YMyttUCQZ4ISy8V1dwK6zHFJylST2fDCu+TqHXmTfhk=;
        b=PrC3zE0+eS8oUMCVPXdsR2KY2oT8RKnO8FxKs3hBJqTQYL74DPXfTGToVT/hSVQ7VT
         6L5SwSt+UEh+hH8H9vlW2bKwIAjmYHdhPuN2jNiETEbpfz7Az18T8UMXWmjvkcAqtvlT
         IR2wGGC9W6mInMzOqkcOPMi2rBVcs/e/+ObX7zsXjHzeZnNU3QIsVDQ2diiDA8X+jsE5
         Py2R3oLXOYzQeqvix/ETlGmzGexGUpUSv8412qyCR09QTMAMdztv7j7G3c1Ma0glYigH
         2uokRiXqUhtaJkiWOzzq79AxhFSmZh2toE8G9cOkcdfakBipqXrGByGSfhCc3Lbv2+jx
         UaCg==
X-Gm-Message-State: APjAAAXlHPezbtmkcpMttp1z6l5S8mrgn1gYz8ut9cb26eB8ici9Ln93
        0cd8bkAeWqGt/IckrPem0pisJmnculJwDwBgnYrdGg==
X-Google-Smtp-Source: APXvYqzvhA+OprcDNMPqcvh7K2ub0bk8PJx6uICdSdi7h/udMi/13ymBwnoPwlSsQD/pN3WEtAZjW3uTv46J0XVrCP0=
X-Received: by 2002:ae9:f301:: with SMTP id p1mr20784257qkg.353.1566893295132;
 Tue, 27 Aug 2019 01:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <1566302108-18219-1-git-send-email-wgong@codeaurora.org>
 <1566302108-18219-2-git-send-email-wgong@codeaurora.org> <CANMq1KBR0nd+XOJWpgWyoJdsFgZByQyjD-0dpttygiN0OfiD5Q@mail.gmail.com>
 <2ec213d88ebb4b89812826866b39886d@aptaiexm02f.ap.qualcomm.com>
In-Reply-To: <2ec213d88ebb4b89812826866b39886d@aptaiexm02f.ap.qualcomm.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 27 Aug 2019 16:08:04 +0800
Message-ID: <CANMq1KCiH8-16esCfwi+60=ArZKC0G83Qs-W2Hq5GARar=6D9g@mail.gmail.com>
Subject: Re: [PATCH 1/7] ath10k: enable RX bundle receive for sdio
To:     Wen Gong <wgong@qti.qualcomm.com>
Cc:     Wen Gong <wgong@codeaurora.org>,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>,
        "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 27, 2019 at 4:03 PM Wen Gong <wgong@qti.qualcomm.com> wrote:
>
> > -----Original Message-----
> > From: ath10k <ath10k-bounces@lists.infradead.org> On Behalf Of Nicolas
> > Boichat
> > Sent: Tuesday, August 27, 2019 3:41 PM
> > To: Wen Gong <wgong@codeaurora.org>
> > Cc: open list:NETWORKING DRIVERS (WIRELESS) <linux-
> > wireless@vger.kernel.org>; ath10k@lists.infradead.org
> > Subject: [EXT] Re: [PATCH 1/7] ath10k: enable RX bundle receive for sdio
> >
> > > -static int ath10k_sdio_mbox_rx_fetch(struct ath10k *ar)
> > > +static int ath10k_sdio_mbox_rx_fetch_bundle(struct ath10k *ar)
> > >  {
> > >         struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> > > +       struct ath10k_sdio_rx_data *pkt;
> > >         int ret, i;
> > > +       u32 pkt_offset, virt_pkt_len;
> > >
> > > +       virt_pkt_len = 0;
> > >         for (i = 0; i < ar_sdio->n_rx_pkts; i++) {
> > > -               ret = ath10k_sdio_mbox_rx_packet(ar,
> > > -                                                &ar_sdio->rx_pkts[i]);
> > > -               if (ret)
> > > +               virt_pkt_len += ar_sdio->rx_pkts[i].alloc_len;
> > > +       }
> > > +
> > > +       if (virt_pkt_len < ATH10K_SDIO_DMA_BUF_SIZE) {
> > > +               ret = ath10k_sdio_readsb(ar, ar_sdio->mbox_info.htc_addr,
> > > +                                        ar_sdio->vsg_buffer, virt_pkt_len);
> > > +               if (ret) {
> > > +                       i = 0;
> > >                         goto err;
> > > +               }
> > > +       } else {
> > > +               ath10k_err(ar, "size exceeding limit %d\n", virt_pkt_len);
> > > +       }
> > > +
> > > +       pkt_offset = 0;
> > > +       for (i = 0; i < ar_sdio->n_rx_pkts; i++) {
> > > +               struct sk_buff *skb = ar_sdio->rx_pkts[i].skb;
> > > +
> > > +               pkt = &ar_sdio->rx_pkts[i];
> > > +               memcpy(skb->data, ar_sdio->vsg_buffer + pkt_offset,
> > > +                      pkt->alloc_len);
> >
> > Why do you copy alloc_len if you only plan to use act_len?
> alloc_len is aligned to block size(256),  and act_len maybe not same for each packet in the bundle.
> Eg a bundle:
> Packet 1 len 240,   alloc_len: 256, 1st time: act_len 240, left padding size is 16,
> Packet 1 len 250, alloc_len: 256, 1st time: act_len 240, left padding size is 6,
> Packet 1 len 230,   alloc_len: 256, 1st time: act_len 240, left padding size is 26,
>
> The bundled buffer len is 256 * 3 = 768, it has 256 bytes for each packet, the left size is padding which
> Is not needed, but the left padding is not same for each packet, before read all the buffer from sdio bus,
> It does not know each packet's act len, it only know the 1st packet's act len.
> So it need to copy all the alloc_len's buffer to ensure it will not lose data.

Gotcha, thanks.

> > Actually, just use skb_put_data.
> >
> > Also, do you have the same issue as
> > https://patchwork.kernel.org/patch/11116215/ w.r.t. act_len being
> > incorrect?
> >
> > > +               pkt->status = 0;
> > > +               skb_put(skb, pkt->act_len);

So I guess this is incorrect, see patchwork linked above.

> > > +               pkt_offset += pkt->alloc_len;
> > >         }
> > >
> > >         return 0;
> > >
> >
> > _______________________________________________
> > ath10k mailing list
> > ath10k@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/ath10k
