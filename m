Return-Path: <linux-wireless+bounces-13718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B820B9941FE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 10:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C73C1F269FB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83531E5733;
	Tue,  8 Oct 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="C4loo5g8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7981E32BB
	for <linux-wireless@vger.kernel.org>; Tue,  8 Oct 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374259; cv=none; b=D7NdLguigRi89jZYgHKO1BabL6Gy3Smz/fw0ncRdAp2/EmkjnSCd4whIJpQz56LzDDKjPdLoYwr9ncvHRj1IYwr+v9UeVLAoxp/UblL/Uk53geqU8gmNFFku/Ds9dpTnAoOT0qPPHNp5TWIGH7bSIQXgxM83+eC4w35ZF9IcdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374259; c=relaxed/simple;
	bh=fopNFE7NuhHMHpnzHuKTmDO/ZQRsyCWbQabMrLz2hGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e64AJsZuSG6aZ5DmO42mk4ORTbh3y4dV+FppUj+XARMUZLVgW0uFvFQ/0xGGjReF0RlozpGKEWzNpO+AF9XuGwKCAMaEw37Ocj0t6VfmJ+TgN2/m4k6v3Xu8lYn2bfXnjUbSGsI/sI32L1s8DbySdgwbPe7fXIDQR42mcR2FWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=C4loo5g8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vC4tB9wjEBfLq1aagX37WEC/zEjzqPNvnEf8WCHKNTs=; b=C4loo5g8xMJVbcYV4MGbRIwLEs
	u2B8ilRZyKIdQqJJ3AQVLdn4+Bkw4260GFi6XSKInwvlCdRs1/2xa3tFoqfnxrrbbBEYwm2EkBN8N
	EE2M6zznqDAVk+hvKVYJhuA1u7i5MxWPGEjZ4qI9aWJPRfEnNYYkYgtZUJnSsVlXu2E0=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sy4ZN-006H62-1Z;
	Tue, 08 Oct 2024 09:23:45 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v4 00/11] wifi: cfg80211/mac80211: improve support for multiple radios
Date: Tue,  8 Oct 2024 09:23:33 +0200
Message-ID: <cover.bd168805c299851d01269473eb64e7b05edc41d6.1728372192.git-series.nbd@nbd.name>
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
 net/wireless/trace.h                               | 10 +-
 net/wireless/util.c                                | 29 ++++++-
 net/wireless/wext-compat.c                         |  2 +-
 26 files changed, 289 insertions(+), 97 deletions(-)

base-commit: 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
-- 
git-series 0.9.1

