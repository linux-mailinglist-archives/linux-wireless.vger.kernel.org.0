Return-Path: <linux-wireless+bounces-28867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 857EAC521FE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 12:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 603584F4E91
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 11:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB03313E0A;
	Wed, 12 Nov 2025 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oetBiFmq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BB2FD684;
	Wed, 12 Nov 2025 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762948292; cv=none; b=hSpmPSRI2KKIHzuLWAKIM6dmH36CBg5f6wOYZAjBIn5p19J4SMEwWIyGH+CciiUvhl1sMT46RrbqsD+MIRfMSBjYhLnWOvvH0614Ua8CzROKppcCNdxp87JAJmwPU4iulFLCQ2TGDWsM5lFQmC6HIChL3WLu63f8zL8WO5LcGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762948292; c=relaxed/simple;
	bh=Y+iMD70VypAUzl02NICb5IqHFNnGm8eBBPfehbkZgw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HkAeOgLp2mRk5qGhgaon080DyH/B7L0lc094DbJVXx3V7UIjp4F6EGE/o+MG8D9u0OZpR3gpRw/56rraR+WMe1LVdW1LCGDOPPCEcNUUFbVdvQN9Lq5BM+dJqC3p3S6YDAksjaa90910e0L2s+j1ttUzeS68KLgpDE/CLOsFuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oetBiFmq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=uSqtUxqoSTeI2ScF7umWBQZMcaL6Cd1hNoT1xrRtbIY=; t=1762948290; x=1764157890; 
	b=oetBiFmqGFvB95wnnJAg1GdBYNeyC6OJ5spGq2j4LteUfC20wH4agZaydzy3hwhWfgAGRsqMHi1
	ll+aO1UEbdjNsDLfmZ30Nt1I9NQY/9/ktbm2RD8f/vX5JRwhZqAZ5jRqwHjfc40dbNm6cSssVxoWC
	zzv7K6thQ8Zxm5NI9UITmi+D5Vfet1sRS4ypeBRLxJQr8OiZ4K1YcDawYRAjlZm3oSOT8vxgWallv
	6C0K+RURipn70mi+rLTBGeWB4M7ZswUuFJyf5hVjZDtvIm7uqlSWYEUnijpEAeTUuI+VEQLIXUc5O
	kcr4UTEgaYxi87b4b25BFzzDalCTr5FOpNzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vJ9No-00000001CTN-2CPZ;
	Wed, 12 Nov 2025 12:51:28 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-11-12
Date: Wed, 12 Nov 2025 12:50:29 +0100
Message-ID: <20251112115126.16223-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

And a little bit more stuff for -next as well, but
Jeff informs me that Qualcomm has a lot pending from
their refactor side-branch that reworks the ath12k
driver architecture towards their WiFi8 chipsets,
which will come soon.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 1ec9871fbb80ba7db84f868f6aa40d38bc43f0e0:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-11-06 09:27:40 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-11-12

for you to fetch changes up to 0eb272033b64ef05fffa30288284659c33e17830:

  Merge tag 'ath-next-20251111' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath (2025-11-12 09:56:28 +0100)

----------------------------------------------------------------
More -next material, notably:
 - split ieee80211.h file, it's way too big
 - mac80211: initial chanctx work towards NAN
 - mac80211: MU-MIMO sniffer improvements
 - ath12k: statistics improvements

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: cw1200: Fix potential memory leak in cw1200_bh_rx_helper()

Benjamin Berg (2):
      wifi: mac80211: track MU-MIMO configuration on disabled interfaces
      wifi: mac80211: make monitor link info check more specific

Chien Wong (1):
      wifi: cfg80211: fix doc of struct key_params

Emmanuel Grumbach (1):
      wifi: cfg80211: use a C99 initializer in wiphy_register

