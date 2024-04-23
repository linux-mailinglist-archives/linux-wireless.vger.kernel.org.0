Return-Path: <linux-wireless+bounces-6711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638D8AE183
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8142284F82
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 09:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EA7605CE;
	Tue, 23 Apr 2024 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qAcT6BMt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651551E863;
	Tue, 23 Apr 2024 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866357; cv=none; b=GvCH0aBlx9IF2cBX3WkUiijb5fn4VY+/93gyRg2XFw7M2fgZjSsbzJElNXT3weSPhzz2+klT4eQ6NA3iubPF/KaKjRv8ksKM9TUZP2DBa4lPueTq6xsmJPUxmVo0viCZOWYak2rk47zp/+CEEQ0OxJRb3zA5KZHH8ixCA2G2ngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866357; c=relaxed/simple;
	bh=/9R+h6X+vZp7jCAWC8iiBTXqDopMPtVBVc0rTbp+Ecg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VOduE7q7rWbDnUBL26ruuN89GISE2wHkc3VOfgyVxcIy/b3rDO0uLt2S6nerIMutos0IItB5VaA992wyfh3RHBM76qpX/ZQlXFPMbfmaLeLibWDbhXG6lV2g3eqxLbmlgh0ys8pZzOTaJmEbhqKB6fvAJnmH1DxX0LFOvmFnfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qAcT6BMt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=n/Zk6ZEKvt2M7IEMMBqsu9H/VFuTDxgT/eViZ5CqB0A=; t=1713866355; x=1715075955; 
	b=qAcT6BMtvcO/K4ZNxjQNCPZ+3XKyQpVHgTQTeGdgbpdWeNrAEMnHfAz6HEj6GV1yBRHnY6Hm9+A
	NPWgLq7L2RsocJKBZsWCS45qiSWQImDG09G1DxEwL3Y8U0UNGatS82hzoU/OPe/2VFGmtvSHKJ8mB
	OM06TyABRqYNjwk5I6OXqKHzCxMXg6jTZoMyICrYB2dPh0WAGPdCRolSVEGKjgLr722/ZKc8qtj08
	bBPDJFGDsEj4cRZI5zb/oP6Es1tiP57f+p+fr4VcJR6HDPCI0q+RmLRnraAqgH7mrTcOWrOSx7JWK
	mSON+IWI0DuepgHUR6xEISYJ+MjL2SzfU9Gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzCvg-000000022yu-3A5Y;
	Tue, 23 Apr 2024 11:59:12 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-2024-04-23
Date: Tue, 23 Apr 2024 11:57:37 +0200
Message-ID: <20240423095910.11779-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Probably should've sent some of this earlier, but here we are
now. Mostly stack fixes, but one important (link ID management)
fix for iwlwifi as well, where older devices were completely
broken.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 50108c352db70405b3d71d8099d0b3adc3b3352c:

  Merge tag 'net-6.9-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-03-28 13:09:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-04-23

for you to fetch changes up to 91112fc6212a9be6f3be636d885df9c17395e1a4:

  wifi: iwlwifi: mvm: fix link ID management (2024-04-22 09:42:25 +0200)

----------------------------------------------------------------
Fixes for the current cycle:
 * ath11k: convert to correct RCU iteration of IPv6 addresses
 * iwlwifi: link ID, FW API version, scanning and PASN fixes
 * cfg80211: NULL-deref and tracing fixes
 * mac80211: connection mode, mesh fast-TX, multi-link and
             various other small fixes

----------------------------------------------------------------
Avraham Stern (1):
      wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Felix Fietkau (1):
      wifi: mac80211: split mesh fast tx cache into local/proxied/forwarded

Igor Artemiev (1):
      wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class

Johannes Berg (12):
      wifi: mac80211: check EHT/TTLM action frame length
      wifi: mac80211: don't use rate mask for scanning
      Revert "wifi: iwlwifi: bump FW API to 90 for BZ/SC devices"
      wifi: mac80211: fix idle calculation with multi-link
      wifi: mac80211: mlme: re-parse with correct mode
      wifi: mac80211: mlme: fix memory leak
      wifi: mac80211: mlme: re-parse if AP mode is less than client
      wifi: nl80211: don't free NULL coalescing rule
      wifi: mac80211_hwsim: init peer measurement result
      wifi: mac80211: remove link before AP
      wifi: mac80211: fix unaligned le16 access
      wifi: iwlwifi: mvm: fix link ID management

Kalle Valo (1):
      wifi: ath11k: use RCU when accessing struct inet6_dev::ac_list

Miri Korenblit (1):
      wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

Richard Kinder (1):
      wifi: mac80211: ensure beacon is non-S1G prior to extracting the beacon timestamp field

 drivers/net/wireless/ath/ath11k/mac.c              |  4 ++-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  2 +-
 include/net/mac80211.h                             |  3 ++
 net/mac80211/chan.c                                | 27 +++++++++++++---
 net/mac80211/mesh.c                                |  8 ++++-
 net/mac80211/mesh.h                                | 36 ++++++++++++++++++++--
 net/mac80211/mesh_pathtbl.c                        | 31 +++++++++++++------
 net/mac80211/mlme.c                                | 31 +++++++++++++------
 net/mac80211/rate.c                                |  6 +++-
 net/mac80211/rx.c                                  | 17 ++++++++--
 net/mac80211/scan.c                                |  1 +
 net/mac80211/tx.c                                  | 13 +++++---
 net/wireless/nl80211.c                             |  2 ++
 net/wireless/trace.h                               |  4 +--
 19 files changed, 152 insertions(+), 44 deletions(-)

