Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05E287BB69
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfGaIUF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 04:20:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfGaIUF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 04:20:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE61D308FBB1;
        Wed, 31 Jul 2019 08:20:04 +0000 (UTC)
Received: from localhost (unknown [10.40.205.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E8CA60605;
        Wed, 31 Jul 2019 08:19:59 +0000 (UTC)
Date:   Wed, 31 Jul 2019 10:19:58 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190731081957.GA4096@redhat.com>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
 <20190729125351.GA3086@redhat.com>
 <20190729140241.GC4030@localhost.localdomain>
 <20190730135450.GA2361@redhat.com>
 <20190730145531.GA3813@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730145531.GA3813@localhost.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 31 Jul 2019 08:20:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Jul 30, 2019 at 04:55:31PM +0200, Lorenzo Bianconi wrote:
> > > > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > index 467b28379870..622251faa415 100644
> > > > --- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
> > > > @@ -170,7 +170,7 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
> > > >  					       mt76.tx_napi);
> > > >  	int i;
> > > >  
> > > > -	mt76x02_mac_poll_tx_status(dev, false);
> > > > +	mt76x02_mac_poll_tx_status(dev, true);
> > > 
> > > I am not sure if we really need mt76x02_mac_poll_tx_status() here since we run
> > > it in mt76x02_tx_complete_skb() and in mt76x02_tx_tasklet(). Anyway the only
> > > difference doing so is we do not run mt76x02_send_tx_status().
> > 
> > I thought this is the problem, but it was my mistake during testing.
> > I tested the above change together with mt76_txq_schedule(dev, txq->ac)
> > change and get wrong impression it fixes the issue. But above change
> > alone does not help.
> > 
> > I tried to add some locking to avoid parallel execution of mt76x02_poll_tx()
> > and mt76x02_tx_tasklet(), but it didn't help either. So far only patch
> > originally posted here make the problem gone.
> 
> so, in order to be on the same page, if you comment out mt76x02_mac_poll_tx_status()
> in mt76x02_poll_tx() the issue will still occur. The only to 'fix' it is to run
> mt76_txq_schedule_all() in mt76x02_poll_tx(), right?

Yes.

Stanislaw
