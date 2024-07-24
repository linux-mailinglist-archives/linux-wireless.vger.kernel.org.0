Return-Path: <linux-wireless+bounces-10472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796D93AD95
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 09:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7E31C20940
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 07:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD90981AC4;
	Wed, 24 Jul 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="e1Am3DbK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F21B285;
	Wed, 24 Jul 2024 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807917; cv=none; b=hldEA62jB/VOOHicMZ86rkEfJTMQOI7lfXGKzzSny8NCaucGe6pDZTCu/8dDO23IsS5DB8FZF39fn8uGviotKXMXL0w4kCn6icDNE5XrvGnyPXXXYsEWHVqQEzVXOe7DR8PdrMHp/q+cioQauaLllxpDyAba+fj5Er6CFIBkC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807917; c=relaxed/simple;
	bh=iRCRHXO7lCIyO8Op+JZCTGyMLbGizL8QKXIZmrNQiZo=;
	h=Message-ID:Date:MIME-Version:From:Cc:To:Subject:Content-Type; b=XCRrzKk8CTj3RegvXs8k9sO9cIdBgAiO5b4wyObFbCO3eHShoGqLEm4Q6S2qMoqpXgFnOdNLNHdXg09PG2NVXcOL9JvnE/1zqNFh4q4RvwSp2MvB6YlQjr4VexgjmfHoBCiGlKJ4LB24cqMEoDtuou+X0s5Y+i/Ql9hnxKQUDsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=e1Am3DbK; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:To:Reply-To:Cc:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
	Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=f+QZer3xnRAMYn9uqN9HcU3KEgUHNksandpcoaHZmog=; t=1721807915;
	x=1722239915; b=e1Am3DbKLADrIUOhXilZgiM+NNtI2G4ku/wxH9dfkQWSm0PDvWlhegnECTVz1
	7c4aatjpMPq65wADL4YKXPu8qih182ZfNcKxPbNGMYaHH8wJ+/JRUQhTS52UmsAOHOdw1xMZhmjbg
	iXni0yVYRE1UGxPRjjRf8jPfKOKEQIRqhgMZXKvqDwkgzdW+Du93xdmoFqDKi2o0V2dXnAy3Lwfri
	YRrni66+qiY2OJR9/LXBSl1vZr93UDzjI83eFxnE29SaXUQHBIwLkaR3eBFKHmiJiTER+AZGviByZ
	6JtzZL8CHIGYONJR2V6jFPzDRUKX/Gm1JSrw0p4jtwQWja+rdQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sWWtL-000445-HZ; Wed, 24 Jul 2024 09:58:31 +0200
Message-ID: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
Date: Wed, 24 Jul 2024 09:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: Michael <ZeroBeat@gmx.de>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>
Subject: [regression] mt76x2u: NULL pointer dereference since recent change to
 fix chanctx emulation for monitor mode
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1721807915;f6c98a9f;
X-HE-SMSGID: 1sWWtL-000445-HZ

Hi, Thorsten here, the Linux kernel's regression tracker.

Johannes, Felix, Lorenzo, Ryder, I noticed a report about a regression
in bugzilla.kernel.org that (for my untrained eyes) appears to be a bug
in some code paths of mt76x2u that was exposed by 0d9c2beed116e6 ("wifi:
mac80211: fix monitor channel with chanctx emulation") [v6.10-rc5,
v6.9.7] from Johannes.

As many (most?) kernel developers don't keep an eye on the bug tracker,
I decided to write this mail. To quote from
https://bugzilla.kernel.org/show_bug.cgi?id=219086 :

