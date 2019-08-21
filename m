Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFA7977D9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 13:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfHULWv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 07:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfHULWu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 07:22:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 861C689F38E;
        Wed, 21 Aug 2019 11:22:50 +0000 (UTC)
Received: from localhost (unknown [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CA4D1001925;
        Wed, 21 Aug 2019 11:22:47 +0000 (UTC)
Date:   Wed, 21 Aug 2019 13:22:46 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
Message-ID: <20190821112244.GA23546@redhat.com>
References: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
 <CAJ0CqmXM4NRMYU6Lt_a4f+DXE2bVmhYrjQbgxHG0g=N+o3TeQw@mail.gmail.com>
 <20190815100936.GA21775@redhat.com>
 <727fd528-16c1-e3b3-e1a9-2edbcbdddee7@nbd.name>
 <20190819110639.GA6037@redhat.com>
 <7b46ab63-d69d-f389-b3c2-245cbe11c7b7@nbd.name>
 <20190820112438.GA2227@redhat.com>
 <20190821084724.GB20223@redhat.com>
 <433c1d1f-3590-375f-ed8d-c9de2af873d5@nbd.name>
 <876a4137-ecd5-2e6c-0c75-87eae895e672@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876a4137-ecd5-2e6c-0c75-87eae895e672@nbd.name>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 21 Aug 2019 11:22:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Aug 21, 2019 at 12:40:14PM +0200, Felix Fietkau wrote:
> On 2019-08-21 11:03, Felix Fietkau wrote:
> > On 2019-08-21 10:47, Stanislaw Gruszka wrote:
> >> On Tue, Aug 20, 2019 at 01:24:39PM +0200, Stanislaw Gruszka wrote:
> >>> > Can you test if disabling hw encryption only for shared or only for
> >>> > pairwise keys makes any difference?
> >>> 
> >>> Disabling only pairwise keys helps. Disabling only shared keys does
> >>> not help.
> >>> 
> >>> Not sure if this will be helpful information or make things more
> >>> confusing, but seems the difference between mt76_txq_schedule()
> >>> and tasklet_schedule() in mt76_wake_tx_queue() is that on 
> >>> mt76_txq_schedule() some tx packets are serialized by dev->rx_lock
> >>> (because some ARP and TCP packets are sent via network stack as response
> >>> of incoming packet within ieee80211_rx_napi() call). Removing
> >>> spin_lock(&dev->rx_lock) in mt76_rx_complete() make the problem
> >>> reproducible again with mt76_txq_schedule() & HW encryption.
> >> 
> >> So, I think this is FW/HW issue related with encryption and ordering
> >> and we should apply patch originally posted in this thread that
> >> disable HW encryption for MT7630E.
> >> 
> >> I do not think we should disable HW encryption only for pairwise keys,
> >> because FW/HW can have the same bug for shared keys, but is not
> >> triggered in my test, as we do not sent lot of group frames.
> > I'm still not convinced that this is just the hardware implementation of
> > hw crypto being faulty. I think it's more likely that there's a bug in
> > the tx path somewhere, which causes hangs on MT7630E but remains hidden
> > (or at least recoverable) on other devices.
> > I'm currently reviewing key handling in the mac80211 fast-xmit codepath
> > and get the feeling that something might be racy there.
> > I will let you know when I make some progress with that review.
> > If we can't find the bug soon, then I'm fine with merging this patch.
> > Right now, I would like to see first if we can fix it properly.
> Another question: Does a watchdog restart happen before tx fails?

No, we do not run wdt_work for mt76x0e.

Stanislaw
