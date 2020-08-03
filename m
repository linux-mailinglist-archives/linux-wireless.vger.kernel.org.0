Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B5223A86F
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHCObC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 10:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgHCObC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 10:31:02 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D65A206D4;
        Mon,  3 Aug 2020 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596465060;
        bh=DZv7qthWwoOdLQUbveraF42ceuRzq+dGaWJs+SdT2Ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+birqDDiKwLOk1ZHpBpGYYvp861T8bNrfb8CtyOtfZjfc2VAFjNdPgYvQmPFJ969
         Fqic6Lpdj6yKMoMj27LQOIHMshWkpF+a0eytFjdW/hJl4QpuCMYNtF6Llj8UDSrPc/
         81hy2FXlmaQGEfvbIp/V9Om5A/+yPIuK1IwF9GMM=
Received: by pali.im (Postfix)
        id 12F98121D; Mon,  3 Aug 2020 16:30:59 +0200 (CEST)
Date:   Mon, 3 Aug 2020 16:30:58 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Subject: Re: mwifiex & cfg80211: Problems with power save mode
Message-ID: <20200803143058.jg7eu3jtks7ygell@pali>
References: <20200609111544.v7u5ort3yk4s7coy@pali>
 <20200708093524.cw5k6667gvhop5zj@pali>
 <07147c779fbb4212e04d0f007d6f79bf1c971bf8.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07147c779fbb4212e04d0f007d6f79bf1c971bf8.camel@sipsolutions.net>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

On Thursday 30 July 2020 15:33:44 Johannes Berg wrote:
> Hi,
> 
> Sorry about the long delay!
> 
> > > I'm looking at power save mode provided by mwifiex driver and I see that
> > > current implementation is suboptimal and probably default settings quite
> > > suspicious for me.
> > > 
> > > If I understand mwifiex driver correctly, it supports power save mode,
> > > but its setting is global for all interfaces. mwifiex is fullmac driver
> > > and power save mode is controlled by firmware and it is not possible to
> > > set it per-bssid. There is just command which affects all bssids.
> > > Ganapathi, please correct me if I'm wrong here.
> > > 
> > > On the other hand, current cfg80211 layer supports controlling power
> > > save mode by NL80211_CMD_SET_POWER_SAVE and NL80211_CMD_GET_POWER_SAVE
> > > commands, which are per-net-interface, not per-wiphy-interface.
> > > 
> > > Moreover NL80211_CMD_GET_POWER_SAVE does not use any driver callback,
> > > just use cached value from the last NL80211_CMD_SET_POWER_SAVE call. So
> > > kernel driver cannot provide correct state of power save by asking
> > > firmware for it.
> > > 
> > > So currently it is not possible to implement power save mode for mwifiex
> > > driver correctly when more bssid interfaces for wiphy are used.
> > > 
> > > Current situation is following: If I create two wlan interfaces (wlan0
> > > and wlan1) for mwifiex wiphy and turn power save just only for wlan0
> > > then mwifiex turn power save for both wlan0 and wlan1 (as firmware does
> > > not support per-bssid powe save), but cfg80211 for wlan1 still inform
> > > that power save is enabled.
> > > 
> > > Do you have any idea how to fix this issue "properly"? So kernel would
> > > not lay about power save state of mwifiex interfaces? I guess that some
> > > extension or modification would be needed to core wireless cfg80211
> > > code.
> 
> I'm not sure I'd consider it "lying"? After all, powersave is sort of
> opportunistic anyway, and turned off when there's "enough" traffic, etc.

More people with 8997 chip are seeing instability issues and it looks
like that some are related to power save mode. So I would like to know
if power save is disabled. But because of above problem, I cannot use
standard "iw dev wlan0 get power_save" as it may return information that
power save is enabled when it is disabled. So for me this is "lying",
not providing me correct information.

There is bugzilla ticket about instability issues:
https://bugzilla.kernel.org/show_bug.cgi?id=109681

