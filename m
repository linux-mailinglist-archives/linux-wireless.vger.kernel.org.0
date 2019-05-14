Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2853F1C503
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 10:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfENIdH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 04:33:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39722 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfENIdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 04:33:07 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hQSrt-0004y8-U3; Tue, 14 May 2019 10:33:02 +0200
Message-ID: <9c8492a1f5dbe3a8d743a40b6788a1a21d6b977f.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix possible deadlock in TX path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>, davem@davemloft.net,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Date:   Tue, 14 May 2019 10:33:00 +0200
In-Reply-To: <20190427204155.14211-1-erik.stromdahl@gmail.com> (sfid-20190427_224204_178829_B91A7E8B)
References: <20190427204155.14211-1-erik.stromdahl@gmail.com>
         (sfid-20190427_224204_178829_B91A7E8B)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-04-27 at 22:41 +0200, Erik Stromdahl wrote:
> This patch fixes a possible deadlock when updating the TX statistics
> (when calling into ieee80211_tx_stats()) from ieee80211_tx_dequeue().
> 
> ieee80211_tx_dequeue() might be called from process context.

I think this really is the problem.

> [<c0cb1864>] (ieee80211_xmit_fast_finish) from [<c0cb4504>] (ieee80211_tx_dequeue+0x30c/0xb9c)
>  r10:d2f1a900 r9:d2d607a4 r8:d2cf20dc r7:d330b29c r6:d2cf2000 r5:d2c342ba
>  r4:d2899d3c
> [<c0cb41f8>] (ieee80211_tx_dequeue) from [<bf057f64>] (ath10k_mac_tx_push_txq+0x78/0x2a4 [ath10k_core])
>  r10:d2d607cc r9:d2fe06a0 r8:00000000 r7:d2fe1e30 r6:d2fe1d38 r5:d2fe1540
>  r4:d2cf20dc
> [<bf057eec>] (ath10k_mac_tx_push_txq [ath10k_core]) from [<bf058364>] (ath10k_mac_tx_push_pending+0x1d4/0x2e0 [ath10k_core])
>  r10:d2cf20dc r9:bf0582b4 r8:bf0b1dba r7:00000002 r6:c1429994 r5:00000000
>  r4:d2fe06a0
> [<bf058190>] (ath10k_mac_tx_push_pending [ath10k_core]) from [<bf0e25a4>] (ath10k_sdio_irq_handler+0x30c/0x4d8 [ath10k_sdio])
>  r10:00005b5a r9:d2fcc040 r8:00180201 r7:d2fe6540 r6:d2fe6a7c r5:00000000
>  r4:d2fe1540

It seems to be entirely ath10k's fault, and quite possibly our
documentation, but we probably should have local_bh_disable() there
rather than try to do u64_stats_update_begin_irqsave() in some path that
really doesn't need it.

This is going to be whack-a-mole otherwise - the TX path in mac80211
really expects to not be interrupted by softirqs.

johannes

