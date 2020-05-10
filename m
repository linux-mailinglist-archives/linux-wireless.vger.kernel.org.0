Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0621CCE4C
	for <lists+linux-wireless@lfdr.de>; Sun, 10 May 2020 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgEJVyR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 May 2020 17:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727771AbgEJVyR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 May 2020 17:54:17 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49DDC061A0C
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2020 14:54:16 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jXttl-0007SF-V9; Sun, 10 May 2020 23:54:14 +0200
Date:   Sun, 10 May 2020 23:54:13 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        Pkshih <pkshih@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        Kevin Yang <kevin_yang@realtek.com>
Subject: Re: [PATCH 28/40] rtw88: 8723d: Add shutdown callback to disable BT
 USB suspend
Message-ID: <20200510215413.zyeq74pwhw4zw4mt@linutronix.de>
References: <20200417074653.15591-1-yhchuang@realtek.com>
 <20200417074653.15591-29-yhchuang@realtek.com>
 <20200505141455.k2mk7tmuiujfv2sh@linutronix.de>
 <c7083dc760464c1a9017888457c1718d@realtek.com>
 <20200506200129.suid6lfkdwuoapzl@linutronix.de>
 <2ee629b3bb374532b0830a39b57c2389@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ee629b3bb374532b0830a39b57c2389@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-05-07 04:26:24 [+0000], Tony Chuang wrote:
> 
> Ping-Ke, can you please help to check on this ?
> Looks like Kai-Heng is doing the much same thing here.
> 
> But it's still worth to do it in wifi side I think, because it's difficult to
> make sure the synchronization of BT and Wifi patch.

Yes. It sounds reasonable to remove the patch in BT so the device is not
always avoiding the suspend mode.

I don't remember if I asked this: Shouldn't the USB reset get the device
out of suspend? I thought this is part of the USB test. Could this be
fixed in BT's firmware?

> Yen-Hsuan

Sebastian