Johannes Berg (18):
      wifi: ieee80211: split mesh definitions out
      wifi: ieee80211: split HT definitions out
      wifi: ieee80211: split VHT definitions out
      wifi: ieee80211: split HE definitions out
      wifi: ieee80211: split EHT definitions out
      wifi: ieee80211: split S1G definitions out
      wifi: ieee80211: split P2P definitions out
      wifi: ieee80211: split NAN definitions out
      wifi: cfg80211: fix EHT typo
      wifi: mac80211: fix EHT typo
      wifi: mac80211: make link iteration safe for 'break'
      wifi: mac80211: remove chanctx to link back-references
      wifi: mac80211: simplify ieee80211_recalc_chanctx_min_def() API
      wifi: mac80211: add and use chanctx usage iteration
      wifi: mac80211: remove "disabling VHT" message
      wifi: mac80211: pass frame type to element parsing
      wifi: mac80211: remove unnecessary vlan NULL check
      Merge tag 'ath-next-20251111' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Manish Dharanenthiran (2):
      wifi: ath12k: Make firmware stats reset caller-driven
      wifi: ath12k: Fix timeout error during beacon stats retrieval

Pagadala Yesu Anjaneyulu (2):
      wifi: cfg80211/mac80211: clean up duplicate ap_power handling
      wifi: cfg80211/mac80211: Add fallback mechanism for INDOOR_SP connection

 drivers/net/wireless/ath/ath12k/core.c    |    2 -
 drivers/net/wireless/ath/ath12k/core.h    |    1 -
 drivers/net/wireless/ath/ath12k/debugfs.c |    9 +-
 drivers/net/wireless/ath/ath12k/mac.c     |   15 +-
 drivers/net/wireless/ath/ath12k/wmi.c     |   12 +-
 drivers/net/wireless/st/cw1200/bh.c       |    6 +-
 include/linux/ieee80211-eht.h             | 1182 +++++++++++
 include/linux/ieee80211-he.h              |  824 +++++++
 include/linux/ieee80211-ht.h              |  292 +++
 include/linux/ieee80211-mesh.h            |  230 ++
 include/linux/ieee80211-nan.h             |   35 +
 include/linux/ieee80211-p2p.h             |   71 +
 include/linux/ieee80211-s1g.h             |  575 +++++
 include/linux/ieee80211-vht.h             |  236 ++
 include/linux/ieee80211.h                 | 3308 +----------------------------
 include/net/cfg80211.h                    |   34 +-
 include/net/mac80211.h                    |    2 +-
 net/mac80211/agg-rx.c                     |    7 +-
 net/mac80211/cfg.c                        |   47 +-
 net/mac80211/chan.c                       |  397 ++--
 net/mac80211/driver-ops.c                 |    8 +-
 net/mac80211/he.c                         |    6 +-
 net/mac80211/ibss.c                       |   14 +-
 net/mac80211/ieee80211_i.h                |   50 +-
 net/mac80211/iface.c                      |   46 +-
 net/mac80211/link.c                       |    5 -
 net/mac80211/main.c                       |    3 +-
 net/mac80211/mesh.c                       |   26 +-
 net/mac80211/mesh_hwmp.c                  |    7 +-
 net/mac80211/mesh_plink.c                 |    7 +-
 net/mac80211/mlme.c                       |   71 +-
 net/mac80211/parse.c                      |   30 +-
 net/mac80211/scan.c                       |    6 +-
 net/mac80211/tdls.c                       |   12 +-
 net/mac80211/tests/elems.c                |    4 +-
 net/mac80211/util.c                       |   37 +-
 net/wireless/core.c                       |   12 +-
 net/wireless/core.h                       |    3 +-
 net/wireless/nl80211.c                    |    4 +-
 net/wireless/scan.c                       |   20 +-
 40 files changed, 4003 insertions(+), 3653 deletions(-)
 create mode 100644 include/linux/ieee80211-eht.h
 create mode 100644 include/linux/ieee80211-he.h
 create mode 100644 include/linux/ieee80211-ht.h
 create mode 100644 include/linux/ieee80211-mesh.h
 create mode 100644 include/linux/ieee80211-nan.h
 create mode 100644 include/linux/ieee80211-p2p.h
 create mode 100644 include/linux/ieee80211-s1g.h
 create mode 100644 include/linux/ieee80211-vht.h

