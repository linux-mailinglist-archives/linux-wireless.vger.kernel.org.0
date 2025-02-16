Return-Path: <linux-wireless+bounces-19020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DC3A37513
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7246D188DDF3
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FE5199EB2;
	Sun, 16 Feb 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="xwSbaLpm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901D194094
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719952; cv=none; b=NpfbpIlteIpeaptm0thqQi9Cjew9wzjhs0wI6hURI12gs3uxboQVkccGAFrPKXNIo5apr4VIW1oqh9X1T4rYFNIHRTzENVr4A9RpoarTf8TCDBH/ShGUAILuQ1qy3GswyjnDFBgU1moJaYbyUz5ngQoor0atEdQtoZBNTYVLMeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719952; c=relaxed/simple;
	bh=AT6gNZ+ZY9nDCdTLwY2vUjfPAKn5slzsIRsvRqba0N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b9G7ZfGiLrZ5ZkaSGI9mFhNK5kQD70HbaYmSk+mtYvPSGEArdGg0G8mEoeQe3DmeXDZvnw0eu0P9POYbunMQIsae8haOnaxRH8ZwfkKzMkY3dxoI8H6qj8A+JauhISV06lwvq1OOeV+meGi7Dbppx2v5+CTg7h4qHVYQSdg0cRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=xwSbaLpm; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1739719937;
	bh=AT6gNZ+ZY9nDCdTLwY2vUjfPAKn5slzsIRsvRqba0N4=;
	h=From:To:Cc:Subject:Date;
	b=xwSbaLpmkSA9lLayIvbS7j+BrlQN1P6KyFqiKIKHxOBjdzkzhaUCrEcccpsY8lZcO
	 tzhRvRYrjPY0Lf5qfdju2IAouFLF6H3qRLUOvC+/82SCKi+oOaSvqawDhRzHndcDR8
	 cI2Y4YL3H1F3srHspC64NBIDdRuGKvsM5/7kFcYU=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH 00/10] Convert mac80211 to TXQs only
Date: Sun, 16 Feb 2025 16:31:50 +0100
Message-ID: <20250216153200.1318604-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series switches all TX handling in mac80211 over to TXQs.
TXQs can take over buffering in many - potentially even all - cases
where we use separate solutions so far.
This reduces the complexity of the TX path and making it simpler to use
TX in mac8021.

These patches continue the work to get rid of the legacy TX path we
started drivers with
https://lore.kernel.org/r/20221009163040.25637-1-alexander@wetzel-home.de

and was inspired by this old discussion on the wireless mailing list:
https://lore.kernel.org/r/1507217947.2387.60.camel@sipsolutions.net/

Changes compared to RFC v1 are documented in the individual patches.

A quick overview of the patches in the series:
  wifi: mac80211: move rate control setup
	Broken off from "Add new TX queues to replace legacy TX" as
	requested. Moves some exiting code around.

  wifi: mac80211: Always provide the MMPDU TXQ
	When only using TXQs for TX we akways need this.
	Creates and uses MMPDU TXQs even for drivers not supporting
	them.

  wifi: mac80211: Convert vif->txq to an array
	We need some more TXQs for the patch below. Create them.

  wifi: mac80211: Add new TX queues to replace legacy TX
	This starts the core of the move to TXQs.
	Creats all the missing TXQs and updates the support function for
	them. It also directly switches traffic to them, when possible.
	(Only offchannel is sticking to legacy TX after that.)

  wifi: mac80211: Stop using legacy TX path
	Drop the legacy TX functions and move offchannel TX to the new
	alternate TXQ path named TXQ_NOQUEUE (so far).
        With that mac80211 has two TX paths both using TXQ:
         - The existing one, which uses the TXQ for queuing and
         - TXQ_NOQUEUE. Which just puts frames into a TXQ and
           immediately sends out the frame by also calling drv_tx() for
           it. There never can be more than one frame in any of these
           TXQs. They never see a wake_tx_queue call by the driver or
           mac80211.

  wifi: mac80211: Call ieee80211_tx_h_select_key only once
	A optimization which could be without the patches, too. Would
	just be done differently. (Not required)

  wifi: mac80211: Rename IEEE80211_TX_INTFL_OFFCHAN_TX_OK
	Rename the flag used to select the NOQUEU TX path to make its
	use more obvious.

  wifi: mac80211: Simplify AMPDU handling
	Uses TXQs to buffer frames when AMPDU is started/stopped.

  wifi: mac80211: Migrate TX to kthread
	Moves all TX operation except TXQ_NOQUEUE to a new kthread.
        This hooks into the existing txq scheduling and uses
	local->active_txqs to determine which TXQs need to run.

  wifi: mac80211: Cleanup *ieee80211_wake_txq* naming
	Rename a few functions.

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
 include/net/mac80211.h                        |  60 +-
 net/mac80211/agg-tx.c                         | 129 +---
 net/mac80211/cfg.c                            |   8 +-
 net/mac80211/debugfs_netdev.c                 |  46 +-
 net/mac80211/debugfs_sta.c                    |   2 -
 net/mac80211/driver-ops.h                     |  28 +-
 net/mac80211/ieee80211_i.h                    |  32 +-
 net/mac80211/iface.c                          | 144 ++--
 net/mac80211/main.c                           |   9 +-
 net/mac80211/mesh.c                           |  13 +-
 net/mac80211/mlme.c                           |   2 +-
 net/mac80211/offchannel.c                     |   2 +-
 net/mac80211/rx.c                             |  11 +-
 net/mac80211/scan.c                           |   2 +-
 net/mac80211/sta_info.c                       |   6 +-
 net/mac80211/sta_info.h                       |  30 +-
 net/mac80211/tx.c                             | 616 ++++--------------
 net/mac80211/util.c                           | 162 +++--
 31 files changed, 534 insertions(+), 824 deletions(-)

-- 
2.48.1

