Return-Path: <linux-wireless+bounces-18038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36727A1DAB0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87D991624F0
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513551632EF;
	Mon, 27 Jan 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="CahGMRhu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2C15E5B8
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995872; cv=none; b=M1Il4QS3O1uaAE+M6kWt2tK0feEmErKoAiChEgi/iOwL7njza/83QxI/1ZEBhWsz5Kt5W4h1CueNhJ2CxDVQfVW6hX+HCVMMxj+WkFzlH16t29Y4Hol6CDuQ0J5/Sh1Xbqd5B+LqkonqPElqFs3D5SDTxTjQYAA+Kb0h376F5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995872; c=relaxed/simple;
	bh=asvP/s0jkB+sFcFk8fTq/BV6CORl0BH26uPdS8DYRu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3QAOqtdSpMV2GCj1w6cDyMuj/p2kwHKkSqC7aQhBN3cUNtc1YL3HU7QqM/f4yDew76Htp1jKC5tCn7M1u1hrNa2qTdDWawjzjYFndvwA/pmIpWcTElKuAC2d/YM3SU/cMfdDzVfzVyQvMV5dNBfshb4b/rioZbr7i5EgcUP7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=CahGMRhu; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995297;
	bh=asvP/s0jkB+sFcFk8fTq/BV6CORl0BH26uPdS8DYRu0=;
	h=From:To:Cc:Subject:Date;
	b=CahGMRhuEKlEM5m7lbPQQrUJ95GC+wxfZxqzdZIZYi4vz/NTzz8bjz4zXvZwKx0Bg
	 Z1kz2jAWWkEBMA2GcD98o2zR0qPCHA+mWijr7ceuZrOhHppAF7pUnijH2Vnp7EuKnf
	 gD7g6VpiRnp3O004lS6+KpyFawXsPPZLAnqpDnZc=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [RFC PATCH 00/13] Convert mac80211 to TXQs only
Date: Mon, 27 Jan 2025 17:26:12 +0100
Message-ID: <20250127162625.20747-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This converts mac80211 to only use TXQs internally, moves TX into
a kthread and picks up some easy optimizations on the way.

The patches should all have merge-quality and are working both with
iwlmvm (as station) and with the hostapd tests without any known issues.
(Short of not yet including the PS and filtered frame migration to TXQs.)

The first three patches are mostly unrelated for the TXQ move.
When these are ok for you I could submit them independently, cutting
them off here.

Here a short overview of the patches in the series:
  wifi: mac80211: Fix virtual monitor interface creation
	This basically covers questions I have about the monitor handling,
	just posed as a patch. (It has it's own comment section).

  wifi: mac80211: Fix debugfs handling for virtual monitor
	Found during QA testing of this series. Otherwise unrelated.
	
  wifi: mac80211: Cleanup sta TXQs on flush
	Another thing I found during QA while working on an unrelated
	regression I caused.

  wifi: mac80211: Always provide the MMPDU TXQ
	When only using TXQs for TX we can't have this queue optionally.
	We probably want to discuss how to make that mandatory for all
	drivers with native TXQ support. But this works, allowing to
	soften the probably desired updates to (some) TXQ drivers.

  wifi: mac80211: Convert vif->txq to an array
	We need some more TXQs for the patch below. STA TXQs are already
	in an array, so just put the VIF TXQ into one, too.

  wifi: mac80211: Add new TX queues to replace legacy TX
	This here starts the "core" of the patch series.
	It's creating all the missing TXQs and updates the support
	function for them. It also directly switches traffic to them,
	when possible. (Only offchannel is sticking to legacy TX here.)

  wifi: mac80211: Stop using legacy TX path
	This is dropping the legacy TX support and moves offchannel TX to
	the new alternate TXQ path: So far named TXQ_NOQUEUE.
	With that mac80211 has two TX paths both using TXQ:
	 - The existing one, which uses the TXQ for queuing and
	 - TXQ_NOQUEUE. Which just puts frames into a TXQ and
	   immediately sends out the frame by also calling drv_tx() for
	   it. There never can be more than one frame in any of these
	   TXQs. They never see a wake_tx_queue call by the driver or
	   mac80211.

  wifi: mac80211: Call ieee80211_tx_h_select_key only once
	This is just a simple drive-by optimization. Not needed.

  wifi: mac80211: Rename IEEE80211_TX_INTFL_OFFCHAN_TX_OK
	Also functionality irrelevant. Just seems to be a good way to use
	that as the official selector for the TXQ_NOQUEUE path and
	represent that in the name.

  wifi: mac80211: Simplify AMPDU handling
	Also a kind of drive-by optimization. Uses TXQs to buffer frames
	when AMPDU is started/stopped and even gets rid
	IEEE80211_QUEUE_STOP_REASON_AGGREGATION.

  wifi: mac80211: Migrate TX to kthread
	Moves all TX operation except TXQ_NOQUEUE to a new kthread.
	This hooks into the existing txq scheduling and uses local->active_txqs
	to determine which TXQs need to run. We may also consider 
	forcing all drivers to use ieee80211_txq_schedule_start() to get
	rid of the code figuring that out per run...

  wifi: mac80211: Drop wake_txqs_tasklet
	Another drive-by cleanup/optimization which became possible due
	to the kthread patch above.

  wifi: mac80211: Cleanup *ieee80211_wake_txq* naming
	And finally a patch just renaming a few functions. Not sure if
	that avoids or adds confusion... 

As an outline:
When there are no fundamental concerns of the mayor changes in this
series I would try again to pick apart the PS buffering and filtered
frame mess. Which probably will have to be in one patch. Last time I tried
that without kthread it was not possible to rip it out independently.


From a performance point of view this series seems to be ok...
I did run some quick tests with my "normal" home network close to an
stil unpatched AP: 60s long tests with iperf3 using tcp got between
484-524 MBit/s while the patched kernel was between 471-521MBit/s using
SMP. Uniprocessor performance is better in both cases, 484-530MBit/s for
the original and 563-676 MBIT/s for the patched variant.

Alexander
---

 drivers/net/wireless/ath/ath10k/mac.c         |   8 +-
 drivers/net/wireless/ath/ath9k/ath9k.h        |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   6 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |   3 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   5 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |   4 +-
 drivers/net/wireless/realtek/rtw88/main.c     |   2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   2 +-
 include/net/mac80211.h                        |  56 +-
 net/mac80211/agg-tx.c                         | 129 +---
 net/mac80211/cfg.c                            |  17 +-
 net/mac80211/debugfs_netdev.c                 |  46 +-
 net/mac80211/debugfs_sta.c                    |   2 -
 net/mac80211/driver-ops.h                     |  34 +-
 net/mac80211/ethtool.c                        |   7 +-
 net/mac80211/ieee80211_i.h                    |  35 +-
 net/mac80211/iface.c                          | 175 +++--
 net/mac80211/main.c                           |   9 +-
 net/mac80211/mesh.c                           |  13 +-
 net/mac80211/mlme.c                           |   2 +-
 net/mac80211/offchannel.c                     |   2 +-
 net/mac80211/pm.c                             |   1 -
 net/mac80211/rx.c                             |  11 +-
 net/mac80211/scan.c                           |   4 +-
 net/mac80211/sta_info.c                       |   6 +-
 net/mac80211/sta_info.h                       |  30 +-
 net/mac80211/tx.c                             | 616 ++++--------------
 net/mac80211/util.c                           | 160 +++--
 33 files changed, 566 insertions(+), 845 deletions(-)

-- 
2.48.1


