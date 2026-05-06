Return-Path: <linux-wireless+bounces-36004-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEhhEA4g+2kgWwMAu9opvQ
	(envelope-from <linux-wireless+bounces-36004-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 13:03:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE644D9933
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B74C3014C79
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC023043DE;
	Wed,  6 May 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vhU3Cb/a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8234D3242D4;
	Wed,  6 May 2026 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778065418; cv=none; b=nKrG1rMOBaed86ty73LZ7H5E9qlooA9XI/37Uz6TUFc6cdstphE3R1D7c1XAorguTWKeh6Qee/NaW7pDi2SLZ5gQDOJJVHnxU98muFuFA8oP4M/MMikj/HpN61/BuHPlhsUhPStkD10woAhnDlCGix1kRp6VrD3LWC592dlStVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778065418; c=relaxed/simple;
	bh=zJr9SqqlFI5ReysBiBKbxWRqkPNdI0+Vp2XCnwSy1u4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRZwMIUrTK3hQLBPny4XUX9pTXGb1I6P5S2XJMzViCU0ZAl+ALkYp8ug3A1xZuD1hFy6FZwO4JypmmFiLNe9PsJfwpYatzrdLYbsdZ0jpjHxIiyJ+5UdZZZvIoiPZcYSOUpAbbE/e0YnSe+BVUYYhlzEvKGYeAPTd5YdhTtMbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vhU3Cb/a; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=JlEr0rOa2USNOpEJAh1sMDlA42EkeWQIdKE09IQgiRQ=; t=1778065416; x=1779275016; 
	b=vhU3Cb/ahziU4/JR/bcV/bUGc2qFlFNoYJyVaMUSPQMCXIma01xsTVU822y+IgJtANIB1ophADw
	CNVgFycLQW13g1Gm+X6WgP1wDiSDXVdd6Z+ldtmXUy3W0YgkGVIgiJCUPuMwO7BVi6IaZQRxILR/c
	gTUS8DfNbImimVxxv2uxRUaQN7YZfy/YICCJ77erztEs0X4P99sAvrMKKkclC+HP/pSoCvQUMeq0b
	fQC5oCcLqAS1GE410e3IqkSHwlm3OHCd7qoHL/mPUnRC4n7POfFyjvRRxVg9iRZ2wXBZMWzD51Y4A
	oXK6J2wJ8GxxerVV9Y4w/xYI6Y6GjyPCoKVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wKa2K-00000000yOR-1qQh;
	Wed, 06 May 2026 13:03:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-2026-05-06
Date: Wed,  6 May 2026 13:01:56 +0200
Message-ID: <20260506110325.219675-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AAE644D9933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-36004-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

More content given last week's kunit failure, but I've fixed
that now, sorry about that. Things are all over really.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2026-05-06

for you to fetch changes up to 79240f3f6d766b342b57c32397d643e1cfa26b81:

  wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump() continuation (2026-05-06 11:08:41 +0200)

----------------------------------------------------------------
Quite a number of fixes now:
 - mac80211
   - remove HT NSS validation to work with broken APs
     (with a kunit fix now)
   - remove 'static' that could cause races
   - check station link lookup before further processing
   - fix use-after-free due to delete in list iteration
   - remove AP station on assoc failures to fix crashes
 - ath12k
   - fix OF node refcount imbalance
   - fix queue flush ("REO update") in MLO
   - fix RCU assert
 - ath12k:
   - fix Kconfig with POWER_SEQUENCING
   - fix WMI buffer leaks on error conditions
   - don't use uninitialized stack data when processing RSSI events
   - fix logic for determining the peer ID in the RX path
 - ath5k: fix a potential stack buffer overwrite
 - rsi: fix thread lifetime race
 - brcmfmac: fix potential UAF
 - nl80211:
   - stricter permissions/checks for PMK and netns
   - fix netlink policy vs. code type confusion
 - cw1200: revert a broken locking change
 - various fixes to not trust values from firmware

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: fix OF node refcount imbalance in WSI graph traversal

Amir Mohammad Jahangirzad (1):
      wifi: libertas: fix integer underflow in process_cmdrequest()

Baochen Qiang (2):
      wifi: ath12k: prepare REO update element only for primary link
      wifi: ath12k: fix peer_id usage in normal RX path

Bart Van Assche (1):
      wifi: cw1200: Revert "Fix locking in error paths"

Benjamin Berg (1):
      wifi: mac80211: use safe list iteration in radar detect work

Catherine (1):
      wifi: mac80211: drop stray 'static' from fast-RX rx_result

Dmitry Baryshkov (1):
      wifi: ath10k: snoc: select POWER_SEQUENCING

Jakov Novak (1):
      wifi: libertas: notify firmware load wait on disconnect

Jeongjun Park (1):
      wifi: rsi: fix kthread lifetime race between self-exit and external-stop

Jiri Slaby (SUSE) (1):
      wifi: ath5k: do not access array OOB

Johannes Berg (5):
      Merge tag 'ath-current-20260427' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: tests: mark HT check strict
      Merge tag 'ath-current-20260505' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      wifi: mac80211: remove station if connection prep fails
      wifi: nl80211: fix NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST usage

Maoyi Xie (2):
      wifi: nl80211: require CAP_NET_ADMIN over the target netns in SET_WIPHY_NETNS
      wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump() continuation

Marek Szyprowski (1):
      wifi: brcmfmac: Fix potential use-after-free issue when stopping watchdog task

Michael Bommarito (2):
      wifi: nl80211: require admin perm on SET_PMK / DEL_PMK
      wifi: mac80211: check ieee80211_rx_data_set_link return in pubsta MLO path

Nicolas Escande (1):
      wifi: ath12k: fix leak in some ath12k_wmi_xxx() functions

Rameshkumar Sundaram (1):
      wifi: ath12k: initialize RSSI dBm conversion event state

Rio Liu (1):
      wifi: mac80211: skip ieee80211_verify_sta_ht_mcs_support check in non-strict mode

Tristan Madani (2):
      wifi: b43: enforce bounds check on firmware key index in b43_rx()
      wifi: b43legacy: enforce bounds check on firmware key index in RX path

Yu-Hsiang Tseng (1):
      wifi: ath12k: use lockdep_assert_in_rcu_read_lock() for RCU assertions

 drivers/net/wireless/ath/ath10k/Kconfig            |   1 +
 drivers/net/wireless/ath/ath12k/core.c             |  77 +++++++++------
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   5 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   2 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |   2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              | 105 +++++++++++++++++----
 drivers/net/wireless/ath/ath5k/base.c              |   3 +-
 drivers/net/wireless/broadcom/b43/xmit.c           |   3 +-
 drivers/net/wireless/broadcom/b43legacy/xmit.c     |   3 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   6 +-
 drivers/net/wireless/marvell/libertas/if_usb.c     |   6 +-
 drivers/net/wireless/rsi/rsi_common.h              |   5 +-
 drivers/net/wireless/st/cw1200/pm.c                |   2 -
 net/mac80211/mlme.c                                |  18 +++-
 net/mac80211/rx.c                                  |   6 +-
 net/mac80211/tests/chan-mode.c                     |   1 +
 net/mac80211/util.c                                |   4 +-
 net/wireless/nl80211.c                             |  27 ++++++
 net/wireless/pmsr.c                                |   2 +-
 19 files changed, 208 insertions(+), 70 deletions(-)

