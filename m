Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFD36C59C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 13:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237505AbhD0Lvj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 07:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235570AbhD0Lvi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 07:51:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94B9A613E5;
        Tue, 27 Apr 2021 11:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524255;
        bh=U+XMIP+ThaYX6azhRBFTHR13AT1gGRFQ8ZDW2B48MJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/wRLXoClzo3qTvcMHewSEIrGQr7NG/if7bhHb8o4GGetGh2TvGm5XEx9UAEZWmvy
         isigkikmRYe8iCbrFNBxamfWLOg8czXlqHYNMoBMeT6DHLVnf89OGogDWyHon2FON4
         Ib2bSfnYx+A7IsKm8BWREAdq2/EjzRHjzjqlSKVM=
Date:   Tue, 27 Apr 2021 13:50:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Gopinathan <atulgopinathan@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>, brookebasile@gmail.com,
        ath9k-devel@qca.qualcomm.com, davem@davemloft.net, kuba@kernel.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: Memory leak in ath9k_hif_usb_dealloc_tx_urbs()
Message-ID: <YIf6nRsboFTB9H3M@kroah.com>
References: <20200911071427.32354-1-brookebasile@gmail.com>
 <20210330193652.10642-1-paskripkin@gmail.com>
 <YGQWf1lP4ZOUFiG5@kroah.com>
 <20210427113559.GA7527@atulu-nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427113559.GA7527@atulu-nitro>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 27, 2021 at 05:05:59PM +0530, Atul Gopinathan wrote:
> On Wed, Mar 31, 2021 at 08:28:15AM +0200, Greg KH wrote:
> > On Tue, Mar 30, 2021 at 10:36:52PM +0300, Pavel Skripkin wrote:
> > > Hi!
> > > 
> > > I did some debugging on this
> > > https://syzkaller.appspot.com/bug?id=3ea507fb3c47426497b52bd82b8ef0dd5b6cc7ee
> > > and, I believe, I recognized the problem. The problem appears in case of
> > > ath9k_htc_hw_init() fail. In case of this fail all tx_buf->urb krefs will be
> > > initialized to 1, but in free function:
> > > 
> > > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
> > > 
> > > ....
> > > 
> > > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
> > > {
> > >     ...
> > > 	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
> > > 				 &hif_dev->tx.tx_buf, list) {
> > > 		usb_get_urb(tx_buf->urb);
> > > 		...
> > > 		usb_free_urb(tx_buf->urb);
> > > 		...
> > > 		}
> > > 
> > > Krefs are incremented and then decremented, that means urbs won't be freed.
> > > I found your patch and I can't properly understand why You added usb_get_urb(tx_buf->urb).
> > > Can You explain please, I believe this will help me or somebody to fix this ussue :)
> > 
> > I think almost everyone who has looked into this has given up due to the
> > mess of twisty-passages here with almost no real-world benefits for
> > unwinding them :)
> 
> Just wanted to confirm, what is the status of this bug then, as in is it
> invalid (not sure if that's the correct word)? I happened to stumble
> across the same syzkaller bug report Pavel posted above, in the morning.
> Saw that there has been no patch tests/fixes on this yet according to
> syzkaller. Spent a couple of hours going through it before sending a
> test patch to syzbot which returned an "OK" (and the patch is exactly
> what Pavel pointed out, I simply removed the `usb_get_urb()`). Before
> sending anything to the mailing list, I made sure to search all the
> relavant networking lists to see if this topic had been brought up (learnt
> to do this from my preious mistakes of sending already accepted patches) and
> luckily I found this.
> 
> Syzbot has had 380 crashes caused by this bug, with the latest being
> today. So I wanted to confirm what should be done be about this bug. 

If you think you can fix it, wonderful, go ahead please!

greg k-h
