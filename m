Return-Path: <linux-wireless+bounces-9711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A891D06B
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 09:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90D33B21168
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 07:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E56B433A2;
	Sun, 30 Jun 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="lmToUtPk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1AF29A5
	for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719733867; cv=none; b=NAI1a1B/J7Zu3OK7g3iGj1ezKsLbKBQ7OnoNFMw7p/THn38VBUthukLL1J5ez3Puh954ROSLad3m6CmB/wpxFeIrYp+FkNrljhXk1fJyN1OvtHrf3op3h7dLxo1VAZyqrEgeBAzVsGQ/KgXtWlvqqW6pO4E0+ivsg0y5jigeOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719733867; c=relaxed/simple;
	bh=7wfj2GaEhURu5rp6LCq28e+cLN3gBN3wKAJMbjU0XcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjrhiOoECfo6k/C63FgcyXI4WeqiJ+g/7g2ASx+ajEpOGZNagzh7lujS1JEMnP6M5cMQVtiyp1AHT9idY98tQuDPbKxMNPOlsMjOgvOhXNIExZUQvnQMP6tOXnpcx223rJzmB/x1QkwyJagVzrGlk/bLK9XulxL52S6y2yHBMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=lmToUtPk; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q4dEUxsvCcaQGKeaYaphzv7+5iYpioCdXyJ3VzfBVsM=; b=lmToUtPk90jw19Rr1lxtG3L/EC
	w+o7+42wk6p7lm257AhnsrJl5DsEPcoOT0cB8dAyez5gIXAES0QUOnwnzim2PZyHk1ijBXN6ERB2X
	bDqXpBL9aQSB8Xk67rjJr9lDsxuXpgTQLoJmsig/9Ju+5R1Bn7M/cqhMgJhtKqG+ZHbc=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sNpKo-000sh7-1B;
	Sun, 30 Jun 2024 09:50:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v2 00/10] cfg80211/mac80211: support defining multiple radios per wiphy
Date: Sun, 30 Jun 2024 09:50:43 +0200
Message-ID: <cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prerequisite for MLO support in cfg80211/mac80211 is that all the links
participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
expectation, some drivers may need to group multiple discrete hardware each
acting as a link in MLO under single wiphy.

With this change, supported frequencies and interface combinations of each
individual radio are reported to user space. This allows user space to figure
out the limitations of what combination of channels can be used concurrently.

Each mac80211 channel context is assigned to a radio based on radio specific
frequency ranges and interface combinations.

Even for non-MLO devices, this improves support for devices capable of
running on multiple channels at the same time.

This is loosely based on Karthikeyan Periyasamy's series
"[PATCH 00/13] wifi: Add multi physical hardware iface combination support"
with some differences:

 - a struct wiphy_radio is defined, which holds the frequency ranges and
   a full struct ieee80211_iface_combination array
 - a channel context is explicitly assigned to a radio when created
 - both global and per-radio interface combination limits are checked
   and enforced on channel context assignment
 - improve comments/docs and attributes
 - add cfg80211 helper for checking radio freq range

Changes since PATCH v1:
 - add nested flag to newly added nested attributes
 - make per-radio attributes multi-attr
 - add __counted_by annotation
 - remove unnecessary tracing
 - fix hwsim attribute docs
 - add hwsim attribute policy
 - add radio index

Changes since RFC v4:
 - report the first radio's ifcomb as main ifcomb for legacy compatibility
 - report the global wiphy ifcomb separately
 - add mac80211_hwsim support

Changes since RFC v3:
 - fix __ieee80211_get_radio_mask to return per-vif radio mask
 - fix params->radio in ieee80211_check_combinations()
 - fix indentation
 - pass radio_idx in struct iface_combination_params
 - improve get_radio_mask callback

Changes since RFC v2:
 - fix uninitialized variables
 - fix multiple radios with DFS
 - add support for per-radio beacon interval checking

Changes since RFC:
 - replace static per-radio number of channels limit with full ifcomb
   checks
 - remove band bitmask in favor of only using freq ranges

Felix Fietkau (10):
  wifi: nl80211: split helper function from nl80211_put_iface_combinations
  wifi: cfg80211: add support for advertising multiple radios belonging to a wiphy
  wifi: cfg80211: extend interface combination check for multi-radio
  wifi: cfg80211: add helper for checking if a chandef is valid on a radio
  wifi: mac80211: add support for DFS with multiple radios
  wifi: mac80211: add radio index to ieee80211_chanctx_conf
  wifi: mac80211: extend ifcomb check functions for multi-radio
  wifi: mac80211: move code in ieee80211_link_reserve_chanctx to a helper
  wifi: mac80211: add wiphy radio assignment and validation
  wifi: mac80211_hwsim: add support for multi-radio wiphy

 drivers/net/wireless/virtual/mac80211_hwsim.c |  78 ++++++-
 drivers/net/wireless/virtual/mac80211_hwsim.h |   4 +-
 include/net/cfg80211.h                        |  51 +++++-
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  63 ++++++-
 net/mac80211/cfg.c                            |   7 +-
 net/mac80211/chan.c                           | 210 +++++++++++--------
 net/mac80211/ibss.c                           |   2 +-
 net/mac80211/ieee80211_i.h                    |   5 +-
 net/mac80211/iface.c                          |   2 +-
 net/mac80211/main.c                           |  32 ++-
 net/mac80211/util.c                           | 127 +++++++----
 net/wireless/nl80211.c                        | 201 +++++++++++++-----
 net/wireless/rdev-ops.h                       |  12 +-
 net/wireless/util.c                           |  68 +++++-
 15 files changed, 663 insertions(+), 201 deletions(-)

base-commit: 8c62617295d3c4cd03f1a02c3b9bf9d4e6d6e0c6
-- 
git-series 0.9.1

