Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EF381A01
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 18:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhEOQzc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 12:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233885AbhEOQy6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 12:54:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E68C561369;
        Sat, 15 May 2021 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621097621;
        bh=gmEC+WFvzJ0OnoOXHpOAmo0LdJffyTQ+aW+Hp1/1+U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NI+bAoh2wKEuKTofe2heeutP4fBjLmv4QZx84wIMc2fxD9iCAQbE4CAqw+UvsTaIk
         go60h+JGmzjpWx/4z1/6ELTdDYXPGDFLlHlodp+ILTH+800q6+Zoy9nyENI2RzEOwO
         8DIqYn4/B0+MQ8qBiPIKZY1sFBM7gdn7o53nWa+xGBnOw+iF+vMPRaCXe8mpiaiqL1
         3BBhf6A0z9eR4NXQhpn1KofrQcw7/cAtQxIW99LNnYOxCd3XAtgUY1lwz9CtoeqQ7J
         16gNtr+ZgbinK1/oyNsouzWi5JMZEZ2xn1hIgngacxpd3fL5k3QDbO2dfq17S/bBB/
         feY9P8nXCe5zQ==
Received: by pali.im (Postfix)
        id 789E4A3B; Sat, 15 May 2021 18:53:38 +0200 (CEST)
Date:   Sat, 15 May 2021 18:53:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dave Olsthoorn <dave@bewaar.me>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ganapathi Bhat <ganapathi017@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: mwifiex firmware crash
Message-ID: <20210515165338.7lqe6nqtkevpc5lh@pali>
References: <20210515024227.2159311-1-briannorris@chromium.org>
 <713286ddc100bd63a9dbefdece39c935@bewaar.me>
 <20210515154042.mscvvyfapuvwdgzy@pali>
 <ec4aa44faf41f2820c2f82317373033e@bewaar.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec4aa44faf41f2820c2f82317373033e@bewaar.me>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello!

On Saturday 15 May 2021 18:32:30 Dave Olsthoorn wrote:
> Hi,
> 
> On 2021-05-15 17:40, Pali Rohár wrote:
> > On Saturday 15 May 2021 17:10:31 Dave Olsthoorn wrote:
> > > The firmware still seems to crash quicker than previously, but
> > > that's a
> > > unrelated problem.
> > 
> > Hello! Do you have some more details (or links) about mentioned firmware
> > crash?
> 
> Sure, firmware crashes have always been a problem on the Surface devices.

What wifi chip you have on these devices? Because very similar firmware
crashes I see on 88W8997 chip (also with mwifiex) when wifi card is
configured in SDIO mode (not PCIe).

I know that there are new version of firmwares for these 88W8xxx chips,
but they are available only under NXP NDA and only for NXP customers.
So it looks like that end users with NXP wifi chips are out of luck.

> They seem to be related, at least for some of the crashes, to power
> management. For this reason I disabled powersaving in NetworkManager which
> used to make it at least stable enough for me, in 5.13 this trick does not
> seem to work.
> 
> The dmesg log attached shows a firmware crash happening, the card does not
> work even after a reset or remove & rescan on the pci(e) bus.

Similar issue, card start working again only after whole system restart.

So this is something which can be resolved only in NXP.

Sharvari, could you look at this issue? It looks like there are many
mwifiex driver or 88W8xxx firmware issues which are common both PCIe and
SDIO modes.

Also could you please look at way how NXP 88W8xxx firmware files could
be updated in linux-firmware repository?

> There are patches [1] which have not been submitted yet and where developed
> as part of the linux-surface effort [2]. From my experience these patches
> resolve most if not all of the firmware crashes.

Is somebody going to cleanup these patches and send them for inclusion
into mainline kernel? I see that most of them are PCIe related, but due
to seeing same issues also on SDIO bus, I guess adding similar hooks
also for SDIO could make also SDIO more stable...

