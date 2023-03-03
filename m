Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658176A9793
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 13:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCCMvw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 07:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCCMvv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 07:51:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC447F8
        for <linux-wireless@vger.kernel.org>; Fri,  3 Mar 2023 04:51:50 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pY4t3-0006Cy-3S; Fri, 03 Mar 2023 13:51:49 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pY4t2-000366-0l; Fri, 03 Mar 2023 13:51:48 +0100
Date:   Fri, 3 Mar 2023 13:51:47 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     "Alex G." <mr.nuke.me@gmail.com>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        neojou@gmail.com
Subject: Re: Issues with rtw88_8821cu
Message-ID: <20230303125147.GV32097@pengutronix.de>
References: <ee614c10-cfd7-de88-3f85-6448aaa17c5a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee614c10-cfd7-de88-3f85-6448aaa17c5a@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alex,

On Wed, Mar 01, 2023 at 03:57:04PM -0600, Alex G. wrote:
> Hi,
> 
> I'm seeing some issues with a BrosTrend AC650 adapter (rtw88_8821cu). I have
> all the recent fixes, up to and including commit 4a267bc5ea8f ("wifi: rtw88:
> use RTW_FLAG_POWERON flag to prevent to power on/off twice").
> 
> 1)   rtw_8821cu 1-3:1.0: Firmware version 24.11.0, H2C version 12
>     rtw_8821cu 1-3:1.0: failed to download firmware
>     rtw_8821cu 1-3:1.0: failed to setup chip efuse info
>     rtw_8821cu 1-3:1.0: failed to setup chip information
> 
> This first issue is related to USB errors. Generally, it starts with the
> "failed to download firmware" followed by an assortment of other "failed to"
> messages. At this point the adapter may show up in iw, but is unusable until
> unplugged and replugged.

I can confirm these issues. Unfortunately I don't know why this is happening.
I have a board here with USB2 (ehci) ports and USB3 (xhci) ports. It
seems to work fine on the USB2 ports, but on the USB3 ports it fails
like you described. Well, not always, sometimes it works. It works
better when not using NetworkManager, but wpa_supplicant directly.

> 
> 2) The second issue is unusably low Rx signal levels on the 2.4 GHz bands.
> The scan results report about 30dB to 50dB lower than adjacent adapters.
> That's if the 8821cu can even detect the beacons.

That was reported elsewhere and I can confirm it, but unfortunately I
don't know a solution.

> 
> 3) The third issue is that, in IBSS mode, the adapter cannot receive any
> packets or see adjacent IBSS nodes.
> 	iw <wlanx> station dump
> shows no results, unless also running a scan. Even so, ifconfig shows 0 Rx
> packets, and the adapter is not able to receive. This happens in either
> noHT, HT20, or HT40 modes.

I haven't tested IBSS mode, so I can't say anything to this.

> 
> Where do I begin getting these running?

For the first problem I can imagine that it could be solved by looking
at the code and evaluating what is different between NetworkManager vs.
wpa_supplicant or EHCI vs. XHCI.

For the other two problems I don't have an idea either. There is no
documentation for these chips and the downstream drivers are a complete
mess.

Have you tried one of these drivers?

https://github.com/lwfinger/rtw88
https://github.com/ulli-kroll/rtw88-usb

The code is based on the kernel driver and the RTW88 USB support in the
kernel is derived from these drivers. There is a chance that I broke
something while porting it upstream and if yes it should be fairly easy
to sort out.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