>  Michael 2024-07-23 15:38:43 UTC
> 
> After a user opened this discussion:
> https://github.com/ZerBea/hcxdumptool/discussions/465
> 
> Jul 21 05:40:39 rpi4b-aarch kernel: mt76x2u 2-2:1.0 wlan1: entered promiscuous mode
> Jul 21 05:40:45 rpi4b-aarch kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Jul 21 05:40:45 rpi4b-aarch kernel: Mem abort info:
> Jul 21 05:40:45 rpi4b-aarch kernel:   ESR = 0x0000000096000044
> Jul 21 05:40:45 rpi4b-aarch kernel:   EC = 0x25: DABT (current EL), IL = 32 bits
> Jul 21 05:40:45 rpi4b-aarch kernel:   SET = 0, FnV = 0
> Jul 21 05:40:45 rpi4b-aarch kernel:   EA = 0, S1PTW = 0
> Jul 21 05:40:45 rpi4b-aarch kernel:   FSC = 0x04: level 0 translation fault
> Jul 21 05:40:45 rpi4b-aarch kernel: Data abort info:
> Jul 21 05:40:45 rpi4b-aarch kernel:   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
> Jul 21 05:40:45 rpi4b-aarch kernel:   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
> Jul 21 05:40:45 rpi4b-aarch kernel:   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> Jul 21 05:40:45 rpi4b-aarch kernel: user pgtable: 4k pages, 48-bit VAs, pgdp=0000000041300000
> Jul 21 05:40:45 rpi4b-aarch kernel: [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> Jul 21 05:40:45 rpi4b-aarch kernel: Internal error: Oops: 0000000096000044 [#1] PREEMPT SMP
> 
> I decided to run a test (AMD RYZEN & Arch Linux) on kernel 6.9.10 and 6.10 which confirmed the problem:
> Trying to inject a 802.11 packet caused my AMD systems to become unresponsive.
> I don't have a dmesg log, because my entire system crashed - need to power off!
> 
> To reproduce on kernel 6.9.5 up to 6.10:
> plug in an ALFA AWUS036ACM (mt76x2u)
> set monitor mode
> set WiFi channel and inject a packet
> $ sudo hcxdumptool -i wlp5s0f4u2 --rcascan=active
> or
> sudo ./aireplay-ng --test wlp5s0f4u2
> 
> Kernel 6.6.40 is not affected and the user reported that kernel 6.8.2 is not affected, too.
> That looks like a regression and git bisect identified the commit that caused the problem:
> 
> commit 0d9c2beed116e623ac30810d382bd67163650f98
> Author: Johannes Berg <johannes.berg@intel.com>
> Date:   Wed Jun 12 12:23:51 2024 +0200
> 
>     wifi: mac80211: fix monitor channel with chanctx emulation
>     
>     After the channel context emulation, there were reports that
>     changing the monitor channel no longer works. This is because
>     those drivers don't have WANT_MONITOR_VIF, so the setting the
>     channel always exits out quickly.
>     
>     Fix this by always allocating the virtual monitor sdata, and
>     simply not telling the driver about it unless it wanted to.
>     This way, we have an interface/sdata to bind the chanctx to,
>     and the emulation can work correctly.
>     
>     Cc: stable@vger.kernel.org
>     Fixes: 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx drivers")
>     Reported-and-tested-by: Savyasaachi Vanga <savyasaachiv@gmail.com>
>     Closes: https://lore.kernel.org/r/chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl
>     Link: https://msgid.link/20240612122351.b12d4a109dde.I1831a44417faaab92bea1071209abbe4efbe3fba@changeid
>     Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
>  net/mac80211/driver-ops.c | 17 +++++++++++++++++
>  net/mac80211/iface.c      | 21 +++++++++------------
>  net/mac80211/util.c       |  2 +-
>  3 files changed, 27 insertions(+), 13 deletions(-)
> 
> Looks like the patch which should fix monitor mode breaks mt76x2u driver.
> 
> BTW:
> Reasons for me to set severity to high:
> "Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000"
> and
> running a simple command from which I would not have expected that my entire system crashes.
> 
> [tag] [reply] [−]
> Private
> Comment 1 Michael 2024-07-23 17:17:13 UTC
> 
> After some more tests, I'm not longer sure that the problem is caused by the commit mentioned. It looks like it is only a symptom.
> I tested several mt76 devices e.g. this one:
> D 148f:761a Ralink Technology, Corp. MT7610U ("Archer T2U" 2.4G+5G WLAN Adapter
> 
> Driver is mt76x0u:
> $ hcxdumptool -l
>   0	  3	503eaa1a736c	f49da7d6f202	*	wlp48s0f4u2u4   	mt76x0u	NETLINK
> 
> All of them are running into the same problem as mentioned above,
> while other devices are working as expected, e.g.:
> ID 2357:010c TP-Link TL-WN722N v2/v3 [Realtek RTL8188EUS]
> 
> Driver is rtl8xxxu
> $ hcxdumptool -l
>   0	  3	9ca2f4094fe1	c8aacc8562e3	+	wlp48s0f4u2u4   	rtl8xxxu	NETLINK
> 
> This leads me to the assumption that the "chanctx emulation" inside the mt76 series driver caused the real problem.

The reporter is CCed.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: 0d9c2beed116e623ac30810d382bd67163650f98
#regzbot title: net: mt76x2u: NULL pointer dereference since recent
change to fix chanctx emulation for monitor mode
#regzbot from: Michael <ZeroBeat@gmx.de>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=219086
#regzbot ignore-activity

