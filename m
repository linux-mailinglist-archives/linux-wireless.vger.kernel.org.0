Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644BDD7A10
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2019 17:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731433AbfJOPm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Oct 2019 11:42:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731230AbfJOPmz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Oct 2019 11:42:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 95144801681;
        Tue, 15 Oct 2019 15:42:55 +0000 (UTC)
Received: from localhost (ovpn-204-54.brq.redhat.com [10.40.204.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C9AF19C58;
        Tue, 15 Oct 2019 15:42:52 +0000 (UTC)
Date:   Tue, 15 Oct 2019 17:42:51 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] mt76: refactor cc_lock locking scheme
Message-ID: <20191015154250.GA18262@redhat.com>
References: <252d75b5139a7acb4bdc28c8131e408c2483d8ac.1571151935.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252d75b5139a7acb4bdc28c8131e408c2483d8ac.1571151935.git.lorenzo@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 15 Oct 2019 15:42:55 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 15, 2019 at 05:16:43PM +0200, Lorenzo Bianconi wrote:
> Read busy counters not holding cc_lock spinlock since usb read can't be
> performed in interrupt context. Move cc_active and cc_rx counters out of
> cc_lock since they are not modified in interrupt context.
> Grab cc_lock updating cur_cc_bss_rx in mt76_airtime_report and do not
> hold rx_lock in mt76_update_survey.
<snip>
> Fixes: 168aea24f4bb ("mt76: mt76x02u: enable survey support")

I think problem was introduced currently in mt76 driver version
that is not yet in mainline tree, so this is not right commit.
On Linus' tree we still read registers outside of cc_lock section.

void mt76x02_update_channel(struct mt76_dev *mdev)
{
	...

        busy = mt76_rr(dev, MT_CH_BUSY);
        active = busy + mt76_rr(dev, MT_CH_IDLE);

        spin_lock_bh(&dev->mt76.cc_lock);
        state->cc_busy += busy;
        state->cc_active += active;
        spin_unlock_bh(&dev->mt76.cc_lock);
}

>  	if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME) {
> -		spin_lock_bh(&dev->rx_lock);
> -		spin_lock(&dev->cc_lock);
> +		spin_lock_bh(&dev->cc_lock);
>  		state->cc_bss_rx += dev->cur_cc_bss_rx;
>  		dev->cur_cc_bss_rx = 0;
> -		spin_unlock(&dev->cc_lock);
> -		spin_unlock_bh(&dev->rx_lock);
> +		spin_unlock_bh(&dev->cc_lock);

Why dev->rx_lock was needed before and is not needed now ?

Stanislaw
