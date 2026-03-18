Return-Path: <linux-wireless+bounces-33422-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GQ2NAPgumk3cwIAu9opvQ
	(envelope-from <linux-wireless+bounces-33422-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 18:25:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796352C0368
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 18:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2A7830175E7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDDB2F3C22;
	Wed, 18 Mar 2026 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rvtgvTiJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023D2D6E70;
	Wed, 18 Mar 2026 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854721; cv=none; b=c6ahBM0MGwcVyoSl12Yu+9r4d8yMek5GjJINYHEdKz/ZkJfTr4E5gvakNTDv2Cd4ia0Qwl/xMER3xTYqHd7KcYooiJzJQGuvgVyOpj3mF7ayiww4y6OO2wpOEG1HcrYbgRoMgr8Qt26CSf530OYk92qCWbrBfx1IXqccZ/I41RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854721; c=relaxed/simple;
	bh=yu4dATME5kRmTSr6FHbRTvhd/PGjjKeDLagi/M2QyjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gkILLRfX7mPfDSMYUYwrvYfTbOZfhcO24aiJ9wt2CxRInm2OrUTI4Dvk9yd1oU0iCNKorp8vUtR56MnSHDfb1/+PUrAJn3+PbfRgaRVLA2/sAvQ3klksYRPtqstkj0XTzvDLxb9GIXIrX69OU4dpcO3SZfIVm1fs/3v7PtoKbsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rvtgvTiJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=iEV2g761NfyXrHTmNv15Nm2NKnKFbyzlLM+bO3W70Fo=; t=1773854720; x=1775064320; 
	b=rvtgvTiJaVfHBPXK3mxpKT/4zTTrFPmeWnP+UQGhoJdYNW84WaiEr+Nk9wDZl5lj8qxEbXlQ45V
	B+D+qb3bpVxv5hl0FRtMbmUDZc8u52E4f0vqx29hq+xePHFAb0eyOhSY49XjpS6Ekxd9VtGdB+N0j
	QYJjq8jewlasMF5t1CRSQPco5MOcoK1IndV8A1mX6aKLDO5XbLDvdEUkXlfU7rFkKl8S7BcqRpLpT
	yzZLnjZwryE5IMKNiAxFFCTddqn3i6yDo4lUveNrHQ20nrQm367Q7U5BMvmP9lQ2n+rtFDnSw520g
	rsP9NZsfWfJ45Yc3RRG94gtws/C00PjiQXhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w2udy-00000004Zjb-0jCI;
	Wed, 18 Mar 2026 18:25:18 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-03-18
Date: Wed, 18 Mar 2026 18:20:49 +0100
Message-ID: <20260318172515.381148-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33422-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.991];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 796352C0368
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

So maybe a couple more fixes than I'd like, but here we
are, and it's small. I also failed to notice the missing
"wifi:" subject for one of the commits, but didn't rebase
just because of that now.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit abacaf559950eec0d99d37ff6b92049409af5943:

  Merge tag 'net-7.0-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-03-05 11:00:46 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-03-18

for you to fetch changes up to d5ad6ab61cbd89afdb60881f6274f74328af3ee9:

  wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure (2026-03-18 09:09:58 +0100)

----------------------------------------------------------------
Just a few updates:
 - cfg80211:
   - guarantee pmsr work is cancelled
 - mac80211:
   - reject TDLS operations on non-TDLS stations
   - fix crash in AP_VLAN bandwidth change
   - fix leak or double-free on some TX preparation
     failures
   - remove keys needed for beacons _after_ stopping
     those
   - fix debugfs static branch race
   - avoid underflow in inactive time
   - fix another NULL dereference in mesh on invalid
     frames
 - ti/wlcore: avoid infinite realloc loop

----------------------------------------------------------------
Deepanshu Kartikey (1):
      wifi: mac80211: check tdls flag in ieee80211_tdls_oper

Felix Fietkau (2):
      mac80211: fix crash in ieee80211_chan_bw_change for AP_VLAN stations
      wifi: mac80211: always free skb on ieee80211_tx_prepare_skb() failure

Guenter Roeck (1):
      wifi: wlcore: Return -ENOMEM instead of -EAGAIN if there is not enough headroom

Johannes Berg (2):
      wifi: mac80211_hwsim: fully initialise PMSR capabilities
      wifi: mac80211: remove keys after disabling beaconing

Kuniyuki Iwashima (1):
      wifi: mac80211: Fix static_branch_dec() underflow for aql_disable.

Nicolas Cavallari (1):
      wifi: mac80211: use jiffies_delta_to_msecs() for sta_info inactive times

Peddolla Harshavardhan Reddy (1):
      wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down

Xiang Mei (1):
      wifi: mac80211: fix NULL deref in mesh_matches_local()

 drivers/net/wireless/ath/ath9k/channel.c      |  6 ++----
 drivers/net/wireless/mediatek/mt76/scan.c     |  4 +---
 drivers/net/wireless/ti/wlcore/tx.c           |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c |  3 +--
 include/net/mac80211.h                        |  4 +++-
 net/mac80211/cfg.c                            | 12 ++++++------
 net/mac80211/chan.c                           |  6 ++++--
 net/mac80211/debugfs.c                        | 14 +++++---------
 net/mac80211/mesh.c                           |  3 +++
 net/mac80211/sta_info.c                       |  7 +++++--
 net/mac80211/tdls.c                           |  2 +-
 net/mac80211/tx.c                             |  4 +++-
 net/wireless/pmsr.c                           |  1 +
 13 files changed, 36 insertions(+), 32 deletions(-)

