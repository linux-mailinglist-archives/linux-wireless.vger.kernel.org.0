Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B88210515
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2020 09:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgGAHdJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jul 2020 03:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgGAHdJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jul 2020 03:33:09 -0400
Received: from rhcavuit02.kulnet.kuleuven.be (rhcavuit02.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247E1C061755
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2020 00:33:09 -0700 (PDT)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: C9718120346.A005C
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id C9718120346
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2020 09:33:01 +0200 (CEST)
Received: from mathy-work.localhost (unknown [176.205.50.14])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 0F174200A1;
        Wed,  1 Jul 2020 09:33:00 +0200 (CEST)
Date:   Wed, 1 Jul 2020 11:32:57 +0400
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] mac80211: keep non-zero sequence counter of injected
 frames
Message-ID: <20200701113257.28af0012@mathy-work.localhost>
In-Reply-To: <a814fe75135815e85a1968cf6a985c604246bcc8.camel@sipsolutions.net>
References: <20200628220512.28535ebc@mathy-work.localhost>
        <a814fe75135815e85a1968cf6a985c604246bcc8.camel@sipsolutions.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The kernel test robot highlighted a bug in the patch. So for now do not
apply this one.

I'm currently testing the injection behavior of some new devices I
have, since my current ones are getting old, and I'll send updated
patches within a week or two if all goes well.

On Sun, 28 Jun 2020 20:59:56 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Sun, 2020-06-28 at 22:05 +0400, Mathy Vanhoef wrote:
> > The sequence number of injected frames is being overwritten by the
> > function ieee80211_tx_h_sequence when the following two conditions
> > are met:
> > 
> > 1. The frame is injected on a virtual interface, and a second
> > virtual interface on this device is operating in managed/AP/.. mode.
> > 
> > 2. The sender MAC address of the injected frame matches the MAC
> >    address of the second interface operating in managed/AP/.. mode.
> > 
> > In some cases this may be desired, for instance when hostap is
> > configured to send certain frames using a monitor interface, in
> > which case the user-space will not assign a sequence number and
> > instead injects frames with a sequence number of zero.  
> 
> Yeah, this is where that used to be used. I'm thinking we should
> "break" this stuff eventually, tell people to use modern hostapd
> versions, and see who cares ... because all this "cooked monitor"
> etc. is all quite ugly.
> 
> > However, in case the user-space does assign a non-zero sequence
> > number, this number should not be overwritten by the kernel. This
> > patch adds a check to see if injected frames have already been
> > assigned a non-zero sequence number, and if so, this sequence
> > number will not be overwritten by the kernel.  
> 
> Seems reasonable, but I have to wonder what you're up to now ;-)
> 
> Anyway, I'll apply this unless I find some tests fail or something,
> but I'll be going on vacation soon, so it'll be a while (since it's
> for the -next tree as a feature).
> 
> johannes
> 

