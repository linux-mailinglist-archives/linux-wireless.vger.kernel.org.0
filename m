Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FE089D51
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2019 13:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfHLLu5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Aug 2019 07:50:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbfHLLu5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Aug 2019 07:50:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 215633C917;
        Mon, 12 Aug 2019 11:50:57 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1F63600C4;
        Mon, 12 Aug 2019 11:50:54 +0000 (UTC)
Date:   Mon, 12 Aug 2019 13:50:52 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190812115051.GB6333@redhat.com>
References: <20190729125351.GA3086@redhat.com>
 <20190729140241.GC4030@localhost.localdomain>
 <20190730135450.GA2361@redhat.com>
 <20190730145531.GA3813@localhost.localdomain>
 <20190731081957.GA4096@redhat.com>
 <20190731085147.GB4096@redhat.com>
 <20190731090927.GA3665@localhost.localdomain>
 <20190805100110.GA17889@redhat.com>
 <20190805112719.GA12280@localhost.localdomain>
 <20190805123916.GA24209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805123916.GA24209@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 12 Aug 2019 11:50:57 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 05, 2019 at 02:39:16PM +0200, Stanislaw Gruszka wrote:
> On Mon, Aug 05, 2019 at 01:27:19PM +0200, Lorenzo Bianconi wrote:
> > > ... but I think we have bug when do mt76_txq_schedule_all() in
> > > tx_tasklet, because we can schedule on queues that are stoped.
> > > So reverting 41634aa8d6db and then optimize by removing tx_tasklet
> > > for mmio and remove not needed mt76_txq_schedule_all() calls looks
> > > more reasoneble to me.
> > 
> > schedule a stopped queue seems not harmful at a first glance since we do not
> > copy pending skbs if we have not enough room in the dma ring.
> 
> mac80211 stop queues for various other reasons than 
> IEEE80211_QUEUE_STOP_REASON_DRIVER .

After looking in more details, we check if queue is stopped in 
ieee80211_tx_dequeue(). But we do not check that for skb's queued
in mtxq->retry_q .

> > diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
> > index 5397827668b9..bd2d34c4f326 100644
> > --- a/drivers/net/wireless/mediatek/mt76/tx.c
> > +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> > @@ -495,6 +495,9 @@ mt76_txq_schedule_list(struct mt76_dev *dev, enum mt76_txq_id qid)
> >  	while (1) {
> >  		bool empty = false;
> >  
> > +		if (hwq->stopped)
> > +			break;
> > +
> >  		if (sq->swq_queued >= 4)
> >  			break;
> > 
> > Does it fix the issue you are facing?
> 
> I'll not be able to test this patch this week. Will have access to
> the hardware next week. 
> 
> I checeked before, if
> 'q->queued + (tx_info.nbuf + 1) / 2 >= q->ndesc - 1' is triggered
> when MT7630E hangs and it is not. But maybe second part of the patch
> will help.

Patch did not help.

I debugged problem a bit more and issue is related with HW encryption.
Using full mac80211 SW encyption by retuning -EOPNOTSUPP
mt76x02_set_key() make the problem gone as well. Looks there is
some race between setting HW keys and transmitting.

Stanislaw
