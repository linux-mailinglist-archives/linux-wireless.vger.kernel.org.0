Return-Path: <linux-wireless+bounces-13419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E919D98D25C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B9BB22640
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2024 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C642200131;
	Wed,  2 Oct 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="r8Z0F960"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4E1E5016
	for <linux-wireless@vger.kernel.org>; Wed,  2 Oct 2024 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869524; cv=none; b=daoHYQsvZZVEVZ9B054kSu+lF9Uq46bs8d3BOs5N89nJhKWd3U4PFCwQOJea1M/2hgD+6a2uRwOEaM93ARL47nrF32AaNpQon+6aLh7/RysjXb8Zc6mn841yhAaX9z7onzfkZMvaHPjjVAAR24GNqTJwW0EhS3uFkkVRTAx4inE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869524; c=relaxed/simple;
	bh=SpCm3p3WBT801Ibxi/Fh+tY8Af2yZiCMLqlN1wGZohE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPTHmNsmH8yV26BEPsppfRQmMu0zhajyugDbhSJUWIa88ROpt3XQfzDgTtWB7yl/iaxBWurt7E7OoNXwJqoEtdDuAkUKH9EoDzEoqZ78rmybBbFltWCVjWHYScFYciD8B9A1PhvAoGJWFDO9+yZwzwDEqc99IEYwgGF/1MCBN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=r8Z0F960; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+qUotlIyz7A75wBglM2obACWfmRXc7S/U9Jci0fyJU8=; b=r8Z0F960oqGoztJXEKBwfroztB
	D575dHMvworx5GMVMMmHevJC7NdDumH+30V7+YerhpYTv1feRalf90CfyjNFhyY5je3XNgORD2b7X
	8JMFy5c6laDUmfOf471i7XkEsUpoTxUwCoVZn99Z92Eon341sQuavYsVh9lBNclXle7k=;
Received: from p4ff130c8.dip0.t-ipconnect.de ([79.241.48.200] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1svxnB-003vyr-2R;
	Wed, 02 Oct 2024 13:45:17 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 00/11] wifi: cfg80211/mac80211: improve support for multiple radios
Date: Wed,  2 Oct 2024 13:45:06 +0200
Message-ID: <cover.cb088351ab8df44310eee259bf2dbec858702463.1727869380.git-series.nbd@nbd.name>
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

Felix Fietkau (11):
  wifi: cfg80211: add option for vif allowed radios
  wifi: mac80211: use vif radio mask to limit ibss scan frequencies
  wifi: mac80211: use vif radio mask to limit chanctx and remain-on-channel
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
 include/net/cfg80211.h                             | 18 ++++-
 include/net/mac80211.h                             | 12 +--
 include/uapi/linux/nl80211.h                       | 10 ++-
 net/mac80211/cfg.c                                 | 45 ++++++----
 net/mac80211/chan.c                                | 27 +++++-
 net/mac80211/debugfs.c                             |  1 +-
 net/mac80211/driver-ops.c                          |  1 +-
 net/mac80211/ieee80211_i.h                         |  2 +-
 net/mac80211/iface.c                               | 24 +++--
 net/mac80211/rx.c                                  | 71 ++++++++-------
 net/mac80211/scan.c                                | 10 +-
 net/mac80211/status.c                              |  5 +-
 net/mac80211/tx.c                                  |  6 +-
 net/mac80211/util.c                                | 14 ++-
 net/wireless/chan.c                                |  3 +-
 net/wireless/core.h                                |  1 +-
 net/wireless/nl80211.c                             | 65 +++++++++++---
 net/wireless/rdev-ops.h                            |  5 +-
 net/wireless/scan.c                                | 10 +-
 net/wireless/trace.h                               |  8 +-
 net/wireless/util.c                                | 29 ++++++-
 net/wireless/wext-compat.c                         |  2 +-
 25 files changed, 280 insertions(+), 94 deletions(-)

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
git-series 0.9.1

