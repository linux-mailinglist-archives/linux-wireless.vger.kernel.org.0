Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270D53CC3AA
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jul 2021 15:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhGQNu4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Jul 2021 09:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232974AbhGQNu4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Jul 2021 09:50:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FB84613D3;
        Sat, 17 Jul 2021 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626529679;
        bh=NWSMEiSCehlLGab8IWcnuz5yhKKmsitA/SYxsp/QMXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ch4Kjoqhqp2TlSoCS2YHd0O4ygbHUQ16J/o0Wyhmy39b4yelpTSEnxgXQb31y2MS6
         4AfGCcGxQ+AGayB/bpwFciZNqHRng+flccFLUaJGieM97+vyBGaGL2NN0YNzTVqE96
         DO8t+udaGwfHqmGE/d5ZK23bwrWIguz1j4gRFr5CMihfG/twEiahNKTnNnUI3Y3Ph2
         Y67lmsD1O8rDUVBrbWMMuRm2Z3jv4C/rn5v4RXPvGT3c5UNyJiZTxhRXhLnYa9fWUc
         jE81bzpurtSoLEAZdXRmdzocnGqhi1ubSbfL+h0/MXHaszKU61GEFn9tQovoWsQhkQ
         QwmBdADuTjV6g==
Received: by pali.im (Postfix)
        id 09B9495D; Sat, 17 Jul 2021 15:47:56 +0200 (CEST)
Date:   Sat, 17 Jul 2021 15:47:56 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Jonas =?utf-8?Q?Dre=C3=9Fler?= <verdre@v0yd.nl>,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-wireless@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: mwifiex: Initialization of FW and net interface
Message-ID: <20210717134756.njsqcie4kgnyos47@pali>
References: <20200612103501.vhwo3skvzt2243gz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200612103501.vhwo3skvzt2243gz@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[+cc: Maximilian and Jonas]

Hello Sharvari! I'm forwarding to you this email about initialization
issues in mwifiex driver. Could you as a new NXP maintainer of mwifiex
driver look at it?

On Friday 12 June 2020 12:35:01 Pali Rohár wrote:
> Hello!
> 
> I was looking at mwifiex code which initialize card firmware and linux
> network interface and I think that there are some issues with this code
> path.
> 
> There is a function mwifiex_sta_init_cmd() which basically doing two
> different things:
> 
>  * initial card firmware initialization
>  * configuration of interface parameters via card firmware
> 
> That function has following definition:
> 
> int mwifiex_sta_init_cmd(struct mwifiex_private *priv, u8 first_sta, bool init);
> 
> 'first_sta' and 'init' is FALSE when doing just configuration of
> interface parameters (by cfg80211 callbacks).
> 
> 'init' is TRUE when doing initial card firmware initialization and it is
> called when mwifiex driver is doing setup of card. But this function is
> called with 'init' set to TRUE multiple times when card driver was
> configured to create multiple linux network interfaces. In this case
> 'first_sta' is TRUE only for the first call of this function.
> 
> And now the first suspicious thing is: Why mwifiex driver calls that
> initial card firmware initialization multiple times when network
> interfaces are created during driver setup, and not when they are
> created later by "iw phy phyX interface add ..."?
> 
> Next, looking at code of that function mwifiex_sta_init_cmd() it looks
> like that all commands send to firmware are "global" and affects all
> existing mwifiex network interfaces. Why then it is needed to call this
> function when creating a new interface? (E.g. second bssid for AP mode).
> 
> Also if it really affects all existing interfaces, it means that
> creating a new interface changes configured cfg80211 parameters of all
> existing interfaces to some default values.
> 
> This also affects power save settings which I described in previous email:
> https://lore.kernel.org/linux-wireless/20200609111544.v7u5ort3yk4s7coy@pali/
> 
> And the last and the most suspicious thing in that mwifiex_sta_init_cmd
> function is that some AP related code is executed only during initial
> card firmware initialization and only if initial interface is AP mode
> ('init' = TRUE, 'first_sta' = TRUE, mode = 'AP').
> 
> Seems that driver behaves differently if interfaces are created by
> standard 'iw phy phyX interface add ..." command (via cfg80211 layer)
> and differently if interfaces are created automatically during driver
> setup function.
> 
> Are there any reasons for these differences? And what to do with the
> fact that most firmware commands which affects all interfaces and not
> just one which is initializing?
> 
> These issues which I described makes it hard for me to understand what
> is driver really doing and what should be correct behavior.
> 
> By the way, do you have documentation for firmware commands?
