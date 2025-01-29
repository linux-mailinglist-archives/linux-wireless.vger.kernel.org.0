Return-Path: <linux-wireless+bounces-18120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1EDA218F3
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 09:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452843A5864
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07B1B393A;
	Wed, 29 Jan 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="yL9N9c6O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F4D1B0F34
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738138911; cv=none; b=KTvCvYyQNd/yP7u1WziQ8c6FH6BkypR5IWRczT9QQBiyszz9tDbCINVyhsRBFc/ep8Z8LwTx6RBa93ypClbNiPYgEmLhqobCrygYVglxn0ADld49701oqm0RPdq+QmgrrctRQ702PU7PJYVfQO5bKXFn+JFCthBfl+jLiflJd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738138911; c=relaxed/simple;
	bh=j8dWlgYdDZ0/TK+GeHIe3Ly566ISZlZRIFEYzePfrzE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPNzQwfNUpj5JOqkTtjIlMDZkvNI4Qwmny44OCHO7RFWbb1VlAOaWXhhzY6JDaKczQUuTYddWbsj+tsgf/oenxlPJppqS8TnQ4e9y11JlUM4H6DeOZ/VHTFTUVNRX4ZzjixkdceZWJ0mZqeX8dvHWvhQ6qfo4QeQJ02Ies+LXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=yL9N9c6O; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0NT8oj1wlvrYobuuBbQBIy3MNCBcJKeqz4o3IZamgk4=;
	t=1738138909; x=1739348509; b=yL9N9c6O98s88uO94974juAkgGIEkfavk3ZG4AVfNz6Km/j
	H0vwOC/2MY1dfGXWJGUy/+4OpzYQEEKgYPExiIGArRowKtVff/O4oqcmm7mwdH76/BQbnyFR9HQdm
	BSQYwy/3AmF9G3xKm+MO9/CTTeWpkJ+m3lVTlpTkk+ilggZ4al7ZlwpgidtGcsUznp1SUFtw3PeiN
	xfSVvoQD1BtCTx15KyH4E3agQWEpeNjH7q+q4tHIDCElq9o9AqylAugyHIVr3dmh0iHykCUink1CN
	+FdfPnUOKi1GLo5ijw25c1o9zMYinrdWgHfCvomyKT899QQAtIU7e6R9cmDo39Hw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1td3KU-0000000DrYE-3Vcg;
	Wed, 29 Jan 2025 09:21:47 +0100
Message-ID: <7d137eb815889fcad9b93b0d45c5957a698e98e4.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 00/13] Convert mac80211 to TXQs only
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 29 Jan 2025 09:21:46 +0100
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,
Nice! I haven't gotten through it all yet, just some comments here also:
>=20
> Here a short overview of the patches in the series:
>   wifi: mac80211: Fix virtual monitor interface creation
> 	This basically covers questions I have about the monitor
handling,
> 	just posed as a patch. (It has it's own comment section).

Right, see my comments there.

>   wifi: mac80211: Fix debugfs handling for virtual monitor
> 	Found during QA testing of this series. Otherwise unrelated.

Haven't really figured this one out, I should ask Benjamin to take a
look.

>   wifi: mac80211: Cleanup sta TXQs on flush
> 	Another thing I found during QA while working on an unrelated
> 	regression I caused.

That looks fine, I think.

>   wifi: mac80211: Always provide the MMPDU TXQ
> 	When only using TXQs for TX we can't have this queue optionally.
> 	We probably want to discuss how to make that mandatory for all
> 	drivers with native TXQ support. But this works, allowing to
> 	soften the probably desired updates to (some) TXQ drivers.

Yeah not sure how we could deal with the drivers - after all none other
than iwlwifi opted in to this, I think, even through it exists for quite
a while now.

>   wifi: mac80211: Convert vif->txq to an array
> 	We need some more TXQs for the patch below. STA TXQs are already
> 	in an array, so just put the VIF TXQ into one, too.

Sure, looks mostly fine.

>   wifi: mac80211: Add new TX queues to replace legacy TX
> 	This here starts the "core" of the patch series.
> 	It's creating all the missing TXQs and updates the support
> 	function for them. It also directly switches traffic to them,
> 	when possible. (Only offchannel is sticking to legacy TX here.)

I only got to this one for the individual reviews.

>   wifi: mac80211: Stop using legacy TX path
> 	This is dropping the legacy TX support and moves offchannel TX to
> 	the new alternate TXQ path: So far named TXQ_NOQUEUE.
> 	With that mac80211 has two TX paths both using TXQ:
> 	 - The existing one, which uses the TXQ for queuing and
> 	 - TXQ_NOQUEUE. Which just puts frames into a TXQ and
> 	   immediately sends out the frame by also calling drv_tx() for
> 	   it. There never can be more than one frame in any of these
> 	   TXQs. They never see a wake_tx_queue call by the driver or
> 	   mac80211.

Just reading the description I wondered what we gain here, but of course
all the internal code path differences are removed, that's nice :-)

>   wifi: mac80211: Call ieee80211_tx_h_select_key only once
> 	This is just a simple drive-by optimization. Not needed.

Also I guess independent?

>   wifi: mac80211: Rename IEEE80211_TX_INTFL_OFFCHAN_TX_OK
> 	Also functionality irrelevant. Just seems to be a good way to use
> 	that as the official selector for the TXQ_NOQUEUE path and
> 	represent that in the name.

makes sense

>   wifi: mac80211: Simplify AMPDU handling
> 	Also a kind of drive-by optimization. Uses TXQs to buffer frames
> 	when AMPDU is started/stopped and even gets rid
> 	IEEE80211_QUEUE_STOP_REASON_AGGREGATION.

That's nice though, also a really nice cleanup. Not sure I'd necessarily
call it an optimisation.

>   wifi: mac80211: Migrate TX to kthread
> 	Moves all TX operation except TXQ_NOQUEUE to a new kthread.
> 	This hooks into the existing txq scheduling and uses local->active_txqs
> 	to determine which TXQs need to run. We may also consider=20
> 	forcing all drivers to use ieee80211_txq_schedule_start() to get
> 	rid of the code figuring that out per run...

Forcing drivers is always hard ... will need to take a closer look at
this.

>   wifi: mac80211: Drop wake_txqs_tasklet
> 	Another drive-by cleanup/optimization which became possible due
> 	to the kthread patch above.

Feels a bit like that should just be part of the kthread patch? Why keep
a useless tasklet around after that?

>   wifi: mac80211: Cleanup *ieee80211_wake_txq* naming
> 	And finally a patch just renaming a few functions. Not sure if
> 	that avoids or adds confusion...=20

:)

> As an outline:
> When there are no fundamental concerns of the mayor changes in this
> series I would try again to pick apart the PS buffering and filtered
> frame mess. Which probably will have to be in one patch. Last time I trie=
d
> that without kthread it was not possible to rip it out independently.

I don't see _fundamental_ concerns right now, but I'd probably still
hold off on that for a while, perhaps even put that into a separate
kernel release just in case?

> From a performance point of view this series seems to be ok...

:)

> I did run some quick tests with my "normal" home network close to an
> stil unpatched AP: 60s long tests with iperf3 using tcp got between
> 484-524 MBit/s while the patched kernel was between 471-521MBit/s using
> SMP. Uniprocessor performance is better in both cases, 484-530MBit/s for
> the original and 563-676 MBIT/s for the patched variant.

Interesting.

Thanks for doing this! I need to review it much more carefully, but it
looks really nice as far as I've seen.

johannes

