Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF271C5F3D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgEERtv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 13:49:51 -0400
Received: from ns.iliad.fr ([212.27.33.1]:44778 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbgEERtv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 13:49:51 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id B4559215B5;
        Tue,  5 May 2020 19:49:48 +0200 (CEST)
Received: from sakura (freebox.vlq16.iliad.fr [213.36.7.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ns.iliad.fr (Postfix) with ESMTPS id A70952156D;
        Tue,  5 May 2020 19:49:48 +0200 (CEST)
Date:   Tue, 5 May 2020 19:49:47 +0200
From:   Maxime Bizon <mbizon@freebox.fr>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: Regarding .wake_tx_queue() model
Message-ID: <20200505174947.GB2079@sakura>
References: <20200504193959.GC26805@sakura>
 <878si6oabp.fsf@toke.dk>
 <20200505131531.GA32619@sakura>
 <87368eo5dn.fsf@toke.dk>
 <20200505152010.GA33304@sakura>
 <87pnbimil6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnbimil6.fsf@toke.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue May  5 19:49:48 2020 +0200 (CEST)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On Tuesday 05 May 2020 à 18:50:45 (+0200), Toke Høiland-Jørgensen wrote:

> This seems like a bad idea; we want the TXQ mechanism to decide which
> frame to send on wakeup.

.release_buffered_frames() is only needed/used if STA went into
powersave while packets were already sitting inside txqi, that's an
edge case.

In the other much more common case (STA went into sleep without any
traffic pending in txqi), then the "classic" ps delivery code is used:
frames gets pulled from ps_tx_buf queue (1 by 1 for ps poll, more for
uapsd), and those frames ends up being sent through drv_tx(), since
they have the flag IEEE80211_TX_CTRL_PS_RESPONSE so they bypass txqi.

so I was just looking at removing that edge case, sending those frames
back to ps_tx_buf() from the driver.


> really is no way around having a way to instruct the driver "please use
> these flags for the next N frames you send" - which is what
> release_buffered_frames() does. What you're suggesting is basically
> turning off this 'pull mode' for the frames buffered during PS and have
> mac80211 revert to push mode for those, right? But then you lose the
> benefits of pull mode (the TXQs) for those frames.

I just want to give those back to mac80211, those frames were already
in push mode anyway.

> I remember Johannes talking about a 'shim layer' between the mac80211
> TXQs and the 'drv_tx()' hook as a way to bring the benefits of the TXQs
> to the 'long tail' of simple drivers that don't do any internal
> buffering anyway, without having to change the drivers to use 'pull
> mode'. Am I wrong in thinking that mwl8k may be a good candidate for
> such a layer? From glancing through the existing driver it looks like
> it's mostly just taking each frame, wrapping it in a HW descriptor, and
> sticking it on a TX ring?

maybe with the current firmware interface, but with the new one
aggregation is done on host side, so tx path is no more that simple.

-- 
Maxime
