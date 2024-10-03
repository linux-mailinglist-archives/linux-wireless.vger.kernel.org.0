Return-Path: <linux-wireless+bounces-13443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6798EAE9
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B3228618F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 07:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C4B13AA2B;
	Thu,  3 Oct 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="hU+SHxr9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91795823DF
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942305; cv=none; b=Fn8TNzpgfk8jOl7ByiPll6CKizpf+15oPkO34AlwRSzazOehmBF2fo6BZjhMcooITOEkMMTMtePvnDt7usIbeNNLPstQccpa6bAiFec6R9X9Wub7vdPtOajDjxCs4Zw6mRaRpKvuej3RYuFjT1HwyWZg064NNrlfzBl2wwljuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942305; c=relaxed/simple;
	bh=iW/f3rtogvvb6/sKGH1H480gQzxZX9XbRUh3VQ8xHVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cArJN6q35mw5tnI3Vm6rl7IhwmZSAAsvRakWaSLBpF1Ieh3e+Wdx34t7m5rEcIgqtQAiNpPbefAh2QxkNaIyH4cpwyBB9hiATXgL0gPK3AzpW7vI6yRfNfDFAyzFRyHqhqVVWdEVVJmeFzOG2bJ2yRYydAGBuLOoZpPpfzAWF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=hU+SHxr9; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hjd5mjbhq3vL9pKsUrN54WJiU4EURjDgeTKWOC01WmM=; b=hU+SHxr9H2QBf1svNWRhp35fKk
	bBeyN3jGfN6aT0FDPCbxstD+cyeN3Kgn6Ep6HxbmNqe6UjHkRVFEgsZ3Vx4Q7iV4Mo4XOXIx404Ux
	YuU8DHPhOda+ov4nYD594KYSGi6XXtbdItUr+wwl2c9xD4Now2+pV84Vkz88gHYe4tNs=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swGj6-004Jgh-1b;
	Thu, 03 Oct 2024 09:58:20 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v2 00/11] wifi: cfg80211/mac80211: improve support for multiple radios
Date: Thu,  3 Oct 2024 09:58:08 +0200
Message-ID: <cover.debd54967c43dd95013c56efa390ea6117062373.1727942154.git-series.nbd@nbd.name>
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
 net/mac80211/scan.c                                | 16 ++-
 net/mac80211/status.c                              |  5 +-
 net/mac80211/tx.c                                  |  6 +-
 net/mac80211/util.c                                | 14 ++-
 net/wireless/chan.c                                |  3 +-
 net/wireless/core.c                                |  2 +-
 net/wireless/core.h                                |  1 +-
 net/wireless/nl80211.c                             | 67 +++++++++++---
 net/wireless/rdev-ops.h                            |  5 +-
 net/wireless/scan.c                                | 10 +-
 net/wireless/trace.h                               |  8 +-
 net/wireless/util.c                                | 29 ++++++-
 net/wireless/wext-compat.c                         |  2 +-
 26 files changed, 288 insertions(+), 96 deletions(-)

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
git-series 0.9.1

