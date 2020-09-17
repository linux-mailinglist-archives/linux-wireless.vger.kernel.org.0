Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3141C26D877
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 12:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgIQKIi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 06:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIQKIf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 06:08:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700BDC061756
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 03:08:35 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kIqq7-005Vo1-3J; Thu, 17 Sep 2020 12:08:31 +0200
Message-ID: <882789fcb46ed8196ae4372cff1b9255ebfe4cb6.camel@sipsolutions.net>
Subject: Re: mwifiex & cfg80211: Problems with power save mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Thu, 17 Sep 2020 12:08:30 +0200
In-Reply-To: <20200803143058.jg7eu3jtks7ygell@pali>
References: <20200609111544.v7u5ort3yk4s7coy@pali>
         <20200708093524.cw5k6667gvhop5zj@pali>
         <07147c779fbb4212e04d0f007d6f79bf1c971bf8.camel@sipsolutions.net>
         <20200803143058.jg7eu3jtks7ygell@pali>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Pali,

Again, sorry ...

> > But if you wanted to, I think you could just iterate all your interfaces
> > and change
> > 
> > 	wdev->ps
> > 
> > for each one accordingly. It's a bit of a hack, but I'm not convinced
> > that adding new API to nl80211 for this is worthwhile. That'd require
> > disallowing the per-interface API, adding new API that is global, etc.
> > 
> > So IMHO easier and good enough to just set wdev->ps for all of them
> > whenever one of them is changed?
> 
> Well, I agree this is a hack. But if you as maintainer says that this is
> how drivers with global power save state should implement nl80211 power
> save API, I have no problem with it.
> 
> Basically with current API I was not able to fix/implement it properly
> and that is why I wrote previous email: to ask how to deal with it.

Right. And I don't really see a good way to fix the API either, since it
goes all the way to userspace that way. Even back in iwconfig ...

So the best thing we could do is add new global API like I described,
and then we'd probably somehow need to support the old API for older
userspace (otherwise all your users must upgrade to be able to fix
this!) and then ... I just don't think it's worth it, hence the
suggestion of just propagating it across all interfaces and effectively
limiting it to a global state in the driver that way.

Even in cfg80211 we'd have to do that if we implemented a global state
there! But I don't see it worthwhile much there ...

> This is something for consistency. If driver API provides some option I
> would expect that drivers would respect / implement it in the same way.
> 
> And if some option are not respected then it is probably good idea to
> remove them? (Or fixing them)

There's very little consistency in this area to start with ...

> > I think we should probably just remove the CFG80211_DEFAULT_PS config
> > entirely. A lot of drivers won't really honour it, I suspect, and the
> > runtime setting is trivially available.
> 
> Of course userspace can set power save mode after creating interface.
> 
> If I'm looking at the code correctly, CONFIG_CFG80211_DEFAULT_PS
> controls WIPHY_FLAG_PS_ON_BY_DEFAULT flag which directly sets wdev->ps
> state during NETDEV_REGISTER event.
> 
> So checking if drivers really honor it, is not easy. As it is needed to
> check if wdev->ps is used during register. And not only option
> CONFIG_CFG80211_DEFAULT_PS or flag WIPHY_FLAG_PS_ON_BY_DEFAULT.

Yeah. I doubt most drivers will honor it.

> In driver we can implement anything. So I think some consensus or
> decision should be done. As I do not think that it make sense what one
> driver would behave difference as other drivers. Such thing should
> prevent users surprise that one card behave differently as other card.
> Just because one driver enable power save by default other not.

Yeah, but if you look at things ... very little consistency expected in
this area today. It's a legacy interface coming from wireless extensions
though, so that's not very unexpected.

> >  * keep wdev->ps as it is, so "lie" to userspace about it in some cases
> >  * disable powersave for AP interfaces completely (probably not even
> >    allowing it enabled); keep it for P2P_GO if supported though
> >  * whenever any interfaces come and go or any interface's state changes,
> >    recalculate the overall powersave state of the device and apply that
> 
> Personally I see a problem with first point that wdev->ps would not
> contain current state of power save. I really would like to see some
> meaningful output from "iw dev wlan0 get power_save". If kernel would
> "lie" then there is no point to use "get power_save" command as it just
> return bogus value.
> 
> What I need to know is: "Is mwifixex power save mode enabled or not?"
> If "get power_save" command cannot provide correct answer then I need
> some other way how to retrieve this kind of information.

OK :)

So then I'd probably recommend to implement propagation to all netdevs
you have. In the most common cases that'll probably just be a single one
anyway.

johannes

