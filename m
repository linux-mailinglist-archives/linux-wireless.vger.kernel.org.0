Return-Path: <linux-wireless+bounces-5402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B47C88EF0A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 20:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065E829F8C7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 19:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8D7152DEE;
	Wed, 27 Mar 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnygISV0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EC914F138;
	Wed, 27 Mar 2024 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566826; cv=none; b=A0lXclHZczJHwEyc9XjHVO/UOLW6SBX4uoDcCPVWzN0xDVE79yWWImFvRJR0MoIahwoCcxXjetN+RlwAn+pq8dkBu2tfKpRSymQ9BMDd5Z9u2wo/sBH+8jSm6v3opOfLSrxe1uOpw96lFwyyju+ujrjb6pFMmi97x6/Bgw4pxTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566826; c=relaxed/simple;
	bh=NckPbqFmFfNbzUcph+tZohyESREqpmqBmwqXhaXExZg=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=GYY67mbi4k9+2Iaenz955KpMZLwUHSj2KB8xM+neV+gyND5i4lJwXv5UUylcUuOCqy7qrbcv3ltCK/6KfyYn/SV84y1Vg/90krsEq23/CTby6iLcg5Fnq051zlWKJGug2B1Lbs/eNGc4l9lCNGHBJjJcKyUiJ/s/YhnrZZClkb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnygISV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1EAC433C7;
	Wed, 27 Mar 2024 19:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711566826;
	bh=NckPbqFmFfNbzUcph+tZohyESREqpmqBmwqXhaXExZg=;
	h=From:Subject:To:Cc:Date:From;
	b=DnygISV04hQ8NKdBvFgRPDxuG91zuhhlFqIazTprT7FcScLKrvauNTFWETjcpfkrZ
	 IWVf5otvzTLnzO5C0maLuxtqflA/kdhnbu5wB6NOEWjLedGsKK1LvvGpA9GmiAhN8a
	 a6u5UYbnZTkFLMFgXqhRdFSmTFrUltXMFsRPFhFayycv3Pfu9Igboq+AoPvsJatx7c
	 9uRj//+rDi+p8+BV2WI6/vy8fTuQOB4b9/CxbkTjkGWEmgpFvDn5ta3+QVGBsAyF0I
	 g7DcaXXHa95epygHd5fFAr32R0aRjkmtVkfwDcYk9MbZ/K0ip8MF0nGfhlXWZ+nnKI
	 dvkXvNK8p8lxA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-03-27
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240327191346.1A1EAC433C7@smtp.kernel.org>
Date: Wed, 27 Mar 2024 19:13:45 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit 67072c314f5f0ec12a7a51a19f7156eebb073654:

  Merge branch 'tcp-rds-fix-use-after-free-around-kernel-tcp-reqsk' (2024-03-12 18:56:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-03-27

for you to fetch changes up to 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c:

  MAINTAINERS: wifi: mwifiex: add Francesco as reviewer (2024-03-26 14:31:09 +0200)

----------------------------------------------------------------
wireless fixes for v6.9-rc2

The first fixes for v6.9. Ping-Ke Shih now maintains a separate tree
for Realtek drivers, document that in the MAINTAINERS. Plenty of fixes
for both to stack and iwlwifi. Our kunit tests were working only on um
architecture but that's fixed now.

----------------------------------------------------------------
Ayala Beker (1):
      wifi: mac80211: correctly set active links upon TTLM

Benjamin Berg (2):
      wifi: iwlwifi: mvm: guard against invalid STA ID on removal
      wifi: iwlwifi: mvm: include link ID when releasing frames

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: pick the version of SESSION_PROTECTION_NOTIF

Felix Fietkau (1):
      wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Francesco Dolcini (1):
      MAINTAINERS: wifi: mwifiex: add Francesco as reviewer

Igor Artemiev (1):
      wifi: cfg80211: fix rdev_dump_mpp() arguments order

Ilan Peer (1):
      wifi: iwlwifi: mvm: Configure the link mapping for non-MLD FW

Jeff Johnson (1):
      wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc

Johan Hovold (1):
      wifi: mac80211: fix mlme_link_id_dbg()

Johannes Berg (8):
      wifi: cfg80211: add a flag to disable wireless extensions
      wifi: iwlwifi: mvm: disable MLO for the time being
      wifi: mac80211: fix prep_connection error path
      wifi: iwlwifi: mvm: rfi: fix potential response leaks
      wifi: iwlwifi: fw: don't always use FW dump trig
      wifi: iwlwifi: read txq->read_ptr under lock
      wifi: iwlwifi: mvm: handle debugfs names more carefully
      kunit: fix wireless test dependencies

Ping-Ke Shih (2):
      wifi: rtw89: coex: fix configuration for shared antenna for 8922A
      MAINTAINERS: wifi: add git tree for Realtek WiFi drivers

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: consider having one active link

 MAINTAINERS                                        |  6 +++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        | 15 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        | 16 +++---
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   | 11 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      | 59 +++++++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  9 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  7 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c       |  8 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      | 20 +++-----
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  5 +-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c      |  2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  2 +-
 include/net/cfg80211.h                             |  2 +
 net/mac80211/cfg.c                                 |  5 +-
 net/mac80211/debug.h                               |  2 +-
 net/mac80211/ieee80211_i.h                         |  4 +-
 net/mac80211/mlme.c                                | 15 ++++--
 net/wireless/trace.h                               |  2 +-
 net/wireless/wext-core.c                           |  7 ++-
 tools/testing/kunit/configs/all_tests.config       |  2 +
 21 files changed, 138 insertions(+), 65 deletions(-)


