Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820F88E8CB
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 12:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfHOKJm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 06:09:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbfHOKJm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 06:09:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B0DBE3082E24;
        Thu, 15 Aug 2019 10:09:41 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51142608AB;
        Thu, 15 Aug 2019 10:09:38 +0000 (UTC)
Date:   Thu, 15 Aug 2019 12:09:37 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
Message-ID: <20190815100936.GA21775@redhat.com>
References: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
 <CAJ0CqmXM4NRMYU6Lt_a4f+DXE2bVmhYrjQbgxHG0g=N+o3TeQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ0CqmXM4NRMYU6Lt_a4f+DXE2bVmhYrjQbgxHG0g=N+o3TeQw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 15 Aug 2019 10:09:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 14, 2019 at 11:50:12AM +0200, Lorenzo Bianconi wrote:
> >
> > Since 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> > I can observe firmware hangs on MT7630E on station mode: tx stop
> > functioning after minor activity (rx keep working) and on module
> > unload device fail to stop with messages:
> >
> > [ 5446.141413] mt76x0e 0000:06:00.0: TX DMA did not stop
> > [ 5449.176764] mt76x0e 0000:06:00.0: TX DMA did not stop
> >
> > Loading module again results in failure to associate with AP.
> > Only machine power off / power on cycle can make device work again.
> >
> > It's unclear why commit 41634aa8d6db causes the problem, but it is
> > related to HW encryption. Since issue is a firmware hang, that is super
> > hard to debug, just disable HW encryption as fix for the issue.
> >
> > Fixes: 41634aa8d6db ("mt76: only schedule txqs from the tx tasklet")
> > Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> > index 4585e1b756c2..6117e6ca08cb 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> > @@ -62,6 +62,19 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
> >         mt76x0e_stop_hw(dev);
> >  }
> >
> > +static int
> > +mt76x0e_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
> > +               struct ieee80211_vif *vif, struct ieee80211_sta *sta,
> > +               struct ieee80211_key_conf *key)
> > +{
> > +       struct mt76x02_dev *dev = hw->priv;
> > +
> > +       if (is_mt7630(dev))
> > +               return -EOPNOTSUPP;
> 
> Hi Stanislaw,
> 
> Can you please try if disabling/enabling the tx tasklet during hw key
> configuration fixes the issue?
> Doing something like:
> 
> tasklet_disable(tx_tasklet)
> mt76x02_set_key()
> tasklet_enable(tx_tasklet)

It does not help with the problem.

> Moreover, have you double checked if there is any performance impact
> of not using hw encryption?

I didn't observe any, but realized on this machine I have
aesni_intel encryption accelerator. After rebuild kernel without
CONFIG_CRYPTO_AES_NI_INTEL, 'perf top' showed extra 20% of cpu usage
in aes_encrypt() when sending data with HW encryption disabled.

> If so, I guess it is better to just redefine mt76_wake_tx_queue for
> mt76x0e and run mt76_txq_schedule for 7630e:
> 
> void mt76x0e_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
> {
>         if (is_mt7630(dev)) {
>             mt76_txq_schedule(dev, txq->ac);
>         } else {
>             tasklet_schedule(&dev->tx_tasklet);
>         }
> }

Not sure about reduction of lock contention for which the tx_tasklet
was introduced here, but looks ok for me as fix.
 
Stanislaw
