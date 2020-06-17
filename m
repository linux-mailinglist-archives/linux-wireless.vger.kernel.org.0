Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE41FC768
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 09:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQH3q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQH3p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 03:29:45 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42879C061573
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2020 00:29:45 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jlSVu-0003WR-Hl; Wed, 17 Jun 2020 09:29:38 +0200
Date:   Wed, 17 Jun 2020 09:29:38 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tony Chuang <yhchuang@realtek.com>
Cc:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>,
        "kernel@iuliancostan.com" <kernel@iuliancostan.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "i@outv.im" <i@outv.im>,
        "trevor@shartrec.com" <trevor@shartrec.com>
Subject: Re: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with
 module parameter
Message-ID: <20200617072938.dx56qsvcrpmtrrgu@linutronix.de>
References: <20200605074703.32726-1-yhchuang@realtek.com>
 <20200610213720.3sopcuimas375xl2@linutronix.de>
 <a2aac609b5e2416b899c5842817da4bb@realtek.com>
 <20200616133531.7eyfu6jniywhak7h@linutronix.de>
 <fbf8d9cb6b864004b11372f6d70b734b@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbf8d9cb6b864004b11372f6d70b734b@realtek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-06-17 05:30:22 [+0000], Tony Chuang wrote:
> 0000], Tony Chuang wrote:
> > > > On 2020-06-05 15:47:03 [+0800], yhchuang@realtek.com wrote:
> > > > > From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> > > > >
> > > > > Some platforms cannot read the DBI register successfully for the
> > > > > ASPM settings. After the read failed, the bus could be unstable,
> > > > > and the device just became unavailable [1]. For those platforms,
> > > > > the ASPM should be disabled. But as the ASPM can help the driver
> > > > > to save the power consumption in power save mode, the ASPM is still
> > > > > needed. So, add a module parameter for them to disable it, then
> > > > > the device can still work, while others can benefit from the less
> > > > > power consumption that brings by ASPM enabled.
> > > >
> > > > Can you set disable_aspm if rtw_dbi_read8() fails? Or make a test if it
> > > > is save to use?
> > > >
> > > > If someone notices the warning they still have to search for the warning
> > > > in order to make the link towards loading the module with the
> > > > disable_aspm=1 paramter.
> > > > Is it known what causes the failure?
> > > >
> > >
> > > I think as long as the rtw_dbi_read() fails, the consequent register
> > > operation will also fail, and still get an error read/write the register.
> > > And this is some sort of PCI issue, and I am not really familiar with it.
> > > Such as the root cause or how it fails.
> > 
> > Then it does not sound safe to enable it by default.
> 
> We have had a discussion about this, but I cannot find the thread now.
> People suggested that the module parameter should not be used.
> And they think that if the ASPM can help for power consumption, then
> it should be default enabled. But I think it should be based on that the
> other platforms will not just fail to bring up the device. However, the
> platforms are less than the others, not sure if default enable or disable
> is better.

What I fail to understand is if this error affects other PCI devices as
well or just this one. And if it is possible to reset the wifi device
and everything gets back no normal. Or is it just the register reading,
that spams the log and would affect the system otherwise if you would
just avoided after the first fail.

> > > If we can default disable it, then we can help those platforms, but
> > > then other platform will suffer from higher power consumption.
> > 
> > So for those platform, where the error occurs, you expect that the user
> > manages to read the error message (a backtrace from rtw_dbi_read8()) and
> > connects this the need to set a certain module option.
> 
> Yes, we can discuss if it should be default enabled or not. Otherwise the
> people with those platforms can only do that to prevent this. Really bad.

It would be good to know the root cause of this. So then default enable
would depend on it.
You could have a allow/forbid list based on DMI once you identified
good/bad systems but this includes additional maintenance.

I think that at the very least, if the read fails you should give the
user additional information how to stop this from happening again. And
either stop issuing the commands again or skip driver loading (depending
what it means for device stability).

> Yen-Hsuan

Sebastian
