Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1218008F
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Mar 2020 15:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgCJOsN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Mar 2020 10:48:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJOsN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Mar 2020 10:48:13 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jBgB0-0004ju-3h; Tue, 10 Mar 2020 15:48:10 +0100
Date:   Tue, 10 Mar 2020 15:48:09 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Support for RTL8188FU
Message-ID: <20200310144809.se2oqvlnnh55fhfd@linutronix.de>
References: <20191001160305.qrl4nt2jmdsogaaz@linutronix.de>
 <3af284c7-ee46-dd42-9549-de55feae2528@lwfinger.net>
 <20191001174612.4kj3mt3h5epidyyk@linutronix.de>
 <b958b669-a683-d7cd-6bbf-bfe3e674f62d@lwfinger.net>
 <20200304102152.a25cczvat2mujxwa@linutronix.de>
 <9c6717de-5ffc-47dc-6db7-7e070cbc41b9@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9c6717de-5ffc-47dc-6db7-7e070cbc41b9@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-03-04 12:16:54 [-0600], Larry Finger wrote:
> 
> I have no further advice. There are quite likely a number of routines that
> will differ as the 8188FU chip is quite likely a lot different from the
> 8188EU, even though both are 802.11n devices.

That is more complicated than I assumed. Even the "generic" hal layer is
different. Sometimes there are additional bits, sometimes the bits are
moved (to/from the HW-specific hal layer), sometimes the bits the are
different (like BIT0|BIT1 vs BIT1). Without having any kind of
documentation I can't even tell how essential the difference is.

Right now I went function by function and compared the code and *hoped*
that I didn't miss anything. I get USB errors later and I can't tell if
there is something that I missed/did wrong _or_ did not yet modify. I'm
worried that by the time I'm done, I did something wrong and no idea
where to look for the bug.

I stumbled over the version define:
The driver on github is
|include/rtw_version.h:#define DRIVERVERSION "v5.2.2.4_25483.20171222"

and mine is
|include/rtw_version.h:#define DRIVERVERSION "v5.7.4_33085.20190419"

Going by the date, they are more than a year apart. (Side note: the
driver in staging is from 2013.)

Is it possible to obtain a more recent version of the 8188EU driver from
realtek? That should ease the integration of the "two" drivers since the
generic bits should be the same…

What would be the challenges to get the 8188f Realtek driver upstream?
Looking at the todo list for the staging driver, it is mostly clean up
and checkpatch kind of thing. The more difficult/non mechanic task is to
convince the driver to use lib80211/mac80211 layer.

> Larry

Sebastian
