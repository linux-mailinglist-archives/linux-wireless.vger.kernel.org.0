Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366C21544AD
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2020 14:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgBFNO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Feb 2020 08:14:58 -0500
Received: from mail.monom.org ([188.138.9.77]:53710 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbgBFNO6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Feb 2020 08:14:58 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 9A14E5004AE;
        Thu,  6 Feb 2020 14:14:55 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id 4ADAC500294;
        Thu,  6 Feb 2020 14:14:55 +0100 (CET)
Date:   Thu, 6 Feb 2020 14:14:55 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     JH <jupiter.hce@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
Subject: Re: Failed to can wifi Invalid Sched_scan parameters
Message-ID: <20200206131455.knx2nsitunrfo4nu@beryllium.lan>
References: <CAA=hcWQuz9QTvbRJgFXBbYrB9RBmWajCJ=oD49DyEaLw91t2bQ@mail.gmail.com>
 <20200204081435.zhzqtsnrcgkzhpdw@beryllium.lan>
 <CAA=hcWQ780vCx8KkNPqgmtbzxqZbrGnZx6zghr0PAwhG3o4hng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWQ780vCx8KkNPqgmtbzxqZbrGnZx6zghr0PAwhG3o4hng@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Feb 06, 2020 at 10:08:16PM +1100, JH wrote:
> On 2/4/20, Daniel Wagner <wagi@monom.org> wrote:
> > The 'Invalid Sched_scan parameters' indicates, wpa_supplicant is
> > providing the wrong parameters. Best thing is to monitor between
> > wpa_supplicant and kernel the netlink messages. iwmon is an excellent
> > tool for this.
> 
> Thanks for the tip, I did not realize that connman is actually heavily
> relied on wpa_supplicant, if I restarted wpa_supplicant, most of time
> it popped up mwifiex_sdio messages, then the WiFi could be up:

The good news here: with iwd ConnMan doesn't have to rely on
wpa_supplicant anymore. We had to add *a lot* of code to ConnMan
because of wpa_supplicant including a lot of work arounds. With iwd we
have a clear separation between the domains. So I strongly recommend
to look at iwd.

> $ systemctl restart wpa_supplicant
> [  371.617417] mwifiex_sdio mmc0:0001:1: info: 2
> [  371.647545] mwifiex_sdio mmc0:0001:1: info: associated to bssid 34:08:04:12:y
> [  371.726667] IPv6: ADDRCONF(NETDEV_CHANGE): mlan0: link becomes ready
> [  371.772758] mwifiex_sdio mmc0:0001:1: CMD_RESP: cmd 0x23f error, result=0x2
> 
> But sometime when I restated wpa_supplicant, that message did not
> come, the WiFi network was still down.

You need to look at what your hardware/firmware, driver and
wpa_supplicant is going on. This is something ConnMan can't fix.

> How is mwifiex_sdio related to wpa_supplicant?

wpa_supplicant steers your WiFi chip.

> Why it is nondeterministic, sometime restart wpa_supplicant could
> bring mwifiex_sdio and WiFi up, something it couldn't?

That is the sad part about WiFi. The quality of the firmware, driver
and wpa_supplicant varies a lot. Some combination works great, others
are unusable.

> I think mwifiex_sdio is the lowest layer to interact to WiFi modem, in
> which circumstance it could bring WiFi modem up and in which
> circumstance it couldn't?

Sure, depending on the quality of the firmware and driver it might be
your main problem.

Don't get me wrong. I don't say your current setup is not good, but
from expierence firmware/drivers and wpa_supplicant tend to be
problematic.

iwd on the other hand is able to hide most of the nasty stuff for
ConnMan and I think in the long run it will be a lot more reliable
then wpa_supplicant was.

> That is far too unstable, I always thought I could rely on connman for
> WiFi connection stability, but it seems that beyond connman capacity,
> so what I can do when the WiFi is not up when restart wpa_supplicant
> could not fix it?

Try iwd.

Thanks,
Daniel