> Regards,
> Dave Olsthoorn
> 
> [1]: https://github.com/linux-surface/linux-surface/blob/master/patches/5.12/0002-mwifiex.patch
> [2]: https://github.com/linux-surface
> 
> dmesg.log:
> [ 127.367628]   mwifiex_pcie 0000:01:00.0: info: successfully disconnected
> from xx:xx:xx:xx:xx:xx: reason code 3
> [ 127.371059]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.371083]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 127.371086]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.371088]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 127.371091]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.371093]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 127.371096]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.371099]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 127.371101]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.371103]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 127.374001]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.374028]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.374103]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.374113]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.375041]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.375311]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.375445]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.375903]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW in reset state
> [ 127.379980]   mwifiex_pcie 0000:01:00.0: info: shutdown mwifiex...
> [ 127.448638]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 127.457009]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 127.494749]   mwifiex_pcie 0000:01:00.0: performing cancel_work_sync()...
> [ 127.494756]   mwifiex_pcie 0000:01:00.0: cancel_work_sync() done
> [ 155.308155]   mwifiex_pcie: PCI memory map Virt0: 00000000ff7d3684 PCI
> memory map Virt2: 000000004aa1ebbb
> [ 155.357139]   mwifiex_pcie 0000:01:00.0: WLAN FW already running! Skip FW
> dnld
> [ 155.357146]   mwifiex_pcie 0000:01:00.0: WLAN FW is active
> [ 155.510296]   mwifiex_pcie 0000:01:00.0: info: MWIFIEX VERSION: mwifiex
> 1.0 (15.68.19.p21)
> [ 155.510319]   mwifiex_pcie 0000:01:00.0: driver_version = mwifiex 1.0
> (15.68.19.p21)
> [ 155.560724]   mwifiex_pcie 0000:01:00.0 wlp1s0: renamed from mlan0
> [ 161.848939]   mwifiex_pcie 0000:01:00.0: info: trying to associate to
> bssid xx:xx:xx:xx:xx:xx
> [ 162.027982]   mwifiex_pcie 0000:01:00.0: info: associated to bssid
> xx:xx:xx:xx:xx:xx successfully
> [ 162.063062]   IPv6: ADDRCONF(NETDEV_CHANGE): wlp1s0: link becomes ready
> [ 173.452786]   mwifiex_pcie 0000:01:00.0: mwifiex_cmd_timeout_func: Timeout
> cmd id = 0x10, act = 0x1
> [ 173.452867]   mwifiex_pcie 0000:01:00.0: num_data_h2c_failure = 0
> [ 173.452873]   mwifiex_pcie 0000:01:00.0: num_cmd_h2c_failure = 0
> [ 173.452877]   mwifiex_pcie 0000:01:00.0: is_cmd_timedout = 1
> [ 173.452881]   mwifiex_pcie 0000:01:00.0: num_tx_timeout = 0
> [ 173.452885]   mwifiex_pcie 0000:01:00.0: last_cmd_index = 1
> [ 173.452889]   mwifiex_pcie 0000:01:00.0: last_cmd_id: 16 00 10 00 28 00 a4
> 00 7f 00
> [ 173.452894]   mwifiex_pcie 0000:01:00.0: last_cmd_act: 00 00 01 00 13 00
> 00 00 00 00
> [ 173.452898]   mwifiex_pcie 0000:01:00.0: last_cmd_resp_index = 0
> [ 173.452905]   mwifiex_pcie 0000:01:00.0: last_cmd_resp_id: 16 80 10 80 28
> 80 a4 80 7f 80
> [ 173.452911]   mwifiex_pcie 0000:01:00.0: last_event_index = 3
> [ 173.452918]   mwifiex_pcie 0000:01:00.0: last_event: 6a 00 17 00 2b 00 33
> 00 58 00
> [ 173.452925]   mwifiex_pcie 0000:01:00.0: data_sent=1 cmd_sent=1
> [ 173.452930]   mwifiex_pcie 0000:01:00.0: ps_mode=0 ps_state=0
> [ 173.455878]   mwifiex_pcie 0000:01:00.0: ===mwifiex driverinfo dump
> start===
> [ 173.455914]   mwifiex_pcie 0000:01:00.0: info: MWIFIEX VERSION: mwifiex
> 1.0 (15.68.19.p21)
> [ 173.455925]   mwifiex_pcie 0000:01:00.0: PCIE register dump start
> [ 173.456014]   mwifiex_pcie 0000:01:00.0: pcie scratch register:
> [ 173.456026]   mwifiex_pcie 0000:01:00.0: reg:0xcf0, value=0xfedcba00
> reg:0xcf8, value=0x9141cc
> reg:0xcfc, value=0x28c8c00
> [ 173.456030]   mwifiex_pcie 0000:01:00.0: PCIE register dump end
> [ 173.456173]   mwifiex_pcie 0000:01:00.0: ===mwifiex driverinfo dump end===
> [ 173.456177]   mwifiex_pcie 0000:01:00.0: == mwifiex firmware dump start ==
> [ 177.548244]   mwifiex_pcie 0000:01:00.0: cmd_wait_q terminated: -110
> [ 177.548341]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 177.548708]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 177.548712]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 182.816381]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 182.816389]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 183.100502]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 183.100524]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 183.463055]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 183.463059]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 189.465526]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 189.465538]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 195.464760]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 195.464770]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 201.467820]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 201.467826]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 207.463143]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 207.463154]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 213.462237]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 213.462244]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 219.464173]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 219.464180]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 223.116948]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 225.468213]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 225.468219]   mwifiex_pcie 0000:01:00.0: failed to get signal information
> [ 229.349824]   mwifiex_pcie 0000:01:00.0: Firmware dump Finished!
> [ 229.349835]   mwifiex_pcie 0000:01:00.0: == mwifiex firmware dump end ==
> [ 229.350968]   mwifiex_pcie 0000:01:00.0: == mwifiex dump information to
> /sys/class/devcoredump start
> [ 229.354949]   mwifiex_pcie 0000:01:00.0: == mwifiex dump information to
> /sys/class/devcoredump end
> [ 229.354981]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 229.356825]   mwifiex_pcie 0000:01:00.0: PREP_CMD: FW is in bad state
> [ 229.357175]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 229.357184]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 229.357190]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 229.357195]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 229.357200]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 229.357205]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 229.357210]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 229.357215]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 229.357219]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 229.357224]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 229.357228]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 229.357233]   mwifiex_pcie 0000:01:00.0: deleting the crypto keys
> [ 229.359375]   mwifiex_pcie 0000:01:00.0: info: shutdown mwifiex...
> [ 229.362422]   mwifiex_pcie 0000:01:00.0: rx_pending=0, tx_pending=1,
> cmd_pending=0
> [ 229.493680]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 229.493700]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 229.509094]   mwifiex_pcie 0000:01:00.0: PREP_CMD: card is removed
> [ 230.653787]   mwifiex_pcie 0000:01:00.0: WLAN FW already running! Skip FW
> dnld
> [ 230.653794]   mwifiex_pcie 0000:01:00.0: WLAN FW is active
> [ 241.037922]   mwifiex_pcie 0000:01:00.0: mwifiex_cmd_timeout_func: Timeout
> cmd id = 0xfa, act = 0x4000
> [ 241.038005]   mwifiex_pcie 0000:01:00.0: num_data_h2c_failure = 0
> [ 241.038031]   mwifiex_pcie 0000:01:00.0: num_cmd_h2c_failure = 0
> [ 241.038048]   mwifiex_pcie 0000:01:00.0: is_cmd_timedout = 1
> [ 241.038067]   mwifiex_pcie 0000:01:00.0: num_tx_timeout = 0
> [ 241.038086]   mwifiex_pcie 0000:01:00.0: last_cmd_index = 2
> [ 241.038104]   mwifiex_pcie 0000:01:00.0: last_cmd_id: 16 00 10 00 fa 00 a4
> 00 7f 00
> [ 241.038126]   mwifiex_pcie 0000:01:00.0: last_cmd_act: 00 00 01 00 00 40
> 00 00 00 00
> [ 241.038147]   mwifiex_pcie 0000:01:00.0: last_cmd_resp_index = 0
> [ 241.038168]   mwifiex_pcie 0000:01:00.0: last_cmd_resp_id: 16 80 10 80 28
> 80 a4 80 7f 80
> [ 241.038187]   mwifiex_pcie 0000:01:00.0: last_event_index = 3
> [ 241.038207]   mwifiex_pcie 0000:01:00.0: last_event: 6a 00 17 00 2b 00 33
> 00 58 00
> [ 241.038226]   mwifiex_pcie 0000:01:00.0: data_sent=0 cmd_sent=1
> [ 241.038246]   mwifiex_pcie 0000:01:00.0: ps_mode=0 ps_state=0
> [ 241.040764]   mwifiex_pcie 0000:01:00.0: info: _mwifiex_fw_dpc: unregister
> device
> [ 241.057936]   mwifiex_pcie 0000:01:00.0: skipped cancel_work_sync()
> because we're in card reset failure path
> [ 241.060488]   mwifiex: Failed to bring up adapter: -5
> [ 241.060504]   mwifiex_pcie 0000:01:00.0: reinit failed: -5
