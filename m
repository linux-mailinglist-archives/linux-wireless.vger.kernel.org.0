Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295E0C31DA
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 12:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfJAK4a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 06:56:30 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59666 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJAK4a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 06:56:30 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFFpU-0005wU-Oj; Tue, 01 Oct 2019 12:56:28 +0200
Message-ID: <bb98e67fd47effce9eada17bdf24a9d0b7102f31.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: keep BHs disabled while calling
 drv_tx_wake_queue()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        linux-wireless@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>, Aaron Hill <aa1ronham@gmail.com>,
        Lukas Redlinger <rel+kernel@agilox.net>,
        Oleksii Shevchuk <alxchk@gmail.com>
Date:   Tue, 01 Oct 2019 12:56:27 +0200
In-Reply-To: <87blv0visz.fsf@toke.dk>
References: <1569924485-I3e8838c5ecad878e59d4a94eb069a90f6641461a@changeid>
         <87blv0visz.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-10-01 at 12:53 +0200, Toke Høiland-Jørgensen wrote:
> 
> > -			spin_unlock_bh(&fq->lock);
> > +			spin_unlock(&fq->lock);
> >  			drv_wake_tx_queue(local, txqi);
> > -			spin_lock_bh(&fq->lock);
> > +			spin_lock(&fq->lock);
> 
> Okay, so this will mean that the drv_wake_tx_queue() entry point will be
> called with bhs disabled.

Right.

>  But there are lots of uses of
> spin_{,un}lock_bh() in tx.c:

[snip]

> so won't that mean that the driver still gets bhs re-enabled after (for
> instance) the first call to ieee80211_tx_dequeue()?

No, local_bh_disable()/local_bh_enable() is re-entrant and nests fine.

johannes

