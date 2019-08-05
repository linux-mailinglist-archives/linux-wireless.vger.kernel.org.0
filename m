Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2814381979
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHEMjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 08:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfHEMjW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 08:39:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 211F2307D928;
        Mon,  5 Aug 2019 12:39:22 +0000 (UTC)
Received: from localhost (unknown [10.40.205.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2558052EF;
        Mon,  5 Aug 2019 12:39:18 +0000 (UTC)
Date:   Mon, 5 Aug 2019 14:39:17 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190805123916.GA24209@redhat.com>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
 <20190729125351.GA3086@redhat.com>
 <20190729140241.GC4030@localhost.localdomain>
 <20190730135450.GA2361@redhat.com>
 <20190730145531.GA3813@localhost.localdomain>
 <20190731081957.GA4096@redhat.com>
 <20190731085147.GB4096@redhat.com>
 <20190731090927.GA3665@localhost.localdomain>
 <20190805100110.GA17889@redhat.com>
 <20190805112719.GA12280@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805112719.GA12280@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 05 Aug 2019 12:39:22 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 05, 2019 at 01:27:19PM +0200, Lorenzo Bianconi wrote:
> > ... but I think we have bug when do mt76_txq_schedule_all() in
> > tx_tasklet, because we can schedule on queues that are stoped.
> > So reverting 41634aa8d6db and then optimize by removing tx_tasklet
> > for mmio and remove not needed mt76_txq_schedule_all() calls looks
> > more reasoneble to me.
> 
> schedule a stopped queue seems not harmful at a first glance since we do not
> copy pending skbs if we have not enough room in the dma ring.

mac80211 stop queues for various other reasons than 
IEEE80211_QUEUE_STOP_REASON_DRIVER .
 
> Maybe we can be
> more conservative doing something like:
>
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
> index d8f61e540bfd..c6482155e5e4 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -346,6 +346,11 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, enum mt76_txq_id qid,
>  		goto unmap;
>  
>  	if (q->queued + (tx_info.nbuf + 1) / 2 >= q->ndesc - 1) {
> +		if (!q->stopped) {
> +			ieee80211_stop_queue(dev->hw,
> +					     skb_get_queue_mapping(skb));
> +			q->stopped = true;
> +		}
>  		ret = -ENOMEM;
>  		goto unmap;
>  	}
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
> index 5397827668b9..bd2d34c4f326 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -495,6 +495,9 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
>  	while (1) {
>  		bool empty = false;
>  
> +		if (hwq->stopped)
> +			break;
> +
>  		if (sq->swq_queued >= 4)
>  			break;
> 
> Does it fix the issue you are facing?

I'll not be able to test this patch this week. Will have access to
the hardware next week. 

I checeked before, if
'q->queued + (tx_info.nbuf + 1) / 2 >= q->ndesc - 1' is triggered
when MT7630E hangs and it is not. But maybe second part of the patch
will help.

Stanislaw
