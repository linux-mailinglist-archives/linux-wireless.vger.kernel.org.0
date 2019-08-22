Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE0993F1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 14:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbfHVMiD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 08:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729052AbfHVMiD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 08:38:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC3D510C6966;
        Thu, 22 Aug 2019 12:38:02 +0000 (UTC)
Received: from localhost (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E5B75D6A7;
        Thu, 22 Aug 2019 12:37:59 +0000 (UTC)
Date:   Thu, 22 Aug 2019 14:37:58 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: remove empty flag in mt76_txq_schedule_list
Message-ID: <20190822123757.GA28300@redhat.com>
References: <fb24ac317768ec71d16354ef6cd2a9c10931c75d.1566466668.git.lorenzo@kernel.org>
 <20190822103629.GA2368@redhat.com>
 <20190822115052.GC3350@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822115052.GC3350@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Thu, 22 Aug 2019 12:38:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 22, 2019 at 01:50:52PM +0200, Lorenzo Bianconi wrote:
> > On Thu, Aug 22, 2019 at 11:49:10AM +0200, Lorenzo Bianconi wrote:
> > > Remove empty flag in mt76_txq_schedule_list and mt76_txq_send_burst
> > > since we just need retry_q length to notify mac80211 to reschedule the
> > > current tx queue
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/tx.c | 23 +++++++----------------
> > >  1 file changed, 7 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
> > > index d7982aa83c11..51d69329ed06 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/tx.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> > > @@ -378,7 +378,7 @@ EXPORT_SYMBOL_GPL(mt76_release_buffered_frames);
> > >  
> > >  static int
> > >  mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
> > > -		    struct mt76_txq *mtxq, bool *empty)
> > > +		    struct mt76_txq *mtxq)
> > >  {
> > >  	struct ieee80211_txq *txq = mtxq_to_txq(mtxq);
> > >  	enum mt76_txq_id qid = mt76_txq_get_qid(txq);
> > > @@ -392,16 +392,12 @@ mt76_txq_send_burst(struct mt76_dev *dev, struct mt76_sw_queue *sq,
> > >  	bool probe;
> > >  	int idx;
> > >  
> > > -	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags)) {
> > > -		*empty = true;
> > > +	if (test_bit(MT_WCID_FLAG_PS, &wcid->flags))
> > >  		return 0;
> > 
> > This changes behaviour for station in PS state. If retry_q is not
> > empty, now we will be rescheduling tx queue for STA in PS mode.
> > Not sure if this is problem or not, though.
> 
> good point..looking at the code it seems not a issue since we will not actually
> tx frames for PS stations. What do you think?

I do not see how changing this could possibly break things, but it 
was explicitly added by below commit, with changelog sugesting it is
needed:

commit d225581df3147060bc99e931b11f7cf2dcb1b2ca
Author: Felix Fietkau <nbd@nbd.name>
Date:   Mon Jan 21 17:33:38 2019 +0100

    mt76: avoid scheduling tx queues for powersave stations
    
    In case a tx queue wake call arrives after a client has transitioned to
    powersave, make sure that the queue is not kept active until the client
    has left powersave mode

Stanislaw
