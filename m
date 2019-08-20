Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B21C995D35
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfHTLYp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 07:24:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbfHTLYo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 07:24:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0C8B301E13E;
        Tue, 20 Aug 2019 11:24:44 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB745100195C;
        Tue, 20 Aug 2019 11:24:41 +0000 (UTC)
Date:   Tue, 20 Aug 2019 13:24:39 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
Message-ID: <20190820112438.GA2227@redhat.com>
References: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
 <CAJ0CqmXM4NRMYU6Lt_a4f+DXE2bVmhYrjQbgxHG0g=N+o3TeQw@mail.gmail.com>
 <20190815100936.GA21775@redhat.com>
 <727fd528-16c1-e3b3-e1a9-2edbcbdddee7@nbd.name>
 <20190819110639.GA6037@redhat.com>
 <7b46ab63-d69d-f389-b3c2-245cbe11c7b7@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b46ab63-d69d-f389-b3c2-245cbe11c7b7@nbd.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 20 Aug 2019 11:24:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 20, 2019 at 12:31:56PM +0200, Felix Fietkau wrote:
> >> >> void mt76x0e_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
> >> >> {
> >> >>         if (is_mt7630(dev)) {
> >> >>             mt76_txq_schedule(dev, txq->ac);
> >> >>         } else {
> >> >>             tasklet_schedule(&dev->tx_tasklet);
> >> >>         }
> >> >> }
> >> > 
> >> > Not sure about reduction of lock contention for which the tx_tasklet
> >> > was introduced here, but looks ok for me as fix.
> >> I think if we work around the bug like this, it can easily come back to
> >> bite us again later. 
> > 
> > I'm not into workarounds any kind, but this is really strange issue,
> > maybe FW bug that triggers just by slightly different driver behaviour.
> > 
> >> I don't see any logical explanation as to how this
> >> makes a difference with hardware encryption.
> >> Also, I think it would be helpful to figure out what key operation (if
> >> any) triggers this, adding or removing keys.
> > 
> > Seems not to be related with set_key operation at all. We set 2 HW
> > keys at the beginning and hang happen after some tx/rx traffic
> > without any re-keyring.
> > 
> > I'm not sure why disabling HW encryption helps. Maybe it is due to
> > ordering or timing. With SW encryption we spend more time in mac80211
> > before pass skb's to the driver. Or maybe we just mix some HW keys 
> > and SW (group) keys in way that FW does not like.
> > 
> >> Maybe it could also help if we change the order in which the WCID table
> >> entries are updated, i.e. changing MT_WCID_ATTR first when removing keys.
> >> 
> >> Maybe temporarily clearing MT_MAC_SYS_CTRL_ENABLE_TX before the key
> >> update and setting it again afterwards could also help.
> > 
> > I tested below patch and it did not help.
> Can you test if disabling hw encryption only for shared or only for
> pairwise keys makes any difference?

Disabling only pairwise keys helps. Disabling only shared keys does
not help.

Not sure if this will be helpful information or make things more
confusing, but seems the difference between mt76_txq_schedule()
and tasklet_schedule() in mt76_wake_tx_queue() is that on 
mt76_txq_schedule() some tx packets are serialized by dev->rx_lock
(because some ARP and TCP packets are sent via network stack as response
of incoming packet within ieee80211_rx_napi() call). Removing
spin_lock(&dev->rx_lock) in mt76_rx_complete() make the problem
reproducible again with mt76_txq_schedule() & HW encryption.

Stanislaw
