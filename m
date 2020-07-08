Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413D22183E4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2020 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGHJf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jul 2020 05:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgGHJf1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jul 2020 05:35:27 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7C79206C3;
        Wed,  8 Jul 2020 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594200926;
        bh=1FiwzFAJEiJEBBX6zXtc81AT3Q1jhfDaxIAW4BzpyJk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=C1pSmKV1k/JSlaHjiqOgy4q5We9bqESu5to5uJ3w9o9ZtbiaM6zJnCILgEhp3EHL/
         JumZ0wReKN30funY/wUXpmPed04HhbN2Zr+jpioKCErzYOJIwyLhHoFTBcpRy6oRah
         GLo2Ry8o94kQFQnhmAKLAdJWO/hV82YxnluQSsMg=
Received: by pali.im (Postfix)
        id 62A51FBE; Wed,  8 Jul 2020 11:35:24 +0200 (CEST)
Date:   Wed, 8 Jul 2020 11:35:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: mwifiex & cfg80211: Problems with power save mode
Message-ID: <20200708093524.cw5k6667gvhop5zj@pali>
References: <20200609111544.v7u5ort3yk4s7coy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200609111544.v7u5ort3yk4s7coy@pali>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello! I would like to remind issue with NL80211_CMD_GET_POWER_SAVE
described below. Do you have any idea how to fix / workaround it for
nl80211 API?

On Tuesday 09 June 2020 13:15:44 Pali Rohár wrote:
> Hello!
> 
> I'm looking at power save mode provided by mwifiex driver and I see that
> current implementation is suboptimal and probably default settings quite
> suspicious for me.
> 
> If I understand mwifiex driver correctly, it supports power save mode,
> but its setting is global for all interfaces. mwifiex is fullmac driver
> and power save mode is controlled by firmware and it is not possible to
> set it per-bssid. There is just command which affects all bssids.
> Ganapathi, please correct me if I'm wrong here.
> 
> On the other hand, current cfg80211 layer supports controlling power
> save mode by NL80211_CMD_SET_POWER_SAVE and NL80211_CMD_GET_POWER_SAVE
> commands, which are per-net-interface, not per-wiphy-interface.
> 
> Moreover NL80211_CMD_GET_POWER_SAVE does not use any driver callback,
> just use cached value from the last NL80211_CMD_SET_POWER_SAVE call. So
> kernel driver cannot provide correct state of power save by asking
> firmware for it.
> 
> So currently it is not possible to implement power save mode for mwifiex
> driver correctly when more bssid interfaces for wiphy are used.
> 
> Current situation is following: If I create two wlan interfaces (wlan0
> and wlan1) for mwifiex wiphy and turn power save just only for wlan0
> then mwifiex turn power save for both wlan0 and wlan1 (as firmware does
> not support per-bssid powe save), but cfg80211 for wlan1 still inform
> that power save is enabled.
> 
> Do you have any idea how to fix this issue "properly"? So kernel would
> not lay about power save state of mwifiex interfaces? I guess that some
> extension or modification would be needed to core wireless cfg80211
> code.
> 
> 
> And I have another question about power save. How should be handled
> WIPHY_FLAG_PS_ON_BY_DEFAULT flag? I see that kernel by default set it
> based on CONFIG_CFG80211_DEFAULT_PS compile option. But mwifiex driver
> always enable it independently of how is CONFIG_CFG80211_DEFAULT_PS was
> set at compile time.
> 
> Should mwifiex driver respect CONFIG_CFG80211_DEFAULT_PS compile time
> option and do not enable WIPHY_FLAG_PS_ON_BY_DEFAULT when
> CONFIG_CFG80211_DEFAULT_PS is not set to power save?
> 
> 
> And the last question about power save mode and mwifiex. As power save
> mode for mwifiex firmware is global for all interfaces, what should be
> the correct behavior when there is wlan0 interface in managed/sta mode
> with enabled power save mode and then user add a new wlan1 interface in
> AP mode? Should driver turn off power save mode automatically (as it AP
> with enabled power save mode may cause problems) or should power save
> mode stay enabled (as user explicitly did not turned it off for wlan0)?
> 
> And what should be the correct behavior when there are two interfaces
> wlan0 and wlan1, both have power save mode turned off and user try to
> enable power save mode just for wlan0? Should mwifiex driver turn power
> save mode and therefore enable it for both wlan0 and wlan1? Or it should
> not enable power save mode until command is send for both wlan0 and
> wlan1 interfaces?
