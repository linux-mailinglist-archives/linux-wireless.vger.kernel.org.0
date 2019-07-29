Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3778C0D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2019 14:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfG2Mx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jul 2019 08:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfG2Mx5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jul 2019 08:53:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1F0C307D868;
        Mon, 29 Jul 2019 12:53:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 929EE60C44;
        Mon, 29 Jul 2019 12:53:53 +0000 (UTC)
Date:   Mon, 29 Jul 2019 14:53:51 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [RFC] mt76: fix tx hung regression on MT7630E
Message-ID: <20190729125351.GA3086@redhat.com>
References: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564143056-14610-1-git-send-email-sgruszka@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 29 Jul 2019 12:53:56 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 26, 2019 at 02:10:56PM +0200, Stanislaw Gruszka wrote:
> Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> I can observe firmware hangs on MT7630E on station mode: tx stop
> functioning after minor activity (rx keep working) and on module
> unload device fail to stop with messages:
> 
> [ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
> [ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop
> 
> Loading module again results in failure to associate with AP.
> Only machine power off / power on cycle can make device work again.
> 
> I have no idea why the commit caused F/W hangs. Most likely some proper
> fix is needed of changing registers programming (or assuring proper order
> of actions), but so far I can not came up with any better fix than
> a partial revert of 41634aa8d6db.

The difference is that with 41634aa8d6db we can run mt76x02_poll_tx()
and mt76x02_tx_tasklet() in parallel on 2 different CPUs. Without
the commit, since tasklet is not scheduled from mt76_wake_tx_queue(),
it does not happen.

I'm not quite sure why, but MT7630E does not like when we poll tx status
on 2 cpus at once. Change like below:

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 467b28379870..622251faa415 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -170,7 +170,7 @@ static int mt76x02_poll_tx(struct napi_struct *napi, int budget)
 					       mt76.tx_napi);
 	int i;
 
-	mt76x02_mac_poll_tx_status(dev, false);
+	mt76x02_mac_poll_tx_status(dev, true);
 
 	for (i = MT_TXQ_MCU; i >= 0; i--)
 		mt76_queue_tx_cleanup(dev, i, false);

is sufficient to avoid the hangs.

> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
> index 5397827668b9..fefe0ee52584 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -598,7 +598,7 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
>  	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
>  		return;
>  
> -	tasklet_schedule(&dev->tx_tasklet);
> +	mt76_txq_schedule(dev, txq->ac);

However I'm not sure if change to tasklet_schedule() is indeed correct,
since on tasklet we schedule all queues, hence queues that could
possibly be still blocked? And on mt76_wake_tx_queue() we schedule only
one queue.

Stanislaw
