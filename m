Return-Path: <linux-wireless+bounces-3998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C576866E22
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 10:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA303286020
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4CC1EEEA;
	Mon, 26 Feb 2024 08:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nx4kAT+o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9A61CAA2
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936982; cv=none; b=HDojEIKaRv59n21IFXrGYSm7FOQUEK8irjUN6hFSjt2s0+mm5flsCWJlOD/yTQfjM+InYjWtovRrpD2S8ewphU4JeYDstWVByJgFAIzBEoodTtJ1VteT1QxbJAHTMEhBLwNBQQhVB2umiQnpWNhKF5/nlZWF+ChYH2OjLbQFGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936982; c=relaxed/simple;
	bh=JFvbODBGxPuSbdK8jF+Mg9nCZeldfMzPtY2GrJzopQE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u4oDXwADTrcHwSaU4pOwPKiX6J6AWGz+8/pRuXy2LzYbkbo2heKVUerVXBbEZSNRynK7cgZM/q4hZG+vfh+6OH9o3mK+RhumA120eKw7jOsz9G6pogCZ6+9rIxn9pJDHaqm6xfbnYkVvGvEXDWXq+HouXEyk5GSIFpKUUjUrTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nx4kAT+o; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Ro1ZkUfDNBOqrQxGwae3yVtnW2/XzWschVsU0vfdjt4=;
	t=1708936980; x=1710146580; b=nx4kAT+o7SLqguxDdKw8uWXzBu61RFIYbdjux+Ul3nDuh0f
	5Fv5HV0v6WOS7hHMYlPS6tttxQmcuoPV9W4nRLCHSB9XaTPtyv/GpZ68/aWpybYPghfKqDzUFjlws
	9+CUl2pmtFeLGko5kaEcJ1cNy8b+Tx2Esew/aM5nRym6+L4rU7m6AfVHaaxBXStKArYfDZq+hTLbo
	1v5OO9rL4o5TMjnSQ1MV348Hk7isdntCS4QCf3dGoD1wLGYlbuUywbjcZwLMjxgjy3Hpl+QXdKdoA
	65ybNvxx+ZEfHrduPhGwLwmZt352cJwXiNeHv9nVBQuzIh1swhWkhDW+c4atsRBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1reWZe-000000095Zp-0OMv;
	Mon, 26 Feb 2024 09:42:58 +0100
Message-ID: <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Mon, 26 Feb 2024 09:42:56 +0100
In-Reply-To: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-02-23 at 09:08 -0800, Ben Greear wrote:

> [905261.271981] INFO: task systemd-resolve:948 blocked for more than 180 =
seconds.
> [905261.277834]       Tainted: G           O       6.7.3+ #34
> [905261.281939] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disabl=
es this message.
> [905261.288474] task:systemd-resolve state:D stack:0     pid:948   tgid:9=
48   ppid:1      flags:0x00000002

I don't know what that's doing, but

> [905261.288477] Call Trace:
> [905261.288478]  <TASK>
> [905261.288481]  __schedule+0x377/0xa10
> [905261.288486]  ? _copy_to_user+0x20/0x30
> [905261.288507]  schedule+0x29/0xc0
> [905261.288509]  schedule_preempt_disabled+0xc/0x20
> [905261.288511]  __mutex_lock.constprop.0+0x34d/0x760
> [905261.288514]  do_ip_setsockopt+0x4a/0x1150

I'm going to assume that this is RTNL, the socket lock isn't technically
a mutex, and doesn't seem reasonable in this context.

> [905261.337114] task:xdg-desktop-por state:D stack:0     pid:2485  tgid:2=
485  ppid:1742   flags:0x00000002
> [905261.337116] Call Trace:
> [905261.337117]  <TASK>
> [905261.337118]  __schedule+0x377/0xa10
> [905261.337120]  ? poll_freewait+0x40/0xa0
> [905261.337122]  schedule+0x29/0xc0
> [905261.337138]  schedule_preempt_disabled+0xc/0x20
> [905261.337139]  __mutex_lock.constprop.0+0x34d/0x760
> [905261.337142]  __netlink_dump_start+0x6c/0x280
> [905261.337143]  ? rtnl_mdb_dump+0x160/0x160
> [905261.337146]  rtnetlink_rcv_msg+0x267/0x3b0

A lot of other things are waiting for the RTNL too.

> [905261.353300] INFO: task btserver:3593 blocked for more than 180 second=
s.
> [905261.358620]       Tainted: G           O       6.7.3+ #34
> [905261.362729] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disabl=
es this message.
> [905261.369263] task:btserver        state:D stack:0     pid:3593  tgid:3=
593  ppid:2866   flags:0x00000002
> [905261.369265] Call Trace:
> [905261.369266]  <TASK>
> [905261.369267]  __schedule+0x377/0xa10
> [905261.369268]  ? sched_clock+0xc/0x20
> [905261.369270]  schedule+0x29/0xc0
> [905261.369271]  schedule_timeout+0x136/0x150
> [905261.369274]  wait_for_completion+0x7d/0x130
> [905261.369292]  wiphy_locked_debugfs_read+0x114/0x180 [cfg80211]
> [905261.369363]  ? wiphy_locked_debugfs_write_work+0x30/0x30 [cfg80211]
> [905261.369400]  ? rts_threshold_read+0x80/0x80 [cfg80211]
> [905261.369438]  ? ieee80211_link_sta_debugfs_drv_remove+0x40/0x40 [mac80=
211]
> [905261.369516]  ieee80211_if_read_sdata+0x55/0x80 [mac80211]

This you saw - it's waiting for the completion of the read of the ...
not sure which file? Any chance you could find out which fd this process
has open when it happens?

> [905261.369553]  ? ieee80211_link_sta_debugfs_drv_remove+0x40/0x40 [mac80=
211]
> [905261.369587]  ? ieee80211_if_fmt_dot11MeshMaxRetries+0x20/0x20 [mac802=
11]

I don't think we can trust any of the lines marked "?", they're probably
old prior stack contents ... these don't show up in the call stack of
ieee80211_if_read_sdata() directly, after all.

> [905261.402921] INFO: task kworker/u16:17:2582370 blocked for more than 1=
80 seconds.
> [905261.409024]       Tainted: G           O       6.7.3+ #34
> [905261.413157] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disabl=
es this message.
> [905261.419735] task:kworker/u16:17  state:D stack:0     pid:2582370 tgid=
:2582370 ppid:2      flags:0x00004000
> [905261.419738] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
> [905261.419788] Call Trace:
> [905261.419788]  <TASK>
> [905261.419789]  __schedule+0x377/0xa10
> [905261.419792]  schedule+0x29/0xc0
> [905261.419793]  schedule_preempt_disabled+0xc/0x20
> [905261.419795]  __mutex_lock.constprop.0+0x34d/0x760
> [905261.419797]  cfg80211_wiphy_work+0x15/0xb0 [cfg80211]
> [905261.419827]  process_one_work+0x15d/0x330

This is a bit interesting - why is the wiphy work stuck trying to
acquire the wiphy mutex? But nothing related to the RTNL.

This does explain why the debugfs is stuck though. So maybe doesn't
matter knowing which file got stuck ...

> [905261.436449] Future hung task reports are suppressed, see sysctl kerne=
l.hung_task_warnings

I think we're missing the process that's actually stuck though, maybe
here or later?

Seems like there must be a process somewhere that holds RTNL and wiphy
mutex, but didn't get listed here. Maybe it's live-locked? Maybe it's
actually a netdev removal (which would hold both those locks), but then
why is it stuck and not shown?

johannes

