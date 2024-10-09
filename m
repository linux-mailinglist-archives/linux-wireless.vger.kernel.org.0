Return-Path: <linux-wireless+bounces-13773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2A996269
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FC01C2204B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6731189915;
	Wed,  9 Oct 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="RNggVLpZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DE187FF2
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462364; cv=none; b=C/pruQp7Voe99RWnGvmeittbBw/7nnneWuGSMwbXW19UvUVYq2Ei/zDme3ip13MrhpifwLyVkZnVjCTB5zhxT/F8cRjCfCgHoiLPau5yovJBU7Ruo0mOTmaYOsjNyZhqFQM9qU9noYD0F6h4zxijq+4jfmpoF+eTX4SlWjpB3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462364; c=relaxed/simple;
	bh=b/yLIkg/yiNfvehRW02BhyWkWPJmKk72iWusrDk8o6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHHjGgfQFxAKlDqbqNLLTWFk/e/aAoA1qi0DC9I0/mjyrMqaJXGurptyeA4dktz5VIiEQH4d/spZE5lfU3K5dPDl+3Gk2cFCIL070Rq/FmT37yxEKUFFtDoRqPLoF6gW1WfzDAsb2Kz3WsEPxeY6id8VU/hBsXlyivgx3KoWTOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=RNggVLpZ; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7l2QtOp5DjY/MwHqoe19TOPD5Gm6OJ6wM+QafhonUok=; b=RNggVLpZXZeAiQmftSIhGyhRA5
	vfRwj1qACIUEylFOuxegAszW92s55wlBkvW4vPcz9ZWGfn6agPzLUgxg9h7ge+Vmn3REz0ZULvR35
	9FHjNUbt18esKrYc9FYSsmM/Q0wGTFWWVs9Nqh1vwucHJLv9QmduyvOwwsv6gLASdY8s=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1syS12-006e0I-2i;
	Wed, 09 Oct 2024 10:25:52 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v5 00/11] wifi: cfg80211/mac80211: improve support for multiple radios
Date: Wed,  9 Oct 2024 10:25:41 +0200
Message-ID: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for restricting vifs to a set of radios.
The allowed radios mask is used to restrict scanning, off-channel activity,
and can be used by the driver to selectively enable monitoring and manage
radio state.
It also adds support for monitoring on multiple channels at the same time.

Changes since RFC:
 - split cfg80211 and mac80211 changes
 - remove mac80211 per-radio tracking for monitor state
 - remove per-radio start/stop calls
 - remove radio index from rx status
 - rewrite multi-channel monitor support

Changes since PATCH:
 - fix commit commit descriptions regarding remain-on-channel
 - fix return code in ibss scan change
 - fix wdev->radio_mask initialization

Changes since PATCH v2:
 - fix build error with tracing on .set_monitor_channel change

Changes since PATCH v3:
 - fix another tracing build error

Changes since PATCH v4:
 - add missing documentation
 - clean up commit description and return code handling for ibss scan
 - do not report invalid radio antenna mask

Felix Fietkau (11):
  wifi: cfg80211: add option for vif allowed radios
  wifi: mac80211: use vif radio mask to limit ibss scan frequencies
  wifi: mac80211: use vif radio mask to limit creating chanctx
  wifi: cfg80211: report per wiphy radio antenna mask
  wifi: mac80211: remove status->ampdu_delimiter_crc
  wifi: cfg80211: pass net_device to .set_monitor_channel
  wifi: mac80211: add flag to opt out of virtual monitor support
  wifi: cfg80211: add monitor SKIP_TX flag
  wifi: mac80211: add support for the monitor SKIP_TX flag
  wifi: mac80211: refactor ieee80211_rx_monitor
  wifi: mac80211: filter on monitor interfaces based on configured channel

 drivers/net/wireless/ath/wil6210/cfg80211.c        |  1 +-
 drivers/net/wireless/marvell/libertas/cfg.c        |  1 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  3 +-
 include/net/cfg80211.h                             | 21 ++++-
 include/net/mac80211.h                             | 12 +--
 include/uapi/linux/nl80211.h                       | 10 ++-
 net/mac80211/cfg.c                                 | 45 ++++++----
 net/mac80211/chan.c                                | 27 +++++-
 net/mac80211/debugfs.c                             |  1 +-
 net/mac80211/driver-ops.c                          |  1 +-
 net/mac80211/ieee80211_i.h                         |  2 +-
 net/mac80211/iface.c                               | 24 +++--
 net/mac80211/rx.c                                  | 71 ++++++++-------
 net/mac80211/scan.c                                | 22 ++---
 net/mac80211/status.c                              |  5 +-
 net/mac80211/tx.c                                  |  6 +-
 net/mac80211/util.c                                | 14 ++-
 net/wireless/chan.c                                |  3 +-
 net/wireless/core.c                                |  2 +-
 net/wireless/core.h                                |  1 +-
 net/wireless/nl80211.c                             | 68 ++++++++++++--
 net/wireless/rdev-ops.h                            |  5 +-
 net/wireless/scan.c                                | 10 +-
 net/wireless/trace.h                               | 10 +-
 net/wireless/util.c                                | 29 ++++++-
 net/wireless/wext-compat.c                         |  2 +-
 26 files changed, 295 insertions(+), 101 deletions(-)

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
git-series 0.9.1