> But if you wanted to, I think you could just iterate all your interfaces
> and change
> 
> 	wdev->ps
> 
> for each one accordingly. It's a bit of a hack, but I'm not convinced
> that adding new API to nl80211 for this is worthwhile. That'd require
> disallowing the per-interface API, adding new API that is global, etc.
> 
> So IMHO easier and good enough to just set wdev->ps for all of them
> whenever one of them is changed?

Well, I agree this is a hack. But if you as maintainer says that this is
how drivers with global power save state should implement nl80211 power
save API, I have no problem with it.

Basically with current API I was not able to fix/implement it properly
and that is why I wrote previous email: to ask how to deal with it.

> > > And I have another question about power save. How should be handled
> > > WIPHY_FLAG_PS_ON_BY_DEFAULT flag? I see that kernel by default set it
> > > based on CONFIG_CFG80211_DEFAULT_PS compile option. But mwifiex driver
> > > always enable it independently of how is CONFIG_CFG80211_DEFAULT_PS was
> > > set at compile time.
> > > 
> > > Should mwifiex driver respect CONFIG_CFG80211_DEFAULT_PS compile time
> > > option and do not enable WIPHY_FLAG_PS_ON_BY_DEFAULT when
> > > CONFIG_CFG80211_DEFAULT_PS is not set to power save?
> 
> Uh, not sure really, sorry.
> 
> I don't think it matters much?

This is something for consistency. If driver API provides some option I
would expect that drivers would respect / implement it in the same way.

And if some option are not respected then it is probably good idea to
remove them? (Or fixing them)

> I think we should probably just remove the CFG80211_DEFAULT_PS config
> entirely. A lot of drivers won't really honour it, I suspect, and the
> runtime setting is trivially available.

Of course userspace can set power save mode after creating interface.

If I'm looking at the code correctly, CONFIG_CFG80211_DEFAULT_PS
controls WIPHY_FLAG_PS_ON_BY_DEFAULT flag which directly sets wdev->ps
state during NETDEV_REGISTER event.

So checking if drivers really honor it, is not easy. As it is needed to
check if wdev->ps is used during register. And not only option
CONFIG_CFG80211_DEFAULT_PS or flag WIPHY_FLAG_PS_ON_BY_DEFAULT.

> > > And the last question about power save mode and mwifiex. As power save
> > > mode for mwifiex firmware is global for all interfaces, what should be
> > > the correct behavior when there is wlan0 interface in managed/sta mode
> > > with enabled power save mode and then user add a new wlan1 interface in
> > > AP mode? Should driver turn off power save mode automatically (as it AP
> > > with enabled power save mode may cause problems) or should power save
> > > mode stay enabled (as user explicitly did not turned it off for wlan0)?
> 
> That's up to the driver I guess, but I'd consider turning it off.

In driver we can implement anything. So I think some consensus or
decision should be done. As I do not think that it make sense what one
driver would behave difference as other drivers. Such thing should
prevent users surprise that one card behave differently as other card.
Just because one driver enable power save by default other not.

> Btw if you keep "wdev->ps" then you can undo this when the AP interface
> goes away, or in general when the list of interfaces changes.
> 
> 
> > > And what should be the correct behavior when there are two interfaces
> > > wlan0 and wlan1, both have power save mode turned off and user try to
> > > enable power save mode just for wlan0? Should mwifiex driver turn power
> > > save mode and therefore enable it for both wlan0 and wlan1? Or it should
> > > not enable power save mode until command is send for both wlan0 and
> > > wlan1 interfaces?
> 
> Yeah, no idea :)
> 
> I'd probably do something like this
> 
>  * keep wdev->ps as it is, so "lie" to userspace about it in some cases
>  * disable powersave for AP interfaces completely (probably not even
>    allowing it enabled); keep it for P2P_GO if supported though
>  * whenever any interfaces come and go or any interface's state changes,
>    recalculate the overall powersave state of the device and apply that

Personally I see a problem with first point that wdev->ps would not
contain current state of power save. I really would like to see some
meaningful output from "iw dev wlan0 get power_save". If kernel would
"lie" then there is no point to use "get power_save" command as it just
return bogus value.

What I need to know is: "Is mwifixex power save mode enabled or not?"
If "get power_save" command cannot provide correct answer then I need
some other way how to retrieve this kind of information.
