Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43499ACFF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 12:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390347AbfHWKUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 06:20:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733285AbfHWKUk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 06:20:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC49A7F74C;
        Fri, 23 Aug 2019 10:20:40 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2AF461785;
        Fri, 23 Aug 2019 10:20:37 +0000 (UTC)
Date:   Fri, 23 Aug 2019 12:20:37 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH 1/3] mt76: remove redundant mt76_txq_schedule_all
Message-ID: <20190823102036.GA6523@redhat.com>
References: <1566550337-6287-1-git-send-email-sgruszka@redhat.com>
 <1566550337-6287-2-git-send-email-sgruszka@redhat.com>
 <a7ba0815-5e5c-c88f-c07c-c7d2a6a0714d@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ba0815-5e5c-c88f-c07c-c7d2a6a0714d@nbd.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Fri, 23 Aug 2019 10:20:40 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Aug 23, 2019 at 11:27:41AM +0200, Felix Fietkau wrote:
> On 2019-08-23 10:52, Stanislaw Gruszka wrote:
> > Waking tx queues will cause that txq's will be scheduled. Calling
> > mt76_txq_schedule_all() while queues are blocked is not necessary.
> > We will not get any skb's from ieee80211_tx_dequeue() anyway, but
> > patch changes that transmit of mtxq->retry_q skb's will be a bit
> > deferred (on the moment after channel switch or other situation
> > when we wake up queues).
> > 
> > Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Waking tx queues will not always cause txqs to be scheduled - only if an
> attempt to dequeue was blocked because queues were stopped at that time.
> Because of that, I don't think this patch is correct.

Ok, please drop it.

Stanislaw
