Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229061C7AE0
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEFUBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgEFUBe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 16:01:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE3BC061A0F
        for <linux-wireless@vger.kernel.org>; Wed,  6 May 2020 13:01:33 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jWQEU-0002mg-0L; Wed, 06 May 2020 22:01:30 +0200
Date:   Wed, 6 May 2020 22:01:29 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH 28/40] rtw88: 8723d: Add shutdown callback to disable BT
 USB suspend
Message-ID: <20200506200129.suid6lfkdwuoapzl@linutronix.de>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-29-yhchuang@realtek.com>
 <20200505141455.k2mk7tmuiujfv2sh@linutronix.de>
 <c7083dc760464c1a9017888457c1718d@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7083dc760464c1a9017888457c1718d@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-06 02:35:21 [+0000], Tony Chuang wrote:
> > On 2020-04-17 15:46:41 [+0800], yhchuang@realtek.com wrote:
> > > From: Ping-Ke Shih <pkshih@realtek.com>
> > >
> > > Without this patch, wifi card can't initialize properly due to BT in USB
> > > suspend state. So, we disable BT USB suspend (wakeup) in shutdown callback
> > > that is the moment before rebooting. To save BT USB power, we can't do this
> > > in 'remove' callback.
> > 
> > So you can't initialize the USB part because it is in suspend and the
> > only way to avoid it to disable it on the PCI side. That means you don't
> > see it enumerated on the USB bus at all?
> 
> Yes, if we don't disable it on PCI side, then the USB part cannot be
> probed on USB bus.

We talk here about USB's runtime-suspend / autosuspend? If so, are you
aware of commit
  7ecacafc24063 ("Bluetooth: btusb: Disable runtime suspend on Realtek devices")

or is this an attempt to get rid of this change in favour of this one
(so that the device can enter suspend-mode)?

Sebastian
