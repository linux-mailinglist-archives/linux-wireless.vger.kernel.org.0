Return-Path: <linux-wireless+bounces-4012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3D867AA4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A3E1F2617B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBEB12BEBA;
	Mon, 26 Feb 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kq/658X5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A312B159
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962388; cv=none; b=G8msycr+3/AH/LQhC2JivV2pvfegU/xzklZUmAjWipqbBcuFzHRAVlCQTVd99F+luR7sQllKXgohrJud+g02ayg19lXu0Fv9wDiZ1nK6gNQbOBXWooxXsy38zYJtGguG/eCzO2v5KxJ4L/PNSV/FBF6rzX1pO2TshBuMweJei/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962388; c=relaxed/simple;
	bh=2NUQhm28HB1DkEgTHNAY6OmlcZA9XNrCgCz5JrFtTOI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8jFalCjydRBi5dkAwyx0P4iO/y9MIHiFr7hRgBS4KzpophFe0527OThBvh5LN4cC6J3ZO1ixqDmaSmDDhkUSDOMnU2ARBUZHqSuY7yibXqfRtrGjgir7C9aDQE0i8cHaaiYvXPoC9ClZ7Yf34flRGPPR+L3/quHY0mxEtiMoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kq/658X5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UJrt0hpj0bpdyHXu/BPYY12RICJuuh6cRTEahqMtz54=;
	t=1708962385; x=1710171985; b=kq/658X5UqKlZpohOx3RGgt1ClNZTNMkuKdWcbxR8aIlhGi
	wzpD43+7XxLFwJVG7bvXFB1RRjzfzJF8an7EBwMabyByJ5D59JElLElh6t0jShZdQye7v3F3CCEtG
	8II7Qj2v9WFuAXJR/FUKuHv3i1NMaMaz0XJ05Upf0VfCgEOQYePf7OHB1yAHjkPs65CGkUuYMgvGn
	AUUKoAWWylQsRIlwk4MpiL6SVZMQdBYCXXeb3rB6Bpg7pUoDj+eKeYb01U1LM56rSnCr6hZGl1ncc
	lNO2mNOM8FiQBuCvlTImiAl16Q655ZaADHZ2KWXQ4NAyC8hwm41HAF6M0eSeOSlg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1redBM-00000009Kqt-33bz;
	Mon, 26 Feb 2024 16:46:22 +0100
Message-ID: <bb923801f7519c89b2b8f4300df1cb77ed2bb016.camel@sipsolutions.net>
Subject: Re: Kernel deadlock in 6.7.5 + hacks, maybe debugfs related.
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Mon, 26 Feb 2024 16:46:19 +0100
In-Reply-To: <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
References: <1c9fa9e5-09f1-0522-fdbc-dbcef4d255ca@candelatech.com>
	 <bdc7c51e3b6afaa7ac79efa15c6d1d41e9e918b5.camel@sipsolutions.net>
	 <95d56b9a-4b91-476f-bab3-7af0f28ff469@candelatech.com>
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

On Mon, 2024-02-26 at 06:58 -0800, Ben Greear wrote:

