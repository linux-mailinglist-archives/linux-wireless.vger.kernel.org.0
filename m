Return-Path: <linux-wireless+bounces-9776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02191E207
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 16:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3951C22D1B
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A761607B4;
	Mon,  1 Jul 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="eYiNaJN6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7531649A8
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843218; cv=none; b=c4sAbLb4oizdcCEh48XgzPVq4YeVN8iRpd6zYTR0lv6M39CoNfi7ay5eod43mB9S7ndhK6NyAsd3pPtHMCt18IZj3Nx9iddkuMuTbvB9j+RNIj3YGRFnWDTVFk9KX/U8xTZ60/ntctax2VVIUhEIOnUWsfIT3Iv/FiHotKD7fHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843218; c=relaxed/simple;
	bh=lNDDO7zTIq9/qhQVzS/SQhpzTeOr6Cag90F4QEQtgNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGeXp7RBYj/xrO7+sL5HjC6DU25P39p1idxwYGKZlsj+XseLZ8VIJYY0d/BWrDwyN1LSmqJJQ8044so1V0Jom0sQrfVrMhsukZI5KcQg7sM5Tww5CmAgx4NL70N+eapX7WmOayvZUf7Ovelg5EqGtb6LJZKL9MZTpZoSTaWlvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=eYiNaJN6; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kTLqWiGBOMGxfnC4lXtwH503jsRRXNuUunp8txuhrqU=; b=eYiNaJN6yrzqM8c7gTPT78maZ7
	Jpo9qX9MvHs8zcuBX20bquysIKYGfjMN5kp30D9sk4JflPcLSm+7qwTiV2AKTYeFQdFgJlenTXiLd
	PsC/tiYS7ttXAGGskXjyhADU8LV5DwOkreGff6j8CrOCqVNezReCnm/hSPFlpw6o8iEI=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sOHmY-001Qfu-1G;
	Mon, 01 Jul 2024 16:13:26 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH v3 00/10] cfg80211/mac80211: support defining multiple radios per wiphy
Date: Mon,  1 Jul 2024 16:13:15 +0200
Message-ID: <cover.a50ea6fd728e14cfdaafeb9cfac003364713c8e7.1719843147.git-series.nbd@nbd.name>
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

Changes since PATCH v2:
 - fix locking annotation for get_radio_mask
 - fix related rcu access in mac80211
 - fix nl80211 radio data type docs
 - remove __counted_by
 - fix unwinding on netlink attr/nest
 - consmetic fixes
 - remove WARN_ON_ONCE in hwsim

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

 drivers/net/wireless/virtual/mac80211_hwsim.c |  74 +++++--
 drivers/net/wireless/virtual/mac80211_hwsim.h |   4 +-
 include/net/cfg80211.h                        |  52 +++++-
 include/net/mac80211.h                        |   2 +-
 include/uapi/linux/nl80211.h                  |  65 ++++++-
 net/mac80211/cfg.c                            |   7 +-
 net/mac80211/chan.c                           | 210 +++++++++++--------
 net/mac80211/ibss.c                           |   2 +-
 net/mac80211/ieee80211_i.h                    |   5 +-
 net/mac80211/iface.c                          |   2 +-
 net/mac80211/main.c                           |  32 ++-
 net/mac80211/util.c                           | 127 +++++++----
 net/wireless/nl80211.c                        | 202 +++++++++++++-----
 net/wireless/rdev-ops.h                       |  12 +-
 net/wireless/util.c                           |  68 +++++-
 15 files changed, 663 insertions(+), 201 deletions(-)

base-commit: 8c62617295d3c4cd03f1a02c3b9bf9d4e6d6e0c6
-- 
git-series 0.9.1

