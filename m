Return-Path: <linux-wireless+bounces-221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1007FDACA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 16:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE0A1C2040B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 15:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECA37177;
	Wed, 29 Nov 2023 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WEf+Zd0n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C577ADD;
	Wed, 29 Nov 2023 07:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=t5xLtxOy4hbrpxKCfhc7jQx0EfqgpSIA0JLhwnMSArI=; t=1701270499; x=1702480099; 
	b=WEf+Zd0nMDBX5NNu5ZLTosZWJdEhHfik6AdvfU77zWVvhFPSNtHCHEMy1tilzLSb+qd9liy28II
	E65dZG0t5hhIQvyjhw09MJMBe85VNrjmYRD4fVUTSbKMZyktQ3DScdgYQZF/k6/MFIEtdptTUP5JM
	wgaELxC14tKIlt2Y/33OcQ6lRa48YuGxr7PY4AuAwMQnHVYtaXwKW7PdIno1D0NqhMWaYN3xdeOpK
	VwQ0R0D+y/6RzE0UFqHRzghe9HSr1txdsWOchi5oru1CssUzBDltG4qxSMFAjab/dWchj9LUfh/fq
	Ws9FRyVAtBIl6t6Qza8hR5yPr0qyKG/0OrOQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r8MAj-00000008lYo-36Yx;
	Wed, 29 Nov 2023 16:08:17 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2023-11-29
Date: Wed, 29 Nov 2023 16:04:24 +0100
Message-ID: <20231129150809.31083-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned

Hi,

Here's the first wireless pull request, see below.

Now that I'm actually preparing this, I'm having second
thoughts on the debugfs lockdep change, since that's a
new 'feature' of sorts, pointing out the deadlocks. I had
that in to actually sort of prove the fix worked, though
I also tested that another way, Greg ACK'ed it, and then
I didn't think about it again. I guess I could revert it
back out, but it doesn't revert cleanly. Lockdep only.

Also there was a fortify build problem report on the CQM
fix that we haven't been able to make sense of, and yet
the CQM fix is the one thing we'd rather have in soon as
it broke quite a few users... Asked Kees about it too,
but no response yet (it was only this morning.)

If that seems OK for now, please pull. Otherwise let me
know if I should revert the debugfs lockdep, and/or wait
for the CQM/fortify issue to get resolved.

Thanks,
johannes



The following changes since commit 55c900477f5b3897d9038446f72a281cae0efd86:

  net: fill in MODULE_DESCRIPTION()s under drivers/net/ (2023-10-28 11:29:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2023-11-29

for you to fetch changes up to 4ded3bfe1db655367642aadba91aee770cbab317:

  wifi: mac80211: use wiphy locked debugfs for sdata/link (2023-11-27 11:25:09 +0100)

----------------------------------------------------------------
wireless fixes:
 - debugfs had a deadlock (removal vs. use of files),
   fixes going through wireless ACKed by Greg
 - support for HT STAs on 320 MHz channels, even if it's
   not clear that should ever happen (that's 6 GHz), best
   not to WARN()
 - fix for the previous CQM fix that broke most cases
 - various wiphy locking fixes
 - various small driver fixes

----------------------------------------------------------------
Ben Greear (1):
      wifi: mac80211: handle 320 MHz in ieee80211_ht_cap_ie_to_sta_ht_cap

Dan Carpenter (1):
      wifi: iwlwifi: mvm: fix an error code in iwl_mvm_mld_add_sta()

Johannes Berg (9):
      wifi: cfg80211: fix CQM for non-range use
      wifi: cfg80211: lock wiphy mutex for rfkill poll
      wifi: cfg80211: hold wiphy mutex for send_interface
      debugfs: fix automount d_fsdata usage
      debugfs: annotate debugfs handlers vs. removal with lockdep
      debugfs: add API to allow debugfs operations cancellation
      wifi: cfg80211: add locked debugfs wrappers
      wifi: mac80211: use wiphy locked debugfs helpers for agg_status
      wifi: mac80211: use wiphy locked debugfs for sdata/link

Lorenzo Bianconi (1):
      wifi: mt76: mt7925: fix typo in mt7925_init_he_caps

Michael-CY Lee (1):
      wifi: avoid offset calculation on NULL pointer

Ming Yen Hsieh (1):
      wifi: mt76: mt7921: fix 6GHz disabled by the missing default CLC config

Oldřich Jedlička (1):
      wifi: mac80211: do not pass AP_VLAN vif pointer to drivers during flush

 drivers/net/wireless/ath/ath9k/Kconfig           |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c  |   1 +
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |   4 +-
 fs/debugfs/file.c                                | 100 ++++++++++++++
 fs/debugfs/inode.c                               |  71 ++++++++--
 fs/debugfs/internal.h                            |  21 ++-
 include/linux/debugfs.h                          |  19 +++
 include/linux/ieee80211.h                        |   4 +-
 include/net/cfg80211.h                           |  46 +++++++
 net/mac80211/Kconfig                             |   2 +-
 net/mac80211/debugfs_netdev.c                    | 150 ++++++++++++++-------
 net/mac80211/debugfs_sta.c                       |  74 ++++++-----
 net/mac80211/driver-ops.h                        |   9 +-
 net/mac80211/ht.c                                |   1 +
 net/wireless/core.c                              |   6 +-
 net/wireless/core.h                              |   1 +
 net/wireless/debugfs.c                           | 160 +++++++++++++++++++++++
 net/wireless/nl80211.c                           |  55 +++++---
 19 files changed, 614 insertions(+), 118 deletions(-)

