Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5CC23F875
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Aug 2020 20:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgHHSev (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Aug 2020 14:34:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23933 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHSeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Aug 2020 14:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596911683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tl0RnskJnH0c4Is5Eg5/TEMg/0/tur4bxuu2WMZ+WHM=;
        b=aXHMyQyv80nHaKMGI6qIGzClHMFnRKFtScIDrscMhChdT66EmtBGpknnRmSBwkPwUjjAji
        yETZJt3fHbxgeVaTgtgf0mk+lWJAN8dHBsOrP2EAuDck41sjhPito0AUn7WdOQK441ctfZ
        ZN0JZw0oUN0wkz9pCmS6gxSl69QGYDo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-4KIZLI7RMe2lSJuREzj6fQ-1; Sat, 08 Aug 2020 14:34:41 -0400
X-MC-Unique: 4KIZLI7RMe2lSJuREzj6fQ-1
Received: by mail-il1-f198.google.com with SMTP id e12so4368304ile.14
        for <linux-wireless@vger.kernel.org>; Sat, 08 Aug 2020 11:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl0RnskJnH0c4Is5Eg5/TEMg/0/tur4bxuu2WMZ+WHM=;
        b=DFLWz5yMDKT7KzmyPYHceCAg7Q/CvZpVoiMS78G9shzOIOkdRjTg/teNvXbq16mfq2
         u3egviMAKy2lYAOLVYJ5YQraUsIikQAdPwTpSv8DehUVbu/8BO64a8f1F1sJCqc9f76V
         SB3qpXkMXmtxsrfoXu2Tvi/Z6BgEaYMSK1PzPLqYSyx5AEPKVUmVOJEV9bEcIHNt/Afo
         RdHgzRvE8TzH3y1HzZiq32oTDYsyyIXQVjwFpAqZbvAhfTTTrzRnLlMyVZ+mOqC5liqs
         MXvLqt+5FphVYbxXcOokUUhPheQgag4ssIEZeDn7dPppSqoc/WIl+Va+O5NKk5qp+C1A
         v2kg==
X-Gm-Message-State: AOAM531n4Ao5V05OWiuENyDuM46qT7J5c180sJD/KadYF2L2dv4tImfM
        +eqardhsDCJQ8mkRYNUDjMFEJ7TgB9c74l52QIuL0ZcI8C6pu8lZYRrB60UkKMKeZcimfwjPvh0
        Of6wVtRj+5O7/8NtVH/qNVyM1iyJCYoyRhzu06QzuFu4=
X-Received: by 2002:a92:cbd0:: with SMTP id s16mr1986641ilq.187.1596911680571;
        Sat, 08 Aug 2020 11:34:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8CyLH6sXUcoonlS6edw3t8E04eXUjYfoao+gcwpKnDdTbKaO6Dgw8LvbkwY6YCGhV6O6Tr5hl//wucd4Gt48=
X-Received: by 2002:a92:cbd0:: with SMTP id s16mr1986627ilq.187.1596911680319;
 Sat, 08 Aug 2020 11:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <368c78ef79cb6782008b33a87d73b5fc51ba2989.1596101881.git.lorenzo@kernel.org>
In-Reply-To: <368c78ef79cb6782008b33a87d73b5fc51ba2989.1596101881.git.lorenzo@kernel.org>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sat, 8 Aug 2020 20:34:37 +0200
Message-ID: <CAJ0CqmVXrfMJXWnW+cZCFJxv1+At4UrPesrvk0D73iHTaFgFyA@mail.gmail.com>
Subject: Re: [PATCH] mt76: mt76s: fix oom in mt76s_tx_queue_skb_raw
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Free the mcu skb in case of error in mt76s_tx_queue_skb_raw routine
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

I think the proper fixes tag for this patch is:

Fixes: d39b52e31aa6 ("mt76: introduce mt76_sdio module")

Regards,
Lorenzo

>  drivers/net/wireless/mediatek/mt76/sdio.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
> index d2b38ed7f3b4..5d8353026aaf 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio.c
> @@ -244,22 +244,27 @@ mt76s_tx_queue_skb_raw(struct mt76_dev *dev, enum mt76_txq_id qid,
>         struct mt76_queue *q = dev->q_tx[qid].q;
>         int ret = -ENOSPC, len = skb->len;
>
> -       spin_lock_bh(&q->lock);
>         if (q->queued == q->ndesc)
> -               goto out;
> +               goto error;
>
>         ret = mt76_skb_adjust_pad(skb);
>         if (ret)
> -               goto out;
> +               goto error;
> +
> +       spin_lock_bh(&q->lock);
>
>         q->entry[q->tail].buf_sz = len;
>         q->entry[q->tail].skb = skb;
>         q->tail = (q->tail + 1) % q->ndesc;
>         q->queued++;
>
> -out:
>         spin_unlock_bh(&q->lock);
>
> +       return 0;
> +
> +error:
> +       dev_kfree_skb(skb);
> +
>         return ret;
>  }
>
> --
> 2.26.2
>