> I managed to catch it in a lockdep enabled kernel.  There were no lockdep
> warnings, but more lock info was printed at least:
>=20
> Maybe ordering of this one's lock printout means it is 'ip' that is actua=
lly holding the rtnl?
>=20
> [Seen in context further below]
> Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by ip/28125:
> Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.=
+.}-{4:4}, at: rtnetlink_rcv_msg+0x13e/0x620
> Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffff888122e60768 (&rdev->wiphy.m=
tx){+.+.}-{4:4}, at: ieee80211_stop+0x2d/0x180 [mac80211]
> Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffff88812661d768 (&sb->s_type->i=
_mutex_key#3){++++}-{4:4}, at: simple_recursive_removal+0x189/0x2b0

Yes, probably.

> Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task kworker/6:3:542 blocked fo=
r more than 180 seconds.
> Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
> Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_=
timeout_secs" disables this message.
> Feb 26 06:01:45 ct523c-0b0b kernel: task:kworker/6:3     state:D stack:0 =
    pid:542   tgid:542   ppid:2      flags:0x00004000
> Feb 26 06:01:45 ct523c-0b0b kernel: Workqueue: ipv6_addrconf addrconf_ver=
ify_work
> Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
> Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
> Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
> Feb 26 06:01:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? lock_acquire+0xc6/0x2b0
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? addrconf_verify_work+0x9/0x20
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? addrconf_verify_work+0x9/0x20
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
> Feb 26 06:01:45 ct523c-0b0b kernel:  addrconf_verify_work+0x9/0x20

Lots of things like this are just blocked on RTNL.

> Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_=
timeout_secs" disables this message.
> Feb 26 06:01:45 ct523c-0b0b kernel: task:kworker/u16:1   state:D stack:0 =
    pid:8298  tgid:8298  ppid:2      flags:0x00004000
> Feb 26 06:01:45 ct523c-0b0b kernel: Workqueue: events_unbound cfg80211_wi=
phy_work [cfg80211]
> Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
> Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
> Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_preempt_disabled+0xc/0x20
> Feb 26 06:01:45 ct523c-0b0b kernel:  __mutex_lock+0x5c4/0xc00
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? cfg80211_wiphy_work+0x1a/0xc0 [cfg=
80211]
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? process_one_work+0x18f/0x4e0
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? cfg80211_wiphy_work+0x1a/0xc0 [cfg=
80211]
> Feb 26 06:01:45 ct523c-0b0b kernel:  cfg80211_wiphy_work+0x1a/0xc0 [cfg80=
211]

this is blocked on wiphy mutex.

> Feb 26 06:01:45 ct523c-0b0b kernel: INFO: task ip:28125 blocked for more =
than 180 seconds.
> Feb 26 06:01:45 ct523c-0b0b kernel:       Not tainted 6.7.5+ #1
> Feb 26 06:01:45 ct523c-0b0b kernel: "echo 0 > /proc/sys/kernel/hung_task_=
timeout_secs" disables this message.
> Feb 26 06:01:45 ct523c-0b0b kernel: task:ip              state:D stack:0 =
    pid:28125 tgid:28125 ppid:3604   flags:0x00004002
> Feb 26 06:01:45 ct523c-0b0b kernel: Call Trace:
> Feb 26 06:01:45 ct523c-0b0b kernel:  <TASK>
> Feb 26 06:01:45 ct523c-0b0b kernel:  __schedule+0x42c/0xde0
> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule+0x3c/0x120
> Feb 26 06:01:45 ct523c-0b0b kernel:  schedule_timeout+0x19c/0x1b0
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? mark_held_locks+0x49/0x70
> Feb 26 06:01:45 ct523c-0b0b kernel:  __wait_for_common+0xba/0x1d0
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? usleep_range_state+0xb0/0xb0
> Feb 26 06:01:45 ct523c-0b0b kernel:  remove_one+0x6b/0x100
> Feb 26 06:01:45 ct523c-0b0b kernel:  simple_recursive_removal+0x20c/0x2b0
> Feb 26 06:01:45 ct523c-0b0b kernel:  ? start_creating.part.0+0x170/0x170
> Feb 26 06:01:45 ct523c-0b0b kernel:  debugfs_remove+0x3b/0x60
> Feb 26 06:01:45 ct523c-0b0b kernel:  ieee80211_debugfs_recreate_netdev+0x=
30/0xac0 [mac80211]

This seems to be blocked on the wait_for_completion()?! Which means it
should have actually triggered the c->cancel() first, but ... if
wiphy_locked_debugfs_read_cancel() had actually been called, I'm not
sure why we'd be stuck here?

Then again, I'm looking at the code now and not sure why I put this

+       /* if we're already removing wake it up to cancel */
+       if (d_unlinked(dentry))
+               complete(&fsd->active_users_drained);

into debugfs_enter_cancellation()...




> Feb 26 06:01:45 ct523c-0b0b kernel:
>                                      Showing all locks held in the system=
:

This isn't always clear on holding vs. acquiring, FWIW.

> Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by kworker/6:3/542:
> Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffff888109b33b38 ((wq_completion=
)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
> Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffffc90000f77e58 ((work_completi=
on)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0=
x18f/0x4e0
> Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffffffff82a6d588 (rtnl_mutex){+.=
+.}-{4:4}, at: addrconf_verify_work+0x9/0x20

See this, it's actually stuck on acquiring the RTNL.

> Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by kworker/u16:1/8298:
> Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffff888108058d38 ((wq_completion=
)events_unbound){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
> Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffffc9000abcfe58 ((work_completi=
on)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x18f/0x4e0
> Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffff888122e60768 (&rdev->wiphy.m=
tx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0x1a/0xc0 [cfg80211]

And this is stuck trying to acquire the wiphy mutex.

> Feb 26 06:01:45 ct523c-0b0b kernel: 3 locks held by ip/28125:
> Feb 26 06:01:45 ct523c-0b0b kernel:  #0: ffffffff82a6d588 (rtnl_mutex){+.=
+.}-{4:4}, at: rtnetlink_rcv_msg+0x13e/0x620
> Feb 26 06:01:45 ct523c-0b0b kernel:  #1: ffff888122e60768 (&rdev->wiphy.m=
tx){+.+.}-{4:4}, at: ieee80211_stop+0x2d/0x180 [mac80211]
> Feb 26 06:01:45 ct523c-0b0b kernel:  #2: ffff88812661d768 (&sb->s_type->i=
_mutex_key#3){++++}-{4:4}, at: simple_recursive_removal+0x189/0x2b0

This has them all.

johannes

