Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ACB233327
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgG3Ndw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 09:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgG3Ndu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 09:33:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D41C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 06:33:49 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k18gr-00DYCs-07; Thu, 30 Jul 2020 15:33:45 +0200
Message-ID: <07147c779fbb4212e04d0f007d6f79bf1c971bf8.camel@sipsolutions.net>
Subject: Re: mwifiex & cfg80211: Problems with power save mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 15:33:44 +0200
In-Reply-To: <20200708093524.cw5k6667gvhop5zj@pali>
References: <20200609111544.v7u5ort3yk4s7coy@pali>
         <20200708093524.cw5k6667gvhop5zj@pali>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry about the long delay!

> > I'm looking at power save mode provided by mwifiex driver and I see that
> > current implementation is suboptimal and probably default settings quite
> > suspicious for me.
> > 
> > If I understand mwifiex driver correctly, it supports power save mode,
> > but its setting is global for all interfaces. mwifiex is fullmac driver
> > and power save mode is controlled by firmware and it is not possible to
> > set it per-bssid. There is just command which affects all bssids.
> > Ganapathi, please correct me if I'm wrong here.
> > 
> > On the other hand, current cfg80211 layer supports controlling power
> > save mode by NL80211_CMD_SET_POWER_SAVE and NL80211_CMD_GET_POWER_SAVE
> > commands, which are per-net-interface, not per-wiphy-interface.
> > 
> > Moreover NL80211_CMD_GET_POWER_SAVE does not use any driver callback,
> > just use cached value from the last NL80211_CMD_SET_POWER_SAVE call. So
> > kernel driver cannot provide correct state of power save by asking
> > firmware for it.
> > 
> > So currently it is not possible to implement power save mode for mwifiex
> > driver correctly when more bssid interfaces for wiphy are used.
> > 
> > Current situation is following: If I create two wlan interfaces (wlan0
> > and wlan1) for mwifiex wiphy and turn power save just only for wlan0
> > then mwifiex turn power save for both wlan0 and wlan1 (as firmware does
> > not support per-bssid powe save), but cfg80211 for wlan1 still inform
> > that power save is enabled.
> > 
> > Do you have any idea how to fix this issue "properly"? So kernel would
> > not lay about power save state of mwifiex interfaces? I guess that some
> > extension or modification would be needed to core wireless cfg80211
> > code.

I'm not sure I'd consider it "lying"? After all, powersave is sort of
opportunistic anyway, and turned off when there's "enough" traffic, etc.

But if you wanted to, I think you could just iterate all your interfaces
and change

	wdev->ps

for each one accordingly. It's a bit of a hack, but I'm not convinced
that adding new API to nl80211 for this is worthwhile. That'd require
disallowing the per-interface API, adding new API that is global, etc.

So IMHO easier and good enough to just set wdev->ps for all of them
whenever one of them is changed?

> > And I have another question about power save. How should be handled
> > WIPHY_FLAG_PS_ON_BY_DEFAULT flag? I see that kernel by default set it
> > based on CONFIG_CFG80211_DEFAULT_PS compile option. But mwifiex driver
> > always enable it independently of how is CONFIG_CFG80211_DEFAULT_PS was
> > set at compile time.
> > 
> > Should mwifiex driver respect CONFIG_CFG80211_DEFAULT_PS compile time
> > option and do not enable WIPHY_FLAG_PS_ON_BY_DEFAULT when
> > CONFIG_CFG80211_DEFAULT_PS is not set to power save?

Uh, not sure really, sorry.

I don't think it matters much?

I think we should probably just remove the CFG80211_DEFAULT_PS config
entirely. A lot of drivers won't really honour it, I suspect, and the
runtime setting is trivially available.


> > And the last question about power save mode and mwifiex. As power save
> > mode for mwifiex firmware is global for all interfaces, what should be
> > the correct behavior when there is wlan0 interface in managed/sta mode
> > with enabled power save mode and then user add a new wlan1 interface in
> > AP mode? Should driver turn off power save mode automatically (as it AP
> > with enabled power save mode may cause problems) or should power save
> > mode stay enabled (as user explicitly did not turned it off for wlan0)?

That's up to the driver I guess, but I'd consider turning it off.

Btw if you keep "wdev->ps" then you can undo this when the AP interface
goes away, or in general when the list of interfaces changes.


> > And what should be the correct behavior when there are two interfaces
> > wlan0 and wlan1, both have power save mode turned off and user try to
> > enable power save mode just for wlan0? Should mwifiex driver turn power
> > save mode and therefore enable it for both wlan0 and wlan1? Or it should
> > not enable power save mode until command is send for both wlan0 and
> > wlan1 interfaces?

Yeah, no idea :)

I'd probably do something like this

 * keep wdev->ps as it is, so "lie" to userspace about it in some cases
 * disable powersave for AP interfaces completely (probably not even
   allowing it enabled); keep it for P2P_GO if supported though
 * whenever any interfaces come and go or any interface's state changes,
   recalculate the overall powersave state of the device and apply that

johannes

