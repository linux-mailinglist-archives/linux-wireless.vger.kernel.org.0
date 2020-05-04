Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116331C4735
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 21:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgEDTpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 15:45:20 -0400
Received: from ns.iliad.fr ([212.27.33.1]:38952 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgEDTpU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 15:45:20 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2020 15:45:19 EDT
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 0E69A20A52
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 21:40:01 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ns.iliad.fr (Postfix) with ESMTPS id 015442092E
        for <linux-wireless@vger.kernel.org>; Mon,  4 May 2020 21:40:01 +0200 (CEST)
Date:   Mon, 4 May 2020 21:39:59 +0200
From:   Maxime Bizon <mbizon@freebox.fr>
To:     linux-wireless@vger.kernel.org
Subject: Regarding .wake_tx_queue() model
Message-ID: <20200504193959.GC26805@sakura>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon May  4 21:40:01 2020 +0200 (CEST)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hello,

Currently switching a driver to .wake_tx_queue() model, and I would
appreciate some guidance over a couple of issues.

My hardware exposes 1 FIFO per ac, so the current driver basically
queue skb in the correct fifo from drv_tx(), and once a FIFO is big
"enough" (packet count or total duration), I use
ieee80211_stop_queue(), and the corresponding ieee80211_wait_queue()
in tx completion.

Current driver TX flow is:
 - drv_tx() => push into FIFO
 - drv_tx() => push into FIFO
 - drv_tx() => push into FIFO => FIFO full => ieee80211_stop_queue()
 - [drv_tx won't be called]
 - tx completion event => ieee80211_wake_queue()
 - drv_tx()
 [...]


1) drv_tx() & drv_wake_tx_queue() concurrency

With the .wake_tx_queue model, there are now two entry points in the
driver, how does the stack ensure that drv_tx() is not blocked forever
if there is concurrent traffic on the same AC ?

for example:

 - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
 - tx completion event => ieee80211_wake_queue()
 - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
 - tx completion event => ieee80211_wake_queue()
 - [...]

ieee80211_wake_queue() will schedule both tx_pending_tasklet and
wake_txqs_tasklet, but I don't think there is any guarantee in the
call ordering.

Is it the driver's duty to leave a bit of room during
drv_wake_tx_queue() scheduling and not stop the queues from there ?


2) ieee80211_stop_queue() vs drv_wake_tx_queue()

Commit 21a5d4c3a45ca608477a083096cfbce76e449a0c made it so that
ieee80211_tx_dequeue() will return nothing if hardware queue is
stopped, but drv_wake_tx_queue() is still called for ac whose queue is
stopped.


so should I do this ?

 - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
 - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => NULL => return
 - tx completion event => ieee80211_wake_queue()
 - .wake_tx_queue() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
 - [...]

or this ?

 - .wake_tx_queue() => ieee80211_queue_stopped() => ieee80211_next_txq() => ieee80211_tx_dequeue() => FIFO now full => ieee80211_stop_queue()
 - .wake_tx_queue() => ieee80211_queue_stopped() => return

associated commit log only mentions edge cases (channel switch, DFS),
so I'm not sure if ieee80211_stop_queue() for txqs was intended for
"fast path", also see 3)


3) _ieee80211_wake_txqs() looks buggy:

If the cab_queue is not stopped, this loop will unconditionally wake
up all txqs, which I guess is not what was intended:

        for (i = 0; i < local->hw.queues; i++) {
                if (local->queue_stop_reasons[i])
                        continue;

                        for (ac = 0; ac < n_acs; ac++) {
                                int ac_queue = sdata->vif.hw_queue[ac];

                                if (ac_queue == i ||
                                    sdata->vif.cab_queue == i)
                                        __ieee80211_wake_txqs(sdata, ac);
                        }


4) building aggregation in the driver:

I'm doing aggregation on the host side rather than in the firmware,
which will ends up with more or less the same code as ath9k, is there
any on-going effort to move that code from the driver into the stack ?

Thanks,

-- 
Maxime
